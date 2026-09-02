#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

cat > "$TMP_DIR/stubborn-tree.sh" <<'EOF'
#!/usr/bin/env bash
trap '' TERM
(trap '' TERM; while :; do sleep 1; done) &
printf '%s\n' "$!" > "$1"
while :; do sleep 1; done
EOF
chmod +x "$TMP_DIR/stubborn-tree.sh"

set +e
bash "$SCRIPT_DIR/run-bounded-command.sh" 1 1 \
  bash "$TMP_DIR/stubborn-tree.sh" "$TMP_DIR/child.pid"
status=$?
set -e

[ "$status" -eq 137 ] || { printf 'expected exit 137, got %s\n' "$status" >&2; exit 1; }
[ -s "$TMP_DIR/child.pid" ] || { printf 'child pid was not recorded\n' >&2; exit 1; }
child_pid="$(cat "$TMP_DIR/child.pid")"
if kill -0 "$child_pid" 2>/dev/null; then
  printf 'descendant survived timeout: %s\n' "$child_pid" >&2
  exit 1
fi

set +e
bash "$SCRIPT_DIR/run-bounded-command.sh" 0 1 true >/dev/null 2>&1
invalid_status=$?
set -e
[ "$invalid_status" -eq 2 ] || { printf 'invalid limit was accepted\n' >&2; exit 1; }

bash "$SCRIPT_DIR/run-bounded-command.sh" 2 1 true
printf 'OK: finite timeout and descendant cleanup\n'
