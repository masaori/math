#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
VALIDATOR="$SCRIPT_DIR/validate-slack-route-response.sh"

printf '%s' '{"repository":"math","channel":"math-ai-notification","channel_id":"C0123456789","ts":"1787810000.000001"}' \
  | "$VALIDATOR" math

if printf '%s' '{"repository":"math","channel":"local-pc-management","channel_id":"","ts":"1787810000.000001"}' \
  | "$VALIDATOR" math; then
  echo "channel_id が空の応答を受理した" >&2
  exit 1
fi

if printf '%s' '{"repository":"local-pc-management","channel":"math-ai-notification","channel_id":"C0123456789","ts":"1787810000.000001"}' \
  | "$VALIDATOR" math; then
  echo "別リポジトリの応答を受理した" >&2
  exit 1
fi

echo "Slack route response validation tests passed"
