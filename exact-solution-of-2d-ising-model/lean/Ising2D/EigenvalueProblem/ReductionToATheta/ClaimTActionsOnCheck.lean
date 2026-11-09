/-
# 具体版: `T_{(V_1^{(+)})^{1/2}}`, `T_{V_2}` の `check(Z), check(Y)` への作用

対応する人手証明のラベル:

* **`T_actions_on_check_Z_Y`**（`evensectorT_005_claim_T_actions`）
* **`linearity_of_T_on_check_Z_Y`**（`evensectorT_006_claim_linearity_of_T`）
* **`linearity_of_T_V2`**（`evensectorT_006a_claim_linearity_of_T_V2`）
* **`calc_of_TxT_check_Z_Y`**（`evensectorT_008_claim_product_action`）

（いずれも `structured-latex/content/eigenvalue_problem_reduction_to_A_theta.ts`）

**必要十分版**は既存の `Ising2D/NecSuf/TVAction.lean`
（`Ising2D.NecSuf.twoDimConjMat`, `exp_conj_two_dim_actsBy`, `conj_smul_eq`）。
本ファイルの `calc_of_TxT_check_Z_Y` の 2 式がその特殊化として得られることは
`EigenvalueProblem/ReductionToATheta/ClaimTActionsOnCheckFromNecSuf.lean` に書いた。

具体版のステップと必要十分版の補題の対応は次のとおりである。

| 具体版の行 | 必要十分版 |
| --- | --- |
| `exp_X_Y_exp_-X` と `extract_taylor_coefficient_of_check_Z_Y` の 2 行（`exp(X)A exp(-X)` を `cosh`・`sinh` の係数に直す） | `NecSuf.exp_conj_two_dim_z` / `exp_conj_two_dim_y` |
| 4 式を 2 列に並べて `B_1(θ~_μ)`, `B_2` と突き合わせる行 | `NecSuf.exp_conj_two_dim_actsBy`（作用行列 `twoDimConjMat`） |
| `V_2` の前因子を打ち消す行（人手の 6〜13 行目（`TConj_V2_checkZ` の calc の 4〜11 段）、`V2H2Form` 版は `smul_conj_smul_inv_eq`） | `NecSuf.conj_smul_eq` |

## 人手証明との対応

`T_actions_on_check_Z_Y` の 4 式は、人手の式変形の各行を `calc` の 1 行に対応させて示す。

| 人手の行の根拠 | Lean |
| --- | --- |
| `def_T_g`（`T_g(X) = gXg^{-1}`） | `TConj_apply` |
| `def_V1_plus_square_root`（`(V_1^{(+)})^{1/2} := exp((i/2)K_1H_1^{(+)})`） | `V1plusHalfUnits_val`・`V1plusHalf` |
| `matrix_exp_conjugation` (3)（`exp(X)^{-1} = exp(-X)`） | `matExpUnits_inv`（`V1plusHalfUnits` は `matExpUnits` の値） |
| `V2_invertible`（`V_2^{-1} = (a^{-1})_ℂ exp(-Y)`） | `V2Units_inv_val` |
| `V2_exponential_representation`、`V2_invertible` の `a`・`Y` | `V2_exponential_representation` の書き換えと `V2H2Form` の展開の 1 段 |
| `scalar_multiple_factors_out_of_left_factor` を 2 回、`_right_factor`、`scalar_multiple_is_associative` | `smul_mul_matrix_tensorPow`・`mul_smul_matrix_tensorPow`・`smul_smul` |
| `real_inclusion_preserves_product`（`a_ℂ(a^{-1})_ℂ = (aa^{-1})_ℂ`）、ℝ で `aa^{-1} = 1`、`1_ℂ` の略記、`scalar_multiple_by_one` | `real_inclusion_mul`・`mul_inv_cancel₀`（ℝ）・`Complex.ofReal_one`・`one_smul_tensorPow` |
| `exp_X_Y_exp_-X` | `matExp_conj_eq_tsum` |
| `extract_taylor_coefficient_of_check_Z_Y` (h1.z)(h1.y)(h2.z)(h2.y) | `extract_taylor_H1Plus_checkZ` ほか |

`calc_of_TxT_check_Z_Y` は、人手どおり 4 式の列を 2 列並べ（`ActsBy` の定義）、`def_B1_theta_B2` の成分と
突き合わせて示す。

## 人手の `V_2` と `V2H2Form`

`T_{V_2}` の作用は、人手の `V_2`（`def_transfer_matrix`）の単元 `V2Units`
（`EigenvalueProblem/ReductionToATheta/DefinitionVPlus.lean`。逆元は人手 `V2_invertible` の `(a^{-1})_ℂ exp(-Y)`）による共役
（`TConj_V2_checkZ`・`TConj_V2_checkY`）を人手の鎖と 1 対 1 に示す。主張の係数は人手どおり `(cosh 2K_2^*)_ℂ` の像で書く。
`V2H2Form`（`V2_exponential_representation` の右辺の式、`s2`, `K2star` は独立な引数）による共役（`TConj_V2H2Form_checkZ` ほか）は
人手に無い一般化で、単元の逆元が複素数の逆数 `c^{-1}` なので、前因子を mathlib の `smul_comm`・`mul_inv_cancel₀` で閉じる `smul_conj_smul_inv_eq` で打ち消す。

