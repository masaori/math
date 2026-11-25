/-
# 実数の差・和・符号反転・共通の因子・零の有限和、二重の有限和の順序の入れ替え、非負の実数の有限和の下からの評価、有限和の三角不等式と項ごとの大小（**具体版**）

対応する人手証明のラベル: `def_finite_sum_of_real_numbers`, `finite_sum_of_real_differences`, `finite_sum_of_real_sums`, `finite_sum_of_real_zeros`, `finite_double_sum_of_real_numbers_interchange`,
`finite_sum_of_negated_real_numbers`, `finite_sum_of_real_scalar_multiples`, `finite_sum_of_nonnegative_reals_is_at_least_each_term`,
`finite_sum_of_real_numbers_triangle_inequality`, `finite_sum_of_real_numbers_is_monotone`,
`finite_sum_of_real_numbers_moves_one_term_to_end`, `finite_sum_of_real_numbers_with_single_nonzero_term`
（`structured-latex/content/000_calculation_formulae_00_09.ts` の `calc_formulae_definition_finite_sum_of_real_numbers`,
`calc_formulae_claim_finite_sum_of_real_differences`, `calc_formulae_claim_finite_sum_of_real_sums`, `calc_formulae_claim_finite_sum_of_real_zeros`, `calc_formulae_claim_finite_double_sum_of_real_numbers_interchange`, `calc_formulae_claim_finite_sum_of_negated_real_numbers`,
`calc_formulae_claim_finite_sum_of_real_scalar_multiples`,
`calc_formulae_claim_finite_sum_of_nonnegative_reals_is_at_least_each_term`,
`calc_formulae_claim_finite_sum_of_real_numbers_triangle_inequality`, `calc_formulae_claim_finite_sum_of_real_numbers_is_monotone`,
`calc_formulae_claim_finite_sum_of_real_numbers_moves_one_term_to_end`, `calc_formulae_claim_finite_sum_of_real_numbers_with_single_nonzero_term`）。

**必要十分版**: `Ising2D/NecSuf/FiniteSumDifferenceAndNonnegativeTerm.lean`（一つの項を末尾へ移す主張は `Ising2D/NecSuf/FiniteSumMovesOneTermToEnd.lean`、和の主張は複素数の兄弟 `finite_sum_of_complex_sums` と共有の `Ising2D/NecSuf/MatMulDistribSum.lean` の `finite_sum_add_fin'`、二重の和の順序の入れ替えと零の有限和は `Ising2D/NecSuf/FiniteDoubleSumInterchange.lean`）。具体版をその系として導くのは
`ClaimFiniteSumsOfRealNumbersFromNecSuf.lean`。

## 人手証明との対応

* 人手の `m ∈ ℤ_{≥0}` 項の和は、Lean では `Fin m` の上の和で書く。人手の `m ≥ 1` の帰納法は `_succ` の `Fin (m + 1)` の上の和（`m` についての帰納法）で、人手の `m` が Lean の `m + 1` に当たる。
  人手の `m = 0` の空の和の式は `finset_sum_fin_real_eq_finite_sum_of_real_numbers` の一つ目の式で出す。`m ≥ 1` の
  `def_finite_sum_of_real_numbers` の 2 つの式は `Fin.sum_univ_one`・`Fin.sum_univ_castSucc` で出す
  （mathlib の `Finset.sum` を人手の左から足す和の定義へ読み替える段）。人手の添字 `j ∈ {1, …, m+1}` は Lean の `Fin (m + 1)` の `j - 1`、
  `j = m + 1` は `Fin.last`、`j ≤ m` は `Fin.castSucc` である。
* `finite_sum_of_real_differences_succ` の帰納法の段の calc は人手の 12 行と対応する。人手の 8 行（`def_real_difference` の 2 か所同時適用・
  加法の結合律・結合律・交換律・結合律・結合律・`real_negation_of_sum_is_sum_of_negations` を右辺から左辺へ・`def_real_difference` を右辺から左辺へ）は
  `finite_sum_of_real_differences_step`（1 行 1 段）。
  人手の `α, β` は `let` で置き、帰納法の仮定の段と 8 行の段の右辺を `α, β` で書く。人手の「`α, β` の置き方」の行は `α, β` を和へ戻す `rfl` の 1 段で、
  その次の `def_finite_sum_of_real_numbers` の 2 か所同時適用とは別の段である。`m = 0`（空の和）は人手の `m = 0` の 3 行と 1 対 1 の `calc` で、空の和の式は `finset_sum_fin_real_eq_finite_sum_of_real_numbers` の一つ目の式から引く（`finite_sum_of_real_differences`）。
* `finite_sum_of_real_sums_succ` の `m = 1` の 2 行と帰納法の段は人手の行と対応する。人手の結合律・交換律の 5 行は
  `finite_sum_of_real_sums_step`（1 行 1 段）。`α, β` を `let` で置くことと、「`α, β` の置き方」の行を `rfl` の 1 段にすることは、`finite_sum_of_real_differences_succ` と同じである。
  `m = 0`（空の和）は `finite_sum_of_real_differences` と同じく人手の 3 行と 1 対 1 の `calc` である（`finite_sum_of_real_sums`）。有限型の添字の和には `finite_sum_of_real_sums_fintype` を置く。
* `finite_double_sum_of_real_numbers_interchange_succ` は人手の `n_1 ∈ ℤ_{≥1}`・`n_2 ∈ ℤ_{≥0}` を Lean の `p + 1`・`q`、`c_{k,l}` を `a k l` で書き、`n_1 = 1` の 2 行と
  帰納法の段の 4 行が人手の行と 1 対 1 の `calc` である。人手の「各 `l` の項へ同時適用」は `Finset.sum_congr` で各項に当てる段である。
  人手の `n_1 = 0` の 3 行は `finite_double_sum_of_real_numbers_interchange` の `p = 0` の段で、1 対 1 の `calc` である（`Σ_{l=1}^{n_2} 0 = 0` は `finite_sum_of_real_zeros`）。
  有限型の添字の二重の和には `_fintype` を置く。
* `finite_sum_of_real_zeros_succ` の `m = 1` の 1 行と帰納法の段の 3 行、`finite_sum_of_real_zeros` の `m = 0` の 1 行は、人手の行と 1 対 1 の `calc` である。
* `finite_sum_of_negated_real_numbers_succ` の `m = 1` の 2 行と帰納法の段の 4 行は、人手の行と 1 対 1 の `calc` である。
  人手の 1 行 `real_negation_of_sum_is_sum_of_negations`（文字を `p, q` に替える）を右辺から左辺へ当てる行は、同じ名前の具体版の定理を右辺から左辺へ使う 1 段である。`m = 0`（空の和）は人手の 3 行と 1 対 1 の `calc` である（`finite_sum_of_negated_real_numbers`。その段の `-0 = 0` は mathlib の `neg_zero` ではなく `real_negation_of_zero_is_zero`）。
* `finite_sum_of_real_scalar_multiples_succ` の `m = 1` の 2 行と帰納法の段の 4 行は、人手の行と 1 対 1 の `calc` である。
  人手の 1 行「ℝ の分配律 `ca + cb = c(a + b)`」は mathlib の `mul_add` を右辺から左辺へ使う 1 段である。`m = 0`（空の和）は人手の 3 行と 1 対 1 の `calc` で、`c · 0 = 0` は `real_times_zero_is_zero` である（`finite_sum_of_real_scalar_multiples`）。
  有限型の添字の和には、`finite_sum_of_nonnegative_reals_ge_term_fintype` と同じく番号を付けて当てる `finite_sum_of_real_scalar_multiples_fintype` を置く。
* `finite_sum_of_nonnegative_reals_ge_term_succ` は人手と同じく、`k ≤ m`（Lean の `Fin.castSucc k'`）と `k = m + 1`（`Fin.last`）に分け、
  それぞれ人手の 4 行と 1 対 1 の `calc` にした。`k = m + 1` の前置き `Σ_{j=1}^{m} a_j ≥ a_1 ≥ 0` は帰納法の仮定を `k → 1`（Lean の `0`）で使う。
  「両辺に同じ実数を足す」は `add_le_add` の片方を `le_rfl` にしたもの、「0 は ℝ の和の単位元」は `add_zero`・`zero_add` である。
