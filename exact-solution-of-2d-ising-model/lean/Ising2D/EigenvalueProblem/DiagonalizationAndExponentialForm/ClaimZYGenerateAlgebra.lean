/-
# `Z, Y` は `Mat(2^M, ℂ)` を環として生成する

対応する人手証明:
`structured-latex/content/eigenvalue_problem_diagonalization_and_exponential_form.ts` の `Z_Y_generate_algebra`

原文の主張: `S = {Z_1, …, Z_M, Y_1, …, Y_M}` を含む最小の ℂ-部分多元環 `𝒜` は
`Mat(2^M, ℂ)` 全体に一致する。

Lean では「`S` を含む最小の ℂ-部分多元環」を mathlib の `Algebra.adjoin ℂ S`
（`Subalgebra ℂ (TensorPow M)`）とし、結論を `Algebra.adjoin ℂ (ZYSet M) = ⊤` と述べる。

## 原文の証明との対応

| 原文 | Lean |
| --- | --- |
| Step 1（準備 (f)・(g)、第 1〜4 式、`σ_k^xσ_k^x = I`・`σ_k^x = (-i)(σ_k^yσ_k^z)` の鎖、異サイト可換性） | `Ising2D/PartitionFunction/ProjectionAndJordanWigner/DefinitionTransferMatrixSymbols.lean` の `zy_prep_I_mul_I`・`zy_prep_neg_I_mul_I`（準備 (f)・(g)）、`pauliX_mul_pauliX`（第 1 式。`pauli_matrix_products`）・`pauliY_mul_pauliZ`（第 2 式）・`pauliX_eq`（第 3 式）・`siteOp_mul_same`（第 4 式）・`sigmaX_mul_self`・`sigmaX_eq`（各鎖と 1 段ずつの `calc`）、`siteOp_mul_comm`（`distinct_site_pauli_matrices_commute`） |
| Step 2（帰納法で `σ^x_m, σ^y_m, σ^z_m ∈ 𝒜`） | `xString_mem_adjoin`, `sigmaX_mem_adjoin` ほか |
| Step 3 前半（`{I, σ^x, σ^y, σ^z}` は `Mat(2,ℂ)` の基底） | 準備 (a)〜(e) は `zy_prep_two_mul_mul_inv_two`・`zy_prep_add_self`・`zy_prep_add_neg`・`zy_prep_sum_add_diff`・`zy_prep_sum_sub_diff`（(f)・(g) は Step 1 の行）、4 成分の鎖は `pauliDecompRhs_apply_00`〜`_11`、展開の式は `matrix_two_decomp` |
| Step 3 前半の結び（`𝓑` は張り、`dim Mat(2,ℂ) = 4 = #𝓑` より基底） | `top_le_span_pauliFamily`・`finrank_mat2_eq_four`・`pauliBasis`（「張り、元数が次元に等しい族は基底」は mathlib の `basisOfTopLeSpanOfCardEqFinrank` に委ねる） |
| Step 3 後半（`𝓑^{⊠M}` は基底。`<tensor_basis>` (2) を `𝓑` に適用） | `kroneckerTensorPowBasisOf M pauliBasis`（`TheoremTensorBasisFromNecSuf.lean`。mathlib の `Basis.piTensorProduct` を移したもので、人手 `<tensor_basis>` の Step 4 と 1 対 1 でない） |
| Step 3 後半（各 `E_k ∈ 𝒜`。`e_k = I` と `e_k = σ^x, σ^y, σ^z` の場合分け） | `siteOp_pauliFamily_mem_adjoin` |
| Step 3 後半（`P_1 := E_1`・`P_{s+1} := P_sE_{s+1}` の帰納法で `P_s = e_1 ⊠ ⋯ ⊠ e_s ⊠ I ⊠ ⋯ ⊠ I` かつ `P_s ∈ 𝒜`、`s = M_col` で `e_1 ⊠ ⋯ ⊠ e_M ∈ 𝒜`） | `siteFactorPrefixProduct`（`P_s`）・`siteFactorPrefixProduct_eq_and_mem`（`s = 1` の 2 行と一段の 6 行の鎖）・`siteProd_mem`（`s = M_col`） |
| Step 3 の結び（`Mat(2^M,ℂ) = span(𝓑^{⊠M}) ⊆ 𝒜`） | `Z_Y_generate_algebra` |
-/
import Ising2D.PartitionFunction.ProjectionAndJordanWigner.DefinitionTransferMatrixSymbols
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimExpOfNegativeIRealAsCosMinusISin
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimAddAndSubtractZeroMatrix
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.TheoremTensorBasisFromNecSuf
import Mathlib.LinearAlgebra.Dimension.OrzechProperty

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
`κ_z := (a₁₁−a₂₂)/2_ℂ` を `def_complex_quotient` の商（`w → 2_ℂ`）と読み、準備 (a)〜(e) を置いてから
（(f)・(g) は Step 1 で置く。Lean は `DefinitionTransferMatrixSymbols.lean` の `zy_prep_I_mul_I`・`zy_prep_neg_I_mul_I`）、
右辺 `R` の 4 成分の鎖を書く。以下の補題はその準備と 4 本の鎖を 1 行ずつ辿る（人手の添字 `1, 2` は Lean では `0, 1`）。
Lean の `z / 2` は `div_eq_mul_inv`（`def_complex_quotient`）で `z * 2⁻¹` に開く。`2_ℂ ∈ ℂ^×` は
`complex_two_ne_zero_by_re`（`inclusion_rr_to_cc` の第 1 成分の比較）である。 -/

