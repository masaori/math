#!/usr/bin/env bash
# cycle 41 step 4: 「mathlib に無い」と書いてある記録を、定理の名前ではなく
# **機構（engine）の名前**で引き直す走査。
#
# なぜこれをやるか:
#   cycle 40 step 4 で、Monsky の定理の「素材も無い」という判定が誤りだと分かった。
#   原因は探した語が**定理の名前**（`Monsky`）だったことである。
#   定理の名前で引くと、その定理を証明する道具が在っても 0 件になる。
#   本走査は、いま立っている「無い」の記録すべてについて、engine の名前で引き直す。
#
# 使い方:
#   cd integrable-lattice/lean && bash scripts/mathlib-gap-survey-cycle41-engines.sh
#
# 出力は logs/mathlib-gap-survey-cycle41-engines.log へ手で写す（走査そのものはここが正本）。
set -euo pipefail

cd "$(dirname "$0")/.."
M=.lake/packages/mathlib/Mathlib

if [ ! -d "$M" ]; then
  echo "NG: mathlib がこの作業ツリーに無い（lake exe cache get を先に実行すること）" >&2
  exit 1
fi

echo "走査したファイル数: $(find "$M" -name '*.lean' | wc -l | tr -d ' ')"
echo

# 記録ごとに「これまで引いた語（定理の名前）」と「engine の名前」を並べて引く。
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

survey "冪和と係数の関係（Newton の関係）— cycle 41 step 1 が「その形は無い」と書いた記録" \
  "NewtonIdentities" "MvPolynomial.psum" "esymm" "Matrix.trace.*charpoly"

survey "Skolem–Mahler–Lech（零点集合）" \
  "SkolemMahlerLech" "Strassmann" "LinearRecurrence" "mahlerSeries" "MahlerBasis"

survey "Cuoco–Monsky（\$\\mathbb{Z}_p^d\$ の岩澤型漸近）" \
  "CuocoMonsky" "MvPowerSeries.isAdicComplete" "MvPowerSeries" "AdicCompletion"

survey "多変数の Mahler 測度" \
  "MahlerMeasure" "logMahler" "torusIntegral" "JensenFormula"

survey "整数行列の単因子の整除の鎖" \
  "Matrix.smithNormalForm" "smithCoeffs" "smithNormalForm" "invariantFactor"

echo "## 判定は log 側に書く（この script は数を出すだけである）"
