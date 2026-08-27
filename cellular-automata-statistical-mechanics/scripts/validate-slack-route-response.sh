#!/usr/bin/env bash
# slack route-post が SSOT を検証した後の成功応答だけを受理する。
set -euo pipefail

expected_repository="${1:-}"
if [ -z "$expected_repository" ]; then
  echo "usage: validate-slack-route-response.sh <repository>" >&2
  exit 2
fi

jq -e --arg repository "$expected_repository" '
  .repository == $repository
  and (.channel | type == "string" and length > 0)
  and (.channel_id | type == "string" and length > 0)
  and (.ts | type == "string" and length > 0)
' >/dev/null
