/-
# 必要十分版からの導出: `check(Z), check(Y)` についての cosh / sinh の展開係数への変換

対応する人手証明のラベル: **`cosh_sinh_coefficient_conversion_for_check`**。
人手証明と 1 対 1 の具体版は `EigenvalueProblem/ReductionToATheta/ClaimCoefficientConversion.lean` にある。

具体版の手順は「補題 1 → `nesting_of_commutator_of_H_and_check_Z` の代入 → スカラーの整理と補題 2」である。
ここでは同じ手順のまま、前の 2 段を必要十分版の特殊化に差し替えて 8 本を得る。

- **補題 1** は必要十分版 `Ising2D.NecSuf.iterComm_smul_left`（`Ising2D/NecSuf/IteratedCommutatorSmul.lean`）の特殊化
  `adPow_smul_left_of_necSuf` で当てる。
- **代入する入れ子交換子**は必要十分版 `Ising2D.NecSuf.nested_*`（`Ising2D/NecSuf/NestedCommutatorTwoDim.lean`）の特殊化
  `nesting_*_of_necSuf`（`ClaimNestedCommutatorFromNecSuf.lean`）で当てる。
- 最後のスカラーの等式は、具体版と同じ `(i/2)^n = i^n 2^{-n}`（`half_I_pow`）・`(2K_1)^n = 2^nK_1^n`・補題 2（`I_pow_even`・`I_pow_odd`）で
  開き、`2^{-n}2^n = 1`（`two_pow_inv_mul`）と `(-1)^k(-1)^k = 1`・`(-1)^k(-1)^{k+1} = -1` を一次結合で当てる。

このファイルには、スカラー倍した生成子 `(i/2)K_1H_1^{(+)}`・`iK_2^*H_2` が `span{check(Z)_μ, check(Y)_μ}` を保つこと
（`ad_V1plusHalf_*`・`ad_V2H2Form_*`・`sK1_sq`・`sK2_sq`）も置く。人手の本主張の証明はこれらを使わないが、
`T_actions_on_check_Z_Y` を必要十分版 `NecSuf.exp_conj_two_dim_actsBy` から導く
`EigenvalueProblem/ReductionToATheta/ClaimTActionsOnCheckFromNecSuf.lean` がこれらを使う。
-/
import Ising2D.NecSuf.IteratedCommutatorSmul
import Ising2D.EigenvalueProblem.ReductionToATheta.ClaimCoefficientConversion
import Ising2D.EigenvalueProblem.ReductionToATheta.ClaimNestedCommutatorFromNecSuf

namespace Ising2D

variable {M : ℕ}

/-! ## 補題 1 を必要十分版の特殊化として得る -/

/-- 人手の補題 1 を必要十分版 `NecSuf.iterComm_smul_left` の特殊化として得たもの。 -/
theorem adPow_smul_left_of_necSuf (α : ℂ) (X W : TensorPow M) (n : ℕ) :
    adPow (α • X) n W = α ^ n • adPow X n W := by
  rw [adPow_eq_iterComm, adPow_eq_iterComm, NecSuf.iterComm_smul_left]

/-! ## 符号の整理に使う 2 つの等式 -/

private theorem neg_one_pow_mul_self (k : ℕ) : (-1 : ℂ) ^ k * (-1 : ℂ) ^ k = 1 := by
  rw [← pow_add, ← two_mul, pow_mul, neg_one_sq, one_pow]

private theorem neg_one_pow_mul_succ (k : ℕ) : (-1 : ℂ) ^ k * (-1 : ℂ) ^ (k + 1) = -1 := by
  rw [pow_succ, ← mul_assoc, neg_one_pow_mul_self, one_mul]

/-! ## 8 本を、補題 1 と入れ子交換子の必要十分版の特殊化から得る -/

/-- 人手 (h1.z) 偶数側を必要十分版の特殊化から得たもの。 -/
theorem conversion_H1Plus_checkZ_even_of_necSuf (hM : M ≠ 0) (K1 : ℂ) (μ : ℤ) (k : ℕ) :
    adPow (((1 / 2 : ℂ) * Complex.I * K1) • H1plus M) (2 * k) (checkZ M μ)
      = (K1 ^ (2 * k)) • checkZ M μ := by
  rw [← smul_smul, adPow_smul_left_of_necSuf, nesting_H1Plus_checkZ_even_of_necSuf hM K1 μ k,
    smul_smul]
  congr 1
  rw [half_I_pow, mul_pow (2 : ℂ) K1, I_pow_even]
  linear_combination (K1 ^ (2 * k) * ((-1 : ℂ) ^ k * (-1 : ℂ) ^ k)) * two_pow_inv_mul (2 * k)
    + K1 ^ (2 * k) * neg_one_pow_mul_self k

