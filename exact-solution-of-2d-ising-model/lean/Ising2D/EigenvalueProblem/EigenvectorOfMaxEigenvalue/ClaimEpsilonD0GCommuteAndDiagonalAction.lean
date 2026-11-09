/-
# `ε, D_0, G` の可換性・`(εG)^2 = I`・配置基底の上での `D_0, G` の対角作用（具体版）

正本: `structured-latex/content/eigenvalue_problem_eigenvector_of_max_eigenvalue.ts`

| 人手 | Lean |
| --- | --- |
| `epsilon_D0_G_pairwise_commute` の準備（`ε` と `σ^z` の対の可換）の 8 行 `ε(σ^z_jσ^z_k) = ⋯ = (σ^z_jσ^z_k)ε` | `epsilon_mul_sigmaZ_mul_sigmaZ` の 8 段 |
| 同 準備（`σ^z` どうしの可換）`σ^z_jσ^z_k = σ^z_kσ^z_j`（`j ≠ k` と `j = k` の場合分け） | `sigmaZ_mul_sigmaZ_comm` |
| 同 準備（`σ^z` の対と `G` の可換）の 14 行 `(σ^z_mσ^z_{m+1})G = ⋯ = G(σ^z_mσ^z_{m+1})` | `sigmaZ_mul_sigmaZ_mul_boundaryG` の 14 段 |
| 同 `εD_0 = D_0ε` の 5 行 | `epsilon_mul_openChainD0` の 5 段（`M_col = r + 2`） |
| 同 `εG = Gε` の 3 行 | `epsilon_mul_boundaryG` の 3 段 |
| 同 `D_0G = GD_0` の 5 行 | `openChainD0_mul_boundaryG` の 5 段（`M_col = r + 2`） |
| `epsilon_G_is_involution` の準備の 5 行 `σ^z_kσ^z_k = ⋯ = I_{Mat(2^{M_col},ℂ)}` | `sigmaZ_mul_self` の 5 段 |
| 同 主張の 15 行 `(εG)^2 = ⋯ = I_{Mat(2^{M_col},ℂ)}`（`M_col ≥ 2`） | `epsilon_mul_boundaryG_sq` の 15 段 |
| `D0_G_diagonal_action` の準備の 7 行 `(σ^z_mσ^z_{m+1})f_{ι(s)} = ⋯ = (s(m)s(m+1))_ℂ f_{ι(s)}` | `sigmaZ_mul_sigmaZ_mulVec_basisVec_spin` の 7 段 |
| 同 開鎖項の 5 行 `D_0f_{ι(s)} = ⋯ = (∑_{m=1}^{M_col-1}s(m)s(m+1))_ℂ f_{ι(s)}` | `openChainD0_mulVec_basisVec` の 5 段 |
| 同 周期境界項の 8 行 `Gf_{ι(s)} = ⋯ = (s(M_col)s(1))_ℂ f_{ι(s)}` | `boundaryG_mulVec_basisVec` の 8 段 |

人手の `ε σ^z_k = -σ^z_k ε`（`epsilon_anticommutes_with_site_sigma_z`）は
`epsilon_anticomm_sigmaZ`、`σ^z_m f_{ι(s)} = s(m) f_{ι(s)}`（`sigma_z_diagonal_action`）は
`sigmaZ_mulVec_basisVec_spin`、`ε^2 = I` は `epsilon_sq`、`distinct_site_pauli_matrices_commute` は `siteOp_mul_comm` である。

この証明が使うのは、既存の補題 `epsilon_anticomm_sigmaZ`・`siteOp_mul_comm`・`sigmaZ_mulVec_basisVec_spin`・`epsilon_sq`・
`pauliZ_mul_pauliZ`・`siteProd_mul`・`siteProd_one`・`update_one_mul_update_one_same`・`identity_matrix_mul`・`identity_matrix_mul_tensorPow`・`real_inclusion_mul`（`ℝ` から `ℂ` への包含が積を保つこと）に加えて、
環の公理と有限和・スカラー倍の線型性と、包含が有限和を保つことと、和の添字の読み替え
`sum_filter_not_last_eq_sum_castSucc`（`ClaimH1PlusInSigmaZForm.lean`）だけである。
既存の関係を環の公理と有限和の分配で組み合わせるだけで、主張に固有の構造が無いので、必要十分版は置かない
（`H1_plus_in_sigma_z_form` と同じ判断）。
-/
import Ising2D.EigenvalueProblem.EigenvectorOfMaxEigenvalue.DefinitionOpenChainAndBoundaryOperators
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesFiniteSum
import Ising2D.PartitionFunction.TransferMatrixRepresentation.ClaimSigmaZDiagonalAction
import Ising2D.PartitionFunction.ProjectionAndJordanWigner.ClaimEpsilonCommutes
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesProduct
import Ising2D.EigenvalueProblem.EigenvectorOfMaxEigenvalue.ClaimH1PlusInSigmaZForm
import Ising2D.EigenvalueProblem.EigenvaluesOfVPlus.ClaimSignFlipConjugation
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimNegationFactorsOutOfMatrixProductFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimMatrixDoubleNegationFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimFiniteSumOfMatricesDistributesInLeftFactorFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimFiniteSumOfMatricesDistributesInRightFactorFromNecSuf

