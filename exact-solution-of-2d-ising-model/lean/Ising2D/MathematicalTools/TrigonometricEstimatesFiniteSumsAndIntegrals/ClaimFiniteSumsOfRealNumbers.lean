/-
# 実数の差・符号反転・共通の因子の有限和、非負の実数の有限和の下からの評価、有限和の三角不等式と項ごとの大小（**具体版**）

対応する人手証明のラベル: `def_finite_sum_of_real_numbers`, `finite_sum_of_real_differences`,
`finite_sum_of_negated_real_numbers`, `finite_sum_of_real_scalar_multiples`, `finite_sum_of_nonnegative_reals_is_at_least_each_term`,
`finite_sum_of_real_numbers_triangle_inequality`, `finite_sum_of_real_numbers_is_monotone`,
`finite_sum_of_real_numbers_moves_one_term_to_end`
（`structured-latex/content/000_calculation_formulae_00_09.ts` の `calc_formulae_definition_finite_sum_of_real_numbers`,
`calc_formulae_claim_finite_sum_of_real_differences`, `calc_formulae_claim_finite_sum_of_negated_real_numbers`,
`calc_formulae_claim_finite_sum_of_real_scalar_multiples`,
`calc_formulae_claim_finite_sum_of_nonnegative_reals_is_at_least_each_term`,
`calc_formulae_claim_finite_sum_of_real_numbers_triangle_inequality`, `calc_formulae_claim_finite_sum_of_real_numbers_is_monotone`,
`calc_formulae_claim_finite_sum_of_real_numbers_moves_one_term_to_end`）。

**必要十分版**: `Ising2D/NecSuf/FiniteSumDifferenceAndNonnegativeTerm.lean`（一つの項を末尾へ移す主張は `Ising2D/NecSuf/FiniteSumMovesOneTermToEnd.lean`）。具体版をその系として導くのは
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
* `finite_sum_of_real_scalar_multiples_succ` の `m = 1` の 2 行と帰納法の段の 4 行は、人手の行と 1 対 1 の `calc` である。
  人手の 1 行「ℝ の分配法則 `ca + cb = c(a + b)`」は mathlib の `mul_add` を右辺から左辺へ使う 1 段である。`m = 0`（空の和）は人手には無い（`finite_sum_of_real_scalar_multiples`）。
  有限型の添字の和には、`finite_sum_of_nonnegative_reals_ge_term_fintype` と同じく番号を付けて当てる `finite_sum_of_real_scalar_multiples_fintype` を置く。
* `finite_sum_of_nonnegative_reals_ge_term_succ` は人手と同じく、`k ≤ m`（Lean の `Fin.castSucc k'`）と `k = m + 1`（`Fin.last`）に分け、
  それぞれ人手の 4 行と 1 対 1 の `calc` にした。`k = m + 1` の前置き `Σ_{j=1}^{m} a_j ≥ a_1 ≥ 0` は帰納法の仮定を `k → 1`（Lean の `0`）で使う。
  「両辺に同じ実数を足す」は `add_le_add` の片方を `le_rfl` にしたもの、「0 は ℝ の和の単位元」は `add_zero`・`zero_add` である。
* `finite_sum_of_real_numbers_triangle_inequality_succ` と `finite_sum_of_real_numbers_is_monotone_succ` は、`m = 1` の 2 行・3 行と帰納法の段の 4 行が
  人手の行と 1 対 1 の `calc` である（三角不等式の `m = 1` は人手の等号の 2 行に、`≤` へ移す `le_rfl` を 1 段足した）。
  帰納法の段の三角不等式は `real_abs_triangle_inequality`（`ClaimRealAbsoluteValueBoundsTriangleAndProduct.lean`）を引く。
  `_fintype` 版は `finite_sum_of_nonnegative_reals_ge_term_fintype` と同じく、有限型の添字に番号を付けて当てる。
* `finite_sum_of_real_numbers_moves_one_term_to_end` は人手の `m ≥ 1` を Lean の `n + 1` で書き、`δ^{m}_{k}` は `skipIndex k`
  （`DefinitionIndexSkippingMap.lean`）である。人手と同じく `m = 1` を `k = 1`（Lean の `castSucc 0`）・`k = 2`（`last 1`）に、
  帰納法の段を `k = m + 2`（`Fin.last`）・`k ≤ m + 1`（`Fin.castSucc k'`）に分け、各場合の前置き（`δ` の値）を `have` に、鎖を人手の行と 1 対 1 の `calc` にした。
  人手の `{1, …, m+1} ⊂ {1, …, m+2}` の包含は `Fin.castSucc` で、人手の前置き `δ^{m+1}_{k}(j) = δ^{m}_{k}(j)` は Lean では
  `skipIndex k'.castSucc j.castSucc = (skipIndex k' j).castSucc` になる。各場合の最後の行「`k = 1`」「`k = 2`」「`k = m + 2`」は、
  Lean では `k` を場合分けで置き換え済みなので段にしない。`s` の置き方は `let` で、置き方の段は `rfl` である。
-/
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Data.Real.Basic
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimRealAbsoluteValueBoundsTriangleAndProduct
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.DefinitionIndexSkippingMap

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
          (mul_add _ _ _).symm                                                -- ℝ の分配法則 `ca + cb = c(a + b)`
      _ = c * ∑ j, x j := by rw [Fin.sum_univ_castSucc x]                     -- `def_finite_sum_of_real_numbers` を右辺から左辺へ

/-- **`finite_sum_of_real_scalar_multiples`**（`m = 0` の空の和を含む。`m = 0` は人手には無い）。 -/
theorem finite_sum_of_real_scalar_multiples (m : ℕ) (c : ℝ) (x : Fin m → ℝ) :
    ∑ j, c * x j = c * ∑ j, x j := by
  cases m with
  | zero => rw [Fin.sum_univ_zero, Fin.sum_univ_zero, mul_zero]
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

/-- **`finite_sum_of_real_numbers_triangle_inequality`**（`m = 0` の空の和を含む。`m = 0` は人手には無い）。 -/
theorem finite_sum_of_real_numbers_triangle_inequality (m : ℕ) (a : Fin m → ℝ) :
    |∑ j, a j| ≤ ∑ j, |a j| := by
  cases m with
  | zero => rw [Fin.sum_univ_zero, Fin.sum_univ_zero, abs_zero]
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

/-- **`finite_sum_of_real_numbers_is_monotone`**（`m = 0` の空の和を含む。`m = 0` は人手には無い）。 -/
theorem finite_sum_of_real_numbers_is_monotone (m : ℕ) (a b : Fin m → ℝ)
    (hab : ∀ j, a j ≤ b j) : ∑ j, a j ≤ ∑ j, b j := by
  cases m with
  | zero => rw [Fin.sum_univ_zero, Fin.sum_univ_zero]
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
        _ = b (Fin.last 1) + b (Fin.castSucc 0) := add_comm _ _               -- ℝ の和の交換法則
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
        _ = s + (b k'.castSucc + b (Fin.last _)) := add_assoc _ _ _           -- ℝ の和の結合法則
        _ = s + (b (Fin.last _) + b k'.castSucc) := by
            rw [add_comm (b k'.castSucc)]                                     -- ℝ の和の交換法則
        _ = (s + b (Fin.last _)) + b k'.castSucc := (add_assoc _ _ _).symm    -- ℝ の和の結合法則
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

end Ising2D
