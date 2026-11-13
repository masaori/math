/-
# 2 次の単位行列・`σ^x`・`σ^z`・`R^y` の成分はすべて実数と、`σ^y = iR^y`（具体版）

正本: `structured-latex/content/006_Z_Y_anticommutation.ts`
（`Z_Y_anticommutation_claim_identity_matrix_of_order_two_has_real_entries`・`Z_Y_anticommutation_claim_pauli_x_has_real_entries`・
`Z_Y_anticommutation_claim_pauli_z_has_real_entries`・`Z_Y_anticommutation_definition_real_factor_of_pauli_y`・
`Z_Y_anticommutation_claim_pauli_y_is_i_times_real_factor`・`Z_Y_anticommutation_claim_real_factor_of_pauli_y_has_real_entries`、
ラベル **`identity_matrix_of_order_two_has_real_entries`**・**`pauli_x_has_real_entries`**・**`pauli_z_has_real_entries`**・
**`def_real_factor_of_pauli_y`**・**`pauli_y_is_i_times_real_factor`**・**`real_factor_of_pauli_y_has_real_entries`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| `identity_matrix_of_order_two_has_real_entries` の鎖 3 行（`def_identity_matrix` → `def_kronecker_delta` → `inclusion_rr_to_cc` の略記を各成分へ） | `identity_matrix_two_eq_ofReal` の `calc` の 3 段 |
| `pauli_x_has_real_entries` の鎖 2 行（`def_pauli_matrices` の `σ^x` → `inclusion_rr_to_cc` の略記を各成分へ） | `pauliX_eq_ofReal` の `calc` の 2 段 |
| `pauli_z_has_real_entries` の鎖 2 行（`def_pauli_matrices` の `σ^z` → `inclusion_rr_to_cc` の略記を各成分へ） | `pauliZ_eq_ofReal` の `calc` の 2 段 |
| `def_real_factor_of_pauli_y`（`R^y := !![0_ℂ, -1_ℂ; 1_ℂ, 0_ℂ]`） | `pauliYReal` |
| `pauli_y_is_i_times_real_factor` の鎖 7 行（`def_pauli_matrices` の `σ^y` → `multiply_by_minus_one` → 積の可換律 → 積の単位元 → `complex_times_zero_is_zero` を 2 成分へ → `def_matrix_scalar_multiple` → `def_real_factor_of_pauli_y`） | `pauliY_eq_I_smul_pauliYReal` の `calc` の 7 段 |
| `real_factor_of_pauli_y_has_real_entries` の鎖 2 行（`def_real_factor_of_pauli_y` → `inclusion_rr_to_cc` の略記を各成分へ） | `pauliYReal_eq_ofReal` の `calc` の 2 段 |
| 各成分について `r` を取り、`def_matrix_with_real_entries` の条件が成り立つ | `identity_matrix_two_hasRealEntries`・`pauliX_hasRealEntries`・`pauliZ_hasRealEntries`・`pauliYReal_hasRealEntries`（`r` は実の `2 × 2` 行列の `(p, q)` 成分） |

- 人手の `r_ℂ = ι_{ℝ→ℂ}(r)`（`inclusion_rr_to_cc`）は Lean の `(r : ℂ)` である。人手の `0_ℂ = ι(0)`・`1_ℂ = ι(1)`・`-1_ℂ = ι(-1)` の略記は、
  Lean では mathlib の `Complex.ofReal_zero`・`Complex.ofReal_one`・`Complex.ofReal_neg` で読む。
- 人手の `multiply_by_minus_one`（`-z := (-1_ℂ)·z`）は mathlib の `neg_one_mul`、`complex_numbers_form_a_field` の積の可換律・単位元は `mul_comm`・`mul_one`、
  `complex_times_zero_is_zero` は `mul_zero` で読む。`def_matrix_scalar_multiple` の段は、成分ごとに `(c • A) p q = c * A p q` が定義から成り立つことを
  `fin_cases` で 4 成分について確かめる。
- 人手が場合ごとに書く `r`（`p = q` なら `1`、`p ≠ q` なら `0` など）は、実の行列 `!![1, 0; 0, 1]` などの `(p, q)` 成分としてまとめて取る。

具体的な 2 次の行列の成分の計算なので、必要十分版は置かない（同じファイルの転置の主張と同じ）。
-/
import Ising2D.PartitionFunction.ProjectionAndJordanWigner.DefinitionTransferMatrixSymbols
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.DefinitionMatrixWithRealEntries