Lean の `B2mat`（`DefinitionB1B2.lean`）の成分は複素数の `cosh (2K)`・`sinh (2K)` で、人手 `def_B1_theta_B2` の
`(cosh 2K_2^*)_ℂ` と定義が違う。`actsBy_TConj_V2_check` はその読み替えを `Complex.ofReal_cosh`・`Complex.ofReal_mul` の段で行う
（人手の行ではない）。
-/
import Ising2D.EigenvalueProblem.ReductionToATheta.ClaimExtractTaylor
import Ising2D.EigenvalueProblem.ReductionToATheta.DefinitionB1B2
import Ising2D.EigenvalueProblem.ReductionToATheta.DefinitionVPlus
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimMatMultDistributesOverSumFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityAndScalarMultipleInMatrixProductFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimScalarMultipleByOneFromNecSuf
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesProduct

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

/-! ## 原文 `T_actions_on_check_Z_Y` の 4 式 -/

/-- **原文 第 1 式**: `T_{(V_1^{(+)})^{1/2}}(check(Z)_μ)
= cosh(K_1) check(Z)_μ + i e^{-iθ~_μ} sinh(K_1) check(Y)_μ`。 -/
theorem TConj_V1plusHalf_checkZ (hM : M ≠ 0) (K1 : ℝ) (μ : ℤ) :
    TConj (V1plusHalfUnits M K1) (checkZ M μ)
      = Complex.cosh K1 • checkZ M μ
        + (Complex.I * checkPhase M 1 μ * Complex.sinh K1) • checkY M μ := by
  calc TConj (V1plusHalfUnits M K1) (checkZ M μ)
      -- `def_T_g`
      = ((V1plusHalfUnits M K1 : (TensorPow M)ˣ) : TensorPow M) * checkZ M μ *
          (((V1plusHalfUnits M K1)⁻¹ : (TensorPow M)ˣ) : TensorPow M) := TConj_apply _ _
      -- `def_V1_plus_square_root`
    _ = matExp (((1 / 2 : ℂ) * Complex.I * K1) • H1plus M) * checkZ M μ *
          (((matExpUnits (((1 / 2 : ℂ) * Complex.I * K1) • H1plus M))⁻¹ : (TensorPow M)ˣ) :
            TensorPow M) := by rw [V1plusHalfUnits_val, V1plusHalf]; rfl
      -- `matrix_exp_conjugation` (3): `exp(X)^{-1} = exp(-X)`
    _ = matExp (((1 / 2 : ℂ) * Complex.I * K1) • H1plus M) * checkZ M μ *
          matExp (-(((1 / 2 : ℂ) * Complex.I * K1) • H1plus M)) := by rw [matExpUnits_inv]
      -- `exp_X_Y_exp_-X`
    _ = ∑' n : ℕ, ((n.factorial : ℂ))⁻¹ •
          adPow (((1 / 2 : ℂ) * Complex.I * K1) • H1plus M) n (checkZ M μ) :=
        matExp_conj_eq_tsum _ _
      -- `extract_taylor_coefficient_of_check_Z_Y` (h1.z)
    _ = Complex.cosh K1 • checkZ M μ
          + (Complex.I * checkPhase M 1 μ * Complex.sinh K1) • checkY M μ :=
        (extract_taylor_H1Plus_checkZ hM K1 μ).2.trans (by
          rw [Complex.ofReal_cosh, Complex.ofReal_sinh])
          -- 右の `rw` は値の像 `(cosh K_1)_ℂ` を mathlib の `Complex.cosh` で書き直す段（人手の行ではない）

