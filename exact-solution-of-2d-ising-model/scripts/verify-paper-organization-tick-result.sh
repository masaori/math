#!/usr/bin/env bash
set -euo pipefail

test "$#" -eq 2
run_output="$1"
success_prefix="$2"
test -f "$run_output"
test -n "$success_prefix"

awk -v prefix="$success_prefix" '
  index($0, prefix) == 1 {
    commit = substr($0, length(prefix) + 1)
    if (length($0) != length(prefix) + 40 || commit !~ /^[0-9a-f]+$/) {
      invalid++
    } else {
      commits[commit] = 1
    }
  }
  END {
    if (invalid > 0) {
      printf "invalid success marker count must be 0, got %d\n", invalid > "/dev/stderr"
      exit 1
    }
    for (commit in commits) {
      unique++
      result = commit
    }
    if (unique != 1) {
      printf "unique success commit count must be 1, got %d\n", unique > "/dev/stderr"
      exit 1
    }
    print result
  }
' "$run_output"
