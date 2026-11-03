/-
# `S_1^{(+)} = iK_1H_1^{(+)}`・`S_2 = iK_2^*H_2` の Pauli 行列による表示（具体版）

正本: `structured-latex/content/eigenvalue_problem_eigenvalues_of_V_plus.ts`
（`eigenvalues_of_V_014_claim_iH_is_real_symmetric`、ラベル **`iH_is_real_symmetric`**）

人手 `iH_is_real_symmetric` の Step 0 の 2×2 の積と、Step 1 と Step 2 の鎖（`S_2 = K_2^*Σσ^x_m`・`S_1^{(+)} = K_1Σσ^z_mσ^z_{m+1} - K_1G`）と 1 対 1 に対応する。
Step 3 の転置の 3 本の鎖（`(σ^x_m)^⊤ = σ^x_m`・`(σ^z_mσ^z_{m+1})^⊤ = σ^z_mσ^z_{m+1}`・`G^⊤ = G`）と、Step 3 の成分の実性の `σ^x_m`・`σ^z_mσ^z_{m+1}`・`G` の段落（`sigmaX_hasRealEntries`・`sigmaZ_castSucc_mul_sigmaZ_succ_hasRealEntries`・`boundaryYXY_eq_neg_one_smul_real`・`boundaryYXY_hasRealEntries`）もこのファイルが持つ。
Step 3 の `S_2`・`S_1^{(+)}` の転置の鎖（`S2_transpose_by_pauli_form`・`S1plus_transpose_by_pauli_form`）もこのファイルが持つ。
Step 3 の結論（`S_1^{(+)}`・`S_2` の成分が実で転置について対称）は、いまはこれらの鎖を経ない別の論法で `S1plus_isHermitian`・`S1plus_transpose`・`S2_isHermitian`・`S2_transpose`
（`MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/ClaimPositiveDefinite.lean`）が持っている。

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| Step 0 の準備 `(-i)·i = 1`・`(-i)·(-i) = -1` | `negI_mul_I_eq_one`・`negI_mul_negI_eq_neg_one`（`EigenvectorOfMaxEigenvalue/ClaimH1PlusInSigmaZForm.lean`） |
| Step 0 の `σ^zσ^y = (-i)σ^x`（11 行。`V1_in_Z_Y_epsilon` の Step 0 の第 3 の鎖と同じ鎖） | `pauliZ_mul_pauliY`（`PartitionFunction/ProjectionAndJordanWigner/DefinitionTransferMatrixSymbols.lean`） |
| Step 0 の `σ^yσ^x = (-i)σ^z`（12 行。`V1_in_Z_Y_epsilon` の Step 0 の第 1 の鎖と同じ鎖） | `pauliY_mul_pauliX_eq`（`PartitionFunction/ProjectionAndJordanWigner/ClaimV1InZYEpsilon.lean`） |
| Step 0 の `σ^xσ^z = (-i)σ^y`（11 行） | `pauliX_mul_pauliZ_eq`（`EigenvectorOfMaxEigenvalue/ClaimH1PlusInSigmaZForm.lean`） |
| Step 1 の準備（`Z_m`・`Y_m` のクロネッカー積表示）と `Z_mY_m = (-i)σ^x_m` の 8 行（準備の `Z_m`・`Y_m` の表示 → `kronecker_product_rule` (1) → `σ^xσ^x = I` → `identity_matrix_is_left_unit_of_mat_mult` → Step 0 の `σ^zσ^y = (-i)σ^x` → `kronecker_multilinear` → `def_site_pauli_matrices`） | `Z_mul_Y_same` の `calc` の 8 段（`PartitionFunction/ProjectionAndJordanWigner/DefinitionTransferMatrixSymbols.lean`。準備の表示は Lean では `Z`・`Y` の定義そのもので `rfl`） |
| Step 1 の `H_2` の鎖の 3 行（`def_H2` → 上で得た `Z_mY_m` → `finite_sum_of_scalar_multiples`） | `H2_eq_neg_I_smul_sum_sigmaX` の `calc` の 3 段 |
| Step 1 の `S_2` の鎖の 8 行（`S_2` の定義 → `H_2` の表示 → `scalar_multiple_is_associative` → ℂ の積の結合律 → 交換律 → 結合律 → `i(-i) = 1` → 乗法の単位元） | `S2_eq_K2star_smul_sum_sigmaX` の `calc` の 7 段（先頭の「`S_2` の定義」の行は Lean では主張の左辺そのもの） |
| Step 2 の準備（`Y_m`・`Z_{m+1}` のクロネッカー積表示と、`σ^z_mσ^z_{m+1}` の 6 行（`def_site_pauli_matrices` 2 回 → `kronecker_product_rule` (1) → `identity_matrix_is_right_unit_of_mat_mult` → `identity_matrix_is_left_unit_of_mat_mult` 2 回）） | `Y`・`Z` の定義（`rfl`）と `sigmaZ_castSucc_mul_sigmaZ_succ_kronecker` の `calc` の 6 段 |
| Step 2 の `Y_mZ_{m+1} = (-i)σ^z_mσ^z_{m+1}` の 9 行（`1 ≤ m ≤ M_col-1`。準備の `Y_m`・`Z_{m+1}` の表示 → `kronecker_product_rule` (1) → `σ^xσ^x = I` → `identity_matrix_is_left_unit_of_mat_mult`（`A → σ^z`・`A → I`） → Step 0 の `σ^yσ^x = (-i)σ^z` → `kronecker_multilinear` → 準備の `σ^z_mσ^z_{m+1}` の表示） | `Y_castSucc_mul_Z_succ` の `calc` の 9 段（人手の差の形の添字 `Fin.castSucc m`・`Fin.succ m` で） |
| Step 2 の境界項の準備（`Y_{M_col}`・`Z_1`・`G`（`G = σ^y_1σ^x_2⋯σ^x_{M_col-1}σ^y_{M_col}`）のクロネッカー積表示）と `Y_{M_col}Z_1 = (-i)G` の 8 行（準備の `Y_{M_col}`・`Z_1` の表示 → `kronecker_product_rule` (1) → `identity_matrix_is_right_unit_of_mat_mult`（`A → σ^x`・`A → σ^y`） → Step 0 の `σ^xσ^z = (-i)σ^y` → `kronecker_multilinear` → 準備の `G` の表示） | `Y_last_mul_Z_zero` の `calc` の 8 段（人手の差の形の添字 `Fin.last (r + 1)`・`0` で。準備の `Y`・`Z` の表示は定義そのもので `rfl`、`G` の表示は `boundaryYXYFamily` との書き方の違いを揃える段） |
| Step 3 の `(σ^x_m)^⊤ = σ^x_m` の 5 行（`def_site_pauli_matrices` → `kronecker_transpose` → `transpose_of_identity_matrix_of_order_two` → `transpose_of_pauli_x` → `def_site_pauli_matrices`） | `sigmaX_transpose` の `calc` の 5 段（`kronecker_transpose` は `siteProd_transpose`、`MathematicalTools/KroneckerProductAndMultiFactorBasis/ClaimKroneckerTranspose.lean`） |
| Step 3 の `(σ^z_mσ^z_{m+1})^⊤ = σ^z_mσ^z_{m+1}` の 5 行（Step 2 の準備の表示 → `kronecker_transpose` → `transpose_of_identity_matrix_of_order_two` → `transpose_of_pauli_z` → 準備の表示） | `sigmaZ_castSucc_mul_sigmaZ_succ_transpose` の `calc` の 5 段 |
| Step 3 の `G^⊤ = G` の 11 行（Step 2 の準備の `G` の表示 → `kronecker_transpose` → `transpose_of_pauli_x` → `transpose_of_pauli_y` → `negation_is_scalar_multiple_by_minus_one` → `kronecker_multilinear` 2 回 → `scalar_multiple_is_associative` → `(-1)(-1) = 1` → `scalar_multiple_by_one` → 準備の表示） | `boundaryYXY_transpose` の `calc` の 11 段（準備の `G` の表示の `ite` の形は `boundaryYXYFamily_eq_ite`） |
| Step 3 の `σ^x_m` の成分の実性（`def_site_pauli_matrices` の表示 → `identity_matrix_of_order_two_has_real_entries`・`pauli_x_has_real_entries` → `kronecker_of_real_entry_matrices_has_real_entries`） | `sigmaX_hasRealEntries`（`M = n + 1`） |
| Step 3 の `σ^z_mσ^z_{m+1}` の成分の実性（Step 2 の準備の表示 → `identity_matrix_of_order_two_has_real_entries`・`pauli_z_has_real_entries` → `kronecker_of_real_entry_matrices_has_real_entries`） | `sigmaZ_castSucc_mul_sigmaZ_succ_hasRealEntries` |
| Step 3 の `G = (-1)_ℂ(R^y⊠σ^x⊠⋯⊠σ^x⊠R^y)` の 7 行（Step 2 の準備の `G` の表示 → `pauli_y_is_i_times_real_factor` → `kronecker_multilinear` 2 回 → `scalar_multiple_is_associative` → ℂ で `i·i = -1` → `inclusion_rr_to_cc` の略記） | `boundaryYXY_eq_neg_one_smul_real` の `calc` の 7 段 |
| Step 3 の `G` の成分の実性（`real_factor_of_pauli_y_has_real_entries`・`pauli_x_has_real_entries` → `kronecker_of_real_entry_matrices_has_real_entries` → `real_scalar_multiple_of_real_entry_matrix_has_real_entries` と上の鎖） | `boundaryYXY_hasRealEntries` |
| Step 2 の `S_1^{(+)}` の鎖の 13 行 | `S1plus_eq_K1_smul_sub` の `calc` の 12 段（先頭の「`S_1^{(+)}` の定義」の行は Lean では主張の左辺そのもの） |
| Step 3 の `(S_2)^⊤ = S_2` の 5 行（Step 1 の `S_2` の表示 → `transpose_of_matrix_scalar_multiple` → `transpose_of_finite_sum_of_matrices` → `(σ^x_m)^⊤ = σ^x_m` を各項へ → Step 1 の表示） | `S2_transpose_by_pauli_form` の `calc` の 5 段 |
| Step 3 の `(S_1^{(+)})^⊤ = S_1^{(+)}` の 7 行（Step 2 の `S_1^{(+)}` の表示 → `transpose_of_matrix_difference` → `transpose_of_matrix_scalar_multiple` を 2 箇所 → `transpose_of_finite_sum_of_matrices` → `(σ^z_mσ^z_{m+1})^⊤` を各項へ → `G^⊤ = G` → Step 2 の表示） | `S1plus_transpose_by_pauli_form` の `calc` の 7 段 |

