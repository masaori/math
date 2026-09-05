#!/usr/bin/env bash
# 研究監督 tick が、契約どおりに揃っていることを検査する。
#
#   verify-cellular-automata-supervisor-tick.sh              リポジトリ側だけを検査する
#   verify-cellular-automata-supervisor-tick.sh --installed  さらに launchd への設置まで検査する
#
# 設置の検査を既定にしないのは、PR の回帰検査（設置されていない環境）でも使うためである。
# 逆に `--installed` を付けたときは、設置されていないこと・宣言と食い違うことを成功として通さない。
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
LABEL="com.masaori.cellular-automata-research-supervision"
LAUNCHER="$HOME/.local/bin/cellular-automata-supervision-launcher.sh"
PLIST="$HOME/Library/LaunchAgents/$LABEL.plist"
LOG_DIR="$HOME/Library/Logs/cellular-automata-research-supervision"
DECLARATION="$HOME/git/masaori/local-pc-management/agent-sessions/config/tick-schedules.json"
WORKTREE_SUFFIX=".claude/worktrees/tick/cellular-automata-research-supervision"

check_installed=0
for arg in "$@"; do
  case "$arg" in
    --installed) check_installed=1 ;;
    *)
      echo "不明な引数: $arg" >&2
      exit 2
      ;;
  esac
done

PATH="$HOME/.local/bin:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:$PATH"
[ -d "$HOME/.local/share/mise/shims" ] && PATH="$HOME/.local/share/mise/shims:$PATH"
export PATH

for cli in node python3; do
  if ! command -v "$cli" >/dev/null 2>&1; then
    echo "必要なコマンドが PATH に無い: $cli" >&2
    exit 1
  fi
done

failures=0
ng() {
  echo "  NG: $1" >&2
  failures=$((failures + 1))
}
ok() { echo "  OK: $1"; }

echo "== 契約と実装が揃っていることを検査する =="

RUNBOOK="$PROJECT_DIR/docs/tasks/supervision-runbook.md"
if [ ! -f "$RUNBOOK" ]; then
  ng "監督の契約の正本が無い: $RUNBOOK"
else
  ok "監督の契約の正本がある"
  # 契約の四つの判定が全て書かれていること。**どれかが契約から消えると、記録の規則だけが
  # 残って「なぜその欄を書くのか」が失われる。**
  for heading in "最終ゴールとの照合" "段取りの妥当性" "証明済み事項から得たインサイト" "段取りの変更"; do
    if ! grep -q "### $heading" "$RUNBOOK"; then
      ng "契約に「$heading」の節が無い"
    fi
  done
  if ! grep -q "進捗を件数で測らない" "$RUNBOOK"; then
    ng "契約に「進捗を件数で測らない」の節が無い"
  fi
  if ! grep -q "ゴールを縮めない" "$RUNBOOK"; then
    ng "契約に「ゴールを縮めない」の制約が無い"
  fi
  if [ "$failures" -eq 0 ]; then
    ok "契約が四つの判定・件数を進捗としないこと・ゴールを縮めないことを全て持っている"
  fi
fi

TICK="$PROJECT_DIR/scripts/supervisor-tick.sh"
if [ ! -f "$TICK" ]; then
  ng "監督 tick の本体が無い: $TICK"
elif [ ! -x "$TICK" ]; then
  ng "監督 tick の本体に実行権が無い: $TICK"
else
  ok "監督 tick の本体がある"
  # 研究 tick と worktree を共有していないこと。共有すると互いの未コミット成果を巻き込む。
  # 見るのは worktree の代入行だけにする（説明の地の文には研究 tick の名前が出てよい）。
  worktree_line="$(grep -E '^LOOP_WORKTREE=' "$TICK" || true)"
  if [ -z "$worktree_line" ]; then
    ng "監督 tick に worktree の代入が無い"
  elif printf '%s' "$worktree_line" | grep -q "cellular-automata-auto-loop"; then
    ng "監督 tick が研究 tick の worktree を指している: $worktree_line"
  elif ! printf '%s' "$worktree_line" | grep -q "cellular-automata-research-supervision"; then
    ng "監督 tick の worktree が監督専用の名前になっていない: $worktree_line"
  else
    ok "監督 tick が研究 tick とは別の専用 worktree を使う"
  fi
  # 失敗時に別モデルへ落とす経路が無いこと（フォールバック禁止）。
  if grep -qE '\|\| *(claude|codex) ' "$TICK"; then
    ng "監督 tick に別モデルへのフォールバック経路がある"
  else
    ok "監督 tick に別モデルへのフォールバック経路が無い"
  fi
