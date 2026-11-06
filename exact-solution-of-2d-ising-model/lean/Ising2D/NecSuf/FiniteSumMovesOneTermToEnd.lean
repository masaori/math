/-
# 有限和の一つの項を末尾へ移す（**必要十分版**）

対応する人手証明のラベル: `finite_sum_of_real_numbers_moves_one_term_to_end`（具体版は
`Ising2D/MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimFiniteSumsOfRealNumbers.lean`、
添字を飛ばす写像 `def_index_skipping_map` は同じフォルダの `DefinitionIndexSkippingMap.lean`）。
具体版をこの系として導くのは `ClaimFiniteSumsOfRealNumbersFromNecSuf.lean` の `finite_sum_of_real_numbers_moves_one_term_to_end_of_necSuf`。

## 何が効いているか / 効いていないか

| 具体版（係数 `ℝ`） | 必要十分版 | 仮定 |
| --- | --- | --- |
| `finite_sum_of_real_numbers_moves_one_term_to_end` | `finite_sum_skip_index_succ'`（同じ場合分けと並び） | 加法についての可換モノイドだけ |

* 効いているのは加法の結合法則と交換法則だけである（`m = 1` の `k = 1` の段の交換法則と、帰納法の段の結合法則・交換法則・結合法則の 3 行）。
* `0` は人手の鎖に現れず、`Finset` の上の和 `∑` が `AddCommMonoid` を要求するためだけに要る。
  差も乗法も順序も、実数であることも効いていない。交換法則は外せない（`b_k` と `b_{m+2}` を入れ替える段がある）。
-/
import Mathlib.Algebra.BigOperators.Fin
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.DefinitionIndexSkippingMap

namespace Ising2D.NecSuf

variable {R : Type*}

