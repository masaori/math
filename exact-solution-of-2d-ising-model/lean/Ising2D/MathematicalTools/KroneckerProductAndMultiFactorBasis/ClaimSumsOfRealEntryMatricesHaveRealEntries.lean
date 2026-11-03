/-
# 成分がすべて実数の行列の和・差・有限和は成分がすべて実数（具体版）

正本: `structured-latex/content/002_linear_space_general.ts`
（`linear_space_general_claim_sum_of_real_entry_matrices_has_real_entries`、ラベル **`sum_of_real_entry_matrices_has_real_entries`**、
`linear_space_general_claim_difference_of_real_entry_matrices_has_real_entries`、ラベル **`difference_of_real_entry_matrices_has_real_entries`**、
`linear_space_general_claim_finite_sum_of_real_entry_matrices_has_real_entries`、ラベル **`finite_sum_of_real_entry_matrices_has_real_entries`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| `sum_of_real_entry_matrices_has_real_entries` の準備: 任意の `p, q` と、仮定から `A_{pq} = s_ℂ`・`B_{pq} = t_ℂ` を満たす `s, t` | `intro p q` と `hA p q`・`hB p q` の `obtain` |
| 同じ主張の成分の鎖の 6 行（`def_matrix_sum` → `s, t` の取り方 → `inclusion_rr_to_cc` を 2 箇所 → `definition_of_cc` の和 → ℝ で `0 + 0 = 0` → `inclusion_rr_to_cc`） | `matrix_add_hasRealEntries` の `calc` の 6 段 |
| 同じ主張の `r := s + t` と取れば `def_matrix_with_real_entries` の条件が成り立つ | `refine ⟨s + t, ?_⟩` |
| `difference_of_real_entry_matrices_has_real_entries` の鎖の 3 行（`matrix_difference_is_sum_with_negation` → `negation_is_scalar_multiple_by_minus_one` → `inclusion_rr_to_cc` の略記 `-1_ℂ = ι(-1)`） | `matrix_sub_eq_add_real_neg_one_smul` の `calc` の 3 段（添字 `Fin m`）と `sub_eq_add_real_neg_one_smul_tensorPow`（添字 `Conf M`） |
| 同じ主張の段落（`real_scalar_multiple_of_real_entry_matrix_has_real_entries`（`c → -1`） → `sum_of_real_entry_matrices_has_real_entries`（`B → (-1)_ℂB`） → 上の鎖） | `matrix_sub_hasRealEntries`・`sub_hasRealEntries_tensorPow` の 3 行 |
| `finite_sum_of_real_entry_matrices_has_real_entries` の `r = 1`（`def_finite_sum_of_matrices` と仮定）と、帰納法の段（`def_finite_sum_of_matrices` → 帰納法の仮定と仮定 → `sum_of_real_entry_matrices_has_real_entries`） | `finite_sum_hasRealEntries` の `0` の場合と `r + 1` の場合 |

- 人手の `m, n ∈ ℤ_{≥1}` と成分の番号は、和と有限和では Lean の行と列の添字の型 `α`・`β` の元である
  （`MatrixHasRealEntries`・`real_smul_hasRealEntries` と同じ。`TensorPow M` の行列にもそのまま使う）。
  `def_matrix_sum` の段 `(A + B) p q = A p q + B p q` は mathlib の行列の和の定義で `rfl` である。
- 差の鎖が引く `matrix_difference_is_sum_with_negation`・`negation_is_scalar_multiple_by_minus_one` の Lean の具体版は添字 `Fin m` の行列について
  述べてある（`matrix_sub_eq_add_neg`・`neg_eq_neg_one_smul_matrix`）。そこで差の主張は、添字 `Fin m` の具体版 `matrix_sub_hasRealEntries` と、
  同じ鎖を `TensorPow M` の系 `sub_eq_add_neg_tensorPow`・`neg_eq_neg_one_smul_tensorPow` で辿る `sub_hasRealEntries_tensorPow` の 2 本に置く
  （`iH_is_real_symmetric` の Step 3 は後者を使う）。
