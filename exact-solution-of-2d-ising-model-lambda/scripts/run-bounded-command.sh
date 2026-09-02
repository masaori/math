#!/usr/bin/env bash
# コマンド全体を独立プロセスグループで有限実行し、TERM で止まらない子孫も回収する。
set -euo pipefail

LIMIT_SECONDS="${1:?usage: run-bounded-command.sh LIMIT_SECONDS KILL_AFTER_SECONDS COMMAND [ARG ...]}"
KILL_AFTER_SECONDS="${2:?usage: run-bounded-command.sh LIMIT_SECONDS KILL_AFTER_SECONDS COMMAND [ARG ...]}"
shift 2
[ "$#" -gt 0 ] || { printf 'command is required\n' >&2; exit 2; }

case "$LIMIT_SECONDS:$KILL_AFTER_SECONDS" in
  *[!0-9:]*|0:*|*:0) printf 'timeout limits must be positive integers\n' >&2; exit 2 ;;
esac

# GNU timeout は既定で COMMAND を独立プロセスグループに置く。期限時はそのグループへ
# TERM、さらに -k の期限後は KILL を送るため、COMMAND が起動した子孫も残らない。
exec timeout -k "$KILL_AFTER_SECONDS" "$LIMIT_SECONDS" "$@"