/-- 人手 Step 3 の準備 (a): `(2_ℂ z) 2_ℂ^{-1} = z`。 -/
theorem zy_prep_two_mul_mul_inv_two (z : ℂ) : (2 * z) * 2⁻¹ = z := by
  calc (2 * z) * 2⁻¹
      = (z * 2) * 2⁻¹ := by rw [mul_comm 2 z]                         -- 積の可換律
    _ = z * (2 * 2⁻¹) := mul_assoc _ _ _                              -- 積の結合律
    _ = z * 1 := by rw [mul_inv_cancel₀ complex_two_ne_zero_by_re]   -- `multiplicative_group_of_cc` の逆元（`2_ℂ ∈ ℂ^×`）
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


/-- 人手 `pauli_matrix_products` で定めた Pauli 行列の成分（人手の証明の冒頭がこの定めを引く）。 -/
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
          rw [pauliX_apply_00, pauliY_apply_00, pauliZ_apply_00]        -- `pauli_matrix_products` の `σ^x, σ^y, σ^z` の `(1,1)` 成分
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
          rw [pauliX_apply_01, pauliY_apply_01, pauliZ_apply_01]        -- `pauli_matrix_products` の `σ^x, σ^y, σ^z` の `(1,2)` 成分
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
          rw [pauliX_apply_10, pauliY_apply_10, pauliZ_apply_10]        -- `pauli_matrix_products` の `σ^x, σ^y, σ^z` の `(2,1)` 成分
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
          rw [pauliX_apply_11, pauliY_apply_11, pauliZ_apply_11]        -- `pauli_matrix_products` の `σ^x, σ^y, σ^z` の `(2,2)` 成分
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

/-- 人手 Step 3 の `𝓑 = {b_1, b_2, b_3, b_4} := {I_{Mat(2,ℂ)}, σ^x, σ^y, σ^z}`（Lean の添字は `0, 1, 2, 3`）。 -/
noncomputable def pauliFamily : Fin 4 → Matrix (Fin 2) (Fin 2) ℂ :=
  ![1, pauliX, pauliY, pauliZ]

