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
| Step 2 の準備の `P_0 := I`・`P_r := P_{r-1}σ_r^x` | `sigmaXPrefixProduct`（`DefinitionTransferMatrixSymbols.lean`）・`sigmaXPrefixProduct_succ_of_lt` |
| Step 2 の準備の積の表示 `P_r = ∏_{j=1}^{r}σ_j^x`（`r = 1` の 4 行と一段の 3 行） | `sigmaXFamily`（Lean の `sigmaXFamily r` の因子は `σ_1^x, …, σ_{r+1}^x`。人手の `r` は Lean の `r + 1`）・`sigmaXPrefixProduct_eq_finiteMatrixProduct`（積は `def_finite_product_of_matrices` の具体版 `finiteMatrixProduct` を `ι := Conf M` で使う） |
| Step 2 の準備の可換の式 `σ_k^xP_r = P_rσ_k^x`（`r < k`）と二乗の式 `P_rP_r = I`（`r` の帰納法） | `sigmaX_mul_sigmaXPrefixProduct_comm`・`sigmaXPrefixProduct_mul_self` |
| Step 2 の `Z_m = P_{m-1}σ_m^z`・`Y_m = P_{m-1}σ_m^y` の 4 行の鎖（`m ≥ 2`） | `Z_eq_sigmaXPrefixProduct_mul`・`Y_eq_sigmaXPrefixProduct_mul`（`calc` の 4 段。1 行目は `Z_eq_finiteMatrixProduct`・`Y_eq_finiteMatrixProduct`（`ClaimSitePauliPrefixProductKroneckerForm.lean`）、3 行目は `jwFactor` の定義、4 行目は `sigmaXPrefixProduct_eq_finiteMatrixProduct`） |
| Step 2 の `P_{m-1}Z_m = σ_m^z`・`P_{m-1}Y_m = σ_m^y` の 4 行の鎖（`m ≥ 2`） | `sigmaZ_eq_sigmaXPrefixProduct_mul`・`sigmaY_eq_sigmaXPrefixProduct_mul` |
| Step 2 の `m` の帰納法（仮定は `σ_1^x, …, σ_{m-1}^x ∈ 𝒜`）、その中の `P_{m-1} ∈ 𝒜` の `r` の帰納法、`σ_m^z, σ_m^y, σ_m^x ∈ 𝒜` | `sigma_mem_adjoin_all`・`sigma_mem_adjoin_first_site`（`m = 1`。`sigmaZ_zero_eq_Z`・`sigmaY_zero_eq_Y`）・`sigmaXPrefixProduct_mem_adjoin`・`sigma_mem_adjoin_of_previous_sigmaX`（`m ≥ 2`）、`sigmaX_mem_adjoin` ほか |
| Step 3 前半（`{I, σ^x, σ^y, σ^z}` は `Mat(2,ℂ)` を張る） | 準備 (a)〜(e) は `zy_prep_two_mul_mul_inv_two`・`zy_prep_add_self`・`zy_prep_add_neg`・`zy_prep_sum_add_diff`・`zy_prep_sum_sub_diff`（(f)・(g) は Step 1 の行）、4 成分の鎖は `pauliDecompRhs_apply_00`〜`_11`、展開の式は `matrix_two_decomp` |
| Step 3 前半の結び（`𝓑` は `Mat(2,ℂ)` を張る） | `pauliFamily_spans`（`matrix_two_decomp` の係数を並べる） |
| Step 3 後半（`𝓑^{⊠M}` は `Mat(2^M,ℂ)` を張る。`<kronecker_family_of_spanning_family_spans>` を `𝓑` に適用） | `kronecker_family_of_spanning_family_spans pauliFamily pauliFamily_spans`（`ClaimKroneckerFamilyOfSpanningFamilySpans.lean`） |
| Step 3 後半（各 `E_k ∈ 𝒜`。`e_k = I` と `e_k = σ^x, σ^y, σ^z` の場合分け） | `siteOp_pauliFamily_mem_adjoin` |
| Step 3 後半（`Q_1 := E_1`・`Q_{s+1} := Q_sE_{s+1}` の帰納法で `Q_s = e_1 ⊠ ⋯ ⊠ e_s ⊠ I ⊠ ⋯ ⊠ I` かつ `Q_s ∈ 𝒜`、`s = M_col` で `e_1 ⊠ ⋯ ⊠ e_M ∈ 𝒜`） | `siteFactorPrefixProduct`（`Q_s`）・`siteFactorPrefixProduct_eq_and_mem`（`s = 1` の 2 行と一段の 6 行の鎖）・`siteProd_mem`（`s = M_col`） |
| Step 3 の結び（`Mat(2^M,ℂ) = span(𝓑^{⊠M}) ⊆ 𝒜`。`𝒜` は ℂ-線型結合について閉じる） | `Z_Y_generate_algebra` |
-/
import Ising2D.PartitionFunction.ProjectionAndJordanWigner.DefinitionTransferMatrixSymbols
import Ising2D.PartitionFunction.ProjectionAndJordanWigner.ClaimSitePauliPrefixProductKroneckerForm
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimExpOfNegativeIRealAsCosMinusISin
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimAddAndSubtractZeroMatrix
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimKroneckerFamilyOfSpanningFamilySpans
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityAndScalarMultipleInMatrixProductFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.DefinitionFiniteProductOfMatrices

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