namespace Ising2D

open Matrix

variable {M : ℕ}

/-! ## `epsilon_D0_G_pairwise_commute`

人手の 3 つの準備（`ε` と `σ^z` の対の可換の 8 行、`σ^z` どうしの可換の場合分け、`σ^z` の対と `G` の可換の 14 行）と
3 つの鎖（`εD_0 = D_0ε` の 5 行、`εG = Gε` の 3 行、`D_0G = GD_0` の 5 行）が、下の 6 つの定理の `calc` の段と 1 対 1 に対応する。
`mat_mult_associative` の段は、Lean の具体版が無いので mathlib の `Matrix.mul_assoc` を 1 回ずつ引く（ほかのファイルと同じ扱い）。
`negation_factors_out_of_left_factor`・`negation_factors_out_of_right_factor`・`matrix_double_negation`・
`finite_sum_of_matrices_distributes_in_left_factor`・`finite_sum_of_matrices_distributes_in_right_factor` の段は、
具体版の `TensorPow M` の系 `neg_mul_matrix_tensorPow`・`mul_neg_matrix_tensorPow`・`neg_neg_tensorPow`・`finite_sum_mul_tensorPow`・
`mul_finite_sum_tensorPow` を引く。和の鎖は `H1_plus_in_sigma_z_form` と同じく `M_col = r + 2` と置き、人手の和 `Σ_{m=1}^{M_col-1}` を
`Fin (r + 1)` の上の和（人手の `m` は `Fin.castSucc j`）で書く。1 段目と 5 段目（`def_D0_open_chain_operator`）は、
Lean の `openChainD0` の和の書き方（`Finset.filter`）をこの和へ読み替える段を含む（`sum_filter_not_last_eq_sum_castSucc`）。 -/

/-- **人手 `epsilon_D0_G_pairwise_commute` の準備（`ε` と `σ^z` の対の可換）** `ε(σ^z_jσ^z_k) = ⋯ = (σ^z_jσ^z_k)ε` の 8 行。 -/
theorem epsilon_mul_sigmaZ_mul_sigmaZ (j k : Fin M) :
    epsilon M * (sigmaZ j * sigmaZ k) = (sigmaZ j * sigmaZ k) * epsilon M :=
  calc epsilon M * (sigmaZ j * sigmaZ k)
      = (epsilon M * sigmaZ j) * sigmaZ k :=
        (Matrix.mul_assoc _ _ _).symm                   -- `mat_mult_associative`
    _ = (-(sigmaZ j * epsilon M)) * sigmaZ k := by
        rw [epsilon_anticomm_sigmaZ j]                  -- `epsilon_anticommutes_with_site_sigma_z`（`k → j`）
    _ = -((sigmaZ j * epsilon M) * sigmaZ k) :=
        neg_mul_matrix_tensorPow _ _                    -- `negation_factors_out_of_left_factor`
    _ = -(sigmaZ j * (epsilon M * sigmaZ k)) := by
        rw [Matrix.mul_assoc]                           -- `mat_mult_associative`
    _ = -(sigmaZ j * (-(sigmaZ k * epsilon M))) := by
        rw [epsilon_anticomm_sigmaZ k]                  -- `epsilon_anticommutes_with_site_sigma_z`（`k → k`）
    _ = -(-(sigmaZ j * (sigmaZ k * epsilon M))) := by
        rw [mul_neg_matrix_tensorPow]                   -- `negation_factors_out_of_right_factor`
    _ = sigmaZ j * (sigmaZ k * epsilon M) :=
        neg_neg_tensorPow _                             -- `matrix_double_negation`
    _ = (sigmaZ j * sigmaZ k) * epsilon M :=
        (Matrix.mul_assoc _ _ _).symm                   -- `mat_mult_associative`

/-- **人手 `epsilon_D0_G_pairwise_commute` の準備（`σ^z` どうしの可換）** `σ^z_jσ^z_k = σ^z_kσ^z_j`。

人手どおり `j ≠ k` と `j = k` に場合を分ける。`j ≠ k` は `distinct_site_pauli_matrices_commute`（`a = b = z`）の具体版
`siteOp_mul_comm`、`j = k` は両辺が同じ行列である。 -/
theorem sigmaZ_mul_sigmaZ_comm (j k : Fin M) : sigmaZ j * sigmaZ k = sigmaZ k * sigmaZ j := by
  by_cases h : j = k
  · rw [h]                                              -- `j = k`: 両辺は同じ行列
  · exact siteOp_mul_comm h pauliZ pauliZ               -- `distinct_site_pauli_matrices_commute`（`a = b = z`）

