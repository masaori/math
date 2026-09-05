/-
「一次因子との積の係数は、上の番号で零である」の必要十分版。

本文と同じ準備三段・本体六段の係数計算を行う。
必要なのは環（一次式 X - C w が加法の逆元を要るため）と一次因子との積の
係数公式だけであり、積の可換性・体・代数閉性は要らない。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Polynomial
open scoped BigOperators

/-- 環上でも、係数が番号 `m` で尽きる多項式に一次因子を掛けると、
係数は番号 `m + 1` で尽きる。 -/
theorem poly_linear_factor_coeff_bound_necSuf {R : Type*} [Ring R]
    (w : R) (C : R[X]) (m : ℕ)
    (hC : ∀ k, m < k → C.coeff k = 0) :
    ∀ k, m + 1 < k → ((X - Polynomial.C w) * C).coeff k = 0 := by
  intro k hk
  -- 本文の準備: 一次式の番号 i ≥ 2 の係数を三段で計算する。
  have hlin (i : ℕ) (hi : 2 ≤ i) : (X - Polynomial.C w).coeff i = 0 := by
    calc
      (X - Polynomial.C w).coeff i = (X : R[X]).coeff i - (Polynomial.C w).coeff i := coeff_sub _ _ _
      _ = 0 - 0 := by
        rw [coeff_X_of_ne_one (by omega)]
        rw [coeff_C_of_ne_zero (by omega)]
      _ = 0 := sub_self 0
  let f : ℕ → R := fun i => (X - Polynomial.C w).coeff i * C.coeff (k - i)
  have hsplit : (∑ i ∈ Finset.range (k + 1), f i) =
      f 0 + f 1 + ∑ i ∈ Finset.Ico 2 (k + 1), f i := by
    rw [← Finset.sum_range_add_sum_Ico f (by omega : 2 ≤ k + 1)]
    simp only [Finset.sum_range_succ, Finset.sum_range_zero, zero_add]
  -- 本文の本体: 積の係数、二項の取り出し、係数仮定、準備、零との積、零の和。
  calc
    ((X - Polynomial.C w) * C).coeff k
        = ∑ i ∈ Finset.range (k + 1), (X - Polynomial.C w).coeff i * C.coeff (k - i) := by
          rw [coeff_mul, Finset.Nat.sum_antidiagonal_eq_sum_range_succ_mk]
    _ = (X - Polynomial.C w).coeff 0 * C.coeff k +
        (X - Polynomial.C w).coeff 1 * C.coeff (k - 1) +
        ∑ i ∈ Finset.Ico 2 (k + 1), (X - Polynomial.C w).coeff i * C.coeff (k - i) := by
          simpa only [f, Nat.sub_zero] using hsplit
    _ = (X - Polynomial.C w).coeff 0 * 0 + (X - Polynomial.C w).coeff 1 * 0 +
        ∑ i ∈ Finset.Ico 2 (k + 1), (X - Polynomial.C w).coeff i * C.coeff (k - i) := by
          rw [hC k (by omega), hC (k - 1) (by omega)]
    _ = (X - Polynomial.C w).coeff 0 * 0 + (X - Polynomial.C w).coeff 1 * 0 +
        ∑ i ∈ Finset.Ico 2 (k + 1), 0 * C.coeff (k - i) := by
          congr 1
          apply Finset.sum_congr rfl
          intro i hi
          rw [hlin i (Finset.mem_Ico.mp hi).1]
    _ = 0 + 0 + ∑ _i ∈ Finset.Ico 2 (k + 1), (0 : R) := by
          simp only [mul_zero, zero_mul]
    _ = 0 := by simp only [Finset.sum_const_zero, add_zero]

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