- 人手の `(s, 0)`（`inclusion_rr_to_cc`）は Lean の `(⟨s, 0⟩ : ℂ)` で、`(s : ℂ)` とは定義で一致する（`rfl`）。
  `definition_of_cc` の和の段 `⟨s, 0⟩ + ⟨t, 0⟩ = ⟨s + t, 0 + 0⟩` も mathlib の `ℂ` の和の定義で `rfl` である。
- 有限和は `Fin (r + 1)` の上の和で、人手の `r ∈ ℤ_{≥1}` が Lean の `r + 1` に当たる（`finite_sum_transpose_of_matrices` と同じ）。
  `def_finite_sum_of_matrices` の 2 つの式は `Fin.sum_univ_one`・`Fin.sum_univ_castSucc` で出す。

必要十分版は `Ising2D/NecSuf/SumsOfClosedEntries.lean`、具体版をその特殊化として得るのは
`ClaimSumsOfRealEntryMatricesFromNecSuf.lean` である。
-/
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealScalarMultipleOfRealEntryMatrixHasRealEntries
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimMatrixDifferenceIsSumWithNegationFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimNegationIsScalarMultipleByMinusOneFromNecSuf
import Mathlib.Algebra.BigOperators.Fin

namespace Ising2D

/-- **人手 `sum_of_real_entry_matrices_has_real_entries`**: `A`・`B` の成分がすべて実数なら、`A + B` の成分もすべて実数。 -/
theorem matrix_add_hasRealEntries {α β : Type*} (A B : Matrix α β ℂ)
    (hA : MatrixHasRealEntries A) (hB : MatrixHasRealEntries B) : MatrixHasRealEntries (A + B) := by
  intro p q
  obtain ⟨s, hs⟩ := hA p q                                                  -- 仮定（`def_matrix_with_real_entries`）から `s`
  obtain ⟨t, ht⟩ := hB p q                                                  -- 仮定（`def_matrix_with_real_entries`）から `t`
  refine ⟨s + t, ?_⟩                                                        -- `r := s + t`
  calc (A + B) p q
      = A p q + B p q := rfl                                                -- `def_matrix_sum`（`i → p`, `j → q`）
    _ = (s : ℂ) + (t : ℂ) := by rw [hs, ht]                                 -- `s, t` の取り方
    _ = (⟨s, 0⟩ : ℂ) + ⟨t, 0⟩ := rfl                                        -- `inclusion_rr_to_cc` を 2 箇所へ同時に適用
    _ = ⟨s + t, 0 + 0⟩ := rfl                                               -- `definition_of_cc` の和
    _ = ⟨s + t, 0⟩ := by rw [add_zero (0 : ℝ)]                              -- ℝ で `0 + 0 = 0`
    _ = ((s + t : ℝ) : ℂ) := rfl                                            -- `inclusion_rr_to_cc`

/-- **人手 `difference_of_real_entry_matrices_has_real_entries` の鎖**（添字 `Fin m`）: `A - B = A + (-1)_ℂB`。 -/
theorem matrix_sub_eq_add_real_neg_one_smul {m n : ℕ} (A B : Matrix (Fin m) (Fin n) ℂ) :
    A - B = A + (((-1 : ℝ) : ℂ) • B) :=
  calc A - B
      = A + (-B) := matrix_sub_eq_add_neg A B                               -- `matrix_difference_is_sum_with_negation`
    _ = A + ((-1 : ℂ) • B) := by rw [neg_eq_neg_one_smul_matrix B]          -- `negation_is_scalar_multiple_by_minus_one`（`A → B`）
    _ = A + (((-1 : ℝ) : ℂ) • B) := by
        rw [Complex.ofReal_neg, Complex.ofReal_one]                         -- `inclusion_rr_to_cc` の略記 `-1_ℂ = ι(-1)`

