/-
「一次因子は消去できる」の必要十分版。

本文と同じく、係数を上の番号から下へ辿る帰納法を行う。必要なのは環の加法の逆元と、一次因子との積の係数計算だけである。
積の可換性・体・代数閉性は要らない。一次式の引き算のため環を残す。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Polynomial
open scoped BigOperators

/-- 環上でも、一次因子との積は係数を上から復元できるので消去できる。 -/
theorem poly_linear_factor_cancellation_necSuf {R : Type*} [Ring R]
    (w : R) (A B : R[X]) (n : ℕ)
    (hA : ∀ k, n < k → A.coeff k = 0)
    (hB : ∀ k, n < k → B.coeff k = 0)
    (hmul : (X - C w) * A = (X - C w) * B) : A = B := by
  -- 本文の準備: 一次式の係数三本と、積の係数を五段で求める。
  have hzero : (Polynomial.X - Polynomial.C w).coeff 0 = -w := by
    calc
      (Polynomial.X - Polynomial.C w).coeff 0 = (Polynomial.X : R[X]).coeff 0 - (Polynomial.C w).coeff 0 := coeff_sub _ _ _
      _ = 0 - w := by simp only [coeff_X_zero, coeff_C_zero]
      _ = -w := zero_sub w
  have hone : (Polynomial.X - Polynomial.C w).coeff 1 = 1 := by
    calc
      (Polynomial.X - Polynomial.C w).coeff 1 = (Polynomial.X : R[X]).coeff 1 - (Polynomial.C w).coeff 1 := coeff_sub _ _ _
      _ = 1 - 0 := by simp only [coeff_X_one, coeff_C_succ]
      _ = 1 := sub_zero 1
  have hhigher (i : ℕ) (hi : 2 ≤ i) : (Polynomial.X - Polynomial.C w).coeff i = 0 := by
    calc
      (Polynomial.X - Polynomial.C w).coeff i = (Polynomial.X : R[X]).coeff i - (Polynomial.C w).coeff i := coeff_sub _ _ _
      _ = 0 - 0 := by
        rw [coeff_X_of_ne_one (by omega)]
        rw [coeff_C_of_ne_zero (by omega)]
      _ = 0 := sub_self 0
  have hproduct (P : R[X]) (m : ℕ) :
      ((Polynomial.X - Polynomial.C w) * P).coeff (m + 1) = P.coeff m + (-w) * P.coeff (m + 1) := by
    let f : ℕ → R := fun i => (Polynomial.X - Polynomial.C w).coeff i * P.coeff (m + 1 - i)
    have hsplit : (∑ i ∈ Finset.range (m + 1 + 1), f i) =
        f 0 + f 1 + ∑ i ∈ Finset.Ico 2 (m + 1 + 1), f i := by
      rw [← Finset.sum_range_add_sum_Ico f (by omega : 2 ≤ m + 1 + 1)]
      simp only [Finset.sum_range_succ, Finset.sum_range_zero, zero_add]
    calc
      ((Polynomial.X - Polynomial.C w) * P).coeff (m + 1)
          = ∑ i ∈ Finset.range (m + 1 + 1), (Polynomial.X - Polynomial.C w).coeff i * P.coeff (m + 1 - i) := by
            rw [coeff_mul, Finset.Nat.sum_antidiagonal_eq_sum_range_succ_mk]
      _ = (Polynomial.X - Polynomial.C w).coeff 0 * P.coeff (m + 1) + (Polynomial.X - Polynomial.C w).coeff 1 * P.coeff m +
          ∑ i ∈ Finset.Ico 2 (m + 1 + 1), (Polynomial.X - Polynomial.C w).coeff i * P.coeff (m + 1 - i) := by
            simpa only [f, Nat.sub_zero, Nat.add_sub_cancel] using hsplit
      _ = (-w) * P.coeff (m + 1) + 1 * P.coeff m +
          ∑ i ∈ Finset.Ico 2 (m + 1 + 1), 0 * P.coeff (m + 1 - i) := by
            rw [hzero, hone]
            congr 1
            apply Finset.sum_congr rfl
            intro i hi
            rw [hhigher i (Finset.mem_Ico.mp hi).1]
      _ = (-w) * P.coeff (m + 1) + P.coeff m + 0 := by
            simp only [one_mul, zero_mul, Finset.sum_const_zero]
      _ = P.coeff m + (-w) * P.coeff (m + 1) := by rw [add_zero, add_comm]
  apply Polynomial.ext
  intro k
  have hP : ∀ j k : ℕ, n + 1 ≤ k + j → A.coeff k = B.coeff k := by
    intro j
    induction j with
    | zero =>
        intro k hk
        have hnk : n < k := by omega
        calc
          A.coeff k = 0 := hA k hnk
          _ = B.coeff k := (hB k hnk).symm
    | succ j ih =>
        intro k hk
        by_cases hprev : n + 1 ≤ k + j
        · exact ih k hprev
        · have hk1 : n + 1 ≤ (k + 1) + j := by omega
          have hcoeff := congrArg (fun p : R[X] => p.coeff (k + 1)) hmul
          have hmulA := hproduct A k
          have hmulB := hproduct B k
          calc
            A.coeff k
                = (A.coeff k + (-w) * A.coeff (k + 1)) - (-w) * A.coeff (k + 1) := (add_sub_cancel_right _ _).symm
            _ = ((X - C w) * A).coeff (k + 1) - (-w) * A.coeff (k + 1) := by rw [hmulA]
            _ = ((X - C w) * B).coeff (k + 1) - (-w) * A.coeff (k + 1) := by rw [hcoeff]
            _ = ((X - C w) * B).coeff (k + 1) - (-w) * B.coeff (k + 1) := by rw [ih (k + 1) hk1]
            _ = (B.coeff k + (-w) * B.coeff (k + 1)) - (-w) * B.coeff (k + 1) := by rw [hmulB]
            _ = B.coeff k := add_sub_cancel_right _ _
  exact hP (n + 1) k (by omega)

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