/-- 人手 (h1.z) 奇数側を必要十分版の特殊化から得たもの。 -/
theorem conversion_H1Plus_checkZ_odd_of_necSuf (hM : M ≠ 0) (K1 : ℂ) (μ : ℤ) (k : ℕ) :
    adPow (((1 / 2 : ℂ) * Complex.I * K1) • H1plus M) (2 * k + 1) (checkZ M μ)
      = (Complex.I * K1 ^ (2 * k + 1) * checkPhase M 1 μ) • checkY M μ := by
  rw [← smul_smul, adPow_smul_left_of_necSuf, nesting_H1Plus_checkZ_odd_of_necSuf hM K1 μ k,
    smul_smul]
  congr 1
  rw [half_I_pow, mul_pow (2 : ℂ) K1, I_pow_odd]
  linear_combination
    (Complex.I * K1 ^ (2 * k + 1) * checkPhase M 1 μ * ((-1 : ℂ) ^ k * (-1 : ℂ) ^ k))
        * two_pow_inv_mul (2 * k + 1)
      + (Complex.I * K1 ^ (2 * k + 1) * checkPhase M 1 μ) * neg_one_pow_mul_self k

/-- 人手 (h1.y) 偶数側を必要十分版の特殊化から得たもの。 -/
theorem conversion_H1Plus_checkY_even_of_necSuf (hM : M ≠ 0) (K1 : ℂ) (μ : ℤ) (k : ℕ) :
    adPow (((1 / 2 : ℂ) * Complex.I * K1) • H1plus M) (2 * k) (checkY M μ)
      = (K1 ^ (2 * k)) • checkY M μ := by
  rw [← smul_smul, adPow_smul_left_of_necSuf, nesting_H1Plus_checkY_even_of_necSuf hM K1 μ k,
    smul_smul]
  congr 1
  rw [half_I_pow, mul_pow (2 : ℂ) K1, I_pow_even]
  linear_combination (K1 ^ (2 * k) * ((-1 : ℂ) ^ k * (-1 : ℂ) ^ k)) * two_pow_inv_mul (2 * k)
    + K1 ^ (2 * k) * neg_one_pow_mul_self k

/-- 人手 (h1.y) 奇数側を必要十分版の特殊化から得たもの。 -/
theorem conversion_H1Plus_checkY_odd_of_necSuf (hM : M ≠ 0) (K1 : ℂ) (μ : ℤ) (k : ℕ) :
    adPow (((1 / 2 : ℂ) * Complex.I * K1) • H1plus M) (2 * k + 1) (checkY M μ)
      = (-Complex.I * K1 ^ (2 * k + 1) * checkPhase M (-1) μ) • checkZ M μ := by
  rw [← smul_smul, adPow_smul_left_of_necSuf, nesting_H1Plus_checkY_odd_of_necSuf hM K1 μ k,
    smul_smul]
  congr 1
  rw [half_I_pow, mul_pow (2 : ℂ) K1, I_pow_odd]
  linear_combination
    (Complex.I * K1 ^ (2 * k + 1) * checkPhase M (-1) μ * ((-1 : ℂ) ^ k * (-1 : ℂ) ^ (k + 1)))
        * two_pow_inv_mul (2 * k + 1)
      + (Complex.I * K1 ^ (2 * k + 1) * checkPhase M (-1) μ) * neg_one_pow_mul_succ k

/-- 人手 (h2.z) 偶数側を必要十分版の特殊化から得たもの。 -/
theorem conversion_H2_checkZ_even_of_necSuf (hM : M ≠ 0) (K2star : ℂ) (μ : ℤ) (k : ℕ) :
    adPow ((Complex.I * K2star) • H2 M) (2 * k) (checkZ M μ)
      = ((2 * K2star) ^ (2 * k)) • checkZ M μ := by
  rw [← smul_smul, adPow_smul_left_of_necSuf, nesting_H2_checkZ_even_of_necSuf hM K2star μ k,
    smul_smul]
  congr 1
  rw [I_pow_even]
  linear_combination (2 * K2star) ^ (2 * k) * neg_one_pow_mul_self k

/-- 人手 (h2.z) 奇数側を必要十分版の特殊化から得たもの。 -/
theorem conversion_H2_checkZ_odd_of_necSuf (hM : M ≠ 0) (K2star : ℂ) (μ : ℤ) (k : ℕ) :
    adPow ((Complex.I * K2star) • H2 M) (2 * k + 1) (checkZ M μ)
      = (-Complex.I * (2 * K2star) ^ (2 * k + 1)) • checkY M μ := by
  rw [← smul_smul, adPow_smul_left_of_necSuf, nesting_H2_checkZ_odd_of_necSuf hM K2star μ k,
    smul_smul]
  congr 1
  rw [I_pow_odd]
  linear_combination (Complex.I * (2 * K2star) ^ (2 * k + 1)) * neg_one_pow_mul_succ k

