/-
# 共役転置の積・線型結合の法則と、共役転置は行列のノルムと行列の列の極限を保つこと（**具体版**）

対応する人手証明のラベル: `star_preserves_norm_and_limits`
（`structured-latex/content/009_eigenvalues_of_V.ts` の `eigenvalues_of_V_012_claim_star_is_norm_preserving`）。

**必要十分版**: `Ising2D/NecSuf/StarPreservesNormAndLimits.lean`。具体版をその特殊化として導き、`TensorPow M` の系を置くのは
`ClaimStarPreservesNormAndLimitsFromNecSuf.lean`。

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| (1) の第 1 式の `(k, l)` 成分の鎖の 7 行（共役転置の定義 → `mat_mult` → `complex_conjugate_of_sum` の `m = n` → `complex_conjugate_of_product` を各項へ → 積の可換性を各項へ → 共役転置の定義を各項へ → `mat_mult`） | `matrix_conjTranspose_mul_apply` の `calc` の 7 段 |
| (1) の第 1 式の「すべての成分が等しい」 | `matrix_conjTranspose_mul`（`Matrix.ext`） |
| (1) の第 2 式の成分の鎖の 8 行（共役転置の定義 → `def_matrix_sum` → `def_matrix_scalar_multiple` → `complex_conjugate_of_sum` の `m = 2` → `complex_conjugate_of_product` を各項へ → 共役転置の定義を各項へ → `def_matrix_scalar_multiple` → `def_matrix_sum`） | `matrix_conjTranspose_add_smul_apply` の `calc` の 8 段 |
| (1) の第 2 式の「すべての成分が等しい」 | `matrix_conjTranspose_add_smul`（`Matrix.ext`） |
| (2) の 5 行（`def_matrix_norm` → 共役転置の定義を各項へ → `abs_of_complex_conjugate` を各項へ → `ℝ` の有限和の順序の入れ替え → `def_matrix_norm`） | `matrix_conjTranspose_norm` の `calc` の 5 段 |
| (3) の準備の成分の鎖の 5 行（`def_matrix_difference` → 共役転置の定義を各項へ → `complex_conjugate_of_difference` → `def_matrix_difference` → 共役転置の定義） | `matrix_conjTranspose_sub_apply` の `calc` の 5 段 |
| (3) の準備の「`A_N^* − A^* = (A_N − A)^*`」 | `matrix_conjTranspose_sub`（`Matrix.ext`） |
| (3) の各 `N` の 2 行（準備 → (2) の `A → A_N − A`）と、「2 つの実数列はすべての項が等しく、仮定より `‖A_N^* − A^*‖ → 0`」 | `matrix_conjTranspose_tendsto` の中の `heq` の `calc` の 2 段と、最後の段（`funext heq` で列を書き換えて仮定を使う） |

* 共役転置（`def_hermitian_positive_definite`）は mathlib の `Matrix.conjTranspose`（`Aᴴ k l = star (A l k)` が定義から `rfl`）である
  （`ClaimRealMultipleOfHermitianIsHermitian.lean` と同じ）。積・和・スカラー倍・差の成分は `mat_mult`・`def_matrix_sum`・
  `def_matrix_scalar_multiple`・`def_matrix_difference` の具体版 `matrix_mul_apply_sum`・`matrix_sum_apply`・`matrix_smul_apply`・`matrix_sub_apply` を引く。
* 複素共役の性質 `complex_conjugate_of_sum`・`complex_conjugate_of_product`・`complex_conjugate_of_difference`・`abs_of_complex_conjugate`
  （`structured-latex/content/005_exp_conjugation_proof.ts`）のうち前の 3 つの具体版は
  `MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimComplexConjugateOfSumProductDifference.lean` にあるが `starRingEnd ℂ` の形で、有限和の添字が `Fin (m + 1)` である。
  このファイルは `star` の形で添字が `Fin n` なので、まだ mathlib の `star_sum`・`star_add`（`m = 2`）・
  `star_mul'`・`star_sub`・`norm_star` を引く（`ClaimCongruencePreservesPositiveDefinite.lean` と同じ扱い。差し替えは状態台帳の残り。`abs_of_complex_conjugate` は具体版が無い）。
  `ℂ` の積の可換性（`complex_numbers_form_a_field`）は `mul_comm`、`ℝ` の有限和の順序の入れ替えは本文に主張が無く `Finset.sum_comm` を引く
  （`ClaimTransposePreservesMatrixNormAndLimits.lean` と同じ扱い）。
* ノルムは mathlib の Frobenius ノルム（`Matrix.frobenius_norm_def`）で、`def_matrix_norm` の行列ノルムと値が一致する。
  `|z|` は `ℂ` のノルム `‖z‖` である。(2)(3) で `ℝ` へ脱出する（人手の主張に書いてある）。
