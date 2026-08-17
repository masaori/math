/-
「対称化した極限量に対して粗視化は必要でない」の Lean 具体版・$Z_L(q)\neq Z_L(1/q)$ への準備。

`eval_ne_eval_inv_of_nonneg_coeff` の三前提のうち第一（係数非負）を、
重複度列から作る多項式 `polyOfMultiplicity` について示す。
$i\le E$ では係数は $\Omega(i)\ge0$、$i>E$ では和の各項の係数が 0。
-/
import Ising3DCut.LimitQuantity.SymmetrizedReciprocalInvariantPolyOfMultiplicity

namespace Ising3DCut.LimitQuantity

open Polynomial

/-- 重複度列から作った多項式のすべての係数は非負。 -/
theorem coeff_polyOfMultiplicity_nonneg (E : ℕ) (Ω : ℕ → ℕ) (i : ℕ) :
    0 ≤ (polyOfMultiplicity E Ω).coeff i := by
  by_cases hi : i ≤ E
  · rw [coeff_polyOfMultiplicity_of_le hi]
    exact Nat.cast_nonneg _
  · unfold polyOfMultiplicity
    rw [finsetSum_coeff]
    apply Finset.sum_nonneg
    intro m _
    rw [coeff_C_mul_X_pow]
    split_ifs
    · exact Nat.cast_nonneg _
    · exact le_rfl

end Ising3DCut.LimitQuantity
