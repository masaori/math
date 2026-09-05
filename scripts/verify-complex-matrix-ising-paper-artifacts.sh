#!/usr/bin/env bash
# 複素行列版2次元イジング模型の論文構成再編について、人間が読む公開物が
# remote default branch の現行版に追随していることを検証する。
#
#   1. 論文本文（complex-matrix-ising-paper）
#   2. 構成再編の現在地（complex-matrix-ising-paper-organization）
#
# 判定は公開 HTML に埋め込まれた版（生成時の commit）で行う。未コミットの状態で
# 公開されている場合、および版が origin/main に含まれない場合は失敗とする。
# 公開ページには再編の現在地（確定した節の件数）が載っていることも併せて検証する。
set -uo pipefail

BASE_URL="https://hexcomp-artifacts.web.app/math"
SLUGS=(complex-matrix-ising-paper complex-matrix-ising-paper-organization)

failures=0
fail() { echo "  NG: $1"; failures=$((failures + 1)); }

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

for slug in "${SLUGS[@]}"; do
  url="$BASE_URL/$slug/"
  file="$tmp/$slug.html"
  echo "== ${slug} ${url}"
  curl -sfL "$url" -o "$file" || true
  if [ ! -s "$file" ]; then fail "HTML を取得できなかった"; continue; fi

  if grep -q '版 [0-9a-f]\{7,40\}+' "$file"; then
    fail "未コミットの変更を含む状態で公開されている"
    continue
  fi
  commit="$(grep -o '版 [0-9a-f]\{7,40\}' "$file" | head -1 | awk '{print $2}')"
  if [ -z "$commit" ]; then
    fail "版表示が無い（どの時点の内容か判別できない）"
  elif git cat-file -e "${commit}^{commit}" 2>/dev/null &&
       git merge-base --is-ancestor "$commit" origin/main 2>/dev/null; then
    echo "  公開版 $commit は origin/main に含まれる"
  else
    fail "公開版 ${commit:-なし} が origin/main に含まれない（再公開が要る）"
  fi
done

# 構成ページ単体で再編の現在地が読めること
org="$tmp/complex-matrix-ising-paper-organization.html"
if [ -s "$org" ]; then
  if ! grep -q '再編の現在地' "$org"; then
    fail "構成ページに再編の現在地が無い"
  elif ! grep -qE '全[0-9]+件のうち<strong>[0-9]+件</strong>' "$org"; then
    fail "構成ページの現在地に確定件数が入っていない"
  else
    echo "== 現在地: $(grep -o '全[0-9]*件のうち<strong>[0-9]*件</strong>を、[0-9]*個の節' "$org" | sed 's/<[^>]*>//g')"
  fi
fi

if [ "$failures" -ne 0 ]; then
  echo "FAIL: $failures 件"
  exit 1
fi
echo "PASS"