namespace Ising2D

open Matrix

/-- 人手 `identity_matrix_of_order_two_has_real_entries` の鎖: `I = (δ_{pq}) = !![1_ℂ, 0_ℂ; 0_ℂ, 1_ℂ] = !![ι(1), ι(0); ι(0), ι(1)]`。 -/
theorem identity_matrix_two_eq_ofReal :
    (1 : Matrix (Fin 2) (Fin 2) ℂ) = !![((1 : ℝ) : ℂ), ((0 : ℝ) : ℂ); ((0 : ℝ) : ℂ), ((1 : ℝ) : ℂ)] :=
  calc (1 : Matrix (Fin 2) (Fin 2) ℂ)
      = !![kroneckerDelta (0 : Fin 2) 0, kroneckerDelta (0 : Fin 2) 1;
          kroneckerDelta (1 : Fin 2) 0, kroneckerDelta (1 : Fin 2) 1] :=
        twoByTwo_kroneckerDelta_eq_identity.symm                      -- `def_identity_matrix`（`n = 2`）
    _ = !![(1 : ℂ), 0; 0, 1] := twoByTwo_one_eq_kroneckerDelta.symm    -- `def_kronecker_delta`
    _ = !![((1 : ℝ) : ℂ), ((0 : ℝ) : ℂ); ((0 : ℝ) : ℂ), ((1 : ℝ) : ℂ)] := by
        rw [Complex.ofReal_one, Complex.ofReal_zero]                  -- `inclusion_rr_to_cc` の略記 `1_ℂ = ι(1)`, `0_ℂ = ι(0)` を各成分へ

/-- **人手 `identity_matrix_of_order_two_has_real_entries`**: `I_{Mat(2,ℂ)}` の成分はすべて実数。 -/
theorem identity_matrix_two_hasRealEntries : MatrixHasRealEntries (1 : Matrix (Fin 2) (Fin 2) ℂ) := by
  intro p q
  refine ⟨(!![(1 : ℝ), 0; 0, 1] : Matrix (Fin 2) (Fin 2) ℝ) p q, ?_⟩
  rw [identity_matrix_two_eq_ofReal]
  fin_cases p <;> fin_cases q <;> rfl

/-- 人手 `pauli_x_has_real_entries` の鎖: `σ^x = !![0_ℂ, 1_ℂ; 1_ℂ, 0_ℂ] = !![ι(0), ι(1); ι(1), ι(0)]`。 -/
theorem pauliX_eq_ofReal :
    pauliX = !![((0 : ℝ) : ℂ), ((1 : ℝ) : ℂ); ((1 : ℝ) : ℂ), ((0 : ℝ) : ℂ)] :=
  calc pauliX
      = !![(0 : ℂ), 1; 1, 0] := rfl                                    -- `def_pauli_matrices` の `σ^x`
    _ = !![((0 : ℝ) : ℂ), ((1 : ℝ) : ℂ); ((1 : ℝ) : ℂ), ((0 : ℝ) : ℂ)] := by
        rw [Complex.ofReal_zero, Complex.ofReal_one]                  -- `inclusion_rr_to_cc` の略記 `0_ℂ = ι(0)`, `1_ℂ = ι(1)` を各成分へ

/-- **人手 `pauli_x_has_real_entries`**: `σ^x` の成分はすべて実数。 -/
theorem pauliX_hasRealEntries : MatrixHasRealEntries pauliX := by
  intro p q
  refine ⟨(!![(0 : ℝ), 1; 1, 0] : Matrix (Fin 2) (Fin 2) ℝ) p q, ?_⟩
  rw [pauliX_eq_ofReal]
  fin_cases p <;> fin_cases q <;> rfl

/-- 人手 `pauli_z_has_real_entries` の鎖: `σ^z = !![1_ℂ, 0_ℂ; 0_ℂ, -1_ℂ] = !![ι(1), ι(0); ι(0), ι(-1)]`。 -/
theorem pauliZ_eq_ofReal :
    pauliZ = !![((1 : ℝ) : ℂ), ((0 : ℝ) : ℂ); ((0 : ℝ) : ℂ), ((-1 : ℝ) : ℂ)] :=
  calc pauliZ
      = !![(1 : ℂ), 0; 0, -1] := rfl                                   -- `def_pauli_matrices` の `σ^z`
    _ = !![((1 : ℝ) : ℂ), ((0 : ℝ) : ℂ); ((0 : ℝ) : ℂ), ((-1 : ℝ) : ℂ)] := by
        rw [Complex.ofReal_one, Complex.ofReal_zero, Complex.ofReal_neg, Complex.ofReal_one]
                                                                       -- `inclusion_rr_to_cc` の略記 `1_ℂ = ι(1)`, `0_ℂ = ι(0)`, `-1_ℂ = ι(-1)` を各成分へ