- 人手の `K_1, K_2^* ∈ ℝ` は、Lean では `ℂ` の元 `K1`・`K2star` として受け取る（`ClaimPositiveDefinite.lean` の `S1plus_isHermitian` ほかと同じ）。
  鎖は係数の実性を使わないので、仮定 `star K1 = K1` は置かない。
- 人手は `M_col ≥ 2` で述べる。`H_2`・`S_2` の鎖は `M = r + 1`、`S_1^{(+)}` の鎖は `M = r + 2` の場合を述べる
  （Lean の添字は 0 始まりなので、人手の `m` は `Fin.castSucc m`、`m + 1` は `Fin.succ m`、`M_col` は `Fin.last (r + 1)`、`1` は `0`）。
  人手の `H_1^{(+)}` の差の形は `H1plus_eq_sub`（`def_H1_plus`）で読み替える。
- 人手の `G` は、サイトごとの因子の族 `boundaryYXYFamily` をクロネッカー積 `siteProd` に入れたものとして書く
  （`EigenvectorOfMaxEigenvalue/ClaimH1PlusInSigmaZForm.lean`）。同じ文字の `boundaryG`（`σ^z_{M_col}σ^z_1`）とは別のものである。
- `scalar_multiple_is_associative` の Lean の具体版は無く、mathlib の `smul_smul` を使う（状態台帳に記録がある）。
  ℂ の積の結合律・交換律・単位元（`complex_numbers_form_a_field`）は `mul_assoc`・`mul_comm`・`one_mul`、`i·(-i) = 1_ℂ` は `I_mul_neg_I`
  （`PartitionFunction/ProjectionAndJordanWigner/DefinitionTransferMatrixSymbols.lean`）。

具体的な複素行列の等式であり、主張に固有なのは各段で引いた主張（それぞれ必要十分版を持つ）だけなので、必要十分版は置かない。
-/
import Ising2D.EigenvalueProblem.EigenvectorOfMaxEigenvalue.ClaimH1PlusInSigmaZForm
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimScalarMultipleDistributesOverMatrixSumFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimScalarMultipleDistributesOverMatrixDifferenceFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimNegationIsScalarMultipleByMinusOne
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimKroneckerTranspose
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimTransposeOfMatrixSumsAndScalarMultiplesFromNecSuf
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimKroneckerOfRealEntryMatricesHasRealEntries
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealScalarMultipleOfRealEntryMatrixHasRealEntries
import Ising2D.PartitionFunction.ProjectionAndJordanWigner.ClaimPauliMatricesHaveRealEntries
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimScalarMultipleByOneFromNecSuf

namespace Ising2D

open Matrix

/-- **人手 `iH_is_real_symmetric` Step 1 の `H_2` の鎖**: `H_2 = -iΣ_{m=1}^{M_col} σ^x_m`（`M = r + 1`）。 -/
theorem H2_eq_neg_I_smul_sum_sigmaX (r : ℕ) :
    H2 (r + 1) = (-Complex.I) • ∑ m : Fin (r + 1), sigmaX m :=
  calc H2 (r + 1)
      = ∑ m : Fin (r + 1), Z m * Y m := rfl                                  -- `def_H2`
    _ = ∑ m : Fin (r + 1), (-Complex.I) • sigmaX m :=
        Finset.sum_congr rfl fun m _ => Z_mul_Y_same m                       -- 上で得た `Z_mY_m = -iσ^x_m`
    _ = (-Complex.I) • ∑ m : Fin (r + 1), sigmaX m :=
        finite_sum_smul_tensorPow _ r _                                      -- `finite_sum_of_scalar_multiples`（`m, n → 2^{M_col}`, `r → M_col`, `c → -i`, `(X_1, …, X_r) → (σ^x_1, …, σ^x_{M_col})`）

/-- **人手 `iH_is_real_symmetric` Step 1 の `S_2` の鎖**: `S_2 = (iK_2^*)H_2 = K_2^*Σ_{m=1}^{M_col} σ^x_m`（`M = r + 1`）。 -/
theorem S2_eq_K2star_smul_sum_sigmaX (K2star : ℂ) (r : ℕ) :
    (Complex.I * K2star) • H2 (r + 1) = K2star • ∑ m : Fin (r + 1), sigmaX m :=
  calc (Complex.I * K2star) • H2 (r + 1)
      = (Complex.I * K2star) • ((-Complex.I) • ∑ m : Fin (r + 1), sigmaX m) := by
        rw [H2_eq_neg_I_smul_sum_sigmaX]                                     -- 上で得た `H_2` の表示
    _ = ((Complex.I * K2star) * (-Complex.I)) • ∑ m : Fin (r + 1), sigmaX m :=
        smul_smul _ _ _                                                      -- `scalar_multiple_is_associative`（`a → iK_2^*`, `b → -i`）
    _ = (Complex.I * (K2star * (-Complex.I))) • ∑ m : Fin (r + 1), sigmaX m := by
        rw [mul_assoc]                                                       -- ℂ の積の結合律
    _ = (Complex.I * ((-Complex.I) * K2star)) • ∑ m : Fin (r + 1), sigmaX m := by
        rw [mul_comm K2star (-Complex.I)]                                    -- ℂ の積の交換律
    _ = ((Complex.I * (-Complex.I)) * K2star) • ∑ m : Fin (r + 1), sigmaX m := by
        rw [← mul_assoc]                                                     -- ℂ の積の結合律
    _ = (1 * K2star) • ∑ m : Fin (r + 1), sigmaX m := by
        rw [I_mul_neg_I]                                                     -- `i·(-i) = 1_ℂ`
    _ = K2star • ∑ m : Fin (r + 1), sigmaX m := by
        rw [one_mul]                                                         -- ℂ の乗法の単位元

