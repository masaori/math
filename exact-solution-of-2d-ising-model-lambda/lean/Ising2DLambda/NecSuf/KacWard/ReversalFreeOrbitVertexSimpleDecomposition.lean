/-
必要十分版: 不変条件を満たす対象を、測度が零になるまで二分する。

人手証明からトーラス、向き付き辺、置換、閉歩道を除き、自然数値の測度、
加法的な台の目録、法 2 の二量、不変条件、および不変条件を保つ二分の一歩だけを残す。
既存の接触消去と違い、分解後の各成員にも不変条件が残ることを同じ累積帰納で示す。
-/
import Mathlib.Data.Fintype.BigOperators
import Mathlib.Data.List.Basic

namespace Ising2DLambda.NecSuf.KacWard

theorem invariant_elimination_by_splitting_necSuf {α M : Type}
    [AddMonoid M]
    (measure : α → ℕ) (inventory : α → M) (hor ver : α → ℕ)
    (invariant : α → Prop)
    (step : ∀ a : α, invariant a → 0 < measure a → ∃ b c : α,
      invariant b ∧ invariant c ∧
      measure b + measure c < measure a ∧
      inventory b + inventory c = inventory a ∧
      (hor b + hor c) % 2 = hor a % 2 ∧
      (ver b + ver c) % 2 = ver a % 2) :
    ∀ a : α, invariant a → ∃ family : List α,
      family ≠ [] ∧
      (∀ x ∈ family, invariant x ∧ measure x = 0) ∧
      (family.map inventory).sum = inventory a ∧
      (family.map hor).sum % 2 = hor a % 2 ∧
      (family.map ver).sum % 2 = ver a % 2 := by
  have main : ∀ n : ℕ, ∀ a : α, invariant a → measure a ≤ n →
      ∃ family : List α,
        family ≠ [] ∧
        (∀ x ∈ family, invariant x ∧ measure x = 0) ∧
        (family.map inventory).sum = inventory a ∧
        (family.map hor).sum % 2 = hor a % 2 ∧
        (family.map ver).sum % 2 = ver a % 2 := by
    intro n
    induction n with
    | zero =>
      intro a hinv ha
      refine ⟨[a], by simp, ?_, by simp, by simp, by simp⟩
      intro x hx
      rw [List.mem_singleton.mp hx]
      exact ⟨hinv, by omega⟩
    | succ n ih =>
      intro a hinv ha
      by_cases h0 : measure a = 0
      · refine ⟨[a], by simp, ?_, by simp, by simp, by simp⟩
        intro x hx
        rw [List.mem_singleton.mp hx]
        exact ⟨hinv, h0⟩
      · obtain ⟨b, c, hbinv, hcinv, hlt, hi, hh, hv⟩ :=
          step a hinv (Nat.pos_of_ne_zero h0)
        obtain ⟨fb, hfbne, hfb0, hfbi, hfbh, hfbv⟩ := ih b hbinv (by omega)
        obtain ⟨fc, _, hfc0, hfci, hfch, hfcv⟩ := ih c hcinv (by omega)
        refine ⟨fb ++ fc, by simp [hfbne], ?_, ?_, ?_, ?_⟩
        · intro x hx
          rcases List.mem_append.mp hx with h | h
          exacts [hfb0 x h, hfc0 x h]
        · rw [List.map_append, List.sum_append, hfbi, hfci, hi]
        · rw [List.map_append, List.sum_append, Nat.add_mod, hfbh, hfch, ← Nat.add_mod, hh]
        · rw [List.map_append, List.sum_append, Nat.add_mod, hfbv, hfcv, ← Nat.add_mod, hv]
  intro a hinv
  exact main (measure a) a hinv le_rfl

end Ising2DLambda.NecSuf.KacWard
