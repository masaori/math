#!/usr/bin/env bash
# 公開してよい版かどうかの判定が、実際に落とすべきものを落とすかを確かめる。
#
# 2026-09-05 の事故の回帰試験である。作業ツリーに未追跡のディレクトリが残ったまま公開したため、
# 公開物の版行が「a1999f79a+（未コミットの変更を含む）」になり、その HTML をどのコミットから
# 作り直せるのか分からなくなった。印を隠すのではなく公開そのものを止める、という直し方が
# 効いていることをここで固定する。
#
#   bash scripts/test-require-publishable-version.sh
set -uo pipefail

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
GATE="$PROJECT_DIR/scripts/require-publishable-version.sh"

work="$(mktemp -d)"
trap 'rm -rf "$work"' EXIT

failures=0
expect() {
  local want="$1" name="$2" repo="$3"
  local output status
  output="$(bash "$GATE" "$repo" --no-fetch 2>&1)"; status=$?
  if [ "$status" -eq "$want" ]; then
    printf '✓ %s\n' "$name"
  else
    printf '✗ %s（終了コード %d、期待 %d）\n%s\n' "$name" "$status" "$want" "$output"
    failures=$((failures + 1))
  fi
}

# origin 役の裸リポジトリと、そこを追う作業用リポジトリを作る。
make_repo() {
  local name="$1"
  local origin="$work/$name-origin.git" repo="$work/$name"
  git init --quiet --bare "$origin"
  git init --quiet "$repo"
  git -C "$repo" config user.email test@example.com
  git -C "$repo" config user.name test
  echo one > "$repo/paper.txt"
  git -C "$repo" add paper.txt
  git -C "$repo" commit --quiet -m one
  git -C "$repo" branch -M main
  git -C "$repo" remote add origin "$origin"
  git -C "$repo" push --quiet -u origin main
  git -C "$repo" symbolic-ref refs/remotes/origin/HEAD refs/remotes/origin/main
  printf '%s' "$repo"
}

repo="$(make_repo clean)"
expect 0 "クリーンで remote default に含まれる版は通る" "$repo"

repo="$(make_repo tracked-dirty)"
echo two > "$repo/paper.txt"
expect 1 "追跡ファイルに未コミットの変更があると落ちる" "$repo"

repo="$(make_repo untracked-dirty)"
mkdir -p "$repo/.tmp"
echo scratch > "$repo/.tmp/scratch.txt"
expect 1 "未追跡のファイルが残っていても落ちる（本文はディレクトリ走査で読むため）" "$repo"

repo="$(make_repo not-pushed)"
echo two > "$repo/paper.txt"
git -C "$repo" commit --quiet -am two
expect 1 "remote default に含まれないコミットでは落ちる" "$repo"

repo="$(make_repo pushed)"
echo two > "$repo/paper.txt"
git -C "$repo" commit --quiet -am two
git -C "$repo" push --quiet origin main
expect 0 "push して remote default に入れば通る" "$repo"

if [ "$failures" -eq 0 ]; then
  echo "PASS: 公開してよい版の判定は、dirty と未包含をどちらも止める"
  exit 0
fi
echo "FAIL: $failures 件"
exit 1