/-- **人手 `iH_is_real_symmetric` Step 2 の準備の `σ^z_mσ^z_{m+1}` のクロネッカー積表示**（6 行。`1 ≤ m ≤ M_col - 1`、`M = r + 2`）。
人手の `m` は Lean の `Fin.castSucc m`、`m + 1` は `Fin.succ m`。人手の「第 `m` 因子と第 `m+1` 因子以外の因子」は Lean の
`i ≠ Fin.castSucc m` かつ `i ≠ Fin.succ m` で、`calc` の終わりの因子の並び `I⊠⋯⊠I⊠σ^z⊠σ^z⊠I⊠⋯⊠I` は `Function.update` を 2 回重ねて書く。 -/
theorem sigmaZ_castSucc_mul_sigmaZ_succ_kronecker {r : ℕ} (m : Fin (r + 1)) :
    sigmaZ (Fin.castSucc m) * sigmaZ (Fin.succ m)
      = siteProd (r + 2) (Function.update (Function.update (1 : Fin (r + 2) → Matrix (Fin 2) (Fin 2) ℂ)
          (Fin.succ m) pauliZ) (Fin.castSucc m) pauliZ) := by
  have hab : (Fin.castSucc m : Fin (r + 2)) ≠ Fin.succ m := Fin.ne_of_val_ne (by simp)
  calc
    sigmaZ (Fin.castSucc m) * sigmaZ (Fin.succ m)
        = siteProd (r + 2) (Function.update 1 (Fin.castSucc m) pauliZ) * sigmaZ (Fin.succ m) := rfl
                                                        -- `def_site_pauli_matrices`（`k → m`, `a → z`）
    _ = siteProd (r + 2) (Function.update 1 (Fin.castSucc m) pauliZ)
          * siteProd (r + 2) (Function.update 1 (Fin.succ m) pauliZ) := rfl
                                                        -- `def_site_pauli_matrices`（`k → m+1`, `a → z`）
    _ = siteProd (r + 2) (fun i =>
          if i = Fin.castSucc m then pauliZ * 1
          else if i = Fin.succ m then 1 * pauliZ else 1 * 1) := by
      rw [← siteProd_mul]                               -- `kronecker_product_rule` (1)（`M → M_col`）
      congr 1
      funext i
      simp only [Pi.mul_apply]
      by_cases ha : i = Fin.castSucc m
      · rw [ha, Function.update_self, Function.update_of_ne hab, if_pos rfl]; rfl
      · by_cases hb : i = Fin.succ m
        · rw [hb, Function.update_self, Function.update_of_ne hab.symm, if_neg hab.symm, if_pos rfl]; rfl
        · rw [Function.update_of_ne ha, Function.update_of_ne hb, if_neg ha, if_neg hb]; rfl
    _ = siteProd (r + 2) (fun i =>
          if i = Fin.castSucc m then pauliZ
          else if i = Fin.succ m then 1 * pauliZ else 1 * 1) := by
      rw [mul_identity_matrix pauliZ]                   -- `identity_matrix_is_right_unit_of_mat_mult`（`m, n → 2`, `A → σ^z`。第 `m` 因子へ）
    _ = siteProd (r + 2) (fun i =>
          if i = Fin.castSucc m then pauliZ
          else if i = Fin.succ m then pauliZ else 1 * 1) := by
      rw [identity_matrix_mul pauliZ]                   -- `identity_matrix_is_left_unit_of_mat_mult`（`m, n → 2`, `A → σ^z`。第 `m+1` 因子へ）
    _ = siteProd (r + 2) (Function.update (Function.update (1 : Fin (r + 2) → Matrix (Fin 2) (Fin 2) ℂ)
          (Fin.succ m) pauliZ) (Fin.castSucc m) pauliZ) := by
      rw [identity_matrix_mul (1 : Matrix (Fin 2) (Fin 2) ℂ)]
                                                        -- `identity_matrix_is_left_unit_of_mat_mult`（`m, n → 2`, `A → I`。第 `m`・第 `m+1` 因子以外へ同時に適用）
      congr 1                                           -- 両辺は同じ因子の並び（`Function.update` は `ite` の書き方の違いだけ）
      funext i
      by_cases ha : i = Fin.castSucc m
      · rw [ha, Function.update_self, if_pos rfl]
      · rw [Function.update_of_ne ha, if_neg ha]
        by_cases hb : i = Fin.succ m
        · rw [hb, Function.update_self, if_pos rfl]
        · rw [Function.update_of_ne hb, if_neg hb]; rfl

/-- **人手 `iH_is_real_symmetric` Step 2 の `Y_mZ_{m+1} = (-i)σ^z_mσ^z_{m+1}` の 9 行の鎖**（`1 ≤ m ≤ M_col - 1`、`M = r + 2`）を、
`H1plus_eq_sub` の添字（`Fin.castSucc m`・`Fin.succ m`）で。

人手との対応: 人手の準備の `Y_m`・`Z_{m+1}` のクロネッカー積表示（`def_jordan_wigner_Y_matrices`・`def_jordan_wigner_Z_matrices` と
`site_pauli_prefix_product_kronecker_form`）は、Lean では `Y`・`Z` の定義そのもの（`siteProd` に `jwFamily` を入れたもの）なので、
`calc` の 1・2 段は `rfl` である（`Z_mul_Y_same` と同じ）。準備の `σ^z_mσ^z_{m+1}` の表示は `sigmaZ_castSucc_mul_sigmaZ_succ_kronecker`。
人手の「第 `1` から第 `m-1` 因子」「第 `m+2` 以降の因子」は Lean の `i < Fin.castSucc m`・それ以外（`i ≠ Fin.castSucc m`, `i ≠ Fin.succ m`）である。
`V1_in_Z_Y_epsilon` の Step 2 の鎖は別の 5 行の鎖で、Lean の `Y_mul_Z_next_of_not_last` が持つ。 -/
theorem Y_castSucc_mul_Z_succ {r : ℕ} (m : Fin (r + 1)) :
    Y (Fin.castSucc m) * Z (Fin.succ m)
      = (-Complex.I) • (sigmaZ (Fin.castSucc m) * sigmaZ (Fin.succ m)) := by
  have hab : (Fin.castSucc m : Fin (r + 2)) ≠ Fin.succ m := Fin.ne_of_val_ne (by simp)
  have hsucc : ((Fin.succ m : Fin (r + 2)) : ℕ) = ((Fin.castSucc m : Fin (r + 2)) : ℕ) + 1 := by simp
  calc
    Y (Fin.castSucc m) * Z (Fin.succ m)
        = siteProd (r + 2) (jwFamily (Fin.castSucc m) pauliY) * Z (Fin.succ m) := rfl
                                                        -- 準備の `Y_m` の表示
    _ = siteProd (r + 2) (jwFamily (Fin.castSucc m) pauliY)
          * siteProd (r + 2) (jwFamily (Fin.succ m) pauliZ) := rfl
                                                        -- 準備の `Z_{m+1}` の表示
    _ = siteProd (r + 2) (fun i =>
          if (i : ℕ) < (Fin.castSucc m : ℕ) then pauliX * pauliX
          else if i = Fin.castSucc m then pauliY * pauliX
          else if i = Fin.succ m then 1 * pauliZ else 1 * 1) := by
      rw [← siteProd_mul]                               -- `kronecker_product_rule` (1)（`M → M_col`）
      congr 1
      funext i
      simp only [Pi.mul_apply]
      rcases lt_trichotomy (i : ℕ) (Fin.castSucc m : ℕ) with h | h | h
      · rw [jwFamily_of_lt h, jwFamily_of_lt (by omega), if_pos h]
      · have he : i = Fin.castSucc m := Fin.val_injective h
        rw [he, jwFamily_self, jwFamily_of_lt (by omega), if_neg (lt_irrefl _), if_pos rfl]
      · have hne : i ≠ Fin.castSucc m := fun he => absurd (congrArg Fin.val he) (by omega)
        rw [jwFamily_of_gt h, if_neg (by omega), if_neg hne]
        rcases lt_trichotomy (i : ℕ) (Fin.succ m : ℕ) with h' | h' | h'
        · omega
        · have he : i = Fin.succ m := Fin.val_injective h'
          rw [he, jwFamily_self, if_pos rfl]
        · have hne' : i ≠ Fin.succ m := fun he => absurd (congrArg Fin.val he) (by omega)
          rw [jwFamily_of_gt h', if_neg hne']
    _ = siteProd (r + 2) (fun i =>
          if (i : ℕ) < (Fin.castSucc m : ℕ) then 1
          else if i = Fin.castSucc m then pauliY * pauliX
          else if i = Fin.succ m then 1 * pauliZ else 1 * 1) := by
      rw [pauliX_mul_pauliX]                            -- `pauli_matrix_products` の `σ^xσ^x = I`（第 1 から第 `m-1` 因子へ同時に適用）
    _ = siteProd (r + 2) (fun i =>
          if (i : ℕ) < (Fin.castSucc m : ℕ) then 1
          else if i = Fin.castSucc m then pauliY * pauliX
          else if i = Fin.succ m then pauliZ else 1 * 1) := by
      rw [identity_matrix_mul pauliZ]                   -- `identity_matrix_is_left_unit_of_mat_mult`（`m, n → 2`, `A → σ^z`。第 `m+1` 因子へ）
    _ = siteProd (r + 2) (Function.update (Function.update (1 : Fin (r + 2) → Matrix (Fin 2) (Fin 2) ℂ)
          (Fin.succ m) pauliZ) (Fin.castSucc m) (pauliY * pauliX)) := by
      rw [identity_matrix_mul (1 : Matrix (Fin 2) (Fin 2) ℂ)]
                                                        -- `identity_matrix_is_left_unit_of_mat_mult`（`m, n → 2`, `A → I`。第 `m+2` 以降の因子へ同時に適用）
      congr 1                                           -- 両辺は同じ因子の並び `I⊠⋯⊠I⊠(σ^yσ^x)⊠σ^z⊠I⊠⋯⊠I`（`Function.update` は `ite` の書き方の違いだけ）
      funext i
      by_cases ha : i = Fin.castSucc m
      · rw [ha, Function.update_self, if_neg (lt_irrefl _), if_pos rfl]
      · rw [Function.update_of_ne ha, if_neg ha]
        by_cases hb : i = Fin.succ m
        · rw [hb, Function.update_self, if_neg (by omega), if_pos rfl]
        · rw [Function.update_of_ne hb, if_neg hb]
          by_cases hlt : (i : ℕ) < (Fin.castSucc m : ℕ)
          · rw [if_pos hlt]; rfl
          · rw [if_neg hlt]; rfl
    _ = siteProd (r + 2) (Function.update (Function.update (1 : Fin (r + 2) → Matrix (Fin 2) (Fin 2) ℂ)
          (Fin.succ m) pauliZ) (Fin.castSucc m) ((-Complex.I) • pauliZ)) := by
      rw [pauliY_mul_pauliX_eq]                         -- Step 0 の `σ^yσ^x = (-i)σ^z`
    _ = (-Complex.I) • siteProd (r + 2) (Function.update (Function.update (1 : Fin (r + 2) → Matrix (Fin 2) (Fin 2) ℂ)
          (Fin.succ m) pauliZ) (Fin.castSucc m) pauliZ) :=
      (siteProd (r + 2)).map_update_smul _ (Fin.castSucc m) (-Complex.I) pauliZ
                                                        -- `kronecker_multilinear` の `r = 1` の場合（`j → m`, `c → -i`, `A_m → σ^z`, `A_{m+1} → σ^z`, `A_k → I`）。Lean の具体版は無く、`siteProd` の多重線型性 `MultilinearMap.map_update_smul` を 1 回
    _ = (-Complex.I) • (sigmaZ (Fin.castSucc m) * sigmaZ (Fin.succ m)) := by
      rw [sigmaZ_castSucc_mul_sigmaZ_succ_kronecker]    -- 準備の `σ^z_mσ^z_{m+1}` の表示

