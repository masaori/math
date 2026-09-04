#!/usr/bin/env bash
# 上流検算の読み込み方と、閉形式へ至る段取りの公開状態を機械で検査する。
#
# 二つのことを一度に確かめる。
#
# 一つ目は、下流の検算が上流の「assertion まで」読み直していないこと。以前は
# check.sage が上流の check.sage を読んでいたため、弧署名の検算を一本走らせるだけで
# 先行 36 本の assertion が毎回再実行され、読み込みだけで 13 分かかっていた
# （実測 2026-09-05。自動ループの tick は 2700 秒で打ち切られ、exit 124 になった）。
# いまは各ディレクトリを construction.sage（再利用する厳密構成）と check.sage
# （観測の出力と assertion）に分け、下流は construction.sage だけを読む。
# **先行検算を握り潰したわけではない**（日次監査は check.sage を全数で回す）ので、
# ここではその二つ——下流が構成だけを読むことと、check.sage が全数残っていること——を
# どちらも検査する。
#
# 二つ目は、有限符号恒等式から Onsager 積分までの段取りが、証明の正本（構造化テキスト）と
# 公開している論文 HTML の両方から読めること。段取りが実装のログにしか無いと、
# 人間は「いまどこにいるのか」を成果物から読めない。
#
#   bash scripts/verify-upstream-load-and-roadmap.sh              # 正本だけを検査
#   bash scripts/verify-upstream-load-and-roadmap.sh --published  # 公開 HTML も検査
#   bash scripts/verify-upstream-load-and-roadmap.sh --run        # 対象検算を実際に走らせて時間を測る
set -uo pipefail

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
cd "$PROJECT_DIR"

TARGET_CHECK="sagemath/check/parity-identity-simple-cycle-arc-interior-membership/check.sage"
PUBLISHED_URL="https://hexcomp-artifacts.web.app/math/ising-lambda/"
# tick の締切は 2700 秒で、まとめに 600 秒を残す。対象検算はその内側で終わること。
RUN_LIMIT_SECONDS="${RUN_LIMIT_SECONDS:-1800}"

check_published=0
run_target=0
for arg in "$@"; do
  case "$arg" in
    --published) check_published=1 ;;
    --run) run_target=1 ;;
    *) echo "不明な引数: $arg" >&2; exit 2 ;;
  esac
done

failures=0
fail() { printf 'NG: %s\n' "$1"; failures=$((failures + 1)); }
ok() { printf 'OK: %s\n' "$1"; }

# --- 読み込み連鎖と、構成／assertion の分離 -------------------------------------

if python3 sagemath/tools/verify-construction-separation.py "$PROJECT_DIR" "$TARGET_CHECK"; then
  ok "対象検算は上流の構成だけを読み、構成に assertion が無い"
else
  fail "読み込み連鎖または構成／assertion の分離が壊れている"
fi

# --- 先行検算を握り潰していないこと ---------------------------------------------

chain_dirs="$(python3 - "$TARGET_CHECK" <<'PYTHON'
import os, re, sys
seen, stack = [], [sys.argv[1]]
while stack:
    path = stack.pop()
    if path in seen:
        continue
    seen.append(path)
    stack.extend(re.findall(r'load\("([^"]+)"\)', open(path, encoding="utf-8").read()))
print("\n".join(sorted({os.path.dirname(p) for p in seen})))
PYTHON
)"

missing_checks=0
while IFS= read -r dir; do
  [ -n "$dir" ] || continue
  [ -f "$dir/check.sage" ] || { fail "先行検算の check.sage が消えている: $dir"; missing_checks=1; }
done <<< "$chain_dirs"
[ "$missing_checks" -eq 0 ] && ok "連鎖に現れる全ディレクトリに check.sage が残っている（日次監査が全数を回す）"

if grep -q 'check.sage' scripts/audit-loop.sh; then
  ok "日次監査は check.sage を全数で回す設定のままである"
else
  fail "日次監査が check.sage を回さなくなっている（先行検算の握り潰し）"
fi

# --- 段取りが正本と公開物から読めること -----------------------------------------

STAGES=(
  "有限符号恒等式"
  "四つの有限トーラス行列式"
  "有限 Fourier 分解"
  "熱力学極限"
  "Onsager 積分"
)

source_missing=0
for stage in "${STAGES[@]}"; do
  grep -q "$stage" structured-latex/content/main-text.ts || {
    fail "段取りの段が証明の正本に無い: $stage"; source_missing=1; }
done
[ "$source_missing" -eq 0 ] && ok "五つの段が構造化テキストの本文にある"

if [ "$check_published" -eq 1 ]; then
  html="$(mktemp)"
  if curl -fsS "$PUBLISHED_URL" -o "$html"; then
    published_missing=0
    for stage in "${STAGES[@]}"; do
      grep -q "$stage" "$html" || {
        fail "段取りの段が公開している論文に無い: $stage"; published_missing=1; }
    done
    [ "$published_missing" -eq 0 ] && ok "五つの段が公開している論文 HTML にある（${PUBLISHED_URL}）"
  else
    fail "公開している論文 HTML を取得できない: $PUBLISHED_URL"
  fi
  rm -f "$html"
fi

# --- 対象検算が tick の内側で終わること -----------------------------------------

if [ "$run_target" -eq 1 ]; then
  if command -v sage >/dev/null 2>&1; then
    started="$(date +%s)"
    if timeout "$RUN_LIMIT_SECONDS" sage "$TARGET_CHECK" > /dev/null 2>&1; then
      elapsed=$(( $(date +%s) - started ))
      ok "対象検算は ${elapsed} 秒で完了した（上限 ${RUN_LIMIT_SECONDS} 秒）"
    else
      status=$?
      if [ "$status" -eq 124 ]; then
        fail "対象検算が上限 ${RUN_LIMIT_SECONDS} 秒で打ち切られた"
      else
        fail "対象検算が失敗した（終了コード $status）"
      fi
    fi
  else
    fail "sage が PATH に無いので対象検算を走らせられない"
  fi
fi

if [ "$failures" -eq 0 ]; then
  echo "PASS: 上流の読み込み方と段取りの公開状態はどちらも要求どおりである"
  exit 0
fi
echo "FAIL: $failures 件"
exit 1
