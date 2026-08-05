#!/usr/bin/env bash
# cycle 48 step 2（命題 T の残り 1 段＝本文の完備化が舞台であることの同定）で使った
# mathlib の実在確認。
#
# 使い方:
#   cd integrable-lattice/lean && bash scripts/mathlib-gap-survey-cycle48-completion.sh \
#     > logs/mathlib-gap-survey-cycle48-completion.log
#
# 方式は scripts/mathlib-gap-survey.sh と同じ 3 段（連結語の内容 grep / 語幹の内容 grep /
# 語幹のファイル名検索）。(2)(3) がともに 0 のときにだけ「無い」と書く。
#
# 見たいのは 4 つである。
#   1. 完備化の整数環が離散付値環であることが在るか（cycle 45 は無いと読んでいた側）。
#   2. その環が m 進完備であること（`IsAdicComplete`）へ渡る道が在るか。
#   3. 完備な離散付値環と Witt ベクトル環の同型（Cohen の構造定理）が在るか。
#   4. 円分体で n を割らない素数が不分岐であることが在るか。
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
  "完備化の整数環が離散付値環であること|IsDiscreteValuationRing.*adicCompletionIntegers|adicCompletionIntegers"
  "完備化の整数環が m 進完備であること|IsAdicComplete.*adicCompletionIntegers|isAdicComplete"
  "完備な離散付値環と Witt ベクトル環の同型（Cohen の構造定理）|WittVector.*equiv.*DiscreteValuationRing|cohen structure"
  "円分体で n を割らない素数が不分岐であること|IsUnramified.*cyclotomic|cyclotomic.*unramified"
  "局所環が Hensel であることのクラス|HenselianLocalRing|henselian"
  "付値の位相が m 進位相であること|IsAdic.*[Vv]alu|isAdic.*integer"
  "非アルキメデス局所体のクラスのインスタンス|instance.*IsNonarchimedeanLocalField|IsNonarchimedeanLocalField"
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

echo "--- 完備化の整数環についてのインスタンス（宣言行）"
grep -nE "^(instance|noncomputable instance|theorem|lemma)" \
  "$ML/Mathlib/NumberTheory/NumberField/Completion/FinitePlace.lean" | head -12

echo "--- IsAdicComplete のインスタンスは何に付いているか（宣言行）"
xargs grep -nE "^(instance|noncomputable instance).*IsAdicComplete" < "$LIST" 2>/dev/null | head -8

echo "--- m 進完備性と位相の完備性を結ぶ橋（宣言行）"
grep -nE "^(protected lemma|lemma|theorem) IsAdic\." \
  "$ML/Mathlib/RingTheory/AdicCompletion/Topology.lean" | head -6

echo "--- HenselianLocalRing のインスタンスは何に付いているか（宣言行）"
xargs grep -nE "^instance.*HenselianLocalRing|^instance.*: *HenselianLocalRing" < "$LIST" 2>/dev/null | head -8

echo "--- 完備なら Hensel であること（宣言行）"
grep -nE "IsAdicComplete.henselianRing" "$ML/Mathlib/RingTheory/Henselian.lean" | head -4

echo "--- 非アルキメデス局所体のクラスに、定義元の外でインスタンスが付いているか"
xargs grep -n "IsNonarchimedeanLocalField" < "$LIST" 2>/dev/null \
  | grep -v "LocalField/Basic" | head -6
echo "（上が空なら、このクラスは定義されているだけで、どの体にも付いていない）"