* 人手の `n ∈ ℤ_{≥1}` に対し、Lean は `ℕ` で `0` も許す（成分が無いか和が空なだけで、主張はそのまま成り立つ）。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimAddAndSubtractZeroMatrix
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityAndScalarMultipleInMatrixProduct
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityScalarMultipleAndDifferenceOnVectors
import Mathlib.Algebra.Star.BigOperators
import Mathlib.Analysis.Matrix.Normed
import Mathlib.Analysis.Complex.Basic

namespace Ising2D

open Matrix Filter Topology

attribute [local instance] Matrix.frobeniusNormedAddCommGroup

/-- **`star_preserves_norm_and_limits` (1) の第 1 式**の成分の鎖: `((AB)^*)_{kl} = (B^*A^*)_{kl}`（人手の 7 行）。
必要十分版は `NecSuf.conjTranspose_mul_matrix_apply'`（同じ段の並び）。 -/
theorem matrix_conjTranspose_mul_apply {n : ℕ} (A B : Matrix (Fin n) (Fin n) ℂ) (k l : Fin n) :
    (A * B)ᴴ k l = (Bᴴ * Aᴴ) k l :=
  calc (A * B)ᴴ k l
      = star ((A * B) l k) := rfl                                             -- `def_hermitian_positive_definite`
    _ = star (∑ j, A l j * B j k) := by rw [matrix_mul_apply_sum]             -- `mat_mult`
    _ = ∑ j, star (A l j * B j k) := star_sum _ _                             -- `complex_conjugate_of_sum` の `m = n`
    _ = ∑ j, star (A l j) * star (B j k) := by
        simp only [star_mul']                                                 -- `complex_conjugate_of_product` を各項へ
    _ = ∑ j, star (B j k) * star (A l j) :=
        Finset.sum_congr rfl fun _ _ => mul_comm _ _                          -- 積の可換性を各項へ（`complex_numbers_form_a_field`）
    _ = ∑ j, Bᴴ k j * Aᴴ j l := rfl                                           -- `def_hermitian_positive_definite` を各項へ
    _ = (Bᴴ * Aᴴ) k l := (matrix_mul_apply_sum _ _ _ _).symm                  -- `mat_mult`

/-- **`star_preserves_norm_and_limits` (1) の第 1 式**: `(AB)^* = B^*A^*`。 -/
theorem matrix_conjTranspose_mul {n : ℕ} (A B : Matrix (Fin n) (Fin n) ℂ) : (A * B)ᴴ = Bᴴ * Aᴴ :=
  Matrix.ext (matrix_conjTranspose_mul_apply A B)   -- すべての成分が等しい

/-- **`star_preserves_norm_and_limits` (1) の第 2 式**の成分の鎖:
`((αA + βB)^*)_{kl} = (\overline{α}A^* + \overline{β}B^*)_{kl}`（人手の 8 行）。
必要十分版は `NecSuf.conjTranspose_add_smul_matrix_apply'`（同じ段の並び）。 -/
theorem matrix_conjTranspose_add_smul_apply {n : ℕ} (α β : ℂ) (A B : Matrix (Fin n) (Fin n) ℂ) (k l : Fin n) :
    (α • A + β • B)ᴴ k l = (star α • Aᴴ + star β • Bᴴ) k l :=
  calc (α • A + β • B)ᴴ k l
      = star ((α • A + β • B) l k) := rfl                                     -- `def_hermitian_positive_definite`
    _ = star ((α • A) l k + (β • B) l k) := by rw [matrix_sum_apply]          -- `def_matrix_sum`
    _ = star (α * A l k + β * B l k) := by
        rw [matrix_smul_apply, matrix_smul_apply]                             -- `def_matrix_scalar_multiple`（2 項へ同時に）
    _ = star (α * A l k) + star (β * B l k) := star_add _ _                   -- `complex_conjugate_of_sum` の `m = 2`
    _ = star α * star (A l k) + star β * star (B l k) := by
        rw [star_mul', star_mul']                                             -- `complex_conjugate_of_product` を各項へ
    _ = star α * Aᴴ k l + star β * Bᴴ k l := rfl                              -- `def_hermitian_positive_definite` を各項へ
    _ = (star α • Aᴴ) k l + (star β • Bᴴ) k l := by
        rw [matrix_smul_apply, matrix_smul_apply]                             -- `def_matrix_scalar_multiple`（2 項へ同時に）
    _ = (star α • Aᴴ + star β • Bᴴ) k l := (matrix_sum_apply _ _ _ _).symm    -- `def_matrix_sum`

/-- **`star_preserves_norm_and_limits` (1) の第 2 式**: `(αA + βB)^* = \overline{α}A^* + \overline{β}B^*`。 -/
theorem matrix_conjTranspose_add_smul {n : ℕ} (α β : ℂ) (A B : Matrix (Fin n) (Fin n) ℂ) :
    (α • A + β • B)ᴴ = star α • Aᴴ + star β • Bᴴ :=
  Matrix.ext (matrix_conjTranspose_add_smul_apply α β A B)   -- すべての成分が等しい

/-- **`star_preserves_norm_and_limits` (2)**: `‖A^*‖ = ‖A‖`（人手の 5 行）。必要十分版は `NecSuf.conjTranspose_norm'`（同じ段の並び）。 -/
theorem matrix_conjTranspose_norm {n : ℕ} (A : Matrix (Fin n) (Fin n) ℂ) : ‖Aᴴ‖ = ‖A‖ :=
  calc ‖Aᴴ‖
      = (∑ k, ∑ l, ‖Aᴴ k l‖ ^ (2 : ℝ)) ^ (1 / 2 : ℝ) :=
        Matrix.frobenius_norm_def _                                           -- `def_matrix_norm`（`A → A^*`）
    _ = (∑ k, ∑ l, ‖star (A l k)‖ ^ (2 : ℝ)) ^ (1 / 2 : ℝ) := rfl             -- `def_hermitian_positive_definite` を各項へ
    _ = (∑ k, ∑ l, ‖A l k‖ ^ (2 : ℝ)) ^ (1 / 2 : ℝ) := by
        simp only [norm_star]                                                 -- `abs_of_complex_conjugate` を各項へ
    _ = (∑ l, ∑ k, ‖A l k‖ ^ (2 : ℝ)) ^ (1 / 2 : ℝ) := by
        rw [Finset.sum_comm]                                                  -- `ℝ` の有限和の順序の入れ替え
    _ = ‖A‖ := (Matrix.frobenius_norm_def A).symm                             -- `def_matrix_norm` の `i = l`, `j = k`

/-- **`star_preserves_norm_and_limits` (3) の準備**の成分の鎖: `(A_N^* − A^*)_{kl} = ((A_N − A)^*)_{kl}`（人手の 5 行）。
必要十分版は `NecSuf.conjTranspose_sub_matrix_apply'`（同じ段の並び）。 -/
theorem matrix_conjTranspose_sub_apply {n : ℕ} (AN A : Matrix (Fin n) (Fin n) ℂ) (k l : Fin n) :
    (ANᴴ - Aᴴ) k l = (AN - A)ᴴ k l :=
  calc (ANᴴ - Aᴴ) k l
      = ANᴴ k l - Aᴴ k l := matrix_sub_apply _ _ _ _                          -- `def_matrix_difference`
    _ = star (AN l k) - star (A l k) := rfl                                   -- `def_hermitian_positive_definite` を各項へ
    _ = star (AN l k - A l k) := (star_sub _ _).symm                          -- `complex_conjugate_of_difference`
    _ = star ((AN - A) l k) := by rw [matrix_sub_apply]                       -- `def_matrix_difference`
    _ = (AN - A)ᴴ k l := rfl                                                  -- `def_hermitian_positive_definite`

/-- **`star_preserves_norm_and_limits` (3) の準備**: `A_N^* − A^* = (A_N − A)^*`。 -/
theorem matrix_conjTranspose_sub {n : ℕ} (AN A : Matrix (Fin n) (Fin n) ℂ) : ANᴴ - Aᴴ = (AN - A)ᴴ :=
  Matrix.ext (matrix_conjTranspose_sub_apply AN A)   -- すべての成分が等しい

/-- **`star_preserves_norm_and_limits` (3)**: `‖A_N − A‖ → 0` なら `‖A_N^* − A^*‖ → 0`。
必要十分版は `NecSuf.conjTranspose_tendsto'`（同じ段の並び）。 -/
theorem matrix_conjTranspose_tendsto {n : ℕ} (A : ℕ → Matrix (Fin n) (Fin n) ℂ) (Alim : Matrix (Fin n) (Fin n) ℂ)
    (h : Tendsto (fun N => ‖A N - Alim‖) atTop (𝓝 0)) :
    Tendsto (fun N => ‖(A N)ᴴ - Alimᴴ‖) atTop (𝓝 0) := by
  have heq : ∀ N, ‖(A N)ᴴ - Alimᴴ‖ = ‖A N - Alim‖ := fun N =>
    calc ‖(A N)ᴴ - Alimᴴ‖
        = ‖(A N - Alim)ᴴ‖ := by rw [matrix_conjTranspose_sub]                 -- 準備の `A_N^* − A^* = (A_N − A)^*`
      _ = ‖A N - Alim‖ := matrix_conjTranspose_norm _                         -- (2) の `A → A_N − A`
  -- 2 つの実数列はすべての項が等しいので、仮定の収束がそのまま使える
  rw [funext heq]
  exact h

end Ising2D
