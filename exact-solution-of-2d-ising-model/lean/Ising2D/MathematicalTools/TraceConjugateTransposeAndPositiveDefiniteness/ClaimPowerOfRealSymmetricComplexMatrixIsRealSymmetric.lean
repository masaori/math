/-
# 実対称な複素行列の冪は実対称（具体版）

正本: `structured-latex/content/009_eigenvalues_of_V.ts`
（`eigenvalues_of_V_claim_power_of_real_symmetric_complex_matrix_is_real_symmetric`、
ラベル **`power_of_real_symmetric_complex_matrix_is_real_symmetric`**）

必要十分版: `Ising2D.NecSuf.pow_entries_mem_and_transpose_eq'`（`Ising2D/NecSuf/PowerOfSymmetricMatrixWithClosedEntries.lean`）。
具体版をその特殊化として得るのは `ClaimPowerOfRealSymmetricComplexMatrixIsRealSymmetricFromNecSuf.lean`。

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 準備 `A^1 = A^{0+1} = A^0A = IA = A` の 4 行 | `matrix_pow_one_eq_self_tensorPow` の `calc` の 4 段 |
| `p = 0`: `(I)_{kl} = δ_{kl} = {1_ℂ, 0_ℂ} = {ι(1), ι(0)}` の 3 行 | `identity_matrix_entry_cases_tensorPow` の `calc` の 2 段（1・2 行目が 1 段目にまとまる） |
| `p = 0`: 「成分はすべて実数」（`def_matrix_with_real_entries` の `r` は `k = l` なら `1`、`k ≠ l` なら `0`） | `identity_matrix_hasRealEntries_tensorPow` の場合分け |
| `p = 0`: `(I^⊤)_{kl} = I_{lk} = δ_{lk} = δ_{kl} = I_{kl}` の 4 行 | `identity_transpose_tensorPow` の `calc` の 4 段 |
| `p + 1`: 成分はすべて実数（`product_of_real_entry_matrices_has_real_entries`、`A → A^p`, `B → A`） | `power_of_real_symmetric_complex_matrix_is_real_symmetric` の `succ` の `matrix_mul_hasRealEntries` |
| `p + 1`: `((A^{p+1})^⊤)_{kl}` の 11 行 | `matrix_pow_succ_transpose_apply_tensorPow` の `calc` の 11 段 |
| `p + 1`: `k, l` は任意なので `(A^{p+1})^⊤ = A^{p+1}` | `Matrix.ext` |

- 行列は `TensorPow M`（添字 `Conf M`）で述べ、人手の `n` は `2^M` に限る。使う側（`trace_power_upper_bound` の `A → W`）が
  `TensorPow M` の行列だからである。添字が `Conf M` なので、`identity_matrix_is_left_unit_of_mat_mult` は必要十分版を
  添字 `Conf M` へ特殊化した系 `identity_matrix_mul_tensorPow` を引く（`ClaimExpOfSymmetricIsSymmetric.lean` と同じ扱い）。
- 人手の `p = 0` の 1・2 行目（`def_identity_matrix` と `def_kronecker_delta`）は、mathlib の単位行列の成分 `Matrix.one_apply` が
  `if k = l then 1 else 0` を返すので、Lean では 1 段にまとまる（`ClaimRealMatrixOfRealEntryMatrixPreservesProductAndPower.lean` と同じ扱い）。
- `def_exp` (1) の冪 `A^0 := I`・`A^{m+1} := A^mA` は mathlib の `pow_zero`・`pow_succ` と同じ形である。
  `mat_mult` は mathlib の行列の積の定義（成分は `dotProduct`）で `rfl`、`def_matrix_transpose` は `Aᵀ k l = A l k` が `rfl` である。
  `complex_numbers_form_a_field` の乗法の可換則は mathlib の `mul_comm`（`ℂ`）である。
-/
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.DefinitionRealSymmetricComplexMatrix
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimExpOfSymmetricIsSymmetric
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimProductOfRealEntryMatricesHasRealEntries
import Ising2D.MathematicalTools.MatrixExponentialAndCommutators.ClaimMatrixPowerExponentLaw

namespace Ising2D

open Matrix

variable {M : ℕ}

/-- 人手 準備 `A^1 = A`（4 行）。 -/
theorem matrix_pow_one_eq_self_tensorPow (A : TensorPow M) : A ^ 1 = A :=
  calc A ^ 1
      = A ^ (0 + 1) := rfl                                                  -- `ℤ` で `1 = 0 + 1`
    _ = A ^ 0 * A := pow_succ A 0                                           -- `def_exp` (1) の `A^{m+1} := A^mA`（`m → 0`）
    _ = 1 * A := by rw [pow_zero]                                           -- `def_exp` (1) の `A^0 := I`
    _ = A := identity_matrix_mul_tensorPow A                                -- `identity_matrix_is_left_unit_of_mat_mult`

