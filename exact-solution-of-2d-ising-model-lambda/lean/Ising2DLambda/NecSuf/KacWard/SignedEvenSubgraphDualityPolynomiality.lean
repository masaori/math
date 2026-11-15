import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

/-! The degree bound is the only property of the coefficient family needed here. -/

/-- Clearing the denominator of each term of a bounded polynomial substitution. -/
theorem duality_polynomiality_terms {K : Type*} [Field K]
    (n : ℕ) (c : ℕ → K) (x : K) (hx : 1 + x ≠ 0) :
    (1 + x) ^ n *
      (∑ j ∈ Finset.range (n + 1), c j * ((1 - x) / (1 + x)) ^ j) =
      ∑ j ∈ Finset.range (n + 1), c j * (1 - x) ^ j * (1 + x) ^ (n - j) := by
  rw [Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro j hj
  have hjle : j ≤ n := Nat.le_of_lt_succ (Finset.mem_range.mp hj)
  rw [div_pow, div_eq_mul_inv]
  have hpow : (1 + x) ^ n * ((1 + x) ^ j)⁻¹ = (1 + x) ^ (n - j) := by
    conv_lhs => rw [← Nat.sub_add_cancel hjle, pow_add]
    simp [pow_ne_zero j hx]
  calc
    (1 + x) ^ n * (c j * ((1 - x) ^ j * ((1 + x) ^ j)⁻¹))
        = c j * (1 - x) ^ j * ((1 + x) ^ n * ((1 + x) ^ j)⁻¹) := by ring
    _ = c j * (1 - x) ^ j * (1 + x) ^ (n - j) := by rw [hpow]

/-- The finite coefficient expression has an explicit polynomial representative. -/
noncomputable def denominatorCleared {K : Type*} [Field K] (n : ℕ) (p : Polynomial K) :
    Polynomial K :=
  ∑ j ∈ Finset.range (n + 1), Polynomial.C (p.coeff j) *
    (1 - Polynomial.X) ^ j * (1 + Polynomial.X) ^ (n - j)

theorem eval_denominatorCleared {K : Type*} [Field K]
    (n : ℕ) (p : Polynomial K) (hn : p.natDegree ≤ n)
    (x : K) (hx : 1 + x ≠ 0) :
    (denominatorCleared n p).eval x =
      (1 + x) ^ n * p.eval ((1 - x) / (1 + x)) := by
  rw [denominatorCleared, Polynomial.eval_finsetSum]
  simp only [Polynomial.eval_mul, Polynomial.eval_pow, Polynomial.eval_add,
    Polynomial.eval_sub, Polynomial.eval_one, Polynomial.eval_X, Polynomial.eval_C]
  rw [Polynomial.eval_eq_sum_range' (Nat.lt_succ_of_le hn)]
  exact (duality_polynomiality_terms n p.coeff x hx).symm
