#!/usr/bin/env bash
# 毎 tick の成果を HTML と PDF で公開する（ユーザー指示）。
#
# 公開先は artifacts リポジトリの GitHub Pages。**URL を決め打ちしない**
# （リポジトリの所有が masaori から hexagonal-computation へ移り、決め打ちした URL が
#  実測 2026-08-13 に 404 になった）。公開スクリプトが出力した URL をそのまま使う。
# エージェント CLI 内蔵の公開機能は使わない（グローバル指示。アカウントが切り替わると閲覧できなくなる）。
#
# 置くもの:
#   index.html      いまの状態（版・進捗・残り・直近の記録）だけ
#
# **PDF は置かない**（ユーザー指示。証明本体はローカルで開いて読む）。
#
# **その場で見るためのものだけを置く。** ここは予告なく消えうる場所なので、
# 恒久的にリンクされるものは置かない（グローバル指示）。
set -uo pipefail

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
REPO_DIR="$(cd "$PROJECT_DIR/.." && pwd -P)"
LOG_DIR="$PROJECT_DIR/logs"
LOG_FILE="$LOG_DIR/publish-artifact.log"
LOCK_DIR="$LOG_DIR/publish-artifact.lock"
LEDGER="$PROJECT_DIR/docs/tasks/auto-loop-state.md"
PDF="$PROJECT_DIR/structured-latex/build/document.pdf"
SLUG="ising-lambda"
STAGE="$HOME/.artifact-uploads/math/$SLUG"

