/-
# `Z, Y` は `Mat(2, ℂ)^{⊗M}` を環として生成する

対応する人手証明:
`parts/004_転送行列/014_claim_Z_YはMat2C^Mを環として生成する.typ` (`<Z_Y_generate_algebra>`)

原文の主張: `S = {Z_1, …, Z_M, Y_1, …, Y_M}` を含む最小の ℂ-部分多元環 `𝒜` は
`Mat(2, ℂ)^{⊗M}` 全体に一致する。

Lean では「`S` を含む最小の ℂ-部分多元環」を mathlib の `Algebra.adjoin ℂ S`
（`Subalgebra ℂ (TensorPow M)`）とし、結論を `Algebra.adjoin ℂ (ZYSet M) = ⊤` と述べる。

## 原文の証明との対応

| 原文 | Lean |
| --- | --- |
| Step 1（単一サイトの積公式・異サイト可換性） | `Ising2D/PartitionFunction/ProjectionAndJordanWigner/DefinitionTransferMatrixSymbols.lean` の `pauli*`, `siteOp_mul_same`, `siteOp_mul_comm` |
| Step 2（帰納法で `σ^x_m, σ^y_m, σ^z_m ∈ 𝒜`） | `xString_mem_adjoin`, `sigmaX_mem_adjoin` ほか |
| Step 3 前半（`{I, σ^x, σ^y, σ^z}` は `Mat(2,ℂ)` の基底） | 準備 (a)〜(g) は `zy_prep_two_mul_mul_inv_two`・`zy_prep_add_self`・`zy_prep_add_neg`・`zy_prep_sum_add_diff`・`zy_prep_sum_sub_diff`・`zy_prep_I_mul_I`・`zy_prep_neg_I_mul_I`、4 成分の鎖は `pauliDecompRhs_apply_00`〜`_11`、展開の式は `matrix_two_decomp` |
| Step 3 後半（基底のテンソル積が全体を張る） | `matrixUnitBasis`（`Ising2D/Representation.lean`）+ `E_eq_siteProd` |

Step 3 後半だけ原文と経路が違う。原文は基底として `{I, σ^x, σ^y, σ^z}^{⊗M}` を取り
`<tensor_basis>` を引くが、Lean では既に形式化済みの**行列単位の基底**
`matrixUnitBasis`（これも `<tensor_basis>` の帰結）を使うほうが短い。
どちらも「`𝒜` は ℂ-線型結合で閉じた部分空間で、ある基底を全部含むから全体」という論法で同じ。
-/
import Ising2D.PartitionFunction.ProjectionAndJordanWigner.DefinitionTransferMatrixSymbols
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimExpOfNegativeIRealAsCosMinusISin
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimAddAndSubtractZeroMatrix

namespace Ising2D

variable {M : ℕ}

/-! ## 生成元の集合 -/

/-- 原文の `S = {Z_1, …, Z_M, Y_1, …, Y_M}`。 -/
noncomputable def ZYSet (M : ℕ) : Set (TensorPow M) :=
  Set.range (Z : Fin M → TensorPow M) ∪ Set.range (Y : Fin M → TensorPow M)

theorem Z_mem_adjoin (m : Fin M) : Z m ∈ Algebra.adjoin ℂ (ZYSet M) :=
  Algebra.subset_adjoin (Or.inl ⟨m, rfl⟩)

theorem Y_mem_adjoin (m : Fin M) : Y m ∈ Algebra.adjoin ℂ (ZYSet M) :=
  Algebra.subset_adjoin (Or.inr ⟨m, rfl⟩)

/-! ## Step 2: `σ^x_k, σ^y_k, σ^z_k ∈ 𝒜`

原文の帰納法（`P_{m-1} = σ^x_1 ⋯ σ^x_{m-1} ∈ 𝒜` を仮定して
`σ^z_m = P_{m-1} Z_m`, `σ^y_m = P_{m-1} Y_m`, `σ^x_m = -√-1 σ^y_m σ^z_m` を得る）
をそのまま写したもの。 -/

/-- 原文 Step 2 の `σ^z_m = P_{m-1} Z_m`（`P_{m-1} P_{m-1} = I` を使う）。 -/
theorem sigmaZ_eq_xString_mul (k : Fin M) : sigmaZ k = xString M (k : ℕ) * Z k := by
  rw [Z_eq_xString_mul, ← mul_assoc, xString_mul_self, one_mul]

/-- 原文 Step 2 の `σ^y_m = P_{m-1} Y_m`。 -/
theorem sigmaY_eq_xString_mul (k : Fin M) : sigmaY k = xString M (k : ℕ) * Y k := by
  rw [Y_eq_xString_mul, ← mul_assoc, xString_mul_self, one_mul]

