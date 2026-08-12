/-
「低温展開の自明セクター表示」の必要十分版。
具体版の添字の取り替えと同じく、有限集合の間の写像が両向きに往復し、
重みがその写像で保存されることだけを使う。

証明は始域の有限集合についての帰納法を自前で書く（mathlib の既製の
添字取り替え定理へ丸投げしない）。
- 出発点: 始域が空なら、逆向きの写像の所属から終域も空であり、両辺は空和。
- 一歩: 始域から元 a を一つ外すと、往復の等式から終域からは forward a が
  ちょうど一つ外れ、残りどうしが再び両向きに往復する。帰納法の仮定で残りの
  和が等しく、外した一項は重みの保存で等しい。
仮定に要るのは、値の型が可換加法モノイドであること（有限和の記法）、
両向きの所属、往復の二等式、重みの保存だけである。
-/
import Mathlib.Algebra.BigOperators.Group.Finset.Basic

namespace Ising2DLambda.NecSuf.FisherZero

open Finset

/-- 帰納法の本体。始域についての帰納法で、終域を全称のまま回す。 -/
private theorem weighted_sum_eq_of_inverse_aux
    {A B M : Type*} [DecidableEq A] [DecidableEq B] [AddCommMonoid M]
    (forward : A → B) (backward : B → A)
    (sourceWeight : A → M) (targetWeight : B → M)
    (source : Finset A) :
    ∀ target : Finset B,
      (∀ a ∈ source, forward a ∈ target) →
      (∀ b ∈ target, backward b ∈ source) →
      (∀ a ∈ source, backward (forward a) = a) →
      (∀ b ∈ target, forward (backward b) = b) →
      (∀ a ∈ source, sourceWeight a = targetWeight (forward a)) →
      ∑ a ∈ source, sourceWeight a = ∑ b ∈ target, targetWeight b := by
  classical
  induction source using Finset.induction_on with
  | empty =>
    intro target _ hbackward _ _ _
    have htarget : target = ∅ := by
      rcases Finset.eq_empty_or_nonempty target with h | h
      · exact h
      · obtain ⟨b, hb⟩ := h
        exact absurd (hbackward b hb) (Finset.notMem_empty _)
    rw [htarget, Finset.sum_empty, Finset.sum_empty]
  | insert a s ha ih =>
    intro target hforward hbackward hleft hright hweight
    have hfa : forward a ∈ target := hforward a (Finset.mem_insert_self a s)
    have hforward' : ∀ x ∈ s, forward x ∈ target.erase (forward a) := by
      intro x hx
      have hxmem : forward x ∈ target := hforward x (Finset.mem_insert_of_mem hx)
      have hxa : x ≠ a := fun h => ha (h ▸ hx)
      have hne : forward x ≠ forward a := by
        intro h
        have h1 : backward (forward x) = x := hleft x (Finset.mem_insert_of_mem hx)
        have h2 : backward (forward a) = a := hleft a (Finset.mem_insert_self a s)
        rw [h] at h1
        exact hxa (h1.symm.trans h2)
      exact Finset.mem_erase.mpr ⟨hne, hxmem⟩
    have hbackward' : ∀ b ∈ target.erase (forward a), backward b ∈ s := by
      intro b hb
      obtain ⟨hbne, hbmem⟩ := Finset.mem_erase.mp hb
      rcases Finset.mem_insert.mp (hbackward b hbmem) with h | h
      · exfalso
        have hfb : forward (backward b) = b := hright b hbmem
        rw [h] at hfb
        exact hbne hfb.symm
      · exact h
    have hleft' : ∀ x ∈ s, backward (forward x) = x :=
      fun x hx => hleft x (Finset.mem_insert_of_mem hx)
    have hright' : ∀ b ∈ target.erase (forward a), forward (backward b) = b :=
      fun b hb => hright b (Finset.mem_erase.mp hb).2
    have hweight' : ∀ x ∈ s, sourceWeight x = targetWeight (forward x) :=
      fun x hx => hweight x (Finset.mem_insert_of_mem hx)
    rw [Finset.sum_insert ha,
      ih (target.erase (forward a)) hforward' hbackward' hleft' hright' hweight',
      hweight a (Finset.mem_insert_self a s)]
    exact Finset.add_sum_erase target targetWeight hfa

/-- 互いに逆な写像が重みを保つなら、二つの有限和は等しい。 -/
theorem weighted_sum_eq_of_inverse_necSuf
    {A B M : Type*} [DecidableEq A] [DecidableEq B] [AddCommMonoid M]
    (source : Finset A) (target : Finset B)
    (forward : A → B) (backward : B → A)
    (hforward : ∀ a ∈ source, forward a ∈ target)
    (hbackward : ∀ b ∈ target, backward b ∈ source)
    (hleft : ∀ a ∈ source, backward (forward a) = a)
    (hright : ∀ b ∈ target, forward (backward b) = b)
    (sourceWeight : A → M) (targetWeight : B → M)
    (hweight : ∀ a ∈ source, sourceWeight a = targetWeight (forward a)) :
    ∑ a ∈ source, sourceWeight a = ∑ b ∈ target, targetWeight b :=
  weighted_sum_eq_of_inverse_aux forward backward sourceWeight targetWeight
    source target hforward hbackward hleft hright hweight

end Ising2DLambda.NecSuf.FisherZero