/-- 人手 `p = 0` の成分の 3 行 `(I)_{kl} = δ_{kl} = {1_ℂ, 0_ℂ} = {ι(1), ι(0)}`。 -/
theorem identity_matrix_entry_cases_tensorPow (k l : Conf M) :
    (1 : TensorPow M) k l = if k = l then ((1 : ℝ) : ℂ) else ((0 : ℝ) : ℂ) :=
  calc (1 : TensorPow M) k l
      = if k = l then (1 : ℂ) else 0 := Matrix.one_apply                    -- `def_identity_matrix` と `def_kronecker_delta`
    _ = if k = l then ((1 : ℝ) : ℂ) else ((0 : ℝ) : ℂ) := by
        rw [Complex.ofReal_one, Complex.ofReal_zero]                        -- 略記 `1_ℂ = ι(1)`、`0_ℂ = ι(0)`

/-- 人手 `p = 0`: `I` の成分はすべて実数（`def_matrix_with_real_entries`。`r` は `k = l` なら `1`、`k ≠ l` なら `0`）。 -/
theorem identity_matrix_hasRealEntries_tensorPow : MatrixHasRealEntries (1 : TensorPow M) := by
  intro k l
  rw [identity_matrix_entry_cases_tensorPow]                                -- 上の 3 行
  split_ifs
  · exact ⟨1, rfl⟩                                                          -- `k = l`: `r := 1`
  · exact ⟨0, rfl⟩                                                          -- `k ≠ l`: `r := 0`

/-- 人手 `p = 0`: `A^0 = I` は実対称（成分の 3 行と `(I^⊤)_{kl}` の 4 行）。 -/
theorem identity_matrix_isRealSymmetric_tensorPow : MatrixIsRealSymmetric (1 : TensorPow M) :=
  ⟨identity_matrix_hasRealEntries_tensorPow, identity_transpose_tensorPow⟩

/-- 人手 `p + 1` の `((A^{p+1})^⊤)_{kl}` の 11 行。 -/
theorem matrix_pow_succ_transpose_apply_tensorPow (A : TensorPow M) (hAT : Aᵀ = A) (p : ℕ)
    (ih : (A ^ p)ᵀ = A ^ p) (k l : Conf M) :
    (A ^ (p + 1))ᵀ k l = (A ^ (p + 1)) k l :=
  calc (A ^ (p + 1))ᵀ k l
      = (A ^ (p + 1)) l k := rfl                                            -- `def_matrix_transpose`
    _ = (A ^ p * A) l k := by rw [pow_succ]                                 -- `def_exp` (1) の `A^{m+1} := A^mA`（`m → p`）
    _ = ∑ j, (A ^ p) l j * A j k := rfl                                     -- `mat_mult`
    _ = ∑ j, (A ^ p)ᵀ j l * Aᵀ k j := rfl                                   -- `def_matrix_transpose` を 2 箇所へ同時に適用
    _ = ∑ j, (A ^ p) j l * Aᵀ k j := by rw [ih]                             -- 帰納法の仮定の `(A^p)^⊤ = A^p`
    _ = ∑ j, (A ^ p) j l * A k j := by rw [hAT]                             -- 仮定の `A^⊤ = A`
    _ = ∑ j, A k j * (A ^ p) j l :=
        Finset.sum_congr rfl fun j _ => mul_comm _ _                        -- `complex_numbers_form_a_field` の乗法の可換則
    _ = (A * A ^ p) k l := rfl                                              -- `mat_mult`
    _ = (A ^ 1 * A ^ p) k l := by rw [matrix_pow_one_eq_self_tensorPow A]   -- 準備の `A^1 = A`
    _ = (A ^ (1 + p)) k l := by rw [matrix_power_exponent_law A 1 p]        -- `matrix_power_exponent_law`（`p → 1`, `q → p`）
    _ = (A ^ (p + 1)) k l := by rw [Nat.add_comm 1 p]                       -- `ℤ` の加法の可換則

/-- **人手 `power_of_real_symmetric_complex_matrix_is_real_symmetric`**: 実対称な `A` について、すべての `p` で `A^p` は実対称
（`p` についての帰納法）。 -/
theorem power_of_real_symmetric_complex_matrix_is_real_symmetric (A : TensorPow M)
    (hA : MatrixIsRealSymmetric A) : ∀ p : ℕ, MatrixIsRealSymmetric (A ^ p)
  | 0 => by
      rw [pow_zero]                                                         -- `def_exp` (1) の `A^0 := I`
      exact identity_matrix_isRealSymmetric_tensorPow
  | p + 1 => by
      have ih := power_of_real_symmetric_complex_matrix_is_real_symmetric A hA p  -- 帰納法の仮定（`A^p` は実対称）
      refine ⟨?_, ?_⟩
      · rw [pow_succ]                                                       -- `def_exp` (1) の `A^{p+1} = A^pA`
        exact matrix_mul_hasRealEntries _ _ ih.1 hA.1                       -- `product_of_real_entry_matrices_has_real_entries`（`A → A^p`, `B → A`）
      · exact Matrix.ext (matrix_pow_succ_transpose_apply_tensorPow A hA.2 p ih.2)
                                                                            -- 転置は 11 行の鎖、`k, l` は任意

end Ising2D