/-- **人手 `epsilon_D0_G_pairwise_commute` の準備（`σ^z` の対と `G` の可換）**
`(σ^z_aσ^z_b)G = ⋯ = G(σ^z_aσ^z_b)` の 14 行。

人手の準備は `a = m`、`b = m + 1`（`m ∈ {1, …, M_col-1}`）について書くが、鎖は `b = a + 1` を使わないので、Lean は
任意の 2 サイト `a, b` について述べる（`D_0G = GD_0` の鎖で `a → m`、`b → m + 1` として使う）。人手のサイト `M_col` は
`lastSite M hM`、サイト `1` は `firstSite M hM` で、`G` の定義に要る `M ≠ 0` だけを仮定する。 -/
theorem sigmaZ_mul_sigmaZ_mul_boundaryG (hM : M ≠ 0) (a b : Fin M) :
    (sigmaZ a * sigmaZ b) * boundaryG M hM = boundaryG M hM * (sigmaZ a * sigmaZ b) :=
  calc (sigmaZ a * sigmaZ b) * boundaryG M hM
      = (sigmaZ a * sigmaZ b) * (sigmaZ (lastSite M hM) * sigmaZ (firstSite M hM)) := by
        rw [boundaryG]                                  -- `def_G_boundary_operator`
    _ = sigmaZ a * (sigmaZ b * (sigmaZ (lastSite M hM) * sigmaZ (firstSite M hM))) :=
        Matrix.mul_assoc _ _ _                          -- `mat_mult_associative`
    _ = sigmaZ a * ((sigmaZ b * sigmaZ (lastSite M hM)) * sigmaZ (firstSite M hM)) := by
        rw [Matrix.mul_assoc (sigmaZ b)]                -- `mat_mult_associative`
    _ = sigmaZ a * ((sigmaZ (lastSite M hM) * sigmaZ b) * sigmaZ (firstSite M hM)) := by
        rw [sigmaZ_mul_sigmaZ_comm b (lastSite M hM)]   -- 準備（`σ^z` どうしの可換）（`j → b`、`k → M_col`。人手の `b` は `m+1`）
    _ = sigmaZ a * (sigmaZ (lastSite M hM) * (sigmaZ b * sigmaZ (firstSite M hM))) := by
        rw [Matrix.mul_assoc (sigmaZ (lastSite M hM))]  -- `mat_mult_associative`
    _ = sigmaZ a * (sigmaZ (lastSite M hM) * (sigmaZ (firstSite M hM) * sigmaZ b)) := by
        rw [sigmaZ_mul_sigmaZ_comm b (firstSite M hM)]  -- 準備（`σ^z` どうしの可換）（`j → b`、`k → 1`）
    _ = (sigmaZ a * sigmaZ (lastSite M hM)) * (sigmaZ (firstSite M hM) * sigmaZ b) :=
        (Matrix.mul_assoc _ _ _).symm                   -- `mat_mult_associative`
    _ = (sigmaZ (lastSite M hM) * sigmaZ a) * (sigmaZ (firstSite M hM) * sigmaZ b) := by
        rw [sigmaZ_mul_sigmaZ_comm a (lastSite M hM)]   -- 準備（`σ^z` どうしの可換）（`j → a`、`k → M_col`。人手の `a` は `m`）
    _ = sigmaZ (lastSite M hM) * (sigmaZ a * (sigmaZ (firstSite M hM) * sigmaZ b)) :=
        Matrix.mul_assoc _ _ _                          -- `mat_mult_associative`
    _ = sigmaZ (lastSite M hM) * ((sigmaZ a * sigmaZ (firstSite M hM)) * sigmaZ b) := by
        rw [Matrix.mul_assoc (sigmaZ a)]                -- `mat_mult_associative`
    _ = sigmaZ (lastSite M hM) * ((sigmaZ (firstSite M hM) * sigmaZ a) * sigmaZ b) := by
        rw [sigmaZ_mul_sigmaZ_comm a (firstSite M hM)]  -- 準備（`σ^z` どうしの可換）（`j → a`、`k → 1`）
    _ = sigmaZ (lastSite M hM) * (sigmaZ (firstSite M hM) * (sigmaZ a * sigmaZ b)) := by
        rw [Matrix.mul_assoc (sigmaZ (firstSite M hM))] -- `mat_mult_associative`
    _ = (sigmaZ (lastSite M hM) * sigmaZ (firstSite M hM)) * (sigmaZ a * sigmaZ b) :=
        (Matrix.mul_assoc _ _ _).symm                   -- `mat_mult_associative`
    _ = boundaryG M hM * (sigmaZ a * sigmaZ b) := by
        rw [boundaryG]                                  -- `def_G_boundary_operator`

