#!/usr/bin/env bash
# 論文構成再編の成果を公開物へ反映する。tick の成功時に呼ばれ、
# 論文本体 HTML と構成棚卸しページの両方を現行本文から作り直して公開する。
# 失敗時は別手段へ切り替えず、そのまま非 0 で終了する。
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
STRUCTURED_DIR="$PROJECT_DIR/structured-latex"
PUBLISH="$HOME/git/masaori/artifacts/publish.py"
STAGE_ROOT="$HOME/.artifact-uploads/math"

test -x "$PUBLISH"

# 専用 worktree には gitignore された node_modules が無い。lockfile が共有 checkout と
# 同一なら clone copy で持ち込み、異なるときだけ lockfile 準拠の install を行う。
MAIN_STRUCTURED="$HOME/git/masaori/math/exact-solution-of-2d-ising-model/structured-latex"
if [ ! -d "$STRUCTURED_DIR/node_modules" ]; then
  if [ -d "$MAIN_STRUCTURED/node_modules" ] && cmp -s "$STRUCTURED_DIR/pnpm-lock.yaml" "$MAIN_STRUCTURED/pnpm-lock.yaml"; then
    cp -Rc "$MAIN_STRUCTURED/node_modules" "$STRUCTURED_DIR/node_modules"
  else
    (cd "$STRUCTURED_DIR" && pnpm install --frozen-lockfile)
  fi
fi

(cd "$STRUCTURED_DIR" && npm run build:html && npm run build:organization-artifact)

publish_one() {
  slug="$1"
  src_file="$2"
  mkdir -p "$STAGE_ROOT/$slug"
  cp "$src_file" "$STAGE_ROOT/$slug/index.html"
  "$PUBLISH" --src "$STAGE_ROOT/$slug" --repo math --path "$slug"
}

publish_one complex-matrix-ising-paper "$STRUCTURED_DIR/build/document.html"
publish_one complex-matrix-ising-paper-organization "$STRUCTURED_DIR/build/paper-organization/index.html"
