#!/usr/bin/env bash
# 作業ツリーにまだビルド済みの成果物（.lake/build）が無いとき、同じマシンの別の作業ツリーで
# 最も新しくビルドされた .lake/build を写す。use-shared-dependencies.sh の後、lake build の前に打つ。
#
# 使い方:
#   cd exact-solution-of-2d-ising-model-lambda/lean && bash scripts/use-shared-dependencies.sh \
#     && bash scripts/seed-build-from-other-worktrees.sh && lake build
#
# lake は各モジュールの入力のハッシュ（.trace）が一致するときだけ成果物を使い、一致しなければ
# 作り直す。写した成果物が別のコミットのものでも、変わったモジュールとその下流だけが作り直される。
# 写し元が写している最中にビルドしていると、.olean が書きかけで、.trace が前のビルドのまま残る
# ことがある。.trace より新しい成果物を持つモジュールは .trace ごと消し、lake に作り直させる。
#
# 写し元は ~/git/masaori/math と ~/git/masaori/math.runs/*/ の同じプロジェクトの lean/.lake/build。
# 依存ディレクトリと違い symlink にしない（片方のビルドがもう片方の成果物を書き換えるため）。
#
# 終了コード 0 = 写した、または写す必要が無い、または写し元が無い（lake build が一から作る）。
set -euo pipefail

cd "$(dirname "$0")/.."
here="$(pwd -P)"
built=".lake/build/lib/lean/Ising2DLambda"

if [ -d "$built" ]; then
  echo "OK: .lake/build は既に在る（写さない）"
  exit 0
fi

best=""
best_time=0
for candidate in "$HOME"/git/masaori/math/exact-solution-of-2d-ising-model-lambda/lean \
                 "$HOME"/git/masaori/math.runs/*/exact-solution-of-2d-ising-model-lambda/lean; do
  [ -d "$candidate/$built" ] || continue
  [ "$(cd "$candidate" && pwd -P)" = "$here" ] && continue
  t="$(stat -c %Y "$candidate/$built")"
  if [ "$t" -gt "$best_time" ]; then
    best="$candidate"
    best_time="$t"
  fi
done

if [ -z "$best" ]; then
  echo "OK: 写し元が無い（lake build が一から作る）"
  exit 0
fi

tmp=".lake/build.seed.$$"
rm -rf "$tmp"
mkdir -p .lake
# 写し元の作業ツリーが途中で消えても、写せたファイルだけで続ける（足りない分は lake が作る）。
cp -a "$best/.lake/build" "$tmp" 2>/dev/null || true
rm -rf .lake/build
mv "$tmp" .lake/build

# .trace より新しい成果物を持つモジュールは、書きかけの恐れがあるので .trace を消す。
removed=0
while IFS= read -r -d '' trace; do
  base="${trace%.trace}"
  for artifact in "$base".olean "$base".ilean "$base".c "$base".o; do
    if [ -e "$artifact" ] && [ "$artifact" -nt "$trace" ]; then
      rm -f "$trace"
      removed=$((removed + 1))
      break
    fi
  done
done < <(find .lake/build -name '*.trace' -print0)

echo "OK: $best から .lake/build を写した（書きかけの恐れで作り直させるモジュール $removed 件）"