/-- **原文 第 2 式**: `T_{(V_1^{(+)})^{1/2}}(check(Y)_μ)
= -i e^{iθ~_μ} sinh(K_1) check(Z)_μ + cosh(K_1) check(Y)_μ`。 -/
theorem TConj_V1plusHalf_checkY (hM : M ≠ 0) (K1 : ℝ) (μ : ℤ) :
    TConj (V1plusHalfUnits M K1) (checkY M μ)
      = (-Complex.I * checkPhase M (-1) μ * Complex.sinh K1) • checkZ M μ
        + Complex.cosh K1 • checkY M μ := by
  calc TConj (V1plusHalfUnits M K1) (checkY M μ)
      -- `def_T_g`
      = ((V1plusHalfUnits M K1 : (TensorPow M)ˣ) : TensorPow M) * checkY M μ *
          (((V1plusHalfUnits M K1)⁻¹ : (TensorPow M)ˣ) : TensorPow M) := TConj_apply _ _
      -- `def_V1_plus_square_root`
    _ = matExp (((1 / 2 : ℂ) * Complex.I * K1) • H1plus M) * checkY M μ *
          (((matExpUnits (((1 / 2 : ℂ) * Complex.I * K1) • H1plus M))⁻¹ : (TensorPow M)ˣ) :
            TensorPow M) := by rw [V1plusHalfUnits_val, V1plusHalf]; rfl
      -- `matrix_exp_conjugation` (3): `exp(X)^{-1} = exp(-X)`
    _ = matExp (((1 / 2 : ℂ) * Complex.I * K1) • H1plus M) * checkY M μ *
          matExp (-(((1 / 2 : ℂ) * Complex.I * K1) • H1plus M)) := by rw [matExpUnits_inv]
      -- `exp_X_Y_exp_-X`
    _ = ∑' n : ℕ, ((n.factorial : ℂ))⁻¹ •
          adPow (((1 / 2 : ℂ) * Complex.I * K1) • H1plus M) n (checkY M μ) :=
        matExp_conj_eq_tsum _ _
      -- `extract_taylor_coefficient_of_check_Z_Y` (h1.y)
    _ = (-Complex.I * checkPhase M (-1) μ * Complex.sinh K1) • checkZ M μ
          + Complex.cosh K1 • checkY M μ :=
        (extract_taylor_H1Plus_checkY hM K1 μ).2.trans (by
          rw [Complex.ofReal_cosh, Complex.ofReal_sinh])
          -- 右の `rw` は値の像 `(cosh K_1)_ℂ` を mathlib の `Complex.cosh` で書き直す段（人手の行ではない）

/-- 人手に無い一般化 `V2H2Form` 版（`TConj_V2H2Form_checkZ`・`_checkY`）で、前因子 `c = (2s_2)^{M/2}` を打ち消す段。
`V2H2FormUnits` の逆元の係数は複素数の逆数 `c^{-1}` なので、人手の `V_2` 版（人手の 6〜13 行目、`TConj_V2_checkZ` の calc の 4〜11 段。
`(a^{-1})_ℂ` と `real_inclusion_preserves_product`）とは手順が違い、mathlib の `smul_comm`・`mul_inv_cancel₀` で閉じる。 -/
theorem smul_conj_smul_inv_eq {s2 : ℝ} (hs2 : 0 < s2) (X A : TensorPow M) :
    ((((2 * s2) ^ ((M : ℝ) / 2) : ℝ) : ℂ) • matExp X) * A *
        (((((2 * s2) ^ ((M : ℝ) / 2) : ℝ) : ℂ))⁻¹ • matExp (-X))
      = matExp X * A * matExp (-X) := by
  set c : ℂ := (((2 * s2) ^ ((M : ℝ) / 2) : ℝ) : ℂ) with hc
  calc (c • matExp X) * A * (c⁻¹ • matExp (-X))
      -- `scalar_identity_commutes`（スカラー `c^{-1}` を左端へ移す）
      = c • c⁻¹ • (matExp X * A * matExp (-X)) := by
        rw [mul_smul_comm, smul_mul_assoc, smul_mul_assoc, smul_comm]
      -- `(2s_2)^{M/2}((2s_2)^{M/2})^{-1} = 1`
    _ = matExp X * A * matExp (-X) := by
        rw [smul_smul, mul_inv_cancel₀ (rpow_two_s2_ne_zero hs2 M), one_smul]