/-- **人手 `pauli_z_has_real_entries`**: `σ^z` の成分はすべて実数。 -/
theorem pauliZ_hasRealEntries : MatrixHasRealEntries pauliZ := by
  intro p q
  refine ⟨(!![(1 : ℝ), 0; 0, -1] : Matrix (Fin 2) (Fin 2) ℝ) p q, ?_⟩
  rw [pauliZ_eq_ofReal]
  fin_cases p <;> fin_cases q <;> rfl

/-- **人手 `def_real_factor_of_pauli_y`**: `R^y := !![0_ℂ, -1_ℂ; 1_ℂ, 0_ℂ]`。 -/
def pauliYReal : Matrix (Fin 2) (Fin 2) ℂ := !![0, -1; 1, 0]

/-- **人手 `pauli_y_is_i_times_real_factor`**: `σ^y = iR^y`（7 行の鎖）。 -/
theorem pauliY_eq_I_smul_pauliYReal : pauliY = Complex.I • pauliYReal :=
  calc pauliY
      = !![0, -Complex.I; Complex.I, 0] := rfl                         -- `def_pauli_matrices` の `σ^y`
    _ = !![0, (-1) * Complex.I; Complex.I, 0] := by
        rw [neg_one_mul]                                               -- `multiply_by_minus_one`（`z → i`）
    _ = !![0, Complex.I * (-1); Complex.I, 0] := by
        rw [mul_comm (-1 : ℂ) Complex.I]                               -- 積の可換律（`complex_numbers_form_a_field`）
    _ = !![0, Complex.I * (-1); Complex.I * 1, 0] := by
        rw [mul_one]                                                   -- `1_ℂ` は積の単位元（`complex_numbers_form_a_field`）
    _ = !![Complex.I * 0, Complex.I * (-1); Complex.I * 1, Complex.I * 0] := by
        rw [mul_zero]                                                  -- `complex_times_zero_is_zero` を `(1,1)` 成分と `(2,2)` 成分へ同時に適用
    _ = Complex.I • !![(0 : ℂ), -1; 1, 0] := by
        ext p q
        fin_cases p <;> fin_cases q <;> rfl                            -- `def_matrix_scalar_multiple`（`m, n → 2`, `a → i`）
    _ = Complex.I • pauliYReal := rfl                                  -- `def_real_factor_of_pauli_y`

/-- 人手 `real_factor_of_pauli_y_has_real_entries` の鎖: `R^y = !![0_ℂ, -1_ℂ; 1_ℂ, 0_ℂ] = !![ι(0), ι(-1); ι(1), ι(0)]`。 -/
theorem pauliYReal_eq_ofReal :
    pauliYReal = !![((0 : ℝ) : ℂ), ((-1 : ℝ) : ℂ); ((1 : ℝ) : ℂ), ((0 : ℝ) : ℂ)] :=
  calc pauliYReal
      = !![(0 : ℂ), -1; 1, 0] := rfl                                   -- `def_real_factor_of_pauli_y`
    _ = !![((0 : ℝ) : ℂ), ((-1 : ℝ) : ℂ); ((1 : ℝ) : ℂ), ((0 : ℝ) : ℂ)] := by
        rw [Complex.ofReal_zero, Complex.ofReal_neg, Complex.ofReal_one]
                                                                       -- `inclusion_rr_to_cc` の略記 `0_ℂ = ι(0)`, `-1_ℂ = ι(-1)`, `1_ℂ = ι(1)` を各成分へ

/-- **人手 `real_factor_of_pauli_y_has_real_entries`**: `R^y` の成分はすべて実数。 -/
theorem pauliYReal_hasRealEntries : MatrixHasRealEntries pauliYReal := by
  intro p q
  refine ⟨(!![(0 : ℝ), -1; 1, 0] : Matrix (Fin 2) (Fin 2) ℝ) p q, ?_⟩
  rw [pauliYReal_eq_ofReal]
  fin_cases p <;> fin_cases q <;> rfl

end Ising2D
