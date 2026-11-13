/-
# 一つを除く項が零行列である行列の有限和は、その一つの項に等しい（具体版）

正本: `structured-latex/content/002_linear_space_general.ts`
（`linear_space_general_claim_finite_sum_of_matrices_with_single_nonzero_term`、ラベル **`finite_sum_of_matrices_with_single_nonzero_term`**）

**必要十分版**: `Ising2D/NecSuf/FiniteSumWithSingleNonzeroTerm.lean` の `NecSuf.finSumLeft_matrix_single'`。
具体版をその系として導くのは、同じフォルダの `ClaimFiniteSumOfMatricesWithSingleNonzeroTermFromNecSuf.lean`。

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 前置き「`a ≠ q` なら `(X_a)_{ik} = O_{ik} = 0_ℂ`（`def_zero_matrix`）」 | `finite_sum_of_matrices_with_single_nonzero_term_apply` の `hzero` |
| 成分の鎖の 2 行（`finite_sum_of_matrices_entrywise` → `finite_sum_with_single_nonzero_term`） | `finite_sum_of_matrices_with_single_nonzero_term_apply` の `calc` の 2 段 |
| 「全ての成分が一致し、主張を得る」 | `finite_sum_of_matrices_with_single_nonzero_term`（`Matrix.ext`） |

- 人手の `X_1, …, X_r ∈ Mat(m, n, ℂ)` は Lean の `X : κ → Matrix α β ℂ`、`q ∈ {1, …, r}` は `q : κ` である。
  和の添字 `{1, …, r}` を有限型 `κ` で受けるので、`κ := Fin r` で人手の主張そのもの、`κ := Fin M → Fin 4` で Step 6 の
  多重添字の和に当てられる（成分の鎖の 2 段目は `finite_sum_with_single_nonzero_term_fintype` で、番号付けの埋め合わせはそこにある）。
  人手の行と列の添字 `{1, …, m}`・`{1, …, n}` は任意の型 `α`・`β` で受ける（成分を読むだけで、行と列の添字の有限性は使わない。
  `TensorPow M` の `Conf M` にもそのまま当たる）。
- `finite_sum_of_matrices_entrywise` は mathlib の `Matrix.sum_apply`（`ClaimKroneckerFamilyOfIndependentFamilyIsIndependent.lean` と同じ）、
  `def_zero_matrix` の `O_{ik} = 0_ℂ` は `Matrix.zero_apply`（`matrix_zero_apply` と同じく定義そのもの）である。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimFiniteSumWithSingleNonzeroTerm
import Mathlib.Data.Matrix.Basic

namespace Ising2D

open Matrix

/-- **`finite_sum_of_matrices_with_single_nonzero_term`** の成分の鎖: `(Σ_a X_a)_{ik} = (X_q)_{ik}`。 -/
theorem finite_sum_of_matrices_with_single_nonzero_term_apply {κ α β : Type*} [Fintype κ]
    (X : κ → Matrix α β ℂ) (q : κ) (hX : ∀ a, a ≠ q → X a = 0) (i : α) (k : β) :
    (∑ a, X a) i k = X q i k := by
  have hzero : ∀ a, a ≠ q → X a i k = 0 := fun a ha => by
    rw [hX a ha]; exact Matrix.zero_apply i k                                     -- `(X_a)_{ik} = O_{ik} = 0_ℂ`（`def_zero_matrix`）
  calc (∑ a, X a) i k
      = ∑ a, X a i k := Matrix.sum_apply i k Finset.univ X                       -- `finite_sum_of_matrices_entrywise`
    _ = X q i k :=
        finite_sum_with_single_nonzero_term_fintype (fun a => X a i k) q hzero    -- `finite_sum_with_single_nonzero_term`（`m → r`、`z_a → (X_a)_{ik}`、`n → q`）

/-- **人手 `finite_sum_of_matrices_with_single_nonzero_term`**: `a ≠ q` のすべての `a` で `X_a = O` なら `Σ_a X_a = X_q`。 -/
theorem finite_sum_of_matrices_with_single_nonzero_term {κ α β : Type*} [Fintype κ]
    (X : κ → Matrix α β ℂ) (q : κ) (hX : ∀ a, a ≠ q → X a = 0) :
    ∑ a, X a = X q :=
  Matrix.ext (finite_sum_of_matrices_with_single_nonzero_term_apply X q hX)      -- 全ての成分が一致する

end Ising2D
