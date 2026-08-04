#!/usr/bin/env bash
# cycle 29 step 2（双対命題 D の p 素点側の切り出し）で使った mathlib の実在確認。
#
# 使い方:
#   cd integrable-lattice/lean && bash scripts/mathlib-gap-survey-cycle29-duality.sh \
#     > logs/mathlib-gap-survey-cycle29-duality.log
#
# 方式は scripts/mathlib-gap-survey.sh と同じ 3 段（連結語の内容 grep / 語幹の内容 grep /
# 語幹のファイル名検索）。(2)(3) がともに 0 のときにだけ「無い」と書く。
#
# 見たいのは 2 つ。
#   (a) 有限 L の段で実際に使う素材が在るか（在るはず。名指しで確かめる）。
#   (b) 塔の漸近の段（Monsky / Cuoco–Monsky の適用）の素材が在るか（無いはず）。
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
  "塔の漸近(無いはず) Monsky の p 進冪級数の定理|Monsky|monsky"
  "塔の漸近(無いはず) Cuoco-Monsky の類数漸近|CuocoMonsky|cuoco"
  "塔の漸近(無いはず) 岩澤不変量 lambda mu nu の漸近|IwasawaInvariant|iwasawa"
  "塔の漸近(無いはず) Z_p^d 拡大|ZpExtension|multiple zp extension"
  "塔の漸近(無いはず) d 変数の完備群環|MvPowerSeries.completion|iwasawa algebra"
  "塔の漸近(無いはず) 指標群の半代数的部分集合|semialgebraic|semialgebraic"
  "塔の漸近(無いはず) 多変数 Weierstrass 準備定理|MvPowerSeries.weierstrass|weierstrass preparation"
  "塔の漸近(無いはず) 代数閉包 Qbar_p 上の付値 ord_p|Padic.algebraicClosure|algebraic closure of p-adic"
  "アルキメデス側(無いはず) 多変数 Mahler 測度|MvPolynomial.mahlerMeasure|mahler measure"
  "有限 L(在るはず) 終結式|Polynomial.resultant|resultant"
  "有限 L(在るはず) 根での積による終結式|resultant_eq_prod_eval|resultant"
  "有限 L(在るはず) 体上の gcd の基底変換|Polynomial.gcd_map|gcd_map"
  "有限 L(在るはず) gcd の根は共通根|isRoot_gcd_iff_isRoot_left_right|root_gcd"
  "有限 L(在るはず) monic な因子の Gauss 降下|eq_map_mul_C_of_dvd|gauss lemma"
  "有限 L(在るはず) X^n-C の分離性|separable_X_pow_sub_C|separable"
  "有限 L(在るはず) 整数の p 進付値|padicValInt|padicval"
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

# 本 step で実際に使った宣言の名指し確認
# （実在を確かめずに mathlib の補題名を書く誤りが 3 サイクル連続で再発しているため）。
echo
echo "=== 名指しの実在確認（本 step が実際に使った宣言） ==="
decls=(
  "Polynomial.resultant_eq_prod_eval"
  "Polynomial.resultant_map_map"
  "Polynomial.roots_multiset_prod_X_sub_C"
  "Polynomial.prod_multiset_X_sub_C_dvd"
  "Polynomial.monic_multiset_prod_of_monic"
  "Polynomial.monic_mul_leadingCoeff_inv"
  "Polynomial.Splits.of_dvd"
  "Polynomial.Splits.eq_prod_roots_of_monic"
  "Polynomial.gcd_map"
  "Polynomial.isRoot_gcd_iff_isRoot_left_right"
  "Polynomial.separable_X_pow_sub_C"
  "Polynomial.nodup_roots"
  "Polynomial.modByMonic_add_div"
  "Polynomial.Monic.of_mul_monic_left"
  "Polynomial.Monic.dvd_of_fraction_map_dvd_fraction_map"
  "IsIntegrallyClosed.eq_map_mul_C_of_dvd"
  "Multiset.prod_dvd_prod_of_le"
  "Multiset.nodup_of_le"
  "Multiset.Nodup.ext"
)
# 宣言名は名前空間の中で `theorem Splits.of_dvd` のように書かれていることがあるので、
# 末尾語だけでなく「末尾 2 成分」でも引く（末尾語だけで引くと実在するものを見落とす）。
for d in "${decls[@]}"; do
  short="${d##*.}"
  head_ns="${d%.*}"
  two="${head_ns##*.}.$short"
  echo "--- $d"
  # まず「末尾 2 成分」で引く（こちらが本命。名前空間の中で `theorem Splits.of_dvd` と
  # 書かれている宣言は、末尾語だけで引くと同名の別宣言に埋もれて見えなくなる）。
  xargs grep -nE -- "^(protected |nonrec |private )?(theorem|lemma|def|abbrev) $two\b" \
    < "$LIST" 2>/dev/null | head -2
  xargs grep -nE -- "^(protected |nonrec |private )?(theorem|lemma|def|abbrev) $short\b" \
    < "$LIST" 2>/dev/null | head -2
done

rm -f "$LIST"
echo
echo "SURVEY_EXIT=0"
