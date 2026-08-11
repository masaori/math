/-
根を一つ取り除く帰納法に必要十分な仮定だけを残した版。
多項式・係数・評価・因数分解は仮定せず、零でない対象から根を一つ取り除く操作が
上界を一つ下げ、ほかの根を保つことだけを使う。
-/
import Mathlib.Data.Finset.Card

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

theorem distinct_roots_card_le_necSuf {P α : Type*} [DecidableEq α]
    (zero : P) (Root : P → α → Prop) (Bound : ℕ → P → Prop) (quot : ℕ → P → α → P)
    (hzero : ∀ p : P, Bound 0 p → (∃ a : α, Root p a) → p = zero)
    (hquot_ne : ∀ n p a, p ≠ zero → Bound n p → Root p a → quot n p a ≠ zero)
    (hbound : ∀ n p a, Bound (n + 1) p → Root p a → Bound n (quot (n + 1) p a))
    (hother : ∀ n p a b, Bound n p → Root p a → Root p b → b ≠ a → Root (quot n p a) b)
    (p : P) (s : Finset α) (n : ℕ) (hpne : p ≠ zero) (hpbound : Bound n p)
    (hroots : ∀ a ∈ s, Root p a) :
    s.card ≤ n := by
  induction n generalizing p s with
  | zero =>
      by_contra hcard
      have hs : s.Nonempty := Finset.card_pos.mp (by omega)
      obtain ⟨a, ha⟩ := hs
      exact hpne (hzero p hpbound ⟨a, hroots a ha⟩)
  | succ n ih =>
      by_cases hs : s.Nonempty
      · obtain ⟨a, ha⟩ := hs
        have hqa : quot (n + 1) p a ≠ zero := hquot_ne (n + 1) p a hpne hpbound (hroots a ha)
        have hqb : Bound n (quot (n + 1) p a) := hbound n p a hpbound (hroots a ha)
        have hqr : ∀ b ∈ s.erase a, Root (quot (n + 1) p a) b := by
          intro b hb
          have hmem := Finset.mem_erase.mp hb
          exact hother (n + 1) p a b hpbound (hroots a ha) (hroots b hmem.2) hmem.1
        have hc := ih (quot (n + 1) p a) (s.erase a) hqa hqb hqr
        rw [Finset.card_erase_of_mem ha] at hc
        omega
      · simp only [Finset.not_nonempty_iff_eq_empty] at hs
        simp [hs]

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
