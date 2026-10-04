#!/usr/bin/env bash
# Lean の依存（mathlib を含む .lake/packages）を、作業ツリーの外に 1 つだけ置いた共有の
# ディレクトリから使う。lake build の前に毎回打つ。
#
# 使い方:
#   cd exact-solution-of-2d-ising-model-lambda/lean && bash scripts/use-shared-dependencies.sh
#   以後は通常どおり lake build する。lake update・lake exe cache get は打たない。
#
# 作業ツリーの .lake/packages を、共有のディレクトリへの symlink にする。共有のディレクトリは
# lean-toolchain と lake-manifest.json の中身のハッシュで分けるので、どちらかが変われば別の
# ディレクトリを一から作り、古い依存のままビルドすることはない。
#
# 作り終えた共有のディレクトリは書き込み禁止にする。依存が揃っていれば lake build は依存へ
# 書き込まないので、同時に動く作業ツリーどうしが壊し合わない。依存を書き換える lake update は
# 権限で失敗する（lake exe cache get は、揃っている依存に対しては何も書かずに終わる）。
# mathlib の版を上げるときは、.lake/packages の symlink を消してから lake update し、
# lake-manifest.json をコミットしたあとでこのスクリプトを打ち直す（新しい鍵の共有のディレクトリが
# 作られる）。
#
# 終了コード 0 = .lake/packages が共有のディレクトリを指している。それ以外 = 失敗。
set -euo pipefail

cd "$(dirname "$0")/.."

# lake は elan 経由で入るため、非対話シェルの PATH に無いことがある。
if ! command -v lake >/dev/null 2>&1; then
  if [ -x "$HOME/.elan/bin/lake" ]; then
    PATH="$HOME/.elan/bin:$PATH"
    export PATH
  else
    echo "NG: lake が見つからない（elan を導入し PATH を通すこと）" >&2
    exit 1
  fi
fi

store="${XDG_CACHE_HOME:-$HOME/.cache}/masaori-math/ising2d-lambda-lake-packages"
key="$(cat lean-toolchain lake-manifest.json | sha256sum | cut -c1-16)"
shared="$store/$key"
packages="$shared/packages"
mkdir -p "$store" .lake

point_packages_to_shared() {
  if [ -L .lake/packages ] && [ "$(readlink .lake/packages)" = "$packages" ]; then
    return
  fi
  if [ -L .lake/packages ]; then
    rm .lake/packages
  elif [ -e .lake/packages ]; then
    # この作業ツリーだけが持っていた依存。共有のディレクトリへ切り替えるので要らない。
    echo "この作業ツリーの .lake/packages（共有でない依存）を消して、共有のディレクトリへ切り替える" >&2
    rm -rf .lake/packages
  fi
  ln -s "$packages" .lake/packages
}

# 同じ鍵を作っている作業ツリーが他に居れば、作り終えるまで待つ。
exec 9>"$shared.lock"
flock 9

if [ ! -e "$shared/ready" ]; then
  # 作りかけ（前回が途中で止まった）が残っていれば消してから作り直す。
  if [ -e "$shared" ]; then
    chmod -R u+w "${shared:?}"
    rm -rf "${shared:?}"
  fi
  mkdir -p "$packages"
  touch "$shared/last-used"
  point_packages_to_shared
  echo "共有のディレクトリ $shared を作る（依存の取得と mathlib のビルド済み olean の展開）" >&2
  lake exe cache get
  # lake build が依存の側で行う処理（ビルド済みでない対象の生成、配布物の取得）を、書き込める
  # いまのうちに済ませる。書き込み禁止にしたあとに必要になると、lake build が権限で落ちる。
  lake build Mathlib
  chmod -R a-w "$packages"
  touch "$shared/ready"
fi

touch "$shared/last-used"
point_packages_to_shared
flock -u 9

# 24 時間使われていない鍵の共有のディレクトリを消す（mathlib の版を上げると古い鍵が残るため）。
# 使い始めに last-used を更新し、定期実行の 1 回は既定で 6 時間で打ち切られるので、
# 定期実行が使っている最中の鍵は消えない。作っている最中の鍵はロックが取れないので消さない。
# 使い始めの更新とすれ違わないよう、使われた時刻はロックを取ってから見る。
shopt -s nullglob
for other in "$store"/*/; do
  other="${other%/}"
  [ "$other" = "$shared" ] && continue
  exec 8>"$other.lock"
  if flock -n 8; then
    if [ ! -e "$other/last-used" ] || [ -n "$(find "$other/last-used" -mmin +1440)" ]; then
      echo "24 時間使われていない共有のディレクトリ $other を消す" >&2
      chmod -R u+w "${other:?}"
      rm -rf "${other:?}"
    fi
    flock -u 8
  fi
  exec 8>&-
done

echo "OK: .lake/packages -> $packages"