/-- **原文 第 3 式**（`V_2` を `V2_exponential_representation` の右辺 `V2H2Form` で書いた形）:
`T_{V_2}(check(Z)_μ) = cosh(2K_2^*) check(Z)_μ - i sinh(2K_2^*) check(Y)_μ`。 -/
theorem TConj_V2H2Form_checkZ {s2 : ℝ} (hs2 : 0 < s2) (K2star : ℝ) (μ : ℤ) :
    TConj (V2H2FormUnits M hs2 K2star) (checkZ M μ)
      = Complex.cosh (2 * K2star) • checkZ M μ
        + (-Complex.I * Complex.sinh (2 * K2star)) • checkY M μ := by
  calc TConj (V2H2FormUnits M hs2 K2star) (checkZ M μ)
      -- `def_T_g`
      = ((V2H2FormUnits M hs2 K2star : (TensorPow M)ˣ) : TensorPow M) * checkZ M μ *
          (((V2H2FormUnits M hs2 K2star)⁻¹ : (TensorPow M)ˣ) : TensorPow M) := TConj_apply _ _
      -- `V2_exponential_representation` の右辺と `V_2^{-1}` の表示
    _ = ((((2 * s2) ^ ((M : ℝ) / 2) : ℝ) : ℂ) • matExp ((Complex.I * K2star) • H2 M)) *
          checkZ M μ *
          (((((2 * s2) ^ ((M : ℝ) / 2) : ℝ) : ℂ))⁻¹ •
            matExp (-((Complex.I * K2star) • H2 M))) := rfl
      -- `scalar_identity_commutes` と `(2s_2)^{M/2}((2s_2)^{M/2})^{-1} = 1`
    _ = matExp ((Complex.I * K2star) • H2 M) * checkZ M μ *
          matExp (-((Complex.I * K2star) • H2 M)) := smul_conj_smul_inv_eq hs2 _ _
      -- `exp_X_Y_exp_-X`
    _ = ∑' n : ℕ, ((n.factorial : ℂ))⁻¹ • adPow ((Complex.I * K2star) • H2 M) n (checkZ M μ) :=
        matExp_conj_eq_tsum _ _
      -- `extract_taylor_coefficient_of_check_Z_Y` (h2.z)
    _ = Complex.cosh (2 * K2star) • checkZ M μ
          + (-Complex.I * Complex.sinh (2 * K2star)) • checkY M μ :=
        (extract_taylor_H2_checkZ K2star μ).2.trans (by
          simp only [Complex.ofReal_cosh, Complex.ofReal_sinh, Complex.ofReal_mul, Complex.ofReal_ofNat])
          -- 右の `simp only` は値の像 `(cosh 2K_2^*)_ℂ` を mathlib の `Complex.cosh` で書き直す段（人手の行ではない）

/-- **原文 第 4 式**（`V_2` を `V2H2Form` で書いた形）:
`T_{V_2}(check(Y)_μ) = i sinh(2K_2^*) check(Z)_μ + cosh(2K_2^*) check(Y)_μ`。 -/
theorem TConj_V2H2Form_checkY {s2 : ℝ} (hs2 : 0 < s2) (K2star : ℝ) (μ : ℤ) :
    TConj (V2H2FormUnits M hs2 K2star) (checkY M μ)
      = (Complex.I * Complex.sinh (2 * K2star)) • checkZ M μ
        + Complex.cosh (2 * K2star) • checkY M μ := by
  calc TConj (V2H2FormUnits M hs2 K2star) (checkY M μ)
      -- `def_T_g`
      = ((V2H2FormUnits M hs2 K2star : (TensorPow M)ˣ) : TensorPow M) * checkY M μ *
          (((V2H2FormUnits M hs2 K2star)⁻¹ : (TensorPow M)ˣ) : TensorPow M) := TConj_apply _ _
      -- `V2_exponential_representation` の右辺と `V_2^{-1}` の表示
    _ = ((((2 * s2) ^ ((M : ℝ) / 2) : ℝ) : ℂ) • matExp ((Complex.I * K2star) • H2 M)) *
          checkY M μ *
          (((((2 * s2) ^ ((M : ℝ) / 2) : ℝ) : ℂ))⁻¹ •
            matExp (-((Complex.I * K2star) • H2 M))) := rfl
      -- `scalar_identity_commutes` と `(2s_2)^{M/2}((2s_2)^{M/2})^{-1} = 1`
    _ = matExp ((Complex.I * K2star) • H2 M) * checkY M μ *
          matExp (-((Complex.I * K2star) • H2 M)) := smul_conj_smul_inv_eq hs2 _ _
      -- `exp_X_Y_exp_-X`
    _ = ∑' n : ℕ, ((n.factorial : ℂ))⁻¹ • adPow ((Complex.I * K2star) • H2 M) n (checkY M μ) :=
        matExp_conj_eq_tsum _ _
      -- `extract_taylor_coefficient_of_check_Z_Y` (h2.y)
    _ = (Complex.I * Complex.sinh (2 * K2star)) • checkZ M μ
          + Complex.cosh (2 * K2star) • checkY M μ :=
        (extract_taylor_H2_checkY K2star μ).2.trans (by
          simp only [Complex.ofReal_cosh, Complex.ofReal_sinh, Complex.ofReal_mul, Complex.ofReal_ofNat])
          -- 右の `simp only` は値の像 `(cosh 2K_2^*)_ℂ` を mathlib の `Complex.cosh` で書き直す段（人手の行ではない）

