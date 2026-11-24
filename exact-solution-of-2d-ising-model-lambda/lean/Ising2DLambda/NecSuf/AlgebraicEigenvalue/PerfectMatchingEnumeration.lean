import Ising2DLambda.NecSuf.AlgebraicEigenvalue.PerfectMatchingSign
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.PerfectMatching
import Mathlib.Data.Finset.Sort
import Mathlib.Data.Fintype.Prod
import Mathlib.Algebra.Ring.Defs

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open scoped Classical

variable {J : Type*} [Fintype J] [LinearOrder J]

/-- 完全マッチングの二元集合を、昇順の端点対で表す。 -/
noncomputable def orientedMatchingPairs (D : PerfectMatching J) : Finset (J × J) := by
  classical
  exact Finset.univ.filter (fun p => p.1 < p.2 ∧ ({p.1, p.2} : Set J) ∈ D.val)

/-- 昇順の各対を一度ずつ書いた端点対列。 -/
def IsMatchingPairEnumeration (D : PerfectMatching J) (l : List (J × J)) : Prop :=
  l.Nodup ∧ ∀ p, p ∈ l ↔ p ∈ orientedMatchingPairs D

/-- 有限集合をリストへ移して得る列挙。 -/
noncomputable def canonicalMatchingPairEnumeration (D : PerfectMatching J) : List (J × J) :=
  (orientedMatchingPairs D).toList

theorem canonicalMatchingPairEnumeration_spec (D : PerfectMatching J) :
    IsMatchingPairEnumeration D (canonicalMatchingPairEnumeration D) := by
  classical
  exact ⟨Finset.nodup_toList _, fun _ => Finset.mem_toList⟩

omit [Fintype J] in
private theorem orientedPair_eq {p q : J × J}
    (hp : p.1 < p.2) (hq : q.1 < q.2)
    (he : ({p.1, p.2} : Set J) = {q.1, q.2}) : p = q := by
  rcases Set.pair_eq_pair_iff.mp he with h | h
  · exact Prod.ext h.1 h.2
  · have : p.2 < p.1 := by simpa [h.1, h.2] using hq
    exact (hp.asymm this).elim

/-- 同じ点を含む昇順対は、完全マッチングでは同じ対である。 -/
theorem orientedMatchingPairs_disjoint (D : PerfectMatching J) {p q : J × J}
    (hp : p ∈ orientedMatchingPairs D) (hq : q ∈ orientedMatchingPairs D)
    {x : J} (hxp : x ∈ [p.1, p.2]) (hxq : x ∈ [q.1, q.2]) : p = q := by
  classical
  have hp' := (Finset.mem_filter.mp hp).2
  have hq' := (Finset.mem_filter.mp hq).2
  obtain ⟨s, hs, hu⟩ := D.property.2 x
  have ep : ({p.1, p.2} : Set J) = s := hu _ ⟨hp'.2, by simpa using hxp⟩
  have eq : ({q.1, q.2} : Set J) = s := hu _ ⟨hq'.2, by simpa using hxq⟩
  exact orientedPair_eq hp'.1 hq'.1 (ep.trans eq.symm)