/-- 人手 Step 3 の「よって `𝓑` は張り」: 任意の `A ∈ Mat(2, ℂ)` は展開の式 `matrix_two_decomp` で
`𝓑` の ℂ-線型結合に書ける。 -/
theorem top_le_span_pauliFamily :
    (⊤ : Submodule ℂ (Matrix (Fin 2) (Fin 2) ℂ)) ≤ Submodule.span ℂ (Set.range pauliFamily) := by
  intro A _
  rw [matrix_two_decomp A]
  refine add_mem (add_mem (add_mem ?_ ?_) ?_) ?_
  · exact Submodule.smul_mem _ _ (Submodule.subset_span ⟨0, rfl⟩)
  · exact Submodule.smul_mem _ _ (Submodule.subset_span ⟨1, rfl⟩)
  · exact Submodule.smul_mem _ _ (Submodule.subset_span ⟨2, rfl⟩)
  · exact Submodule.smul_mem _ _ (Submodule.subset_span ⟨3, rfl⟩)

/-- 人手 Step 3 の `dim_ℂ Mat(2, ℂ) = 4`（人手は根拠を書いていない）。Lean は行列単位の基底
`NecSuf.matrixUnitBasis`（`<tensor_basis>` (1) の `M = 1` に当たる成分比較で作った基底）の元数
`#({1,2} × {1,2}) = 4` を使う。 -/
theorem finrank_mat2_eq_four : Module.finrank ℂ (Matrix (Fin 2) (Fin 2) ℂ) = 4 := by
  rw [Module.finrank_eq_card_basis (NecSuf.matrixUnitBasis ℂ (Fin 2))]
  rfl

/-- 人手 Step 3 の「`dim_ℂ Mat(2,ℂ) = 4 = #𝓑` より基底である」（人手は根拠を書いていない）。
Lean は「全体を張り、元数が次元に等しい族は基底」（人手 `<tensor_basis>` の証明の Step 3 (b) と同じ事実）を
mathlib の `basisOfTopLeSpanOfCardEqFinrank` で使い、自前には証明していない。 -/
noncomputable def pauliBasis : Module.Basis (Fin 4) ℂ (Matrix (Fin 2) (Fin 2) ℂ) :=
  basisOfTopLeSpanOfCardEqFinrank pauliFamily top_le_span_pauliFamily
    (by rw [finrank_mat2_eq_four]; rfl)

@[simp]
theorem coe_pauliBasis : ⇑pauliBasis = pauliFamily :=
  coe_basisOfTopLeSpanOfCardEqFinrank _ _ _

/-! ## Step 3 後半: `e_1 ⊠ ⋯ ⊠ e_M` は `𝒜` に属する -/

/-- 人手 Step 3 後半の `P_s`（`def_finite_product_of_matrices` の左から順に掛けた積 `E_1E_2⋯E_s`）:
`P_1 := E_1`、`P_{s+1} := P_s E_{s+1}`。`E_k = I ⊠ ⋯ ⊠ x_k ⊠ ⋯ ⊠ I` は Lean の `siteOp k (x k)`。
Lean の添字は 0 始まりで、`siteFactorPrefixProduct x s h` が人手の `P_{s+1}`、Lean のサイト `⟨k, _⟩` が人手のサイト `k+1` である。 -/
noncomputable def siteFactorPrefixProduct (x : Fin M → Matrix (Fin 2) (Fin 2) ℂ) :
    (s : ℕ) → s < M → TensorPow M
  | 0, h => siteOp ⟨0, h⟩ (x ⟨0, h⟩)
  | s + 1, h =>
      siteFactorPrefixProduct x s (Nat.lt_of_succ_lt h) * siteOp ⟨s + 1, h⟩ (x ⟨s + 1, h⟩)

