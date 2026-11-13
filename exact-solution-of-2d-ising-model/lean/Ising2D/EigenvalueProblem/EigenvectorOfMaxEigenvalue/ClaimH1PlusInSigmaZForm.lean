/-
# `i H_1^{(+)} = D_0 + ε G`（具体版）

正本: `structured-latex/content/eigenvalue_problem_eigenvector_of_max_eigenvalue.ts`
（`closing_004_claim_H1_plus_in_sigma_z_form`、ラベル **`H1_plus_in_sigma_z_form`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 1 サイトの積 `σ^yσ^x = -iσ^z`（`pauli_y_times_pauli_x`）, `σ^xσ^x = I`（`pauli_matrix_products`） | `pauliY_mul_pauliX_eq`（`Ising2D.PartitionFunction.ProjectionAndJordanWigner.ClaimV1InZYEpsilon`。その `calc` は旧い `V1_in_Z_Y_epsilon` の Step 0 の鎖に合わせたもので、`pauli_y_times_pauli_x` の 7 行の証明とは 1 対 1 でない）、`pauliX_mul_pauliX`（`Ising2D.PartitionFunction.ProjectionAndJordanWigner.DefinitionTransferMatrixSymbols`） |
| 1 サイトの積 `σ^xσ^z = -iσ^y`（`pauli_x_times_pauli_z`） | `pauliX_mul_pauliZ_eq`（人手 `iH_is_real_symmetric` の Step 0 の第 3 の鎖と 1 対 1） |
| 準備 1 の `Y_m`・`Z_{m+1}` の鎖（各 2 行）と `σ_m^zσ_{m+1}^z` の鎖（4 行） | `Y_kronecker_form`・`Z_nextSite_kronecker_form`（定義そのもので `rfl`）と `sigmaZ_mul_sigmaZ_nextSite_kronecker` の `calc` の 4 段（サイト `m` と `m+1` が異なることは `ne_nextSite_of_not_last`） |
| 準備 2 の `Y_{M_col}`・`Z_1` の鎖（各 2 行）、`ε` の式、`σ_{M_col}^zσ_1^z` の鎖（4 行） | `Y_lastSite_kronecker_form`（`rfl`）・`Z_firstSite_kronecker_form` の `calc` の 2 段・`epsilon_kronecker_form`・`sigmaZ_lastSite_mul_sigmaZ_firstSite_kronecker` の `calc` の 4 段 |
| 準備 3 の 11 行の鎖 `i(Y_mZ_{m+1}) = ⋯ = σ_m^zσ_{m+1}^z`（`m ∈ {1,…,M_col-1}`） | `I_smul_Y_mul_Z_next_of_not_last` の `calc` の 11 段（7 段目の `kronecker_multilinear` の `r = 1` の式は `siteProd_ite_smul`） |
| 準備 4 の 17 行の鎖 `-(i(Y_{M_col}Z_1)) = ⋯ = εG`（`M_col ≥ 2`） | `neg_I_smul_Y_lastSite_mul_Z_firstSite` の `calc` の 17 段（9・11 段目の `kronecker_multilinear` の `r = 1` の式（`j → 1`）は `siteProd_ite_smul`、10 段目（`j → M_col`）は `siteProd_ite_ite_smul`） |
| `def_H1_plus` の `H_1^{(+)} = ∑_{m=1}^{M_col-1}Y_mZ_{m+1} - Y_{M_col}Z_1` | `H1plus_eq_bulk_sub_boundary`（和は `Finset.filter` の上。`Fin (r + 1)` の上の和への読み替えは `sum_filter_not_last_eq_sum_castSucc`） |
| 最後の 7 行の鎖 `iH_1^{(+)} = i(Σ Y_mZ_{m+1} − Y_{M_col}Z_1) = ⋯ = D_0 + εG` | `H1_plus_in_sigma_z_form` の `calc` の 7 段（`M_col = r + 2`。1・5 段目は和の添字の読み替えを含む） |

人手の準備 1・2・3・4 と最後の鎖は、このファイルの同名の節・定理と 1 対 1 である。

具体的な複素行列 `Y_m, Z_m, ε, σ^z_m` の間の等式であり、主張に固有なのは各サイトの Pauli 行列の積だけなので、
必要十分版は置かない（同じ型の主張 `V1_in_Z_Y_epsilon` と同じ判断）。
-/
import Ising2D.EigenvalueProblem.EigenvectorOfMaxEigenvalue.DefinitionOpenChainAndBoundaryOperators
import Ising2D.EigenvalueProblem.ReductionToATheta.ClaimAnticommutatorZY
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimScalarMultipleByOneFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimNegationIsScalarMultipleByMinusOneFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimMatrixDifferenceIsSumWithNegationFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimScalarMultipleDistributesOverMatrixSumFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimScalarMultipleDistributesOverMatrixDifferenceFromNecSuf
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimKroneckerMultilinear
import Ising2D.PartitionFunction.ProjectionAndJordanWigner.ClaimSitePauliPrefixProductKroneckerForm

namespace Ising2D

open Matrix

variable {M : ℕ}

/-! ## 1 サイトの積 -/

/-- 人手 `iH_is_real_symmetric` の Step 0 の準備の 1 本目 `(-i)·i = 1`（`eigenvalue_problem_eigenvalues_of_V_plus.ts`）。
人手の鎖の各段と 1 対 1 に対応する。 -/
theorem negI_mul_I_eq_one : (-Complex.I) * Complex.I = 1 :=
  calc (-Complex.I) * Complex.I
      = ((-1) * Complex.I) * Complex.I := by rw [neg_one_mul]               -- `multiply_by_minus_one`
    _ = (-1) * (Complex.I * Complex.I) := mul_assoc _ _ _                    -- 積の結合律（`complex_numbers_form_a_field`）
    _ = (-1) * (-1) := by rw [Complex.I_mul_I]                              -- ℂ で `i·i = -1`（`definition_of_cc` の積）
    _ = 1 := by rw [neg_one_mul, neg_neg]                                    -- ℂ で `(-1)·(-1) = 1`（`definition_of_cc` の積。Lean では `(-1)·z = -z` と `-(-1) = 1` の 2 補題で閉じる）

