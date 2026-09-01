#!/usr/bin/env bash
set -euo pipefail

test "$#" -eq 2
status="$1"
has_pending_work="$2"
case "$has_pending_work" in
  0|1) ;;
  *) printf 'has_pending_work must be 0 or 1\n' >&2; exit 2 ;;
esac

case "$status:$has_pending_work" in
  124:1|137:1) printf 'checkpoint\n' ;;
  124:0|137:0) printf 'timeout\n' ;;
  *) printf 'continue\n' ;;
esac