/-- **原文 第 3 式**（`V_2` は `def_transfer_matrix` の `V_2`、`K_2^*` はその双対結合定数）:
`T_{V_2}(check(Z)_μ) = (cosh 2K_2^*)_ℂ check(Z)_μ + ((-i)(sinh 2K_2^*)_ℂ) check(Y)_μ`。
人手の `T_{V_2}(check(Z)_μ)` の鎖と 1 対 1（3〜5 行目は 1 段、`Y = G_2` と `(1/n!)_ℂ` の行は段を持たない）。
最後の行（`def_pair_of_matrices_times_column_of_numbers`）は `actsBy_TConj_V2_check` が受け持つ。 -/
theorem TConj_V2_checkZ {K2 : ℝ} (hK2 : 0 < K2) (μ : ℤ) :
    TConj (V2Units M hK2) (checkZ M μ)
      = ((Real.cosh (2 * Kstar K2) : ℝ) : ℂ) • checkZ M μ
          + (-Complex.I * ((Real.sinh (2 * Kstar K2) : ℝ) : ℂ)) • checkY M μ := by
  set a : ℝ := (2 * Real.sinh (2 * K2)) ^ ((M : ℝ) / 2) with ha
  set Y : TensorPow M := (Complex.I * ((Kstar K2 : ℝ) : ℂ)) • H2 M with hY
  have hane : a ≠ 0 := ne_of_gt (V2_prefactor_pos hK2 M)
  calc TConj (V2Units M hK2) (checkZ M μ)
      = ((V2Units M hK2 : (TensorPow M)ˣ) : TensorPow M) * checkZ M μ *
          (((V2Units M hK2)⁻¹ : (TensorPow M)ˣ) : TensorPow M) := TConj_apply _ _
        -- `def_T_g`（`g → V_2`, `h → Ž_μ`）
    _ = V2 M K2 * checkZ M μ * (((a⁻¹ : ℝ) : ℂ) • matExp (-Y)) := by
        rw [V2Units_inv_val]; rfl                          -- `V2_invertible`
    _ = ((a : ℂ) • matExp Y) * checkZ M μ * (((a⁻¹ : ℝ) : ℂ) • matExp (-Y)) := by
        rw [V2_exponential_representation hK2]; rfl
        -- `V2_exponential_representation`、`V2_invertible` の `a`・`Y`（`K_2^*`・`a` は `inclusion_rr_to_cc` の像）
    _ = ((a : ℂ) • (matExp Y * checkZ M μ)) * (((a⁻¹ : ℝ) : ℂ) • matExp (-Y)) := by
        rw [smul_mul_matrix_tensorPow]                     -- `scalar_multiple_factors_out_of_left_factor`
    _ = (a : ℂ) • ((matExp Y * checkZ M μ) * (((a⁻¹ : ℝ) : ℂ) • matExp (-Y))) :=
        smul_mul_matrix_tensorPow _ _ _                    -- `scalar_multiple_factors_out_of_left_factor`
    _ = (a : ℂ) • (((a⁻¹ : ℝ) : ℂ) • ((matExp Y * checkZ M μ) * matExp (-Y))) := by
        rw [mul_smul_matrix_tensorPow]                     -- `scalar_multiple_factors_out_of_right_factor`
    _ = ((a : ℂ) * ((a⁻¹ : ℝ) : ℂ)) • ((matExp Y * checkZ M μ) * matExp (-Y)) :=
        smul_smul _ _ _                                    -- `scalar_multiple_is_associative`（mathlib の `smul_smul`）
    _ = ((a * a⁻¹ : ℝ) : ℂ) • ((matExp Y * checkZ M μ) * matExp (-Y)) := by
        rw [real_inclusion_mul]                            -- `real_inclusion_preserves_product`（`a → a`, `b → a^{-1}`）
    _ = ((1 : ℝ) : ℂ) • ((matExp Y * checkZ M μ) * matExp (-Y)) := by
        rw [mul_inv_cancel₀ hane]                          -- ℝ で `aa^{-1} = 1`
    _ = (1 : ℂ) • ((matExp Y * checkZ M μ) * matExp (-Y)) := by
        rw [Complex.ofReal_one]                            -- `1_ℂ` は `inclusion_rr_to_cc` の略記 `r_ℂ` の `r = 1`
    _ = (matExp Y * checkZ M μ) * matExp (-Y) :=
        one_smul_tensorPow _                               -- `scalar_multiple_by_one`
        -- 人手の次の行「準備の `Y = G_2`」は、Lean の `extract_taylor_H2_*` の生成子が `Y` と同じ式なので段を持たない
    _ = ∑' n : ℕ, ((n.factorial : ℂ))⁻¹ • adPow Y n (checkZ M μ) :=
        matExp_conj_eq_tsum _ _                            -- `exp_X_Y_exp_-X`（`X → G_2`, `Y → Ž_μ`）
        -- 人手の次の行（係数 `1/n!` を `(1/n!)_ℂ` と書く）は、Lean では係数が最初から `ℂ` の `(n! : ℂ)⁻¹` なので段を持たない
    _ = ((Real.cosh (2 * Kstar K2) : ℝ) : ℂ) • checkZ M μ
          + (-Complex.I * ((Real.sinh (2 * Kstar K2) : ℝ) : ℂ)) • checkY M μ :=
        (extract_taylor_H2_checkZ (Kstar K2) μ).2           -- `extract_taylor_coefficient_of_check_Z_Y` (h2.z)

