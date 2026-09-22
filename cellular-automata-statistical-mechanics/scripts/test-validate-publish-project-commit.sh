#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
VALIDATOR="$SCRIPT_DIR/validate-publish-project-commit.sh"
work_dir="$(mktemp -d)"
cleanup() {
  rm -rf "$work_dir"
}
trap cleanup EXIT

repo="$work_dir/repo"
git init -q -b main "$repo"
mkdir -p "$repo/research"
printf 'first\n' > "$repo/research/result.txt"
git -C "$repo" add research/result.txt
git -C "$repo" -c user.name=test -c user.email=test@example.com commit -q -m 'research result'
research_commit="$(git -C "$repo" rev-parse HEAD)"

mkdir -p "$repo/research/scripts"
printf 'operation\n' > "$repo/research/scripts/operation.sh"
git -C "$repo" add research/scripts/operation.sh
git -C "$repo" -c user.name=test -c user.email=test@example.com commit -q -m 'operational change'
operational_commit="$(git -C "$repo" rev-parse HEAD)"

"$VALIDATOR" "$repo" research "$research_commit"

reject() {
  local description="$1"
  local commit="$2"
  if "$VALIDATOR" "$repo" research "$commit" >/dev/null 2>&1; then
    echo "$description を受理した" >&2
    exit 1
  fi
}

reject "研究を変更していない commit" "$operational_commit"
reject "存在しない commit" "0000000000000000000000000000000000000000"
reject "短い commit 表記" "${research_commit:0:12}"

git -C "$repo" switch -q -c unmerged "$research_commit"
printf 'unmerged\n' > "$repo/research/unmerged.txt"
git -C "$repo" add research/unmerged.txt
git -C "$repo" -c user.name=test -c user.email=test@example.com commit -q -m 'unmerged research'
unmerged_commit="$(git -C "$repo" rev-parse HEAD)"
git -C "$repo" switch -q main
reject "現在の履歴に含まれない研究 commit" "$unmerged_commit"

echo "Publish project commit validation tests passed"
