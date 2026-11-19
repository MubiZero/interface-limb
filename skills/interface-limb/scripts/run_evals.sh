#!/usr/bin/env bash
# Run the prompts in evals/evals.json through Claude Code twice, without and with this skill, and save both answers
# side by side for a human (or a judge) to compare against each eval's expected_output.
#
#   bash scripts/run_evals.sh --list                    list the evals
#   bash scripts/run_evals.sh --only 3 [--out DIR]      run one eval, both modes
#   bash scripts/run_evals.sh --all [--out DIR]         run every eval (costs tokens: 2 runs each)
#   add --dry-run to print the commands without running them; --model NAME to pick a model
#
# "with": the working copy of this repo is loaded as a plugin (--plugin-dir).
# "without": all skills and slash commands disabled (--disable-slash-commands).
set -eu
here="$(cd "$(dirname "$0")" && pwd)"
skill="$(cd "$here/.." && pwd)"
root="$(cd "$skill/../.." && pwd)"
evals="$skill/evals/evals.json"
mode=""; only=""; dry=0; model=""; out=""
while [ $# -gt 0 ]; do
  case "$1" in
    --list) mode=list ;;
    --all) mode=all ;;
    --only) mode=one; only="$2"; shift ;;
    --dry-run) dry=1 ;;
    --model) model="$2"; shift ;;
    --out) out="$2"; shift ;;
    *) echo "unknown option: $1" >&2; exit 2 ;;
  esac
  shift
done
[ -n "$mode" ] || { sed -n '2,12p' "$0" | sed 's/^# \{0,1\}//'; exit 2; }

if [ "$mode" = list ]; then
  node -e 'for (const t of require(process.argv[1]).evals) console.log(t.id + "\t" + t.name)' "$evals"
  exit 0
fi

out="${out:-$(mktemp -d "${TMPDIR:-/tmp}/limb-evals.XXXXXX")}"
mkdir -p "$out"
ids=$(node -e '
  const e = require(process.argv[1]).evals, only = process.argv[2];
  for (const t of e) if (only === "" || String(t.id) === only) console.log(t.id)' "$evals" "$only")
[ -n "$ids" ] || { echo "no such eval: $only" >&2; exit 2; }

for id in $ids; do
  prompt_file="$out/eval-$id.prompt.txt"
  node -e '
    const fs = require("fs"), p = require("path");
    const evals = process.argv[1], id = process.argv[2];
    const t = require(evals).evals.find((x) => String(x.id) === id);
    let s = t.prompt;
    for (const f of t.files || []) s += "\n\n--- " + f + " ---\n" + fs.readFileSync(p.join(p.dirname(evals), f), "utf8");
    fs.writeFileSync(process.argv[3], s);
    fs.writeFileSync(process.argv[3].replace(".prompt.txt", ".expected.txt"), t.expected_output + "\n");
  ' "$evals" "$id" "$prompt_file"
  for variant in without with; do
    res="$out/eval-$id.$variant.md"
    flags=(-p --no-session-persistence --permission-mode plan)
    [ -n "$model" ] && flags+=(--model "$model")
    if [ "$variant" = with ]; then flags+=(--plugin-dir "$root"); else flags+=(--disable-slash-commands); fi
    echo "eval $id ($variant) -> $res"
    if [ "$dry" = 1 ]; then echo "  claude ${flags[*]} < $prompt_file"; continue; fi
    claude "${flags[@]}" < "$prompt_file" > "$res" 2> "$res.err" || echo "  failed, see $res.err"
  done
done
echo "outputs in $out (compare each *.with.md and *.without.md with *.expected.txt)"