/-- **原文 第 4 式**（`V_2` は `def_transfer_matrix` の `V_2`）:
`T_{V_2}(check(Y)_μ) = (i(sinh 2K_2^*)_ℂ) check(Z)_μ + (cosh 2K_2^*)_ℂ check(Y)_μ`。
人手の `T_{V_2}(check(Y)_μ)` の鎖と 1 対 1（`TConj_V2_checkZ` と同じ段の分け方）。 -/
theorem TConj_V2_checkY {K2 : ℝ} (hK2 : 0 < K2) (μ : ℤ) :
    TConj (V2Units M hK2) (checkY M μ)
      = (Complex.I * ((Real.sinh (2 * Kstar K2) : ℝ) : ℂ)) • checkZ M μ
          + ((Real.cosh (2 * Kstar K2) : ℝ) : ℂ) • checkY M μ := by
  set a : ℝ := (2 * Real.sinh (2 * K2)) ^ ((M : ℝ) / 2) with ha
  set Y : TensorPow M := (Complex.I * ((Kstar K2 : ℝ) : ℂ)) • H2 M with hY
  have hane : a ≠ 0 := ne_of_gt (V2_prefactor_pos hK2 M)
  calc TConj (V2Units M hK2) (checkY M μ)
      = ((V2Units M hK2 : (TensorPow M)ˣ) : TensorPow M) * checkY M μ *
          (((V2Units M hK2)⁻¹ : (TensorPow M)ˣ) : TensorPow M) := TConj_apply _ _
        -- `def_T_g`（`g → V_2`, `h → Y̌_μ`）
    _ = V2 M K2 * checkY M μ * (((a⁻¹ : ℝ) : ℂ) • matExp (-Y)) := by
        rw [V2Units_inv_val]; rfl                          -- `V2_invertible`
    _ = ((a : ℂ) • matExp Y) * checkY M μ * (((a⁻¹ : ℝ) : ℂ) • matExp (-Y)) := by
        rw [V2_exponential_representation hK2]; rfl
        -- `V2_exponential_representation`、`V2_invertible` の `a`・`Y`（`K_2^*`・`a` は `inclusion_rr_to_cc` の像）
    _ = ((a : ℂ) • (matExp Y * checkY M μ)) * (((a⁻¹ : ℝ) : ℂ) • matExp (-Y)) := by
        rw [smul_mul_matrix_tensorPow]                     -- `scalar_multiple_factors_out_of_left_factor`
    _ = (a : ℂ) • ((matExp Y * checkY M μ) * (((a⁻¹ : ℝ) : ℂ) • matExp (-Y))) :=
        smul_mul_matrix_tensorPow _ _ _                    -- `scalar_multiple_factors_out_of_left_factor`
    _ = (a : ℂ) • (((a⁻¹ : ℝ) : ℂ) • ((matExp Y * checkY M μ) * matExp (-Y))) := by
        rw [mul_smul_matrix_tensorPow]                     -- `scalar_multiple_factors_out_of_right_factor`
    _ = ((a : ℂ) * ((a⁻¹ : ℝ) : ℂ)) • ((matExp Y * checkY M μ) * matExp (-Y)) :=
        smul_smul _ _ _                                    -- `scalar_multiple_is_associative`（mathlib の `smul_smul`）
    _ = ((a * a⁻¹ : ℝ) : ℂ) • ((matExp Y * checkY M μ) * matExp (-Y)) := by
        rw [real_inclusion_mul]                            -- `real_inclusion_preserves_product`（`a → a`, `b → a^{-1}`）
    _ = ((1 : ℝ) : ℂ) • ((matExp Y * checkY M μ) * matExp (-Y)) := by
        rw [mul_inv_cancel₀ hane]                          -- ℝ で `aa^{-1} = 1`
    _ = (1 : ℂ) • ((matExp Y * checkY M μ) * matExp (-Y)) := by
        rw [Complex.ofReal_one]                            -- `1_ℂ` は `inclusion_rr_to_cc` の略記 `r_ℂ` の `r = 1`
    _ = (matExp Y * checkY M μ) * matExp (-Y) :=
        one_smul_tensorPow _                               -- `scalar_multiple_by_one`
        -- 人手の次の行「準備の `Y = G_2`」は、Lean の `extract_taylor_H2_*` の生成子が `Y` と同じ式なので段を持たない
    _ = ∑' n : ℕ, ((n.factorial : ℂ))⁻¹ • adPow Y n (checkY M μ) :=
        matExp_conj_eq_tsum _ _                            -- `exp_X_Y_exp_-X`（`X → G_2`, `Y → Y̌_μ`）
        -- 人手の次の行（係数 `1/n!` を `(1/n!)_ℂ` と書く）は、Lean では係数が最初から `ℂ` の `(n! : ℂ)⁻¹` なので段を持たない
    _ = (Complex.I * ((Real.sinh (2 * Kstar K2) : ℝ) : ℂ)) • checkZ M μ
          + ((Real.cosh (2 * Kstar K2) : ℝ) : ℂ) • checkY M μ :=
        (extract_taylor_H2_checkY (Kstar K2) μ).2           -- `extract_taylor_coefficient_of_check_Z_Y` (h2.y)

