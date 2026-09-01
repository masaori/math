#!/usr/bin/env bash
set -euo pipefail

test "$#" -eq 2
repo_dir="$1"
default_ref="$2"
git -C "$repo_dir" rev-parse --verify "$default_ref^{commit}" >/dev/null

if [ -n "$(git -C "$repo_dir" status --porcelain)" ]; then
  exit 0
fi
if [ "$(git -C "$repo_dir" rev-list --count "$default_ref"..HEAD)" -gt 0 ]; then
  exit 0
fi
exit 1
