/-
# 有限和は添字の全単射による付け替えで変わらない（**必要十分版**）

対応する人手証明のラベル: `finite_sum_of_real_numbers_is_invariant_under_bijective_reindexing`（具体版は
`Ising2D/MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimFiniteSumOfRealNumbersReindexedByBijection.lean`）。
具体版をこの系として導くのは同じフォルダの `ClaimFiniteSumOfRealNumbersReindexedByBijectionFromNecSuf.lean`。

## 何が効いているか / 効いていないか

| 具体版（係数 `ℝ`） | 必要十分版 | 仮定 |
| --- | --- | --- |
| `finite_sum_of_real_numbers_is_invariant_under_bijective_reindexing` | `finite_sum_reindex_bijective'`（同じ帰納法と並び） | 加法についての可換モノイド、`π` は全単射 |

* 係数の側で効いているのは、一つの項を末尾へ移す段（`finite_sum_skip_index_succ'`。加法の結合法則と交換法則）だけである。
  `0`・差・乗法・順序も、実数であることも効いていない（`0` は `Finset` の上の和 `∑` が `AddCommMonoid` を要求するためだけに要る）。
* `π` の全射性は `π(k) = m + 1` の `k` を取る段に、全単射性は帰納法の仮定へ渡す `τ^{π}_{k}` の全単射性（`compSkipIndex_bijective`）に効く。
  `Fin (n + 1)` の上では単射から全射が従うが、それは鳩の巣原理による別の論法なので、具体版と同じ手順を保つために全単射を仮定に残す（README 4 節の要件 1）。
-/
import Mathlib.Algebra.BigOperators.Fin
import Ising2D.NecSuf.FiniteSumMovesOneTermToEnd
import Ising2D.NecSuf.BijectionComposedWithIndexSkippingMap

namespace Ising2D.NecSuf

variable {R : Type*}

/-- **添字の全単射による付け替え**（具体版 `finite_sum_of_real_numbers_is_invariant_under_bijective_reindexing`）。
`n` についての帰納法で、具体版と同じ並び。 -/
theorem finite_sum_reindex_bijective' [AddCommMonoid R] (n : ℕ) (a : Fin (n + 1) → R)
    (π : Fin (n + 1) → Fin (n + 1)) (hπ : Function.Bijective π) :
    ∑ j, a (π j) = ∑ j, a j := by
  induction n with
  | zero =>                                                                   -- 人手の `m = 1`
    have hπ1 : π 0 = 0 := Fin.fin_one_eq_zero (π 0)                           -- `π(1) = 1`
    calc ∑ j : Fin 1, a (π j)
        = a (π 0) := Fin.sum_univ_one _                                       -- 和の定義
      _ = a 0 := by rw [hπ1]                                                  -- `π(1) = 1`
      _ = ∑ j : Fin 1, a j := (Fin.sum_univ_one a).symm                       -- 和の定義を右辺から左辺へ
  | succ n ih =>                                                              -- 人手の `m → m + 1`
    obtain ⟨k, hk⟩ := hπ.2 (Fin.last (n + 1))                                 -- `π` は全射
    let b : Fin (n + 2) → R := fun j => a (π j)                               -- `b_j := a_{π(j)}`
    calc ∑ j, a (π j)
        = ∑ j, b j := rfl                                                     -- `b` の置き方
      _ = (∑ j : Fin (n + 1), b (Ising2D.skipIndex k j)) + b k :=
          finite_sum_skip_index_succ' n b k                                   -- 一つの項を末尾へ移す
      _ = (∑ j : Fin (n + 1), a (π (Ising2D.skipIndex k j))) + a (π k) := rfl -- `b` の置き方
      _ = (∑ j : Fin (n + 1), a (compSkipIndex π hπ.1 k hk j).castSucc) + a (π k) := by
          simp only [compSkipIndex_castSucc]                                  -- `τ^{π}_{k}` の定義を右辺から左辺へ
      _ = (∑ j : Fin (n + 1), a (compSkipIndex π hπ.1 k hk j).castSucc) + a (Fin.last (n + 1)) := by
          rw [hk]                                                             -- `π(k) = m + 1`
      _ = (∑ j : Fin (n + 1), a j.castSucc) + a (Fin.last (n + 1)) := by
          rw [ih (fun i => a i.castSucc) (compSkipIndex π hπ.1 k hk)
            (compSkipIndex_bijective π hπ k hk)]                              -- 帰納法の仮定（`τ^{π}_{k}` は全単射）
      _ = ∑ j, a j := (Fin.sum_univ_castSucc a).symm                          -- 和の定義を右辺から左辺へ

end Ising2D.NecSuf
