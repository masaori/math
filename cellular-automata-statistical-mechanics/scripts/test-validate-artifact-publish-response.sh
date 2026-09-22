#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
VALIDATOR="$SCRIPT_DIR/validate-artifact-publish-response.sh"
BASE_URL="https://hexcomp-artifacts.web.app"
EXPECTED_URL="$BASE_URL/63dc5fce-9709-46d7-ac4e-e3e109bf9912"

actual="$(printf '%s' "{\"url\":\"$EXPECTED_URL\",\"loginRequired\":false}" | "$VALIDATOR" "$BASE_URL")"
if [ "$actual" != "$EXPECTED_URL" ]; then
  echo "公開 API の URL をそのまま返さなかった" >&2
  exit 1
fi

reject() {
  local description="$1"
  local response="$2"
  if printf '%s' "$response" | "$VALIDATOR" "$BASE_URL" >/dev/null 2>&1; then
    echo "$description を受理した" >&2
    exit 1
  fi
}

reject "ログイン必須の応答" "{\"url\":\"$EXPECTED_URL\",\"loginRequired\":true}"
reject "別オリジンの URL" '{"url":"https://example.com/report","loginRequired":false}'
reject "パスの無い URL" "{\"url\":\"$BASE_URL/\",\"loginRequired\":false}"
reject "クエリ付き URL" "{\"url\":\"$EXPECTED_URL?token=secret\",\"loginRequired\":false}"
reject "不正な JSON" 'not-json'

echo "Artifact publish response validation tests passed"
