/-
# `ε_ℝ` は対称、`ε_ℝε_ℝ = I_{Mat(2^{M_col},ℝ)}`

正本: `structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts`

* `maxeig_claim_epsilon_real_is_symmetric`（ラベル **`epsilon_real_is_symmetric`**）
* `maxeig_claim_epsilon_real_square_is_identity`（ラベル **`epsilon_real_square_is_identity`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| `epsilon_real_is_symmetric` の 4 行の鎖 `((ε_ℝ)_kl)_ℂ = ε_kl = (ε^⊤)_kl = ε_lk = ((ε_ℝ)_lk)_ℂ` と `inclusion_rr_to_cc_is_injective`（`a → (ε_ℝ)_kl`, `b → (ε_ℝ)_lk`） | `epsilon_real_entry_symm` の `calc` の 4 段 |
| 同じ主張の結び（`def_real_symmetric_matrix` の意味で対称。Lean の `Matrix.IsSymm`） | `epsilon_real_is_symmetric` |
| `epsilon_real_square_is_identity` の 5 行の鎖 `ε_ℝε_ℝ = ϱ(εε) = ϱ(I_{Mat(d,ℂ)}) = ϱ(ε^0) = (ε_ℝ)^0 = I_{Mat(d,ℝ)}` | `epsilon_real_square_is_identity` の `calc` の 5 段 |

- 人手の `M_col` は Lean の `n + 1`、`ε_ℝ` は `epsilonReal n`（`ClaimEpsilonRealFixedVectorIffInclusionInEvenEigenvectors.lean`）である。
- 人手の `εε = I`（`epsilon_square_and_eigenvalues`。その `ε^2` は積 `εε`）は Lean の `epsilon_sq`。
- 既存の `epsilonR_isSymm`・`epsilonR_mul_self`（`ClaimEpsilonIsRealSymmetric.lean`）は、`epsilonR_eq_epsilonReal` で読み替えると
  同じ内容だが、置換行列の必要十分版を経由していて人手と 1 対 1 ではない。人手と 1 対 1 なのは本ファイルの 2 つである。

必要十分版は置かない。どちらの主張も、引いた主張（`epsilon_is_real_symmetric`・`epsilon_square_and_eigenvalues`・
`real_matrix_of_real_entry_matrix_preserves_product`・`real_matrix_of_real_entry_matrix_preserves_power`・`inclusion_rr_to_cc_is_injective`）を成分ごと、または 1 回ずつ当てることに尽き、
それらの外に抽象的な内容を持たない（`W_real_is_symmetric`・`trace_of_W_power_via_W_real` と同じ）。
-/
import Ising2D.ThermodynamicLimit.ColumnLimitAndClosedForm.ClaimEpsilonRealFixedVectorIffInclusionInEvenEigenvectors
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealMatrixOfRealEntryMatrixPreservesProductAndPower
import Ising2D.PartitionFunction.ProjectionAndJordanWigner.ClaimEpsilonProjectors

namespace Ising2D

open Matrix

/-- **人手 `epsilon_real_is_symmetric` の 4 行の鎖と単射性**:
`((ε_ℝ)_kl)_ℂ = ε_kl = (ε^⊤)_kl = ε_lk = ((ε_ℝ)_lk)_ℂ` に `inclusion_rr_to_cc_is_injective`（`a → (ε_ℝ)_kl`, `b → (ε_ℝ)_lk`）を当てる。 -/
theorem epsilon_real_entry_symm (n : ℕ) (k l : Conf (n + 1)) :
    epsilonReal n k l = epsilonReal n l k :=
  inclusion_rr_to_cc_is_injective <|
    calc ((epsilonReal n k l : ℝ) : ℂ)
        = epsilon (n + 1) k l := ofReal_epsilonReal_apply n k l               -- `def_epsilon_real`
      _ = (epsilon (n + 1))ᵀ k l := by
          rw [(epsilon_is_real_symmetric n).2]                              -- `ε^⊤ = ε`（`epsilon_is_real_symmetric`）
      _ = epsilon (n + 1) l k := Matrix.transpose_apply _ _ _               -- `def_matrix_transpose`
      _ = ((epsilonReal n l k : ℝ) : ℂ) := (ofReal_epsilonReal_apply n l k).symm
                                                                            -- `def_epsilon_real`

/-- **人手 `epsilon_real_is_symmetric`**: `ε_ℝ` は対称（`def_real_symmetric_matrix`。Lean の `Matrix.IsSymm` は `ε_ℝ^⊤ = ε_ℝ`、
成分では `(ε_ℝ)_lk = (ε_ℝ)_kl`）。`k, l` は任意なので、上の鎖を各 `k, l` に当てる。 -/
theorem epsilon_real_is_symmetric (n : ℕ) : (epsilonReal n).IsSymm :=
  Matrix.IsSymm.ext fun k l => epsilon_real_entry_symm n l k

/-- **人手 `epsilon_real_square_is_identity`**: `ε_ℝε_ℝ = I_{Mat(2^{M_col},ℝ)}`（人手の `M_col` は `n + 1`、`d := 2^{M_col}`）。
準備（`ε ∈ Mat^re`、`ε_ℝ = ϱ(ε)` なので `real_matrix_of_real_entry_matrix_preserves_product`（`A, B → ε`）・
`real_matrix_of_real_entry_matrix_preserves_power`（`A → ε`）が当てはまる）は `epsilonReal` の定義と `epsilon_hasRealEntries` である。
人手の `εε = I`（`epsilon_square_and_eigenvalues`）は Lean の `epsilon_sq`。 -/
theorem epsilon_real_square_is_identity (n : ℕ) : epsilonReal n * epsilonReal n = 1 :=
  calc epsilonReal n * epsilonReal n
      = realMatrixOfRealEntries (epsilon (n + 1) * epsilon (n + 1))
          (matrix_mul_hasRealEntries _ _ (epsilon_hasRealEntries n) (epsilon_hasRealEntries n)) :=
        (real_matrix_of_real_entry_matrix_preserves_product _ _
          (epsilon_hasRealEntries n) (epsilon_hasRealEntries n)).symm
                                                                            -- `real_matrix_of_real_entry_matrix_preserves_product`（`A, B → ε`）を右辺から左辺へ
    _ = realMatrixOfRealEntries (1 : Matrix (Conf (n + 1)) (Conf (n + 1)) ℂ)
          identity_matrix_hasRealEntries :=
        realMatrixOfRealEntries_congr epsilon_sq _ _                        -- `epsilon_square_and_eigenvalues` の `εε = I_{Mat(d,ℂ)}`
    _ = realMatrixOfRealEntries (epsilon (n + 1) ^ 0)
          (matrix_pow_hasRealEntries _ (epsilon_hasRealEntries n) 0) :=
        realMatrixOfRealEntries_congr (pow_zero _).symm _ _                 -- `def_exp` (1) の `A^0 := I`（`K = ℂ`, `A → ε`）を右辺から左辺へ
    _ = epsilonReal n ^ 0 :=
        real_matrix_of_real_entry_matrix_preserves_power _ (epsilon_hasRealEntries n) 0
                                                                            -- `real_matrix_of_real_entry_matrix_preserves_power`（`A → ε`, `q → 0`）
    _ = 1 := pow_zero _                                                     -- `def_exp` (1) の `A^0 := I`（`K = ℝ`、`I` は `def_real_identity_matrix`）

end Ising2D