/-- **人手 `epsilon_D0_G_pairwise_commute` の `εD_0 = D_0ε`** の 5 行（`M_col ≥ 2`）。 -/
theorem epsilon_mul_openChainD0 (hM : 2 ≤ M) :
    epsilon M * openChainD0 M = openChainD0 M * epsilon M := by
  obtain ⟨r, rfl⟩ : ∃ r, M = r + 2 := ⟨M - 2, by omega⟩
  calc epsilon (r + 2) * openChainD0 (r + 2)
      = epsilon (r + 2) * ∑ j : Fin (r + 1), sigmaZ (Fin.castSucc j) * sigmaZ (nextSite (Fin.castSucc j)) := by
        rw [openChainD0, sum_filter_not_last_eq_sum_castSucc r (fun m => sigmaZ m * sigmaZ (nextSite m))]
                                                        -- `def_D0_open_chain_operator`（和の添字を `Fin (r + 1)` へ読み替える）
    _ = ∑ j : Fin (r + 1), epsilon (r + 2) * (sigmaZ (Fin.castSucc j) * sigmaZ (nextSite (Fin.castSucc j))) :=
        mul_finite_sum_tensorPow r _ _                  -- `finite_sum_of_matrices_distributes_in_right_factor`（`r → M_col - 1`）
    _ = ∑ j : Fin (r + 1), (sigmaZ (Fin.castSucc j) * sigmaZ (nextSite (Fin.castSucc j))) * epsilon (r + 2) :=
        Finset.sum_congr rfl fun j _ =>
          epsilon_mul_sigmaZ_mul_sigmaZ (Fin.castSucc j) (nextSite (Fin.castSucc j))
                                                        -- 準備（`ε` と `σ^z` の対の可換）（`j → m`、`k → m+1`）
    _ = (∑ j : Fin (r + 1), sigmaZ (Fin.castSucc j) * sigmaZ (nextSite (Fin.castSucc j))) * epsilon (r + 2) :=
        (finite_sum_mul_tensorPow r _ _).symm           -- `finite_sum_of_matrices_distributes_in_left_factor`（`r → M_col - 1`）
    _ = openChainD0 (r + 2) * epsilon (r + 2) := by
        rw [openChainD0, sum_filter_not_last_eq_sum_castSucc r (fun m => sigmaZ m * sigmaZ (nextSite m))]
                                                        -- `def_D0_open_chain_operator`（和の添字を `Fin (r + 1)` へ読み替える）

/-- **人手 `epsilon_D0_G_pairwise_commute` の `εG = Gε`** の 3 行。`G` の定義に要る `M ≠ 0` だけを仮定する。 -/
theorem epsilon_mul_boundaryG (hM : M ≠ 0) :
    epsilon M * boundaryG M hM = boundaryG M hM * epsilon M :=
  calc epsilon M * boundaryG M hM
      = epsilon M * (sigmaZ (lastSite M hM) * sigmaZ (firstSite M hM)) := by
        rw [boundaryG]                                  -- `def_G_boundary_operator`
    _ = (sigmaZ (lastSite M hM) * sigmaZ (firstSite M hM)) * epsilon M :=
        epsilon_mul_sigmaZ_mul_sigmaZ (lastSite M hM) (firstSite M hM)
                                                        -- 準備（`ε` と `σ^z` の対の可換）（`j → M_col`、`k → 1`）
    _ = boundaryG M hM * epsilon M := by
        rw [boundaryG]                                  -- `def_G_boundary_operator`

/-- **人手 `epsilon_D0_G_pairwise_commute` の `D_0G = GD_0`** の 5 行（`M_col ≥ 2`）。 -/
theorem openChainD0_mul_boundaryG (hM : 2 ≤ M) :
    openChainD0 M * boundaryG M (by omega) = boundaryG M (by omega) * openChainD0 M := by
  obtain ⟨r, rfl⟩ : ∃ r, M = r + 2 := ⟨M - 2, by omega⟩
  have hM0 : r + 2 ≠ 0 := by omega
  calc openChainD0 (r + 2) * boundaryG (r + 2) hM0
      = (∑ j : Fin (r + 1), sigmaZ (Fin.castSucc j) * sigmaZ (nextSite (Fin.castSucc j))) * boundaryG (r + 2) hM0 := by
        rw [openChainD0, sum_filter_not_last_eq_sum_castSucc r (fun m => sigmaZ m * sigmaZ (nextSite m))]
                                                        -- `def_D0_open_chain_operator`（和の添字を `Fin (r + 1)` へ読み替える）
    _ = ∑ j : Fin (r + 1), (sigmaZ (Fin.castSucc j) * sigmaZ (nextSite (Fin.castSucc j))) * boundaryG (r + 2) hM0 :=
        finite_sum_mul_tensorPow r _ _                  -- `finite_sum_of_matrices_distributes_in_left_factor`（`r → M_col - 1`）
    _ = ∑ j : Fin (r + 1), boundaryG (r + 2) hM0 * (sigmaZ (Fin.castSucc j) * sigmaZ (nextSite (Fin.castSucc j))) :=
        Finset.sum_congr rfl fun j _ =>
          sigmaZ_mul_sigmaZ_mul_boundaryG hM0 (Fin.castSucc j) (nextSite (Fin.castSucc j))
                                                        -- 準備（`σ^z` の対と `G` の可換）
    _ = boundaryG (r + 2) hM0 * ∑ j : Fin (r + 1), sigmaZ (Fin.castSucc j) * sigmaZ (nextSite (Fin.castSucc j)) :=
        (mul_finite_sum_tensorPow r _ _).symm           -- `finite_sum_of_matrices_distributes_in_right_factor`（`r → M_col - 1`）
    _ = boundaryG (r + 2) hM0 * openChainD0 (r + 2) := by
        rw [openChainD0, sum_filter_not_last_eq_sum_castSucc r (fun m => sigmaZ m * sigmaZ (nextSite m))]
                                                        -- `def_D0_open_chain_operator`（和の添字を `Fin (r + 1)` へ読み替える）

