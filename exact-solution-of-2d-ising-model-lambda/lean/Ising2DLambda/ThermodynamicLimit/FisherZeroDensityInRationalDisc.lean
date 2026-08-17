/-
章「熱力学極限」の「有理円板内の格子点数あたりの Fisher 零点数」（`def_fisher_zero_density_in_rational_disc`）と
「有理円板内の格子点数あたりの Fisher 零点数は 2 を超えない」（`claim_fisher_zero_density_in_rational_disc_le_two`）の具体版。

  人手証明                                                          このファイル
  ν_L(c,r) := N_L(c,r) / L^2 ∈ ℚ（L^2 ≠ 0）                        `fisherZeroDensityInRationalDisc`
  0 ≤ ν_L(c,r)（分子は自然数、分母は正）                            `fisherZeroDensityInRationalDisc_nonneg`
  ν_L = N_L/L^2 ≤ |F_L|/L^2 ≤ 2L^2/L^2 = 2（一続き四段）             `fisherZeroDensityInRationalDisc_le_two`

住処: ℚ。実数体・複素数体は現れない。
-/
import Ising2DLambda.ThermodynamicLimit.FisherZeroCountInRationalDisc

namespace Ising2DLambda.ThermodynamicLimit

open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.FisherZero

variable (L : ℕ) [NeZero L]

/-- `def_fisher_zero_density_in_rational_disc` の具体版: `ν_L(c,r) := N_L(c,r) / L^2 ∈ ℚ`。 -/
noncomputable def fisherZeroDensityInRationalDisc
    (data : RealClosedSubfieldData) (c : ℚ × ℚ) (r : {r : ℚ // 0 < r}) : ℚ :=
  (fisherZeroCountInRationalDisc L data c r : ℚ) / ((L : ℚ) ^ 2)

/-- 分母 `L^2` は `L ≥ 1` から正である。 -/
theorem lattice_size_sq_pos_rat : (0 : ℚ) < (L : ℚ) ^ 2 := by
  have hL : (0 : ℚ) < (L : ℚ) := by exact_mod_cast Nat.pos_of_ne_zero (NeZero.ne L)
  positivity

/-- `0 ≤ ν_L(c,r)`（分子は自然数、分母は正の自然数）。 -/
theorem fisherZeroDensityInRationalDisc_nonneg
    (data : RealClosedSubfieldData) (c : ℚ × ℚ) (r : {r : ℚ // 0 < r}) :
    0 ≤ fisherZeroDensityInRationalDisc L data c r :=
  div_nonneg (Nat.cast_nonneg _) (lattice_size_sq_pos_rat L).le

/-- `claim_fisher_zero_density_in_rational_disc_le_two` の具体版。人手証明の一続き四段と同じ順。 -/
theorem fisherZeroDensityInRationalDisc_le_two
    (data : RealClosedSubfieldData) (c : ℚ × ℚ) (r : {r : ℚ // 0 < r}) :
    fisherZeroDensityInRationalDisc L data c r ≤ 2 := by
  have hL2 : (0 : ℚ) < (L : ℚ) ^ 2 := lattice_size_sq_pos_rat L
  -- N_L ≤ |F_L|（`def_fisher_zero_count_in_rational_disc`）
  have hN : (fisherZeroCountInRationalDisc L data c r : ℚ) ≤ ((FisherZeroSet L).ncard : ℚ) := by
    exact_mod_cast fisherZeroCountInRationalDisc_le_ncard L data c r
  -- |F_L| ≤ 2 L^2（`claim_fisher_zero_set_finite_card_bound`）
  have hF : ((FisherZeroSet L).ncard : ℚ) ≤ 2 * (L : ℚ) ^ 2 := by
    exact_mod_cast (fisherZeroSet_finite_ncard_le L).2
  calc fisherZeroDensityInRationalDisc L data c r
      = (fisherZeroCountInRationalDisc L data c r : ℚ) / ((L : ℚ) ^ 2) := rfl
    _ ≤ ((FisherZeroSet L).ncard : ℚ) / ((L : ℚ) ^ 2) := div_le_div_of_nonneg_right hN hL2.le
    _ ≤ (2 * (L : ℚ) ^ 2) / ((L : ℚ) ^ 2) := div_le_div_of_nonneg_right hF hL2.le
    _ = 2 := mul_div_cancel_right₀ (2 : ℚ) hL2.ne'

end Ising2DLambda.ThermodynamicLimit