/-- **人手 `iH_is_real_symmetric` Step 2 の境界項 `Y_{M_col}Z_1 = (-i)G` の 8 行の鎖**（`M_col = r + 2 ≥ 2`）を、
`H1plus_eq_sub` の添字（`Fin.last (r + 1)`・`0`）で。

人手との対応: 人手の準備の `Y_{M_col}`・`Z_1` のクロネッカー積表示（`def_jordan_wigner_Y_matrices`・`def_jordan_wigner_Z_matrices` と
`site_pauli_prefix_product_kronecker_form`）は、Lean では `Y`・`Z` の定義そのもの（`siteProd` に `jwFamily` を入れたもの）なので、
`calc` の 1・2 段は `rfl` である。準備の `G` の表示（主張の `G := σ^y_1σ^x_2⋯σ^x_{M_col-1}σ^y_{M_col}` と
`site_pauli_prefix_product_kronecker_form`）は、Lean では `G` をはじめから `siteProd` に `boundaryYXYFamily` を入れたものとして
書くので、人手の準備の `G` の 2 行（サイトの積としての定義と、クロネッカー積表示へ移す行）に当たる Lean の段は無く、`calc` の 8 段は因子の並びの書き方（`ite` と `boundaryYXYFamily` の `∨`）を揃えるだけである。
人手の第 `1` 因子は Lean の `i = 0`、第 `M_col` 因子は `i = Fin.last (r + 1)`、第 `2` から第 `M_col-1` 因子はそれ以外である。
`H1_plus_in_sigma_z_form` が使う同じ等式 `Y_last_mul_Z_first`（`lastSite`・`firstSite` の添字）は、別の主張の鎖として残す。 -/
theorem Y_last_mul_Z_zero (r : ℕ) :
    Y (Fin.last (r + 1)) * Z (0 : Fin (r + 2))
      = (-Complex.I) • siteProd (r + 2) (boundaryYXYFamily (r + 2) (by omega)) := by
  have h0l : (0 : Fin (r + 2)) ≠ Fin.last (r + 1) := Fin.ne_of_val_ne (by simp)
  calc
    Y (Fin.last (r + 1)) * Z (0 : Fin (r + 2))
        = siteProd (r + 2) (jwFamily (Fin.last (r + 1)) pauliY) * Z (0 : Fin (r + 2)) := rfl
                                                        -- 準備の `Y_{M_col}` の表示
    _ = siteProd (r + 2) (jwFamily (Fin.last (r + 1)) pauliY)
          * siteProd (r + 2) (jwFamily (0 : Fin (r + 2)) pauliZ) := rfl
                                                        -- 準備の `Z_1` の表示
    _ = siteProd (r + 2) (fun i =>
          if i = 0 then pauliX * pauliZ
          else if i = Fin.last (r + 1) then pauliY * 1 else pauliX * 1) := by
      rw [← siteProd_mul]                               -- `kronecker_product_rule` (1)（`M → M_col`）
      congr 1
      funext i
      simp only [Pi.mul_apply]
      by_cases h0 : i = 0
      · rw [h0, jwFamily_of_lt (by simp), jwFamily_self, if_pos rfl]
      · have hpos : 0 < (i : ℕ) := Nat.pos_of_ne_zero (fun h => h0 (Fin.ext h))
        rw [jwFamily_of_gt (A := pauliZ) (by simpa using hpos), if_neg h0]
        by_cases hl : i = Fin.last (r + 1)
        · rw [hl, jwFamily_self, if_pos rfl]
        · have hlt : (i : ℕ) < ((Fin.last (r + 1) : Fin (r + 2)) : ℕ) :=
            lt_of_le_of_ne (Fin.le_last i) (fun h => hl (Fin.ext h))
          rw [jwFamily_of_lt hlt, if_neg hl]
    _ = siteProd (r + 2) (fun i =>
          if i = 0 then pauliX * pauliZ
          else if i = Fin.last (r + 1) then pauliY * 1 else pauliX) := by
      rw [mul_identity_matrix pauliX]                   -- `identity_matrix_is_right_unit_of_mat_mult`（`m, n → 2`, `A → σ^x`。第 `2` から第 `M_col-1` 因子へ同時に適用）
    _ = siteProd (r + 2) (fun i =>
          if i = 0 then pauliX * pauliZ
          else if i = Fin.last (r + 1) then pauliY else pauliX) := by
      rw [mul_identity_matrix pauliY]                   -- `identity_matrix_is_right_unit_of_mat_mult`（`m, n → 2`, `A → σ^y`。第 `M_col` 因子へ）
    _ = siteProd (r + 2) (fun i =>
          if i = 0 then (-Complex.I) • pauliY
          else if i = Fin.last (r + 1) then pauliY else pauliX) := by
      rw [pauliX_mul_pauliZ_eq]                         -- Step 0 の `σ^xσ^z = (-i)σ^y`
    _ = (-Complex.I) • siteProd (r + 2) (fun i =>
          if i = 0 then pauliY
          else if i = Fin.last (r + 1) then pauliY else pauliX) := by
      -- 両辺の因子の並びを `Function.update`（第 `1` 因子だけを置き換えた並び）で書く。`ite` と `Function.update` の書き方の違いだけ
      have hupd : ∀ A : Matrix (Fin 2) (Fin 2) ℂ,
          (fun i : Fin (r + 2) => if i = 0 then A
            else if i = Fin.last (r + 1) then pauliY else pauliX)
            = Function.update (fun i : Fin (r + 2) => if i = 0 then pauliY
                else if i = Fin.last (r + 1) then pauliY else pauliX) 0 A := by
        intro A
        funext i
        by_cases h0 : i = 0
        · rw [h0, Function.update_self, if_pos rfl]
        · rw [Function.update_of_ne h0, if_neg h0, if_neg h0]
      rw [hupd ((-Complex.I) • pauliY)]
      conv_rhs => rw [hupd pauliY]
      exact (siteProd (r + 2)).map_update_smul _ 0 (-Complex.I) pauliY
                                                        -- `kronecker_multilinear` の `r = 1` の場合（`M → M_col`, `j → 1`, `c → -i`, `A_1 → σ^y`, `A_k → σ^x`（`2 ≤ k ≤ M_col-1`）, `A_{M_col} → σ^y`）。Lean の具体版は無く、`siteProd` の多重線型性 `MultilinearMap.map_update_smul` を 1 回
    _ = (-Complex.I) • siteProd (r + 2) (boundaryYXYFamily (r + 2) (by omega)) := by
      congr 2                                           -- 準備の `G` の表示（`boundaryYXYFamily` の `∨` と `ite` の書き方の違いだけ）
      funext i
      have hf : firstSite (r + 2) (by omega) = (0 : Fin (r + 2)) := Fin.ext (by simp [firstSite])
      have hl : lastSite (r + 2) (by omega) = Fin.last (r + 1) := Fin.ext (by simp [lastSite])
      simp only [boundaryYXYFamily, hf, hl]
      by_cases h0 : i = 0
      · rw [if_pos h0, if_pos (Or.inl h0)]
      · rw [if_neg h0]
        by_cases hl' : i = Fin.last (r + 1)
        · rw [if_pos hl', if_pos (Or.inr hl')]
        · rw [if_neg hl', if_neg (by tauto)]

/-- **人手 `iH_is_real_symmetric` Step 2 の `S_1^{(+)}` の鎖**:
`S_1^{(+)} = (iK_1)H_1^{(+)} = K_1Σ_{m=1}^{M_col-1} σ^z_mσ^z_{m+1} - K_1G`（`M = r + 2`）。人手の 13 行のうち先頭の「`S_1^{(+)}` の定義」の行は主張の左辺そのもので、残る 12 行が `calc` の 12 段と 1 対 1。 -/
theorem S1plus_eq_K1_smul_sub (K1 : ℂ) (r : ℕ) :
    (Complex.I * K1) • H1plus (r + 2)
      = K1 • (∑ m : Fin (r + 1), sigmaZ (Fin.castSucc m) * sigmaZ (Fin.succ m))
        - K1 • siteProd (r + 2) (boundaryYXYFamily (r + 2) (by omega)) := by
  set G := siteProd (r + 2) (boundaryYXYFamily (r + 2) (by omega)) with hG
  set D := ∑ m : Fin (r + 1), sigmaZ (Fin.castSucc m) * sigmaZ (Fin.succ m) with hD
  calc (Complex.I * K1) • H1plus (r + 2)
      = (Complex.I * K1) • ((∑ m : Fin (r + 1), Y (Fin.castSucc m) * Z (Fin.succ m))
          - Y (Fin.last (r + 1)) * Z 0) := by
        rw [H1plus_eq_sub]                                                   -- `def_H1_plus`
    _ = (Complex.I * K1) • ((∑ m : Fin (r + 1), (-Complex.I) • (sigmaZ (Fin.castSucc m) * sigmaZ (Fin.succ m)))
          - Y (Fin.last (r + 1)) * Z 0) := by
        rw [Finset.sum_congr rfl fun m _ => Y_castSucc_mul_Z_succ m]          -- 上で得た `Y_mZ_{m+1} = (-i)σ^z_mσ^z_{m+1}` を各項へ
    _ = (Complex.I * K1) • ((∑ m : Fin (r + 1), (-Complex.I) • (sigmaZ (Fin.castSucc m) * sigmaZ (Fin.succ m)))
          - (-Complex.I) • G) := by
        rw [Y_last_mul_Z_zero]                                               -- 上で得た `Y_{M_col}Z_1 = (-i)G`
    _ = (Complex.I * K1) • ((-Complex.I) • D - (-Complex.I) • G) := by
        rw [finite_sum_smul_tensorPow (-Complex.I) r]                        -- `finite_sum_of_scalar_multiples`（`m, n → 2^{M_col}`, `r → M_col-1`, `c → -i`, `(X_1, …, X_r) → (σ^z_1σ^z_2, …, σ^z_{M_col-1}σ^z_{M_col})`）
    _ = (Complex.I * K1) • ((-Complex.I) • (D - G)) := by
        rw [smul_sub_tensorPow (-Complex.I) D G]                             -- `scalar_multiple_distributes_over_matrix_difference`（`c → -i`, `A → Σσ^zσ^z`, `B → G`）を右辺から左辺へ
    _ = ((Complex.I * K1) * (-Complex.I)) • (D - G) :=
        smul_smul _ _ _                                                      -- `scalar_multiple_is_associative`（`a → iK_1`, `b → -i`）
    _ = (Complex.I * (K1 * (-Complex.I))) • (D - G) := by
        rw [mul_assoc]                                                       -- ℂ の積の結合律
    _ = (Complex.I * ((-Complex.I) * K1)) • (D - G) := by
        rw [mul_comm K1 (-Complex.I)]                                        -- ℂ の積の交換律
    _ = ((Complex.I * (-Complex.I)) * K1) • (D - G) := by
        rw [← mul_assoc]                                                     -- ℂ の積の結合律
    _ = (1 * K1) • (D - G) := by
        rw [I_mul_neg_I]                                                     -- `i·(-i) = 1_ℂ`
    _ = K1 • (D - G) := by
        rw [one_mul]                                                         -- ℂ の乗法の単位元
    _ = K1 • D - K1 • G :=
        smul_sub_tensorPow K1 D G                                            -- `scalar_multiple_distributes_over_matrix_difference`（`c → K_1`, `A → Σσ^zσ^z`, `B → G`）

/-! ## Step 3 の転置の鎖

人手の Step 3 の `(σ^x_m)^⊤ = σ^x_m`・`(σ^z_mσ^z_{m+1})^⊤ = σ^z_mσ^z_{m+1}`・`G^⊤ = G` の鎖と 1 対 1 に対応する。
人手の因子の並び `I⊠⋯⊠σ^a⊠⋯⊠I` は、Lean では `siteProd` に入れる因子の族として `ite` で書く。`def_site_pauli_matrices` と
Step 2 の準備の表示は `Function.update` で書いてあるので、`kronecker_transpose`（`siteProd_transpose`）の段と最後の段で、
因子の族の書き方（`Function.update` と `ite`）を揃える（等式の変形ではなく書き方の違いだけ）。 -/

/-- **人手 `iH_is_real_symmetric` Step 3 の `(σ^x_m)^⊤ = σ^x_m` の 5 行の鎖**（`m ∈ {1, …, M_col}`）。 -/
theorem sigmaX_transpose {M : ℕ} (m : Fin M) : (sigmaX m)ᵀ = sigmaX m := by
  have hform : ∀ A : Matrix (Fin 2) (Fin 2) ℂ,
      Function.update (1 : Fin M → Matrix (Fin 2) (Fin 2) ℂ) m A = fun k => if k = m then A else 1 := by
    intro A
    funext k
    by_cases h : k = m
    · rw [h, Function.update_self, if_pos rfl]
    · rw [Function.update_of_ne h, if_neg h]; rfl
  calc
    (sigmaX m)ᵀ
        = (siteProd M (Function.update (1 : Fin M → Matrix (Fin 2) (Fin 2) ℂ) m pauliX))ᵀ := rfl
                                                        -- `def_site_pauli_matrices`（`k → m`, `a → x`）
    _ = siteProd M (fun k => if k = m then pauliXᵀ else (1 : Matrix (Fin 2) (Fin 2) ℂ)ᵀ) := by
      rw [siteProd_transpose, hform]                    -- `kronecker_transpose`（`M → M_col`, `A_m → σ^x`, `A_k → I`（`k ≠ m`））
      congr 1
      funext k
      dsimp only
      by_cases h : k = m
      · rw [if_pos h, if_pos h]
      · rw [if_neg h, if_neg h]
    _ = siteProd M (fun k => if k = m then pauliXᵀ else 1) := by
      rw [identity_matrix_two_transpose]                -- `transpose_of_identity_matrix_of_order_two`（第 `m` 因子以外の因子へ同時に適用）
    _ = siteProd M (fun k => if k = m then pauliX else 1) := by
      rw [pauliX_transpose]                             -- `transpose_of_pauli_x`（第 `m` 因子へ）
    _ = sigmaX m := by
      rw [← hform]; rfl                                 -- `def_site_pauli_matrices`（`k → m`, `a → x`）

/-- **人手 `iH_is_real_symmetric` Step 3 の `(σ^z_mσ^z_{m+1})^⊤ = σ^z_mσ^z_{m+1}` の 5 行の鎖**（`1 ≤ m ≤ M_col - 1`、`M = r + 2`）。
人手の `m` は Lean の `Fin.castSucc m`、`m + 1` は `Fin.succ m`。 -/
theorem sigmaZ_castSucc_mul_sigmaZ_succ_transpose {r : ℕ} (m : Fin (r + 1)) :
    (sigmaZ (Fin.castSucc m) * sigmaZ (Fin.succ m))ᵀ = sigmaZ (Fin.castSucc m) * sigmaZ (Fin.succ m) := by
  have hab : (Fin.castSucc m : Fin (r + 2)) ≠ Fin.succ m := Fin.ne_of_val_ne (by simp)
  have hform : Function.update (Function.update (1 : Fin (r + 2) → Matrix (Fin 2) (Fin 2) ℂ)
      (Fin.succ m) pauliZ) (Fin.castSucc m) pauliZ
        = fun i => if i = Fin.castSucc m then pauliZ else if i = Fin.succ m then pauliZ else 1 := by
    funext i
    by_cases ha : i = Fin.castSucc m
    · rw [ha, Function.update_self, if_pos rfl]
    · rw [Function.update_of_ne ha, if_neg ha]
      by_cases hb : i = Fin.succ m
      · rw [hb, Function.update_self, if_pos rfl]
      · rw [Function.update_of_ne hb, if_neg hb]; rfl
  calc
    (sigmaZ (Fin.castSucc m) * sigmaZ (Fin.succ m))ᵀ
        = (siteProd (r + 2) (Function.update (Function.update (1 : Fin (r + 2) → Matrix (Fin 2) (Fin 2) ℂ)
            (Fin.succ m) pauliZ) (Fin.castSucc m) pauliZ))ᵀ := by
      rw [sigmaZ_castSucc_mul_sigmaZ_succ_kronecker]    -- Step 2 の準備の `σ^z_mσ^z_{m+1}` の表示
    _ = siteProd (r + 2) (fun i => if i = Fin.castSucc m then pauliZᵀ
          else if i = Fin.succ m then pauliZᵀ else (1 : Matrix (Fin 2) (Fin 2) ℂ)ᵀ) := by
      rw [siteProd_transpose, hform]                    -- `kronecker_transpose`（`M → M_col`, `A_m, A_{m+1} → σ^z`, `A_k → I`（`k ≠ m, m+1`））
      congr 1
      funext i
      dsimp only
      by_cases ha : i = Fin.castSucc m
      · rw [if_pos ha, if_pos ha]
      · rw [if_neg ha, if_neg ha]
        by_cases hb : i = Fin.succ m
        · rw [if_pos hb, if_pos hb]
        · rw [if_neg hb, if_neg hb]
    _ = siteProd (r + 2) (fun i => if i = Fin.castSucc m then pauliZᵀ
          else if i = Fin.succ m then pauliZᵀ else 1) := by
      rw [identity_matrix_two_transpose]                -- `transpose_of_identity_matrix_of_order_two`（第 `m`・第 `m+1` 因子以外の因子へ同時に適用）
    _ = siteProd (r + 2) (fun i => if i = Fin.castSucc m then pauliZ
          else if i = Fin.succ m then pauliZ else 1) := by
      rw [pauliZ_transpose]                             -- `transpose_of_pauli_z`（第 `m` 因子と第 `m+1` 因子へ同時に適用）
    _ = sigmaZ (Fin.castSucc m) * sigmaZ (Fin.succ m) := by
      rw [sigmaZ_castSucc_mul_sigmaZ_succ_kronecker, hform]   -- Step 2 の準備の `σ^z_mσ^z_{m+1}` の表示

/-- **人手 `iH_is_real_symmetric` Step 3 の `σ^x_m` の成分の実性**（`1 ≤ m ≤ M_col`、`M = n + 1`）:
`σ^x_m = I⊠⋯⊠σ^x⊠⋯⊠I`（`def_site_pauli_matrices`）の因子 `I`・`σ^x` の成分はすべて実数なので、
`kronecker_of_real_entry_matrices_has_real_entries` より `σ^x_m` の成分はすべて実数。 -/
theorem sigmaX_hasRealEntries {n : ℕ} (m : Fin (n + 1)) : MatrixHasRealEntries (sigmaX m) := by
  have hform : sigmaX m
      = siteProd (n + 1) (Function.update (1 : Fin (n + 1) → Matrix (Fin 2) (Fin 2) ℂ) m pauliX) := rfl
                                                        -- `def_site_pauli_matrices`（`k → m`, `a → x`）
  rw [hform]
  refine siteProd_hasRealEntries _ fun k => ?_          -- `kronecker_of_real_entry_matrices_has_real_entries`（`M → M_col`, `A_m → σ^x`, `A_k → I`（`k ≠ m`））
  by_cases h : k = m
  · rw [h, Function.update_self]
    exact pauliX_hasRealEntries                         -- `pauli_x_has_real_entries`
  · rw [Function.update_of_ne h]
    exact identity_matrix_two_hasRealEntries            -- `identity_matrix_of_order_two_has_real_entries`

/-- **人手 `iH_is_real_symmetric` Step 3 の `σ^z_mσ^z_{m+1}` の成分の実性**（`1 ≤ m ≤ M_col - 1`、`M = r + 2`）:
Step 2 の準備の表示 `I⊠⋯⊠I⊠σ^z⊠σ^z⊠I⊠⋯⊠I` の因子 `I`・`σ^z` の成分はすべて実数なので、
`kronecker_of_real_entry_matrices_has_real_entries` より `σ^z_mσ^z_{m+1}` の成分はすべて実数。 -/
theorem sigmaZ_castSucc_mul_sigmaZ_succ_hasRealEntries {r : ℕ} (m : Fin (r + 1)) :
    MatrixHasRealEntries (sigmaZ (Fin.castSucc m) * sigmaZ (Fin.succ m)) := by
  rw [sigmaZ_castSucc_mul_sigmaZ_succ_kronecker]        -- Step 2 の準備の `σ^z_mσ^z_{m+1}` の表示
  refine siteProd_hasRealEntries _ fun k => ?_          -- `kronecker_of_real_entry_matrices_has_real_entries`（`M → M_col`, `A_m, A_{m+1} → σ^z`, `A_k → I`（`k ≠ m, m+1`））
  by_cases ha : k = Fin.castSucc m
  · rw [ha, Function.update_self]
    exact pauliZ_hasRealEntries                         -- `pauli_z_has_real_entries`（第 `m` 因子）
  · rw [Function.update_of_ne ha]
    by_cases hb : k = Fin.succ m
    · rw [hb, Function.update_self]
      exact pauliZ_hasRealEntries                       -- `pauli_z_has_real_entries`（第 `m+1` 因子）
    · rw [Function.update_of_ne hb]
      exact identity_matrix_two_hasRealEntries          -- `identity_matrix_of_order_two_has_real_entries`

/-- 人手 `iH_is_real_symmetric` Step 2 の準備の `G` の表示 `σ^y⊠σ^x⊠⋯⊠σ^x⊠σ^y` の因子の並びを、`ite` で書いたもの
（`boundaryYXYFamily` の `∨` と `ite` の書き方の違いだけ）。 -/
theorem boundaryYXYFamily_eq_ite (r : ℕ) :
    boundaryYXYFamily (r + 2) (by omega)
      = fun i : Fin (r + 2) => if i = 0 then pauliY else if i = Fin.last (r + 1) then pauliY else pauliX := by
  funext i
  have hf : firstSite (r + 2) (by omega) = (0 : Fin (r + 2)) := Fin.ext (by simp [firstSite])
  have hl : lastSite (r + 2) (by omega) = Fin.last (r + 1) := Fin.ext (by simp [lastSite])
  simp only [boundaryYXYFamily, hf, hl]
  by_cases h0 : i = 0
  · rw [if_pos (Or.inl h0), if_pos h0]
  · rw [if_neg h0]
    by_cases hl' : i = Fin.last (r + 1)
    · rw [if_pos (Or.inr hl'), if_pos hl']
    · rw [if_neg (by tauto), if_neg hl']

/-- **人手 `iH_is_real_symmetric` Step 3 の `G^⊤ = G` の 11 行の鎖**（`M_col = r + 2 ≥ 2`）。
人手の第 `1` 因子は Lean の `i = 0`、第 `M_col` 因子は `i = Fin.last (r + 1)`、第 `2` から第 `M_col-1` 因子はそれ以外である。 -/
theorem boundaryYXY_transpose (r : ℕ) :
    (siteProd (r + 2) (boundaryYXYFamily (r + 2) (by omega)))ᵀ
      = siteProd (r + 2) (boundaryYXYFamily (r + 2) (by omega)) := by
  have h0l : (0 : Fin (r + 2)) ≠ Fin.last (r + 1) := Fin.ne_of_val_ne (by simp)
  -- 因子の並び `A⊠σ^x⊠⋯⊠σ^x⊠B`（第 `1` 因子 `A`、第 `M_col` 因子 `B`）
  let F : Matrix (Fin 2) (Fin 2) ℂ → Matrix (Fin 2) (Fin 2) ℂ → Fin (r + 2) → Matrix (Fin 2) (Fin 2) ℂ :=
    fun A B i => if i = 0 then A else if i = Fin.last (r + 1) then B else pauliX
  -- `F A B` は `F A' B` の第 `1` 因子を `A` に置き換えたもの、`F A B` は `F A B'` の第 `M_col` 因子を `B` に置き換えたもの
  -- （`kronecker_multilinear` を引くための書き方の違いだけ）
  have hupd0 : ∀ A A' B, F A B = Function.update (F A' B) 0 A := by
    intro A A' B
    funext i
    by_cases h0 : i = 0
    · rw [h0, Function.update_self]; simp only [F, if_pos rfl]
    · rw [Function.update_of_ne h0]; simp only [F, if_neg h0]
  have hupdl : ∀ A B B', F A B = Function.update (F A B') (Fin.last (r + 1)) B := by
    intro A B B'
    funext i
    by_cases hl : i = Fin.last (r + 1)
    · rw [hl, Function.update_self]; simp only [F, if_neg h0l.symm, ↓reduceIte]
    · rw [Function.update_of_ne hl]; simp only [F, if_neg hl]
  calc
    (siteProd (r + 2) (boundaryYXYFamily (r + 2) (by omega)))ᵀ
        = (siteProd (r + 2) (F pauliY pauliY))ᵀ := by
      rw [boundaryYXYFamily_eq_ite]                     -- Step 2 の準備の `G` の表示
    _ = siteProd (r + 2) (fun i => if i = 0 then pauliYᵀ
          else if i = Fin.last (r + 1) then pauliYᵀ else pauliXᵀ) := by
      rw [siteProd_transpose]                           -- `kronecker_transpose`（`M → M_col`, `A_1, A_{M_col} → σ^y`, `A_k → σ^x`（`2 ≤ k ≤ M_col-1`））
      congr 1
      funext i
      simp only [F]
      by_cases h0 : i = 0
      · rw [if_pos h0, if_pos h0]
      · rw [if_neg h0, if_neg h0]
        by_cases hl : i = Fin.last (r + 1)
        · rw [if_pos hl, if_pos hl]
        · rw [if_neg hl, if_neg hl]
    _ = siteProd (r + 2) (fun i => if i = 0 then pauliYᵀ
          else if i = Fin.last (r + 1) then pauliYᵀ else pauliX) := by
      rw [pauliX_transpose]                             -- `transpose_of_pauli_x`（第 `2` から第 `M_col-1` 因子へ同時に適用）
    _ = siteProd (r + 2) (F (-pauliY) (-pauliY)) := by
      rw [pauliY_transpose]                             -- `transpose_of_pauli_y`（第 `1` 因子と第 `M_col` 因子へ同時に適用）
    _ = siteProd (r + 2) (F ((-1 : ℂ) • pauliY) ((-1 : ℂ) • pauliY)) := by
      rw [neg_eq_neg_one_smul_matrix pauliY]            -- `negation_is_scalar_multiple_by_minus_one`（`m, n → 2`, `A → σ^y`。第 `1` 因子と第 `M_col` 因子へ同時に適用）
    _ = (-1 : ℂ) • siteProd (r + 2) (F pauliY ((-1 : ℂ) • pauliY)) := by
      rw [hupd0 ((-1 : ℂ) • pauliY) pauliY ((-1 : ℂ) • pauliY)]
      conv_rhs => rw [hupd0 pauliY pauliY ((-1 : ℂ) • pauliY)]
      exact (siteProd (r + 2)).map_update_smul _ 0 (-1 : ℂ) pauliY
                                                        -- `kronecker_multilinear` の `r = 1` の場合（`j → 1`, `c → -1_ℂ`, `A_1 → σ^y`, `A_k → σ^x`, `A_{M_col} → (-1_ℂ)σ^y`）。Lean の具体版は無く、`siteProd` の多重線型性 `MultilinearMap.map_update_smul` を 1 回
    _ = (-1 : ℂ) • ((-1 : ℂ) • siteProd (r + 2) (F pauliY pauliY)) := by
      rw [hupdl pauliY ((-1 : ℂ) • pauliY) pauliY]
      conv_rhs => rw [hupdl pauliY pauliY pauliY]
      congr 1
      exact (siteProd (r + 2)).map_update_smul _ (Fin.last (r + 1)) (-1 : ℂ) pauliY
                                                        -- `kronecker_multilinear` の `r = 1` の場合（`j → M_col`, `c → -1_ℂ`, `A_1 → σ^y`, `A_k → σ^x`, `A_{M_col} → σ^y`）。同上
    _ = ((-1 : ℂ) * (-1)) • siteProd (r + 2) (F pauliY pauliY) :=
      smul_smul _ _ _                                   -- `scalar_multiple_is_associative`（`a, b → -1_ℂ`。Lean の具体版は無く、mathlib の `smul_smul`）
    _ = (1 : ℂ) • siteProd (r + 2) (F pauliY pauliY) := by
      rw [mul_neg_one, neg_neg]                         -- ℂ で `(-1)·(-1) = 1`（`definition_of_cc` の積）
    _ = siteProd (r + 2) (F pauliY pauliY) :=
      one_smul_tensorPow _                              -- `scalar_multiple_by_one`（`TensorPow` の系 `one_smul_tensorPow`）
    _ = siteProd (r + 2) (boundaryYXYFamily (r + 2) (by omega)) := by
      rw [boundaryYXYFamily_eq_ite]                     -- Step 2 の準備の `G` の表示

/-- **人手 `iH_is_real_symmetric` Step 3 の `G` の成分の実性の 7 行の鎖**（`M_col = r + 2 ≥ 2`）:
`G = σ^y⊠σ^x⊠⋯⊠σ^x⊠σ^y = (iR^y)⊠σ^x⊠⋯⊠σ^x⊠(iR^y) = ⋯ = (-1)_ℂ(R^y⊠σ^x⊠⋯⊠σ^x⊠R^y)`。
人手の第 `1` 因子は Lean の `i = 0`、第 `M_col` 因子は `i = Fin.last (r + 1)`、第 `2` から第 `M_col-1` 因子はそれ以外である。 -/
theorem boundaryYXY_eq_neg_one_smul_real (r : ℕ) :
    siteProd (r + 2) (boundaryYXYFamily (r + 2) (by omega))
      = ((-1 : ℝ) : ℂ) • siteProd (r + 2) (fun i : Fin (r + 2) =>
          if i = 0 then pauliYReal else if i = Fin.last (r + 1) then pauliYReal else pauliX) := by
  have h0l : (0 : Fin (r + 2)) ≠ Fin.last (r + 1) := Fin.ne_of_val_ne (by simp)
  -- 因子の並び `A⊠σ^x⊠⋯⊠σ^x⊠B`（第 `1` 因子 `A`、第 `M_col` 因子 `B`）。`boundaryYXY_transpose` と同じ書き方
  let F : Matrix (Fin 2) (Fin 2) ℂ → Matrix (Fin 2) (Fin 2) ℂ → Fin (r + 2) → Matrix (Fin 2) (Fin 2) ℂ :=
    fun A B i => if i = 0 then A else if i = Fin.last (r + 1) then B else pauliX
  have hupd0 : ∀ A A' B, F A B = Function.update (F A' B) 0 A := by
    intro A A' B
    funext i
    by_cases h0 : i = 0
    · rw [h0, Function.update_self]; simp only [F, if_pos rfl]
    · rw [Function.update_of_ne h0]; simp only [F, if_neg h0]
  have hupdl : ∀ A B B', F A B = Function.update (F A B') (Fin.last (r + 1)) B := by
    intro A B B'
    funext i
    by_cases hl : i = Fin.last (r + 1)
    · rw [hl, Function.update_self]; simp only [F, if_neg h0l.symm, ↓reduceIte]
    · rw [Function.update_of_ne hl]; simp only [F, if_neg hl]
  calc
    siteProd (r + 2) (boundaryYXYFamily (r + 2) (by omega))
        = siteProd (r + 2) (F pauliY pauliY) := by
      rw [boundaryYXYFamily_eq_ite]                     -- Step 2 の準備の `G` の表示
    _ = siteProd (r + 2) (F (Complex.I • pauliYReal) (Complex.I • pauliYReal)) := by
      rw [pauliY_eq_I_smul_pauliYReal]                  -- `pauli_y_is_i_times_real_factor`（第 `1` 因子と第 `M_col` 因子へ同時に適用）
    _ = Complex.I • siteProd (r + 2) (F pauliYReal (Complex.I • pauliYReal)) := by
      rw [hupd0 (Complex.I • pauliYReal) pauliYReal (Complex.I • pauliYReal)]
      conv_rhs => rw [hupd0 pauliYReal pauliYReal (Complex.I • pauliYReal)]
      exact (siteProd (r + 2)).map_update_smul _ 0 Complex.I pauliYReal
                                                        -- `kronecker_multilinear` の `r = 1` の場合（`j → 1`, `c → i`, `A_1 → R^y`, `A_k → σ^x`, `A_{M_col} → iR^y`）。Lean の具体版は無く、`siteProd` の多重線型性 `MultilinearMap.map_update_smul` を 1 回（`boundaryYXY_transpose` と同じ）
    _ = Complex.I • (Complex.I • siteProd (r + 2) (F pauliYReal pauliYReal)) := by
      rw [hupdl pauliYReal (Complex.I • pauliYReal) pauliYReal]
      conv_rhs => rw [hupdl pauliYReal pauliYReal pauliYReal]
      congr 1
      exact (siteProd (r + 2)).map_update_smul _ (Fin.last (r + 1)) Complex.I pauliYReal
                                                        -- `kronecker_multilinear` の `r = 1` の場合（`j → M_col`, `c → i`, `A_1 → R^y`, `A_k → σ^x`, `A_{M_col} → R^y`）。同上
    _ = (Complex.I * Complex.I) • siteProd (r + 2) (F pauliYReal pauliYReal) :=
      smul_smul _ _ _                                   -- `scalar_multiple_is_associative`（`a, b → i`。Lean の具体版は無く、mathlib の `smul_smul`）
    _ = (-1 : ℂ) • siteProd (r + 2) (F pauliYReal pauliYReal) := by
      rw [Complex.I_mul_I]                              -- ℂ で `i·i = -1`（`definition_of_cc` の積）
    _ = ((-1 : ℝ) : ℂ) • siteProd (r + 2) (F pauliYReal pauliYReal) := by
      rw [Complex.ofReal_neg, Complex.ofReal_one]       -- `inclusion_rr_to_cc` の略記 `-1_ℂ = ι(-1)`