/-- 人手 `iH_is_real_symmetric` の Step 0 の準備の 2 本目 `(-i)·(-i) = -1`。人手の鎖の各段と 1 対 1 に対応する。 -/
theorem negI_mul_negI_eq_neg_one : (-Complex.I) * (-Complex.I) = -1 :=
  calc (-Complex.I) * (-Complex.I)
      = (-Complex.I) * ((-1) * Complex.I) := by rw [neg_one_mul Complex.I]  -- `multiply_by_minus_one`
    _ = ((-Complex.I) * (-1)) * Complex.I := (mul_assoc _ _ _).symm         -- 積の結合律（`complex_numbers_form_a_field`）
    _ = ((-1) * (-Complex.I)) * Complex.I := by rw [mul_comm (-Complex.I) (-1)]  -- 積の可換律（`complex_numbers_form_a_field`）
    _ = (-1) * ((-Complex.I) * Complex.I) := mul_assoc _ _ _                 -- 積の結合律（`complex_numbers_form_a_field`）
    _ = (-1) * 1 := by rw [negI_mul_I_eq_one]                               -- 直前の鎖
    _ = -1 := mul_one _                                                      -- `1_ℂ` は積の単位元（`complex_numbers_form_a_field`）

/-- 人手 `iH_is_real_symmetric` の Step 0 の第 3 の鎖 `σ^xσ^z = (-i)σ^y`。人手の鎖の 11 行と `calc` の 11 段が 1 対 1 に対応する。
`H1_plus_in_sigma_z_form` の準備 4 が `pauli_x_times_pauli_z` として使う同じ等式でもある。 -/
theorem pauliX_mul_pauliZ_eq : pauliX * pauliZ = (-Complex.I) • pauliY := by
  calc
    -- `pauli_matrix_products`（Pauli 行列）
    pauliX * pauliZ = !![0, 1; 1, 0] * !![1, 0; 0, -1] := rfl
    -- `mat_mult`
    _ = !![0 * 1 + 1 * 0, 0 * 0 + 1 * (-1);
          1 * 1 + 0 * 0, 1 * 0 + 0 * (-1)] := by
      ext i j
      fin_cases i <;> fin_cases j <;> simp only [Matrix.mul_apply, Fin.sum_univ_two] <;> rfl
    -- `complex_zero_times_is_zero`（4 か所へ同時に適用）
    _ = !![0 + 1 * 0, 0 + 1 * (-1); 1 * 1 + 0, 1 * 0 + 0] := by simp only [zero_mul]
    -- `0_ℂ` は加法の単位元（`complex_numbers_form_a_field`。4 か所へ同時に適用）
    _ = !![1 * 0, 1 * (-1); 1 * 1, 1 * 0] := by simp only [zero_add, add_zero]
    -- `complex_times_zero_is_zero`（2 か所へ同時に適用）
    _ = !![0, 1 * (-1); 1 * 1, 0] := by rw [mul_zero (1 : ℂ)]
    -- `1_ℂ` は積の単位元（`complex_numbers_form_a_field`。2 か所へ同時に適用）
    _ = !![0, -1; 1, 0] := by rw [one_mul (-1 : ℂ), one_mul (1 : ℂ)]
    -- `complex_times_zero_is_zero`（右辺の `(-i)·0` へ。2 か所へ同時に適用）
    _ = !![(-Complex.I) * 0, -1; 1, (-Complex.I) * 0] := by rw [mul_zero (-Complex.I)]
    -- 準備の `(-i)·i = 1`
    _ = !![(-Complex.I) * 0, -1; (-Complex.I) * Complex.I, (-Complex.I) * 0] := by
      rw [negI_mul_I_eq_one]
    -- 準備の `(-i)·(-i) = -1`
    _ = !![(-Complex.I) * 0, (-Complex.I) * (-Complex.I); (-Complex.I) * Complex.I, (-Complex.I) * 0] := by
      rw [negI_mul_negI_eq_neg_one]
    -- `def_matrix_scalar_multiple`
    _ = (-Complex.I) • !![0, -Complex.I; Complex.I, 0] := by
      ext i j
      rw [matrix_smul_apply]
      fin_cases i <;> fin_cases j <;> rfl
    -- `pauli_matrix_products`（Pauli 行列）
    _ = (-Complex.I) • pauliY := rfl

/-! ## 準備 1（内部の辺の因子のクロネッカー積表示）

Lean のサイトの添字は 0 始まりで、人手のサイト `m` は値が `m - 1` の `Fin M` の元である。人手の `m ∈ {1,…,M_col-1}` は Lean の `(m : ℕ) + 1 ≠ M` なる `m : Fin M`、人手の `m+1` は `nextSite m` である。
人手の因子の並び `A⊠⋯⊠A`（`k` 個）は、Lean ではサイトごとの因子の族を `siteProd` に入れたもので、族は
サイトの添字についての `if` で書く（人手の「第 `1` から第 `m-1` 因子」は `(i : ℕ) < (m : ℕ)`、第 `m` 因子は `i = m`）。 -/

/-- **人手の準備 1 の `Y_m` の鎖**（2 行）: `Y_m = σ_1^x⋯σ_{m-1}^xσ_m^y = σ^x⊠⋯⊠σ^x⊠σ^y⊠I⊠⋯⊠I`。