/-! ## `epsilon_G_is_involution`

人手の準備（`σ^z_kσ^z_k = I` の 5 行）と主張の 15 行が、下の 2 つの定理の `calc` の段と 1 対 1 に対応する。
`siteProd M x` が人手のクロネッカー積 `x_1 ⊠ ⋯ ⊠ x_{M_col}`、`Function.update 1 k A` が「`k` 番目だけ `A`、ほかは
`I = I_{Mat(2,ℂ)}`」の因子の並びである（`ClaimSignFlipConjugation.lean` の `σ_m^aσ_m^a = I` の鎖と同じ書き方。
因子ごとの積の並べ替え `update_one_mul_update_one_same` もそこから引く）。人手の `X^2 := XX` は mathlib の `sq`、
`mat_mult_associative` の段は具体版が無いので `Matrix.mul_assoc` を 1 回ずつ引く（ほかのファイルと同じ扱い）。
`identity_matrix_is_left_unit_of_mat_mult` の段は、`Mat(2,ℂ)` では具体版 `identity_matrix_mul`、`Mat(2^{M_col},ℂ)` では
`TensorPow M` の系 `identity_matrix_mul_tensorPow` を引く。 -/

/-- **人手 `epsilon_G_is_involution` の準備** `σ^z_kσ^z_k = ⋯ = I_{Mat(2^{M_col},ℂ)}` の 5 行。 -/
theorem sigmaZ_mul_self (k : Fin M) : sigmaZ k * sigmaZ k = 1 :=
  calc sigmaZ k * sigmaZ k
      = siteProd M (Function.update 1 k pauliZ) * siteProd M (Function.update 1 k pauliZ) := rfl
                                                        -- `def_site_pauli_matrices`
    _ = siteProd M (Function.update (fun _ : Fin M => (1 : Matrix (Fin 2) (Fin 2) ℂ) * 1) k (pauliZ * pauliZ)) := by
        rw [← siteProd_mul, update_one_mul_update_one_same]
                                                        -- `kronecker_product_rule` (1)
    _ = siteProd M (Function.update (fun _ : Fin M => (1 : Matrix (Fin 2) (Fin 2) ℂ)) k (pauliZ * pauliZ)) := by
        rw [identity_matrix_mul (1 : Matrix (Fin 2) (Fin 2) ℂ)]
                                                        -- `identity_matrix_is_left_unit_of_mat_mult`（`k` 以外の各サイトで）
    _ = siteProd M (Function.update (fun _ : Fin M => (1 : Matrix (Fin 2) (Fin 2) ℂ)) k 1) := by
        rw [pauliZ_mul_pauliZ]                          -- `pauli_matrix_products` の `σ^zσ^z = I`
    _ = 1 := by
        rw [Function.update_eq_self_iff.mpr rfl]
        exact siteProd_one M                            -- `kronecker_product_rule` (2)

/-- **人手 `epsilon_G_is_involution`**: `(εG)^2 = ⋯ = I_{Mat(2^{M_col},ℂ)}` の 15 行（`M_col ≥ 2`）。