* `finite_sum_of_real_numbers_triangle_inequality_succ` と `finite_sum_of_real_numbers_is_monotone_succ` は、`m = 1` の 2 行・3 行と帰納法の段の 4 行が
  人手の行と 1 対 1 の `calc` である（三角不等式の `m = 1` は人手の等号の 2 行に、`≤` へ移す `le_rfl` を 1 段足した）。
  帰納法の段の三角不等式は `real_abs_triangle_inequality`（`ClaimRealAbsoluteValueBoundsTriangleAndProduct.lean`）を引く。
  `m = 0`（空の和）は人手の 3 行・2 行と 1 対 1 の `calc` に、`≤` へ移す `le_rfl` を 1 段足した（`|0| = 0` は `def_real_absolute_value` の `q ≥ 0` の場合で、`abs_of_nonneg`）。
  `_fintype` 版は `finite_sum_of_nonnegative_reals_ge_term_fintype` と同じく、有限型の添字に番号を付けて当てる。
* `finite_sum_of_real_numbers_moves_one_term_to_end` は人手の `m ≥ 1` を Lean の `n + 1` で書き、`δ^{m}_{k}` は `skipIndex k`
  （`DefinitionIndexSkippingMap.lean`）である。人手と同じく `m = 1` を `k = 1`（Lean の `castSucc 0`）・`k = 2`（`last 1`）に、
  帰納法の段を `k = m + 2`（`Fin.last`）・`k ≤ m + 1`（`Fin.castSucc k'`）に分け、各場合の前置き（`δ` の値）を `have` に、鎖を人手の行と 1 対 1 の `calc` にした。
  人手の `{1, …, m+1} ⊂ {1, …, m+2}` の包含は `Fin.castSucc` で、人手の前置き `δ^{m+1}_{k}(j) = δ^{m}_{k}(j)` は Lean では
  `skipIndex k'.castSucc j.castSucc = (skipIndex k' j).castSucc` になる。各場合の最後の行「`k = 1`」「`k = 2`」「`k = m + 2`」は、
  Lean では `k` を場合分けで置き換え済みなので段にしない。`s` の置き方は `let` で、置き方の段は `rfl` である。
* `finite_sum_of_real_numbers_with_single_nonzero_term_succ` は人手の `m ≥ 1` を Lean の `m + 1`、`k ∈ {1, …, m}` を `k : Fin (m + 1)` で書く。
  `m = 1` の 2 行、帰納法の段の `k = m + 1`（`Fin.last`）の 5 行と `k ≤ m`（`Fin.castSucc k'`）の 4 行が人手の行と 1 対 1 の `calc` である。
  `k = m + 1` の前置き（`r_1, …, r_m` と `1` が帰納法の仮定の仮定を満たすこと、`r_1 = 0`）は、帰納法の仮定へ渡す関数と `have` である。
  「`0` は `ℝ` の和の単位元」は `zero_add`・`add_zero`（`finite_sum_of_nonnegative_reals_ge_term_succ` と同じ扱い）。
-/
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Data.Real.Basic
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealNegationOfZeroIsZero
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimRealAbsoluteValueBoundsTriangleAndProduct
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.DefinitionIndexSkippingMap
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealNegationOfSumIsSumOfNegations
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealMinusZeroIsSelf
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealTimesZeroIsZero
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.DefinitionFiniteSumOverIndexSet

namespace Ising2D

/-- **`finite_sum_of_real_differences`** の帰納法の段の 8 行: `(α - β) + (x - y) = (α + x) - (β + y)`（人手の `a_{m+1}, b_{m+1}` が `x, y`）。 -/
theorem finite_sum_of_real_differences_step (α β x y : ℝ) :
    (α - β) + (x - y) = (α + x) - (β + y) :=
  calc (α - β) + (x - y)
      = (α + -β) + (x + -y) := by rw [sub_eq_add_neg α β, sub_eq_add_neg x y]
                          -- `def_real_difference`（`y → α`, `z → β`; `y → a_{m+1}`, `z → b_{m+1}`）を 2 か所へ同時適用
    _ = α + (-β + (x + -y)) := add_assoc α (-β) (x + -y)
                          -- ℝ の加法の結合律 `(p + q) + s = p + (q + s)`（`p → α`, `q → -β`, `s → a_{m+1} + (-b_{m+1})`）（`set_and_algebra_notation`）
    _ = α + ((-β + x) + -y) := by rw [add_assoc (-β) x (-y)]
                          -- 同じ結合律（`p → -β`, `q → a_{m+1}`, `s → -b_{m+1}`）を右辺から左辺へ
    _ = α + ((x + -β) + -y) := by rw [add_comm (-β) x]
                          -- ℝ の加法の交換律 `p + q = q + p`（`p → -β`, `q → a_{m+1}`）（`set_and_algebra_notation`）
    _ = α + (x + (-β + -y)) := by rw [add_assoc x (-β) (-y)]
                          -- 同じ結合律（`p → a_{m+1}`, `q → -β`, `s → -b_{m+1}`）
    _ = (α + x) + (-β + -y) := (add_assoc α x (-β + -y)).symm
                          -- 同じ結合律（`p → α`, `q → a_{m+1}`, `s → (-β) + (-b_{m+1})`）を右辺から左辺へ
    _ = (α + x) + -(β + y) := by rw [real_negation_of_sum_is_sum_of_negations β y]
                          -- `real_negation_of_sum_is_sum_of_negations`（`x → β`, `y → b_{m+1}`）を右辺から左辺へ
    _ = (α + x) - (β + y) := (sub_eq_add_neg _ _).symm
                          -- `def_real_difference`（`y → α + a_{m+1}`, `z → β + b_{m+1}`）を右辺から左辺へ

/-- **`finite_sum_of_real_differences`**（`m + 1` 項）: `Σ_{j=1}^{m+1}(a_j - b_j) = Σ a_j - Σ b_j`。`m` についての帰納法。 -/
theorem finite_sum_of_real_differences_succ (m : ℕ) (a b : Fin (m + 1) → ℝ) :
    ∑ j, (a j - b j) = (∑ j, a j) - ∑ j, b j := by
  induction m with
  | zero =>
    calc ∑ j : Fin 1, (a j - b j)
        = a 0 - b 0 := Fin.sum_univ_one _                                    -- `def_finite_sum_of_real_numbers`（`r_j → a_j - b_j`）
      _ = (∑ j : Fin 1, a j) - ∑ j : Fin 1, b j := by
          rw [Fin.sum_univ_one a, Fin.sum_univ_one b]                         -- `def_finite_sum_of_real_numbers`（`r_j → a_j`; `r_j → b_j`）を右辺から左辺へ 2 か所同時適用
  | succ m ih =>
    let α : ℝ := ∑ j : Fin (m + 1), a j.castSucc                            -- 人手の `α := Σ_{j=1}^{m} a_j`
    let β : ℝ := ∑ j : Fin (m + 1), b j.castSucc                            -- 人手の `β := Σ_{j=1}^{m} b_j`
    calc ∑ j : Fin (m + 2), (a j - b j)
        = (∑ j : Fin (m + 1), (a j.castSucc - b j.castSucc)) + (a (Fin.last _) - b (Fin.last _)) :=
          Fin.sum_univ_castSucc _                                             -- `def_finite_sum_of_real_numbers`（`r_j → a_j - b_j`）
      _ = (α - β) + (a (Fin.last _) - b (Fin.last _)) := by
          rw [ih (fun j => a j.castSucc) (fun j => b j.castSucc)]             -- 帰納法の仮定
      _ = (α + a (Fin.last _)) - (β + b (Fin.last _)) :=
          finite_sum_of_real_differences_step _ _ _ _                          -- 人手の 8 行（差を和に直す）
      _ = ((∑ j : Fin (m + 1), a j.castSucc) + a (Fin.last _))
            - ((∑ j : Fin (m + 1), b j.castSucc) + b (Fin.last _)) := rfl     -- `α, β` の置き方
      _ = (∑ j, a j) - ∑ j, b j := by
          rw [Fin.sum_univ_castSucc a, Fin.sum_univ_castSucc b]               -- `def_finite_sum_of_real_numbers`（`r_j → a_j`; `r_j → b_j`）を右辺から左辺へ 2 か所同時適用

