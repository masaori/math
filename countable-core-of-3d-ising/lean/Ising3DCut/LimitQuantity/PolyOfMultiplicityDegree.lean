/-
「対称化した極限量に対して粗視化は必要でない」の Lean 具体版・$Z_L(q)\neq Z_L(1/q)$ への準備。

`eval_ne_eval_inv_of_nonneg_coeff` の三前提のうち残る二つ（次数 $\ge1$、最高次係数 $>0$）を、
重複度列から作る多項式 `polyOfMultiplicity` について、$\Omega(E)\ge1$ と $E\ge1$ の仮定の下で示す。
$i>E$ では係数 0、$i=E$ では係数 $\Omega(E)\neq0$ なので次数はちょうど $E$。
-/
import Ising3DCut.LimitQuantity.SymmetrizedReciprocalInvariantPolyOfMultiplicity

namespace Ising3DCut.LimitQuantity

open Polynomial

/-- $i>E$ では係数 0。 -/
theorem coeff_polyOfMultiplicity_of_gt {E : ℕ} {Ω : ℕ → ℕ} {i : ℕ} (hi : E < i) :
    (polyOfMultiplicity E Ω).coeff i = 0 := by
  unfold polyOfMultiplicity
  rw [finsetSum_coeff]
  apply Finset.sum_eq_zero
  intro m hm
  rw [coeff_C_mul_X_pow]
  have : i ≠ m := by
    intro h; subst h
    exact absurd (Finset.mem_range.mp hm) (not_lt.mpr hi)
  simp [this]

/-- $\Omega(E)\neq0$ なら次数はちょうど $E$。 -/
theorem natDegree_polyOfMultiplicity {E : ℕ} {Ω : ℕ → ℕ} (h : Ω E ≠ 0) :
    (polyOfMultiplicity E Ω).natDegree = E := by
  apply natDegree_eq_of_le_of_coeff_ne_zero
  · rw [natDegree_le_iff_coeff_eq_zero]
    intro N hN
    exact coeff_polyOfMultiplicity_of_gt hN
  · rw [coeff_polyOfMultiplicity_of_le le_rfl]
    exact_mod_cast h

/-- 第二前提：$E\ge1$、$\Omega(E)\neq0$ なら次数 $\ge1$。 -/
theorem one_le_natDegree_polyOfMultiplicity {E : ℕ} {Ω : ℕ → ℕ} (hE : 1 ≤ E) (h : Ω E ≠ 0) :
    1 ≤ (polyOfMultiplicity E Ω).natDegree := by
  rw [natDegree_polyOfMultiplicity h]; exact hE

/-- 第三前提：$\Omega(E)\neq0$ なら最高次係数 $\Omega(E)>0$。 -/
theorem leadingCoeff_polyOfMultiplicity_pos {E : ℕ} {Ω : ℕ → ℕ} (h : Ω E ≠ 0) :
    0 < (polyOfMultiplicity E Ω).leadingCoeff := by
  rw [leadingCoeff, natDegree_polyOfMultiplicity h, coeff_polyOfMultiplicity_of_le le_rfl]
  exact_mod_cast Nat.pos_of_ne_zero h

end Ising3DCut.LimitQuantity
