#!/usr/bin/env bash
# cycle 42 step 2: 命題 T の段 3（2 の不分岐性と Hensel 持ち上げ）について、
# 「円分体の完備化への配線が無い」と書いてある記録を **機構（engine）の名前**で引き直す走査。
#
# なぜこれをやるか:
#   これまでの根拠は「`Henselian` と `cyclotomic` が同じ行に現れる箇所が 0 件」だった。
#   同じ行に現れるかどうかは配線の有無しか見ておらず、
#   **その段を動かしている機構が在るかどうかを見ていない。**
#
# 使い方:
#   cd integrable-lattice/lean && bash scripts/mathlib-gap-survey-cycle42-hensel.sh
#
# 出力は logs/mathlib-gap-survey-cycle42-hensel.log へ手で写す（走査そのものはここが正本）。
set -euo pipefail

cd "$(dirname "$0")/.."
M=.lake/packages/mathlib/Mathlib

if [ ! -d "$M" ]; then
  echo "NG: mathlib がこの作業ツリーに無い（lake exe cache get を先に実行すること）" >&2
  exit 1
fi

echo "走査したファイル数: $(find "$M" -name '*.lean' | wc -l | tr -d ' ')"
echo

survey() {
  local title="$1"; shift
  echo "## $title"
  for term in "$@"; do
    local n
    n=$( { grep -rl -- "$term" --include='*.lean' "$M" 2>/dev/null || true; } | wc -l | tr -d ' ')
    echo "- \`$term\`: ${n} ファイル"
    if [ "$n" != "0" ]; then
      { grep -rl -- "$term" --include='*.lean' "$M" 2>/dev/null || true; } | head -3 | sed 's/^/    /'
    fi
  done
  echo
}

survey "Hensel の持ち上げそのもの（機構）" \
  "HenselianLocalRing" "HenselianRing" "IsAdicComplete.henselianRing" "hensels_lemma"

survey "2 の不分岐性（機構は X^L-1 の分離性）" \
  "X_pow_sub_one_separable_iff" "IsCyclotomicExtension" "Algebra.IsUnramified" "Ideal.ramificationIdx"

survey "舞台の構成（完備化）" \
  "adicCompletionIntegers" "IsDiscreteValuationRing" "IsAdicComplete"

survey "原始根の冪の判定" \
  "IsPrimitiveRoot.pow_eq_one_iff_dvd" "IsPrimitiveRoot.pow_inj"

echo "## 判定は log 側に書く（この script は数を出すだけである）"