/-- 人手 Step 3 後半の帰納法: `P_s = e_1 ⊠ ⋯ ⊠ e_s ⊠ I ⊠ ⋯ ⊠ I` かつ `P_s ∈ 𝒜`。
人手の `s` は Lean の `s + 1` で、人手の「第 `1` から第 `s` 因子」は Lean の `(i : ℕ) ≤ s` である。
`s = 1` の 2 行の鎖と、`s → s + 1` の 6 行の鎖は、下の 2 つの節の `calc` と 1 段ずつ対応する
（Lean の最後の段は、人手の因子の並び `e_1 ⊠ ⋯ ⊠ e_{s+1} ⊠ I ⊠ ⋯ ⊠ I` を `if` の書き方へ移すだけである）。
`P_s ∈ 𝒜` は、`s = 1` では `E_1 ∈ 𝒜`、`s → s + 1` では帰納法の仮定と `E_{s+1} ∈ 𝒜` と (iv) である。 -/
theorem siteFactorPrefixProduct_eq_and_mem (A : Subalgebra ℂ (TensorPow M))
    (x : Fin M → Matrix (Fin 2) (Fin 2) ℂ) (hE : ∀ k, siteOp k (x k) ∈ A) :
    ∀ (s : ℕ) (h : s < M),
      siteFactorPrefixProduct x s h = siteProd M (fun i => if (i : ℕ) ≤ s then x i else 1)
        ∧ siteFactorPrefixProduct x s h ∈ A
  | 0, h => by
    refine ⟨?_, hE _⟩                                                  -- `P_1 = E_1 ∈ 𝒜`
    calc siteFactorPrefixProduct x 0 h
        = siteOp ⟨0, h⟩ (x ⟨0, h⟩) := rfl                              -- `P_1` の定義
      _ = siteProd M (fun i => if (i : ℕ) ≤ 0 then x i else 1) := by
          rw [siteOp_apply]                                            -- `E_1` の定義（`e_1 ⊠ I ⊠ ⋯ ⊠ I`）
          congr 1                                                      -- 両辺は同じ因子の並び（`Function.update` は `if` の書き方の違いだけ）
          funext i
          by_cases hi : (i : ℕ) = 0
          · have he : i = ⟨0, h⟩ := Fin.ext hi
            subst he
            simp
          · have hne : i ≠ ⟨0, h⟩ := fun he => hi (congrArg Fin.val he)
            rw [Function.update_of_ne hne, if_neg (by omega), Pi.one_apply]
  | s + 1, h => by
    obtain ⟨ihEq, ihMem⟩ := siteFactorPrefixProduct_eq_and_mem A x hE s (Nat.lt_of_succ_lt h)
    refine ⟨?_, ?_⟩
    · calc siteFactorPrefixProduct x (s + 1) h
          = siteFactorPrefixProduct x s (Nat.lt_of_succ_lt h) * siteOp ⟨s + 1, h⟩ (x ⟨s + 1, h⟩) :=
            rfl                                                        -- `P_{s+1}` の定義
        _ = siteProd M (fun i => if (i : ℕ) ≤ s then x i else 1)
              * siteProd M (Function.update (1 : Fin M → Matrix (Fin 2) (Fin 2) ℂ) ⟨s + 1, h⟩
                  (x ⟨s + 1, h⟩)) := by
            rw [ihEq, siteOp_apply]                                    -- 帰納法の仮定と `E_{s+1}` の定義
        _ = siteProd M (fun i => if (i : ℕ) ≤ s then x i * 1
              else if (i : ℕ) = s + 1 then 1 * x i else 1 * 1) := by
            rw [← siteProd_mul]                                        -- `kronecker_product_rule` (1)
            congr 1
            funext i
            simp only [Pi.mul_apply]
            by_cases hi : (i : ℕ) ≤ s
            · have hne : i ≠ ⟨s + 1, h⟩ := fun he => by
                have := congrArg Fin.val he; simp at this; omega
              rw [if_pos hi, if_pos hi, Function.update_of_ne hne, Pi.one_apply]
            · by_cases hs : (i : ℕ) = s + 1
              · have he : i = ⟨s + 1, h⟩ := Fin.ext hs
                subst he
                rw [if_neg hi, if_neg hi, if_pos hs, Function.update_self]
              · have hne : i ≠ ⟨s + 1, h⟩ := fun he => hs (congrArg Fin.val he)
                rw [if_neg hi, if_neg hi, if_neg hs, Function.update_of_ne hne, Pi.one_apply]
        _ = siteProd M (fun i => if (i : ℕ) ≤ s then x i
              else if (i : ℕ) = s + 1 then 1 * x i else 1 * 1) := by
            congr 1
            funext i
            by_cases hi : (i : ℕ) ≤ s
            · rw [if_pos hi, if_pos hi, mul_identity_matrix (x i)]
                                                                       -- `identity_matrix_is_right_unit_of_mat_mult` を第 1 から第 `s` 因子へ同時に適用
            · rw [if_neg hi, if_neg hi]
        _ = siteProd M (fun i => if (i : ℕ) ≤ s then x i
              else if (i : ℕ) = s + 1 then x i else 1 * 1) := by
            congr 1
            funext i
            by_cases hs : (i : ℕ) = s + 1
            · rw [if_pos hs, if_pos hs, identity_matrix_mul (x i)]
                                                                       -- `identity_matrix_is_left_unit_of_mat_mult`（`A → e_{s+1}`）
            · rw [if_neg hs, if_neg hs]
        _ = siteProd M (fun i => if (i : ℕ) ≤ s then x i
              else if (i : ℕ) = s + 1 then x i else 1) := by
            rw [identity_matrix_mul (1 : Matrix (Fin 2) (Fin 2) ℂ)]
                                                                       -- `identity_matrix_is_left_unit_of_mat_mult`（`A → I`）を第 `s+2` 以降の因子へ同時に適用
        _ = siteProd M (fun i => if (i : ℕ) ≤ s + 1 then x i else 1) := by
            congr 1                                                    -- 両辺は同じ因子の並び `e_1 ⊠ ⋯ ⊠ e_{s+1} ⊠ I ⊠ ⋯ ⊠ I`（`if` の書き方の違いだけ）
            funext i
            by_cases hi : (i : ℕ) ≤ s
            · rw [if_pos hi, if_pos (by omega)]
            · by_cases hs : (i : ℕ) = s + 1
              · rw [if_neg hi, if_pos hs, if_pos (by omega)]
              · rw [if_neg hi, if_neg hs, if_neg (by omega)]
    · exact mul_mem ihMem (hE _)                                       -- 帰納法の仮定・`E_{s+1} ∈ 𝒜`・(iv)