/-- **`finite_sum_of_real_differences`**（`m ∈ ℤ_{≥0}`）: `m = 0` の段は人手の `m = 0` の 3 行、`m ≥ 1` は `finite_sum_of_real_differences_succ`。 -/
theorem finite_sum_of_real_differences (m : ℕ) (a b : Fin m → ℝ) :
    ∑ j, (a j - b j) = (∑ j, a j) - ∑ j, b j := by
  cases m with
  | zero =>
    calc ∑ j : Fin 0, (a j - b j)
        = 0 := finset_sum_fin_real_eq_finite_sum_of_real_numbers.1 _                    -- `def_finite_sum_of_real_numbers` の `Σ_{j=1}^{0} r_j := 0`（`r_j → a_j - b_j`）
      _ = 0 - 0 := (real_minus_zero_is_self 0).symm                          -- `real_minus_zero_is_self`（`a → 0`）を右辺から左辺へ
      _ = (∑ j : Fin 0, a j) - ∑ j : Fin 0, b j := by
          rw [finset_sum_fin_real_eq_finite_sum_of_real_numbers.1 a, finset_sum_fin_real_eq_finite_sum_of_real_numbers.1 b]
                                                                              -- `def_finite_sum_of_real_numbers` の `Σ_{j=1}^{0} r_j := 0`（`r_j → a_j`; `r_j → b_j`）を右辺から左辺へ 2 か所同時適用
  | succ m => exact finite_sum_of_real_differences_succ m a b

/-- **`finite_sum_of_real_sums`** の帰納法の段の 5 行: `(α + β) + (x + y) = (α + x) + (β + y)`（人手の `a_{m+1}, b_{m+1}` が `x, y`）。ℝ の加法の結合律と交換律を 1 段ずつ。 -/
theorem finite_sum_of_real_sums_step (α β x y : ℝ) :
    (α + β) + (x + y) = (α + x) + (β + y) :=
  calc (α + β) + (x + y)
      = α + (β + (x + y)) := add_assoc α β (x + y)
                          -- ℝ の加法の結合律 `(p + q) + s = p + (q + s)`（`p → α`, `q → β`, `s → a_{m+1} + b_{m+1}`）（`set_and_algebra_notation`）
    _ = α + ((β + x) + y) := by rw [add_assoc β x y]
                          -- 同じ結合律（`p → β`, `q → a_{m+1}`, `s → b_{m+1}`）を右辺から左辺へ
    _ = α + ((x + β) + y) := by rw [add_comm β x]
                          -- ℝ の加法の交換律 `p + q = q + p`（`p → β`, `q → a_{m+1}`）（`set_and_algebra_notation`）
    _ = α + (x + (β + y)) := by rw [add_assoc x β y]
                          -- 同じ結合律（`p → a_{m+1}`, `q → β`, `s → b_{m+1}`）
    _ = (α + x) + (β + y) := (add_assoc α x (β + y)).symm
                          -- 同じ結合律（`p → α`, `q → a_{m+1}`, `s → β + b_{m+1}`）を右辺から左辺へ

/-- **`finite_sum_of_real_sums`**（`m + 1` 項）: `Σ_{j=1}^{m+1}(a_j + b_j) = Σ a_j + Σ b_j`。`m` についての帰納法。 -/
theorem finite_sum_of_real_sums_succ (m : ℕ) (a b : Fin (m + 1) → ℝ) :
    ∑ j, (a j + b j) = (∑ j, a j) + ∑ j, b j := by
  induction m with
  | zero =>
    calc ∑ j : Fin 1, (a j + b j)
        = a 0 + b 0 := Fin.sum_univ_one _                                    -- `def_finite_sum_of_real_numbers`（`r_j → a_j + b_j`）
      _ = (∑ j : Fin 1, a j) + ∑ j : Fin 1, b j := by
          rw [Fin.sum_univ_one a, Fin.sum_univ_one b]                         -- `def_finite_sum_of_real_numbers`（`r_j → a_j`; `r_j → b_j`）を右辺から左辺へ 2 か所同時適用
  | succ m ih =>
    let α : ℝ := ∑ j : Fin (m + 1), a j.castSucc                            -- 人手の `α := Σ_{j=1}^{m} a_j`
    let β : ℝ := ∑ j : Fin (m + 1), b j.castSucc                            -- 人手の `β := Σ_{j=1}^{m} b_j`
    calc ∑ j : Fin (m + 2), (a j + b j)
        = (∑ j : Fin (m + 1), (a j.castSucc + b j.castSucc)) + (a (Fin.last _) + b (Fin.last _)) :=
          Fin.sum_univ_castSucc _                                             -- `def_finite_sum_of_real_numbers`（`r_j → a_j + b_j`）
      _ = (α + β) + (a (Fin.last _) + b (Fin.last _)) := by
          rw [ih (fun j => a j.castSucc) (fun j => b j.castSucc)]             -- 帰納法の仮定
      _ = (α + a (Fin.last _)) + (β + b (Fin.last _)) :=
          finite_sum_of_real_sums_step _ _ _ _                                 -- 人手の 5 行（結合律・結合律・交換律・結合律・結合律）
      _ = ((∑ j : Fin (m + 1), a j.castSucc) + a (Fin.last _))
            + ((∑ j : Fin (m + 1), b j.castSucc) + b (Fin.last _)) := rfl     -- `α, β` の置き方
      _ = (∑ j, a j) + ∑ j, b j := by
          rw [Fin.sum_univ_castSucc a, Fin.sum_univ_castSucc b]               -- `def_finite_sum_of_real_numbers`（`r_j → a_j`; `r_j → b_j`）を右辺から左辺へ 2 か所同時適用

/-- **`finite_sum_of_real_sums`**（`m ∈ ℤ_{≥0}`）: `m = 0` の段は人手の `m = 0` の 3 行、`m ≥ 1` は `finite_sum_of_real_sums_succ`。 -/
theorem finite_sum_of_real_sums (m : ℕ) (a b : Fin m → ℝ) :
    ∑ j, (a j + b j) = (∑ j, a j) + ∑ j, b j := by
  cases m with
  | zero =>
    calc ∑ j : Fin 0, (a j + b j)
        = 0 := finset_sum_fin_real_eq_finite_sum_of_real_numbers.1 _                    -- `def_finite_sum_of_real_numbers` の `Σ_{j=1}^{0} r_j := 0`（`r_j → a_j + b_j`）
      _ = 0 + 0 := (add_zero 0).symm                                          -- `0` は ℝ の加法の単位元 `y + 0 = y`（`y → 0`）（`set_and_algebra_notation`）を右辺から左辺へ
      _ = (∑ j : Fin 0, a j) + ∑ j : Fin 0, b j := by
          rw [finset_sum_fin_real_eq_finite_sum_of_real_numbers.1 a, finset_sum_fin_real_eq_finite_sum_of_real_numbers.1 b]
                                                                              -- `def_finite_sum_of_real_numbers` の `Σ_{j=1}^{0} r_j := 0`（`r_j → a_j`; `r_j → b_j`）を右辺から左辺へ 2 か所同時適用
  | succ m => exact finite_sum_of_real_sums_succ m a b

/-- **`finite_sum_of_real_sums`**（添字が有限型 `κ` の和）。
`finite_sum_of_real_scalar_multiples_fintype` と同じく、`κ` に `Fintype.equivFin κ` で番号を付け、`Fin (card κ)` の上の和として
`finite_sum_of_real_sums` を当てる（番号を付ける段と外す段は mathlib の `Equiv.sum_comp` による）。 -/
theorem finite_sum_of_real_sums_fintype {κ : Type*} [Fintype κ] (a b : κ → ℝ) :
    ∑ j, (a j + b j) = (∑ j, a j) + ∑ j, b j := by
  set e := Fintype.equivFin κ
  calc ∑ j, (a j + b j)
      = ∑ j : Fin (Fintype.card κ), (a (e.symm j) + b (e.symm j)) :=
        (e.symm.sum_comp (fun j => a j + b j)).symm                           -- `κ` に番号を付ける
    _ = (∑ j : Fin (Fintype.card κ), a (e.symm j)) + ∑ j : Fin (Fintype.card κ), b (e.symm j) :=
        finite_sum_of_real_sums _ (fun j => a (e.symm j)) (fun j => b (e.symm j))   -- `finite_sum_of_real_sums`（`a_j → a(e^{-1}(j))`、`b_j → b(e^{-1}(j))`）
    _ = (∑ j, a j) + ∑ j, b j := by rw [e.symm.sum_comp a, e.symm.sum_comp b]       -- 番号を外す

