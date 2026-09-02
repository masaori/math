/-
# 具体版: `T_{(V_1^{(+)})^{1/2}}`, `T_{V_2}` の `check(Z), check(Y)` への作用

対応する人手証明のラベル:

* **`T_actions_on_check_Z_Y`**（`evensectorT_005_claim_T_actions`）
* **`linearity_of_T_on_check_Z_Y`**（`evensectorT_006_claim_linearity_of_T`）
* **`calc_of_TxT_check_Z_Y`**（`evensectorT_008_claim_product_action`）

（いずれも `structured-latex/content/014_even_sector_T_action.ts`）

**必要十分版**は既存の `Ising2D/NecSuf/TVAction.lean`
（`Ising2D.NecSuf.twoDimConjMat`, `exp_conj_two_dim_actsBy`, `conj_smul_eq`）。

## 008 章との関係（本章の要点）

008 章の同じ主張（`<ホロノミック量子場_p142下段_1>`、`Part008/Claim012_TVActions.lean` の
`actsBy_TConj_V1half` / `actsBy_TConj_V2`）と本ファイルの主張は、
**同じ必要十分版 `NecSuf.exp_conj_two_dim_actsBy` の別の特殊化**である。
渡す `(α, β, s)` は

| | `α` | `β` | `s` | 作用行列 |
| --- | --- | --- | --- | --- |
| 008 章 `T_{(V_1^{(-)})^{1/2}}` | `i K_1 e^{-iθ_μ}` | `-i K_1 e^{iθ_μ}` | `K_1` | `B_1(θ_μ)` |
| 本章 `T_{(V_1^{(+)})^{1/2}}` | `i K_1 e^{-iθ~_μ}` | `-i K_1 e^{iθ~_μ}` | `K_1` | `B_1(θ~_μ)` |
| 008 章・本章の `T_{V_2}` | `-2i K_2^*` | `2i K_2^*` | `2K_2^*` | `B_2` |

すなわち**違いは `θ_μ = 2πμ/M` を `θ~_μ = 2π(μ-1/2)/M` に置き換えることだけ**であり、
`αβ = s^2` の検証に使うのは `e^{-iθ}e^{iθ} = 1` と `i^2 = -1` だけである。
これが原文の「008 章の各証明は `θ_μ` に固有の性質を使っていない」の Lean での裏づけである。

`V_2` の前因子 `(2s_2)^{M/2}` が共役で打ち消えることも、008 章と同じ
`NecSuf.conj_smul_eq`（任意の ℂ-代数）で処理する。
-/
import Ising2D.Part008.Claim012_TVActions
import Ising2D.Part014.Claim004_ExtractTaylor
import Ising2D.Part014.Definition007_B1B2

namespace Ising2D

variable {M : ℕ}

/-! ## 位相因子を `e^{∓iθ~_μ}` の形へ -/

/-- `e^{-iθ~_μ} = exp(-θ~_μ i)`（`checkPhase` と原文の指数表示の橋渡し）。 -/
theorem checkPhase_one_eq_exp (hM : M ≠ 0) (μ : ℤ) :
    checkPhase M 1 μ = Complex.exp (-((thetaTilde M μ : ℝ) : ℂ) * Complex.I) := by
  rw [checkPhase_eq_exp hM]
  congr 1
  push_cast
  ring

/-- `e^{iθ~_μ} = exp(θ~_μ i)`。 -/
theorem checkPhase_neg_one_eq_exp (hM : M ≠ 0) (μ : ℤ) :
    checkPhase M (-1) μ = Complex.exp (((thetaTilde M μ : ℝ) : ℂ) * Complex.I) := by
  rw [checkPhase_eq_exp hM]
  congr 1
  push_cast
  ring

/-- `e^{-iθ} e^{iθ} = 1`。 -/
private theorem exp_neg_mul_exp' (θ : ℂ) :
    Complex.exp (-θ * Complex.I) * Complex.exp (θ * Complex.I) = 1 := by
  rw [← Complex.exp_add]
  simp

/-! ## `T_{(V_1^{(+)})^{1/2}}` の作用行列は `B_1(θ~_μ)` -/

/-- `ad((i/2)K_1H_1^{(+)})` が `span{check(Z)_μ, check(Y)_μ}` を保つこと（指数表示版）。 -/
theorem ad_V1halfPlus_checkZ_exp (hM : M ≠ 0) (K1 : ℂ) (μ : ℤ) :
    (((1 / 2 : ℂ) * Complex.I * K1) • H1 M (-1)) * checkZ M μ -
        checkZ M μ * (((1 / 2 : ℂ) * Complex.I * K1) • H1 M (-1))
      = (Complex.I * K1 * Complex.exp (-((thetaTilde M μ : ℝ) : ℂ) * Complex.I)) •
          checkY M μ := by
  rw [ad_V1halfPlus_checkZ hM K1 μ, checkPhase_one_eq_exp hM μ]

