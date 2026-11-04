/-
# 実数の二項の和の有限積の展開（**具体版**）

正本: `structured-latex/content/002_linear_space_general.ts`
（`linear_space_general_claim_real_sum_over_binary_words_distributes_in_left_factor`、ラベル **`real_sum_over_binary_words_distributes_in_left_factor`**、
`linear_space_general_claim_expansion_of_finite_product_of_two_term_sums_of_real_numbers`、ラベル **`expansion_of_finite_product_of_two_term_sums_of_real_numbers`**）

**必要十分版**: `Ising2D/NecSuf/BinaryWordSum.lean` の `binWordSum_map`（`f := (· * c)`）と `finProdLeft_add_eq_binWordSum`（`R := ℝ`）。
具体版をその系として導くのは同じフォルダの `ClaimExpansionOfFiniteProductOfTwoTermSumsOfRealNumbersFromNecSuf.lean`。

## 人手証明との対応

* 人手の `r ∈ ℤ_{≥1}` が Lean の `r + 1` に当たる。人手の `a_j^{(e)}` が Lean の `a (j - 1) e`、`{0,1}^r` が `Fin (r + 1) → Fin 2`、
  `(ε', e)` が `Fin.snoc ε' e` である。
* `{0,1}^r` の上の実数の和（`def_sum_over_binary_words_of_real_numbers`）は `binaryWordRealSum`、実数の有限積
  （`def_finite_product_of_real_numbers`）は `ClaimRealExpOfFiniteSum.lean` と同じく `Finset.prod` で、定義の 2 つの式は
  `Fin.prod_univ_one`・`Fin.prod_univ_castSucc` で読む。
* `real_sum_over_binary_words_distributes_in_left_factor` の帰納法の 2 つの鎖（`r = 1` の 3 行、`r → r + 1` の 4 行）は
  `binaryWordRealSum_mul` の 2 つの節の `calc` と 1 対 1 である。ℝ の分配則 `(a + b)c = ac + bc` は mathlib の `add_mul` である。
* `expansion_of_finite_product_of_two_term_sums_of_real_numbers` の帰納法の 2 つの鎖（`r = 1` の 4 行、`r → r + 1` の 7 行）は
  `expansion_of_finite_product_of_two_term_sums_of_real` の 2 つの節の `calc` と 1 対 1 である。ℝ の分配則 `a(b + c) = ab + ac` は
  mathlib の `mul_add` である。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.DefinitionSumOverBinaryWords
import Mathlib.Algebra.BigOperators.Fin

namespace Ising2D