/-- 原文 Step 2 の帰納法の本体: `P_m = σ^x_1 ⋯ σ^x_m ∈ 𝒜`。 -/
theorem xString_mem_adjoin : ∀ n : ℕ, n ≤ M → xString M n ∈ Algebra.adjoin ℂ (ZYSet M) := by
  intro n
  induction n with
  | zero =>
      intro _
      rw [xString_zero]
      exact one_mem _
  | succ n ih =>
      intro hn
      have hnM : n < M := hn
      have hx : xString M n ∈ Algebra.adjoin ℂ (ZYSet M) := ih (le_of_lt hnM)
      have hZ : sigmaZ (⟨n, hnM⟩ : Fin M) ∈ Algebra.adjoin ℂ (ZYSet M) := by
        rw [sigmaZ_eq_xString_mul]
        exact mul_mem hx (Z_mem_adjoin _)
      have hY : sigmaY (⟨n, hnM⟩ : Fin M) ∈ Algebra.adjoin ℂ (ZYSet M) := by
        rw [sigmaY_eq_xString_mul]
        exact mul_mem hx (Y_mem_adjoin _)
      have hX : sigmaX (⟨n, hnM⟩ : Fin M) ∈ Algebra.adjoin ℂ (ZYSet M) := by
        rw [sigmaX_eq]
        exact Subalgebra.smul_mem _ (mul_mem hY hZ) _
      rw [xString_succ n hnM]
      exact mul_mem hx hX

theorem sigmaZ_mem_adjoin (k : Fin M) : sigmaZ k ∈ Algebra.adjoin ℂ (ZYSet M) := by
  rw [sigmaZ_eq_xString_mul]
  exact mul_mem (xString_mem_adjoin _ (le_of_lt k.isLt)) (Z_mem_adjoin k)

theorem sigmaY_mem_adjoin (k : Fin M) : sigmaY k ∈ Algebra.adjoin ℂ (ZYSet M) := by
  rw [sigmaY_eq_xString_mul]
  exact mul_mem (xString_mem_adjoin _ (le_of_lt k.isLt)) (Y_mem_adjoin k)

theorem sigmaX_mem_adjoin (k : Fin M) : sigmaX k ∈ Algebra.adjoin ℂ (ZYSet M) := by
  rw [sigmaX_eq]
  exact Subalgebra.smul_mem _ (mul_mem (sigmaY_mem_adjoin k) (sigmaZ_mem_adjoin k)) _

/-! ## Step 3 前半: `{I, σ^x, σ^y, σ^z}` は `Mat(2, ℂ)` の基底

人手証明の Step 3 は、係数 `κ_0 := (a₁₁+a₂₂)/2_ℂ`・`κ_x := (a₁₂+a₂₁)/2_ℂ`・`κ_y := (i(a₁₂−a₂₁))/2_ℂ`・
`κ_z := (a₁₁−a₂₂)/2_ℂ` を `def_complex_quotient` の商（`w → 2_ℂ`）と読み、準備 (a)〜(g) を置いてから、
右辺 `R` の 4 成分の鎖を書く。以下の補題はその準備と 4 本の鎖を 1 行ずつ辿る（人手の添字 `1, 2` は Lean では `0, 1`）。
Lean の `z / 2` は `div_eq_mul_inv`（`def_complex_quotient`）で `z * 2⁻¹` に開く。`2_ℂ ∈ ℂ^×` は
`exp_neg_I_prep_two_ne_zero`（`inclusion_rr_to_cc` の第 1 成分の比較）である。 -/

/-- 人手 Step 3 の準備 (a): `(2_ℂ z) 2_ℂ^{-1} = z`。 -/
theorem zy_prep_two_mul_mul_inv_two (z : ℂ) : (2 * z) * 2⁻¹ = z := by
  calc (2 * z) * 2⁻¹
      = (z * 2) * 2⁻¹ := by rw [mul_comm 2 z]                         -- 積の可換律
    _ = z * (2 * 2⁻¹) := mul_assoc _ _ _                              -- 積の結合律
    _ = z * 1 := by rw [mul_inv_cancel₀ exp_neg_I_prep_two_ne_zero]   -- `multiplicative_group_of_cc` の逆元（`2_ℂ ∈ ℂ^×`）
    _ = z := mul_one z                                                -- 積の単位元

/-- 人手 Step 3 の準備 (b): `z + z = 2_ℂ z`。 -/
theorem zy_prep_add_self (z : ℂ) : z + z = 2 * z := by
  calc z + z
      = 1 * z + 1 * z := by rw [one_mul]                              -- 積の単位元を 2 か所へ右辺から左辺へ
    _ = (1 + 1) * z := (add_mul _ _ _).symm                           -- 分配律を右辺から左辺へ
    _ = 2 * z := by rw [complex_one_add_one]                          -- `one_plus_one_is_two_in_cc`

/-- 人手 Step 3 の準備 (c): `z + (−z) = 0_ℂ`。 -/
theorem zy_prep_add_neg (z : ℂ) : z + -z = 0 := by
  calc z + -z
      = z + (-1) * z := by rw [neg_one_mul]                           -- `multiply_by_minus_one`
    _ = 1 * z + (-1) * z := by rw [one_mul]                           -- 積の単位元を右辺から左辺へ
    _ = (1 + (-1)) * z := (add_mul _ _ _).symm                        -- 分配律を右辺から左辺へ
    _ = (((1 : ℝ) : ℂ) + ((-1 : ℝ) : ℂ)) * z := by
          rw [Complex.ofReal_neg, Complex.ofReal_one]                 -- `1_ℂ`・`-1_ℂ` は略記 `r_ℂ` の `r = 1`・`r = -1`
    _ = ((1 + (-1) : ℝ) : ℂ) * z := by rw [Complex.ofReal_add]        -- `real_inclusion_preserves_sum`（`a → 1, b → -1`）
    _ = ((0 : ℝ) : ℂ) * z := by rw [add_neg_cancel]                   -- `ℝ` で `1 + (-1) = 0`
    _ = 0 * z := by rw [Complex.ofReal_zero]                          -- `0_ℂ` は略記 `r_ℂ` の `r = 0`
    _ = 0 := zero_mul z                                               -- `complex_zero_times_is_zero`

