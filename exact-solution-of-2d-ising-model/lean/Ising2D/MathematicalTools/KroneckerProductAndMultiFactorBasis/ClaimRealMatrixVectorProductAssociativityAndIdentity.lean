/-
# 実数の行列とベクトルの積の結合則と、実数の単位行列の左単位（具体版）

正本: `structured-latex/content/002_linear_space_general.ts`

* `linear_space_general_claim_real_matrix_vector_product_is_associative`
  （ラベル **`real_matrix_vector_product_is_associative`**）
* `linear_space_general_claim_real_identity_matrix_is_left_unit_of_real_matrix_vector_product`
  （ラベル **`real_identity_matrix_is_left_unit_of_real_matrix_vector_product`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 結合則: 10 行の鎖 `((PQ)x)_i = … = (P(Qx))_i` | `real_matrix_vector_product_is_associative` の `calc` の 10 段 |
| 結合則: 結び（`i` は任意） | 同じ定理の `funext i` |
| 左単位: `j ≠ i` の 4 行 `(r_j)_ℂ = (I_ijx_j)_ℂ = (0·x_j)_ℂ = (0)_ℂ = 0_ℂ` | `real_identity_matrix_is_left_unit_of_real_matrix_vector_product` の `hoff` の `calc` の 4 段 |
| 左単位: `j = i` の 3 行 `r_i = I_iix_i = 1·x_i = x_i` | 同じ定理の `hon` の `calc` の 3 段 |
| 左単位: 5 行 `((Ix)_i)_ℂ = … = (x_i)_ℂ` と単射性 | 同じ定理の最後の `calc` の 5 段と `inclusion_rr_to_cc_is_injective` |

- 人手の `def_real_matrix_product`・`def_real_matrix_vector_product`・`def_real_identity_matrix` は、Lean の `Matrix _ _ ℝ` の `*`・`*ᵥ`
  （成分は `dotProduct` で、人手の式と `rfl`）・`1`（成分は `Matrix.one_apply_eq`・`Matrix.one_apply_ne`）である。
- 人手の `m, n, p ∈ ℤ_{≥1}` と成分の番号は、Lean の添字の型の元である。Lean の主張は添字の型が空でも成り立つので、`Nonempty` を置かない。
- 結合則の 4 行目・8 行目の `finite_sum_of_real_scalar_multiples` は、有限型の添字の版 `finite_sum_of_real_scalar_multiples_fintype` を引く。
  7 行目の `finite_double_sum_of_real_numbers_interchange` は、有限型の添字の版 `finite_double_sum_of_real_numbers_interchange_fintype` を引く。
  乗法の交換則・結合則は `mul_comm`・`mul_assoc` である。
- 左単位の 5 行目の `finite_sum_with_single_nonzero_term` は具体版が無いので、既存の慣行どおり mathlib の `Finset.sum_eq_single` を引く
  （仮定の「`j ≠ i` のとき `0_ℂ`」は `hoff` で人手どおりに示す）。3 行目の `real_inclusion_preserves_finite_sum` は
  具体版 `real_inclusion_of_finite_sum_fintype`（`i ∈ ι` なので添字の型は空でない）、`0_ℂ = (0)_ℂ` の略記は `Complex.ofReal_zero` である。`ℝ` の `0·a = 0`・`1·a = a` は `zero_mul`・`one_mul` である。

必要十分版はまだ置いていない。具体版は人手と同じく ℝ の乗法の交換則（結合則の 3 行目・5 行目）を使うが、
結合則そのものは交換則なしで成り立つはずで、それを必要十分版で確かめるのは残した件である
（係数が ℂ の左単位には必要十分版 `NecSuf.one_mulVec_eq` がある）。
-/
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.DefinitionRealMatrixOfRealEntryMatrix
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesFiniteSum
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimFiniteSumsOfRealNumbers
import Mathlib.Data.Complex.BigOperators
import Mathlib.Data.Matrix.Mul

namespace Ising2D

open Matrix