fi

echo "== 監督の記録が契約を満たしていることを検査する =="
if node "$PROJECT_DIR/scripts/verify-supervision-log.ts"; then
  ok "記録が契約を満たしている"
else
  ng "記録が契約を満たしていない"
fi

echo "== 記録の規則の回帰検査 =="
if node "$PROJECT_DIR/scripts/verify-supervision-log-test.ts"; then
  ok "規則の回帰検査が通った"
else
  ng "規則の回帰検査が落ちた"
fi

if [ "$check_installed" -eq 1 ]; then
  echo "== launchd への設置を検査する =="

  if [ -f "$LAUNCHER" ] && [ -x "$LAUNCHER" ]; then
    ok "起動口がある: $LAUNCHER"
  else
    ng "起動口が無い、または実行権が無い: $LAUNCHER"
  fi

  if [ -f "$PLIST" ]; then
    ok "plist がある: $PLIST"
    if ! plutil -p "$PLIST" | grep -q "$LAUNCHER"; then
      ng "plist が起動口を指していない"
    fi
    # 6 時間ごと（2/8/14/20 時 52 分）であること。実体が宣言から離れていないかを見る。
    hours="$(plutil -p "$PLIST" | grep -c '"Hour" => \(2\|8\|14\|20\)$' || true)"
    minutes="$(plutil -p "$PLIST" | grep -c '"Minute" => 52$' || true)"
    if [ "$hours" = "4" ] && [ "$minutes" = "4" ]; then
      ok "発火が 6 時間ごと（2/8/14/20 時 52 分）である"
    else
      ng "発火が 6 時間ごと（2/8/14/20 時 52 分）でない（Hour ${hours} 件 / Minute ${minutes} 件）"
    fi
  else
    ng "plist が無い: $PLIST"
  fi

  if launchctl print "gui/$(id -u)/$LABEL" >/dev/null 2>&1; then
    ok "launchd に読み込まれている: $LABEL"
  else
    ng "launchd に読み込まれていない: $LABEL"
  fi

  if [ -d "$LOG_DIR" ]; then
    ok "ログの出力先がある: $LOG_DIR"
  else
    ng "ログの出力先が無い: $LOG_DIR"
  fi

  # 宣言（tick-schedules.json）の側にも同じ label が、正準の worktree つきで載っていること。
  # **実体だけを設置して宣言へ載せないと、翌朝の監査で消される。**
  if [ ! -f "$DECLARATION" ]; then
    ng "tick の宣言が読めない: $DECLARATION"
  elif python3 - "$DECLARATION" "$LABEL" "$WORKTREE_SUFFIX" <<'PYEOF'
import json, sys
path, label, suffix = sys.argv[1], sys.argv[2], sys.argv[3]
ticks = json.load(open(path))["ticks"]
found = [t for t in ticks if t.get("label") == label]
if not found:
    print(f"  NG: 宣言に {label} が無い", file=sys.stderr); sys.exit(1)
tick = found[0]
problems = []
if tick.get("kind") != "agent-tick":
    problems.append(f'kind が agent-tick でない: {tick.get("kind")}')
if not tick.get("agents"):
    problems.append("agents が空である")
if tick.get("worktree_tool") != "claude":
    problems.append(f'worktree_tool が claude でない: {tick.get("worktree_tool")}')
worktrees = tick.get("protected_worktrees") or []
if not any(w.endswith(suffix) for w in worktrees):
    problems.append(f"protected_worktrees に正準の worktree が無い: {worktrees}")
schedule = tick.get("schedule") or {}
entries = schedule.get("entries") or []
expected = [{"hour": h, "minute": 52} for h in (2, 8, 14, 20)]
if schedule.get("type") != "calendar" or entries != expected:
    problems.append(f"宣言の発火が 6 時間ごと（2/8/14/20 時 52 分）でない: {schedule}")
for problem in problems:
    print(f"  NG: {problem}", file=sys.stderr)
sys.exit(1 if problems else 0)
PYEOF
  then
    ok "宣言に正準の worktree・実行主体・6 時間ごとの発火が載っている"
  else
    failures=$((failures + 1))
  fi
fi

if [ "$failures" -gt 0 ]; then
  echo "研究監督 tick の検査に失敗した（$failures 件）" >&2
  exit 1
fi
echo "研究監督 tick の検査は全て成功した"