原文の帰納法（`σ_1^x, …, σ_{m-1}^x ∈ 𝒜` を仮定し、(ii)(iv) と `r` の帰納法で `P_{m-1} ∈ 𝒜` を出して、
`σ^z_m = P_{m-1} Z_m`, `σ^y_m = P_{m-1} Y_m`, `σ^x_m = -√-1 σ^y_m σ^z_m` を得る）
をそのまま写したもの。 -/

/-- 人手 Step 2 の `P_0 := I`・`P_{r+1} := P_rσ_{r+1}^x`（`r < M`）。Lean の `P_r` は人手と同じ再帰の
`sigmaXPrefixProduct M r`（`DefinitionTransferMatrixSymbols.lean`）で、`P_0` は `rfl`、`P_{r+1}` はこの補題で読む。
人手の 1 始まりの `σ_{r+1}^x` は Lean の 0 始まりの `sigmaX ⟨r, _⟩`。 -/
theorem sigmaXPrefixProduct_succ_of_lt (r : ℕ) (h : r < M) :
    sigmaXPrefixProduct M (r + 1) = sigmaXPrefixProduct M r * sigmaX ⟨r, h⟩ := by
  rw [sigmaXPrefixProduct, dif_pos h]

/-- 人手 Step 2 の積の表示の右辺の因子 `σ_1^x, …, σ_{r+1}^x`（人手の `r + 1 ≤ M_col` は Lean の `r < M`）。
Lean の 0 始まりの `j : Fin (r + 1)` が人手の `σ_{j+1}^x` で、`def_finite_product_of_matrices` の `A_{j+1}` は Lean の `A j` である。 -/
noncomputable def sigmaXFamily (r : ℕ) (h : r < M) : Fin (r + 1) → TensorPow M :=
  fun j => sigmaX ⟨(j : ℕ), lt_of_le_of_lt (Nat.le_of_lt_succ j.isLt) h⟩

/-- **人手 Step 2 の準備の積の表示 `P_r = ∏_{j=1}^{r}σ_j^x`**（`r ∈ {1, …, M_col}`。人手の `r` は Lean の `r + 1`）。
積は `def_finite_product_of_matrices` の左から順に掛けた積で、具体版 `finiteMatrixProduct`（添字の型 `ι := Conf M`）である。
`r = 1` の 4 行と、一段の 3 行の鎖と 1 段ずつの `calc`。
`r + 1` の段の最後の行（`def_finite_product_of_matrices` の漸化式を右辺から左辺へ）の、因子の並びを `Fin.castSucc` で読み替える部分は
`sigmaXFamily` の定義どおりの読み替え（`rfl`）である。 -/
theorem sigmaXPrefixProduct_eq_finiteMatrixProduct :
    ∀ (r : ℕ) (h : r < M), sigmaXPrefixProduct M (r + 1) = finiteMatrixProduct r (sigmaXFamily r h)
  | 0, h =>
    calc sigmaXPrefixProduct M (0 + 1)
        = sigmaXPrefixProduct M 0 * sigmaX ⟨0, h⟩ :=
          sigmaXPrefixProduct_succ_of_lt 0 h                      -- `P_1` の定義
      _ = (1 : TensorPow M) * sigmaX ⟨0, h⟩ := rfl                 -- `P_0` の定義
      _ = sigmaX ⟨0, h⟩ := identity_matrix_mul_tensorPow _         -- `identity_matrix_is_left_unit_of_mat_mult`（`A → σ_1^x`）
      _ = finiteMatrixProduct 0 (sigmaXFamily 0 h) := by
          rw [finiteMatrixProduct_zero]; rfl                       -- `def_finite_product_of_matrices` の初項を右辺から左辺へ
  | r + 1, h =>
    calc sigmaXPrefixProduct M (r + 1 + 1)
        = sigmaXPrefixProduct M (r + 1) * sigmaX ⟨r + 1, h⟩ :=
          sigmaXPrefixProduct_succ_of_lt (r + 1) h                 -- `P_{r+1}` の定義
      _ = finiteMatrixProduct r (sigmaXFamily r (Nat.lt_of_succ_lt h)) * sigmaX ⟨r + 1, h⟩ := by
          rw [sigmaXPrefixProduct_eq_finiteMatrixProduct r (Nat.lt_of_succ_lt h)]   -- 帰納法の仮定
      _ = finiteMatrixProduct (r + 1) (sigmaXFamily (r + 1) h) := by
          rw [finiteMatrixProduct_succ]; rfl                       -- `def_finite_product_of_matrices` の漸化式を右辺から左辺へ