/-! ## 原文 `calc_of_TxT_check_Z_Y`（4 式を 2 列に並べる） -/

/-- **原文 `calc_of_TxT_check_Z_Y` の第 1 式**:
`(T_{(V_1^{(+)})^{1/2}}(check(Z)_μ), T_{(V_1^{(+)})^{1/2}}(check(Y)_μ)) = (check(Z)_μ, check(Y)_μ) B_1(θ~_μ)`。
`T_actions_on_check_Z_Y` の第 1・第 2 式を 2 列へ同時に使い（`ActsBy` の定義が行ベクトルと行列の積の定義）、
`def_B1_theta_B2` の成分と突き合わせる。 -/
theorem actsBy_TConj_V1plusHalf (hM : M ≠ 0) (K1 : ℝ) (μ : ℤ) :
    ActsBy (TConj (V1plusHalfUnits M K1)).toLinearMap (checkZ M μ) (checkY M μ)
      (B1mat K1 ((thetaTilde M μ : ℝ) : ℂ)) := by
  constructor
  · change TConj (V1plusHalfUnits M K1) (checkZ M μ) = _
    rw [TConj_V1plusHalf_checkZ hM K1 μ, B1mat_zero_zero, B1mat_one_zero,
      checkPhase_one_eq_exp hM μ]
  · change TConj (V1plusHalfUnits M K1) (checkY M μ) = _
    rw [TConj_V1plusHalf_checkY hM K1 μ, B1mat_zero_one, B1mat_one_one,
      checkPhase_neg_one_eq_exp hM μ]

/-- **原文 `calc_of_TxT_check_Z_Y` の第 2 式**:
`(T_{V_2}(check(Z)_μ), T_{V_2}(check(Y)_μ)) = (check(Z)_μ, check(Y)_μ) B_2`
（`V_2` は `V2H2Form`。人手の `V_2` 版は `actsBy_TConj_V2_check`）。 -/
theorem actsBy_TConj_V2H2Form_check {s2 : ℝ} (hs2 : 0 < s2) (K2star : ℝ) (μ : ℤ) :
    ActsBy (TConj (V2H2FormUnits M hs2 K2star)).toLinearMap (checkZ M μ) (checkY M μ)
      (B2mat K2star) := by
  constructor
  · change TConj (V2H2FormUnits M hs2 K2star) (checkZ M μ) = _
    rw [TConj_V2H2Form_checkZ hs2 K2star μ, B2mat_zero_zero, B2mat_one_zero]
  · change TConj (V2H2FormUnits M hs2 K2star) (checkY M μ) = _
    rw [TConj_V2H2Form_checkY hs2 K2star μ, B2mat_zero_one, B2mat_one_one]

/-- **原文 `calc_of_TxT_check_Z_Y` の第 2 式**（`V_2` は `def_transfer_matrix` の `V_2`）:
`(T_{V_2}(check(Z)_μ), T_{V_2}(check(Y)_μ)) = (check(Z)_μ, check(Y)_μ) B_2`。 -/
theorem actsBy_TConj_V2_check {K2 : ℝ} (hK2 : 0 < K2) (μ : ℤ) :
    ActsBy (TConj (V2Units M hK2)).toLinearMap (checkZ M μ) (checkY M μ)
      (B2mat ((Kstar K2 : ℝ) : ℂ)) := by
  constructor
  · change TConj (V2Units M hK2) (checkZ M μ) = _
    rw [TConj_V2_checkZ hK2 μ, B2mat_zero_zero, B2mat_one_zero]
    -- Lean の `B2mat` の成分は複素数の `cosh`・`sinh` で、人手 `def_B1_theta_B2` の像 `(cosh 2K_2^*)_ℂ` と定義が違う。
    -- その読み替えの段（人手の行ではない）
    simp only [Complex.ofReal_cosh, Complex.ofReal_sinh, Complex.ofReal_mul, Complex.ofReal_ofNat]
  · change TConj (V2Units M hK2) (checkY M μ) = _
    rw [TConj_V2_checkY hK2 μ, B2mat_zero_one, B2mat_one_one]
    -- `B2mat` の成分の読み替えの段（上と同じ。人手の行ではない）
    simp only [Complex.ofReal_cosh, Complex.ofReal_sinh, Complex.ofReal_mul, Complex.ofReal_ofNat]

/-! ## 共役写像の一般線型性と半指数行列への特殊化 -/

