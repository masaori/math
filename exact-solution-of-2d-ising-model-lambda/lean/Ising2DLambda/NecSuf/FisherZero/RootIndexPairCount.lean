/-
節「根の番号の対の個数」の必要十分版。
具体版 `Ising2DLambda.FisherZero.rootIndexPairCount` と同じ手順
（Pr_{e+2} を Pr_{e+1} と e+1 個の元の集合へ分ける → 個数の漸化式 → e についての帰納法 →
全単射で N を個数へ移す）を、手順が実際に使う仮定だけの上で行う。

要るのは次だけである。
- 有限型の族 `A : ℕ → Type`（具体版では `A e = Pr_{e+1}`）。
- `A 0` が空であること（具体版の `Pr_1 = ∅`）。帰納法の基底に使う。
- 各 `e` について `A (e+1) ≃ A e ⊕ Fin (e+1)`（具体版の `Pr_{e+2} = Pr_{e+1} ⊔ C_{e+1}`）。
  個数の漸化式に使う。

削れたもの: 族の元が `Fin` の元の対であること、対の成分の大小 `i < j`、`Fin` の順序。
具体版でこれらが使われるのは、上の二つの仮定（空であることと分解の全単射）を作る段だけである。
-/
import Mathlib.Data.Fintype.Sum
import Mathlib.Data.Fintype.Card
import Mathlib.Tactic.Ring

namespace Ising2DLambda.NecSuf.FisherZero

/-- 個数の漸化式 `|A (e+1)| = |A e| + (e+1)`（分解の全単射と、互いに素な和の個数）。 -/
theorem pair_family_card_succ_necSuf (A : ℕ → Type*) [∀ e, Fintype (A e)]
    (split : ∀ e, A (e + 1) ≃ A e ⊕ Fin (e + 1)) (e : ℕ) :
    Fintype.card (A (e + 1)) = Fintype.card (A e) + (e + 1) := by
  rw [Fintype.card_congr (split e), Fintype.card_sum, Fintype.card_fin]

/-- 帰納法: `|A e| + |A e| = (e+1)·e`。 -/
theorem pair_family_card_add_self_necSuf (A : ℕ → Type*) [∀ e, Fintype (A e)]
    (hempty : IsEmpty (A 0)) (split : ∀ e, A (e + 1) ≃ A e ⊕ Fin (e + 1)) (e : ℕ) :
    Fintype.card (A e) + Fintype.card (A e) = (e + 1) * e := by
  induction e with
  | zero => rw [Fintype.card_eq_zero_iff.mpr hempty]
  | succ e ih =>
    calc Fintype.card (A (e + 1)) + Fintype.card (A (e + 1))
        = (Fintype.card (A e) + (e + 1)) + (Fintype.card (A e) + (e + 1)) := by
          rw [pair_family_card_succ_necSuf A split]
      _ = (Fintype.card (A e) + Fintype.card (A e)) + ((e + 1) + (e + 1)) := by ring
      _ = (e + 1) * e + ((e + 1) + (e + 1)) := by rw [ih]
      _ = (e + 1 + 1) * (e + 1) := by ring

/-- 結論: `ν : Fin N ≃ A e` なら `N + N = (e+1)·e`。 -/
theorem pair_family_count_necSuf (A : ℕ → Type*) [∀ e, Fintype (A e)]
    (hempty : IsEmpty (A 0)) (split : ∀ e, A (e + 1) ≃ A e ⊕ Fin (e + 1))
    (e N : ℕ) (ν : Fin N ≃ A e) : N + N = (e + 1) * e := by
  have hN : N = Fintype.card (A e) :=
    calc N = Fintype.card (Fin N) := (Fintype.card_fin N).symm
      _ = Fintype.card (A e) := Fintype.card_congr ν
  calc N + N = Fintype.card (A e) + Fintype.card (A e) := by rw [hN]
    _ = (e + 1) * e := pair_family_card_add_self_necSuf A hempty split e

end Ising2DLambda.NecSuf.FisherZero
