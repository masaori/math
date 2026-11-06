/-
# 実数の有限和は添字の全単射による付け替えで変わらない（**具体版**）

対応する人手証明のラベル: `finite_sum_of_real_numbers_is_invariant_under_bijective_reindexing`
（`structured-latex/content/000_calculation_formulae_00_09.ts` の
`calc_formulae_claim_finite_sum_of_real_numbers_is_invariant_under_bijective_reindexing`）。

## 人手証明との対応

* 人手の `m ∈ ℤ_{≥1}` は Lean の `n + 1` で、`a_1, …, a_m ∈ ℝ` は `a : Fin (n + 1) → ℝ`、
  `π : {1, …, m} → {1, …, m}` は `π : Fin (n + 1) → Fin (n + 1)`、人手の「全単射」は `Function.Bijective π` である。
  人手の `m` についての帰納法は `n` についての帰納法で、帰納法の仮定はすべての `a` と全単射 `π` についての主張である。
* 人手の `m = 1` の段: `π(1) ∈ {1}` から `π(1) = 1`（Lean の `Fin.fin_one_eq_zero`）を前置きにし、鎖の 3 行を `calc` の 3 段にした。
* 人手の `m → m + 1` の段: `π` は全射なので `π(k) = m + 1` の `k` を取る（`hπ.2 (Fin.last _)`）。`b_j := a_{π(j)}` は `let` で、
  置き方の段は `rfl` である。鎖の 7 行を `calc` の 7 段にした。
  - `finite_sum_of_real_numbers_moves_one_term_to_end` は `ClaimFiniteSumsOfRealNumbers.lean`、
    `def_bijection_composed_with_index_skipping_map` の式は `bijectionCompSkipIndex_castSucc`、
    `bijection_composed_with_index_skipping_map_is_bijective` は `bijectionCompSkipIndex_bijective`
    （`ClaimBijectionComposedWithIndexSkippingMap.lean`）である。
  - 人手は `τ^{π}_{k}(j)` を `{1, …, m}` の元として `a` の添字に使う。Lean では `{1, …, m} ⊂ {1, …, m+1}` の包含 `Fin.castSucc` を通して
    `a (τ j).castSucc` と書く。帰納法の仮定に渡す列は、人手の `a_1, …, a_m`（`a` の最初の `m` 項）に当たる `fun i => a i.castSucc` である。
* **必要十分版**: `Ising2D/NecSuf/FiniteSumReindexedByBijection.lean`（加法の可換モノイドだけ）。具体版をその特殊化として得ることは
  `ClaimFiniteSumOfRealNumbersReindexedByBijectionFromNecSuf.lean` に書く。
-/
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimFiniteSumsOfRealNumbers
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimBijectionComposedWithIndexSkippingMap

namespace Ising2D

/-- **`finite_sum_of_real_numbers_is_invariant_under_bijective_reindexing`**:
`π : {1, …, m} → {1, …, m}` が全単射なら `Σ_{j=1}^{m} a_{π(j)} = Σ_{j=1}^{m} a_j`。
人手の `m ≥ 1` は Lean の `n + 1`。`n` についての帰納法（人手の `m` についての帰納法）。 -/
theorem finite_sum_of_real_numbers_is_invariant_under_bijective_reindexing (n : ℕ) (a : Fin (n + 1) → ℝ)
    (π : Fin (n + 1) → Fin (n + 1)) (hπ : Function.Bijective π) :
    ∑ j, a (π j) = ∑ j, a j := by
  induction n with
  | zero =>                                                                   -- 人手の `m = 1`
    have hπ1 : π 0 = 0 := Fin.fin_one_eq_zero (π 0)                           -- `π(1) ∈ {1}` なので `π(1) = 1`
    calc ∑ j : Fin 1, a (π j)
        = a (π 0) := Fin.sum_univ_one _                                       -- `def_finite_sum_of_real_numbers`
      _ = a 0 := by rw [hπ1]                                                  -- `π(1) = 1`
      _ = ∑ j : Fin 1, a j := (Fin.sum_univ_one a).symm                       -- `def_finite_sum_of_real_numbers` を右辺から左辺へ
  | succ n ih =>                                                              -- 人手の `m → m + 1`
    obtain ⟨k, hk⟩ := hπ.2 (Fin.last (n + 1))                                 -- `π` は全射なので `π(k) = m + 1` の `k` がある
    let b : Fin (n + 2) → ℝ := fun j => a (π j)                               -- `b_j := a_{π(j)}`
    calc ∑ j, a (π j)
        = ∑ j, b j := rfl                                                     -- `b` の置き方
      _ = (∑ j : Fin (n + 1), b (skipIndex k j)) + b k :=
          finite_sum_of_real_numbers_moves_one_term_to_end n b k              -- `finite_sum_of_real_numbers_moves_one_term_to_end`
      _ = (∑ j : Fin (n + 1), a (π (skipIndex k j))) + a (π k) := rfl         -- `b` の置き方
      _ = (∑ j : Fin (n + 1), a (bijectionCompSkipIndex π hπ k hk j).castSucc) + a (π k) := by
          simp only [bijectionCompSkipIndex_castSucc]                         -- `def_bijection_composed_with_index_skipping_map` を右辺から左辺へ
      _ = (∑ j : Fin (n + 1), a (bijectionCompSkipIndex π hπ k hk j).castSucc) + a (Fin.last (n + 1)) := by
          rw [hk]                                                             -- `π(k) = m + 1`
      _ = (∑ j : Fin (n + 1), a j.castSucc) + a (Fin.last (n + 1)) := by
          rw [ih (fun i => a i.castSucc) (bijectionCompSkipIndex π hπ k hk)
            (bijectionCompSkipIndex_bijective π hπ k hk)]                     -- 帰納法の仮定（`bijection_composed_with_index_skipping_map_is_bijective`）
      _ = ∑ j, a j := (Fin.sum_univ_castSucc a).symm                          -- `def_finite_sum_of_real_numbers` を右辺から左辺へ

