#!/usr/bin/env bash
# cycle 49 step 3（命題 T の舞台を m 進完備化の側から具体化する段）で使った mathlib の実在確認。
#
# 使い方:
#   cd integrable-lattice/lean && bash scripts/mathlib-gap-survey-cycle49-adic-stage.sh \
#     > logs/mathlib-gap-survey-cycle49-adic-stage.log
#
# 方式は scripts/mathlib-gap-survey.sh と同じ 3 段。
# 見たいのは 3 つである。
#   1. 付値の位相が m 進位相であることを述べた宣言が在るか（cycle 48 step 2 が「無い」と測った 1 本）。
#   2. 数体の完備化を非アルキメデス的局所体として登録した instance が在るか。
#   3. Noether 局所環の m 進完備化について m 進完備性の instance が在るか
#      （在る側。これが本 step の入口である）。
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
  "付値の位相が m 進位相であること|Valued.isAdic|valued.*isAdic"
  "付値環の m 進位相|valuationSubring.*isAdic|adic topology.*valuation"
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
echo "=== 守備範囲を宣言行で直読する ==="

echo "--- IsAdic そのものは在る（定義の宣言行）"
grep -n "def IsAdic" -A 3 "$ML/Mathlib/Topology/Algebra/Nonarchimedean/AdicTopology.lean" | head -6

echo "--- 非アルキメデス的局所体のクラスに instance が付いている型が在るか"
grep -rn "IsNonarchimedeanLocalField" "$ML/Mathlib" --include=*.lean | grep -v "Mathlib/NumberTheory/LocalField/" | head -6
printf '定義ファイルの外での出現 %s 件\n' \
  "$(grep -rn "IsNonarchimedeanLocalField" "$ML/Mathlib" --include=*.lean | grep -vc "Mathlib/NumberTheory/LocalField/")"

echo "--- 在る側: Noether 局所環の m 進完備化についての m 進完備性（宣言行）"
grep -n "IsAdicComplete" -B 2 -A 3 "$ML/Mathlib/RingTheory/AdicCompletion/LocalRing.lean" | head -20

echo "--- 在る側: 非アルキメデス的局所体の整数環の m 進完備性（宣言行）"
grep -n "IsAdicComplete" -A 2 "$ML/Mathlib/NumberTheory/LocalField/Basic.lean" | head -6

echo "--- 在る側: 剰余体が完備化で保たれること（宣言行）"
grep -n "residueField_map_bijective_of_fg" -A 4 "$ML/Mathlib/RingTheory/AdicCompletion/LocalRing.lean" | head -12