/-- **`finite_sum_of_real_zeros`**（`m + 1` 項）: `Σ_{j=1}^{m+1} 0 = 0`。`m` についての帰納法。 -/
theorem finite_sum_of_real_zeros_succ (m : ℕ) : ∑ _j : Fin (m + 1), (0 : ℝ) = 0 := by
  induction m with
  | zero =>
    calc ∑ _j : Fin 1, (0 : ℝ)
        = 0 := Fin.sum_univ_one _                                          -- `def_finite_sum_of_real_numbers` の `Σ_{j=1}^{1} r_j := r_1`（`r_1 → 0`）
  | succ m ih =>
    calc ∑ _j : Fin (m + 2), (0 : ℝ)
        = (∑ _j : Fin (m + 1), (0 : ℝ)) + 0 := Fin.sum_univ_castSucc (fun _ => (0 : ℝ))
                                                                           -- `def_finite_sum_of_real_numbers` の帰納の式（`r_j → 0`）
      _ = 0 + 0 := by rw [ih]                                              -- 帰納法の仮定
      _ = 0 := add_zero 0                                                  -- `0` は ℝ の加法の単位元 `y + 0 = y`（`y → 0`）（`set_and_algebra_notation`）

/-- **`finite_sum_of_real_zeros`**（`m ∈ ℤ_{≥0}`）: `m = 0` の段は人手の `m = 0` の 1 行、`m ≥ 1` は `finite_sum_of_real_zeros_succ`。 -/
theorem finite_sum_of_real_zeros (m : ℕ) : ∑ _j : Fin m, (0 : ℝ) = 0 := by
  cases m with
  | zero =>
    calc ∑ _j : Fin 0, (0 : ℝ)
        = 0 := finset_sum_fin_real_eq_finite_sum_of_real_numbers.1 _      -- `def_finite_sum_of_real_numbers` の `Σ_{j=1}^{0} r_j := 0`（`r_j → 0`）
  | succ m => exact finite_sum_of_real_zeros_succ m

/-- **`finite_double_sum_of_real_numbers_interchange`**（外側 `p + 1` 項・内側 `q` 項）:
`Σ_{k=1}^{n_1} Σ_{l=1}^{n_2} c_{k,l} = Σ_{l=1}^{n_2} Σ_{k=1}^{n_1} c_{k,l}`（人手の `n_1 ∈ ℤ_{≥1}, n_2 ∈ ℤ_{≥0}` は Lean の `p + 1`・`q`、`c_{k,l}` は `a k l`）。`p` についての帰納法（`q` は固定）。 -/
theorem finite_double_sum_of_real_numbers_interchange_succ (p q : ℕ) (a : Fin (p + 1) → Fin q → ℝ) :
    ∑ k, ∑ l, a k l = ∑ l, ∑ k, a k l := by
  induction p with
  | zero =>
    calc ∑ k : Fin 1, ∑ l, a k l
        = ∑ l, a 0 l := Fin.sum_univ_one _                                   -- `def_finite_sum_of_real_numbers`（`r_j → Σ_l c_{j,l}`）
      _ = ∑ l, ∑ k : Fin 1, a k l :=
          Finset.sum_congr rfl fun l _ => (Fin.sum_univ_one (fun k => a k l)).symm
                                                                              -- `def_finite_sum_of_real_numbers`（`r_j → c_{j,l}`）を右辺から左辺へ、各 `l` の項へ
  | succ p ih =>
    calc ∑ k : Fin (p + 2), ∑ l, a k l
        = (∑ k : Fin (p + 1), ∑ l, a k.castSucc l) + ∑ l, a (Fin.last _) l :=
          Fin.sum_univ_castSucc _                                             -- `def_finite_sum_of_real_numbers`（`m → n_1`、`r_j → Σ_l c_{j,l}`）
      _ = (∑ l, ∑ k : Fin (p + 1), a k.castSucc l) + ∑ l, a (Fin.last _) l := by
          rw [ih (fun k l => a k.castSucc l)]                                 -- 帰納法の仮定
      _ = ∑ l, ((∑ k : Fin (p + 1), a k.castSucc l) + a (Fin.last _) l) :=
          (finite_sum_of_real_sums q _ _).symm                              -- `finite_sum_of_real_sums`（`m → n_2`、`a_j → Σ_{k=1}^{n_1} c_{k,j}`、`b_j → c_{n_1+1,j}`）を右辺から左辺へ
      _ = ∑ l, ∑ k, a k l :=
          Finset.sum_congr rfl fun l _ => (Fin.sum_univ_castSucc (fun k => a k l)).symm
                                                                              -- `def_finite_sum_of_real_numbers`（`m → n_1`、`r_j → c_{j,l}`）を右辺から左辺へ、各 `l` の項へ

/-- **`finite_double_sum_of_real_numbers_interchange`**（`n_1, n_2 ∈ ℤ_{≥0}`）: `p = 0` の段は人手の `n_1 = 0` の 3 行、
`p ≥ 1` は `finite_double_sum_of_real_numbers_interchange_succ`。 -/
theorem finite_double_sum_of_real_numbers_interchange (p q : ℕ) (a : Fin p → Fin q → ℝ) :
    ∑ k, ∑ l, a k l = ∑ l, ∑ k, a k l := by
  cases p with
  | zero =>
    calc ∑ k : Fin 0, ∑ l, a k l
        = 0 := finset_sum_fin_real_eq_finite_sum_of_real_numbers.1 _      -- `def_finite_sum_of_real_numbers` の `Σ_{j=1}^{0} r_j := 0`（`r_j → Σ_l c_{j,l}`）
      _ = ∑ _l : Fin q, (0 : ℝ) := (finite_sum_of_real_zeros q).symm      -- `finite_sum_of_real_zeros`（`m → n_2`）を右辺から左辺へ
      _ = ∑ l, ∑ k : Fin 0, a k l :=
          Finset.sum_congr rfl fun l _ => (finset_sum_fin_real_eq_finite_sum_of_real_numbers.1 (fun k => a k l)).symm
                                                                           -- `def_finite_sum_of_real_numbers` の `Σ_{j=1}^{0} r_j := 0`（`r_j → c_{j,l}`）を右辺から左辺へ、各 `l` の項へ
  | succ p => exact finite_double_sum_of_real_numbers_interchange_succ p q a

/-- **`finite_double_sum_of_real_numbers_interchange`**（添字が有限型 `κ`・`ι` の二重の和）。
`finite_sum_of_real_sums_fintype` と同じく、`κ`・`ι` に `Fintype.equivFin` で番号を付け、`Fin (card κ)`・`Fin (card ι)` の上の和として
`finite_double_sum_of_real_numbers_interchange` を当てる（番号を付ける段と外す段は mathlib の `Equiv.sum_comp` による）。 -/
theorem finite_double_sum_of_real_numbers_interchange_fintype {κ ι : Type*} [Fintype κ] [Fintype ι]
    (a : κ → ι → ℝ) :
    ∑ k, ∑ l, a k l = ∑ l, ∑ k, a k l := by
  set e := Fintype.equivFin κ
  set f := Fintype.equivFin ι
  calc ∑ k, ∑ l, a k l
      = ∑ k : Fin (Fintype.card κ), ∑ l, a (e.symm k) l :=
        (e.symm.sum_comp (fun k => ∑ l, a k l)).symm                          -- `κ` に番号を付ける
    _ = ∑ k : Fin (Fintype.card κ), ∑ l : Fin (Fintype.card ι), a (e.symm k) (f.symm l) :=
        Finset.sum_congr rfl fun k _ => (f.symm.sum_comp (fun l => a (e.symm k) l)).symm   -- `ι` に番号を付ける（各 `k` の項へ）
    _ = ∑ l : Fin (Fintype.card ι), ∑ k : Fin (Fintype.card κ), a (e.symm k) (f.symm l) :=
        finite_double_sum_of_real_numbers_interchange _ _ _                    -- `finite_double_sum_of_real_numbers_interchange`（`c_{k,l} → a(e^{-1}(k), f^{-1}(l))`）
    _ = ∑ l : Fin (Fintype.card ι), ∑ k, a k (f.symm l) :=
        Finset.sum_congr rfl fun l _ => e.symm.sum_comp (fun k => a k (f.symm l))   -- `κ` の番号を外す（各 `l` の項へ）
    _ = ∑ l, ∑ k, a k l := f.symm.sum_comp (fun l => ∑ k, a k l)               -- `ι` の番号を外す