/-- **人手 `difference_of_real_entry_matrices_has_real_entries`**（添字 `Fin m`）: `A`・`B` の成分がすべて実数なら、`A - B` の成分もすべて実数。 -/
theorem matrix_sub_hasRealEntries {m n : ℕ} (A B : Matrix (Fin m) (Fin n) ℂ)
    (hA : MatrixHasRealEntries A) (hB : MatrixHasRealEntries B) : MatrixHasRealEntries (A - B) := by
  have hnB := real_smul_hasRealEntries (-1) B hB          -- `real_scalar_multiple_of_real_entry_matrix_has_real_entries`（`c → -1`）
  have hsum := matrix_add_hasRealEntries A _ hA hnB       -- `sum_of_real_entry_matrices_has_real_entries`（`B → (-1)_ℂB`）
  rw [matrix_sub_eq_add_real_neg_one_smul A B]            -- 上の鎖
  exact hsum

/-- **人手 `difference_of_real_entry_matrices_has_real_entries` の鎖**（`TensorPow M`）: `A - B = A + (-1)_ℂB`。 -/
theorem sub_eq_add_real_neg_one_smul_tensorPow {M : ℕ} (A B : TensorPow M) :
    A - B = A + (((-1 : ℝ) : ℂ) • B) :=
  calc A - B
      = A + (-B) := sub_eq_add_neg_tensorPow A B                            -- `matrix_difference_is_sum_with_negation`（`TensorPow M` の系）
    _ = A + ((-1 : ℂ) • B) := by rw [neg_eq_neg_one_smul_tensorPow B]       -- `negation_is_scalar_multiple_by_minus_one`（`TensorPow M` の系。`A → B`）
    _ = A + (((-1 : ℝ) : ℂ) • B) := by
        rw [Complex.ofReal_neg, Complex.ofReal_one]                         -- `inclusion_rr_to_cc` の略記 `-1_ℂ = ι(-1)`

/-- **人手 `difference_of_real_entry_matrices_has_real_entries`**（`TensorPow M`）: `A`・`B` の成分がすべて実数なら、`A - B` の成分もすべて実数。 -/
theorem sub_hasRealEntries_tensorPow {M : ℕ} (A B : TensorPow M)
    (hA : MatrixHasRealEntries A) (hB : MatrixHasRealEntries B) : MatrixHasRealEntries (A - B) := by
  have hnB := real_smul_hasRealEntries (-1) B hB          -- `real_scalar_multiple_of_real_entry_matrix_has_real_entries`（`c → -1`）
  have hsum := matrix_add_hasRealEntries A _ hA hnB       -- `sum_of_real_entry_matrices_has_real_entries`（`B → (-1)_ℂB`）
  rw [sub_eq_add_real_neg_one_smul_tensorPow A B]         -- 上の鎖
  exact hsum

/-- **人手 `finite_sum_of_real_entry_matrices_has_real_entries`**: `X_1, …, X_{r+1}` の成分がすべて実数なら、
`Σ_{j=1}^{r+1} X_j` の成分もすべて実数（人手の `r` は Lean の `r + 1`）。`r` についての帰納法。 -/
theorem finite_sum_hasRealEntries {α β : Type*} :
    ∀ (r : ℕ) (X : Fin (r + 1) → Matrix α β ℂ), (∀ j, MatrixHasRealEntries (X j)) →
      MatrixHasRealEntries (∑ j, X j)
  | 0, X, hX => by
    rw [Fin.sum_univ_one]                                 -- `def_finite_sum_of_matrices`（`Σ_{j=1}^{1} X_j = X_1`）
    exact hX 0                                            -- 仮定
  | r + 1, X, hX => by
    rw [Fin.sum_univ_castSucc X]                          -- `def_finite_sum_of_matrices`（`Σ_{j=1}^{r+1} X_j = (Σ_{j=1}^{r} X_j) + X_{r+1}`）
    exact matrix_add_hasRealEntries _ _
      (finite_sum_hasRealEntries r (fun j => X j.castSucc) fun j => hX j.castSucc)  -- 帰納法の仮定
      (hX (Fin.last _))                                   -- 仮定。`sum_of_real_entry_matrices_has_real_entries`（`A → Σ_{j=1}^{r} X_j`, `B → X_{r+1}`）

end Ising2D