/-- 同上（`y` 側）。 -/
theorem ad_V1halfPlus_checkY_exp (hM : M ≠ 0) (K1 : ℂ) (μ : ℤ) :
    (((1 / 2 : ℂ) * Complex.I * K1) • H1 M (-1)) * checkY M μ -
        checkY M μ * (((1 / 2 : ℂ) * Complex.I * K1) • H1 M (-1))
      = (-Complex.I * K1 * Complex.exp (((thetaTilde M μ : ℝ) : ℂ) * Complex.I)) •
          checkZ M μ := by
  rw [ad_V1halfPlus_checkY hM K1 μ, checkPhase_neg_one_eq_exp hM μ]

/-- **原文 `calc_of_TxT_check_Z_Y` の第 1 式**（原文 `T_actions_on_check_Z_Y` の
第 1・第 2 式を行ベクトル記法にまとめたもの）:
`T_{(V_1^{(+)})^{1/2}}` は `(check(Z)_μ, check(Y)_μ)` に `B_1(θ~_μ)` で作用する。 -/
theorem actsBy_TConj_V1halfPlus (hM : M ≠ 0) (K1 : ℂ) (μ : ℤ) :
    ActsBy (TConj (V1halfUnits M K1 (-1))).toLinearMap (checkZ M μ) (checkY M μ)
      (B1mat K1 ((thetaTilde M μ : ℝ) : ℂ)) := by
  rw [B1mat_eq_twoDimConjMat]
  refine actsBy_TConj_matExpUnits (ad_V1halfPlus_checkZ_exp hM K1 μ)
    (ad_V1halfPlus_checkY_exp hM K1 μ) ?_
  have h := exp_neg_mul_exp' ((thetaTilde M μ : ℝ) : ℂ)
  have hI : Complex.I * Complex.I = -1 := Complex.I_mul_I
  linear_combination (-(K1 ^ 2)) * h +
    (K1 ^ 2 * Complex.exp (-((thetaTilde M μ : ℝ) : ℂ) * Complex.I) *
      Complex.exp (((thetaTilde M μ : ℝ) : ℂ) * Complex.I)) * hI

/-! ## `T_{V_2}` の作用行列は `B_2` -/

/-- **原文 `calc_of_TxT_check_Z_Y` の第 2 式**（原文 `T_actions_on_check_Z_Y` の
第 3・第 4 式）: `T_{V_2}` は `(check(Z)_μ, check(Y)_μ)` に `B_2` で作用する。
前因子 `(2s_2)^{M/2}` は共役で打ち消える。 -/
theorem actsBy_TConj_V2_check (hM : M ≠ 0) {s2 : ℝ} (hs2 : 0 < s2) (K2star : ℂ) (μ : ℤ) :
    ActsBy (TConj (V2Units M hs2 K2star)).toLinearMap (checkZ M μ) (checkY M μ)
      (B2mat K2star) := by
  rw [B2mat_eq_twoDimConjMat]
  refine actsBy_TConj_smulUnits _ ?_
  exact actsBy_TConj_matExpUnits (ad_V2_checkZ hM K2star μ) (ad_V2_checkY hM K2star μ)
    (sK2_sq K2star)

/-! ## 原文 `T_actions_on_check_Z_Y` の 4 式（成分の形） -/

/-- **原文 第 1 式**: `T_{(V_1^{(+)})^{1/2}}(check(Z)_μ)
= cosh(K_1) check(Z)_μ + i e^{-iθ~_μ} sinh(K_1) check(Y)_μ`。 -/
theorem TConj_V1halfPlus_checkZ (hM : M ≠ 0) (K1 : ℂ) (μ : ℤ) :
    TConj (V1halfUnits M K1 (-1)) (checkZ M μ)
      = Complex.cosh K1 • checkZ M μ
        + (Complex.I * checkPhase M 1 μ * Complex.sinh K1) • checkY M μ := by
  have h := (actsBy_TConj_V1halfPlus hM K1 μ).1
  rw [checkPhase_one_eq_exp hM μ]
  rw [show (TConj (V1halfUnits M K1 (-1))) (checkZ M μ)
      = (TConj (V1halfUnits M K1 (-1))).toLinearMap (checkZ M μ) from rfl, h]
  simp only [B1mat_zero_zero, B1mat_one_zero]