/-- **`finite_sum_of_real_numbers_is_invariant_under_bijective_reindexing`**（添字が空でない有限型 `κ` の和）。
人手のベクトルは最初から `{1, …, m}` を添字に持つが、Lean のベクトルは有限型 `κ`（例えば `Conf M`）を添字に持つ。
この差を埋めるため、`κ` に固定した番号 `e`（`Fintype.equivFin κ`）を付けて `Fin m` の上の和へ移し、外す
（この 2 段は mathlib の `Equiv.sum_comp` によるが、人手のどの行にも当たらない番号付けの埋め合わせである）。
`π` による付け替えそのものは、`Fin m` の上の具体版 `finite_sum_of_real_numbers_is_invariant_under_bijective_reindexing` を
`e ∘ π ∘ e⁻¹` に当てて通す。`Equiv.ofBijective π hπ` を `Equiv.sum_comp` へ渡せば全体が 1 行で閉じるが、それは主張そのものの
mathlib 版への丸投げになるので使わない。 -/
theorem finite_sum_of_real_numbers_is_invariant_under_bijective_reindexing_fintype {κ : Type*} [Fintype κ]
    [Nonempty κ] (a : κ → ℝ) (π : κ → κ) (hπ : Function.Bijective π) :
    ∑ j, a (π j) = ∑ j, a j := by
  obtain ⟨n, hn⟩ : ∃ n, Fintype.card κ = n + 1 :=
    Nat.exists_eq_succ_of_ne_zero Fintype.card_ne_zero                       -- `κ` は空でないので `m = card κ ≥ 1`
  let e : κ ≃ Fin (n + 1) := (Fintype.equivFin κ).trans (finCongr hn)
  have he : Function.Bijective (fun i => e (π (e.symm i))) :=
    e.bijective.comp (hπ.comp e.symm.bijective)
  calc ∑ j, a (π j)
      = ∑ i : Fin (n + 1), a (π (e.symm i)) :=
        (e.symm.sum_comp (fun j => a (π j))).symm                             -- `κ` に番号を付ける
    _ = ∑ i : Fin (n + 1), (fun i => a (e.symm i)) (e (π (e.symm i))) := by
        simp only [Equiv.symm_apply_apply]                                    -- 番号を付けた列 `i ↦ a(e⁻¹(i))` の項として書く
    _ = ∑ i : Fin (n + 1), (fun i => a (e.symm i)) i :=
        finite_sum_of_real_numbers_is_invariant_under_bijective_reindexing n (fun i => a (e.symm i)) _ he
                                                                              -- `finite_sum_of_real_numbers_is_invariant_under_bijective_reindexing`（`π → e ∘ π ∘ e⁻¹`）
    _ = ∑ j, a j := e.symm.sum_comp a                                         -- 番号を外す

end Ising2D