/-- **`finite_sum_of_negated_real_numbers`**（`m + 1` 項）: `Σ_{j=1}^{m+1}(−x_j) = −Σ_{j=1}^{m+1} x_j`。`m` についての帰納法。 -/
theorem finite_sum_of_negated_real_numbers_succ (m : ℕ) (x : Fin (m + 1) → ℝ) :
    ∑ j, -(x j) = -(∑ j, x j) := by
  induction m with
  | zero =>
    calc ∑ j : Fin 1, -(x j)
        = -(x 0) := Fin.sum_univ_one _                                       -- `def_finite_sum_of_real_numbers`
      _ = -(∑ j : Fin 1, x j) := by rw [Fin.sum_univ_one x]                  -- `def_finite_sum_of_real_numbers` を右辺から左辺へ
  | succ m ih =>
    calc ∑ j : Fin (m + 2), -(x j)
        = (∑ j : Fin (m + 1), -(x j.castSucc)) + -(x (Fin.last _)) :=
          Fin.sum_univ_castSucc _                                             -- `def_finite_sum_of_real_numbers`
      _ = -(∑ j : Fin (m + 1), x j.castSucc) + -(x (Fin.last _)) := by
          rw [ih (fun j => x j.castSucc)]                                     -- 帰納法の仮定
      _ = -((∑ j : Fin (m + 1), x j.castSucc) + x (Fin.last _)) :=
          (real_negation_of_sum_is_sum_of_negations _ _).symm                 -- `real_negation_of_sum_is_sum_of_negations` を右辺から左辺へ
      _ = -(∑ j, x j) := by rw [Fin.sum_univ_castSucc x]                      -- `def_finite_sum_of_real_numbers` を右辺から左辺へ

/-- **`finite_sum_of_negated_real_numbers`**（`m ∈ ℤ_{≥0}`）: `m = 0` の段は人手の `m = 0` の 3 行、`m ≥ 1` は `finite_sum_of_negated_real_numbers_succ`。 -/
theorem finite_sum_of_negated_real_numbers (m : ℕ) (x : Fin m → ℝ) :
    ∑ j, -(x j) = -(∑ j, x j) := by
  cases m with
  | zero =>
    calc ∑ j : Fin 0, -(x j)
        = 0 := finset_sum_fin_real_eq_finite_sum_of_real_numbers.1 _                    -- `def_finite_sum_of_real_numbers` の `Σ_{j=1}^{0} r_j := 0`（`r_j → -x_j`）
      _ = -0 := real_negation_of_zero_is_zero.symm                            -- `real_negation_of_zero_is_zero` を右辺から左辺へ
      _ = -(∑ j : Fin 0, x j) := by rw [finset_sum_fin_real_eq_finite_sum_of_real_numbers.1 x]
                                                                              -- `def_finite_sum_of_real_numbers` の `Σ_{j=1}^{0} r_j := 0`（`r_j → x_j`）を右辺から左辺へ
  | succ m => exact finite_sum_of_negated_real_numbers_succ m x

/-- **`finite_sum_of_real_scalar_multiples`**（`m + 1` 項）: `Σ_{j=1}^{m+1} c x_j = c Σ_{j=1}^{m+1} x_j`。`m` についての帰納法。 -/
theorem finite_sum_of_real_scalar_multiples_succ (m : ℕ) (c : ℝ) (x : Fin (m + 1) → ℝ) :
    ∑ j, c * x j = c * ∑ j, x j := by
  induction m with
  | zero =>
    calc ∑ j : Fin 1, c * x j
        = c * x 0 := Fin.sum_univ_one _                                      -- `def_finite_sum_of_real_numbers`（`r_j → c x_j`）
      _ = c * ∑ j : Fin 1, x j := by rw [Fin.sum_univ_one x]                 -- `def_finite_sum_of_real_numbers` を右辺から左辺へ
  | succ m ih =>
    calc ∑ j : Fin (m + 2), c * x j
        = (∑ j : Fin (m + 1), c * x j.castSucc) + c * x (Fin.last _) :=
          Fin.sum_univ_castSucc _                                             -- `def_finite_sum_of_real_numbers`（`r_j → c x_j`）
      _ = c * (∑ j : Fin (m + 1), x j.castSucc) + c * x (Fin.last _) := by
          rw [ih (fun j => x j.castSucc)]                                     -- 帰納法の仮定
      _ = c * ((∑ j : Fin (m + 1), x j.castSucc) + x (Fin.last _)) :=
          (mul_add _ _ _).symm                                                -- ℝ の分配律 `ca + cb = c(a + b)`
      _ = c * ∑ j, x j := by rw [Fin.sum_univ_castSucc x]                     -- `def_finite_sum_of_real_numbers` を右辺から左辺へ

/-- **`finite_sum_of_real_scalar_multiples`**（`m ∈ ℤ_{≥0}`）: `m = 0` の段は人手の `m = 0` の 3 行、`m ≥ 1` は `finite_sum_of_real_scalar_multiples_succ`。 -/
theorem finite_sum_of_real_scalar_multiples (m : ℕ) (c : ℝ) (x : Fin m → ℝ) :
    ∑ j, c * x j = c * ∑ j, x j := by
  cases m with
  | zero =>
    calc ∑ j : Fin 0, c * x j
        = 0 := finset_sum_fin_real_eq_finite_sum_of_real_numbers.1 _                    -- `def_finite_sum_of_real_numbers` の `Σ_{j=1}^{0} r_j := 0`（`r_j → c x_j`）
      _ = c * 0 := (real_times_zero_is_zero c).symm                           -- `real_times_zero_is_zero`（`x → c`）を右辺から左辺へ
      _ = c * ∑ j : Fin 0, x j := by rw [finset_sum_fin_real_eq_finite_sum_of_real_numbers.1 x]
                                                                              -- `def_finite_sum_of_real_numbers` の `Σ_{j=1}^{0} r_j := 0`（`r_j → x_j`）を右辺から左辺へ
  | succ m => exact finite_sum_of_real_scalar_multiples_succ m c x

/-- **`finite_sum_of_real_scalar_multiples`**（添字が有限型 `κ` の和）。
人手の和は添字 `1, …, m` の上の和なので、`κ` に `Fintype.equivFin κ` で番号を付け、`Fin (card κ)` の上の和として
`finite_sum_of_real_scalar_multiples` を当てる（番号を付ける段と外す段は mathlib の `Equiv.sum_comp` による）。 -/
theorem finite_sum_of_real_scalar_multiples_fintype {κ : Type*} [Fintype κ] (c : ℝ) (x : κ → ℝ) :
    ∑ j, c * x j = c * ∑ j, x j := by
  set e := Fintype.equivFin κ
  calc ∑ j, c * x j
      = ∑ j : Fin (Fintype.card κ), c * x (e.symm j) :=
        (e.symm.sum_comp (fun j => c * x j)).symm                             -- `κ` に番号を付ける
    _ = c * ∑ j : Fin (Fintype.card κ), x (e.symm j) :=
        finite_sum_of_real_scalar_multiples _ c (fun j => x (e.symm j))       -- `finite_sum_of_real_scalar_multiples`（`x_j → x(e^{-1}(j))`）
    _ = c * ∑ j, x j := by rw [e.symm.sum_comp x]                             -- 番号を外す