/-- **原文 第 2 式**: `T_{(V_1^{(+)})^{1/2}}(check(Y)_μ)
= -i e^{iθ~_μ} sinh(K_1) check(Z)_μ + cosh(K_1) check(Y)_μ`。 -/
theorem TConj_V1halfPlus_checkY (hM : M ≠ 0) (K1 : ℂ) (μ : ℤ) :
    TConj (V1halfUnits M K1 (-1)) (checkY M μ)
      = (-Complex.I * checkPhase M (-1) μ * Complex.sinh K1) • checkZ M μ
        + Complex.cosh K1 • checkY M μ := by
  have h := (actsBy_TConj_V1halfPlus hM K1 μ).2
  rw [checkPhase_neg_one_eq_exp hM μ]
  rw [show (TConj (V1halfUnits M K1 (-1))) (checkY M μ)
      = (TConj (V1halfUnits M K1 (-1))).toLinearMap (checkY M μ) from rfl, h]
  simp only [B1mat_zero_one, B1mat_one_one]

/-- **原文 第 3 式**: `T_{V_2}(check(Z)_μ)
= cosh(2K_2^*) check(Z)_μ - i sinh(2K_2^*) check(Y)_μ`。 -/
theorem TConj_V2_checkZ (hM : M ≠ 0) {s2 : ℝ} (hs2 : 0 < s2) (K2star : ℂ) (μ : ℤ) :
    TConj (V2Units M hs2 K2star) (checkZ M μ)
      = Complex.cosh (2 * K2star) • checkZ M μ
        + (-Complex.I * Complex.sinh (2 * K2star)) • checkY M μ :=
  (actsBy_TConj_V2_check hM hs2 K2star μ).1

/-- **原文 第 4 式**: `T_{V_2}(check(Y)_μ)
= i sinh(2K_2^*) check(Z)_μ + cosh(2K_2^*) check(Y)_μ`。 -/
theorem TConj_V2_checkY (hM : M ≠ 0) {s2 : ℝ} (hs2 : 0 < s2) (K2star : ℂ) (μ : ℤ) :
    TConj (V2Units M hs2 K2star) (checkY M μ)
      = (Complex.I * Complex.sinh (2 * K2star)) • checkZ M μ
        + Complex.cosh (2 * K2star) • checkY M μ :=
  (actsBy_TConj_V2_check hM hs2 K2star μ).2

/-! ## 共役写像の一般線型性と半指数行列への特殊化 -/

/-- **本文 `linearity_of_T` の具体版**: 有限複素行列の積を一段ずつ分配して示す。 -/
theorem linearity_of_T_on_check (g : (TensorPow M)ˣ) (a b : ℂ) (X W : TensorPow M) :
    TConj g (a • X + b • W) = a • TConj g X + b • TConj g W := by
  change (g : TensorPow M) * (a • X + b • W) * ((g⁻¹ : (TensorPow M)ˣ) : TensorPow M)
      = a • ((g : TensorPow M) * X * ((g⁻¹ : (TensorPow M)ˣ) : TensorPow M))
        + b • ((g : TensorPow M) * W * ((g⁻¹ : (TensorPow M)ˣ) : TensorPow M))
  rw [mul_add]
  rw [add_mul]
  rw [mul_smul_comm, mul_smul_comm]
  rw [smul_mul_assoc, smul_mul_assoc]

/-- 具体版が必要十分版 `TConj_linear` の有限複素行列への特殊化であることを記録する。 -/
theorem linearity_of_T_on_check_from_general (g : (TensorPow M)ˣ)
    (a b : ℂ) (X W : TensorPow M) :
    TConj g (a • X + b • W) = a • TConj g X + b • TConj g W :=
  TConj_linear g a b X W

/-- **本文 `linearity_of_T_on_check_Z_Y`**: `g = (V_1^{(+)})^{1/2}` への特殊化。 -/
theorem linearity_of_T_V1halfPlus (_hM : 2 ≤ M) (K1 : ℂ) (a b : ℂ) (μ : ℤ)
    (_hμ : CheckIndex M μ) :
    TConj (V1halfUnits M K1 (-1)) (a • checkZ M μ + b • checkY M μ)
      = a • TConj (V1halfUnits M K1 (-1)) (checkZ M μ)
        + b • TConj (V1halfUnits M K1 (-1)) (checkY M μ) :=
  linearity_of_T_on_check _ a b _ _

/-- **原文 `linearity_of_T_on_check_Z_Y` の「とくに」の部分**（`g = V_2`）。 -/
theorem linearity_of_T_V2 {s2 : ℝ} (hs2 : 0 < s2) (K2star : ℂ) (a b : ℂ) (μ : ℤ) :
    TConj (V2Units M hs2 K2star) (a • checkZ M μ + b • checkY M μ)
      = a • TConj (V2Units M hs2 K2star) (checkZ M μ)
        + b • TConj (V2Units M hs2 K2star) (checkY M μ) :=
  TConj_linear _ a b _ _

end Ising2D