/-- **一つの項を末尾へ移す**（具体版 `finite_sum_of_real_numbers_moves_one_term_to_end`）。`n` についての帰納法で、具体版と同じ場合分けと並び。 -/
theorem finite_sum_skip_index_succ' [AddCommMonoid R] (n : ℕ) (b : Fin (n + 2) → R) (k : Fin (n + 2)) :
    ∑ j, b j = (∑ j : Fin (n + 1), b (Ising2D.skipIndex k j)) + b k := by
  induction n with
  | zero =>                                                                   -- 人手の `m = 1`
    induction k using Fin.lastCases with
    | cast k' =>                                                              -- 人手の `k = 1`
      have hk' : k' = 0 := Fin.fin_one_eq_zero k'
      subst hk'
      have hδ : Ising2D.skipIndex (Fin.castSucc (0 : Fin 1)) (0 : Fin 1) = Fin.last 1 :=
        Ising2D.skipIndex_of_le _ _ (le_refl _)                                       -- `1 ≥ 1` なので `δ^{1}_{1}(1) = 2`
      calc ∑ j : Fin 2, b j
          = (∑ j : Fin 1, b j.castSucc) + b (Fin.last 1) :=
            Fin.sum_univ_castSucc _                                           -- 和の定義
        _ = b (Fin.castSucc 0) + b (Fin.last 1) := by
            rw [Fin.sum_univ_one]                                             -- 和の定義
        _ = b (Fin.last 1) + b (Fin.castSucc 0) := add_comm _ _               -- 加法の交換法則
        _ = b (Ising2D.skipIndex (Fin.castSucc (0 : Fin 1)) 0) + b (Fin.castSucc 0) := by
            rw [hδ]                                                           -- `δ^{1}_{1}(1) = 2`
        _ = (∑ j : Fin 1, b (Ising2D.skipIndex (Fin.castSucc (0 : Fin 1)) j)) + b (Fin.castSucc 0) := by
            rw [Fin.sum_univ_one]                                             -- 和の定義を右辺から左辺へ
                                                                              -- 人手の最後の行 `k = 1` は、Lean では `k` を `castSucc 0` に置き換え済みなので段にしない
    | last =>                                                                 -- 人手の `k = 2`
      have hδ : ∀ j : Fin 1, Ising2D.skipIndex (Fin.last 1) j = j.castSucc :=
        fun j => Ising2D.skipIndex_of_lt _ _ j.isLt                                   -- `1 < 2` なので `δ^{1}_{2}(1) = 1`
      calc ∑ j : Fin 2, b j
          = (∑ j : Fin 1, b j.castSucc) + b (Fin.last 1) :=
            Fin.sum_univ_castSucc _                                           -- 和の定義
        _ = (∑ j : Fin 1, b (Ising2D.skipIndex (Fin.last 1) j)) + b (Fin.last 1) := by
            simp only [hδ]                                                    -- `δ^{1}_{2}(1) = 1`
                                                                              -- 人手の最後の行 `k = 2` は、Lean では `k` を `last 1` に置き換え済みなので段にしない
  | succ n ih =>                                                              -- 人手の `m → m + 1`（人手の `m` が Lean の `n + 1`）
    induction k using Fin.lastCases with
    | last =>                                                                 -- 人手の `k = m + 2`
      have hδ : ∀ j : Fin (n + 2), Ising2D.skipIndex (Fin.last (n + 2)) j = j.castSucc :=
        fun j => Ising2D.skipIndex_of_lt _ _ j.isLt                                   -- `j < m + 2` なので `δ^{m+1}_{m+2}(j) = j`
      calc ∑ j : Fin (n + 3), b j
          = (∑ j : Fin (n + 2), b j.castSucc) + b (Fin.last _) :=
            Fin.sum_univ_castSucc _                                           -- 和の定義
        _ = (∑ j : Fin (n + 2), b (Ising2D.skipIndex (Fin.last (n + 2)) j)) + b (Fin.last _) := by
            simp only [hδ]                                                    -- `δ^{m+1}_{m+2}(j) = j` を各項へ
    | cast k' =>                                                              -- 人手の `k ≤ m + 1`
      have hδ : ∀ j : Fin (n + 1),
          Ising2D.skipIndex k'.castSucc j.castSucc = (Ising2D.skipIndex k' j).castSucc := by
        intro j                                                               -- `j ≤ m` で `δ^{m+1}_{k}(j) = δ^{m}_{k}(j)`（`j < k` と `j ≥ k` の 2 本の鎖。`by_cases` の 2 枝）
        by_cases h : j.val < k'.val
        · rw [Ising2D.skipIndex_of_lt k'.castSucc j.castSucc h, Ising2D.skipIndex_of_lt k' j h]
        · rw [Ising2D.skipIndex_of_le k'.castSucc j.castSucc (Nat.le_of_not_lt h),
            Ising2D.skipIndex_of_le k' j (Nat.le_of_not_lt h)]; rfl
      have hδlast : Ising2D.skipIndex k'.castSucc (Fin.last (n + 1)) = Fin.last (n + 2) :=
        Ising2D.skipIndex_of_le _ _ (Nat.le_of_lt_succ k'.isLt)                       -- `m + 1 ≥ k` なので `δ^{m+1}_{k}(m+1) = m + 2`
      let s : R := ∑ j : Fin (n + 1), b (Ising2D.skipIndex k' j).castSucc            -- `s := Σ_{j=1}^{m} b_{δ^{m}_{k}(j)}`
      calc ∑ j : Fin (n + 3), b j
          = (∑ j : Fin (n + 2), b j.castSucc) + b (Fin.last _) :=
            Fin.sum_univ_castSucc _                                           -- 和の定義
        _ = ((∑ j : Fin (n + 1), b (Ising2D.skipIndex k' j).castSucc) + b k'.castSucc) + b (Fin.last _) := by
            rw [ih (fun j => b j.castSucc) k']                                -- 帰納法の仮定（`b_1, …, b_{m+1}` と `k`）
        _ = (s + b k'.castSucc) + b (Fin.last _) := rfl                       -- `s` の置き方
        _ = s + (b k'.castSucc + b (Fin.last _)) := add_assoc _ _ _           -- 加法の結合法則
        _ = s + (b (Fin.last _) + b k'.castSucc) := by
            rw [add_comm (b k'.castSucc)]                                     -- 加法の交換法則
        _ = (s + b (Fin.last _)) + b k'.castSucc := (add_assoc _ _ _).symm    -- 加法の結合法則
        _ = ((∑ j : Fin (n + 1), b (Ising2D.skipIndex k' j).castSucc) + b (Fin.last _))
              + b k'.castSucc := rfl                                          -- `s` の置き方
        _ = ((∑ j : Fin (n + 1), b (Ising2D.skipIndex k'.castSucc j.castSucc)) + b (Fin.last _))
              + b k'.castSucc := by
            simp only [hδ]                                                    -- `δ^{m}_{k}(j) = δ^{m+1}_{k}(j)` を各項へ
        _ = ((∑ j : Fin (n + 1), b (Ising2D.skipIndex k'.castSucc j.castSucc))
              + b (Ising2D.skipIndex k'.castSucc (Fin.last (n + 1)))) + b k'.castSucc := by
            rw [hδlast]                                                       -- `δ^{m+1}_{k}(m+1) = m + 2`
        _ = (∑ j : Fin (n + 2), b (Ising2D.skipIndex k'.castSucc j)) + b k'.castSucc := by
            rw [Fin.sum_univ_castSucc (fun j => b (Ising2D.skipIndex k'.castSucc j))] -- 和の定義を右辺から左辺へ

end Ising2D.NecSuf