/-- 人手 Step 3 の準備 (d): `(z + w) + (z − w) = 2_ℂ z`。 -/
theorem zy_prep_sum_add_diff (z w : ℂ) : (z + w) + (z - w) = 2 * z := by
  calc (z + w) + (z - w)
      = (z + w) + (z + -w) := by rw [sub_eq_add_neg]                  -- `def_complex_difference`
    _ = z + (w + (z + -w)) := add_assoc _ _ _                         -- 加法の結合律
    _ = z + ((w + z) + -w) := by rw [add_assoc w z (-w)]              -- 加法の結合律を右辺から左辺へ
    _ = z + ((z + w) + -w) := by rw [add_comm w z]                    -- 加法の可換律
    _ = z + (z + (w + -w)) := by rw [add_assoc z w (-w)]              -- 加法の結合律
    _ = z + (z + 0) := by rw [zy_prep_add_neg w]                      -- (c)（`z → w`）
    _ = z + z := by rw [add_zero]                                     -- 加法の単位元
    _ = 2 * z := zy_prep_add_self z                                   -- (b)

/-- 人手 Step 3 の準備 (e): `(z + w) − (z − w) = 2_ℂ w`。 -/
theorem zy_prep_sum_sub_diff (z w : ℂ) : (z + w) - (z - w) = 2 * w := by
  calc (z + w) - (z - w)
      = (z + w) + -(z - w) := sub_eq_add_neg _ _                      -- `def_complex_difference`（`z → z + w, w → z − w`）
    _ = (z + w) + -(z + -w) := by rw [sub_eq_add_neg z w]             -- `def_complex_difference`
    _ = (z + w) + (-1) * (z + -w) := by rw [neg_one_mul]              -- `multiply_by_minus_one`（`z → z + (−w)`）
    _ = (z + w) + ((-1) * z + (-1) * -w) := by rw [mul_add]           -- 分配律
    _ = (z + w) + (-z + (-1) * -w) := by rw [neg_one_mul z]           -- `multiply_by_minus_one` を右辺から左辺へ
    _ = (z + w) + (-z + (-1) * ((-1) * w)) := by rw [neg_one_mul w]   -- `multiply_by_minus_one`（`z → w`）
    _ = (z + w) + (-z + ((-1) * (-1)) * w) := by rw [mul_assoc]       -- 積の結合律を右辺から左辺へ
    _ = (z + w) + (-z + 1 * w) := by rw [complex_minus_one_mul_minus_one] -- `minus_one_times_minus_one_is_one_in_cc`
    _ = (z + w) + (-z + w) := by rw [one_mul]                         -- 積の単位元
    _ = (w + z) + (-z + w) := by rw [add_comm z w]                    -- 加法の可換律
    _ = w + (z + (-z + w)) := add_assoc _ _ _                         -- 加法の結合律
    _ = w + ((z + -z) + w) := by rw [add_assoc z (-z) w]              -- 加法の結合律を右辺から左辺へ
    _ = w + (0 + w) := by rw [zy_prep_add_neg z]                      -- (c)
    _ = w + w := by rw [zero_add]                                     -- 加法の単位元
    _ = 2 * w := zy_prep_add_self w                                   -- (b)（`z → w`）

/-- 人手 Step 3 の準備 (f): `ii = −1_ℂ`（人手の 4 行）。 -/
theorem zy_prep_I_mul_I : Complex.I * Complex.I = -1 :=
  calc Complex.I * Complex.I
      = (⟨0, 1⟩ : ℂ) * (⟨0, 1⟩ : ℂ) := rfl                             -- `def_imaginary_unit` を 2 か所へ
    _ = (⟨0 * 0 - 1 * 1, 0 * 1 + 1 * 0⟩ : ℂ) := rfl                   -- `definition_of_cc` の積
    _ = (⟨-1, 0⟩ : ℂ) := by norm_num                                  -- `ℝ` の四則
    _ = -1 := by
          rw [show (⟨-1, 0⟩ : ℂ) = ((-1 : ℝ) : ℂ) from rfl, Complex.ofReal_neg, Complex.ofReal_one]
                                                                      -- `-1_ℂ` は `inclusion_rr_to_cc` の略記 `r_ℂ` の `r = -1`

/-- 人手 Step 3 の準備 (g): `(−i) i = 1_ℂ`。 -/
theorem zy_prep_neg_I_mul_I : (-Complex.I) * Complex.I = 1 := by
  calc (-Complex.I) * Complex.I
      = -(Complex.I * Complex.I) := neg_I_mul_eq_neg_of_I_mul _         -- `negative_i_times_complex_is_negation_of_i_times`（`z → i`）
    _ = -(-1) := by rw [zy_prep_I_mul_I]                                -- (f)
    _ = (-1) * (-1) := (neg_one_mul (-1)).symm                          -- `multiply_by_minus_one`（`z → −1_ℂ`）
    _ = 1 := complex_minus_one_mul_minus_one                            -- `minus_one_times_minus_one_is_one_in_cc`

