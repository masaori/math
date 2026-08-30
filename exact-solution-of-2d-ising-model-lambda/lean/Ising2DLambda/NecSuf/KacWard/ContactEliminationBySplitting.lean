/-
「接触対数の整礎帰納は台の辺が相異なる閉歩道を頂点単純な閉路族へ分ける」
（`claim_contact_elimination_by_splitting`）の必要十分版。

閉歩道・接触・台の辺は使わない。自然数値の測度、加法で合成される台の目録、
二つの自然数値と、「測度が正なら二つに分けられ、測度の和が真に減り、目録と
二つの法 2 の量が保存される」という一歩だけを仮定する。
-/
import Mathlib.Data.Fintype.BigOperators
import Mathlib.Data.List.Basic

namespace Ising2DLambda.NecSuf.KacWard

theorem contact_elimination_by_splitting_necSuf {α M : Type}
    [AddMonoid M]
    (measure : α → ℕ) (inventory : α → M) (hor ver : α → ℕ)
    (step : ∀ a : α, 0 < measure a → ∃ b c : α,
      measure b + measure c < measure a ∧
      inventory b + inventory c = inventory a ∧
      (hor b + hor c) % 2 = hor a % 2 ∧
      (ver b + ver c) % 2 = ver a % 2) :
    ∀ a : α, ∃ family : List α,
      family ≠ [] ∧
      (∀ x ∈ family, measure x = 0) ∧
      (family.map inventory).sum = inventory a ∧
      (family.map hor).sum % 2 = hor a % 2 ∧
      (family.map ver).sum % 2 = ver a % 2 := by
  have main : ∀ n : ℕ, ∀ a : α, measure a ≤ n →
      ∃ family : List α,
        family ≠ [] ∧
        (∀ x ∈ family, measure x = 0) ∧
        (family.map inventory).sum = inventory a ∧
        (family.map hor).sum % 2 = hor a % 2 ∧
        (family.map ver).sum % 2 = ver a % 2 := by
    intro n
    induction n with
    | zero =>
      intro a ha
      refine ⟨[a], by simp, ?_, by simp, by simp, by simp⟩
      intro x hx
      rw [List.mem_singleton.mp hx]
      omega
    | succ n ih =>
      intro a ha
      by_cases h0 : measure a = 0
      · refine ⟨[a], by simp, ?_, by simp, by simp, by simp⟩
        intro x hx
        rw [List.mem_singleton.mp hx]
        exact h0
      · obtain ⟨b, c, hlt, hi, hh, hv⟩ := step a (Nat.pos_of_ne_zero h0)
        obtain ⟨fb, hfbne, hfb0, hfbi, hfbh, hfbv⟩ := ih b (by omega)
        obtain ⟨fc, _, hfc0, hfci, hfch, hfcv⟩ := ih c (by omega)
        refine ⟨fb ++ fc, by simp [hfbne], ?_, ?_, ?_, ?_⟩
        · intro x hx
          rcases List.mem_append.mp hx with h | h
          exacts [hfb0 x h, hfc0 x h]
        · rw [List.map_append, List.sum_append, hfbi, hfci, hi]
        · rw [List.map_append, List.sum_append, Nat.add_mod, hfbh, hfch, ← Nat.add_mod, hh]
        · rw [List.map_append, List.sum_append, Nat.add_mod, hfbv, hfcv, ← Nat.add_mod, hv]
  intro a
  exact main (measure a) a le_rfl

end Ising2DLambda.NecSuf.KacWard
