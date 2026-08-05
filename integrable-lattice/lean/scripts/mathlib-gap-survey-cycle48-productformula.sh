#!/usr/bin/env bash
# cycle 48 step 4（命題 W の積公式の段）で使った mathlib と自プロジェクトの実在確認。
#
# 使い方:
#   cd integrable-lattice/lean && bash scripts/mathlib-gap-survey-cycle48-productformula.sh \
#     > logs/mathlib-gap-survey-cycle48-productformula.log
#
# 方式は scripts/mathlib-gap-survey.sh と同じ 3 段。(2)(3) がともに 0 のときにだけ「無い」と書く。
#
# 見たいのは 1 つである。積公式
#   N N' κ(X_{N,N'}) = κ(X) ∏_{(ζ,ξ)≠(1,1)} det L(ζ,ξ)
# を、本プロジェクトが持っている 2 つの道具（2 変数の指標分解・Kirchhoff の matrix-tree）から
# 組み立てるとき、その 2 つ以外に何が要るか。
set -uo pipefail

cd "$(dirname "$0")/.."
ML=.lake/packages/mathlib

echo "=== 日付 ==="
date -u +%Y-%m-%dT%H:%M:%SZ
echo "=== mathlib commit ==="
git -C "$ML" rev-parse HEAD
echo "=== toolchain ==="
cat lean-toolchain

LIST=$(mktemp)
find "$ML/Mathlib" -name '*.lean' > "$LIST"
echo "=== 走査対象 Mathlib/*.lean ファイル数 ==="
wc -l < "$LIST" | tr -d ' '

concepts=(
  "ラプラシアンの全余因子が等しいこと|adjugate.*lapMatrix|cofactor.*laplacian"
  "Kirchhoff の固有値形（非零固有値の積を頂点数で割る）|charpoly.*spanningTree|spanning tree.*eigenvalue"
  "被覆グラフ（voltage グラフ）の全域木数の積公式|voltage.*spanning|derived graph.*spanning"
  "行和が 0 の行列の余因子|det_updateRow_sum|row sum.*adjugate"
)

for entry in "${concepts[@]}"; do
  label="${entry%%|*}"
  rest="${entry#*|}"
  joined="${rest%%|*}"
  stem="${rest#*|}"
  echo
  echo "=== $label ==="
  echo "--- (1) 連結語の内容 grep: '$joined'"
  n1=$(xargs grep -lE -- "$joined" < "$LIST" 2>/dev/null | wc -l | tr -d ' ')
  echo "files=$n1"
  xargs grep -lE -- "$joined" < "$LIST" 2>/dev/null | head -6
  echo "--- (2) 語幹の case-insensitive 内容 grep: '$stem'"
  n2=$(xargs grep -ilE -- "$stem" < "$LIST" 2>/dev/null | wc -l | tr -d ' ')
  echo "files=$n2"
  xargs grep -ilE -- "$stem" < "$LIST" 2>/dev/null | head -6
  echo "--- (3) 語幹の case-insensitive ファイル名検索: '$stem'"
  fnstem=$(echo "$stem" | sed 's/\.\*//g' | tr -d ' ')
  n3=$(find "$ML/Mathlib" -iname "*$fnstem*" -name '*.lean' | wc -l | tr -d ' ')
  echo "files=$n3"
  find "$ML/Mathlib" -iname "*$fnstem*" -name '*.lean' | head -6
done

echo
echo "=== 自プロジェクトの側（積公式の 2 つの道具は在るか） ==="
echo "--- 2 変数の指標分解（宣言行）"
grep -nE "^(theorem|noncomputable def|def) " IntegrableLattice/CharacterDecompositionTwoVariable.lean | head -12
echo "--- Kirchhoff の matrix-tree（宣言行）"
grep -nE "^(theorem|noncomputable def|def) " IntegrableLattice/KirchhoffCounting.lean | head -8
echo "--- 全余因子が等しいことを述べた宣言が自プロジェクトに在るか"
grep -rnE "^(theorem|lemma) .*(adjugate|cofactor)" IntegrableLattice/*.lean | head -6
echo "（上が空なら、自プロジェクトにも無い）"
echo "--- ただしその土台（行和が 0）は在る"
grep -nE "^theorem lapMatrix_row_sum" IntegrableLattice/MultigraphLaplacian.lean