/-- 人手 Step 2 の可換の式 `σ_k^xP_r = P_rσ_k^x`（`r ∈ {0, …, k-1}`）。
人手の 1 始まりのサイト `k` は Lean の `k : Fin M`（0 始まり）の `k + 1` なので、人手の `r ≤ k - 1` は Lean の `r ≤ k`。
`r = 0` の 4 行と、一段の 7 行の鎖と 1 段ずつの `calc`。
`mat_mult_associative` の Lean の具体版は無いので、その段は `mul_assoc`（行列の積の結合則）で閉じる。 -/
theorem sigmaX_mul_sigmaXPrefixProduct_comm (k : Fin M) :
    ∀ r : ℕ, r ≤ (k : ℕ) → sigmaX k * sigmaXPrefixProduct M r = sigmaXPrefixProduct M r * sigmaX k
  | 0, _ =>
    calc sigmaX k * sigmaXPrefixProduct M 0
        = sigmaX k * (1 : TensorPow M) := rfl                      -- `P_0` の定義
      _ = sigmaX k := mul_identity_matrix_tensorPow (sigmaX k)
                                  -- `identity_matrix_is_right_unit_of_mat_mult`（`A → σ_k^x`）
      _ = (1 : TensorPow M) * sigmaX k := (identity_matrix_mul_tensorPow (sigmaX k)).symm
                                  -- `identity_matrix_is_left_unit_of_mat_mult` を右辺から左辺へ
      _ = sigmaXPrefixProduct M 0 * sigmaX k := rfl               -- `P_0` の定義を右辺から左辺へ
  | r + 1, hr => by
    have hrM : r < M := lt_of_lt_of_le (Nat.lt_of_succ_le hr) (le_of_lt k.isLt)
    have hne : k ≠ (⟨r, hrM⟩ : Fin M) := fun he => by
      have : (k : ℕ) = r := congrArg Fin.val he
      omega                                                         -- 人手の `r + 1 ≠ k`
    have ih := sigmaX_mul_sigmaXPrefixProduct_comm k r (Nat.le_of_succ_le hr)
    calc sigmaX k * sigmaXPrefixProduct M (r + 1)
        = sigmaX k * (sigmaXPrefixProduct M r * sigmaX ⟨r, hrM⟩) := by
          rw [sigmaXPrefixProduct_succ_of_lt r hrM]                -- `P_{r+1}` の定義
      _ = (sigmaX k * sigmaXPrefixProduct M r) * sigmaX ⟨r, hrM⟩ := (mul_assoc _ _ _).symm
                                  -- `mat_mult_associative`（`A → σ_k^x`, `B → P_r`, `C → σ_{r+1}^x`）を右辺から左辺へ
      _ = (sigmaXPrefixProduct M r * sigmaX k) * sigmaX ⟨r, hrM⟩ := by rw [ih]   -- 帰納法の仮定
      _ = sigmaXPrefixProduct M r * (sigmaX k * sigmaX ⟨r, hrM⟩) := mul_assoc _ _ _
                                  -- `mat_mult_associative`（`A → P_r`, `B → σ_k^x`, `C → σ_{r+1}^x`）
      _ = sigmaXPrefixProduct M r * (sigmaX ⟨r, hrM⟩ * sigmaX k) := by
          rw [sigmaX, sigmaX, siteOp_mul_comm hne]
                                  -- `distinct_site_pauli_matrices_commute`（`j → k`, `k → r+1`, `a, b → x`）
      _ = (sigmaXPrefixProduct M r * sigmaX ⟨r, hrM⟩) * sigmaX k := (mul_assoc _ _ _).symm
                                  -- `mat_mult_associative`（`A → P_r`, `B → σ_{r+1}^x`, `C → σ_k^x`）を右辺から左辺へ
      _ = sigmaXPrefixProduct M (r + 1) * sigmaX k := by
          rw [sigmaXPrefixProduct_succ_of_lt r hrM]                -- `P_{r+1}` の定義を右辺から左辺へ

/-- 人手 Step 2 の二乗の式 `P_rP_r = I`（`r ∈ {0, …, M_col}`）。`r = 0` の 2 行と、一段の 8 行の鎖と 1 段ずつの `calc`。
一段の可換の式は人手の `k → r+1`（Lean の `⟨r, _⟩`）で、条件 `r ≤ (r+1) - 1` は Lean の `r ≤ r`。 -/
theorem sigmaXPrefixProduct_mul_self : ∀ r : ℕ, r ≤ M → sigmaXPrefixProduct M r * sigmaXPrefixProduct M r = 1
  | 0, _ =>
    calc sigmaXPrefixProduct M 0 * sigmaXPrefixProduct M 0
        = (1 : TensorPow M) * (1 : TensorPow M) := rfl             -- `P_0` の定義を 2 か所へ
      _ = 1 := identity_matrix_mul_tensorPow 1
                                  -- `identity_matrix_is_left_unit_of_mat_mult`（`A → I`）
  | r + 1, hr => by
    have hrM : r < M := Nat.lt_of_succ_le hr
    have ih := sigmaXPrefixProduct_mul_self r (le_of_lt hrM)
    have hcomm := sigmaX_mul_sigmaXPrefixProduct_comm (⟨r, hrM⟩ : Fin M) r le_rfl
    calc sigmaXPrefixProduct M (r + 1) * sigmaXPrefixProduct M (r + 1)
        = (sigmaXPrefixProduct M r * sigmaX ⟨r, hrM⟩) * (sigmaXPrefixProduct M r * sigmaX ⟨r, hrM⟩) := by
          rw [sigmaXPrefixProduct_succ_of_lt r hrM]                -- `P_{r+1}` の定義を 2 か所へ
      _ = sigmaXPrefixProduct M r * (sigmaX ⟨r, hrM⟩ * (sigmaXPrefixProduct M r * sigmaX ⟨r, hrM⟩)) :=
          mul_assoc _ _ _
                                  -- `mat_mult_associative`（`A → P_r`, `B → σ_{r+1}^x`, `C → P_rσ_{r+1}^x`）
      _ = sigmaXPrefixProduct M r * ((sigmaX ⟨r, hrM⟩ * sigmaXPrefixProduct M r) * sigmaX ⟨r, hrM⟩) := by
          rw [mul_assoc (sigmaX ⟨r, hrM⟩)]
                                  -- `mat_mult_associative`（`A → σ_{r+1}^x`, `B → P_r`, `C → σ_{r+1}^x`）を右辺から左辺へ
      _ = sigmaXPrefixProduct M r * ((sigmaXPrefixProduct M r * sigmaX ⟨r, hrM⟩) * sigmaX ⟨r, hrM⟩) := by
          rw [hcomm]                                                -- 可換の式（`k → r+1`）
      _ = sigmaXPrefixProduct M r * (sigmaXPrefixProduct M r * (sigmaX ⟨r, hrM⟩ * sigmaX ⟨r, hrM⟩)) := by
          rw [mul_assoc (sigmaXPrefixProduct M r) (sigmaX ⟨r, hrM⟩)]
                                  -- `mat_mult_associative`（`A → P_r`, `B → σ_{r+1}^x`, `C → σ_{r+1}^x`）
      _ = sigmaXPrefixProduct M r * (sigmaXPrefixProduct M r * (1 : TensorPow M)) := by
          rw [sigmaX_mul_self]                                      -- Step 1 の `σ_k^xσ_k^x = I`（`k → r+1`）
      _ = sigmaXPrefixProduct M r * sigmaXPrefixProduct M r := by
          rw [mul_identity_matrix_tensorPow]
                                  -- `identity_matrix_is_right_unit_of_mat_mult`（`A → P_r`）
      _ = 1 := ih                                                   -- 帰納法の仮定