/-- **人手 `iH_is_real_symmetric` Step 3 の `G` の成分の実性**（`M_col = r + 2 ≥ 2`）:
因子 `R^y`・`σ^x` の成分はすべて実数なので `kronecker_of_real_entry_matrices_has_real_entries` より `R^y⊠σ^x⊠⋯⊠σ^x⊠R^y` の成分はすべて実数、
`real_scalar_multiple_of_real_entry_matrix_has_real_entries`（`c → -1`）と `boundaryYXY_eq_neg_one_smul_real` より `G` の成分はすべて実数。 -/
theorem boundaryYXY_hasRealEntries (r : ℕ) :
    MatrixHasRealEntries (siteProd (r + 2) (boundaryYXYFamily (r + 2) (by omega))) := by
  rw [boundaryYXY_eq_neg_one_smul_real]                 -- 上の鎖
  refine real_smul_hasRealEntries (-1) _ ?_             -- `real_scalar_multiple_of_real_entry_matrix_has_real_entries`（`m, n → 2^{M_col}`, `c → -1`）
  refine siteProd_hasRealEntries _ fun k => ?_          -- `kronecker_of_real_entry_matrices_has_real_entries`（`M → M_col`, `A_1, A_{M_col} → R^y`, `A_k → σ^x`（`2 ≤ k ≤ M_col-1`））
  by_cases h0 : k = 0
  · rw [if_pos h0]
    exact pauliYReal_hasRealEntries                     -- `real_factor_of_pauli_y_has_real_entries`（第 `1` 因子）
  · rw [if_neg h0]
    by_cases hl : k = Fin.last (r + 1)
    · rw [if_pos hl]
      exact pauliYReal_hasRealEntries                   -- `real_factor_of_pauli_y_has_real_entries`（第 `M_col` 因子）
    · rw [if_neg hl]
      exact pauliX_hasRealEntries                       -- `pauli_x_has_real_entries`（第 `2` から第 `M_col-1` 因子）

