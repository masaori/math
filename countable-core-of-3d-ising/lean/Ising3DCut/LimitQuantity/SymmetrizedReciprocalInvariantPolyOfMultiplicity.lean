/-
「対称化した列は q↔1/q で不変である（有限箱の等式）」の Lean 具体版へ向けた橋渡し（続き）。
本文の $Z_L$ は重複度列 $\Omega(m)$（`multiplicity`）から $\sum_{m\le E}\Omega(m)\,q^m$ と定まる。
ここでは一般の列 `Ω : ℕ → ℕ` と辺数 `E` からその多項式を作り、係数が `Ω i`（`i ≤ E`）で
あることと、`Ω` の回文性（`multiplicity_palindrome` の形）から `reflect E f = f` を導く。
-/
import Mathlib.Algebra.Polynomial.Reverse
import Mathlib.Algebra.Polynomial.Coeff
import Ising3DCut.LimitQuantity.SymmetrizedReciprocalInvariantReflectOfCoeff

namespace Ising3DCut.LimitQuantity

open Polynomial

/-- 重複度列 `Ω` と辺数 `E` から定まる多項式 $\sum_{m\le E}\Omega(m)\,X^m$。 -/
noncomputable def polyOfMultiplicity (E : ℕ) (Ω : ℕ → ℕ) : ℚ[X] :=
  ∑ m ∈ Finset.range (E + 1), C (Ω m : ℚ) * X ^ m

theorem coeff_polyOfMultiplicity_of_le {E : ℕ} {Ω : ℕ → ℕ} {i : ℕ} (hi : i ≤ E) :
    (polyOfMultiplicity E Ω).coeff i = (Ω i : ℚ) := by
  unfold polyOfMultiplicity
  rw [finsetSum_coeff]
  simp only [coeff_C_mul_X_pow]
  rw [Finset.sum_eq_single i]
  · simp
  · intro b _ hb
    simp [Ne.symm hb]
  · intro h
    exact absurd (Finset.mem_range.mpr (Nat.lt_succ_of_le hi)) h

/-- `Ω` が `E` について回文なら、対応する多項式は `reflect E` で不変。 -/
theorem reflect_polyOfMultiplicity_eq {E : ℕ} {Ω : ℕ → ℕ}
    (hpal : ∀ m, m ≤ E → Ω m = Ω (E - m)) :
    reflect E (polyOfMultiplicity E Ω) = polyOfMultiplicity E Ω := by
  apply reflect_eq_of_coeff_palindrome
  intro i hi
  rw [coeff_polyOfMultiplicity_of_le hi,
    coeff_polyOfMultiplicity_of_le (Nat.sub_le E i), hpal i hi]

end Ising3DCut.LimitQuantity