/-- 人手 Step 2 の `Z_m = P_{m-1}σ_m^z`（`m ≥ 2`）。人手の `m` は Lean の `r + 2`（`k = ⟨r + 1, h⟩`）で、人手の `P_{m-1}` は
`sigmaXPrefixProduct M (r + 1)`。人手の 4 行の鎖と 1 段ずつの `calc`:
`def_jordan_wigner_Z_matrices` の積 `∏_{j=1}^{m}F_j^{(z)}`（Lean の `Z` が人手の積に等しいことは `Z_eq_finiteMatrixProduct`）、
`def_finite_product_of_matrices` の漸化式（`r → m-1`。`finiteMatrixProduct_succ`）、`def_jordan_wigner_Z_matrices` の `F_j^{(z)}`（`jwFactor`。`j < m` なら `σ_j^x`、
`j = m` なら `σ_m^z`）、積の表示（`r → m-1`。`sigmaXPrefixProduct_eq_finiteMatrixProduct`）を右辺から左辺へ。
人手の `m = 1` はこの鎖を使わず `def_jordan_wigner_Z_matrices` の `m = 1` の場合の `Z_1 = σ_1^z`（`sigmaZ_zero_eq_Z`）で扱うので、Lean も `m ≥ 2` だけで述べる。 -/
theorem Z_eq_sigmaXPrefixProduct_mul (r : ℕ) (h : r + 1 < M) :
    Z (⟨r + 1, h⟩ : Fin M) = sigmaXPrefixProduct M (r + 1) * sigmaZ ⟨r + 1, h⟩ :=
  calc Z (⟨r + 1, h⟩ : Fin M)
      = finiteMatrixProduct (r + 1) (jwFactor (⟨r + 1, h⟩ : Fin M) pauliZ) :=
        Z_eq_finiteMatrixProduct _                                -- `def_jordan_wigner_Z_matrices`
    _ = finiteMatrixProduct r (fun j => jwFactor (⟨r + 1, h⟩ : Fin M) pauliZ (Fin.castSucc j))
          * jwFactor (⟨r + 1, h⟩ : Fin M) pauliZ (Fin.last (r + 1)) :=
        finiteMatrixProduct_succ r _                              -- `def_finite_product_of_matrices` の漸化式（`r → m-1`）
    _ = finiteMatrixProduct r (sigmaXFamily r (Nat.lt_of_succ_lt h)) * sigmaZ ⟨r + 1, h⟩ := by
        -- `def_jordan_wigner_Z_matrices` の `F_j^{(z)}`（`j < m` なら `σ_j^x`、`j = m` なら `σ_m^z`）
        congr 1
        · congr 1
          funext j
          rw [jwFactor, dif_pos (show ((Fin.castSucc j : Fin (r + 2)) : ℕ) < r + 1 from j.isLt)]
          rfl
        · rw [jwFactor, dif_neg (show ¬((Fin.last (r + 1) : Fin (r + 2)) : ℕ) < r + 1 from lt_irrefl _)]
          rfl
    _ = sigmaXPrefixProduct M (r + 1) * sigmaZ ⟨r + 1, h⟩ := by
        rw [sigmaXPrefixProduct_eq_finiteMatrixProduct r (Nat.lt_of_succ_lt h)]
                                  -- 積の表示（`r → m-1`）を右辺から左辺へ