/-- **人手 `real_sum_over_binary_words_distributes_in_left_factor`**:
`(Σ_{ε∈{0,1}^r} x_ε) c = Σ_{ε∈{0,1}^r} x_ε c`（人手の `r` は Lean の `r + 1`）。 -/
theorem binaryWordRealSum_mul :
    ∀ (r : ℕ) (x : (Fin (r + 1) → Fin 2) → ℝ) (c : ℝ),
      binaryWordRealSum r x * c = binaryWordRealSum r (fun ε => x ε * c)
  | 0, x, c =>
    calc binaryWordRealSum 0 x * c
        = (x (fun _ => 1) + x (fun _ => 0)) * c := by rw [binaryWordRealSum_zero]
                                                        -- `def_sum_over_binary_words_of_real_numbers`
      _ = x (fun _ => 1) * c + x (fun _ => 0) * c := add_mul _ _ _
                                                        -- ℝ の分配則 `(a + b)c = ac + bc`
      _ = binaryWordRealSum 0 (fun ε => x ε * c) := by rw [binaryWordRealSum_zero]
                                                        -- `def_sum_over_binary_words_of_real_numbers` を右辺から左辺へ
  | r + 1, x, c =>
    calc binaryWordRealSum (r + 1) x * c
        = binaryWordRealSum r
            (fun ε' => x (Fin.snoc (α := fun _ => Fin 2) ε' 1) + x (Fin.snoc (α := fun _ => Fin 2) ε' 0)) * c := by
          rw [binaryWordRealSum_succ]                   -- `def_sum_over_binary_words_of_real_numbers`
      _ = binaryWordRealSum r
            (fun ε' => (x (Fin.snoc (α := fun _ => Fin 2) ε' 1) + x (Fin.snoc (α := fun _ => Fin 2) ε' 0)) * c) :=
          binaryWordRealSum_mul r _ c                   -- 帰納法の仮定（`x_{ε'} → x_{(ε',1)} + x_{(ε',0)}`）
      _ = binaryWordRealSum r
            (fun ε' => x (Fin.snoc (α := fun _ => Fin 2) ε' 1) * c + x (Fin.snoc (α := fun _ => Fin 2) ε' 0) * c) := by
          congr 1; funext ε'; exact add_mul _ _ _       -- ℝ の分配則 `(a + b)c = ac + bc` を各項へ同時に
      _ = binaryWordRealSum (r + 1) (fun ε => x ε * c) := by rw [binaryWordRealSum_succ]
                                                        -- `def_sum_over_binary_words_of_real_numbers` を右辺から左辺へ

/-- **人手 `expansion_of_finite_product_of_two_term_sums_of_real_numbers`**:
`Π_{j=1}^{r}(a_j^{(1)} + a_j^{(0)}) = Σ_{ε∈{0,1}^r} Π_{j=1}^{r} a_j^{(ε_j)}`（人手の `r` は Lean の `r + 1`）。 -/
theorem expansion_of_finite_product_of_two_term_sums_of_real :
    ∀ (r : ℕ) (a : Fin (r + 1) → Fin 2 → ℝ),
      ∏ j, (a j 1 + a j 0) = binaryWordRealSum r (fun ε => ∏ j, a j (ε j))
  | 0, a =>
    calc ∏ j : Fin 1, (a j 1 + a j 0)
        = a 0 1 + a 0 0 := Fin.prod_univ_one _          -- `def_finite_product_of_real_numbers`
      _ = a 0 ((fun _ : Fin 1 => (1 : Fin 2)) 0) + a 0 ((fun _ : Fin 1 => (0 : Fin 2)) 0) := rfl
                                                        -- `def_sum_over_binary_words` の `(1)_1 = 1`、`(0)_1 = 0`
      _ = (∏ j : Fin 1, a j ((fun _ : Fin 1 => (1 : Fin 2)) j))
            + ∏ j : Fin 1, a j ((fun _ : Fin 1 => (0 : Fin 2)) j) := by
          rw [Fin.prod_univ_one, Fin.prod_univ_one]     -- `def_finite_product_of_real_numbers` を右辺から左辺へ 2 か所
      _ = binaryWordRealSum 0 (fun ε => ∏ j, a j (ε j)) := by rw [binaryWordRealSum_zero]
                                                        -- `def_sum_over_binary_words_of_real_numbers` を右辺から左辺へ
  | r + 1, a =>
    calc ∏ j, (a j 1 + a j 0)
        = (∏ j : Fin (r + 1), (a (Fin.castSucc j) 1 + a (Fin.castSucc j) 0))
            * (a (Fin.last (r + 1)) 1 + a (Fin.last (r + 1)) 0) := Fin.prod_univ_castSucc _
                                                        -- `def_finite_product_of_real_numbers`
      _ = binaryWordRealSum r (fun ε' => ∏ j, a (Fin.castSucc j) (ε' j))
            * (a (Fin.last (r + 1)) 1 + a (Fin.last (r + 1)) 0) := by
          rw [expansion_of_finite_product_of_two_term_sums_of_real r (fun j => a (Fin.castSucc j))]
                                                        -- 帰納法の仮定
      _ = binaryWordRealSum r (fun ε' => (∏ j, a (Fin.castSucc j) (ε' j))
            * (a (Fin.last (r + 1)) 1 + a (Fin.last (r + 1)) 0)) :=
          binaryWordRealSum_mul r _ _                   -- `real_sum_over_binary_words_distributes_in_left_factor`
      _ = binaryWordRealSum r (fun ε' => (∏ j, a (Fin.castSucc j) (ε' j)) * a (Fin.last (r + 1)) 1
            + (∏ j, a (Fin.castSucc j) (ε' j)) * a (Fin.last (r + 1)) 0) := by
          congr 1; funext ε'; exact mul_add _ _ _       -- ℝ の分配則 `a(b + c) = ab + ac` を各項へ同時に
      _ = binaryWordRealSum r (fun ε' =>
            (∏ j, a (Fin.castSucc j) (Fin.snoc (α := fun _ => Fin 2) ε' 1 (Fin.castSucc j)))
              * a (Fin.last (r + 1)) (Fin.snoc (α := fun _ => Fin 2) ε' 1 (Fin.last (r + 1)))
            + (∏ j, a (Fin.castSucc j) (Fin.snoc (α := fun _ => Fin 2) ε' 0 (Fin.castSucc j)))
              * a (Fin.last (r + 1)) (Fin.snoc (α := fun _ => Fin 2) ε' 0 (Fin.last (r + 1)))) := by
          simp only [Fin.snoc_castSucc, Fin.snoc_last]  -- `def_sum_over_binary_words` の `(ε', e)_j = ε'_j`、`(ε', e)_{r+1} = e`
      _ = binaryWordRealSum r (fun ε' =>
            (∏ j, a j (Fin.snoc (α := fun _ => Fin 2) ε' 1 j))
            + ∏ j, a j (Fin.snoc (α := fun _ => Fin 2) ε' 0 j)) := by
          congr 1; funext ε'
          rw [Fin.prod_univ_castSucc (fun j => a j (Fin.snoc (α := fun _ => Fin 2) ε' 1 j)),
            Fin.prod_univ_castSucc (fun j => a j (Fin.snoc (α := fun _ => Fin 2) ε' 0 j))]
                                                        -- `def_finite_product_of_real_numbers` を右辺から左辺へ（各項の 2 か所）
      _ = binaryWordRealSum (r + 1) (fun ε => ∏ j, a j (ε j)) := by rw [binaryWordRealSum_succ]
                                                        -- `def_sum_over_binary_words_of_real_numbers` を右辺から左辺へ

end Ising2D
