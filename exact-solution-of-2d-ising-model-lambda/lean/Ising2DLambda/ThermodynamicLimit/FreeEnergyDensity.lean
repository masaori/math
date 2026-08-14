/-
人手証明「自由エネルギー密度と極限の言明の定式化」の具体版。

有限系の実自由エントロピーを実数倍するため ℝ に留まり、極限の言明には実数の順序を使う。
完備性については、後続の存在証明で使う上限の存在という形だけをここで宣言する。
-/
import Mathlib.Algebra.Order.Archimedean.Real.Basic
import Ising2DLambda.ThermodynamicLimit.FiniteRealFreeEntropy

namespace Ising2DLambda.ThermodynamicLimit

/-- 人手証明の正の格子サイズ `L ∈ ℕ, L ≥ 1`。 -/
abbrev PositiveNatural := {L : ℕ // 0 < L}

/-- `def_free_energy_density`。有理数 `1 / L²` を ℝ へ移してから掛ける。 -/
noncomputable def freeEnergyDensity (L : PositiveNatural)
    (t : StrictlyPositiveReal) : ℝ :=
  letI : NeZero L.1 := ⟨Nat.ne_of_gt L.2⟩
  (((1 / ((L.1 : ℚ) ^ 2) : ℚ) : ℝ) * finiteRealFreeEntropy L.1 t)

/-- `def_free_energy_density_limit_statement`。絶対値を使わず二つの不等式で定める。 -/
def IsFreeEnergyDensityLimit (t : StrictlyPositiveReal) (f : ℝ) : Prop :=
  ∀ eps : StrictlyPositiveReal, ∃ N : ℕ, 1 ≤ N ∧
    ∀ L : PositiveNatural, N ≤ L.1 →
      -eps.1 < freeEnergyDensity L t - f ∧ freeEnergyDensity L t - f < eps.1

/-- `remark_real_completeness_escape`。空でない上に有界な実数集合は上限を持つ。 -/
theorem real_nonempty_bddAbove_has_supremum (S : Set ℝ)
    (hne : S.Nonempty) (hbdd : BddAbove S) : ∃ s : ℝ, IsLUB S s := by
  exact Real.exists_isLUB hne hbdd

end Ising2DLambda.ThermodynamicLimit