/-- 人手 Step 2 の `Y_m = P_{m-1}σ_m^y`（`m ≥ 2`）。`Z_eq_sigmaXPrefixProduct_mul` と同じ 4 行の鎖で、
`def_jordan_wigner_Y_matrices`（`Y_eq_finiteMatrixProduct`）とその定義の `F_j^{(y)}` を引く。 -/
theorem Y_eq_sigmaXPrefixProduct_mul (r : ℕ) (h : r + 1 < M) :
    Y (⟨r + 1, h⟩ : Fin M) = sigmaXPrefixProduct M (r + 1) * sigmaY ⟨r + 1, h⟩ :=
  calc Y (⟨r + 1, h⟩ : Fin M)
      = finiteMatrixProduct (r + 1) (jwFactor (⟨r + 1, h⟩ : Fin M) pauliY) :=
        Y_eq_finiteMatrixProduct _                                -- `def_jordan_wigner_Y_matrices`
    _ = finiteMatrixProduct r (fun j => jwFactor (⟨r + 1, h⟩ : Fin M) pauliY (Fin.castSucc j))
          * jwFactor (⟨r + 1, h⟩ : Fin M) pauliY (Fin.last (r + 1)) :=
        finiteMatrixProduct_succ r _                              -- `def_finite_product_of_matrices` の漸化式（`r → m-1`）
    _ = finiteMatrixProduct r (sigmaXFamily r (Nat.lt_of_succ_lt h)) * sigmaY ⟨r + 1, h⟩ := by
        -- `def_jordan_wigner_Y_matrices` の `F_j^{(y)}`（`j < m` なら `σ_j^x`、`j = m` なら `σ_m^y`）
        congr 1
        · congr 1
          funext j
          rw [jwFactor, dif_pos (show ((Fin.castSucc j : Fin (r + 2)) : ℕ) < r + 1 from j.isLt)]
          rfl
        · rw [jwFactor, dif_neg (show ¬((Fin.last (r + 1) : Fin (r + 2)) : ℕ) < r + 1 from lt_irrefl _)]
          rfl
    _ = sigmaXPrefixProduct M (r + 1) * sigmaY ⟨r + 1, h⟩ := by
        rw [sigmaXPrefixProduct_eq_finiteMatrixProduct r (Nat.lt_of_succ_lt h)]
                                  -- 積の表示（`r → m-1`）を右辺から左辺へ

/-- 原文 Step 2 の `σ^z_m = P_{m-1} Z_m`（`m ≥ 2`。人手の `P_{m-1}Z_m` の 4 行の鎖を右辺から左辺へ読む）。 -/
theorem sigmaZ_eq_sigmaXPrefixProduct_mul (r : ℕ) (h : r + 1 < M) :
    sigmaZ (⟨r + 1, h⟩ : Fin M) = sigmaXPrefixProduct M (r + 1) * Z ⟨r + 1, h⟩ := by
  symm
  calc sigmaXPrefixProduct M (r + 1) * Z ⟨r + 1, h⟩
      = sigmaXPrefixProduct M (r + 1) * (sigmaXPrefixProduct M (r + 1) * sigmaZ ⟨r + 1, h⟩) := by
        rw [Z_eq_sigmaXPrefixProduct_mul]                           -- 直前の `Z_m = P_{m-1}σ_m^z`
    _ = (sigmaXPrefixProduct M (r + 1) * sigmaXPrefixProduct M (r + 1)) * sigmaZ ⟨r + 1, h⟩ :=
        (mul_assoc _ _ _).symm
                                  -- `mat_mult_associative`（`A, B → P_{m-1}`, `C → σ_m^z`）を右辺から左辺へ
    _ = (1 : TensorPow M) * sigmaZ ⟨r + 1, h⟩ := by
        rw [sigmaXPrefixProduct_mul_self (r + 1) (le_of_lt h)]      -- 二乗の式（`r → m-1`）
    _ = sigmaZ ⟨r + 1, h⟩ := identity_matrix_mul_tensorPow _
                                  -- `identity_matrix_is_left_unit_of_mat_mult`（`A → σ_m^z`）

/-- 原文 Step 2 の `σ^y_m = P_{m-1} Y_m`（`m ≥ 2`。人手の `P_{m-1}Y_m` の 4 行の鎖を右辺から左辺へ読む）。 -/
theorem sigmaY_eq_sigmaXPrefixProduct_mul (r : ℕ) (h : r + 1 < M) :
    sigmaY (⟨r + 1, h⟩ : Fin M) = sigmaXPrefixProduct M (r + 1) * Y ⟨r + 1, h⟩ := by
  symm
  calc sigmaXPrefixProduct M (r + 1) * Y ⟨r + 1, h⟩
      = sigmaXPrefixProduct M (r + 1) * (sigmaXPrefixProduct M (r + 1) * sigmaY ⟨r + 1, h⟩) := by
        rw [Y_eq_sigmaXPrefixProduct_mul]                           -- 直前の `Y_m = P_{m-1}σ_m^y`
    _ = (sigmaXPrefixProduct M (r + 1) * sigmaXPrefixProduct M (r + 1)) * sigmaY ⟨r + 1, h⟩ :=
        (mul_assoc _ _ _).symm
                                  -- `mat_mult_associative`（`A, B → P_{m-1}`, `C → σ_m^y`）を右辺から左辺へ
    _ = (1 : TensorPow M) * sigmaY ⟨r + 1, h⟩ := by
        rw [sigmaXPrefixProduct_mul_self (r + 1) (le_of_lt h)]      -- 二乗の式（`r → m-1`）
    _ = sigmaY ⟨r + 1, h⟩ := identity_matrix_mul_tensorPow _
                                  -- `identity_matrix_is_left_unit_of_mat_mult`（`A → σ_m^y`）

/-- 人手 Step 2 の `m ≥ 2` の段の「`P_0 ∈ 𝒜` は (ii)、`P_{r-1} ∈ 𝒜` なら `σ_r^x ∈ 𝒜` と (iv) で `P_r ∈ 𝒜`」の `r` の帰納法。
仮定 `h` は人手の外側の帰納法の仮定 `σ_1^x, …, σ_{m-1}^x ∈ 𝒜`（Lean の 0 始まりで `j < r` のサイト）。 -/
theorem sigmaXPrefixProduct_mem_adjoin (r : ℕ) (hr : r ≤ M)
    (h : ∀ j : Fin M, (j : ℕ) < r → sigmaX j ∈ Algebra.adjoin ℂ (ZYSet M)) :
    sigmaXPrefixProduct M r ∈ Algebra.adjoin ℂ (ZYSet M) := by
  induction r with
  | zero => exact one_mem _                                          -- `P_0 = I` と (ii)
  | succ r ih =>
      have hrM : r < M := Nat.lt_of_succ_le hr
      rw [sigmaXPrefixProduct_succ_of_lt r hrM]                     -- `P_{r+1} = P_rσ_{r+1}^x`
      exact mul_mem (ih (le_of_lt hrM) (fun j hj => h j (Nat.lt_succ_of_lt hj)))
        (h ⟨r, hrM⟩ (Nat.lt_succ_self r))                           -- 帰納法の仮定・`σ_{r+1}^x ∈ 𝒜` と (iv)

