#!/usr/bin/env bash
# cycle 37 step 1（命題 W* の最後の残り）で使った mathlib の実在確認。
#
# 使い方:
#   cd integrable-lattice/lean && bash scripts/mathlib-gap-survey-cycle37-squarefree.sh \
#     > logs/mathlib-gap-survey-cycle37-squarefree.log
#
# 方式は scripts/mathlib-gap-survey.sh と同じ 3 段（連結語の内容 grep / 語幹の内容 grep /
# 語幹のファイル名検索）。(2)(3) がともに 0 のときにだけ「無い」と書く。
#
# 見たいのは 2 つ。
#   (a) 無平方性を $\mathbb{Z}[x]$ から $\mathbb{Q}[x]$ へ移す Gauss 型の補題が在るか（無いはず）。
#       これが 命題 W* に残る最後の段の素材である。「無い」と書くならその場でログを残す。
#   (b) その段を自前で書くときに使える素材が在るか（在るはず。名指しで確かめる）。
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
  "移送(無いはず) 無平方性を map で移す補題|squarefree_map|squarefree_map"
  "移送(無いはず) 無平方性と分数体|Squarefree.isFractionRing|squarefree_iff_squarefree"
  "移送(無いはず) 無平方性とモニック除法|Monic.squarefree_map_iff|monic.squarefree"
  "自前で書く素材(在るはず) モニックな除数の移送|Monic.dvd_iff_fraction_map_dvd_fraction_map|dvd_iff_fraction_map"
  "自前で書く素材(在るはず) 整閉性による係数の引き戻し|IsIntegrallyClosed.eq_map_mul_C_of_dvd|eq_map_mul_C_of_dvd"
  "自前で書く素材(在るはず) 分離性と無平方性の同値|separable_iff_squarefree|separable_iff_squarefree"
  "自前で書く素材(在るはず) 分離性の map による保存|Separable.map|separable.map"
)

for entry in "${concepts[@]}"; do
  label="${entry%%|*}"
  rest="${entry#*|}"
  joined="${rest%%|*}"
  stem="${rest#*|}"
  echo
  echo "=== $label ==="
  echo "--- (1) 連結語の内容 grep: '$joined'"
  n1=$(xargs grep -l -- "$joined" < "$LIST" 2>/dev/null | wc -l | tr -d ' ')
  echo "files=$n1"
  xargs grep -l -- "$joined" < "$LIST" 2>/dev/null | head -8
  if [ -n "$stem" ]; then
    echo "--- (2) 語幹の case-insensitive 内容 grep: '$stem'"
    n2=$(xargs grep -il -- "$stem" < "$LIST" 2>/dev/null | wc -l | tr -d ' ')
    echo "files=$n2"
    xargs grep -il -- "$stem" < "$LIST" 2>/dev/null | head -8
    echo "--- (3) 語幹の case-insensitive ファイル名検索: '$stem'"
    n3=$(find "$ML/Mathlib" -iname "*$(echo "$stem" | tr -d ' ')*" -name '*.lean' | wc -l | tr -d ' ')
    echo "files=$n3"
    find "$ML/Mathlib" -iname "*$(echo "$stem" | tr -d ' ')*" -name '*.lean' | head -8
  fi
done

# 「Gauss の章に無平方性の移送が無い」は語の不在だけでは弱いので、
# その 2 ファイルの中身を直接引いて確かめる。
echo
echo "=== Gauss の章と content の章に Squarefree が現れないことの直接確認 ==="
for f in "$ML/Mathlib/RingTheory/Polynomial/GaussLemma.lean" \
         "$ML/Mathlib/RingTheory/Polynomial/Content.lean"; do
  echo "--- $f"
  echo -n "Squarefree の出現行数: "
  grep -c "Squarefree" "$f" 2>/dev/null || echo 0
done

# 本 step で実際に使った宣言の名指し確認（在ることを確かめる側）。
echo
echo "=== 本 step で使った宣言の実在確認 ==="
for decl in \
  "Matrix.exists_mulVec_eq_zero_iff" \
  "Algebra.leftMulMatrix_mulVec_repr" \
  "Algebra.norm_eq_matrix_det" \
  "AdjoinRoot.powerBasis'" \
  "Monic.as_sum" \
  "Submodule.exists_smith_normal_form_of_rank_eq" ; do
  echo -n "$decl: files="
  xargs grep -l -- "$decl" < "$LIST" 2>/dev/null | wc -l | tr -d ' '
done