人手は `M_col ≥ 2` から `M_col ≠ 1`（サイト `1` と `M_col` が異なること）を出し、11 行目で
`distinct_site_pauli_matrices_commute` を引く。Lean はその具体版 `siteOp_mul_comm` に `firstSite ≠ lastSite` を渡す。 -/
theorem epsilon_mul_boundaryG_sq (hM : 2 ≤ M) :
    (epsilon M * boundaryG M (by omega)) ^ 2 = 1 := by
  have hM0 : M ≠ 0 := by omega
  have hne : firstSite M hM0 ≠ lastSite M hM0 :=
    Fin.ne_of_val_ne (by simp [firstSite, lastSite]; omega)
                                                        -- `M_col ≥ 2` より `M_col ≠ 1`
  calc (epsilon M * boundaryG M hM0) ^ 2
      = (epsilon M * boundaryG M hM0) * (epsilon M * boundaryG M hM0) :=
        sq _                                            -- `X^2 := XX`
    _ = ((epsilon M * boundaryG M hM0) * epsilon M) * boundaryG M hM0 :=
        (Matrix.mul_assoc _ _ _).symm                   -- `mat_mult_associative`
    _ = (epsilon M * (boundaryG M hM0 * epsilon M)) * boundaryG M hM0 := by
        rw [Matrix.mul_assoc (epsilon M)]               -- `mat_mult_associative`
    _ = (epsilon M * (epsilon M * boundaryG M hM0)) * boundaryG M hM0 := by
        rw [epsilon_mul_boundaryG hM0]                  -- `epsilon_D0_G_pairwise_commute` の `εG = Gε`
    _ = ((epsilon M * epsilon M) * boundaryG M hM0) * boundaryG M hM0 := by
        rw [Matrix.mul_assoc (epsilon M) (epsilon M)]   -- `mat_mult_associative`
    _ = (1 * boundaryG M hM0) * boundaryG M hM0 := by
        rw [epsilon_sq]                                 -- `epsilon_square_and_eigenvalues` の `εε = I`
    _ = boundaryG M hM0 * boundaryG M hM0 := by
        rw [identity_matrix_mul_tensorPow]              -- `identity_matrix_is_left_unit_of_mat_mult`
    _ = (sigmaZ (lastSite M hM0) * sigmaZ (firstSite M hM0))
          * (sigmaZ (lastSite M hM0) * sigmaZ (firstSite M hM0)) := by
        rw [boundaryG]                                  -- `def_G_boundary_operator`
    _ = sigmaZ (lastSite M hM0)
          * (sigmaZ (firstSite M hM0) * (sigmaZ (lastSite M hM0) * sigmaZ (firstSite M hM0))) :=
        Matrix.mul_assoc _ _ _                          -- `mat_mult_associative`
    _ = sigmaZ (lastSite M hM0)
          * ((sigmaZ (firstSite M hM0) * sigmaZ (lastSite M hM0)) * sigmaZ (firstSite M hM0)) := by
        rw [Matrix.mul_assoc (sigmaZ (firstSite M hM0))] -- `mat_mult_associative`
    _ = sigmaZ (lastSite M hM0)
          * ((sigmaZ (lastSite M hM0) * sigmaZ (firstSite M hM0)) * sigmaZ (firstSite M hM0)) := by
        rw [show sigmaZ (firstSite M hM0) * sigmaZ (lastSite M hM0)
              = sigmaZ (lastSite M hM0) * sigmaZ (firstSite M hM0) from siteOp_mul_comm hne pauliZ pauliZ]
                                                        -- `distinct_site_pauli_matrices_commute`（`j → 1`、`k → M_col`、`a = b = z`）
    _ = sigmaZ (lastSite M hM0)
          * (sigmaZ (lastSite M hM0) * (sigmaZ (firstSite M hM0) * sigmaZ (firstSite M hM0))) := by
        rw [Matrix.mul_assoc (sigmaZ (lastSite M hM0)) (sigmaZ (firstSite M hM0))]
                                                        -- `mat_mult_associative`
    _ = (sigmaZ (lastSite M hM0) * sigmaZ (lastSite M hM0))
          * (sigmaZ (firstSite M hM0) * sigmaZ (firstSite M hM0)) :=
        (Matrix.mul_assoc _ _ _).symm                   -- `mat_mult_associative`
    _ = 1 * 1 := by
        rw [sigmaZ_mul_self, sigmaZ_mul_self]           -- 準備を `k = M_col` と `k = 1` で
    _ = 1 :=
        identity_matrix_mul_tensorPow 1                 -- `identity_matrix_is_left_unit_of_mat_mult`

/-! ## `D0_G_diagonal_action`

人手の 3 つの鎖（準備の 7 行、開鎖項の 5 行、周期境界項の 8 行）と、下の 3 つの定理の `calc` の段が 1 対 1 に対応する。
Lean の数ベクトルは 1 列の行列ではなく `Conf M → ℂ` なので、人手の `mat_mult_associative`・
`scalar_multiple_factors_out_of_right_factor`・`finite_sum_of_matrices_distributes_in_left_factor`・
`finite_sum_of_scalar_multiples_of_one_matrix` を数ベクトルへ使う段は、mathlib の `Matrix.mulVec_mulVec`・`Matrix.mulVec_smul`・
`Matrix.sum_mulVec`・`Finset.sum_smul` を引く（いずれも数ベクトルの版の具体版は無い。`finite_sum_of_scalar_multiples_of_one_matrix` の
具体版 `finite_sum_smul_one_matrix` とその系 `finite_sum_smul_one_tensorPow` は `Fin (r + 1)` の上の行列の和について述べるので、
`Finset.filter` の上の数ベクトルの和には使えない）。
`scalar_multiple_is_associative` にも Lean の具体版は無く、mathlib の `smul_smul` を引く。
`real_inclusion_preserves_finite_sum` は具体版の `Finset.filter` の上の和の形 `real_inclusion_of_finite_sum_finset` を引く
（人手は `M_col ≥ 2` だが、Lean の主張は人手の範囲外の `M ≤ 1` も含み、そのとき和は空なので、空の場合を分ける版を経る）。`real_inclusion_preserves_product` は具体版 `real_inclusion_mul` を引く。 -/