/-- 人手 Step 2 の外側の帰納法の一段（`m ≥ 2`）: `σ_1^x, …, σ_{m-1}^x ∈ 𝒜` なら `σ_m^z, σ_m^y, σ_m^x ∈ 𝒜`。
人手の `m` は Lean の `r + 2`（`k = ⟨r + 1, h⟩`）。人手の `m = 1` は `sigma_mem_adjoin_first_site` で扱う。
`σ_m^z = P_{m-1}Z_m`・`σ_m^y = P_{m-1}Y_m` と (iv)、`σ_m^x = (-i)(σ_m^yσ_m^z)`（Step 1）と (iii)(iv)。 -/
theorem sigma_mem_adjoin_of_previous_sigmaX (r : ℕ) (h : r + 1 < M)
    (hprev : ∀ j : Fin M, (j : ℕ) < r + 1 → sigmaX j ∈ Algebra.adjoin ℂ (ZYSet M)) :
    sigmaZ (⟨r + 1, h⟩ : Fin M) ∈ Algebra.adjoin ℂ (ZYSet M) ∧
      sigmaY (⟨r + 1, h⟩ : Fin M) ∈ Algebra.adjoin ℂ (ZYSet M) ∧
      sigmaX (⟨r + 1, h⟩ : Fin M) ∈ Algebra.adjoin ℂ (ZYSet M) := by
  have hP := sigmaXPrefixProduct_mem_adjoin (r + 1) (le_of_lt h) hprev   -- `P_{m-1} ∈ 𝒜`
  have hZ : sigmaZ (⟨r + 1, h⟩ : Fin M) ∈ Algebra.adjoin ℂ (ZYSet M) := by
    rw [sigmaZ_eq_sigmaXPrefixProduct_mul]
    exact mul_mem hP (Z_mem_adjoin _)                               -- `σ_m^z = P_{m-1}Z_m ∈ 𝒜`
  have hY : sigmaY (⟨r + 1, h⟩ : Fin M) ∈ Algebra.adjoin ℂ (ZYSet M) := by
    rw [sigmaY_eq_sigmaXPrefixProduct_mul]
    exact mul_mem hP (Y_mem_adjoin _)                               -- `σ_m^y = P_{m-1}Y_m ∈ 𝒜`
  refine ⟨hZ, hY, ?_⟩
  rw [sigmaX_eq]
  exact Subalgebra.smul_mem _ (mul_mem hY hZ) _                     -- `σ_m^x = (-i)(σ_m^yσ_m^z) ∈ 𝒜`

/-- 人手 Step 2 の `m = 1` の段の `σ_1^z = Z_1`。人手 `def_jordan_wigner_Z_matrices` の `m = 1` の場合の 3 段
（`F_1^{(z)} = σ_1^z`（`F_m^{(z)}` の定義で `m = 1`）、`def_finite_product_of_matrices` の `r = 1` の式 `∏_{j=1}^{1}F_j^{(z)} = F_1^{(z)}`、
`Z_1 = ∏_{j=1}^{1}F_j^{(z)}`）を、`σ_1^z` から右へ読む `calc`。Lean の 0 始まりで `sigmaZ ⟨0, _⟩ = Z ⟨0, _⟩`。 -/
theorem sigmaZ_zero_eq_Z (h : 0 < M) : sigmaZ (⟨0, h⟩ : Fin M) = Z ⟨0, h⟩ :=
  calc sigmaZ (⟨0, h⟩ : Fin M)
      = jwFactor (⟨0, h⟩ : Fin M) pauliZ 0 := by
        -- `F_m^{(z)}` の定義（`m = 1`。`j = m` の因子は `σ_m^z`）を右辺から左辺へ
        rw [jwFactor, dif_neg (show ¬(((0 : Fin 1) : ℕ) < ((⟨0, h⟩ : Fin M) : ℕ)) from lt_irrefl 0)]
        rfl
    _ = finiteMatrixProduct 0 (jwFactor (⟨0, h⟩ : Fin M) pauliZ) :=
        (finiteMatrixProduct_zero _).symm                      -- `def_finite_product_of_matrices` の `r = 1` の式を右辺から左辺へ
    _ = Z ⟨0, h⟩ := (Z_eq_finiteMatrixProduct (⟨0, h⟩ : Fin M)).symm        -- `def_jordan_wigner_Z_matrices`（`m = 1`）を右辺から左辺へ

