/-
「一次因子との積の係数は、上の番号で零である」の具体版。
人手証明と同じ準備三段・本体六段の係数計算を行う。
住処: Qbar。ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyLinearFactorCancellation

namespace Ising2DLambda.AlgebraicEigenvalue

open Polynomial
open scoped BigOperators

/-- `Qbar[t]` では、係数が番号 `m` で尽きる多項式に一次因子を掛けても、
係数は番号 `m + 1` で尽きる。 -/
theorem qbarPolyLinearFactorCoeffBound (w : Qbar) (C : QbarPoly) (m : ℕ)
    (hC : ∀ k, m < k → C.coeff k = 0) :
    ∀ k, m + 1 < k → ((Polynomial.X - qbarConst w) * C).coeff k = 0 := by
  intro k hk
  -- 本文の準備: 一次式の番号 i ≥ 2 の係数を三段で計算する。
  have hlin (i : ℕ) (hi : 2 ≤ i) : (X - qbarConst w).coeff i = 0 := by
    calc
      (X - qbarConst w).coeff i = (X : QbarPoly).coeff i - (qbarConst w).coeff i := coeff_sub _ _ _
      _ = 0 - 0 := by
        rw [coeff_X_of_ne_one (by omega)]
        unfold qbarConst
        rw [coeff_C_of_ne_zero (by omega)]
      _ = 0 := sub_self 0
  let f : ℕ → Qbar := fun i => (X - qbarConst w).coeff i * C.coeff (k - i)
  have hsplit : (∑ i ∈ Finset.range (k + 1), f i) =
      f 0 + f 1 + ∑ i ∈ Finset.Ico 2 (k + 1), f i := by
    rw [← Finset.sum_range_add_sum_Ico f (by omega : 2 ≤ k + 1)]
    simp only [Finset.sum_range_succ, Finset.sum_range_zero, zero_add]
  -- 本文の本体: 積の係数、二項の取り出し、係数仮定、準備、零との積、零の和。
  calc
    ((X - qbarConst w) * C).coeff k
        = ∑ i ∈ Finset.range (k + 1), (X - qbarConst w).coeff i * C.coeff (k - i) := by
          rw [coeff_mul, Finset.Nat.sum_antidiagonal_eq_sum_range_succ_mk]
    _ = (X - qbarConst w).coeff 0 * C.coeff k +
        (X - qbarConst w).coeff 1 * C.coeff (k - 1) +
        ∑ i ∈ Finset.Ico 2 (k + 1), (X - qbarConst w).coeff i * C.coeff (k - i) := by
          simpa only [f, Nat.sub_zero] using hsplit
    _ = (X - qbarConst w).coeff 0 * 0 + (X - qbarConst w).coeff 1 * 0 +
        ∑ i ∈ Finset.Ico 2 (k + 1), (X - qbarConst w).coeff i * C.coeff (k - i) := by
          rw [hC k (by omega), hC (k - 1) (by omega)]
    _ = (X - qbarConst w).coeff 0 * 0 + (X - qbarConst w).coeff 1 * 0 +
        ∑ i ∈ Finset.Ico 2 (k + 1), 0 * C.coeff (k - i) := by
          congr 1
          apply Finset.sum_congr rfl
          intro i hi
          rw [hlin i (Finset.mem_Ico.mp hi).1]
    _ = 0 + 0 + ∑ _i ∈ Finset.Ico 2 (k + 1), (0 : Qbar) := by
          simp only [mul_zero, zero_mul]
    _ = 0 := by simp only [Finset.sum_const_zero, add_zero]

end Ising2DLambda.AlgebraicEigenvalue
