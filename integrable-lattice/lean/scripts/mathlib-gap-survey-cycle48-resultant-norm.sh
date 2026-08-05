#!/usr/bin/env bash
# cycle 48 step 1（命題 C′ の残り 1 段＝終結式が剰余環のノルムであること）で使った
# mathlib の実在確認。
#
# 使い方:
#   cd integrable-lattice/lean && bash scripts/mathlib-gap-survey-cycle48-resultant-norm.sh \
#     > logs/mathlib-gap-survey-cycle48-resultant-norm.log
#
# 方式は scripts/mathlib-gap-survey.sh と同じ 3 段（連結語の内容 grep / 語幹の内容 grep /
# 語幹のファイル名検索）。(2)(3) がともに 0 のときにだけ「無い」と書く。
#
# 見たいのは 3 つである。
#   1. 終結式を剰余環の乗法写像の行列式（＝ノルム）として述べた宣言が在るか。
#   2. 冪基底のトレース形式の Gram 行列式（Algebra.discr）と多項式の判別式（Polynomial.discr）を
#      結ぶ宣言が在るか。
#   3. モニック除法の商が R 線形であることを述べた宣言が在るか（余りの側は在る）。
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

# 表記は 概念名|連結語|語幹。
concepts=(
  "終結式と剰余環のノルムの同定|resultant_eq_norm|resultant.*algebra.norm"
  "剰余環の乗法写像の行列式としての終結式|norm_eq_resultant|norm.*resultant"
  "2 つの判別式（Algebra.discr と Polynomial.discr）の同定|Algebra.discr.*Polynomial.discr|discr.*discriminant.*resultant"
  "モニック除法の商の R 線形性|divByMonicHom|divByMonic.*linearMap"
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

# 語の不在では守備範囲を測れないものは、実在する宣言の仮定を宣言行で直読する。
echo
echo "=== 守備範囲を宣言行で直読する（在るが射程が足りないもの） ==="

echo "--- 終結式の章に Algebra.norm が現れるか（現れれば同定が在る疑い）"
printf 'Mathlib/RingTheory/Polynomial/Resultant/Basic.lean : Algebra.norm の出現 %s 件\n' \
  "$(grep -c 'Algebra.norm' "$ML/Mathlib/RingTheory/Polynomial/Resultant/Basic.lean")"

echo "--- 根の像の積で述べた版は在るが、何を要求するか（宣言行）"
grep -nE "^(theorem|lemma) resultant_eq_prod_roots" -A 3 \
  "$ML/Mathlib/RingTheory/Polynomial/Resultant/Basic.lean" | head -8

echo "--- Algebra.discr をノルムで述べた版は何を要求するか（宣言行）"
grep -nE "^(theorem|lemma) discr_powerBasis_eq_norm" -B 6 -A 3 \
  "$ML/Mathlib/RingTheory/Discriminant.lean" | head -14

echo "--- モニック除法について在るもの（宣言行）。余りは線形写像として在る"
grep -nE "^(theorem|lemma|def|noncomputable def) .*[Mm]odByMonicHom" \
  "$ML/Mathlib/Algebra/Polynomial/RingDivision.lean" | head -4

echo "--- 商について在るもの（宣言行）。次数の補題だけで加法性・スカラー倍は無い"
xargs grep -nE "^(theorem|lemma|def|noncomputable def) .*divByMonic" < "$LIST" 2>/dev/null | head -12