/-- 人手 Step 2 の `m = 1` の段の `σ_1^y = Y_1`。人手 `def_jordan_wigner_Y_matrices` の `m = 1` の場合の 3 段
（`F_1^{(y)} = σ_1^y`（`F_m^{(y)}` の定義で `m = 1`）、`def_finite_product_of_matrices` の `r = 1` の式 `∏_{j=1}^{1}F_j^{(y)} = F_1^{(y)}`、
`Y_1 = ∏_{j=1}^{1}F_j^{(y)}`）を、`σ_1^y` から右へ読む `calc`。Lean の 0 始まりで `sigmaY ⟨0, _⟩ = Y ⟨0, _⟩`。 -/
theorem sigmaY_zero_eq_Y (h : 0 < M) : sigmaY (⟨0, h⟩ : Fin M) = Y ⟨0, h⟩ :=
  calc sigmaY (⟨0, h⟩ : Fin M)
      = jwFactor (⟨0, h⟩ : Fin M) pauliY 0 := by
        -- `F_m^{(y)}` の定義（`m = 1`。`j = m` の因子は `σ_m^y`）を右辺から左辺へ
        rw [jwFactor, dif_neg (show ¬(((0 : Fin 1) : ℕ) < ((⟨0, h⟩ : Fin M) : ℕ)) from lt_irrefl 0)]
        rfl
    _ = finiteMatrixProduct 0 (jwFactor (⟨0, h⟩ : Fin M) pauliY) :=
        (finiteMatrixProduct_zero _).symm                      -- `def_finite_product_of_matrices` の `r = 1` の式を右辺から左辺へ
    _ = Y ⟨0, h⟩ := (Y_eq_finiteMatrixProduct (⟨0, h⟩ : Fin M)).symm        -- `def_jordan_wigner_Y_matrices`（`m = 1`）を右辺から左辺へ

/-- 人手 Step 2 の `m = 1` の段: `σ_1^z = Z_1 ∈ 𝒜`・`σ_1^y = Y_1 ∈ 𝒜` と、`σ_1^x` の 2 行の鎖
（Step 1 の `σ_k^x = (-i)(σ_k^yσ_k^z)` を `k = 1` に取る、`σ_1^y = Y_1`・`σ_1^z = Z_1`）と (iii)(iv)。 -/
theorem sigma_mem_adjoin_first_site (h : 0 < M) :
    sigmaZ (⟨0, h⟩ : Fin M) ∈ Algebra.adjoin ℂ (ZYSet M) ∧
      sigmaY (⟨0, h⟩ : Fin M) ∈ Algebra.adjoin ℂ (ZYSet M) ∧
      sigmaX (⟨0, h⟩ : Fin M) ∈ Algebra.adjoin ℂ (ZYSet M) := by
  have hX : sigmaX (⟨0, h⟩ : Fin M) = (-Complex.I) • (Y ⟨0, h⟩ * Z ⟨0, h⟩) := by
    calc sigmaX (⟨0, h⟩ : Fin M)
        = (-Complex.I) • (sigmaY ⟨0, h⟩ * sigmaZ ⟨0, h⟩) := sigmaX_eq _
                                  -- Step 1 の `σ_k^x = (-i)(σ_k^yσ_k^z)` を `k = 1` に取る
      _ = (-Complex.I) • (Y ⟨0, h⟩ * Z ⟨0, h⟩) := by
          rw [sigmaY_zero_eq_Y, sigmaZ_zero_eq_Z]                   -- `σ_1^y = Y_1`, `σ_1^z = Z_1`
  refine ⟨?_, ?_, ?_⟩
  · rw [sigmaZ_zero_eq_Z]; exact Z_mem_adjoin _
  · rw [sigmaY_zero_eq_Y]; exact Y_mem_adjoin _
  · rw [hX]; exact Subalgebra.smul_mem _ (mul_mem (Y_mem_adjoin _) (Z_mem_adjoin _)) _

/-- 人手 Step 2 の外側の `m` の帰納法（仮定は `σ_1^x, …, σ_{m-1}^x ∈ 𝒜`。Lean は累積帰納法）。
人手の `m = 1` は `sigma_mem_adjoin_first_site`、`m ≥ 2` は `sigma_mem_adjoin_of_previous_sigmaX`。 -/
theorem sigma_mem_adjoin_all : ∀ n : ℕ, ∀ hn : n < M,
    sigmaZ (⟨n, hn⟩ : Fin M) ∈ Algebra.adjoin ℂ (ZYSet M) ∧
      sigmaY (⟨n, hn⟩ : Fin M) ∈ Algebra.adjoin ℂ (ZYSet M) ∧
      sigmaX (⟨n, hn⟩ : Fin M) ∈ Algebra.adjoin ℂ (ZYSet M) := by
  intro n
  induction n using Nat.strong_induction_on with
  | _ n ih =>
      intro hn
      rcases n with _ | n
      · exact sigma_mem_adjoin_first_site hn
      · exact sigma_mem_adjoin_of_previous_sigmaX n hn
          (fun j hj => (ih j hj j.isLt).2.2)

theorem sigmaZ_mem_adjoin (k : Fin M) : sigmaZ k ∈ Algebra.adjoin ℂ (ZYSet M) :=
  (sigma_mem_adjoin_all (k : ℕ) k.isLt).1

theorem sigmaY_mem_adjoin (k : Fin M) : sigmaY k ∈ Algebra.adjoin ℂ (ZYSet M) :=
  (sigma_mem_adjoin_all (k : ℕ) k.isLt).2.1

theorem sigmaX_mem_adjoin (k : Fin M) : sigmaX k ∈ Algebra.adjoin ℂ (ZYSet M) :=
  (sigma_mem_adjoin_all (k : ℕ) k.isLt).2.2

/-! ## Step 3 前半: `{I, σ^x, σ^y, σ^z}` は `Mat(2, ℂ)` を張る

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