/-- **人手 `real_matrix_vector_product_is_associative`**: `(PQ)x = P(Qx)`。 -/
theorem real_matrix_vector_product_is_associative {α β γ : Type*} [Fintype β] [Fintype γ]
    (P : Matrix α β ℝ) (Q : Matrix β γ ℝ) (x : γ → ℝ) :
    (P * Q) *ᵥ x = P *ᵥ (Q *ᵥ x) := by
  funext i
  calc ((P * Q) *ᵥ x) i
      = ∑ k, (P * Q) i k * x k := rfl                                         -- `def_real_matrix_vector_product`（`P → PQ`）
    _ = ∑ k, (∑ j, P i j * Q j k) * x k := rfl                               -- `def_real_matrix_product` を `p` 個の項へ
    _ = ∑ k, x k * (∑ j, P i j * Q j k) :=
        Finset.sum_congr rfl fun k _ => mul_comm _ _                          -- ℝ の乗法の交換則を `p` 個の項へ
    _ = ∑ k, ∑ j, x k * (P i j * Q j k) :=
        Finset.sum_congr rfl fun k _ =>
          (finite_sum_of_real_scalar_multiples_fintype (x k) (fun j => P i j * Q j k)).symm
                                                                              -- `finite_sum_of_real_scalar_multiples`（`c → x_k`）を右辺から左辺へ
    _ = ∑ k, ∑ j, (P i j * Q j k) * x k :=
        Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun j _ =>
          mul_comm _ _                                                        -- ℝ の乗法の交換則を `np` 個の項へ
    _ = ∑ k, ∑ j, P i j * (Q j k * x k) :=
        Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun j _ =>
          mul_assoc _ _ _                                                     -- ℝ の乗法の結合則を `np` 個の項へ
    _ = ∑ j, ∑ k, P i j * (Q j k * x k) :=
        finite_double_sum_of_real_numbers_interchange_fintype (fun k j => P i j * (Q j k * x k))
                                                                              -- `finite_double_sum_of_real_numbers_interchange`（`n_1 → p`、`n_2 → n`、`c_{k,l} → P_il(Q_lk x_k)`）
    _ = ∑ j, P i j * ∑ k, Q j k * x k :=
        Finset.sum_congr rfl fun j _ =>
          finite_sum_of_real_scalar_multiples_fintype (P i j) (fun k => Q j k * x k)
                                                                              -- `finite_sum_of_real_scalar_multiples`（`c → P_ij`）を `n` 個の項へ
    _ = ∑ j, P i j * (Q *ᵥ x) j := rfl                                       -- `def_real_matrix_vector_product`（`P → Q`）を右辺から左辺へ
    _ = (P *ᵥ (Q *ᵥ x)) i := rfl                                             -- `def_real_matrix_vector_product`（`x → Qx`）を右辺から左辺へ

/-- **人手 `real_identity_matrix_is_left_unit_of_real_matrix_vector_product`**: `I_{Mat(n,ℝ)}x = x`。 -/
theorem real_identity_matrix_is_left_unit_of_real_matrix_vector_product
    {ι : Type*} [Fintype ι] [DecidableEq ι] (x : ι → ℝ) :
    (1 : Matrix ι ι ℝ) *ᵥ x = x := by
  funext i
  set r : ι → ℝ := fun j => (1 : Matrix ι ι ℝ) i j * x j with hr             -- `r_j := I_ijx_j`
  have hoff : ∀ j, j ≠ i → ((r j : ℝ) : ℂ) = 0 := fun j hj =>
    calc ((r j : ℝ) : ℂ)
        = (((1 : Matrix ι ι ℝ) i j * x j : ℝ) : ℂ) := rfl                    -- `r_j := I_ijx_j`
      _ = ((0 * x j : ℝ) : ℂ) := by rw [Matrix.one_apply_ne (Ne.symm hj)]     -- `def_real_identity_matrix`（`i ≠ j`）
      _ = ((0 : ℝ) : ℂ) := by rw [zero_mul]                                   -- ℝ で `0·a = 0`
      _ = 0 := Complex.ofReal_zero                                            -- 略記 `0_ℂ = (0)_ℂ`
  have hon : r i = x i :=
    calc r i
        = (1 : Matrix ι ι ℝ) i i * x i := rfl                                 -- `r_j := I_ijx_j`（`j → i`）
      _ = 1 * x i := by rw [Matrix.one_apply_eq]                              -- `def_real_identity_matrix`（`s, t → i`）
      _ = x i := one_mul _                                                    -- `1` は ℝ の乗法の単位元
  haveI : Nonempty ι := ⟨i⟩                                                   -- `i ∈ ι` なので添字の集合は空でない
  apply inclusion_rr_to_cc_is_injective                                       -- `a → (Ix)_i`, `b → x_i`
  calc ((((1 : Matrix ι ι ℝ) *ᵥ x) i : ℝ) : ℂ)
      = ((∑ j, (1 : Matrix ι ι ℝ) i j * x j : ℝ) : ℂ) := rfl                 -- `def_real_matrix_vector_product`（`P → I`）
    _ = ((∑ j, r j : ℝ) : ℂ) := rfl                                           -- `r_j := I_ijx_j` を `n` 個の項へ
    _ = ∑ j, ((r j : ℝ) : ℂ) := (real_inclusion_of_finite_sum_fintype _).symm -- `real_inclusion_preserves_finite_sum` を右辺から左辺へ
    _ = ((r i : ℝ) : ℂ) :=
        Finset.sum_eq_single i (fun j _ hj => hoff j hj)
          (fun h => absurd (Finset.mem_univ i) h)                             -- `finite_sum_with_single_nonzero_term`（`n → i`）
    _ = ((x i : ℝ) : ℂ) := by rw [hon]                                        -- `r_i = x_i`

end Ising2D