/-- **`finite_sum_of_nonnegative_reals_is_at_least_each_term`**（`m + 1` 項）:
すべての `a_j ≥ 0` なら、すべての `k` について `Σ_{j=1}^{m+1} a_j ≥ a_k`。`m` についての帰納法。 -/
theorem finite_sum_of_nonnegative_reals_ge_term_succ (m : ℕ) (a : Fin (m + 1) → ℝ)
    (ha : ∀ j, 0 ≤ a j) (k : Fin (m + 1)) : ∑ j, a j ≥ a k := by
  induction m with
  | zero =>
    have hk : k = 0 := Fin.fin_one_eq_zero k                                  -- 人手の `k = 1`
    calc ∑ j : Fin 1, a j
        = a 0 := Fin.sum_univ_one _                                          -- `def_finite_sum_of_real_numbers`
      _ = a k := by rw [hk]                                                   -- `k = 1`
      _ ≥ a k := le_refl _
  | succ m ih =>
    induction k using Fin.lastCases with
    | cast k' =>                                                              -- 人手の `k ≤ m`
      calc ∑ j : Fin (m + 2), a j
          = (∑ j : Fin (m + 1), a j.castSucc) + a (Fin.last _) :=
            Fin.sum_univ_castSucc _                                           -- `def_finite_sum_of_real_numbers`
        _ ≥ (∑ j : Fin (m + 1), a j.castSucc) + 0 :=
            add_le_add le_rfl (ha _)                                          -- `a_{m+1} ≥ 0` の両辺に同じ実数を足す
        _ = ∑ j : Fin (m + 1), a j.castSucc := add_zero _                     -- 0 は ℝ の和の単位元
        _ ≥ a k'.castSucc := ih (fun j => a j.castSucc) (fun j => ha _) k'    -- 帰納法の仮定（`k ≤ m`）
    | last =>                                                                 -- 人手の `k = m + 1`
      have h0 : ∑ j : Fin (m + 1), a j.castSucc ≥ 0 :=
        le_trans (ha (Fin.castSucc 0)) (ih (fun j => a j.castSucc) (fun j => ha _) 0)
                                                                              -- 帰納法の仮定を `k → 1` で使い、`a_1 ≥ 0`
      calc ∑ j : Fin (m + 2), a j
          = (∑ j : Fin (m + 1), a j.castSucc) + a (Fin.last _) :=
            Fin.sum_univ_castSucc _                                           -- `def_finite_sum_of_real_numbers`
        _ ≥ 0 + a (Fin.last _) := add_le_add h0 le_rfl                       -- `Σ_{j=1}^{m} a_j ≥ 0` の両辺に同じ実数を足す
        _ = a (Fin.last _) := zero_add _                                      -- 0 は ℝ の和の単位元

/-- **`finite_sum_of_nonnegative_reals_is_at_least_each_term`**（`Fin m` の上の和。`k : Fin m` があるので `m ≥ 1` である）。 -/
theorem finite_sum_of_nonnegative_reals_ge_term (m : ℕ) (a : Fin m → ℝ)
    (ha : ∀ j, 0 ≤ a j) (k : Fin m) : ∑ j, a j ≥ a k := by
  cases m with
  | zero => exact k.elim0
  | succ m => exact finite_sum_of_nonnegative_reals_ge_term_succ m a ha k

/-- **`finite_sum_of_nonnegative_reals_is_at_least_each_term`**（添字が有限型 `κ` の和）。
人手の和は添字 `1, …, m` の上の和なので、`κ` に `Fintype.equivFin κ` で番号を付け、`Fin (card κ)` の上の和として
`finite_sum_of_nonnegative_reals_ge_term` を当てる（番号を付ける段と外す段は mathlib の `Equiv.sum_comp` による）。 -/
theorem finite_sum_of_nonnegative_reals_ge_term_fintype {κ : Type*} [Fintype κ] (a : κ → ℝ)
    (ha : ∀ j, 0 ≤ a j) (k : κ) : ∑ j, a j ≥ a k := by
  set e := Fintype.equivFin κ
  calc ∑ j, a j
      = ∑ j : Fin (Fintype.card κ), a (e.symm j) := (e.symm.sum_comp a).symm  -- `κ` に番号を付ける
    _ ≥ a (e.symm (e k)) :=
        finite_sum_of_nonnegative_reals_ge_term _ (fun j => a (e.symm j)) (fun j => ha _) (e k)
                                                                              -- `finite_sum_of_nonnegative_reals_is_at_least_each_term`（`k → e(k)`）
    _ = a k := by rw [Equiv.symm_apply_apply]                                 -- 番号を外す

/-- **`finite_sum_of_real_numbers_triangle_inequality`**（`m + 1` 項）: `|Σ_{j=1}^{m+1} a_j| ≤ Σ_{j=1}^{m+1} |a_j|`。`m` についての帰納法。 -/
theorem finite_sum_of_real_numbers_triangle_inequality_succ (m : ℕ) (a : Fin (m + 1) → ℝ) :
    |∑ j, a j| ≤ ∑ j, |a j| := by
  induction m with
  | zero =>
    calc |∑ j : Fin 1, a j|
        = |a 0| := by rw [Fin.sum_univ_one]                                  -- `def_finite_sum_of_real_numbers`
      _ = ∑ j : Fin 1, |a j| := (Fin.sum_univ_one (fun j => |a j|)).symm      -- `def_finite_sum_of_real_numbers`（`r_j → |a_j|`）
      _ ≤ ∑ j : Fin 1, |a j| := le_rfl
  | succ m ih =>
    calc |∑ j : Fin (m + 2), a j|
        = |(∑ j : Fin (m + 1), a j.castSucc) + a (Fin.last _)| := by
          rw [Fin.sum_univ_castSucc]                                          -- `def_finite_sum_of_real_numbers`
      _ ≤ |∑ j : Fin (m + 1), a j.castSucc| + |a (Fin.last _)| :=
          real_abs_triangle_inequality _ _                                    -- `real_abs_triangle_inequality`（`a → Σ_{j=1}^{m} a_j`、`b → a_{m+1}`）
      _ ≤ (∑ j : Fin (m + 1), |a j.castSucc|) + |a (Fin.last _)| :=
          add_le_add (ih (fun j => a j.castSucc)) le_rfl                      -- 帰納法の仮定の両辺に `|a_{m+1}|` を足す
      _ = ∑ j, |a j| := (Fin.sum_univ_castSucc (fun j => |a j|)).symm         -- `def_finite_sum_of_real_numbers`（`r_j → |a_j|`）

/-- **`finite_sum_of_real_numbers_triangle_inequality`**（`m ∈ ℤ_{≥0}`）: `m = 0` の段は人手の `m = 0` の 3 行、`m ≥ 1` は `finite_sum_of_real_numbers_triangle_inequality_succ`。 -/
theorem finite_sum_of_real_numbers_triangle_inequality (m : ℕ) (a : Fin m → ℝ) :
    |∑ j, a j| ≤ ∑ j, |a j| := by
  cases m with
  | zero =>
    calc |∑ j : Fin 0, a j|
        = |(0 : ℝ)| := by rw [finset_sum_fin_real_eq_finite_sum_of_real_numbers.1 a]   -- `def_finite_sum_of_real_numbers` の `Σ_{j=1}^{0} r_j := 0`（`r_j → a_j`）
      _ = 0 := abs_of_nonneg le_rfl                                           -- `def_real_absolute_value`（`q → 0`）の `q ≥ 0` の場合
      _ = ∑ j : Fin 0, |a j| := (finset_sum_fin_real_eq_finite_sum_of_real_numbers.1 (fun j => |a j|)).symm
                                                                              -- `def_finite_sum_of_real_numbers` の `Σ_{j=1}^{0} r_j := 0`（`r_j → |a_j|`）を右辺から左辺へ
      _ ≤ ∑ j : Fin 0, |a j| := le_rfl                                        -- 人手の「だから成り立つ」（等号の鎖を `≤` へ移す。`m = 1` の段と同じ扱い）
  | succ m => exact finite_sum_of_real_numbers_triangle_inequality_succ m a