/-- 人手 Step 3 の「よって `𝓑` は `Mat(2,ℂ)` を ℂ 上張る」: 任意の `A ∈ Mat(2, ℂ)` は展開の式 `matrix_two_decomp` の
係数 `κ_0, κ_x, κ_y, κ_z` で `𝓑` の ℂ-線型結合に書ける（`<kronecker_family_of_spanning_family_spans>` の仮定の形）。 -/
theorem pauliFamily_spans (A : Matrix (Fin 2) (Fin 2) ℂ) :
    ∃ c : Fin 4 → ℂ, A = ∑ a, c a • pauliFamily a := by
  refine ⟨![(A 0 0 + A 1 1) / 2, (A 0 1 + A 1 0) / 2, (Complex.I * (A 0 1 - A 1 0)) / 2,
    (A 0 0 - A 1 1) / 2], ?_⟩
  rw [Fin.sum_univ_four]
  exact matrix_two_decomp A

/-! ## Step 3 後半: `e_1 ⊠ ⋯ ⊠ e_M` は `𝒜` に属する -/

/-- 人手 Step 3 後半の `Q_s`（`def_finite_product_of_matrices` の左から順に掛けた積 `E_1E_2⋯E_s`）:
`Q_1 := E_1`、`Q_{s+1} := Q_s E_{s+1}`。`E_k = I ⊠ ⋯ ⊠ x_k ⊠ ⋯ ⊠ I` は Lean の `siteOp k (x k)`。
Lean の添字は 0 始まりで、`siteFactorPrefixProduct x s h` が人手の `Q_{s+1}`、Lean のサイト `⟨k, _⟩` が人手のサイト `k+1` である。 -/
noncomputable def siteFactorPrefixProduct (x : Fin M → Matrix (Fin 2) (Fin 2) ℂ) :
    (s : ℕ) → s < M → TensorPow M
  | 0, h => siteOp ⟨0, h⟩ (x ⟨0, h⟩)
  | s + 1, h =>
      siteFactorPrefixProduct x s (Nat.lt_of_succ_lt h) * siteOp ⟨s + 1, h⟩ (x ⟨s + 1, h⟩)

/-- 人手 Step 3 後半の帰納法: `Q_s = e_1 ⊠ ⋯ ⊠ e_s ⊠ I ⊠ ⋯ ⊠ I` かつ `Q_s ∈ 𝒜`。
人手の `s` は Lean の `s + 1` で、人手の「第 `1` から第 `s` 因子」は Lean の `(i : ℕ) ≤ s` である。
`s = 1` の 2 行の鎖と、`s → s + 1` の 6 行の鎖は、下の 2 つの節の `calc` と 1 段ずつ対応する
（Lean の最後の段は、人手の因子の並び `e_1 ⊠ ⋯ ⊠ e_{s+1} ⊠ I ⊠ ⋯ ⊠ I` を `if` の書き方へ移すだけである）。
`Q_s ∈ 𝒜` は、`s = 1` では `E_1 ∈ 𝒜`、`s → s + 1` では帰納法の仮定と `E_{s+1} ∈ 𝒜` と (iv) である。 -/
theorem siteFactorPrefixProduct_eq_and_mem (A : Subalgebra ℂ (TensorPow M))
    (x : Fin M → Matrix (Fin 2) (Fin 2) ℂ) (hE : ∀ k, siteOp k (x k) ∈ A) :
    ∀ (s : ℕ) (h : s < M),
      siteFactorPrefixProduct x s h = siteProd M (fun i => if (i : ℕ) ≤ s then x i else 1)
        ∧ siteFactorPrefixProduct x s h ∈ A
  | 0, h => by
    refine ⟨?_, hE _⟩                                                  -- `Q_1 = E_1 ∈ 𝒜`
    calc siteFactorPrefixProduct x 0 h
        = siteOp ⟨0, h⟩ (x ⟨0, h⟩) := rfl                              -- `Q_1` の定義
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
            rfl                                                        -- `Q_{s+1}` の定義
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

人手 Step 3 後半の「`s = M_col` として `e_1 ⊠ ⋯ ⊠ e_{M_col} = Q_{M_col} ∈ 𝒜`」: `siteFactorPrefixProduct_eq_and_mem` を
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

人手 Step 3 の結びと同じく、`𝓑^{⊠M}` が `Mat(2^M, ℂ)` を張ること（`<kronecker_family_of_spanning_family_spans>` を
`𝓑` に適用した `kronecker_family_of_spanning_family_spans pauliFamily pauliFamily_spans`）と、その元
`e_1 ⊠ ⋯ ⊠ e_M` がすべて `𝒜` に入ること（`siteProd_mem` と `siteOp_pauliFamily_mem_adjoin`）から、
`Mat(2^M, ℂ) = span_ℂ(𝓑^{⊠M}) ⊆ 𝒜`（`𝒜` は ℂ-線型結合について閉じる）を得る。 -/
theorem Z_Y_generate_algebra (M : ℕ) : Algebra.adjoin ℂ (ZYSet M) = ⊤ := by
  refine eq_top_iff.2 fun X _ => ?_
  obtain ⟨d, hd⟩ := kronecker_family_of_spanning_family_spans pauliFamily pauliFamily_spans X
                                                                        -- `Mat(2^M,ℂ) = span(𝓑^{⊠M})`
  rw [hd]
  exact Subalgebra.sum_mem _ fun p _ => Subalgebra.smul_mem _
    (siteProd_mem _ _ fun k => siteOp_pauliFamily_mem_adjoin k (p k)) _  -- `𝒜` は ℂ-線型結合について閉じる

end Ising2D
