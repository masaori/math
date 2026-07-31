#!/usr/bin/env bash
# 未形式化の命題について「mathlib に何が無いか」を一次確認するための grep。
#
# 使い方:
#   cd integrable-lattice/lean && bash scripts/mathlib-gap-survey.sh > logs/mathlib-gap-survey.log
#
# 推測で「無い」と書かないために、検索語とヒットしたファイル数を必ずログに残す。
#
# ## 方式上の注意（2026-07-31 に実際に踏んだ罠。必ず読むこと）
#
# 旧版はキャメルケース連結語をファイル**内容**にだけ grep していた。その結果
# `WeierstrassPreparation files=0` が出たが、これは **偽陰性** だった:
# mathlib には `Mathlib/RingTheory/PowerSeries/WeierstrassPreparation.lean` が実在し、
# 中身の宣言名は `IsWeierstrassDivisionAt` / `IsWeierstrassFactorizationAt` /
# `exists_isWeierstrassDivision` 等で、"WeierstrassPreparation" という連続文字列は
# ファイル内に一度も現れない。
#
# したがってこのスクリプトは各概念について次の 3 つを必ず取る。
#   (1) 連結語のファイル内容 grep（宣言名がその綴りで存在するか）
#   (2) **語幹の case-insensitive** ファイル内容 grep（別の綴り・分割綴りを拾う）
#   (3) **ファイル名** の case-insensitive 検索（宣言名と file 名が食い違う場合を拾う）
# (2)(3) が 0 のときにだけ「その概念は mathlib に無い」と書いてよい。
# (1) だけが 0 なのは「その綴りの識別子が無い」に過ぎず、概念の不在の証拠にならない。
set -uo pipefail

cd "$(dirname "$0")/.."
ML=.lake/packages/mathlib

echo "=== 日付 ==="
date -u +%Y-%m-%dT%H:%M:%SZ
echo "=== mathlib commit ==="
git -C "$ML" rev-parse HEAD
echo "=== mathlib tag / toolchain ==="
git -C "$ML" describe --tags --always 2>/dev/null || true
cat lean-toolchain

# 走査対象のファイル一覧を一度だけ作る（毎回 mathlib 全体を歩くと非常に遅い）
LIST=$(mktemp)
find "$ML/Mathlib" -name '*.lean' > "$LIST"
echo "=== 走査対象 Mathlib/*.lean ファイル数 ==="
wc -l < "$LIST" | tr -d ' '

# 概念ごとに: ラベル | 連結語（内容 grep）| 語幹（case-insensitive の内容 grep / ファイル名検索）
# 語幹が空文字なら (2)(3) は省略する。
concepts=(
  "命題N p進Newton多角形|NewtonPolygon|newton"
  "命題N 下方凸包|lowerConvexHull|convex hull"
  "命題T/W matrix-tree定理|matrixTree|kirchhoff"
  "命題T/W 全域木数|numSpanningTrees|spanning tree"
  "命題W 岩澤不変量|IwasawaInvariant|iwasawa"
  "命題N Skolem-Mahler-Lech|SkolemMahlerLech|mahler"
  "命題N Strassmann|Strassmann|strassmann"
  "命題N Newton 恒等式（行列トレース版があるか）|MvPolynomial.psum|newton identit"
  "命題N companion 行列|Matrix.companion|companion matrix"
  "命題B 固有値の代数的重複度|algebraicMultiplicity|algebraic multiplicity"
  "命題B Jordan標準形|JordanNormalForm|jordan normal"
  "命題B 有理標準形|rationalCanonicalForm|rational canonical"
  "命題B 行列の乗法的位数|Matrix.orderOf|"
  "対照(在ることが既知) Weierstrass準備|WeierstrassPreparation|weierstrass"
  "対照(使用中) 終結式|Polynomial.resultant|resultant"
  "対照(使用中) 乗法的位数|orderOf|"
  "対照(使用中) 特性多項式|Matrix.charpoly|charpoly"
  "対照(使用中) 一般固有空間|genEigenspace|eigenspace"
)

for entry in "${concepts[@]}"; do
  IFS='|' read -r label camel stem <<< "$entry"
  n1=$(grep -l -F -- "$camel" $(cat "$LIST") 2>/dev/null | wc -l | tr -d ' ')
  printf '\n--- %s\n' "$label"
  printf '  (1) 内容 grep  "%s"        files=%s\n' "$camel" "$n1"
  if [ -n "$stem" ]; then
    n2=$(grep -li -F -- "$stem" $(cat "$LIST") 2>/dev/null | wc -l | tr -d ' ')
    n3=$(grep -ci -- "$stem" <<< "$(sed 's|.*/||' "$LIST")" | tr -d ' ')
    printf '  (2) 内容 grep  "%s" (-i)  files=%s\n' "$stem" "$n2"
    printf '  (3) ファイル名 "%s" (-i)  files=%s\n' "$stem" "$n3"
    if [ "$n2" != "0" ]; then
      echo "      内容ヒット（先頭 10 件）:"
      grep -li -F -- "$stem" $(cat "$LIST") 2>/dev/null | sed "s|$ML/||" | head -10 | sed 's/^/        /'
    fi
    if [ "$n3" != "0" ]; then
      echo "      ファイル名ヒット:"
      grep -i -- "$stem" "$LIST" | sed "s|$ML/||" | head -10 | sed 's/^/        /'
    fi
  fi
done

rm -f "$LIST"
