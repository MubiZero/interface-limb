#!/usr/bin/env bash
# Repo self-check for interface-limb: versions, frontmatter, links, reference map, evals, script syntax.
# Usage: bash skills/interface-limb/scripts/check.sh   (run from anywhere; exits 1 on any failure)
set -u
here="$(cd "$(dirname "$0")" && pwd)"
skill="$(cd "$here/.." && pwd)"
root="$(cd "$skill/../.." && pwd)"
fail=0
bad() { echo "FAIL  $*"; fail=1; }
ok()  { echo "ok    $*"; }

# 1. manifests: valid JSON, versions agree
pv=$(node -e 'console.log(require(process.argv[1]).version)' "$root/.claude-plugin/plugin.json" 2>/dev/null)
mv=$(node -e 'console.log(require(process.argv[1]).plugins[0].version)' "$root/.claude-plugin/marketplace.json" 2>/dev/null)
if [ -n "$pv" ] && [ "$pv" = "$mv" ]; then ok "manifest versions agree ($pv)"; else bad "manifest versions differ: plugin.json=$pv marketplace.json=$mv"; fi

# 2. SKILL.md frontmatter and size
head -1 "$skill/SKILL.md" | grep -q '^---$' || bad "SKILL.md has no frontmatter"
grep -q '^name: interface-limb$' "$skill/SKILL.md" && ok "frontmatter name" || bad "frontmatter name is not interface-limb"
grep -q '^description:' "$skill/SKILL.md" || bad "frontmatter has no description"
n=$(wc -l < "$skill/SKILL.md" | tr -d ' ')
[ "$n" -le 500 ] && ok "SKILL.md is $n lines (limit 500)" || bad "SKILL.md is $n lines (limit 500)"

# 3. every relative .md link resolves; every reference is reachable from SKILL.md
broken=0
while IFS= read -r f; do
  d=$(dirname "$f")
  while IFS= read -r l; do
    l=${l%%#*}
    [ -z "$l" ] && continue
    [ -e "$d/$l" ] || { bad "broken link in ${f#$root/}: $l"; broken=1; }
  done < <(grep -oE '\]\(([^)#: ]+\.(md|png|html|sh|js))(#[^)]*)?\)' "$f" | sed -E 's/^\]\(//; s/\)$//')
done < <(find "$skill" "$root/README.md" -name '*.md' -not -path '*/node_modules/*')
[ "$broken" = 0 ] && ok "all relative links resolve"
for r in "$skill"/references/*.md; do
  b=$(basename "$r")
  grep -q "references/$b" "$skill/SKILL.md" || bad "references/$b is not linked from SKILL.md"
done
ok "reference map covers references/"

# 4. evals: valid JSON, fixtures exist
if node -e '
  const e=require(process.argv[1]); const fs=require("fs"),p=require("path");
  const dir=p.dirname(process.argv[1]); let bad=0;
  for(const t of e.evals){ if(!t.prompt||!t.expected_output){console.log("eval "+t.id+" lacks prompt/expected_output");bad=1}
    for(const f of t.files||[]) if(!fs.existsSync(p.join(dir,f))){console.log("eval "+t.id+" missing file "+f);bad=1} }
  const ids=e.evals.map(t=>t.id); if(new Set(ids).size!==ids.length){console.log("duplicate eval ids");bad=1}
  process.exit(bad)' "$skill/evals/evals.json"; then ok "evals.json valid"; else bad "evals.json problems (above)"; fi

# 5. scripts parse
for s in "$skill"/scripts/*.sh; do bash -n "$s" && ok "bash -n $(basename "$s")" || bad "syntax error in $s"; done
node --check "$skill/scripts/dead_buttons.js" 2>/dev/null && ok "node --check dead_buttons.js" || bad "syntax error in dead_buttons.js"
node --check "$root/demos/build_compare.mjs" 2>/dev/null && ok "node --check build_compare.mjs" || bad "syntax error in build_compare.mjs"

# 6. ds_audit.sh runs on the eval fixtures
bash "$skill/scripts/ds_audit.sh" "$skill/evals/files" >/dev/null 2>&1 && ok "ds_audit.sh runs on evals/files" || bad "ds_audit.sh failed on evals/files"

# 7. README badge matches the manifest version
grep -q "badge/version-$pv-" "$root/README.md" && ok "README badge shows $pv" || bad "README version badge is not $pv"

[ "$fail" = 0 ] && echo "ALL OK" || echo "FAILED"
exit $fail