/-- **`finite_sum_of_real_numbers_triangle_inequality`**（添字が有限型 `κ` の和）。
`κ` に `Fintype.equivFin κ` で番号を付け、`Fin (card κ)` の上の和として当てる（番号を付ける段と外す段は mathlib の `Equiv.sum_comp` による）。 -/
theorem finite_sum_of_real_numbers_triangle_inequality_fintype {κ : Type*} [Fintype κ] (a : κ → ℝ) :
    |∑ j, a j| ≤ ∑ j, |a j| := by
  set e := Fintype.equivFin κ
  calc |∑ j, a j|
      = |∑ j : Fin (Fintype.card κ), a (e.symm j)| := by rw [e.symm.sum_comp a]  -- `κ` に番号を付ける
    _ ≤ ∑ j : Fin (Fintype.card κ), |a (e.symm j)| :=
        finite_sum_of_real_numbers_triangle_inequality _ _                    -- `finite_sum_of_real_numbers_triangle_inequality`
    _ = ∑ j, |a j| := e.symm.sum_comp (fun j => |a j|)                        -- 番号を外す

/-- **`finite_sum_of_real_numbers_is_monotone`**（`m + 1` 項）: すべての `j` で `a_j ≤ b_j` なら `Σ a_j ≤ Σ b_j`。`m` についての帰納法。 -/
theorem finite_sum_of_real_numbers_is_monotone_succ (m : ℕ) (a b : Fin (m + 1) → ℝ)
    (hab : ∀ j, a j ≤ b j) : ∑ j, a j ≤ ∑ j, b j := by
  induction m with
  | zero =>
    calc ∑ j : Fin 1, a j
        = a 0 := Fin.sum_univ_one _                                          -- `def_finite_sum_of_real_numbers`
      _ ≤ b 0 := hab 0                                                        -- 仮定 `a_1 ≤ b_1`
      _ = ∑ j : Fin 1, b j := (Fin.sum_univ_one _).symm                       -- `def_finite_sum_of_real_numbers`
  | succ m ih =>
    calc ∑ j : Fin (m + 2), a j
        = (∑ j : Fin (m + 1), a j.castSucc) + a (Fin.last _) :=
          Fin.sum_univ_castSucc _                                             -- `def_finite_sum_of_real_numbers`
      _ ≤ (∑ j : Fin (m + 1), b j.castSucc) + a (Fin.last _) :=
          add_le_add (ih (fun j => a j.castSucc) (fun j => b j.castSucc) (fun j => hab _)) le_rfl
                                                                              -- 帰納法の仮定の両辺に `a_{m+1}` を足す
      _ ≤ (∑ j : Fin (m + 1), b j.castSucc) + b (Fin.last _) :=
          add_le_add le_rfl (hab _)                                           -- `a_{m+1} ≤ b_{m+1}` の両辺に `Σ_{j=1}^{m} b_j` を足す
      _ = ∑ j, b j := (Fin.sum_univ_castSucc b).symm                          -- `def_finite_sum_of_real_numbers`

/-- **`finite_sum_of_real_numbers_is_monotone`**（`m ∈ ℤ_{≥0}`）: `m = 0` の段は人手の `m = 0` の 2 行、`m ≥ 1` は `finite_sum_of_real_numbers_is_monotone_succ`。 -/
theorem finite_sum_of_real_numbers_is_monotone (m : ℕ) (a b : Fin m → ℝ)
    (hab : ∀ j, a j ≤ b j) : ∑ j, a j ≤ ∑ j, b j := by
  cases m with
  | zero =>
    calc ∑ j : Fin 0, a j
        = 0 := finset_sum_fin_real_eq_finite_sum_of_real_numbers.1 a                    -- `def_finite_sum_of_real_numbers` の `Σ_{j=1}^{0} r_j := 0`（`r_j → a_j`）
      _ = ∑ j : Fin 0, b j := (finset_sum_fin_real_eq_finite_sum_of_real_numbers.1 b).symm
                                                                              -- `def_finite_sum_of_real_numbers` の `Σ_{j=1}^{0} r_j := 0`（`r_j → b_j`）を右辺から左辺へ
      _ ≤ ∑ j : Fin 0, b j := le_rfl                                          -- 人手の「だから成り立つ」（等号の鎖を `≤` へ移す）
  | succ m => exact finite_sum_of_real_numbers_is_monotone_succ m a b hab

/-- **`finite_sum_of_real_numbers_is_monotone`**（添字が有限型 `κ` の和）。番号の付け方は
`finite_sum_of_real_numbers_triangle_inequality_fintype` と同じ。 -/
theorem finite_sum_of_real_numbers_is_monotone_fintype {κ : Type*} [Fintype κ] (a b : κ → ℝ)
    (hab : ∀ j, a j ≤ b j) : ∑ j, a j ≤ ∑ j, b j := by
  set e := Fintype.equivFin κ
  calc ∑ j, a j
      = ∑ j : Fin (Fintype.card κ), a (e.symm j) := (e.symm.sum_comp a).symm  -- `κ` に番号を付ける
    _ ≤ ∑ j : Fin (Fintype.card κ), b (e.symm j) :=
        finite_sum_of_real_numbers_is_monotone _ _ _ (fun j => hab _)         -- `finite_sum_of_real_numbers_is_monotone`
    _ = ∑ j, b j := e.symm.sum_comp b                                         -- 番号を外す