人手の 1 行目（`def_jordan_wigner_Y_matrices`）と 2 行目（`site_pauli_prefix_product_kronecker_form`）は、Lean では
`Y` の定義そのもの（`siteProd` に `jwFamily` を入れたもの）なので `rfl` である（`Z_mul_Y_same` と同じ。Lean の `Y` が
人手の積 `∏_{j=1}^{m}F_j^{(y)}` に等しいことは、`site_pauli_prefix_product_kronecker_form` の具体版を使う `Y_eq_finiteMatrixProduct`
（`ClaimSitePauliPrefixProductKroneckerForm.lean`）が持つ）。
人手は `m ≤ M_col - 1` に限るが、Lean の等式は全ての `m` で成り立つので仮定を置かない。 -/
theorem Y_kronecker_form (m : Fin M) : Y m = siteProd M (jwFamily m pauliY) := rfl

/-- **人手の準備 1 の `Z_{m+1}` の鎖**（2 行）: `Z_{m+1} = σ_1^x⋯σ_m^xσ_{m+1}^z = σ^x⊠⋯⊠σ^x⊠σ^z⊠I⊠⋯⊠I`。
`Y_kronecker_form` と同じ理由で `rfl` である（人手の `m+1` は Lean の `nextSite m`）。 -/
theorem Z_nextSite_kronecker_form (m : Fin M) :
    Z (nextSite m) = siteProd M (jwFamily (nextSite m) pauliZ) := rfl

/-- 人手の `m ∈ {1,…,M_col-1}` のサイト `m` と `m+1` は異なる（`nextSite m` の値は `m + 1`）。 -/
theorem ne_nextSite_of_not_last (m : Fin M) (hm : (m : ℕ) + 1 ≠ M) : m ≠ nextSite m := by
  have hlt : (m : ℕ) + 1 < M := by have := m.isLt; omega
  intro h
  have := congrArg Fin.val h
  rw [nextSite_val_of_lt hlt] at this
  omega

/-- **人手の準備 1 の `σ_m^zσ_{m+1}^z` の鎖**（4 行。`m ∈ {1,…,M_col-1}`）。人手の 4 行と `calc` の 4 段が 1 対 1 に対応する。 -/
theorem sigmaZ_mul_sigmaZ_nextSite_kronecker (m : Fin M) (hm : (m : ℕ) + 1 ≠ M) :
    sigmaZ m * sigmaZ (nextSite m)
      = siteProd M (fun i => if i = m then pauliZ else if i = nextSite m then pauliZ else 1) := by
  have hne := ne_nextSite_of_not_last m hm
  calc
    sigmaZ m * sigmaZ (nextSite m)
        = siteProd M (Function.update 1 m pauliZ)
          * siteProd M (Function.update 1 (nextSite m) pauliZ) := rfl
                                                        -- `def_site_pauli_matrices` を 2 箇所へ同時適用
    _ = siteProd M (fun i =>
          if i = m then pauliZ * 1
          else if i = nextSite m then 1 * pauliZ else 1 * 1) := by
      rw [← siteProd_mul]                               -- `kronecker_product_rule` (1)（`M → M_col`）
      congr 1
      funext i
      simp only [Pi.mul_apply]
      by_cases ha : i = m
      · rw [ha, Function.update_self, Function.update_of_ne hne, if_pos rfl]; rfl
      · by_cases hb : i = nextSite m
        · rw [hb, Function.update_self, Function.update_of_ne hne.symm, if_neg hne.symm, if_pos rfl]; rfl
        · rw [Function.update_of_ne ha, Function.update_of_ne hb, if_neg ha, if_neg hb]; rfl
    _ = siteProd M (fun i =>
          if i = m then pauliZ
          else if i = nextSite m then 1 * pauliZ else 1) := by
      rw [mul_identity_matrix pauliZ, mul_identity_matrix (1 : Matrix (Fin 2) (Fin 2) ℂ)]
                                                        -- `identity_matrix_is_right_unit_of_mat_mult` を `AI` の形の因子（第 `m` 因子と、第 `m`・`m+1` 以外の因子）へ同時適用
    _ = siteProd M (fun i => if i = m then pauliZ else if i = nextSite m then pauliZ else 1) := by
      rw [identity_matrix_mul pauliZ]                   -- `identity_matrix_is_left_unit_of_mat_mult`（第 `m+1` 因子）

/-! ## 準備 2（境界の因子のクロネッカー積表示）

人手のサイト `1` と `M_col` は Lean の `firstSite`・`lastSite` である。 -/

/-- `M_col ≥ 2` なら人手のサイト `1` と `M_col` は異なる。 -/
private theorem firstSite_ne_lastSite (hM : 2 ≤ M) :
    firstSite M (by omega) ≠ lastSite M (by omega) :=
  Fin.ne_of_val_ne (by simp [firstSite, lastSite]; omega)

/-- **人手の準備 2 の `Y_{M_col}` の鎖**（2 行）: `Y_{M_col} = σ_1^x⋯σ_{M_col-1}^xσ_{M_col}^y = σ^x⊠⋯⊠σ^x⊠σ^y`。
`Y_kronecker_form` と同じ理由で `rfl` である。 -/
theorem Y_lastSite_kronecker_form (hM : M ≠ 0) :
    Y (lastSite M hM) = siteProd M (jwFamily (lastSite M hM) pauliY) := rfl

/-- **人手の準備 2 の `Z_1` の鎖**（2 行）: `Z_1 = σ_1^z = σ^z⊠I⊠⋯⊠I`。人手の 2 行と `calc` の 2 段が 1 対 1 に対応する。 -/
theorem Z_firstSite_kronecker_form (hM : M ≠ 0) :
    Z (firstSite M hM) = siteProd M (Function.update 1 (firstSite M hM) pauliZ) :=
  calc
    Z (firstSite M hM) = sigmaZ (firstSite M hM) := Z_zero (Nat.pos_of_ne_zero hM)
                                                        -- `def_jordan_wigner_Z_matrices`（`m = 1`）。人手は `Z_1 = σ_1^z` を有限積の `r = 1` の場合として導き、Lean はそれを補題 `Z_zero` で受ける
    _ = siteProd M (Function.update 1 (firstSite M hM) pauliZ) := rfl
                                                        -- `def_site_pauli_matrices`