/-- 人手の証明の冒頭の Pauli 行列の成分。 -/
theorem pauliX_apply_00 : pauliX 0 0 = 0 := rfl
theorem pauliX_apply_01 : pauliX 0 1 = 1 := rfl
theorem pauliX_apply_10 : pauliX 1 0 = 1 := rfl
theorem pauliX_apply_11 : pauliX 1 1 = 0 := rfl
theorem pauliY_apply_00 : pauliY 0 0 = 0 := rfl
theorem pauliY_apply_01 : pauliY 0 1 = -Complex.I := rfl
theorem pauliY_apply_10 : pauliY 1 0 = Complex.I := rfl
theorem pauliY_apply_11 : pauliY 1 1 = 0 := rfl
theorem pauliZ_apply_00 : pauliZ 0 0 = 1 := rfl
theorem pauliZ_apply_01 : pauliZ 0 1 = 0 := rfl
theorem pauliZ_apply_10 : pauliZ 1 0 = 0 := rfl
theorem pauliZ_apply_11 : pauliZ 1 1 = -1 := rfl

/-- 人手 Step 3 の係数 `κ_0 := (a₁₁+a₂₂)/2_ℂ`。 -/
noncomputable def kappa0 (a d : ℂ) : ℂ := (a + d) / 2
/-- 人手 Step 3 の係数 `κ_x := (a₁₂+a₂₁)/2_ℂ`。 -/
noncomputable def kappaX (b c : ℂ) : ℂ := (b + c) / 2
/-- 人手 Step 3 の係数 `κ_y := (i(a₁₂−a₂₁))/2_ℂ`。 -/
noncomputable def kappaY (b c : ℂ) : ℂ := (Complex.I * (b - c)) / 2
/-- 人手 Step 3 の係数 `κ_z := (a₁₁−a₂₂)/2_ℂ`。 -/
noncomputable def kappaZ (a d : ℂ) : ℂ := (a - d) / 2

/-- 人手 Step 3 の右辺 `R := κ_0 I + κ_x σ^x + κ_y σ^y + κ_z σ^z`（成分 `a₁₁ = a`, `a₁₂ = b`, `a₂₁ = c`, `a₂₂ = d`）。 -/
noncomputable def pauliDecompRhs (a b c d : ℂ) : Matrix (Fin 2) (Fin 2) ℂ :=
  kappa0 a d • (1 : Matrix (Fin 2) (Fin 2) ℂ) + kappaX b c • pauliX
    + kappaY b c • pauliY + kappaZ a d • pauliZ

/-- 人手 Step 3 の `R_{11}` の鎖。 -/
theorem pauliDecompRhs_apply_00 (a b c d : ℂ) : pauliDecompRhs a b c d 0 0 = a := by
  calc pauliDecompRhs a b c d 0 0
      = (kappa0 a d • (1 : Matrix (Fin 2) (Fin 2) ℂ) + kappaX b c • pauliX
          + kappaY b c • pauliY + kappaZ a d • pauliZ) 0 0 := rfl
                                                                      -- `R` の定義
    _ = (((kappa0 a d • (1 : Matrix (Fin 2) (Fin 2) ℂ)) 0 0 + (kappaX b c • pauliX) 0 0)
          + (kappaY b c • pauliY) 0 0) + (kappaZ a d • pauliZ) 0 0 := by
          rw [matrix_sum_apply, matrix_sum_apply, matrix_sum_apply]    -- `def_matrix_sum` を 3 か所へ
    _ = ((kappa0 a d * (1 : Matrix (Fin 2) (Fin 2) ℂ) 0 0 + kappaX b c * pauliX 0 0)
          + kappaY b c * pauliY 0 0) + kappaZ a d * pauliZ 0 0 := by
          rw [matrix_smul_apply, matrix_smul_apply, matrix_smul_apply, matrix_smul_apply]
                                                                      -- `def_matrix_scalar_multiple` を 4 か所へ
    _ = ((kappa0 a d * kroneckerDelta (0 : Fin 2) 0 + kappaX b c * pauliX 0 0)
          + kappaY b c * pauliY 0 0) + kappaZ a d * pauliZ 0 0 := by
          rw [identity_matrix_apply]                                    -- `def_identity_matrix`
    _ = ((kappa0 a d * 1 + kappaX b c * pauliX 0 0)
          + kappaY b c * pauliY 0 0) + kappaZ a d * pauliZ 0 0 := by
          rw [kroneckerDelta_self]                                      -- `def_kronecker_delta`
    _ = ((kappa0 a d * 1 + kappaX b c * 0) + kappaY b c * 0) + kappaZ a d * 1 := by
          rw [pauliX_apply_00, pauliY_apply_00, pauliZ_apply_00]        -- `σ^x, σ^y, σ^z` の `(1,1)` 成分
    _ = ((kappa0 a d * 1 + 0) + 0) + kappaZ a d * 1 := by
          rw [mul_zero, mul_zero]                                       -- `complex_times_zero_is_zero` を 2 か所へ
    _ = kappa0 a d * 1 + kappaZ a d * 1 := by
          rw [add_zero, add_zero]                                       -- 加法の単位元を 2 か所へ
    _ = kappa0 a d + kappaZ a d := by rw [mul_one, mul_one]           -- 積の単位元を 2 か所へ
    _ = (a + d) / 2 + (a - d) / 2 := rfl                              -- `κ_0`・`κ_z` の定義
    _ = (a + d) * 2⁻¹ + (a - d) * 2⁻¹ := by
          rw [div_eq_mul_inv, div_eq_mul_inv]                           -- `def_complex_quotient` を 2 か所へ
    _ = ((a + d) + (a - d)) * 2⁻¹ := (add_mul _ _ _).symm              -- 分配律を右辺から左辺へ
    _ = (2 * a) * 2⁻¹ := by rw [zy_prep_sum_add_diff a d]              -- (d)（`z → a₁₁, w → a₂₂`）
    _ = a := zy_prep_two_mul_mul_inv_two a                              -- (a)（`z → a₁₁`）

