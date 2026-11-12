#!/usr/bin/env bash
# interface-limb · shoot_widths.sh — render a page at the widths people use, so you can open the PNGs and look.
#
#   bash shoot_widths.sh http://localhost:5173/screen [out-dir]
#
# Desktop and tablet sizes are shot directly. Phone sizes are shot through iframes of the exact width on a wider page:
# headless Chrome does not shrink its window below ~500 px, so --window-size=360,640 silently lays the page out at ~500
# and hides every phone bug. The page runs visible (transitions and timers run), unlike a hidden browser tab.
# Needs Google Chrome (or Chromium: set CHROME=/path/to/chrome).
set -euo pipefail
url=${1:?usage: shoot_widths.sh <url> [out-dir]}
out=${2:-./shots}
mkdir -p "$out"
chrome=${CHROME:-}
if [[ -z $chrome ]]; then
  for c in "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" "$(command -v google-chrome || true)" "$(command -v chromium || true)"; do
    [[ -n $c && -x $c ]] && chrome=$c && break
  done
fi
[[ -n $chrome ]] || { echo "Chrome not found: set CHROME=/path/to/chrome" >&2; exit 1; }
shoot() { "$chrome" --headless=new --disable-gpu --hide-scrollbars --virtual-time-budget=4000 \
  --window-size="$1" --screenshot="$2" "$3" >/dev/null 2>&1; }

for size in 1366,768 1440,900 1024,768 768,1024; do
  shoot "$size" "$out/${size/,/x}.png" "$url"
done

frames="$out/_phones.html"
cat > "$frames" <<HTML
<!doctype html><meta charset="utf-8">
<style>body{margin:0;background:#777;display:flex;gap:16px;padding:16px;align-items:flex-start}iframe{border:0;background:#fff}</style>
<iframe src="$url" width="360" height="640"></iframe>
<iframe src="$url" width="390" height="844"></iframe>
<iframe src="$url" width="412" height="900"></iframe>
HTML
shoot 1260,940 "$out/phones-360-390-412.png" "file://$(cd "$out" && pwd)/_phones.html"
ls -1 "$out"/*.png
