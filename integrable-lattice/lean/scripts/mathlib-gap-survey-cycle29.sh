#!/usr/bin/env bash
# cycle 29 step 1 の仕分け（部分的 16 件を「素材が無い」と「配線をしていないだけ」へ分ける）で
# 使った mathlib の実在確認。
#
# 使い方:
#   cd integrable-lattice/lean && bash scripts/mathlib-gap-survey-cycle29.sh > logs/mathlib-gap-survey-cycle29.log
#
# 方式は scripts/mathlib-gap-survey.sh と同じ 3 段（連結語の内容 grep / 語幹の内容 grep /
# 語幹のファイル名検索）。(2)(3) がともに 0 のときにだけ「無い」と書く。
# 台帳が「素材は在る」と書いている宣言はここで**名前を挙げて実在を確かめる**
# （実在を確かめずに mathlib の補題名を書く誤りが 3 サイクル連続で再発しているため）。
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
  "素材(無いはず) matrix-tree 定理|matrixTree|kirchhoff"
  "素材(無いはず) 全域木数の公式|numSpanningTrees|spanning tree"
  "素材(無いはず) 多変数 Mahler 測度|MvPolynomial.mahlerMeasure|mahler"
  "素材(無いはず) Skolem-Mahler-Lech|SkolemMahlerLech|skolem"
  "素材(無いはず) Strassmann|Strassmann|strassmann"
  "素材(無いはず) Newton 多面体|NewtonPolytope|newton polytope"
  "素材(無いはず) 岩澤不変量の漸近|IwasawaInvariant|iwasawa"
  "素材(無いはず) 整数行列の Smith 標準形|Matrix.smithNormalForm|smith normal"
  "素材(在るはず) 終結式|Polynomial.resultant|resultant"
  "素材(在るはず) 円分拡大|IsCyclotomicExtension|cyclotomic"
  "素材(在るはず) Hensel の補題|hensel|henselian"
  "素材(在るはず) トレース双対|traceDual|trace dual"
  "素材(在るはず) different イデアル|differentIdeal|different ideal"
  "素材(在るはず) 冪級数の位数|PowerSeries.order|power series order"
  "素材(在るはず) 部分再帰関数|Nat.Partrec|partrec"
  "素材(在るはず) 分岐指数|ramificationIdx|ramification"
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

# 本サイクルで実際に使う（あるいは使えるか確かめる）宣言の名指し確認。
echo
echo "=== 名指しの実在確認（宣言名を直接引く） ==="
decls=(
  "Polynomial.resultant"
  "Polynomial.resultant_map_map"
  "Polynomial.resultant_X_sub_C_pow_left"
  "orderOf_eq_prime"
  "Nat.sub_one"
  "geom_sum_mul"
  "CharP.charP"
  "Polynomial.instCharP"
)
for d in "${decls[@]}"; do
  short="${d##*.}"
  n=$(xargs grep -l -- "$short" < "$LIST" 2>/dev/null | wc -l | tr -d ' ')
  echo "--- $d （末尾語 '$short' を含むファイル数）: $n"
  xargs grep -n -- "theorem $short\|lemma $short\|def $short\|instance $short\|noncomputable def $short" < "$LIST" 2>/dev/null | head -4
done

rm -f "$LIST"
echo
echo "SURVEY_EXIT=0"