/-- **人手の準備 2 の `ε` の式**: `ε = σ^x⊠⋯⊠σ^x`（`global_spin_flip_kronecker_form`）。人手の `M_col ∈ ℤ_{≥1}` は、人手の 2 行の鎖と
1 対 1 の具体版 `global_spin_flip_kronecker_form`（`PartitionFunction/ProjectionAndJordanWigner/ClaimSitePauliPrefixProductKroneckerForm.lean`）で、
人手に無い `M = 0` は `epsilon_eq_siteProd_pauliX_by_induction` で埋める（`epsilon_eq_siteProd` と同じ分け方）。 -/
theorem epsilon_kronecker_form : ∀ {M : ℕ}, epsilon M = siteProd M (fun _ => pauliX)
  | 0 => epsilon_eq_siteProd_pauliX_by_induction
  | n + 1 => global_spin_flip_kronecker_form n

/-- **人手の準備 2 の `σ_{M_col}^zσ_1^z` の鎖**（4 行。`M_col ≥ 2`）。人手の 4 行と `calc` の 4 段が 1 対 1 に対応する。
人手の第 `1` 因子は Lean の `i = firstSite M _`、第 `M_col` 因子は `i = lastSite M _`、第 `2` から第 `M_col-1` 因子はそれ以外である。 -/
theorem sigmaZ_lastSite_mul_sigmaZ_firstSite_kronecker (hM : 2 ≤ M) :
    sigmaZ (lastSite M (by omega)) * sigmaZ (firstSite M (by omega))
      = siteProd M (fun i =>
          if i = firstSite M (by omega) then pauliZ
          else if i = lastSite M (by omega) then pauliZ else 1) := by
  have hne := firstSite_ne_lastSite hM
  calc
    sigmaZ (lastSite M (by omega)) * sigmaZ (firstSite M (by omega))
        = siteProd M (Function.update 1 (lastSite M (by omega)) pauliZ)
          * siteProd M (Function.update 1 (firstSite M (by omega)) pauliZ) := rfl
                                                        -- `def_site_pauli_matrices` を 2 箇所へ同時適用
    _ = siteProd M (fun i =>
          if i = firstSite M (by omega) then 1 * pauliZ
          else if i = lastSite M (by omega) then pauliZ * 1 else 1 * 1) := by
      rw [← siteProd_mul]                               -- `kronecker_product_rule` (1)（`M ≥ 2` より第 `1` 因子と第 `M_col` 因子は異なる）
      congr 1
      funext i
      simp only [Pi.mul_apply]
      by_cases ha : i = firstSite M (by omega)
      · rw [ha, Function.update_self, Function.update_of_ne hne, if_pos rfl]; rfl
      · by_cases hb : i = lastSite M (by omega)
        · rw [hb, Function.update_self, Function.update_of_ne hne.symm, if_neg hne.symm, if_pos rfl]; rfl
        · rw [Function.update_of_ne ha, Function.update_of_ne hb, if_neg ha, if_neg hb]; rfl
    _ = siteProd M (fun i =>
          if i = firstSite M (by omega) then 1 * pauliZ
          else if i = lastSite M (by omega) then pauliZ else 1) := by
      rw [mul_identity_matrix pauliZ, mul_identity_matrix (1 : Matrix (Fin 2) (Fin 2) ℂ)]
                                                        -- `identity_matrix_is_right_unit_of_mat_mult` を `AI` の形の因子（第 `M_col` 因子と、第 `2` から第 `M_col-1` 因子）へ同時適用
    _ = siteProd M (fun i =>
          if i = firstSite M (by omega) then pauliZ
          else if i = lastSite M (by omega) then pauliZ else 1) := by
      rw [identity_matrix_mul pauliZ]                   -- `identity_matrix_is_left_unit_of_mat_mult`（第 `1` 因子）

/-! ## 準備 3（内部の辺）

人手の準備 3 の 11 行の鎖 `i(Y_mZ_{m+1}) = ⋯ = σ_m^zσ_{m+1}^z`（`m ∈ {1,…,M_col-1}`）。添字の読み替えは準備 1 と同じである。 -/

/-- 人手 `kronecker_multilinear` の `r = 1` の式（`j → m`）を、第 `m` 因子を `if` で書いた族について述べたもの。
`kronecker_multilinear` の `r = 1` の場合の具体版 `siteProd_update_smul`（`ClaimKroneckerMultilinear.lean`）を 1 回使う。
族を `Function.update` で書き直す段は、因子の並びの書き方（`ite` と `Function.update`）を揃えるだけである。 -/
theorem siteProd_ite_smul (m : Fin M) (c : ℂ) (A : Matrix (Fin 2) (Fin 2) ℂ)
    (G : Fin M → Matrix (Fin 2) (Fin 2) ℂ) :
    siteProd M (fun i => if i = m then c • A else G i)
      = c • siteProd M (fun i => if i = m then A else G i) := by
  have hc : (fun i => if i = m then c • A else G i) = Function.update G m (c • A) := by
    funext i
    rw [Function.update_apply]
  have h1 : (fun i => if i = m then A else G i) = Function.update G m A := by
    funext i
    rw [Function.update_apply]
  rw [hc, h1]
  exact siteProd_update_smul G m c A

/-- **人手の準備 3**: `i(Y_mZ_{m+1}) = σ_m^zσ_{m+1}^z`（`m ∈ {1,…,M_col-1}`）。人手の 11 行と `calc` の 11 段が 1 対 1 に対応する。

