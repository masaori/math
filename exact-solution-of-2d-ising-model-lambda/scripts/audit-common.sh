#!/usr/bin/env bash

count_matches() {
  grep -c -- "$1" "$2" 2>/dev/null || true
}

count_remaining_ledger_rows() {
  awk '
    /^\| 章 \| セクション \| 状態 \| 備考 \|$/ { in_table = 1; next }
    in_table && /^\|---/ { next }
    in_table && /^\|/ { count++; next }
    in_table { exit }
    END { print count + 0 }
  ' "$1"
}