/-- **人手 `D0_G_diagonal_action` の準備** `(σ^z_aσ^z_b)f_{ι(s)} = ⋯ = (s(a)s(b))_ℂ f_{ι(s)}` の 7 行。

人手の準備は `a = m`、`b = m + 1` について書くが、鎖は `b = a + 1` を使わないので、Lean は相異なるとも限らない
任意の 2 サイト `a, b` について述べる（開鎖項の鎖で `a → m`、`b → m + 1` として使う）。 -/
theorem sigmaZ_mul_sigmaZ_mulVec_basisVec_spin (a b : Fin M) (s : SpinConf M) :
    (sigmaZ a * sigmaZ b) *ᵥ basisVec (configBasisIso M s)
      = (((s a : ℝ) * (s b : ℝ) : ℝ) : ℂ) • basisVec (configBasisIso M s) :=
  calc (sigmaZ a * sigmaZ b) *ᵥ basisVec (configBasisIso M s)
      = sigmaZ a *ᵥ (sigmaZ b *ᵥ basisVec (configBasisIso M s)) :=
        (Matrix.mulVec_mulVec _ _ _).symm               -- `mat_mult_associative`
    _ = sigmaZ a *ᵥ ((((s b : ℝ)) : ℂ) • basisVec (configBasisIso M s)) := by
        rw [sigmaZ_mulVec_basisVec_spin b s]            -- `sigma_z_diagonal_action`（`μ → s`、`m → b`）
    _ = (((s b : ℝ)) : ℂ) • (sigmaZ a *ᵥ basisVec (configBasisIso M s)) :=
        Matrix.mulVec_smul _ _ _                        -- `scalar_multiple_factors_out_of_right_factor`
    _ = (((s b : ℝ)) : ℂ) • ((((s a : ℝ)) : ℂ) • basisVec (configBasisIso M s)) := by
        rw [sigmaZ_mulVec_basisVec_spin a s]            -- `sigma_z_diagonal_action`（`μ → s`、`m → a`）
    _ = ((((s b : ℝ)) : ℂ) * (((s a : ℝ)) : ℂ)) • basisVec (configBasisIso M s) :=
        smul_smul _ _ _                                 -- `scalar_multiple_is_associative`
    _ = (((s b : ℝ) * (s a : ℝ) : ℝ) : ℂ) • basisVec (configBasisIso M s) := by
        rw [real_inclusion_mul]                         -- `real_inclusion_preserves_product`
    _ = (((s a : ℝ) * (s b : ℝ) : ℝ) : ℂ) • basisVec (configBasisIso M s) := by
        rw [mul_comm (s b : ℝ)]                         -- ℝ の積の交換律

/-- **人手 `D0_G_diagonal_action` の `D_0f_{ι(s)} = (∑_{m=1}^{M_col-1}s(m)s(m+1))_ℂ f_{ι(s)}`** の 5 行。

人手の和 `∑_{m=1}^{M_col-1}` は、Lean の `openChainD0` と同じく「`(m : ℕ) + 1 ≠ M` なる `m : Fin M`」の上の和で書く
（人手のサイト `m + 1` は `nextSite m`）。人手は `M_col ≥ 2` を仮定するが、この形の和は `M ≤ 1` でも意味を持ち、
鎖も `M` の大きさを使わないので、Lean は仮定を置かない。 -/
theorem openChainD0_mulVec_basisVec (s : SpinConf M) :
    openChainD0 M *ᵥ basisVec (configBasisIso M s)
      = ((∑ m ∈ Finset.univ.filter (fun m : Fin M => (m : ℕ) + 1 ≠ M),
            (s m : ℝ) * (s (nextSite m) : ℝ) : ℝ) : ℂ) • basisVec (configBasisIso M s) :=
  calc openChainD0 M *ᵥ basisVec (configBasisIso M s)
      = (∑ m ∈ Finset.univ.filter (fun m : Fin M => (m : ℕ) + 1 ≠ M),
          sigmaZ m * sigmaZ (nextSite m)) *ᵥ basisVec (configBasisIso M s) := by
        rw [openChainD0]                                -- `def_D0_open_chain_operator`
    _ = ∑ m ∈ Finset.univ.filter (fun m : Fin M => (m : ℕ) + 1 ≠ M),
          (sigmaZ m * sigmaZ (nextSite m)) *ᵥ basisVec (configBasisIso M s) :=
        Matrix.sum_mulVec _ _ _                         -- `finite_sum_of_matrices_distributes_in_left_factor`（`r → M_col - 1`）
    _ = ∑ m ∈ Finset.univ.filter (fun m : Fin M => (m : ℕ) + 1 ≠ M),
          (((s m : ℝ) * (s (nextSite m) : ℝ) : ℝ) : ℂ) • basisVec (configBasisIso M s) :=
        Finset.sum_congr rfl fun m _ => sigmaZ_mul_sigmaZ_mulVec_basisVec_spin m (nextSite m) s
                                                        -- 準備の等式を各 `m` へ同時に適用
    _ = (∑ m ∈ Finset.univ.filter (fun m : Fin M => (m : ℕ) + 1 ≠ M),
          (((s m : ℝ) * (s (nextSite m) : ℝ) : ℝ) : ℂ)) • basisVec (configBasisIso M s) :=
        Finset.sum_smul.symm                            -- `finite_sum_of_scalar_multiples_of_one_matrix`
                                                        -- （`r → M_col - 1`、`c_j → (s(j)s(j+1))_ℂ`）
    _ = ((∑ m ∈ Finset.univ.filter (fun m : Fin M => (m : ℕ) + 1 ≠ M),
            (s m : ℝ) * (s (nextSite m) : ℝ) : ℝ) : ℂ) • basisVec (configBasisIso M s) := by
        rw [← real_inclusion_of_finite_sum_finset]                   -- `real_inclusion_preserves_finite_sum`
                                                        -- （`m → M_col - 1`、`r_j → s(j)s(j+1)`）

