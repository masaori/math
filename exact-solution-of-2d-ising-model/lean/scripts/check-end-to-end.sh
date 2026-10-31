#!/usr/bin/env bash
# 厳密解が、具体的な分配関数から閉形式まで仮定なしで通しに証明されていることを確かめる。
#
# 使い方:
#   cd exact-solution-of-2d-ising-model/lean && lake build && ./scripts/check-end-to-end.sh
#
# 主張の形はこのスクリプトが固定する。Lean 側の定理 `Ising2D.onsager_exact_solution_end_to_end` が
# 下の型をそのまま持ち、結合定数の正値性以外の仮定を取らず、sorryAx に依存しないときだけ exit 0。
# 主張を弱めて通すことを防ぐため、型は Ising2D の定義（分配関数 `partitionFunction`、
# 双対結合定数 `Kstar`）と mathlib の関数だけで書き、`gammaFn` のような途中の定義を経由しない。
set -euo pipefail

cd "$(dirname "$0")/.."

if ! command -v lake >/dev/null 2>&1; then
  if [ -x "$HOME/.elan/bin/lake" ]; then
    PATH="$HOME/.elan/bin:$PATH"
    export PATH
  else
    echo "NG: lake が見つからない（elan を導入し PATH を通すこと）" >&2
    exit 1
  fi
fi

out=$(lake env lean --stdin 2>&1 <<'EOF'
import Ising2D

open Filter
open scoped Topology

/-- 2 次元 Ising 模型の厳密解（Onsager の自由エネルギー）。
`partitionFunction N M K1 K2` は周期境界条件をもつ N 行 M 列の格子の分配関数。 -/
example (K1 K2 : ℝ) (hK1 : 0 < K1) (hK2 : 0 < K2) :
    ∃ f : ℕ → ℝ,
      (∀ M : ℕ, 2 ≤ M →
        Tendsto (fun N : ℕ => 1 / ((M : ℝ) * N) * Real.log (Ising2D.partitionFunction N M K1 K2))
          atTop (𝓝 (f M)))
      ∧ Tendsto f atTop
          (𝓝 (1 / 2 * Real.log (2 * Real.sinh (2 * K2))
            + 1 / (4 * Real.pi) * ∫ θ in (0 : ℝ)..(2 * Real.pi),
                Real.arcosh (Real.cosh (2 * K1) * Real.cosh (2 * Ising2D.Kstar K2)
                  - Real.sinh (2 * K1) * Real.sinh (2 * Ising2D.Kstar K2) * Real.cos θ))) :=
  Ising2D.onsager_exact_solution_end_to_end K1 K2 hK1 hK2

#print axioms Ising2D.onsager_exact_solution_end_to_end
EOF
) || { echo "$out"; echo "NG: 通しの定理が無いか、主張の型が一致しない" >&2; exit 1; }

echo "$out"
if echo "$out" | grep -q "error"; then
  echo "NG: 通しの定理が無いか、主張の型が一致しない" >&2
  exit 1
fi
if echo "$out" | grep -q "sorryAx"; then
  echo "NG: 通しの定理が sorry に依存している" >&2
  exit 1
fi
echo "OK: 分配関数から閉形式までが仮定なしで通しに証明されている"