/-- 人手 Step 3 の `R_{12}` の鎖。 -/
theorem pauliDecompRhs_apply_01 (a b c d : ℂ) : pauliDecompRhs a b c d 0 1 = b := by
  calc pauliDecompRhs a b c d 0 1
      = (kappa0 a d • (1 : Matrix (Fin 2) (Fin 2) ℂ) + kappaX b c • pauliX
          + kappaY b c • pauliY + kappaZ a d • pauliZ) 0 1 := rfl
                                                                      -- `R` の定義
    _ = (((kappa0 a d • (1 : Matrix (Fin 2) (Fin 2) ℂ)) 0 1 + (kappaX b c • pauliX) 0 1)
          + (kappaY b c • pauliY) 0 1) + (kappaZ a d • pauliZ) 0 1 := by
          rw [matrix_sum_apply, matrix_sum_apply, matrix_sum_apply]    -- `def_matrix_sum` を 3 か所へ
    _ = ((kappa0 a d * (1 : Matrix (Fin 2) (Fin 2) ℂ) 0 1 + kappaX b c * pauliX 0 1)
          + kappaY b c * pauliY 0 1) + kappaZ a d * pauliZ 0 1 := by
          rw [matrix_smul_apply, matrix_smul_apply, matrix_smul_apply, matrix_smul_apply]
                                                                      -- `def_matrix_scalar_multiple` を 4 か所へ
    _ = ((kappa0 a d * kroneckerDelta (0 : Fin 2) 1 + kappaX b c * pauliX 0 1)
          + kappaY b c * pauliY 0 1) + kappaZ a d * pauliZ 0 1 := by
          rw [identity_matrix_apply]                                    -- `def_identity_matrix`
    _ = ((kappa0 a d * 0 + kappaX b c * pauliX 0 1)
          + kappaY b c * pauliY 0 1) + kappaZ a d * pauliZ 0 1 := by
          rw [kroneckerDelta_of_ne (by decide)]                         -- `def_kronecker_delta`
    _ = ((kappa0 a d * 0 + kappaX b c * 1) + kappaY b c * (-Complex.I)) + kappaZ a d * 0 := by
          rw [pauliX_apply_01, pauliY_apply_01, pauliZ_apply_01]        -- `σ^x, σ^y, σ^z` の `(1,2)` 成分
    _ = ((0 + kappaX b c * 1) + kappaY b c * (-Complex.I)) + 0 := by
          rw [mul_zero, mul_zero]                                       -- `complex_times_zero_is_zero` を 2 か所へ
    _ = kappaX b c * 1 + kappaY b c * (-Complex.I) := by
          rw [zero_add, add_zero]                                       -- 加法の単位元を 2 か所へ
    _ = kappaX b c + kappaY b c * (-Complex.I) := by rw [mul_one]             -- 積の単位元
    _ = (b + c) / 2 + ((Complex.I * (b - c)) / 2) * (-Complex.I) := rfl        -- `κ_x`・`κ_y` の定義
    _ = (b + c) * 2⁻¹ + ((Complex.I * (b - c)) * 2⁻¹) * (-Complex.I) := by
          rw [div_eq_mul_inv, div_eq_mul_inv]                           -- `def_complex_quotient` を 2 か所へ
    _ = (b + c) * 2⁻¹ + (-Complex.I) * ((Complex.I * (b - c)) * 2⁻¹) := by
          rw [mul_comm ((Complex.I * (b - c)) * 2⁻¹) (-Complex.I)]             -- 積の可換律
    _ = (b + c) * 2⁻¹ + ((-Complex.I) * (Complex.I * (b - c))) * 2⁻¹ := by
          rw [← mul_assoc (-Complex.I) (Complex.I * (b - c))]                  -- 積の結合律を右辺から左辺へ
    _ = (b + c) * 2⁻¹ + (((-Complex.I) * Complex.I) * (b - c)) * 2⁻¹ := by
          rw [← mul_assoc (-Complex.I) Complex.I]                              -- 積の結合律を右辺から左辺へ
    _ = (b + c) * 2⁻¹ + (1 * (b - c)) * 2⁻¹ := by
          rw [zy_prep_neg_I_mul_I]                                      -- (g)
    _ = (b + c) * 2⁻¹ + (b - c) * 2⁻¹ := by rw [one_mul]               -- 積の単位元
    _ = ((b + c) + (b - c)) * 2⁻¹ := (add_mul _ _ _).symm              -- 分配律を右辺から左辺へ
    _ = (2 * b) * 2⁻¹ := by rw [zy_prep_sum_add_diff b c]              -- (d)（`z → a₁₂, w → a₂₁`）
    _ = b := zy_prep_two_mul_mul_inv_two b                              -- (a)（`z → a₁₂`）

