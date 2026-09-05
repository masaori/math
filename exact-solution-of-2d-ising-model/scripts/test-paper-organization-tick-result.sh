#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
VERIFY="$SCRIPT_DIR/verify-paper-organization-tick-result.sh"
TICK="$SCRIPT_DIR/paper-organization-tick.sh"
TIMEOUT_DISPOSITION="$SCRIPT_DIR/paper-organization-timeout-disposition.sh"
HAS_PENDING_WORK="$SCRIPT_DIR/paper-organization-has-pending-work.sh"
TEST_DIR="$(mktemp -d)"
PENDING_REPO="$TEST_DIR/pending-repo"
trap 'rm -rf "$PENDING_REPO"; rm -f "$TEST_DIR/stop.log" "$TEST_DIR/invalid.log" "$TEST_DIR/valid.log" "$TEST_DIR/duplicate.log" "$TEST_DIR/different.log" "$TEST_DIR/mixed-invalid.log"; rmdir "$TEST_DIR"' EXIT

prefix='TICK_RESULT_SUCCESS:run-123:'
commit='0123456789abcdef0123456789abcdef01234567'

printf '停止報告です。npm exit 254\n' > "$TEST_DIR/stop.log"
if "$VERIFY" "$TEST_DIR/stop.log" "$prefix" >/dev/null 2>&1; then
  printf '停止報告を成功と判定した\n' >&2
  exit 1
fi

printf '%s%s\n' "$prefix" 'not-a-commit' > "$TEST_DIR/invalid.log"
if "$VERIFY" "$TEST_DIR/invalid.log" "$prefix" >/dev/null 2>&1; then
  printf '不正な成果コミットを成功と判定した\n' >&2
  exit 1
fi

printf '作業完了\n%s%s\n' "$prefix" "$commit" > "$TEST_DIR/valid.log"
test "$("$VERIFY" "$TEST_DIR/valid.log" "$prefix")" = "$commit"

printf '%s%s\n%s%s\n' "$prefix" "$commit" "$prefix" "$commit" > "$TEST_DIR/duplicate.log"
test "$("$VERIFY" "$TEST_DIR/duplicate.log" "$prefix")" = "$commit"

different_commit='89abcdef0123456789abcdef0123456789abcdef'
printf '%s%s\n%s%s\n' "$prefix" "$commit" "$prefix" "$different_commit" > "$TEST_DIR/different.log"
if "$VERIFY" "$TEST_DIR/different.log" "$prefix" >/dev/null 2>&1; then
  printf '異なる成果コミットを一意の成功と判定した\n' >&2
  exit 1
fi

printf '%s%s\n%s%s\n' "$prefix" "$commit" "$prefix" 'not-a-commit' > "$TEST_DIR/mixed-invalid.log"
if "$VERIFY" "$TEST_DIR/mixed-invalid.log" "$prefix" >/dev/null 2>&1; then
  printf '正当なマーカーと混在した不正マーカーを無視した\n' >&2
  exit 1
fi

if grep -Eq 'gh[[:space:]]+pr|gh[[:space:]]+auth' "$TICK"; then
  printf 'tmux外tickへGitHub CLI操作が混入している\n' >&2
  exit 1
fi
grep -Fq "git push origin HEAD:\$default_branch" "$TICK"
grep -Fq 'continuation_mode=1' "$TICK"
grep -Fq '既存棚卸し項目を最大二項だけ扱う' "$TICK"
grep -Fq 'MISE_NO_CONFIG=1' "$TICK"
grep -Fq 'mise/installs/node/22.22.3/bin' "$TICK"
if grep -Fq 'mise/shims' "$TICK"; then
  printf 'MISE_NO_CONFIG環境へmise shimが残っている\n' >&2
  exit 1
fi
grep -Fq '全てのexec_commandはlogin=falseを明示し、/bin/bash -lcを使わない' "$TICK"
grep -Fq 'CHECKPOINT: 有限上限までの成果をworktreeへ保持し、次回は継続モードで完了工程だけを行う' "$TICK"

# Codex が既定の login shell を選んでも、tick から継承した環境では mise の
# 設定探索を行わず本文コマンドへ有限時間で到達することを実経路で確認する。
tick_path="$HOME/.local/bin:$HOME/.local/share/mise/installs/node/22.22.3/bin:$HOME/.elan/bin:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
env -i HOME="$HOME" PATH="$tick_path" MISE_NO_CONFIG=1 timeout -k 2 10 /bin/bash -lc \
  'test "$MISE_NO_CONFIG" = 1; test "$(node --version)" = v22.22.3; npm --version >/dev/null'
env -i HOME="$HOME" PATH="$tick_path" MISE_NO_CONFIG=1 timeout -k 2 10 /bin/bash -c \
  'test "$MISE_NO_CONFIG" = 1; test "$(node --version)" = v22.22.3; npm --version >/dev/null'
test "$("$TIMEOUT_DISPOSITION" 124 1)" = checkpoint
test "$("$TIMEOUT_DISPOSITION" 137 1)" = checkpoint
test "$("$TIMEOUT_DISPOSITION" 124 0)" = timeout
test "$("$TIMEOUT_DISPOSITION" 137 0)" = timeout
test "$("$TIMEOUT_DISPOSITION" 1 1)" = continue
test "$("$TIMEOUT_DISPOSITION" 0 0)" = continue