/-! ## Step 3 の `S_2`・`S_1^{(+)}` の転置の鎖

人手の Step 3 の `(S_2)^⊤ = S_2` の 5 行と `(S_1^{(+)})^⊤ = S_1^{(+)}` の 7 行の鎖と 1 対 1 に対応する。
`transpose_of_matrix_scalar_multiple`・`transpose_of_matrix_difference`・`transpose_of_finite_sum_of_matrices` は、`TensorPow M` の系
`transpose_smul_tensorPow`・`transpose_sub_tensorPow`・`finite_sum_transpose_tensorPow`
（`MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimTransposeOfMatrixSumsAndScalarMultiplesFromNecSuf.lean`）で引く。これらは必要十分版を添字 `Conf M` へ特殊化したもので、具体版（添字 `Fin m`）と手順は同じである（`finite_sum_smul_tensorPow` と同じ構成）。 -/

/-- **人手 `iH_is_real_symmetric` Step 3 の `(S_2)^⊤ = S_2` の 5 行の鎖**（`M = r + 1`）。 -/
theorem S2_transpose_by_pauli_form (K2star : ℂ) (r : ℕ) :
    ((Complex.I * K2star) • H2 (r + 1))ᵀ = (Complex.I * K2star) • H2 (r + 1) :=
  calc ((Complex.I * K2star) • H2 (r + 1))ᵀ
      = (K2star • ∑ m : Fin (r + 1), sigmaX m)ᵀ := by
        rw [S2_eq_K2star_smul_sum_sigmaX]                                    -- Step 1 の `S_2` の表示
    _ = K2star • (∑ m : Fin (r + 1), sigmaX m)ᵀ :=
        transpose_smul_tensorPow _ _                                         -- `transpose_of_matrix_scalar_multiple`（必要十分版の `Conf M` への特殊化。`m, n → 2^{M_col}`, `c → K_2^*`, `A → Σσ^x_ℓ`）
    _ = K2star • ∑ m : Fin (r + 1), (sigmaX m)ᵀ := by
        rw [finite_sum_transpose_tensorPow r]                                -- `transpose_of_finite_sum_of_matrices`（必要十分版の `Conf M` への特殊化。`r → M_col`, `(X_1, …, X_r) → (σ^x_1, …, σ^x_{M_col})`）
    _ = K2star • ∑ m : Fin (r + 1), sigmaX m := by
        rw [Finset.sum_congr rfl fun m _ => sigmaX_transpose m]              -- 上で得た `(σ^x_m)^⊤ = σ^x_m` を各項へ
    _ = (Complex.I * K2star) • H2 (r + 1) :=
        (S2_eq_K2star_smul_sum_sigmaX K2star r).symm                         -- Step 1 の `S_2` の表示