/-- 人手 Step 3 の `R_{21}` の鎖。 -/
theorem pauliDecompRhs_apply_10 (a b c d : ℂ) : pauliDecompRhs a b c d 1 0 = c := by
  calc pauliDecompRhs a b c d 1 0
      = (kappa0 a d • (1 : Matrix (Fin 2) (Fin 2) ℂ) + kappaX b c • pauliX
          + kappaY b c • pauliY + kappaZ a d • pauliZ) 1 0 := rfl
                                                                      -- `R` の定義
    _ = (((kappa0 a d • (1 : Matrix (Fin 2) (Fin 2) ℂ)) 1 0 + (kappaX b c • pauliX) 1 0)
          + (kappaY b c • pauliY) 1 0) + (kappaZ a d • pauliZ) 1 0 := by
          rw [matrix_sum_apply, matrix_sum_apply, matrix_sum_apply]    -- `def_matrix_sum` を 3 か所へ
    _ = ((kappa0 a d * (1 : Matrix (Fin 2) (Fin 2) ℂ) 1 0 + kappaX b c * pauliX 1 0)
          + kappaY b c * pauliY 1 0) + kappaZ a d * pauliZ 1 0 := by
          rw [matrix_smul_apply, matrix_smul_apply, matrix_smul_apply, matrix_smul_apply]
                                                                      -- `def_matrix_scalar_multiple` を 4 か所へ
    _ = ((kappa0 a d * kroneckerDelta (1 : Fin 2) 0 + kappaX b c * pauliX 1 0)
          + kappaY b c * pauliY 1 0) + kappaZ a d * pauliZ 1 0 := by
          rw [identity_matrix_apply]                                    -- `def_identity_matrix`
    _ = ((kappa0 a d * 0 + kappaX b c * pauliX 1 0)
          + kappaY b c * pauliY 1 0) + kappaZ a d * pauliZ 1 0 := by
          rw [kroneckerDelta_of_ne (by decide)]                         -- `def_kronecker_delta`
    _ = ((kappa0 a d * 0 + kappaX b c * 1) + kappaY b c * Complex.I) + kappaZ a d * 0 := by
          rw [pauliX_apply_10, pauliY_apply_10, pauliZ_apply_10]        -- `σ^x, σ^y, σ^z` の `(2,1)` 成分
    _ = ((0 + kappaX b c * 1) + kappaY b c * Complex.I) + 0 := by
          rw [mul_zero, mul_zero]                                       -- `complex_times_zero_is_zero` を 2 か所へ
    _ = kappaX b c * 1 + kappaY b c * Complex.I := by
          rw [zero_add, add_zero]                                       -- 加法の単位元を 2 か所へ
    _ = kappaX b c + kappaY b c * Complex.I := by rw [mul_one]             -- 積の単位元
    _ = (b + c) / 2 + ((Complex.I * (b - c)) / 2) * Complex.I := rfl        -- `κ_x`・`κ_y` の定義
    _ = (b + c) * 2⁻¹ + ((Complex.I * (b - c)) * 2⁻¹) * Complex.I := by
          rw [div_eq_mul_inv, div_eq_mul_inv]                           -- `def_complex_quotient` を 2 か所へ
    _ = (b + c) * 2⁻¹ + Complex.I * ((Complex.I * (b - c)) * 2⁻¹) := by
          rw [mul_comm ((Complex.I * (b - c)) * 2⁻¹) Complex.I]             -- 積の可換律
    _ = (b + c) * 2⁻¹ + (Complex.I * (Complex.I * (b - c))) * 2⁻¹ := by
          rw [← mul_assoc Complex.I (Complex.I * (b - c))]                  -- 積の結合律を右辺から左辺へ
    _ = (b + c) * 2⁻¹ + ((Complex.I * Complex.I) * (b - c)) * 2⁻¹ := by
          rw [← mul_assoc Complex.I Complex.I]                              -- 積の結合律を右辺から左辺へ
    _ = (b + c) * 2⁻¹ + ((-1) * (b - c)) * 2⁻¹ := by
          rw [zy_prep_I_mul_I]                                          -- (f)
    _ = (b + c) * 2⁻¹ + (-(b - c)) * 2⁻¹ := by rw [neg_one_mul]        -- `multiply_by_minus_one` を右辺から左辺へ
    _ = ((b + c) + -(b - c)) * 2⁻¹ := (add_mul _ _ _).symm             -- 分配律を右辺から左辺へ
    _ = ((b + c) - (b - c)) * 2⁻¹ := by rw [← sub_eq_add_neg]          -- `def_complex_difference` を右辺から左辺へ
    _ = (2 * c) * 2⁻¹ := by rw [zy_prep_sum_sub_diff b c]              -- (e)（`z → a₁₂, w → a₂₁`）
    _ = c := zy_prep_two_mul_mul_inv_two c                              -- (a)（`z → a₂₁`）

