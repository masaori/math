#!/usr/bin/env bash
set -euo pipefail

test "$#" -eq 2
run_output="$1"
success_prefix="$2"
test -f "$run_output"
test -n "$success_prefix"

marker_count="$(awk -v prefix="$success_prefix" '
  index($0, prefix) == 1 && length($0) == length(prefix) + 40 && substr($0, length(prefix) + 1) ~ /^[0-9a-f]+$/ { count++ }
  END { print count + 0 }
' "$run_output")"
if [ "$marker_count" -ne 1 ]; then
  printf 'success marker count must be 1, got %s\n' "$marker_count" >&2
  exit 1
fi

awk -v prefix="$success_prefix" '
  index($0, prefix) == 1 && length($0) == length(prefix) + 40 && substr($0, length(prefix) + 1) ~ /^[0-9a-f]+$/ {
    print substr($0, length(prefix) + 1)
  }
' "$run_output"