/-- 昇順対の列挙の端点列は、全元を重複なく含む。 -/
theorem matchingPairEnumeration_complete (D : PerfectMatching J) (l : List (J × J))
    (hl : IsMatchingPairEnumeration D l) : IsCompleteWord (matchingPairWord l) := by
  classical
  refine ⟨List.nodup_flatMap.mpr ⟨?_, ?_⟩, ?_⟩
  · intro p hp
    have hlt := (Finset.mem_filter.mp ((hl.2 p).mp hp)).2.1
    simpa using hlt.ne
  · apply hl.1.imp_of_mem
    intro p q hp hq hpq
    apply List.disjoint_left.mpr
    intro x hxp hxq
    exact hpq (orientedMatchingPairs_disjoint D ((hl.2 p).mp hp)
      ((hl.2 q).mp hq) hxp hxq)
  · intro x
    obtain ⟨p, hp, _⟩ := D.property.2 x
    obtain ⟨a, b, hab, rfl⟩ := D.property.1 p hp.1
    rcases lt_or_gt_of_ne hab with hlt | hlt
    · apply List.mem_flatMap.mpr
      refine ⟨(a, b), (hl.2 _).mpr ?_, ?_⟩
      · exact Finset.mem_filter.mpr ⟨Finset.mem_univ _, hlt, hp.1⟩
      · simpa using hp.2
    · apply List.mem_flatMap.mpr
      refine ⟨(b, a), (hl.2 _).mpr ?_, ?_⟩
      · exact Finset.mem_filter.mpr ⟨Finset.mem_univ _, hlt, by simpa [Set.pair_comm] using hp.1⟩
      · simpa [or_comm] using hp.2

omit [Fintype J] [LinearOrder J] in
private theorem pairList_move_front (u : List (J × J)) (a : J × J)
    (v : List (J × J)) : (u ++ a :: v).Perm (a :: (u ++ v)) := by
  induction u with
  | nil => exact List.Perm.refl _
  | cons b u ih => exact (ih.cons b).trans (List.Perm.swap a b (u ++ v))

omit [Fintype J] in
private theorem pairList_perm {l r : List (J × J)}
    (hl : l.Nodup) (hr : r.Nodup) (hm : ∀ p, p ∈ l ↔ p ∈ r) : l.Perm r := by
  induction l generalizing r with
  | nil =>
      have : r = [] := by
        apply List.eq_nil_iff_forall_not_mem.mpr
        intro x hx
        simpa using (hm x).mpr hx
      subst r
      exact List.Perm.nil
  | cons a l ih =>
      obtain ⟨u, v, rfl⟩ := List.mem_iff_append.mp ((hm a).mp (by simp))
      have hp := pairList_move_front u a v
      have hn : (a :: (u ++ v)).Nodup := hp.nodup_iff.mp hr
      have ht : l.Perm (u ++ v) := ih hl.tail hn.tail (by
        intro x
        have ha : a ∉ l := hl.notMem
        have hb : a ∉ u ++ v := hn.notMem
        by_cases hx : x = a
        · subst x; simp [ha, hb]
        · have hc := (hm x).trans hp.mem_iff
          simpa [hx] using hc)
      exact (ht.cons a).trans hp.symm

/-- 同じ完全マッチングの二列挙は、対の順序を入れ替えるだけで一致する。 -/
theorem matchingPairEnumerations_perm (D : PerfectMatching J) {l r : List (J × J)}
    (hl : IsMatchingPairEnumeration D l) (hr : IsMatchingPairEnumeration D r) : l.Perm r :=
  pairList_perm hl.1 hr.1 (fun p => (hl.2 p).trans (hr.2 p).symm)

/-- 端点列の値を、完全マッチングの標準列挙で定める。 -/
noncomputable def matchingValue {R : Type*} (F : List J → R) (D : PerfectMatching J) : R :=
  F (matchingPairWord (canonicalMatchingPairEnumeration D))

/-- 各対を昇順にした列挙の順序は端点列の値を変えない。 -/
theorem matchingValue_enumeration {R : Type*} [CommRing R] (F : List J → R)
    (hswap : ∀ (u : List J) (a b : J) (v : List J),
      IsCompleteWord (u ++ a :: b :: v) → F (u ++ b :: a :: v) = -F (u ++ a :: b :: v))
    (D : PerfectMatching J) (l : List (J × J)) (hl : IsMatchingPairEnumeration D l) :
    F (matchingPairWord l) = matchingValue F D := by
  have hp := matchingPairEnumerations_perm D (canonicalMatchingPairEnumeration_spec D) hl
  exact matchingWord_value_pair_perm F Neg.neg neg_involutive hswap hp []
    (matchingPairEnumeration_complete D _ (canonicalMatchingPairEnumeration_spec D))

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
