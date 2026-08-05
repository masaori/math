#!/usr/bin/env bash
# cycle 49 step 2（命題 C′ の $w^*$ を本文の単因子の鎖の言葉と一致させる段）で使った
# mathlib の実在確認。
#
# 使い方:
#   cd integrable-lattice/lean && bash scripts/mathlib-gap-survey-cycle49-smith-chain.sh \
#     > logs/mathlib-gap-survey-cycle49-smith-chain.log
#
# 方式は scripts/mathlib-gap-survey.sh と同じ 3 段（連結語の内容 grep / 語幹の内容 grep /
# 語幹のファイル名検索）。(2)(3) がともに 0 のときにだけ「無い」と書く。
#
# 見たいのは 2 つである。本文は $w^*$ を「Smith 標準形の最後の対角成分」と書いているので、
#   1. 整数行列（あるいは PID 上の行列）の Smith 標準形そのものが在るか。
#   2. 適合基底の係数どうしの整除の鎖（$a_1\mid a_2\mid\cdots$）を述べた宣言が在るか。
# 適合基底そのもの（Submodule.smithNormalForm / Ideal.smithCoeffs）は在ることが分かっているので、
# 鎖の側だけが問題である。そこは宣言行を直読して確かめる。
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
  "行列の Smith 標準形（対角化そのもの）|smithNormalFormMatrix|smith normal form"
  "単因子の整除の鎖|smithCoeffs_dvd|elementary divisor"
  "不変因子|invariantFactors|invariant factor"
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
echo "=== 守備範囲を宣言行で直読する（在るが射程が足りないもの） ==="

echo "--- 適合基底そのものは在る（Submodule.smithNormalForm の宣言行）"
grep -rn "smithNormalForm" "$ML/Mathlib/LinearAlgebra/FreeModule/PID.lean" | head -8

echo "--- Ideal.smithCoeffs について在る宣言（係数どうしの整除が在るか）"
grep -rn "smithCoeffs" "$ML/Mathlib" --include=*.lean | head -12

echo "--- smithCoeffs を含む行のうち、整除（∣ / Dvd）を述べているもの"
grep -rn "smithCoeffs" "$ML/Mathlib" --include=*.lean | grep -cE "∣|Dvd"