git init -q "$PENDING_REPO"
git -C "$PENDING_REPO" config user.name tick-test
git -C "$PENDING_REPO" config user.email tick-test@example.invalid
printf 'base\n' > "$PENDING_REPO/tracked.txt"
git -C "$PENDING_REPO" add tracked.txt
git -C "$PENDING_REPO" commit -qm base
git -C "$PENDING_REPO" update-ref refs/remotes/origin/main HEAD
if "$HAS_PENDING_WORK" "$PENDING_REPO" origin/main; then
  printf 'remote default一致のclean worktreeを前回成果ありと判定した\n' >&2
  exit 1
fi
printf 'dirty\n' >> "$PENDING_REPO/tracked.txt"
"$HAS_PENDING_WORK" "$PENDING_REPO" origin/main
git -C "$PENDING_REPO" checkout -- tracked.txt
printf 'ahead\n' >> "$PENDING_REPO/tracked.txt"
git -C "$PENDING_REPO" commit -qam ahead
"$HAS_PENDING_WORK" "$PENDING_REPO" origin/main

# macOSのbash 3.2ではUTF-8の全角括弧が直後にある裸の変数名を誤認する。
# 実際の終了分岐を実行し、ログの分類と元の終了値の両方を固定する。
python3 - "$TICK" <<'PYTEST'
import os
from pathlib import Path
import subprocess
import sys

source = Path(sys.argv[1]).read_text()
ending = source[source.index('case "$status" in'):]
for status, category in [(0, "SUCCESS"), (1, "ERROR"), (124, "TIMEOUT"), (137, "TIMEOUT")]:
    result = subprocess.run(
        ["/bin/bash", "-uc", 'log() { printf "%s\\n" "$1"; }; ' + ending],
        env={**os.environ, "status": str(status), "LC_ALL": "en_US.UTF-8"},
        capture_output=True, text=True, errors="replace",
    )
    assert result.returncode == status, (status, result.returncode, result.stderr)
    assert result.stdout.startswith(category + ":"), result.stdout
    assert result.stderr == "", result.stderr
    if status:
        assert f"exit {status}）" in result.stdout, result.stdout
PYTEST

# プログラミングによる検証: 実起動部分のモデル・環境・終了値を偽 CLI で判定する。
python3 - "$TICK" <<'PYTEST'
import json
import os
from pathlib import Path
import re
import subprocess
import sys
import tempfile

source = Path(sys.argv[1]).read_text()
guards = re.findall(r'^: "\$\{CODEX_HOME:\?.*$', source, re.M)
assert len(guards) == 1
section = source[source.index('log "START: 論文構成tick"'):]
invocation = re.search(r'^set \+e\n(.*?)^set -e$', section, re.M | re.S).group(1)
with tempfile.TemporaryDirectory() as tmp:
    root = Path(tmp)
    cli = root / 'timeout'
    cli.write_text("#!/usr/bin/env python3\nimport os,json,sys\nfrom pathlib import Path\n"
                   "with Path(os.environ['CAPTURE']).open('a') as f: f.write(json.dumps({'args':sys.argv[1:],'home':os.environ['CODEX_HOME'],'prompt':sys.stdin.read()})+'\\n')\n"
                   "raise SystemExit(int(os.environ['TEST_EXIT']))\n")
    cli.chmod(0o755)
    capture = root / 'calls'
    env = dict(os.environ, PATH=tmp+os.pathsep+os.environ['PATH'], CAPTURE=str(capture),
               CODEX_HOME=str(root/'selected account'), TIMEOUT_SECONDS='17', REPO_DIR=tmp,
               PROMPT='[[AI_AGENT_MESSAGE]] 起動の試験', LOG_FILE=str(root/'run.log'), run_output=str(root/'output'))
    for code in (0,1,124,137):
        env['TEST_EXIT'] = str(code)
        result = subprocess.run(['bash','-c','set -eu\n'+guards[0]+'\n'+invocation+'exit "$status"'],
                                env=env,capture_output=True,text=True,timeout=10)
        assert result.returncode == code, result.stderr
    calls = [json.loads(row) for row in capture.read_text().splitlines()]
    assert len(calls) == 4
    for call in calls:
        assert call == {'args':['-k','60','17','codex','exec','-m','gpt-6-astra','-c','model_reasoning_effort=medium','-C',tmp,'-'],
                        'home':env['CODEX_HOME'],'prompt':env['PROMPT']}, call
    for value in (None,''):
        absent = env.copy()
        absent.pop('CODEX_HOME')
        if value is not None: absent['CODEX_HOME']=value
        result=subprocess.run(['bash','-c','set -eu\n'+guards[0]+'\n'+invocation+'exit "$status"'],
                              env=absent,capture_output=True,text=True,timeout=10)
        assert result.returncode != 0 and 'CODEX_HOME' in result.stderr
    assert len(capture.read_text().splitlines()) == 4
PYTEST

printf 'tick結果判定の回帰テスト成功\n'
