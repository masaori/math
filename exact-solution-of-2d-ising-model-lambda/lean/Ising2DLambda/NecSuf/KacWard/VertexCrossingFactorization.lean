/-
「頂点ごとの横断数は水平直進数と垂直直進数の積である」
（`claim_vertex_crossing_number_factorization`）の必要十分版。

人手証明が使うのは、有限全順序集合の異なる二元を小さい順に並べることと、
二値写像の値が異なることだけである。格子・閉歩道・頂点の構造は使わない。
住処は有限集合の数え上げ（ℕ）であり、ℝ / ℂ は現れない。
-/
import Mathlib.Data.Finset.Prod
import Ising2DLambda.NecSuf.KacWard.CrossingNumberDouble

namespace Ising2DLambda.NecSuf.KacWard

/-- 有限全順序集合の元を二値に分けると、値の異なる順序なし対の個数は
二つのファイバーの個数の積になる。 -/
theorem opposite_bool_unordered_pairs_card_necSuf {ι : Type} [LinearOrder ι]
    (s : Finset ι) (active : ι → Prop) [DecidablePred active] (axis : ι → Bool) :
    ((s ×ˢ s).filter fun p => p.1 < p.2 ∧ active p.1 ∧ active p.2 ∧ axis p.1 ≠ axis p.2).card
      = (s.filter fun k => active k ∧ axis k = false).card
        * (s.filter fun k => active k ∧ axis k = true).card := by
  let H := s.filter fun k => active k ∧ axis k = false
  let V := s.filter fun k => active k ∧ axis k = true
  let r := fun k l => active k ∧ active l ∧ axis k ≠ axis l
  change ((s ×ˢ s).filter fun p => p.1 < p.2 ∧ r p.1 p.2).card = H.card * V.card
  have hsymm : ∀ k l, r k l → r l k := by
    intro k l h
    exact ⟨h.2.1, h.1, Ne.symm h.2.2⟩
  have hordered := ordered_pairs_double_necSuf s r hsymm
  have hset :
      ((s ×ˢ s).filter fun p => p.1 ≠ p.2 ∧ r p.1 p.2) = (H ×ˢ V) ∪ (V ×ˢ H) := by
    ext p
    simp only [Finset.mem_filter, Finset.mem_product, Finset.mem_union, H, V, r]
    rcases h₁ : axis p.1 with _ | _ <;> rcases h₂ : axis p.2 with _ | _ <;>
      simp only [h₁, h₂, Bool.false_eq_true, Bool.true_eq_false, ne_eq, not_false_eq_true,
        not_true_eq_false, and_false, or_false, false_or]
    case false.true =>
      constructor
      · rintro ⟨⟨hs₁, hs₂⟩, _, ha₁, ha₂⟩
        exact ⟨⟨hs₁, ha₁, trivial⟩, hs₂, ha₂⟩
      · rintro ⟨⟨hs₁, ha₁, _⟩, hs₂, ha₂⟩
        refine ⟨⟨hs₁, hs₂⟩, ?_, ha₁, ha₂⟩
        intro heq
        have := congrArg axis heq
        simp [h₁, h₂] at this
    case true.false =>
      constructor
      · rintro ⟨⟨hs₁, hs₂⟩, _, ha₁, ha₂⟩
        exact ⟨⟨hs₁, ha₁, trivial⟩, hs₂, ha₂⟩
      · rintro ⟨⟨hs₁, ha₁, _⟩, hs₂, ha₂⟩
        refine ⟨⟨hs₁, hs₂⟩, ?_, ha₁, ha₂⟩
        intro heq
        have := congrArg axis heq
        simp [h₁, h₂] at this
    all_goals simp
  have hdisj : Disjoint (H ×ˢ V) (V ×ˢ H) := by
    rw [Finset.disjoint_left]
    intro p hp hq
    have hpH := (Finset.mem_product.mp hp).1
    have hpV := (Finset.mem_product.mp hq).1
    exact Bool.noConfusion ((Finset.mem_filter.mp hpH).2.2.symm.trans
      (Finset.mem_filter.mp hpV).2.2)
  rw [hset, Finset.card_union_of_disjoint hdisj, Finset.card_product,
    Finset.card_product] at hordered
  rw [Nat.mul_comm V.card H.card] at hordered
  omega

end Ising2DLambda.NecSuf.KacWard