/-- **人手 `D0_G_diagonal_action` の `Gf_{ι(s)} = (s(M_col)s(1))_ℂ f_{ι(s)}`** の 8 行。

人手はこの鎖を準備を引かずに書き下しているので、Lean も準備の定理を引かずに同じ 8 段を書く
（人手のサイト `M_col` は `lastSite M hM`、サイト `1` は `firstSite M hM`）。人手は `M_col ≥ 2` を仮定するが、
`G` の定義に要るのは `M ≠ 0` だけで、鎖も `M` の大きさを使わないので、Lean は `hM : M ≠ 0` だけを仮定する。 -/
theorem boundaryG_mulVec_basisVec (hM : M ≠ 0) (s : SpinConf M) :
    boundaryG M hM *ᵥ basisVec (configBasisIso M s)
      = (((s (lastSite M hM) : ℝ) * (s (firstSite M hM) : ℝ) : ℝ) : ℂ)
          • basisVec (configBasisIso M s) :=
  calc boundaryG M hM *ᵥ basisVec (configBasisIso M s)
      = (sigmaZ (lastSite M hM) * sigmaZ (firstSite M hM)) *ᵥ basisVec (configBasisIso M s) := by
        rw [boundaryG]                                  -- `def_G_boundary_operator`
    _ = sigmaZ (lastSite M hM) *ᵥ (sigmaZ (firstSite M hM) *ᵥ basisVec (configBasisIso M s)) :=
        (Matrix.mulVec_mulVec _ _ _).symm               -- `mat_mult_associative`
    _ = sigmaZ (lastSite M hM) *ᵥ ((((s (firstSite M hM) : ℝ)) : ℂ) • basisVec (configBasisIso M s)) := by
        rw [sigmaZ_mulVec_basisVec_spin (firstSite M hM) s]
                                                        -- `sigma_z_diagonal_action`（`μ → s`、`m → 1`）
    _ = (((s (firstSite M hM) : ℝ)) : ℂ) • (sigmaZ (lastSite M hM) *ᵥ basisVec (configBasisIso M s)) :=
        Matrix.mulVec_smul _ _ _                        -- `scalar_multiple_factors_out_of_right_factor`
    _ = (((s (firstSite M hM) : ℝ)) : ℂ)
          • ((((s (lastSite M hM) : ℝ)) : ℂ) • basisVec (configBasisIso M s)) := by
        rw [sigmaZ_mulVec_basisVec_spin (lastSite M hM) s]
                                                        -- `sigma_z_diagonal_action`（`μ → s`、`m → M_col`）
    _ = ((((s (firstSite M hM) : ℝ)) : ℂ) * (((s (lastSite M hM) : ℝ)) : ℂ))
          • basisVec (configBasisIso M s) :=
        smul_smul _ _ _                                 -- `scalar_multiple_is_associative`
    _ = (((s (firstSite M hM) : ℝ) * (s (lastSite M hM) : ℝ) : ℝ) : ℂ)
          • basisVec (configBasisIso M s) := by
        rw [real_inclusion_mul]                         -- `real_inclusion_preserves_product`
    _ = (((s (lastSite M hM) : ℝ) * (s (firstSite M hM) : ℝ) : ℝ) : ℂ)
          • basisVec (configBasisIso M s) := by
        rw [mul_comm (s (firstSite M hM) : ℝ)]          -- ℝ の積の交換律

end Ising2D
