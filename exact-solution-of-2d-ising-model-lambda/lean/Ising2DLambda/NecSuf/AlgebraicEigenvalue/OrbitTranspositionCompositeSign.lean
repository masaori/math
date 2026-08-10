/-
主張「互換の反復合成の符号は `(-1)^k` である」の必要十分版。

具体版（`Ising2DLambda.AlgebraicEigenvalue.OrbitTranspositionCompositeSign`）の証明は、
準備 2 つ（反復が基点と相異なること・互換の符号が `-1` であること）と、この段の帰納法から成る。
準備の 2 つはどちらも既に示した主張（`claim_row_shift_iterate_distinct_below_period` と
`claim_orbit_transposition_sign`）であり、この段が新しく行っているのは帰納法だけである。
そこで必要十分版は、その帰納法が何を要求しているかだけを述べる。

  使っている性質                なぜ削れないか
  `h0`                          帰納法の出発点（`Ψ₀ = id_O` の符号が `1` であること）。
  `hstep`                       帰納法の一歩（符号の乗法性と互換の符号 `-1` を当てた結果、
                                値が `u` 倍になること）。上界 `n` より下でだけ要求する。
                                人手証明の上界 `k < e(τ₀)` はここに入る。
  `Monoid M`                    `u ^ k` を書くための積と単位元。

削れたもの: 行配位、巡回シフト、軌道、最小周期、互換であること、順序 `≺`、
値が `ℤ` であること、`u = -1` であること（`u * u = 1` すら使わない）、積の可換性、
台の有限性。すなわちこの段は**符号についての言明ですらなく**、
「1 から始めて毎回 `u` を掛ける列の第 `k` 項は `u ^ k` である」という言明でしかない。

住処: ここに ℝ / ℂ は現れない（現れるのは番号（ℕ）とモノイドの元だけである）。
-/
import Mathlib.Algebra.Group.Defs

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- 人手証明の帰納法の必要十分版。出発点が `1` で、上界より下では一歩ごとに `u` 倍になる列は、
第 `k` 項が `u ^ k` である。 -/
theorem value_of_iterated_step {M : Type*} [Monoid M] (w : ℕ → M) (u : M) (n : ℕ)
    (h0 : w 0 = 1) (hstep : ∀ k : ℕ, k + 1 < n → w (k + 1) = u * w k) :
    ∀ k : ℕ, k < n → w k = u ^ k := by
  intro k
  induction k with
  | zero =>
      intro _
      rw [h0, pow_zero]
  | succ k ih =>
      intro hk
      have hkk : k < n := by omega
      rw [hstep k hk, ih hkk, pow_succ']

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
