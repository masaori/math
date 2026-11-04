/-
# 実数の差・符号反転の有限和と、非負の実数の有限和の下からの評価（**具体版**）

対応する人手証明のラベル: `def_finite_sum_of_real_numbers`, `finite_sum_of_real_differences`,
`finite_sum_of_negated_real_numbers`, `finite_sum_of_nonnegative_reals_is_at_least_each_term`
（`structured-latex/content/000_calculation_formulae_00_09.ts` の `calc_formulae_definition_finite_sum_of_real_numbers`,
`calc_formulae_claim_finite_sum_of_real_differences`, `calc_formulae_claim_finite_sum_of_negated_real_numbers`,
`calc_formulae_claim_finite_sum_of_nonnegative_reals_is_at_least_each_term`）。

**必要十分版**: `Ising2D/NecSuf/FiniteSumDifferenceAndNonnegativeTerm.lean`。具体版をその系として導くのは
`ClaimFiniteSumsOfRealNumbersFromNecSuf.lean`。

## 人手証明との対応

* 人手の `m ∈ ℤ_{≥1}` 項の和は、Lean では `Fin (m + 1)` の上の和（`m` についての帰納法）で書く。人手の `m` が Lean の `m + 1` に当たる。
  `def_finite_sum_of_real_numbers` の 2 つの式は `Fin.sum_univ_one`・`Fin.sum_univ_castSucc` で出す
  （mathlib の `Finset.sum` を人手の左から足す和の定義へ読み替える段）。人手の添字 `j ∈ {1, …, m+1}` は Lean の `Fin (m + 1)` の `j - 1`、
  `j = m + 1` は `Fin.last`、`j ≤ m` は `Fin.castSucc` である。
* `finite_sum_of_real_differences_succ` の帰納法の段の calc は人手の 5 行と対応する。人手の 1 行「ℝ の和と差の計算」は
  `finite_sum_of_real_differences_step`（差を符号反転の和に直す・結合則と交換則・和の符号反転の 4 段）。
  人手の「`α, β` の置き方」の行は、Lean では `α, β` を置かずに `Σ_{j=1}^{m}` のまま書くので、その前の段の右辺と同じ式になり段にしない。`m = 0`（空の和）は人手には無い（`finite_sum_of_real_differences`）。
* `finite_sum_of_negated_real_numbers_succ` の `m = 1` の 2 行と帰納法の段の 4 行は、人手の行と 1 対 1 の `calc` である。
  人手の 1 行「ℝ で `(−a) + (−b) = −(a + b)`」は mathlib の `neg_add` を右辺から左辺へ使う 1 段である。`m = 0`（空の和）は人手には無い（`finite_sum_of_negated_real_numbers`）。
* `finite_sum_of_nonnegative_reals_ge_term_succ` は人手と同じく、`k ≤ m`（Lean の `Fin.castSucc k'`）と `k = m + 1`（`Fin.last`）に分け、
  それぞれ人手の 4 行と 1 対 1 の `calc` にした。`k = m + 1` の前置き `Σ_{j=1}^{m} a_j ≥ a_1 ≥ 0` は帰納法の仮定を `k → 1`（Lean の `0`）で使う。
  「両辺に同じ実数を足す」は `add_le_add` の片方を `le_rfl` にしたもの、「0 は ℝ の和の単位元」は `add_zero`・`zero_add` である。
-/
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Data.Real.Basic

namespace Ising2D

/-- **`finite_sum_of_real_differences`** の帰納法の段の「ℝ の和と差の計算」: `(α - β) + (x - y) = (α + x) - (β + y)`。 -/
theorem finite_sum_of_real_differences_step (α β x y : ℝ) :
    (α - β) + (x - y) = (α + x) - (β + y) :=
  calc (α - β) + (x - y)
      = (α + -β) + (x + -y) := by rw [sub_eq_add_neg α β, sub_eq_add_neg x y]   -- 差は符号反転を足すこと（2 か所）
    _ = (α + x) + (-β + -y) := add_add_add_comm _ _ _ _                         -- 和の結合則・交換則
    _ = (α + x) + -(β + y) := by rw [neg_add β y]                               -- 和の符号反転は符号反転の和
    _ = (α + x) - (β + y) := (sub_eq_add_neg _ _).symm                          -- 差は符号反転を足すこと

/-- **`finite_sum_of_real_differences`**（`m + 1` 項）: `Σ_{j=1}^{m+1}(a_j - b_j) = Σ a_j - Σ b_j`。`m` についての帰納法。 -/
theorem finite_sum_of_real_differences_succ (m : ℕ) (a b : Fin (m + 1) → ℝ) :
    ∑ j, (a j - b j) = (∑ j, a j) - ∑ j, b j := by
  induction m with
  | zero =>
    calc ∑ j : Fin 1, (a j - b j)
        = a 0 - b 0 := Fin.sum_univ_one _                                    -- `def_finite_sum_of_real_numbers`
      _ = (∑ j : Fin 1, a j) - ∑ j : Fin 1, b j := by
          rw [Fin.sum_univ_one a, Fin.sum_univ_one b]                         -- 同上を 2 か所
  | succ m ih =>
    calc ∑ j : Fin (m + 2), (a j - b j)
        = (∑ j : Fin (m + 1), (a j.castSucc - b j.castSucc)) + (a (Fin.last _) - b (Fin.last _)) :=
          Fin.sum_univ_castSucc _                                             -- `def_finite_sum_of_real_numbers`
      _ = ((∑ j : Fin (m + 1), a j.castSucc) - ∑ j : Fin (m + 1), b j.castSucc)
            + (a (Fin.last _) - b (Fin.last _)) := by
          rw [ih (fun j => a j.castSucc) (fun j => b j.castSucc)]             -- 帰納法の仮定
      _ = ((∑ j : Fin (m + 1), a j.castSucc) + a (Fin.last _))
            - ((∑ j : Fin (m + 1), b j.castSucc) + b (Fin.last _)) :=
          finite_sum_of_real_differences_step _ _ _ _                          -- ℝ の和と差の計算
      _ = (∑ j, a j) - ∑ j, b j := by
          rw [Fin.sum_univ_castSucc a, Fin.sum_univ_castSucc b]               -- `α, β` の置き方と `def_finite_sum_of_real_numbers` を 2 か所

/-- **`finite_sum_of_real_differences`**（`m = 0` の空の和を含む。`m = 0` は人手には無い）。 -/
theorem finite_sum_of_real_differences (m : ℕ) (a b : Fin m → ℝ) :
    ∑ j, (a j - b j) = (∑ j, a j) - ∑ j, b j := by
  cases m with
  | zero => rw [Fin.sum_univ_zero, Fin.sum_univ_zero, Fin.sum_univ_zero, sub_zero]
  | succ m => exact finite_sum_of_real_differences_succ m a b

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
          (neg_add _ _).symm                                                  -- ℝ で `(−a) + (−b) = −(a + b)`
      _ = -(∑ j, x j) := by rw [Fin.sum_univ_castSucc x]                      -- `def_finite_sum_of_real_numbers` を右辺から左辺へ

/-- **`finite_sum_of_negated_real_numbers`**（`m = 0` の空の和を含む。`m = 0` は人手には無い）。 -/
theorem finite_sum_of_negated_real_numbers (m : ℕ) (x : Fin m → ℝ) :
    ∑ j, -(x j) = -(∑ j, x j) := by
  cases m with
  | zero => rw [Fin.sum_univ_zero, Fin.sum_univ_zero, neg_zero]
  | succ m => exact finite_sum_of_negated_real_numbers_succ m x

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

end Ising2D