/-- 人手 Step 3 の `R_{22}` の鎖。 -/
theorem pauliDecompRhs_apply_11 (a b c d : ℂ) : pauliDecompRhs a b c d 1 1 = d := by
  calc pauliDecompRhs a b c d 1 1
      = (kappa0 a d • (1 : Matrix (Fin 2) (Fin 2) ℂ) + kappaX b c • pauliX
          + kappaY b c • pauliY + kappaZ a d • pauliZ) 1 1 := rfl
                                                                      -- `R` の定義
    _ = (((kappa0 a d • (1 : Matrix (Fin 2) (Fin 2) ℂ)) 1 1 + (kappaX b c • pauliX) 1 1)
          + (kappaY b c • pauliY) 1 1) + (kappaZ a d • pauliZ) 1 1 := by
          rw [matrix_sum_apply, matrix_sum_apply, matrix_sum_apply]    -- `def_matrix_sum` を 3 か所へ
    _ = ((kappa0 a d * (1 : Matrix (Fin 2) (Fin 2) ℂ) 1 1 + kappaX b c * pauliX 1 1)
          + kappaY b c * pauliY 1 1) + kappaZ a d * pauliZ 1 1 := by
          rw [matrix_smul_apply, matrix_smul_apply, matrix_smul_apply, matrix_smul_apply]
                                                                      -- `def_matrix_scalar_multiple` を 4 か所へ
    _ = ((kappa0 a d * kroneckerDelta (1 : Fin 2) 1 + kappaX b c * pauliX 1 1)
          + kappaY b c * pauliY 1 1) + kappaZ a d * pauliZ 1 1 := by
          rw [identity_matrix_apply]                                    -- `def_identity_matrix`
    _ = ((kappa0 a d * 1 + kappaX b c * pauliX 1 1)
          + kappaY b c * pauliY 1 1) + kappaZ a d * pauliZ 1 1 := by
          rw [kroneckerDelta_self]                                      -- `def_kronecker_delta`
    _ = ((kappa0 a d * 1 + kappaX b c * 0) + kappaY b c * 0) + kappaZ a d * (-1) := by
          rw [pauliX_apply_11, pauliY_apply_11, pauliZ_apply_11]        -- `σ^x, σ^y, σ^z` の `(2,2)` 成分
    _ = ((kappa0 a d * 1 + 0) + 0) + kappaZ a d * (-1) := by
          rw [mul_zero, mul_zero]                                       -- `complex_times_zero_is_zero` を 2 か所へ
    _ = kappa0 a d * 1 + kappaZ a d * (-1) := by
          rw [add_zero, add_zero]                                       -- 加法の単位元を 2 か所へ
    _ = kappa0 a d + kappaZ a d * (-1) := by rw [mul_one]             -- 積の単位元
    _ = kappa0 a d + (-1) * kappaZ a d := by
          rw [mul_comm (kappaZ a d) (-1)]                               -- 積の可換律
    _ = (a + d) / 2 + (-1) * ((a - d) / 2) := rfl                     -- `κ_0`・`κ_z` の定義
    _ = (a + d) * 2⁻¹ + (-1) * ((a - d) * 2⁻¹) := by
          rw [div_eq_mul_inv, div_eq_mul_inv]                           -- `def_complex_quotient` を 2 か所へ
    _ = (a + d) * 2⁻¹ + ((-1) * (a - d)) * 2⁻¹ := by
          rw [← mul_assoc (-1 : ℂ) (a - d)]                             -- 積の結合律を右辺から左辺へ
    _ = (a + d) * 2⁻¹ + (-(a - d)) * 2⁻¹ := by rw [neg_one_mul]        -- `multiply_by_minus_one` を右辺から左辺へ
    _ = ((a + d) + -(a - d)) * 2⁻¹ := (add_mul _ _ _).symm             -- 分配律を右辺から左辺へ
    _ = ((a + d) - (a - d)) * 2⁻¹ := by rw [← sub_eq_add_neg]          -- `def_complex_difference` を右辺から左辺へ
    _ = (2 * d) * 2⁻¹ := by rw [zy_prep_sum_sub_diff a d]              -- (e)（`z → a₁₁, w → a₂₂`）
    _ = d := zy_prep_two_mul_mul_inv_two d                              -- (a)（`z → a₂₂`）


/-- **原文 Step 3 の展開の式**:
任意の `B ∈ Mat(2, ℂ)` は `I, σ^x, σ^y, σ^z` の ℂ-線型結合で書ける。

  `B = ((b₁₁+b₂₂)/2_ℂ) I + ((b₁₂+b₂₁)/2_ℂ) σ^x + ((i(b₁₂-b₂₁))/2_ℂ) σ^y + ((b₁₁-b₂₂)/2_ℂ) σ^z`

人手の「4 つの成分が `A` の成分に等しいので `A = R`」を、上の 4 本の鎖で成分ごとに示す。 -/
theorem matrix_two_decomp (B : Matrix (Fin 2) (Fin 2) ℂ) :
    B = ((B 0 0 + B 1 1) / 2) • (1 : Matrix (Fin 2) (Fin 2) ℂ)
      + ((B 0 1 + B 1 0) / 2) • pauliX
      + ((Complex.I * (B 0 1 - B 1 0)) / 2) • pauliY
      + ((B 0 0 - B 1 1) / 2) • pauliZ := by
  change B = pauliDecompRhs (B 0 0) (B 0 1) (B 1 0) (B 1 1)
  ext i j
  fin_cases i <;> fin_cases j
  · exact (pauliDecompRhs_apply_00 _ _ _ _).symm
  · exact (pauliDecompRhs_apply_01 _ _ _ _).symm
  · exact (pauliDecompRhs_apply_10 _ _ _ _).symm
  · exact (pauliDecompRhs_apply_11 _ _ _ _).symm

