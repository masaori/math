#!/usr/bin/env bash
# 具体版と必要十分版の分離の検査。本体はリポジトリ直下の scripts/lean-concrete-necsuf-separation/ にあり、
# 全てのプロジェクトが同じ検査を使う。台帳はこのディレクトリの concrete-necsuf-separation-ledger.txt。
set -euo pipefail
lean_dir="$(cd "$(dirname "$0")/.." && pwd)"
exec bash "$lean_dir/../../scripts/lean-concrete-necsuf-separation/check.sh" "$lean_dir"
