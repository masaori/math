import Mathlib.Tactic

namespace Ising3DCut.LimitQuantity

/-- 箱の大きさに依存しない整除 `a ∣ 2 * (c - 1)` は、どの正の分子 `a` に対しても
底 `c` を選べば満たされる（人手証明 `claim_box_free_divisibility_excludes_no_rational_point`
と 1 対 1 に対応する具体版）。したがってこの整除だけからは `a = 1` は従わない。 -/
theorem box_free_divisibility_excludes_no_rational_point
    (a : ℤ) (ha : 0 < a) :
    ∃ c : ℤ, 1 ≤ c ∧ a ∣ 2 * (c - 1) := by
  refine ⟨a + 1, ?_, ?_⟩
  · -- `a` は正なので `1 ≤ a`、したがって `1 ≤ a + 1`
    have h1 : (1 : ℤ) ≤ a := ha
    linarith
  · -- `2 * ((a + 1) - 1) = 2 * a` であり、`a ∣ 2 * a`
    have hstep : 2 * ((a + 1) - 1) = 2 * a := by ring
    rw [hstep]
    exact Dvd.intro_left 2 rfl

end Ising3DCut.LimitQuantity
