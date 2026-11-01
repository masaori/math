/-
# スカラー倍の単位行列は全行列と可換（**具体版**）

対応する人手証明: `structured-latex/content/002_linear_space_general.ts` の
`linear_space_general_002_claim_scalar_identity_commutes`（`<scalar_identity_commutes>`）。

人手の主張: `n ∈ ℤ_{≥1}`、`c ∈ ℂ`、`A ∈ Mat(n,ℂ)` について `[c · I_{Mat(n,ℂ)}, A] = O`。

## 人手証明との対応

`scalar_identity_commutes` の `calc` の各行が、人手の鎖の各行に当たる。

| 人手の行の根拠 | Lean |
| --- | --- |
| 交換子の定義（`commutator_via_anticommutators`） | `matComm_def` |
| `scalar_multiple_factors_out_of_left_factor` | `smul_mul_matrix` |
| `scalar_multiple_factors_out_of_right_factor` | `mul_smul_matrix` |
| `identity_matrix_is_left_unit_of_mat_mult` | `identity_matrix_mul` |
| `identity_matrix_is_right_unit_of_mat_mult` | `mul_identity_matrix` |
| `matrix_difference_zero_iff_equal` の `⟸` | `matrix_sub_eq_zero_iff` |

仮定 `1 ≤ n` は証明では使わない（`n = 0` でも成分が無いだけで成り立つ）。人手の主張との対応のために引数として残す。

**必要十分版**: `Ising2D/NecSuf/ScalarCentral.lean` の `Ising2D.NecSuf.smul_one_sub_comm`。
具体版をその系として導くのは `LemmaScalarIdentityCommutesFromNecSuf.lean`。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimCommutatorViaAnticommutators
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityAndScalarMultipleInMatrixProduct

namespace Ising2D

/-- **`<scalar_identity_commutes>`**: `[c · I_{Mat(n,ℂ)}, A] = O`。 -/
theorem scalar_identity_commutes {n : ℕ} (_hn : 1 ≤ n) (c : ℂ) (A : Matrix (Fin n) (Fin n) ℂ) :
    matComm (c • (1 : Matrix (Fin n) (Fin n) ℂ)) A = 0 :=
  calc matComm (c • (1 : Matrix (Fin n) (Fin n) ℂ)) A
      = (c • (1 : Matrix (Fin n) (Fin n) ℂ)) * A - A * (c • (1 : Matrix (Fin n) (Fin n) ℂ)) :=
        matComm_def _ _                                                    -- 交換子の定義
    _ = c • ((1 : Matrix (Fin n) (Fin n) ℂ) * A) - A * (c • (1 : Matrix (Fin n) (Fin n) ℂ)) := by
        rw [smul_mul_matrix]                                               -- `scalar_multiple_factors_out_of_left_factor`
    _ = c • ((1 : Matrix (Fin n) (Fin n) ℂ) * A) - c • (A * (1 : Matrix (Fin n) (Fin n) ℂ)) := by
        rw [mul_smul_matrix]                                               -- `scalar_multiple_factors_out_of_right_factor`
    _ = c • A - c • (A * (1 : Matrix (Fin n) (Fin n) ℂ)) := by
        rw [identity_matrix_mul]                                           -- `identity_matrix_is_left_unit_of_mat_mult`
    _ = c • A - c • A := by
        rw [mul_identity_matrix]                                           -- `identity_matrix_is_right_unit_of_mat_mult`
    _ = 0 := (matrix_sub_eq_zero_iff _ _).mpr rfl                          -- `matrix_difference_zero_iff_equal` の `⟸`

end Ising2D
