#!/usr/bin/env bash
# 成果物 API CLI が返す、ログイン不要の正規公開 URL だけを受理する。
set -euo pipefail

expected_base_url="${1:-}"
if [ -z "$expected_base_url" ]; then
  echo "usage: validate-artifact-publish-response.sh <expected-base-url>" >&2
  exit 2
fi

jq -er --arg base "$expected_base_url" '
  select(
    .loginRequired == false
    and (.url | type == "string")
    and (.url | startswith($base + "/"))
    and (.url | length > ($base | length) + 1)
    and (.url | contains("?") | not)
    and (.url | contains("#") | not)
  )
  | .url
'