/-- 人手 (h2.y) 偶数側を必要十分版の特殊化から得たもの。 -/
theorem conversion_H2_checkY_even_of_necSuf (hM : M ≠ 0) (K2star : ℂ) (μ : ℤ) (k : ℕ) :
    adPow ((Complex.I * K2star) • H2 M) (2 * k) (checkY M μ)
      = ((2 * K2star) ^ (2 * k)) • checkY M μ := by
  rw [← smul_smul, adPow_smul_left_of_necSuf, nesting_H2_checkY_even_of_necSuf hM K2star μ k,
    smul_smul]
  congr 1
  rw [I_pow_even]
  linear_combination (2 * K2star) ^ (2 * k) * neg_one_pow_mul_self k

/-- 人手 (h2.y) 奇数側を必要十分版の特殊化から得たもの。 -/
theorem conversion_H2_checkY_odd_of_necSuf (hM : M ≠ 0) (K2star : ℂ) (μ : ℤ) (k : ℕ) :
    adPow ((Complex.I * K2star) • H2 M) (2 * k + 1) (checkY M μ)
      = (Complex.I * (2 * K2star) ^ (2 * k + 1)) • checkZ M μ := by
  rw [← smul_smul, adPow_smul_left_of_necSuf, nesting_H2_checkY_odd_of_necSuf hM K2star μ k,
    smul_smul]
  congr 1
  rw [I_pow_odd]
  linear_combination (Complex.I * (2 * K2star) ^ (2 * k + 1)) * neg_one_pow_mul_self k

/-! ## スカラー倍した生成子の 2 次元不変性（`ClaimTActionsOnCheckFromNecSuf.lean` が使う） -/

/-- 人手 (A) を `(i/2)K_1` 倍したもの。 -/
theorem ad_V1plusHalf_checkZ (hM : M ≠ 0) (K1 : ℂ) (μ : ℤ) :
    (((1 / 2 : ℂ) * Complex.I * K1) • H1plus M) * checkZ M μ -
        checkZ M μ * (((1 / 2 : ℂ) * Complex.I * K1) • H1plus M)
      = (Complex.I * K1 * checkPhase M 1 μ) • checkY M μ := by
  rw [smul_mul_assoc, mul_smul_comm, ← smul_sub, ← Ring.lie_def, lie_H1Plus_checkZ hM μ,
    smul_smul]
  congr 1
  ring

/-- 人手 (B) を `(i/2)K_1` 倍したもの。 -/
theorem ad_V1plusHalf_checkY (hM : M ≠ 0) (K1 : ℂ) (μ : ℤ) :
    (((1 / 2 : ℂ) * Complex.I * K1) • H1plus M) * checkY M μ -
        checkY M μ * (((1 / 2 : ℂ) * Complex.I * K1) • H1plus M)
      = (-Complex.I * K1 * checkPhase M (-1) μ) • checkZ M μ := by
  rw [smul_mul_assoc, mul_smul_comm, ← smul_sub, ← Ring.lie_def, lie_H1Plus_checkY hM μ,
    smul_smul]
  congr 1
  ring

/-- `αβ = K_1^2`（`i·(-i) = 1` と `e^{-iθ~}e^{iθ~} = 1`）。 -/
theorem sK1_sq (M : ℕ) (K1 : ℂ) (μ : ℤ) :
    K1 ^ 2 = (Complex.I * K1 * checkPhase M 1 μ) * (-Complex.I * K1 * checkPhase M (-1) μ) := by
  have hp := checkPhase_mul_neg M μ
  linear_combination
    (K1 ^ 2 * checkPhase M 1 μ * checkPhase M (-1) μ) * Complex.I_sq - (K1 ^ 2) * hp

/-- 人手 (C) を `i K_2^*` 倍したもの。 -/
theorem ad_V2H2Form_checkZ (hM : M ≠ 0) (K2star : ℂ) (μ : ℤ) :
    ((Complex.I * K2star) • H2 M) * checkZ M μ -
        checkZ M μ * ((Complex.I * K2star) • H2 M)
      = (-(2 * Complex.I * K2star)) • checkY M μ := by
  rw [smul_mul_assoc, mul_smul_comm, ← smul_sub, ← Ring.lie_def, lie_H2_checkZ hM μ, smul_smul]
  congr 1
  ring

/-- 人手 (D) を `i K_2^*` 倍したもの。 -/
theorem ad_V2H2Form_checkY (hM : M ≠ 0) (K2star : ℂ) (μ : ℤ) :
    ((Complex.I * K2star) • H2 M) * checkY M μ -
        checkY M μ * ((Complex.I * K2star) • H2 M)
      = (2 * Complex.I * K2star) • checkZ M μ := by
  rw [smul_mul_assoc, mul_smul_comm, ← smul_sub, ← Ring.lie_def, lie_H2_checkY hM μ, smul_smul]
  congr 1
  ring

/-- `αβ = (2K_2^*)^2`。 -/
theorem sK2_sq (K2star : ℂ) :
    (2 * K2star) ^ 2 = (-(2 * Complex.I * K2star)) * (2 * Complex.I * K2star) := by
  linear_combination (4 * K2star ^ 2) * Complex.I_sq

end Ising2D