/-- 上をサイト `k` に載せた形。`siteOp k` が線型なのでそのまま持ち上がる。 -/
theorem siteOp_decomp (k : Fin M) (B : Matrix (Fin 2) (Fin 2) ℂ) :
    siteOp k B = ((B 0 0 + B 1 1) / 2) • (1 : TensorPow M)
      + ((B 0 1 + B 1 0) / 2) • sigmaX k
      + ((Complex.I * (B 0 1 - B 1 0)) / 2) • sigmaY k
      + ((B 0 0 - B 1 1) / 2) • sigmaZ k := by
  conv_lhs => rw [matrix_two_decomp B]
  rw [map_add, map_add, map_add, map_smul, map_smul, map_smul, map_smul, siteOp_one]
  rfl

/-- どんな `B ∈ Mat(2, ℂ)` を第 `k` 因子に載せても `𝒜` に入る。 -/
theorem siteOp_mem_adjoin (k : Fin M) (B : Matrix (Fin 2) (Fin 2) ℂ) :
    siteOp k B ∈ Algebra.adjoin ℂ (ZYSet M) := by
  rw [siteOp_decomp]
  exact add_mem (add_mem (add_mem
    (Subalgebra.smul_mem _ (one_mem _) _)
    (Subalgebra.smul_mem _ (sigmaX_mem_adjoin k) _))
    (Subalgebra.smul_mem _ (sigmaY_mem_adjoin k) _))
    (Subalgebra.smul_mem _ (sigmaZ_mem_adjoin k) _)

/-! ## Step 3 後半: テンソル積が張る -/

/-- 単項テンソル `A_1 ⊗ ⋯ ⊗ A_M` は、各因子をサイト作用素として含む部分多元環に属する。

原文 Step 3 の「`σ_1^{a_1} ⋯ σ_M^{a_M} = e_1 ⊗ ⋯ ⊗ e_M`」（異サイト因子の積公式の反復）に対応。
Lean ではサイトの有限集合 `s` に関する帰納法で書く。 -/
theorem siteProd_mem (A : Subalgebra ℂ (TensorPow M)) (x : Fin M → Matrix (Fin 2) (Fin 2) ℂ)
    (h : ∀ k, siteOp k (x k) ∈ A) : siteProd M x ∈ A := by
  classical
  have aux : ∀ s : Finset (Fin M),
      siteProd M (fun i => if i ∈ s then x i else 1) ∈ A := by
    intro s
    induction s using Finset.induction_on with
    | empty =>
        have h0 : (fun i : Fin M => if i ∈ (∅ : Finset (Fin M)) then x i else 1) = 1 := by
          funext i; simp
        rw [h0, siteProd_one]
        exact one_mem A
    | @insert k s hk ih =>
        have hstep : siteProd M (fun i => if i ∈ insert k s then x i else 1)
            = siteOp k (x k) * siteProd M (fun i => if i ∈ s then x i else 1) := by
          rw [siteOp_apply, ← siteProd_mul]
          congr 1
          funext i
          simp only [Pi.mul_apply, Function.update_apply, Pi.one_apply, Finset.mem_insert]
          by_cases hik : i = k
          · subst hik
            simp [hk]
          · by_cases his : i ∈ s <;> simp [hik, his]
        rw [hstep]
        exact mul_mem (h k) ih
  have hall : (fun i : Fin M => if i ∈ (Finset.univ : Finset (Fin M)) then x i else 1) = x := by
    funext i; simp
  have huniv := aux Finset.univ
  rwa [hall] at huniv

/-- 行列単位 `E_{IJ}` は、各サイトの `Mat(2, ℂ)` の行列単位のテンソル積である。 -/
theorem E_eq_siteProd (I J : Conf M) :
    E I J = siteProd M (fun i => Matrix.single (I i) (J i) (1 : ℂ)) := by
  ext s t
  simp only [siteProd_apply, Matrix.single_apply, E]
  rw [Finset.prod_boole]
  simp [funext_iff, forall_and]

/-! ## 結論 -/

/-- **`<Z_Y_generate_algebra>` の形式化**:
`{Z_1, …, Z_M, Y_1, …, Y_M}` が生成する ℂ-部分多元環は `Mat(2, ℂ)^{⊗M}` 全体である。 -/
theorem Z_Y_generate_algebra (M : ℕ) : Algebra.adjoin ℂ (ZYSet M) = ⊤ := by
  classical
  have hbasis : ∀ IJ : Conf M × Conf M,
      (matrixUnitBasis M) IJ ∈ Algebra.adjoin ℂ (ZYSet M) := by
    intro IJ
    rw [matrixUnitBasis_apply, E_eq_siteProd]
    exact siteProd_mem _ _ fun k => siteOp_mem_adjoin k _
  have hle : Submodule.span ℂ (Set.range (matrixUnitBasis M)) ≤
      Subalgebra.toSubmodule (Algebra.adjoin ℂ (ZYSet M)) := by
    rw [Submodule.span_le]
    rintro _ ⟨IJ, rfl⟩
    exact hbasis IJ
  rw [(matrixUnitBasis M).span_eq] at hle
  refine eq_top_iff.2 fun v _ => ?_
  exact hle (Submodule.mem_top)

end Ising2D