人手の「第 `1` から第 `m-1` 因子」は Lean の `(i : ℕ) < (m : ℕ)`、第 `m` 因子は `i = m`、第 `m+1` 因子は `i = nextSite m`、
第 `m+2` 以降の因子はそれ以外である。5 段目の時点で第 `1` から第 `m-1` 因子（4 段目）と第 `m+2` 以降の因子（5 段目）がどちらも `I` なので、
族の `if` を `i = m`・`i = nextSite m`・それ以外の 3 つの場合に畳む（準備 1 の `σ_m^zσ_{m+1}^z` の鎖の右辺と同じ書き方にするため。
因子の並びは変わらない）。 -/
theorem I_smul_Y_mul_Z_next_of_not_last (m : Fin M) (hm : (m : ℕ) + 1 ≠ M) :
    Complex.I • (Y m * Z (nextSite m)) = sigmaZ m * sigmaZ (nextSite m) := by
  have hlt : (m : ℕ) + 1 < M := by have := m.isLt; omega
  have hnext : ((nextSite m : Fin M) : ℕ) = (m : ℕ) + 1 := nextSite_val_of_lt hlt
  calc
    Complex.I • (Y m * Z (nextSite m))
        = Complex.I • (siteProd M (jwFamily m pauliY) * Z (nextSite m)) := by
      rw [Y_kronecker_form]                             -- 準備 1 の `Y_m` の鎖
    _ = Complex.I • (siteProd M (jwFamily m pauliY) * siteProd M (jwFamily (nextSite m) pauliZ)) := by
      rw [Z_nextSite_kronecker_form]                    -- 準備 1 の `Z_{m+1}` の鎖
    _ = Complex.I • siteProd M (fun i =>
          if (i : ℕ) < (m : ℕ) then pauliX * pauliX
          else if i = m then pauliY * pauliX
          else if i = nextSite m then 1 * pauliZ else 1 * 1) := by
      rw [← siteProd_mul]                               -- `kronecker_product_rule` (1)（`M → M_col`）
      congr 2
      funext i
      simp only [Pi.mul_apply]
      rcases lt_trichotomy (i : ℕ) (m : ℕ) with h | h | h
      · rw [jwFamily_of_lt h, jwFamily_of_lt (by omega), if_pos h]
      · have he : i = m := Fin.val_injective h
        rw [he, jwFamily_self, jwFamily_of_lt (by omega), if_neg (lt_irrefl _), if_pos rfl]
      · have hne' : i ≠ m := fun he => absurd (congrArg Fin.val he) (by omega)
        rw [jwFamily_of_gt h, if_neg (by omega), if_neg hne']
        rcases lt_trichotomy (i : ℕ) ((nextSite m : Fin M) : ℕ) with h' | h' | h'
        · omega
        · have he : i = nextSite m := Fin.val_injective h'
          rw [he, jwFamily_self, if_pos rfl]
        · have hne'' : i ≠ nextSite m := fun he => absurd (congrArg Fin.val he) (by omega)
          rw [jwFamily_of_gt h', if_neg hne'']
    _ = Complex.I • siteProd M (fun i =>
          if (i : ℕ) < (m : ℕ) then 1
          else if i = m then pauliY * pauliX
          else if i = nextSite m then 1 * pauliZ else 1 * 1) := by
      rw [pauliX_mul_pauliX]                            -- `pauli_matrix_products` の `σ^xσ^x = I`（第 1 から第 `m-1` 因子へ同時に適用）
    _ = Complex.I • siteProd M (fun i =>
          if i = m then pauliY * pauliX
          else if i = nextSite m then pauliZ else 1) := by
      rw [identity_matrix_mul pauliZ, identity_matrix_mul (1 : Matrix (Fin 2) (Fin 2) ℂ)]
                                                        -- `identity_matrix_is_left_unit_of_mat_mult` を `IA` の形の因子（第 `m+1` 因子と第 `m+2` 以降の因子）へ同時適用
      congr 2                                           -- 族の `if` を畳むだけ（因子の並び `I⊠⋯⊠I⊠(σ^yσ^x)⊠σ^z⊠I⊠⋯⊠I` は変わらない）
      funext i
      by_cases ha : i = m
      · rw [ha, if_neg (lt_irrefl _), if_pos rfl]
      · rw [if_neg ha]
        by_cases hlt' : (i : ℕ) < (m : ℕ)
        · have hb : i ≠ nextSite m := fun he => absurd (congrArg Fin.val he) (by omega)
          rw [if_pos hlt', if_neg hb]
        · rw [if_neg hlt']
    _ = Complex.I • siteProd M (fun i =>
          if i = m then (-Complex.I) • pauliZ
          else if i = nextSite m then pauliZ else 1) := by
      rw [pauliY_mul_pauliX_eq]                         -- `pauli_y_times_pauli_x`
    _ = Complex.I • ((-Complex.I) • siteProd M (fun i =>
          if i = m then pauliZ
          else if i = nextSite m then pauliZ else 1)) := by
      rw [siteProd_ite_smul]                            -- `kronecker_multilinear` の `r = 1` の式（`j → m`）
    _ = (Complex.I * (-Complex.I)) • siteProd M (fun i =>
          if i = m then pauliZ
          else if i = nextSite m then pauliZ else 1) :=
      smul_smul _ _ _                                   -- `scalar_multiple_is_associative`（Lean の具体版は無く、mathlib の `smul_smul` を 1 回）
    _ = (1 : ℂ) • siteProd M (fun i =>
          if i = m then pauliZ
          else if i = nextSite m then pauliZ else 1) := by
      rw [I_mul_neg_I]                                  -- ℂ で `i·(-i) = 1_ℂ`（`definition_of_cc` の積）
    _ = siteProd M (fun i =>
          if i = m then pauliZ
          else if i = nextSite m then pauliZ else 1) :=
      one_smul_tensorPow _                              -- `scalar_multiple_by_one`
    _ = sigmaZ m * sigmaZ (nextSite m) :=
      (sigmaZ_mul_sigmaZ_nextSite_kronecker m hm).symm  -- 準備 1 の `σ_m^zσ_{m+1}^z` の鎖を右辺から左辺へ

/-! ## 準備 4（境界の辺）

人手の準備 4 の 17 行の鎖 `-(i(Y_{M_col}Z_1)) = ⋯ = εG`（`M_col ≥ 2`）。添字の読み替えは準備 2 と同じで、
族は `i = firstSite M _`（人手の第 `1` 因子）・`i = lastSite M _`（第 `M_col` 因子）・それ以外（第 `2` から第 `M_col-1` 因子）の 3 つの場合の `if` で書く。 -/

/-- 人手 `kronecker_multilinear` の `r = 1` の式（`j → m`）を、族の外側の `if` が別のサイト `m'` を取り、
第 `m` 因子が内側の `if` にある族について述べたもの（`m ≠ m'`）。`siteProd_ite_smul` と同じく、
具体版 `siteProd_update_smul`（`ClaimKroneckerMultilinear.lean`）を 1 回使う。族を `Function.update` で書き直す段は、
因子の並びの書き方を揃えるだけである。仮定 `m ≠ m'` は、第 `m` 因子を取り出すときに外側の `if`（`i = m'`）が成り立たないことを言うのに使う。 -/
theorem siteProd_ite_ite_smul (m' m : Fin M) (hne : m ≠ m') (c : ℂ) (B A : Matrix (Fin 2) (Fin 2) ℂ)
    (G : Fin M → Matrix (Fin 2) (Fin 2) ℂ) :
    siteProd M (fun i => if i = m' then B else if i = m then c • A else G i)
      = c • siteProd M (fun i => if i = m' then B else if i = m then A else G i) := by
  have hc : (fun i => if i = m' then B else if i = m then c • A else G i)
      = Function.update (fun i => if i = m' then B else if i = m then A else G i) m (c • A) := by
    funext i
    rw [Function.update_apply]
    by_cases h : i = m
    · rw [if_pos h, h, if_neg hne, if_pos rfl]
    · simp only [h, ↓reduceIte]
  have h1 : (fun i => if i = m' then B else if i = m then A else G i)
      = Function.update (fun i => if i = m' then B else if i = m then A else G i) m A := by
    funext i
    rw [Function.update_apply]
    by_cases h : i = m
    · rw [if_pos h, h, if_neg hne, if_pos rfl]
    · simp only [h, ↓reduceIte]
  rw [hc]
  conv_rhs => rw [h1]
  exact siteProd_update_smul _ m c A

/-- **人手の準備 4**: `-(i(Y_{M_col}Z_1)) = εG`（`M_col ≥ 2`）。人手の 17 行と `calc` の 17 段が 1 対 1 に対応する。 -/
theorem neg_I_smul_Y_lastSite_mul_Z_firstSite (hM : 2 ≤ M) :
    -(Complex.I • (Y (lastSite M (by omega)) * Z (firstSite M (by omega))))
      = epsilon M * boundaryG M (by omega) := by
  have hM0 : M ≠ 0 := by omega
  have hne := firstSite_ne_lastSite hM
  have hlast : ((lastSite M hM0 : Fin M) : ℕ) = M - 1 := by simp [lastSite]
  have hfirst : ((firstSite M hM0 : Fin M) : ℕ) = 0 := by simp [firstSite]
  calc
    -(Complex.I • (Y (lastSite M hM0) * Z (firstSite M hM0)))
        = (-1 : ℂ) • (Complex.I • (Y (lastSite M hM0) * Z (firstSite M hM0))) :=
      neg_eq_neg_one_smul_tensorPow _                   -- `negation_is_scalar_multiple_by_minus_one`
    _ = ((-1 : ℂ) * Complex.I) • (Y (lastSite M hM0) * Z (firstSite M hM0)) :=
      smul_smul _ _ _                                   -- `scalar_multiple_is_associative`（Lean の具体版は無く、mathlib の `smul_smul` を 1 回）
    _ = (-Complex.I) • (Y (lastSite M hM0) * Z (firstSite M hM0)) := by
      rw [neg_one_mul]                                  -- `multiply_by_minus_one`（Lean の具体版は無く、mathlib の `neg_one_mul` を 1 回）
    _ = (-Complex.I) • (siteProd M (jwFamily (lastSite M hM0) pauliY) * Z (firstSite M hM0)) := by
      rw [Y_lastSite_kronecker_form]                    -- 準備 2 の `Y_{M_col}` の鎖
    _ = (-Complex.I) • (siteProd M (jwFamily (lastSite M hM0) pauliY)
          * siteProd M (Function.update 1 (firstSite M hM0) pauliZ)) := by
      rw [Z_firstSite_kronecker_form]                   -- 準備 2 の `Z_1` の鎖
    _ = (-Complex.I) • siteProd M (fun i =>
          if i = firstSite M hM0 then pauliX * pauliZ
          else if i = lastSite M hM0 then pauliY * 1 else pauliX * 1) := by
      rw [← siteProd_mul]                               -- `kronecker_product_rule` (1)（`M → M_col`。`M ≥ 2` より第 `1` 因子と第 `M_col` 因子は異なる）
      congr 2
      funext i
      simp only [Pi.mul_apply]
      by_cases ha : i = firstSite M hM0
      · rw [ha, Function.update_self, if_pos rfl, jwFamily_of_lt (by omega)]
      · rw [Function.update_of_ne ha, if_neg ha]
        by_cases hb : i = lastSite M hM0
        · rw [hb, jwFamily_self, if_pos rfl]; rfl
        · have hv : (i : ℕ) < M - 1 := by
            have := i.isLt
            have : (i : ℕ) ≠ M - 1 := fun h => hb (Fin.val_injective (by rw [h, hlast]))
            omega
          rw [jwFamily_of_lt (by omega), if_neg hb]; rfl
    _ = (-Complex.I) • siteProd M (fun i =>
          if i = firstSite M hM0 then pauliX * pauliZ
          else if i = lastSite M hM0 then pauliY else pauliX) := by
      rw [mul_identity_matrix pauliY, mul_identity_matrix pauliX]
                                                        -- `identity_matrix_is_right_unit_of_mat_mult` を `AI` の形の因子（第 `2` から第 `M_col` 因子）へ同時適用
    _ = (-Complex.I) • siteProd M (fun i =>
          if i = firstSite M hM0 then (-Complex.I) • pauliY
          else if i = lastSite M hM0 then pauliY else pauliX) := by
      rw [pauliX_mul_pauliZ_eq]                         -- `pauli_x_times_pauli_z`
    _ = (-Complex.I) • ((-Complex.I) • siteProd M (fun i =>
          if i = firstSite M hM0 then pauliY
          else if i = lastSite M hM0 then pauliY else pauliX)) := by
      rw [siteProd_ite_smul]                            -- `kronecker_multilinear` の `r = 1` の式（`j → 1`）
    _ = (-Complex.I) • siteProd M (fun i =>
          if i = firstSite M hM0 then pauliY
          else if i = lastSite M hM0 then (-Complex.I) • pauliY else pauliX) := by
      rw [siteProd_ite_ite_smul _ _ hne.symm]           -- `kronecker_multilinear` の `r = 1` の式（`j → M_col`）を右辺から左辺へ
    _ = siteProd M (fun i =>
          if i = firstSite M hM0 then (-Complex.I) • pauliY
          else if i = lastSite M hM0 then (-Complex.I) • pauliY else pauliX) := by
      rw [siteProd_ite_smul]                            -- `kronecker_multilinear` の `r = 1` の式（`j → 1`）を右辺から左辺へ
    _ = siteProd M (fun i =>
          if i = firstSite M hM0 then pauliX * pauliZ
          else if i = lastSite M hM0 then pauliX * pauliZ else pauliX) := by
      rw [pauliX_mul_pauliZ_eq]                         -- `pauli_x_times_pauli_z` を 2 箇所へ右辺から左辺へ同時適用
    _ = siteProd M (fun i =>
          if i = firstSite M hM0 then pauliX * pauliZ
          else if i = lastSite M hM0 then pauliX * pauliZ else pauliX * 1) := by
      rw [mul_identity_matrix pauliX]                   -- `identity_matrix_is_right_unit_of_mat_mult` を右辺から左辺へ同時適用（第 `2` から第 `M_col-1` 因子）
    _ = siteProd M (fun _ => pauliX) * siteProd M (fun i =>
          if i = firstSite M hM0 then pauliZ
          else if i = lastSite M hM0 then pauliZ else 1) := by
      rw [← siteProd_mul]                               -- `kronecker_product_rule` (1) を右辺から左辺へ
      congr 1
      funext i
      simp only [Pi.mul_apply]
      by_cases ha : i = firstSite M hM0
      · rw [if_pos ha, if_pos ha]
      · rw [if_neg ha, if_neg ha]
        by_cases hb : i = lastSite M hM0
        · rw [if_pos hb, if_pos hb]
        · rw [if_neg hb, if_neg hb]
    _ = epsilon M * siteProd M (fun i =>
          if i = firstSite M hM0 then pauliZ
          else if i = lastSite M hM0 then pauliZ else 1) := by
      rw [epsilon_kronecker_form]                       -- 準備 2 の `ε` の式を右辺から左辺へ
    _ = epsilon M * (sigmaZ (lastSite M hM0) * sigmaZ (firstSite M hM0)) := by
      rw [sigmaZ_lastSite_mul_sigmaZ_firstSite_kronecker hM]
                                                        -- 準備 2 の `σ_{M_col}^zσ_1^z` の鎖を右辺から左辺へ
    _ = epsilon M * boundaryG M hM0 := rfl              -- `def_G_boundary_operator`

/-! ## 境界の因子の族（`ClaimIHPauliForm.lean` が使う） -/

/-- `σ^y_1σ^x_2⋯σ^x_{M_col-1}σ^y_{M_col}` のサイトごとの因子（サイト `1` と `M_col` に `σ^y`、ほかに `σ^x`）。
このファイルの鎖は使わない。`ClaimIHPauliForm.lean` の `G` の表示が使う。 -/
noncomputable def boundaryYXYFamily (M : ℕ) (hM : M ≠ 0) : Fin M → Matrix (Fin 2) (Fin 2) ℂ :=
  fun i => if i = firstSite M hM ∨ i = lastSite M hM then pauliY else pauliX

/-! ## `H_1^{(+)}` の書き換え -/

private theorem filter_last_eq_singleton (hM : M ≠ 0) :
    Finset.univ.filter (fun m : Fin M => ¬ ((m : ℕ) + 1 ≠ M)) = {lastSite M hM} := by
  ext m
  simp only [Finset.mem_filter, Finset.mem_univ, true_and, not_not, Finset.mem_singleton]
  constructor
  · intro h
    exact Fin.val_injective (by simp [lastSite]; omega)
  · rintro rfl
    simp [lastSite]
    omega

/-- **人手 `def_H1_plus` の形** `H_1^{(+)} = ∑_{m=1}^{M_col-1}Y_mZ_{m+1} - Y_{M_col}Z_1`。

Lean の `H1plus` は全サイトの和に境界項の係数 `lastSign (-1)` を掛けた形なので、和を
`(m : ℕ) + 1 ≠ M` の範囲と、残る 1 項（人手のサイト `M_col`）とに分ける。 -/
theorem H1plus_eq_bulk_sub_boundary (hM : M ≠ 0) :
    H1plus M
      = ∑ m ∈ Finset.univ.filter (fun m : Fin M => (m : ℕ) + 1 ≠ M), Y m * Z (nextSite m)
        - Y (lastSite M hM) * Z (firstSite M hM) := by
  rw [H1plus, ← Finset.sum_filter_add_sum_filter_not Finset.univ (fun m : Fin M => (m : ℕ) + 1 ≠ M),
    filter_last_eq_singleton hM, Finset.sum_singleton, sub_eq_add_neg]
  congr 1
  · exact Finset.sum_congr rfl fun m hm => by
      rw [lastSign_of_not_last (Finset.mem_filter.1 hm).2, one_smul]
  · rw [lastSign_of_last (by simp [lastSite]; omega), nextSite_lastSite hM, neg_one_smul]

/-- 人手の和 `Σ_{m=1}^{M_col-1}` の添字の読み替え（`M_col = r + 2`）。Lean の `H1plus_eq_bulk_sub_boundary`・`openChainD0` は
人手の `m ∈ {1, …, M_col-1}` を `Fin (r + 2)` のうち `(m : ℕ) + 1 ≠ r + 2` を満たすものとして書き、
`finite_sum_of_scalar_multiples` の Lean の系 `finite_sum_smul_tensorPow` は項の個数 `r + 1` の和を `Fin (r + 1)` の上に取るので、
`Fin.castSucc` で両者をつなぐ（人手の添字 `m` は Lean の `Fin.castSucc j`、`j` は `m - 1`）。 -/
theorem sum_filter_not_last_eq_sum_castSucc {α : Type*} [AddCommMonoid α] (r : ℕ) (f : Fin (r + 2) → α) :
    ∑ m ∈ Finset.univ.filter (fun m : Fin (r + 2) => (m : ℕ) + 1 ≠ r + 2), f m
      = ∑ j : Fin (r + 1), f (Fin.castSucc j) := by
  rw [Finset.sum_filter, Fin.sum_univ_castSucc, Fin.val_last, if_neg (by omega), add_zero]
  exact Finset.sum_congr rfl fun j _ => if_pos (by simp only [Fin.val_castSucc]; omega)

/-- 人手のサイト `m ∈ {1, …, M_col-1}`（Lean の `Fin.castSucc j`）は最後のサイトではない。 -/
theorem castSucc_val_add_one_ne (r : ℕ) (j : Fin (r + 1)) :
    ((Fin.castSucc j : Fin (r + 2)) : ℕ) + 1 ≠ r + 2 := by
  simp only [Fin.val_castSucc]; omega

/-- **人手 `H1_plus_in_sigma_z_form`**: `iH_1^{(+)} = D_0 + εG`（`M_col ≥ 2`）。

人手の最後の 7 行の鎖と `calc` の 7 段が 1 対 1 に対応する。Lean では `M_col = r + 2` と置き、人手の和 `Σ_{m=1}^{M_col-1}` を
`Fin (r + 1)` の上の和（人手の `m` は `Fin.castSucc j`）で書く。1 段目（`def_H1_plus`）と 5 段目（`def_D0_open_chain_operator`）は、
Lean の `H1plus`・`openChainD0` の和の書き方（`Finset.filter`）をこの和へ読み替える段を含む（`sum_filter_not_last_eq_sum_castSucc`）。 -/
theorem H1_plus_in_sigma_z_form (hM : 2 ≤ M) :
    Complex.I • H1plus M = openChainD0 M + epsilon M * boundaryG M (by omega) := by
  obtain ⟨r, rfl⟩ : ∃ r, M = r + 2 := ⟨M - 2, by omega⟩
  have hM0 : r + 2 ≠ 0 := by omega
  calc Complex.I • H1plus (r + 2)
      = Complex.I • ((∑ j : Fin (r + 1), Y (Fin.castSucc j) * Z (nextSite (Fin.castSucc j)))
          - Y (lastSite (r + 2) hM0) * Z (firstSite (r + 2) hM0)) := by
        rw [H1plus_eq_bulk_sub_boundary hM0,
          sum_filter_not_last_eq_sum_castSucc r (fun m => Y m * Z (nextSite m))]
                                                        -- `def_H1_plus`（和の添字を `Fin (r + 1)` へ読み替える）
    _ = Complex.I • (∑ j : Fin (r + 1), Y (Fin.castSucc j) * Z (nextSite (Fin.castSucc j)))
          - Complex.I • (Y (lastSite (r + 2) hM0) * Z (firstSite (r + 2) hM0)) :=
        smul_sub_tensorPow _ _ _                        -- `scalar_multiple_distributes_over_matrix_difference`
    _ = (∑ j : Fin (r + 1), Complex.I • (Y (Fin.castSucc j) * Z (nextSite (Fin.castSucc j))))
          - Complex.I • (Y (lastSite (r + 2) hM0) * Z (firstSite (r + 2) hM0)) := by
        rw [finite_sum_smul_tensorPow Complex.I r]      -- `finite_sum_of_scalar_multiples` を右辺から左辺へ
    _ = (∑ j : Fin (r + 1), sigmaZ (Fin.castSucc j) * sigmaZ (nextSite (Fin.castSucc j)))
          - Complex.I • (Y (lastSite (r + 2) hM0) * Z (firstSite (r + 2) hM0)) := by
        rw [Finset.sum_congr rfl fun j _ =>
          I_smul_Y_mul_Z_next_of_not_last (Fin.castSucc j) (castSucc_val_add_one_ne r j)]
                                                        -- 準備 3 を各項へ同時適用
    _ = openChainD0 (r + 2)
          - Complex.I • (Y (lastSite (r + 2) hM0) * Z (firstSite (r + 2) hM0)) := by
        rw [openChainD0, sum_filter_not_last_eq_sum_castSucc r (fun m => sigmaZ m * sigmaZ (nextSite m))]
                                                        -- `def_D0_open_chain_operator`（和の添字を `Fin (r + 1)` へ読み替える）
    _ = openChainD0 (r + 2)
          + -(Complex.I • (Y (lastSite (r + 2) hM0) * Z (firstSite (r + 2) hM0))) :=
        sub_eq_add_neg_tensorPow _ _                    -- `matrix_difference_is_sum_with_negation`
    _ = openChainD0 (r + 2) + epsilon (r + 2) * boundaryG (r + 2) hM0 := by
        rw [neg_I_smul_Y_lastSite_mul_Z_firstSite hM]   -- 準備 4

end Ising2D