/-- クロネッカー積 `e_1 ⊠ ⋯ ⊠ e_M` は、各 `E_k = I ⊠ ⋯ ⊠ e_k ⊠ ⋯ ⊠ I` を含む部分多元環に属する。

人手 Step 3 後半の「`s = M_col` として `e_1 ⊠ ⋯ ⊠ e_{M_col} = P_{M_col} ∈ 𝒜`」: `siteFactorPrefixProduct_eq_and_mem` を
人手の `s = M_col`（Lean の `M - 1`）で使い、`(i : ℕ) ≤ M - 1` がすべてのサイトで成り立つことから因子の並びを `x` に戻す。
`M = 0` の場合は人手に現れない（人手は `M_col ∈ ℤ_{≥2}`）。主張の型を `M : ℕ` のままにするため、Lean はこの場合を
`Fin 0 → Mat(2,ℂ)` の元が単位元しかないこと・`kronecker_product_rule` (2)（`siteProd_one`）・(ii) で別に閉じる。 -/
theorem siteProd_mem (A : Subalgebra ℂ (TensorPow M)) (x : Fin M → Matrix (Fin 2) (Fin 2) ℂ)
    (h : ∀ k, siteOp k (x k) ∈ A) : siteProd M x ∈ A := by
  rcases Nat.eq_zero_or_pos M with hM | hM
  · subst hM
    have hx : x = 1 := funext fun i => i.elim0
    rw [hx, siteProd_one]
    exact one_mem A
  · obtain ⟨hform, hmem⟩ := siteFactorPrefixProduct_eq_and_mem A x h (M - 1) (by omega)
    have hall : (fun i : Fin M => if (i : ℕ) ≤ M - 1 then x i else 1) = x := by
      funext i
      rw [if_pos (by omega)]
    rw [hform, hall] at hmem
    exact hmem