/-- **人手 `iH_is_real_symmetric` Step 3 の `(S_1^{(+)})^⊤ = S_1^{(+)}` の 7 行の鎖**（`M = r + 2`）。 -/
theorem S1plus_transpose_by_pauli_form (K1 : ℂ) (r : ℕ) :
    ((Complex.I * K1) • H1plus (r + 2))ᵀ = (Complex.I * K1) • H1plus (r + 2) :=
  calc ((Complex.I * K1) • H1plus (r + 2))ᵀ
      = (K1 • (∑ m : Fin (r + 1), sigmaZ (Fin.castSucc m) * sigmaZ (Fin.succ m))
          - K1 • siteProd (r + 2) (boundaryYXYFamily (r + 2) (by omega)))ᵀ := by
        rw [S1plus_eq_K1_smul_sub]                                           -- Step 2 の `S_1^{(+)}` の表示
    _ = (K1 • (∑ m : Fin (r + 1), sigmaZ (Fin.castSucc m) * sigmaZ (Fin.succ m)))ᵀ
          - (K1 • siteProd (r + 2) (boundaryYXYFamily (r + 2) (by omega)))ᵀ :=
        transpose_sub_tensorPow _ _                                          -- `transpose_of_matrix_difference`（必要十分版の `Conf M` への特殊化。`m, p → 2^{M_col}`, `A → K_1Σσ^zσ^z`, `B → K_1G`）
    _ = K1 • (∑ m : Fin (r + 1), sigmaZ (Fin.castSucc m) * sigmaZ (Fin.succ m))ᵀ
          - K1 • (siteProd (r + 2) (boundaryYXYFamily (r + 2) (by omega)))ᵀ := by
        rw [transpose_smul_tensorPow, transpose_smul_tensorPow]              -- `transpose_of_matrix_scalar_multiple`（必要十分版の `Conf M` への特殊化。`c → K_1`, `A → Σσ^zσ^z` と `A → G`）を 2 箇所へ同時に適用
    _ = K1 • (∑ m : Fin (r + 1), (sigmaZ (Fin.castSucc m) * sigmaZ (Fin.succ m))ᵀ)
          - K1 • (siteProd (r + 2) (boundaryYXYFamily (r + 2) (by omega)))ᵀ := by
        rw [finite_sum_transpose_tensorPow r]                                -- `transpose_of_finite_sum_of_matrices`（必要十分版の `Conf M` への特殊化。`r → M_col-1`, `(X_1, …, X_r) → (σ^z_1σ^z_2, …, σ^z_{M_col-1}σ^z_{M_col})`）
    _ = K1 • (∑ m : Fin (r + 1), sigmaZ (Fin.castSucc m) * sigmaZ (Fin.succ m))
          - K1 • (siteProd (r + 2) (boundaryYXYFamily (r + 2) (by omega)))ᵀ := by
        rw [Finset.sum_congr rfl fun m _ => sigmaZ_castSucc_mul_sigmaZ_succ_transpose m]
                                                                             -- 上で得た `(σ^z_mσ^z_{m+1})^⊤ = σ^z_mσ^z_{m+1}` を各項へ
    _ = K1 • (∑ m : Fin (r + 1), sigmaZ (Fin.castSucc m) * sigmaZ (Fin.succ m))
          - K1 • siteProd (r + 2) (boundaryYXYFamily (r + 2) (by omega)) := by
        rw [boundaryYXY_transpose]                                           -- 上で得た `G^⊤ = G`
    _ = (Complex.I * K1) • H1plus (r + 2) :=
        (S1plus_eq_K1_smul_sub K1 r).symm                                    -- Step 2 の `S_1^{(+)}` の表示

end Ising2D
