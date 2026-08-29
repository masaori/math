#!/usr/bin/env bash
# auto-loop.log は、tick のロックを取得した呼び出し元からだけ rotation する。
set -euo pipefail

LOG_FILE="${1:?usage: rotate-auto-loop-log.sh LOG_FILE [MAX_BYTES] [KEEP_ARCHIVES]}"
MAX_BYTES="${2:-67108864}"
KEEP_ARCHIVES="${3:-8}"
LOG_DIR="$(cd "$(dirname "$LOG_FILE")" && pwd -P)"
LOG_NAME="$(basename "$LOG_FILE")"
STATUS_FILE="$LOG_DIR/auto-loop-status.log"

case "$MAX_BYTES:$KEEP_ARCHIVES" in
  *[!0-9:]*|0:*|*:0) printf 'rotation limits must be positive integers\n' >&2; exit 2 ;;
esac

[ -f "$LOG_FILE" ] || exit 0
size="$(stat -f %z "$LOG_FILE")"
[ "$size" -ge "$MAX_BYTES" ] || exit 0

stamp="$(date -u '+%Y%m%dT%H%M%SZ')"
archive="$LOG_DIR/${LOG_NAME%.log}.${stamp}.$$.log"
mv "$LOG_FILE" "$archive"

# gzip は成功時だけ元ファイルを消す。失敗時は非圧縮 archive が残るため証拠を失わない。
gzip -n "$archive"
gzip -t "$archive.gz"

# 人と監査が raw log 全体を展開せず直近の tick 結果を読める、小さい索引を維持する。
status_tmp="$STATUS_FILE.tmp.$$"
if [ -f "$STATUS_FILE" ]; then
  tail -n 2000 "$STATUS_FILE" > "$status_tmp"
else
  gzip -cd "$archive.gz" | awk '/^20[0-9][0-9]-[0-9][0-9]-[0-9][0-9] [0-9][0-9]:[0-9][0-9]:[0-9][0-9] /' | tail -n 2000 > "$status_tmp"
fi
mv "$status_tmp" "$STATUS_FILE"

# 完全な raw log は直近 KEEP_ARCHIVES 世代を可逆圧縮で保持する。
archives_tmp="$LOG_DIR/.auto-loop-archives.$$"
find "$LOG_DIR" -maxdepth 1 -type f -name 'auto-loop.*.log.gz' -print | sort -r > "$archives_tmp"
archive_count="$(wc -l < "$archives_tmp" | tr -d ' ')"
if [ "$archive_count" -gt "$KEEP_ARCHIVES" ]; then
  tail -n "+$(( KEEP_ARCHIVES + 1 ))" "$archives_tmp" | while IFS= read -r expired; do
    [ -n "$expired" ] && rm -- "$expired"
  done
fi
rm "$archives_tmp"

