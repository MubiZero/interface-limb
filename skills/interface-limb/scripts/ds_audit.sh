#!/usr/bin/env bash
# ds_audit.sh — how well a codebase keeps to its design system.
#
# Usage: bash ds_audit.sh <src-dir> [<src-dir>…]
#   e.g. bash ds_audit.sh apps/staff/lib apps/guest/lib packages/core/lib
#        bash ds_audit.sh src
#
# For each directory it counts literal values (colors, font sizes, weights, paddings, gaps, radii,
# durations) against uses of tokens, and how many dialogs / sheets / pushed pages the code opens.
# It detects Flutter (.dart) and web (.ts/.tsx/.js/.jsx/.vue/.svelte/.css/.scss/.html) by the files
# it finds. Generated localization files are skipped. Plain grep, works with the bash and grep that
# ship with macOS and Linux. The numbers are a symptom map, not a grade: confirm by looking at screens.
#
# Token names it recognizes (Flutter class names are detected per directory; see TOKEN_* below):
#   Flutter: Space.*, Radii.*, Motion.*, Theme/text roles (text.titleLarge…), scheme./colors. lookups
#   Web:     var(--…), theme() / tailwind scale classes (p-4, gap-2, rounded-lg, text-sm, duration-200)

set -u
[ $# -ge 1 ] || { echo "usage: bash ds_audit.sh <src-dir> [<src-dir>…]" >&2; exit 2; }

# Token class names for Flutter: TOKEN_SPACE=Gaps TOKEN_RADII=Corners TOKEN_MOTION=Durations bash ds_audit.sh lib
# overrides them; otherwise each directory is searched for the class its code actually uses (the most common
# `X.` inside EdgeInsets / BorderRadius.circular / duration:), so another project's names are found too.
detect() { # detect <dir> <regex for the call that holds the token>: the most common Class. inside those calls
  grep -rEho --include='*.dart' "$2" "$1" 2>/dev/null \
    | grep -Eo '\b[A-Z][A-Za-z]+\.[a-z][A-Za-z0-9]*' | cut -d. -f1 \
    | grep -vE '^(EdgeInsets|EdgeInsetsDirectional|BorderRadius|Radius|Duration|Colors|Icons|Theme|MediaQuery)$' \
    | sort | uniq -c | sort -rn | awk 'NR==1{print $2}'
}

count() { # count <regex> <dir> <include-globs…>
  local re=$1 dir=$2; shift 2
  local inc=()
  for g in "$@"; do inc+=(--include="$g"); done
  grep -rEho "${inc[@]}" "$re" "$dir" 2>/dev/null \
    | wc -l | tr -d ' '
}
count_files() { # number of matching lines, skipping l10n/generated dirs
  local re=$1 dir=$2; shift 2
  local inc=()
  for g in "$@"; do inc+=(--include="$g"); done
  grep -rE "${inc[@]}" "$re" "$dir" 2>/dev/null \
    | grep -vE '/(l10n|generated|gen|build|node_modules|\.dart_tool)/|\.g\.dart:|\.freezed\.dart:' \
    | wc -l | tr -d ' '
}
pct() { # pct <literal> <token>
  local l=$1 t=$2 s=$(( $1 + $2 ))
  if [ "$s" -eq 0 ]; then echo "  -"; else echo "$(( l * 100 / s ))%"; fi
}
row() { printf '  %-34s %7s %7s %6s\n' "$1" "$2" "$3" "$4"; }

for dir in "$@"; do
  [ -d "$dir" ] || { echo "skip $dir (not a directory)"; continue; }
  ndart=$(find "$dir" -name '*.dart' ! -path '*/l10n/*' ! -name '*.g.dart' 2>/dev/null | wc -l | tr -d ' ')
  nweb=$(find "$dir" \( -name '*.tsx' -o -name '*.ts' -o -name '*.jsx' -o -name '*.js' -o -name '*.vue' -o -name '*.svelte' -o -name '*.css' -o -name '*.scss' -o -name '*.html' -o -name '*.tmpl' -o -name '*.gohtml' \) ! -path '*/node_modules/*' ! -path '*/build/*' ! -path '*/dist/*' 2>/dev/null | wc -l | tr -d ' ')
  echo
  echo "== $dir  (dart files: $ndart, web files: $nweb)"
  row "" "literal" "token" "lit%"

  if [ "$ndart" -gt 0 ]; then
    D='*.dart'
    sp=${TOKEN_SPACE:-$(detect "$dir" 'EdgeInsets(Directional)?\.[a-zA-Z]+\([^)]*')}
    ra=${TOKEN_RADII:-$(detect "$dir" '([Rr]adius: *|Radius\.circular\( *)[A-Z][A-Za-z]+\.[a-z][A-Za-z0-9]*')}
    mo=${TOKEN_MOTION:-$(detect "$dir" '(duration|reverseDuration): *[A-Z][A-Za-z]+\.[a-z][A-Za-z0-9]*')}
    TOKEN_SPACE_RE="${sp:-__none__}\."; TOKEN_RADII_RE="${ra:-__none__}\."; TOKEN_MOTION_RE="${mo:-__none__}\."
    echo "  token classes: spacing=${sp:-none found} radius=${ra:-none found} motion=${mo:-none found}  (override: TOKEN_SPACE=… TOKEN_RADII=… TOKEN_MOTION=…)"
    l=$(count_files 'EdgeInsets\.[a-zA-Z]*\([^)]*[(:, ][0-9]+(\.[0-9]+)?[,)]' "$dir" "$D"); t=$(count_files "EdgeInsets\.[a-zA-Z]*\([^)]*$TOKEN_SPACE_RE" "$dir" "$D"); row "padding (EdgeInsets)" "$l" "$t" "$(pct "$l" "$t")"
    l=$(count_files 'SizedBox\((height|width): *[0-9]' "$dir" "$D");  t=$(count_files "SizedBox\((height|width): *$TOKEN_SPACE_RE" "$dir" "$D"); row "gaps (SizedBox)" "$l" "$t" "$(pct "$l" "$t")"
    l=$(count_files 'BorderRadius\.circular\( *[0-9]' "$dir" "$D");    t=$(count_files "(Radius\\.circular\\( *|[Rr]adius: *|BorderRadius\\.all\\( *)$TOKEN_RADII_RE" "$dir" "$D"); row "radius" "$l" "$t" "$(pct "$l" "$t")"
    l=$(count_files 'Duration\(milliseconds: *[0-9]' "$dir" "$D");     t=$(count_files "(duration|reverseDuration|Duration): *$TOKEN_MOTION_RE|context\\.motion\\(" "$dir" "$D"); row "durations" "$l" "$t" "$(pct "$l" "$t")"
    l=$(count_files 'Color\(0x' "$dir" "$D"); l2=$(count_files 'Colors\.(red|green|blue|orange|amber|grey|black|white|yellow|purple|teal|pink|indigo|brown|cyan|lime)' "$dir" "$D")
    t=$(count_files '(scheme|colorScheme|colors)\.[a-z]' "$dir" "$D"); row "colors (literal / theme lookups)" "$(( l + l2 ))" "$t" "$(pct $(( l + l2 )) "$t")"
    l=$(count_files 'fontSize: *[0-9]' "$dir" "$D"); t=$(count_files 'text(Theme)?\.(display|headline|title|body|label)(Large|Medium|Small)' "$dir" "$D"); row "font size (literal / text roles)" "$l" "$t" "$(pct "$l" "$t")"
    echo "  type-role overrides (copyWith on a role): $(count_files 'text(Theme)?\.[a-zA-Z]+\??\.copyWith' "$dir" "$D")"
    printf '  weights in use:'; grep -rEho --include='*.dart' 'FontWeight\.w[0-9]+' "$dir" 2>/dev/null | sort | uniq -c | sort -rn | awk '{printf " %s×%s", $2, $1}'; echo
    echo "  button style overrides (styleFrom): $(count_files '(Filled|Outlined|Text|Elevated|Icon)Button\.styleFrom' "$dir" "$D")"
    echo "  surfaces opened: dialogs $(count_files 'showDialog[<(]' "$dir" "$D"), sheets $(count_files 'show(App|ModalBottom)Sheet[<(]' "$dir" "$D"), pushed pages $(count_files 'Navigator\.(of\([a-z]+\)\.)?push' "$dir" "$D"), confirms $(count_files 'confirm[A-Z]\w*\(' "$dir" "$D")"
  fi

  if [ "$nweb" -gt 0 ]; then
    W1='*.tsx'; W2='*.ts'; W3='*.jsx'; W4='*.js'; W5='*.vue'; W6='*.svelte'; W7='*.css'; W8='*.scss'; W9='*.html'; W10='*.tmpl'; W11='*.gohtml'
    all=("$W1" "$W2" "$W3" "$W4" "$W5" "$W6" "$W7" "$W8" "$W9" "$W10" "$W11")
    l=$(count_files '#[0-9a-fA-F]{6}\b|#[0-9a-fA-F]{3}\b|rgba?\(' "$dir" "${all[@]}"); t=$(count_files 'var\(--' "$dir" "${all[@]}"); row "colors (hex/rgb vs var(--))" "$l" "$t" "$(pct "$l" "$t")"
    l=$(count_files '\[[0-9.]+(px|rem)\]' "$dir" "${all[@]}"); t=$(count_files '\b(p|px|py|pt|pb|pl|pr|m|mx|my|mt|mb|gap|space-[xy])-[0-9]+\b' "$dir" "${all[@]}"); row "tailwind arbitrary vs scale (space)" "$l" "$t" "$(pct "$l" "$t")"
    l=$(count_files '(padding|margin|gap)(-[a-z]+)?: *[0-9.]+px' "$dir" "${all[@]}"); row "css px spacing (padding/margin/gap)" "$l" "" ""
    l=$(count_files 'font-size: *[0-9.]+(px|rem)|text-\[[0-9]' "$dir" "${all[@]}"); t=$(count_files '\btext-(xs|sm|base|lg|xl|[2-9]xl)\b' "$dir" "${all[@]}"); row "font size (literal vs scale)" "$l" "$t" "$(pct "$l" "$t")"
    l=$(count_files 'border-radius: *[0-9.]+px|rounded-\[' "$dir" "${all[@]}"); t=$(count_files '\brounded(-(sm|md|lg|xl|2xl|3xl|full))?\b' "$dir" "${all[@]}"); row "radius (literal vs scale)" "$l" "$t" "$(pct "$l" "$t")"
    l=$(count_files '(transition|animation)[^;]*[0-9]+m?s|duration-\[' "$dir" "${all[@]}"); row "literal durations" "$l" "" ""
    printf '  weights in use:'; grep -rEho --include='*.css' --include='*.scss' --include='*.tsx' --include='*.jsx' --include='*.vue' 'font-weight: *[0-9]+|font-(thin|light|normal|medium|semibold|bold|extrabold|black)\b|font-\[[0-9]+\]' "$dir" 2>/dev/null | sed 's/font-weight: *//' | sort | uniq -c | sort -rn | awk '{printf " %s×%s", $2, $1}'; echo
    echo "  inline style objects: $(count_files 'style=\{\{' "$dir" "${all[@]}")"
    echo "  surfaces: <Dialog/Modal/Sheet/Drawer> $(count_files '<(Dialog|Modal|Sheet|Drawer|AlertDialog)\b' "$dir" "${all[@]}"), confirm( $(count_files '\bconfirm\(' "$dir" "${all[@]}")"
  fi
done
echo
echo "Read: lit% under ~10 is healthy; 20+ means the scale lacks values or the tokens are not found."
echo "Many role overrides or >3 weights: fix the type scale, then remove the patches."
echo "The file that defines the tokens (theme.dart, tokens.css) shows literals by design: read it apart."
echo "Surfaces far above the number of distinct jobs: duplicate dialogs; see references/design-system.md §4."