/-- **本文 `linearity_of_T` の具体版**: 人手の鎖の 6 行と 1 対 1 の `calc`（`T_g(h)` は `(gh)g^{-1}`。Lean の `TConj_apply` も同じ括弧）。 -/
theorem linearity_of_T_on_check (g : (TensorPow M)ˣ) (a b : ℂ) (X W : TensorPow M) :
    TConj g (a • X + b • W) = a • TConj g X + b • TConj g W :=
  calc TConj g (a • X + b • W)
      = ((g : TensorPow M) * (a • X + b • W)) * ((g⁻¹ : (TensorPow M)ˣ) : TensorPow M) :=
        TConj_apply _ _                                                          -- `def_T_g`
    _ = ((g : TensorPow M) * (a • X) + (g : TensorPow M) * (b • W))
          * ((g⁻¹ : (TensorPow M)ˣ) : TensorPow M) := by
        rw [mul_add_matrix_tensorPow]                                            -- `mat_mult_distributes_over_sum_in_right_factor`
    _ = ((g : TensorPow M) * (a • X)) * ((g⁻¹ : (TensorPow M)ˣ) : TensorPow M)
          + ((g : TensorPow M) * (b • W)) * ((g⁻¹ : (TensorPow M)ˣ) : TensorPow M) :=
        add_mul_matrix_tensorPow _ _ _                                           -- `mat_mult_distributes_over_sum_in_left_factor`
    _ = (a • ((g : TensorPow M) * X)) * ((g⁻¹ : (TensorPow M)ˣ) : TensorPow M)
          + (b • ((g : TensorPow M) * W)) * ((g⁻¹ : (TensorPow M)ˣ) : TensorPow M) := by
        rw [mul_smul_matrix_tensorPow a, mul_smul_matrix_tensorPow b]            -- `scalar_multiple_factors_out_of_right_factor` を 2 か所
    _ = a • (((g : TensorPow M) * X) * ((g⁻¹ : (TensorPow M)ˣ) : TensorPow M))
          + b • (((g : TensorPow M) * W) * ((g⁻¹ : (TensorPow M)ˣ) : TensorPow M)) := by
        rw [smul_mul_matrix_tensorPow a, smul_mul_matrix_tensorPow b]            -- `scalar_multiple_factors_out_of_left_factor` を 2 か所
    _ = a • TConj g X + b • TConj g W := by
        rw [TConj_apply, TConj_apply]                                            -- `def_T_g` を 2 か所

/-- 具体版が必要十分版 `TConj_linear` の有限複素行列への特殊化であることを記録する。 -/
theorem linearity_of_T_on_check_from_general (g : (TensorPow M)ˣ)
    (a b : ℂ) (X W : TensorPow M) :
    TConj g (a • X + b • W) = a • TConj g X + b • TConj g W :=
  TConj_linear g a b X W

/-- **本文 `linearity_of_T_on_check_Z_Y`**: `g = (V_1^{(+)})^{1/2}` への特殊化。
人手は `μ ∈ M̌` について述べるが、証明（`linearity_of_T` の代入）は `μ` の範囲を使わないので、
`T_V_plus_check_Z_Y`（`TVPlus_checkZ_checkY`）と同じく任意の `μ : ℤ` について述べる。 -/
theorem linearity_of_T_V1plusHalf (K1 : ℂ) (a b : ℂ) (μ : ℤ) :
    TConj (V1plusHalfUnits M K1) (a • checkZ M μ + b • checkY M μ)
      = a • TConj (V1plusHalfUnits M K1) (checkZ M μ)
        + b • TConj (V1plusHalfUnits M K1) (checkY M μ) :=
  linearity_of_T_on_check _ a b _ _

/-- **本文 `linearity_of_T_V2`**: `g = V_2`（`def_transfer_matrix` の `V_2`、`V2_invertible` による単元）への特殊化。
`μ` の範囲は `linearity_of_T_V1plusHalf` と同じ理由で置かない。 -/
theorem linearity_of_T_V2 {K2 : ℝ} (hK2 : 0 < K2)
    (a b : ℂ) (μ : ℤ) :
    TConj (V2Units M hK2) (a • checkZ M μ + b • checkY M μ)
      = a • TConj (V2Units M hK2) (checkZ M μ)
        + b • TConj (V2Units M hK2) (checkY M μ) :=
  linearity_of_T_on_check _ a b _ _

/-- 本文 `linearity_of_T_V2` を、`V_2` の代わりに `V2H2Form`（`s2`, `K2star` は独立な引数）で述べた一般化。
人手の `V_2` についての主張は `linearity_of_T_V2`。 -/
theorem linearity_of_T_V2H2Form {s2 : ℝ} (hs2 : 0 < s2)
    (K2star : ℂ) (a b : ℂ) (μ : ℤ) :
    TConj (V2H2FormUnits M hs2 K2star) (a • checkZ M μ + b • checkY M μ)
      = a • TConj (V2H2FormUnits M hs2 K2star) (checkZ M μ)
        + b • TConj (V2H2FormUnits M hs2 K2star) (checkY M μ) :=
  linearity_of_T_on_check _ a b _ _

end Ising2D
