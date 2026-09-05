#!/usr/bin/env bash
# 公開してよい版かどうかを判定する。公開する側はこれを通ってからビルドする。
#
# 出力の版行は `git status --porcelain` が空でなければ「+（未コミットの変更を含む）」を付ける。
# 未追跡ファイルも数えるのは正しい: 本文は content/ をディレクトリ走査で読むので、
# 追跡されていないファイルが 1 つあるだけで出力が変わりうる。
#
# 問題は、その印が付いた HTML をそのまま公開できてしまうことだった。公開物の版が
# 「a1999f79a+」のように dirty だと、その HTML をどのコミットから作り直せるのか誰にも分からない
# （実測 2026-09-05: 手元の作業用ディレクトリが未追跡のまま残っていて dirty 印が付いた）。
#
# そこで印を隠すのではなく、**dirty なら公開しない**。加えて HEAD が remote default branch に
# 含まれることも確かめる。これで公開物の版は必ず「remote default に入っているクリーンな
# コミット」になり、そこから同じものを作り直せる。
#
#   bash scripts/require-publishable-version.sh <リポジトリのパス> [--no-fetch]
#
# 通れば終了コード 0 で短い版を標準出力へ出す。通らなければ理由を出して 1 を返す。
set -uo pipefail

repo_dir="${1:-}"
if [ -z "$repo_dir" ]; then
  echo "使い方: $0 <リポジトリのパス> [--no-fetch]" >&2
  exit 2
fi
do_fetch=1
[ "${2:-}" = "--no-fetch" ] && do_fetch=0

commit="$(git -C "$repo_dir" rev-parse --short HEAD 2>/dev/null)"
if [ -z "$commit" ]; then
  echo "NG: git リポジトリではない: $repo_dir" >&2
  exit 1
fi

dirty="$(git -C "$repo_dir" status --porcelain)"
if [ -n "$dirty" ]; then
  echo "NG: 作業ツリーが汚れているので公開しない（版 ${commit}+）" >&2
  printf '%s\n' "$dirty" >&2
  exit 1
fi

if [ "$do_fetch" -eq 1 ]; then
  if ! git -C "$repo_dir" fetch --quiet origin; then
    echo "NG: origin を fetch できないので、公開版が remote default に含まれるか確かめられない" >&2
    exit 1
  fi
fi

# remote default branch はリポジトリごとに違う。origin/main と決め打ちしない。
default_ref="$(git -C "$repo_dir" symbolic-ref --quiet refs/remotes/origin/HEAD || true)"
if [ -z "$default_ref" ]; then
  default_branch="$(git -C "$repo_dir" remote show origin 2>/dev/null \
    | awk '/HEAD branch/ {print $NF}')"
  [ -n "$default_branch" ] && default_ref="refs/remotes/origin/$default_branch"
fi
if [ -z "$default_ref" ]; then
  echo "NG: remote default branch を特定できない" >&2
  exit 1
fi

if ! git -C "$repo_dir" merge-base --is-ancestor HEAD "$default_ref"; then
  echo "NG: 版 ${commit} が ${default_ref#refs/remotes/} に含まれていない。先にマージすること" >&2
  exit 1
fi

printf '%s\n' "$commit"