/-- 人手 Step 3 後半の「各 `E_k` は `𝒜` に属する」。`E_k = I ⊠ ⋯ ⊠ e_k ⊠ ⋯ ⊠ I` は Lean の
`siteOp k e_k`。`e_k = I` なら `E_k = I_{Mat(2^M,ℂ)}`（`kronecker_product_rule` (2)。Lean の `siteOp_one`）で (ii)、
`e_k = σ^x, σ^y, σ^z` なら `E_k = σ_k^x, σ_k^y, σ_k^z`（`def_site_pauli_matrices`。Lean の `sigmaX` などの定義）で Step 2。 -/
theorem siteOp_pauliFamily_mem_adjoin (k : Fin M) (j : Fin 4) :
    siteOp k (pauliFamily j) ∈ Algebra.adjoin ℂ (ZYSet M) := by
  fin_cases j
  · change siteOp k (1 : Matrix (Fin 2) (Fin 2) ℂ) ∈ Algebra.adjoin ℂ (ZYSet M)
    rw [siteOp_one]                                                   -- `kronecker_product_rule` (2)
    exact one_mem _                                                   -- (ii)
  · exact sigmaX_mem_adjoin k                                         -- `def_site_pauli_matrices` と Step 2
  · exact sigmaY_mem_adjoin k                                         -- `def_site_pauli_matrices` と Step 2
  · exact sigmaZ_mem_adjoin k                                         -- `def_site_pauli_matrices` と Step 2

/-! ## 結論 -/

/-- **`<Z_Y_generate_algebra>` の形式化**:
`{Z_1, …, Z_M, Y_1, …, Y_M}` が生成する ℂ-部分多元環は `Mat(2^M, ℂ)` 全体である。

人手 Step 3 の結びと同じく、`𝓑^{⊠M}`（`<tensor_basis>` (2) を `𝓑` に適用した基底）の元
`e_1 ⊠ ⋯ ⊠ e_M` がすべて `𝒜` に入ること（`siteProd_mem` と `siteOp_pauliFamily_mem_adjoin`）から、
`Mat(2^M, ℂ) = span_ℂ(𝓑^{⊠M}) ⊆ 𝒜`（`𝒜` は ℂ-線型結合について閉じる）を得る。 -/
theorem Z_Y_generate_algebra (M : ℕ) : Algebra.adjoin ℂ (ZYSet M) = ⊤ := by
  have hbasis : ∀ p : Fin M → Fin 4,
      kroneckerTensorPowBasisOf M pauliBasis p ∈ Algebra.adjoin ℂ (ZYSet M) := by
    intro p
    rw [kroneckerTensorPowBasisOf_apply, coe_pauliBasis]                -- `e_1 ⊠ ⋯ ⊠ e_M`
    exact siteProd_mem _ _ fun k => siteOp_pauliFamily_mem_adjoin k (p k)
  have hle : Submodule.span ℂ (Set.range (kroneckerTensorPowBasisOf M pauliBasis)) ≤
      Subalgebra.toSubmodule (Algebra.adjoin ℂ (ZYSet M)) := by
    rw [Submodule.span_le]
    rintro _ ⟨p, rfl⟩
    exact hbasis p
  rw [(kroneckerTensorPowBasisOf M pauliBasis).span_eq] at hle          -- `Mat(2^M,ℂ) = span(𝓑^{⊠M})`
  refine eq_top_iff.2 fun v _ => ?_
  exact hle (Submodule.mem_top)

end Ising2D