/-- **`finite_sum_of_real_numbers_moves_one_term_to_end`**: `Σ_{j=1}^{m+1} b_j = (Σ_{j=1}^{m} b_{δ^{m}_{k}(j)}) + b_k`。
人手の `m ≥ 1` は Lean の `n + 1`（`b : Fin (n + 2) → ℝ`）。`n` についての帰納法（人手の `m` についての帰納法）。 -/
theorem finite_sum_of_real_numbers_moves_one_term_to_end (n : ℕ) (b : Fin (n + 2) → ℝ) (k : Fin (n + 2)) :
    ∑ j, b j = (∑ j : Fin (n + 1), b (skipIndex k j)) + b k := by
  induction n with
  | zero =>                                                                   -- 人手の `m = 1`
    induction k using Fin.lastCases with
    | cast k' =>                                                              -- 人手の `k = 1`
      have hk' : k' = 0 := Fin.fin_one_eq_zero k'
      subst hk'
      have hδ : skipIndex (Fin.castSucc (0 : Fin 1)) (0 : Fin 1) = Fin.last 1 :=
        skipIndex_of_le _ _ (le_refl _)                                       -- `1 ≥ 1` なので `δ^{1}_{1}(1) = 2`
      calc ∑ j : Fin 2, b j
          = (∑ j : Fin 1, b j.castSucc) + b (Fin.last 1) :=
            Fin.sum_univ_castSucc _                                           -- `def_finite_sum_of_real_numbers`
        _ = b (Fin.castSucc 0) + b (Fin.last 1) := by
            rw [Fin.sum_univ_one]                                             -- `def_finite_sum_of_real_numbers`
        _ = b (Fin.last 1) + b (Fin.castSucc 0) := add_comm _ _               -- ℝ の和の交換律
        _ = b (skipIndex (Fin.castSucc (0 : Fin 1)) 0) + b (Fin.castSucc 0) := by
            rw [hδ]                                                           -- `δ^{1}_{1}(1) = 2`
        _ = (∑ j : Fin 1, b (skipIndex (Fin.castSucc (0 : Fin 1)) j)) + b (Fin.castSucc 0) := by
            rw [Fin.sum_univ_one]                                             -- `def_finite_sum_of_real_numbers` を右辺から左辺へ
                                                                              -- 人手の最後の行 `k = 1` は、Lean では `k` を `castSucc 0` に置き換え済みなので段にしない
    | last =>                                                                 -- 人手の `k = 2`
      have hδ : ∀ j : Fin 1, skipIndex (Fin.last 1) j = j.castSucc :=
        fun j => skipIndex_of_lt _ _ j.isLt                                   -- `1 < 2` なので `δ^{1}_{2}(1) = 1`
      calc ∑ j : Fin 2, b j
          = (∑ j : Fin 1, b j.castSucc) + b (Fin.last 1) :=
            Fin.sum_univ_castSucc _                                           -- `def_finite_sum_of_real_numbers`
        _ = (∑ j : Fin 1, b (skipIndex (Fin.last 1) j)) + b (Fin.last 1) := by
            simp only [hδ]                                                    -- `δ^{1}_{2}(1) = 1`
                                                                              -- 人手の最後の行 `k = 2` は、Lean では `k` を `last 1` に置き換え済みなので段にしない
  | succ n ih =>                                                              -- 人手の `m → m + 1`（人手の `m` が Lean の `n + 1`）
    induction k using Fin.lastCases with
    | last =>                                                                 -- 人手の `k = m + 2`
      have hδ : ∀ j : Fin (n + 2), skipIndex (Fin.last (n + 2)) j = j.castSucc :=
        fun j => skipIndex_of_lt _ _ j.isLt                                   -- `j < m + 2` なので `δ^{m+1}_{m+2}(j) = j`
      calc ∑ j : Fin (n + 3), b j
          = (∑ j : Fin (n + 2), b j.castSucc) + b (Fin.last _) :=
            Fin.sum_univ_castSucc _                                           -- `def_finite_sum_of_real_numbers`
        _ = (∑ j : Fin (n + 2), b (skipIndex (Fin.last (n + 2)) j)) + b (Fin.last _) := by
            simp only [hδ]                                                    -- `δ^{m+1}_{m+2}(j) = j` を各項へ
    | cast k' =>                                                              -- 人手の `k ≤ m + 1`
      have hδ : ∀ j : Fin (n + 1),
          skipIndex k'.castSucc j.castSucc = (skipIndex k' j).castSucc := by
        intro j                                                               -- `j ≤ m` で `δ^{m+1}_{k}(j) = δ^{m}_{k}(j)`（`j < k` と `j ≥ k` の 2 本の鎖。`by_cases` の 2 枝）
        by_cases h : j.val < k'.val
        · rw [skipIndex_of_lt k'.castSucc j.castSucc h, skipIndex_of_lt k' j h]
        · rw [skipIndex_of_le k'.castSucc j.castSucc (Nat.le_of_not_lt h),
            skipIndex_of_le k' j (Nat.le_of_not_lt h)]; rfl
      have hδlast : skipIndex k'.castSucc (Fin.last (n + 1)) = Fin.last (n + 2) :=
        skipIndex_of_le _ _ (Nat.le_of_lt_succ k'.isLt)                       -- `m + 1 ≥ k` なので `δ^{m+1}_{k}(m+1) = m + 2`
      let s : ℝ := ∑ j : Fin (n + 1), b (skipIndex k' j).castSucc            -- `s := Σ_{j=1}^{m} b_{δ^{m}_{k}(j)}`
      calc ∑ j : Fin (n + 3), b j
          = (∑ j : Fin (n + 2), b j.castSucc) + b (Fin.last _) :=
            Fin.sum_univ_castSucc _                                           -- `def_finite_sum_of_real_numbers`
        _ = ((∑ j : Fin (n + 1), b (skipIndex k' j).castSucc) + b k'.castSucc) + b (Fin.last _) := by
            rw [ih (fun j => b j.castSucc) k']                                -- 帰納法の仮定（`b_1, …, b_{m+1}` と `k`）
        _ = (s + b k'.castSucc) + b (Fin.last _) := rfl                       -- `s` の置き方
        _ = s + (b k'.castSucc + b (Fin.last _)) := add_assoc _ _ _           -- ℝ の和の結合律
        _ = s + (b (Fin.last _) + b k'.castSucc) := by
            rw [add_comm (b k'.castSucc)]                                     -- ℝ の和の交換律
        _ = (s + b (Fin.last _)) + b k'.castSucc := (add_assoc _ _ _).symm    -- ℝ の和の結合律
        _ = ((∑ j : Fin (n + 1), b (skipIndex k' j).castSucc) + b (Fin.last _))
              + b k'.castSucc := rfl                                          -- `s` の置き方
        _ = ((∑ j : Fin (n + 1), b (skipIndex k'.castSucc j.castSucc)) + b (Fin.last _))
              + b k'.castSucc := by
            simp only [hδ]                                                    -- `δ^{m}_{k}(j) = δ^{m+1}_{k}(j)` を各項へ
        _ = ((∑ j : Fin (n + 1), b (skipIndex k'.castSucc j.castSucc))
              + b (skipIndex k'.castSucc (Fin.last (n + 1)))) + b k'.castSucc := by
            rw [hδlast]                                                       -- `δ^{m+1}_{k}(m+1) = m + 2`
        _ = (∑ j : Fin (n + 2), b (skipIndex k'.castSucc j)) + b k'.castSucc := by
            rw [Fin.sum_univ_castSucc (fun j => b (skipIndex k'.castSucc j))] -- `def_finite_sum_of_real_numbers` を右辺から左辺へ


/-- **人手 `finite_sum_of_real_numbers_with_single_nonzero_term`**: `j ≠ k` のすべての `j` で `r_j = 0` なら `Σ_{j=1}^{m} r_j = r_k`
（`m ∈ ℤ_{≥1}` は Lean の `m + 1`）。`m` についての帰納法。人手と同じく、`k = m + 1` の場合は零の有限和を経ず、
帰納法の仮定を `k → 1`（Lean の `0`）へ当てる。 -/
theorem finite_sum_of_real_numbers_with_single_nonzero_term_succ :
    ∀ (m : ℕ) (r : Fin (m + 1) → ℝ) (k : Fin (m + 1)), (∀ j, j ≠ k → r j = 0) → ∑ j, r j = r k
  | 0, r, k, _ =>                                                                  -- 人手の `m = 1`
    calc ∑ j : Fin 1, r j
        = r 0 := Fin.sum_univ_one r                                                -- `def_finite_sum_of_real_numbers` の `Σ_{j=1}^{1} r_j := r_1`
      _ = r k := by rw [Fin.fin_one_eq_zero k]                                     -- `k = 1`
  | m + 1, r, k, hr => by                                                          -- 人手の `m → m + 1`
    rcases (Fin.eq_castSucc_or_eq_last k).symm with hk | ⟨k', rfl⟩
    · -- 人手の `k = m + 1` の場合: `r_1, …, r_m` と `1` は帰納法の仮定の仮定を満たし、`1 ≠ m + 1 = k` なので `r_1 = 0`
      have hfirst : r (Fin.castSucc 0) = 0 := hr _ (hk ▸ (Fin.castSucc_lt_last 0).ne)
      calc ∑ j : Fin (m + 2), r j
          = (∑ j : Fin (m + 1), r (Fin.castSucc j)) + r (Fin.last (m + 1)) :=
            Fin.sum_univ_castSucc r                                                -- `def_finite_sum_of_real_numbers` の `Σ_{j=1}^{m+1} r_j := (Σ_{j=1}^{m} r_j) + r_{m+1}`
        _ = r (Fin.castSucc 0) + r (Fin.last (m + 1)) := by
            rw [finite_sum_of_real_numbers_with_single_nonzero_term_succ m (fun j => r (Fin.castSucc j)) 0
              (fun j hj => hr _ (hk ▸ (Fin.castSucc_lt_last j).ne))]              -- 帰納法の仮定を `r_1, …, r_m` と `k → 1` へ
        _ = 0 + r (Fin.last (m + 1)) := by rw [hfirst]                             -- `r_1 = 0`
        _ = r (Fin.last (m + 1)) := zero_add _                                     -- `0` は `ℝ` の和の単位元
        _ = r k := by rw [hk]                                                      -- `k = m + 1`
    · -- 人手の `k ∈ {1, …, m}` の場合: `m + 1 ≠ k` なので `r_{m+1} = 0`
      have hlast : r (Fin.last (m + 1)) = 0 := hr _ (Fin.castSucc_lt_last k').ne'
      calc ∑ j : Fin (m + 2), r j
          = (∑ j : Fin (m + 1), r (Fin.castSucc j)) + r (Fin.last (m + 1)) :=
            Fin.sum_univ_castSucc r                                                -- `def_finite_sum_of_real_numbers` の `Σ_{j=1}^{m+1} r_j := (Σ_{j=1}^{m} r_j) + r_{m+1}`
        _ = r (Fin.castSucc k') + r (Fin.last (m + 1)) := by
            rw [finite_sum_of_real_numbers_with_single_nonzero_term_succ m (fun j => r (Fin.castSucc j)) k'
              (fun j hj => hr _ (fun h => hj (Fin.castSucc_injective _ h)))]      -- 帰納法の仮定を `r_1, …, r_m` と `k` へ
        _ = r (Fin.castSucc k') + 0 := by rw [hlast]                               -- `r_{m+1} = 0`
        _ = r (Fin.castSucc k') := add_zero _                                      -- `0` は `ℝ` の和の単位元

end Ising2D
