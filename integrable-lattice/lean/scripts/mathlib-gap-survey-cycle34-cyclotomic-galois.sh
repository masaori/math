#!/usr/bin/env bash
# cycle 34 step 1（命題 R の (R4) を形式化する）で使った
# mathlib の実在確認。
#
# 使い方:
#   cd integrable-lattice/lean && bash scripts/mathlib-gap-survey-cycle34-cyclotomic-galois.sh \
#     > logs/mathlib-gap-survey-cycle34-cyclotomic-galois.log
#
# 方式は scripts/mathlib-gap-survey.sh と同じ 3 段（連結語の内容 grep / 語幹の内容 grep /
# 語幹のファイル名検索）。(2)(3) がともに 0 のときにだけ「無い」と書く。
#
# 見たいのは 1 つだけである。本論文が証明の根拠として引いている外部定理それぞれについて、
# mathlib に既にあるか無いか。あるものは引けばよく（基準の第二種）、無いものは自分で
# 書くことになる（基準の第一種）。この振り分けを憶測でなく実測で決めるためのスクリプトである。
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

# 「本文が証明の根拠として引いている外部定理」を全数並べる。
# 表記は 概念名|連結語|語幹。
concepts=(
  "円分拡大の Galois 群（原始根の取り替え）|autEquivPow|autEquivPow"
  "原始根から自己同型を作る段|autToPow|autToPow"
  "整数環へ環準同型を制限する段|RingOfIntegers.mapRingHom|mapRingHom"
  "終結式が根での値の積であること|resultant_eq_prod_eval|resultant"
  "ノルムが共役の積であること|norm_eq_prod_automorphisms|norm_eq_prod"
  "円分多項式が原始根の積に分解すること|cyclotomic_eq_prod_X_sub_primitiveRoots|primitiveRoots"
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
# 「在る／無い」ではなく「どこまで在るか」が振り分けを決める場合がここに来る。
echo
echo "=== 守備範囲を宣言行で直読する（在るが射程が足りないもの） ==="

echo "--- Mahler 測度は 1 変数か（MvPolynomial を使っているか）"
for f in "$ML/Mathlib/Analysis/Polynomial/MahlerMeasure.lean" "$ML/Mathlib/NumberTheory/MahlerMeasure.lean"; do
  if [ -f "$f" ]; then
    printf '%s : MvPolynomial の出現 %s 件\n' "$f" "$(grep -c 'MvPolynomial' "$f")"
  else
    printf '%s : ファイルが無い\n' "$f"
  fi
done

echo "--- トレース双対は体を要求するか（Module.Basis.traceDual の宣言行）"
xargs grep -nE "traceDual" < "$LIST" 2>/dev/null | grep -E "(def|theorem|lemma) " | head -6

echo "--- Smith 標準形はどこまで在るか（整除の鎖があるか）"
xargs grep -nE "^(theorem|lemma|def|noncomputable def) .*[Ss]mith" < "$LIST" 2>/dev/null | head -12

echo "--- Newton の公式の守備範囲（宣言行）"
xargs grep -nE "^(theorem|lemma|def) .*[Nn]ewton" < "$LIST" 2>/dev/null | head -12

echo "--- Weierstrass 準備定理は何変数か（宣言行）"
xargs grep -nE "^(theorem|lemma|def|structure) .*[Ww]eierstrass" < "$LIST" 2>/dev/null | head -12

rm -f "$LIST"
