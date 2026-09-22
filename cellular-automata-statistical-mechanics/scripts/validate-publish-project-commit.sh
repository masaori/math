#!/usr/bin/env bash
# 公開・通知の版として、現在の履歴に含まれ研究ディレクトリを変更した commit だけを受理する。
set -euo pipefail

if [ "$#" -ne 3 ]; then
  echo "usage: validate-publish-project-commit.sh <repo> <project> <commit>" >&2
  exit 2
fi

repo="$1"
project="$2"
commit="$3"

printf '%s' "$commit" | grep -Eq '^[0-9a-f]{40}$'
git -C "$repo" cat-file -e "$commit^{commit}" 2>/dev/null
git -C "$repo" merge-base --is-ancestor "$commit" HEAD

has_research_change=0
while IFS= read -r changed_path; do
  case "$changed_path" in
    "$project/MEMORY.md"|"$project/scripts/"*|"$project/docs/tasks/auto-loop-runbook.md") ;;
    *) has_research_change=1 ;;
  esac
done < <(git -C "$repo" diff-tree --root --no-commit-id --name-only -r "$commit" -- "$project")

[ "$has_research_change" -eq 1 ]