mkdir -p "$LOG_DIR"
log() { printf '%s %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$1" >> "$LOG_FILE"; }

if ! mkdir "$LOCK_DIR" 2>/dev/null; then exit 0; fi
trap 'rm -rf "$LOCK_DIR"' EXIT

[ -f "$PDF" ] || { log "SKIP: PDF がまだ無い"; exit 0; }

commit="$(git -C "$REPO_DIR" rev-parse --short HEAD)"
committed_at="$(git -C "$REPO_DIR" log -1 --format='%cd' --date=format:'%Y-%m-%d %H:%M')"
subject="$(git -C "$REPO_DIR" log -1 --format='%s')"
pages="$(grep -ao '/Type *//*Page[^s]' "$PDF" 2>/dev/null | wc -l | tr -d ' ')"
agent="$(cat "$LOG_DIR/last-agent" 2>/dev/null || echo '-')"

mkdir -p "$STAGE"
rm -f "$STAGE/document.pdf"   # 以前は置いていた。もう置かない。

# 台帳から「残っているもの」と直近の記録を取り出す（台帳が進捗の正本）。
python3 - "$LEDGER" "$STAGE/index.html" "$commit" "$committed_at" "$subject" "$agent" "$pages" <<'PY'
import html, re, sys, datetime

ledger_path, out_path, commit, committed_at, subject, agent, pages = sys.argv[1:8]
text = open(ledger_path, encoding="utf-8").read()

def section(name):
    m = re.search(rf"^## {re.escape(name)}\n(.*?)(?=^## |\Z)", text, re.S | re.M)
    return m.group(1).strip() if m else ""

# 残っているもの（表の行）
todos = []
for line in section("セクション台帳").split("\n"):
    if "| todo |" in line:
        cols = [c.strip() for c in line.strip().strip("|").split("|")]
        if len(cols) >= 2:
            todos.append((cols[0], cols[1]))

# 済んだ範囲（章ごとの件数）
done = [l[2:].strip() for l in section("セクション台帳").split("\n") if l.startswith("- ")]

def bullets(name, limit):
    out, cur = [], None
    for l in section(name).split("\n"):
        if l.startswith("- "):
            if cur: out.append(cur)
            cur = l[2:]
        elif cur is not None and l.strip():
            cur += " " + l.strip()
    if cur: out.append(cur)
    return out[:limit]

def tex(s):
    """本文の $…$ はそのまま出す（KaTeX は入れない。読めれば十分）。"""
    return html.escape(s)

rows = "\n".join(
    f"<tr><td>{tex(ch)}</td><td>{tex(sec)}</td></tr>" for ch, sec in todos
) or "<tr><td colspan='2'>（残りなし）</td></tr>"

def li(items):
    return "\n".join(f"<li>{tex(x)}</li>" for x in items) or "<li>（記録なし）</li>"

now = datetime.datetime.now().strftime("%Y-%m-%d %H:%M")
open(out_path, "w", encoding="utf-8").write(f"""<!doctype html>
<html lang="ja"><head><meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>2次元 Ising 模型の厳密解 — Λ と Fisher 零点の立場から</title>
<style>
:root {{ color-scheme: light dark; --fg:#1a1a1a; --bg:#fff; --muted:#666; --line:#ddd; --accent:#0b5; }}
@media (prefers-color-scheme: dark) {{ :root {{ --fg:#e8e8e8; --bg:#161616; --muted:#999; --line:#333; }} }}
body {{ margin:0 auto; padding:24px 20px 64px; max-width:1000px;
  font-family:-apple-system,"Hiragino Sans","Noto Sans JP",sans-serif; color:var(--fg); background:var(--bg); line-height:1.7; }}
h1 {{ font-size:1.4rem; margin:0 0 4px; }} h2 {{ font-size:1.05rem; margin:32px 0 8px; }}
.meta {{ color:var(--muted); font-size:.85rem; }}
table {{ border-collapse:collapse; width:100%; font-size:.9rem; }}
td, th {{ border-bottom:1px solid var(--line); padding:6px 8px; text-align:left; vertical-align:top; }}
th {{ color:var(--muted); font-weight:normal; }}
ul {{ padding-left:1.2em; font-size:.9rem; }} li {{ margin:6px 0; }}
.note {{ color:var(--muted); font-size:.8rem; margin-top:40px; border-top:1px solid var(--line); padding-top:12px; }}
</style></head><body>
<h1>2次元 Ising 模型の厳密解 — Λ と Fisher 零点の立場から</h1>
<p class="meta">版 {tex(commit)}・{tex(committed_at)}（直近の tick: {tex(agent)}）／このページの生成 {now}<br>
{tex(subject)}</p>

<p class="meta">証明本体（PDF・{tex(pages)} ページ）はローカルの
<code>structured-latex/build/document.pdf</code> を開いて読む。</p>

<h2>これから書くこと</h2>
<table><tr><th>章</th><th>内容</th></tr>
{rows}
</table>

<h2>済んだ範囲</h2>
<ul>{li(done)}</ul>

<h2>直近の前進</h2>
<ul>{li(bullets("前進の記録", 5))}</ul>

<h2>直近のレビュー</h2>
<ul>{li(bullets("レビュー記録", 3))}</ul>

<p class="note">自動ループ（1 時間ごと、Claude と Codex を交互）が tick のたびに作り直している。
進捗の正本はリポジトリの <code>docs/tasks/auto-loop-state.md</code>、証明の正本は
<code>structured-latex/content/</code> である。このページは今見るためのもので、恒久的なリンク先にはしない。</p>
</body></html>
""")
PY

out="$(/Users/masaori/git/masaori/artifacts/publish.py --src "$STAGE" --repo math --path "$SLUG" 2>&1)"
status=$?
printf '%s\n' "$out" >> "$LOG_FILE"
url="$(printf '%s\n' "$out" | grep -o 'https://[^ ]*/artifacts/math/'"$SLUG"'/' | tail -1)"

if [ "$status" -ne 0 ]; then
  log "NG: 公開に失敗した（版 ${commit}）"
  exit 1
fi
if [ -z "$url" ]; then
  log "NG: 公開はできたが URL を取れなかった（版 ${commit}）"
  exit 1
fi
if ! curl -sfI "$url" >/dev/null 2>&1; then
  log "NG: 公開した URL が読めない（版 ${commit}・$url）"
  exit 1
fi
log "OK: 公開した（版 ${commit}）→ $url"

# Slack へ URL を知らせる（ユーザー指示）。**同じ版で二度は送らない**
# （PDF の作り直し側からも呼ばれるため、素直に送ると同じ内容が重複する）。
NOTIFIED="$LOG_DIR/last-notified-commit"
if [ "$(cat "$NOTIFIED" 2>/dev/null || true)" != "$commit" ]; then
  message="2次元 Ising 模型（Λ の立場）の自動ループが前進した（版 ${commit}・直近の tick: ${agent}）。
${subject}
${url}"
  if curl -sS -X POST 'https://hooks.slack.com/triggers/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' \
      -H "Content-Type: application/json" \
      --data "$(jq -n --arg message "$message" --arg repository "$(basename "$REPO_DIR")" \
        '{message: $message, repository: $repository}')" >> "$LOG_FILE" 2>&1; then
    printf '%s' "$commit" > "$NOTIFIED"
  else
    log "NG: Slack への通知に失敗した（版 ${commit}）"
  fi
fi
