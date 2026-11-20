/-
節「根の番号の対の個数」の具体版。
人手証明の正本は `claim_root_index_pair_count` である。

  人手証明                                                       このファイル
  準備: Pr_{e+2} は互いに素な Pr_{e+1} と C_{e+1} の和集合         `rootIndexPairSplit`（和型への全単射）
  個数の式鎖（|Pr_{e+2}| = |Pr_{e+1}| + (e+1)）                     `card_rootIndexPair_succ_succ`
  帰納法の基底（Pr_1 = ∅）                                         `card_rootIndexPair_one`
  帰納法の一歩の式鎖                                               `card_rootIndexPair_add_self` の calc
  結論の式鎖（N + N = |Pr_d| + |Pr_d| = d·(d-1)）                   `rootIndexPairCount`

本文の `Pr_d` は `RootIndexPair d`、`C_{e+1}` は和型の右の成分 `Fin (e+1)`（i ↦ (i, e+1)）、
全単射 `ν : ℕ_{<N} → Pr_d` は `ν : Fin N ≃ RootIndexPair d` で書く。

住処: N。ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.FisherZero.PairShiftElementarySymmetric

namespace Ising2DLambda.FisherZero

/-- 人手証明の準備: Pr_{e+2} を、第二成分が e+1 未満の対（Pr_{e+1} の元の持ち上げ）と、
第二成分が e+1 の対 (i, e+1)（i ∈ ℕ_{<e+1}）に分ける全単射。 -/
def rootIndexPairSplit (e : ℕ) : RootIndexPair (e + 2) ≃ RootIndexPair (e + 1) ⊕ Fin (e + 1) where
  toFun p :=
    if h : p.1.2.val < e + 1 then
      Sum.inl ⟨(⟨p.1.1.val, lt_trans p.2 h⟩, ⟨p.1.2.val, h⟩), p.2⟩
    else
      Sum.inr ⟨p.1.1.val, lt_of_lt_of_le p.2 (by omega)⟩
  invFun q :=
    match q with
    | Sum.inl q => ⟨(Fin.castSucc q.1.1, Fin.castSucc q.1.2), q.2⟩
    | Sum.inr i => ⟨(Fin.castSucc i, Fin.last (e + 1)), Fin.castSucc_lt_last i⟩
  left_inv p := by
    obtain ⟨⟨i, j⟩, hij⟩ := p
    by_cases h : j.val < e + 1
    · simp only [h, dite_true]
      rfl
    · simp only [h, dite_false]
      apply Subtype.ext
      have hj : j = Fin.last (e + 1) := by ext; simp; omega
      simp [hj]
  right_inv q := by
    rcases q with ⟨⟨i, j⟩, hij⟩ | i
    · simp [Fin.castSucc, Nat.le_of_lt_succ j.isLt]
    · simp [Fin.castSucc]

theorem card_rootIndexPair_succ_succ (e : ℕ) :
    Fintype.card (RootIndexPair (e + 2)) = Fintype.card (RootIndexPair (e + 1)) + (e + 1) := by
  rw [Fintype.card_congr (rootIndexPairSplit e), Fintype.card_sum, Fintype.card_fin]

theorem card_rootIndexPair_one : Fintype.card (RootIndexPair 1) = 0 := by
  rw [Fintype.card_eq_zero_iff]
  constructor
  intro p
  have h0 : p.1.1 = p.1.2 := Subsingleton.elim _ _
  exact absurd p.2 (by rw [h0]; exact lt_irrefl _)

theorem card_rootIndexPair_add_self (e : ℕ) :
    Fintype.card (RootIndexPair (e + 1)) + Fintype.card (RootIndexPair (e + 1)) = (e + 1) * e := by
  induction e with
  | zero => rw [card_rootIndexPair_one]
  | succ e ih =>
    calc Fintype.card (RootIndexPair (e + 2)) + Fintype.card (RootIndexPair (e + 2))
        = (Fintype.card (RootIndexPair (e + 1)) + (e + 1))
            + (Fintype.card (RootIndexPair (e + 1)) + (e + 1)) := by
          rw [card_rootIndexPair_succ_succ]
      _ = (Fintype.card (RootIndexPair (e + 1)) + Fintype.card (RootIndexPair (e + 1)))
            + ((e + 1) + (e + 1)) := by ring
      _ = (e + 1) * e + ((e + 1) + (e + 1)) := by rw [ih]
      _ = (e + 1 + 1) * (e + 1) := by ring

/-- `claim_root_index_pair_count` の具体版。 -/
theorem rootIndexPairCount (d N : ℕ) (hd : 1 ≤ d) (ν : Fin N ≃ RootIndexPair d) :
    N + N = d * (d - 1) := by
  obtain ⟨e, rfl⟩ : ∃ e : ℕ, d = e + 1 := ⟨d - 1, (Nat.sub_add_cancel hd).symm⟩
  have hN : N = Fintype.card (RootIndexPair (e + 1)) :=
    calc N = Fintype.card (Fin N) := (Fintype.card_fin N).symm
      _ = Fintype.card (RootIndexPair (e + 1)) := Fintype.card_congr ν
  calc N + N = Fintype.card (RootIndexPair (e + 1)) + Fintype.card (RootIndexPair (e + 1)) := by
        rw [hN]
    _ = (e + 1) * e := card_rootIndexPair_add_self e
    _ = (e + 1) * (e + 1 - 1) := by rw [Nat.add_sub_cancel]

end Ising2DLambda.FisherZero
