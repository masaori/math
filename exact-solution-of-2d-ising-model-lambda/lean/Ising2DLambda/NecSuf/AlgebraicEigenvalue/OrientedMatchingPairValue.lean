import Ising2DLambda.NecSuf.AlgebraicEigenvalue.PerfectMatchingEnumeration
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairWordOrientationSign

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open scoped Classical

variable {J R : Type*} [Fintype J] [LinearOrder J] [CommRing R]

/-- 対の二端点を昇順へ直す。 -/
def orderedMatchingPair (p : J × J) : J × J :=
  if p.1 < p.2 then p else (p.2, p.1)

/-- 完全な端点列の各対を昇順にすると、完全マッチングの列挙になる。 -/
theorem orderedMatchingPairs_enumeration (D : PerfectMatching J) (l : List (J × J))
    (hc : IsCompleteWord (matchingPairWord l))
    (hD : ∀ p ∈ l, ({p.1, p.2} : Set J) ∈ D.val) :
    IsMatchingPairEnumeration D (l.map orderedMatchingPair) := by
  have hne : ∀ p ∈ l, p.1 ≠ p.2 := by
    intro p hp
    have hpair := (List.nodup_flatMap.mp hc.1).1 p hp
    simpa using hpair
  have hset : ∀ p : J × J,
      ({(orderedMatchingPair p).1, (orderedMatchingPair p).2} : Set J) = {p.1, p.2} := by
    intro p
    unfold orderedMatchingPair
    split_ifs
    · rfl
    · exact Set.pair_comm _ _
  have hasc : ∀ p ∈ l, (orderedMatchingPair p).1 < (orderedMatchingPair p).2 := by
    intro p hp
    unfold orderedMatchingPair
    split_ifs with h
    · exact h
    · exact lt_of_le_of_ne (not_lt.mp h) (hne p hp).symm
  have heq : ∀ p q : J × J, p.1 < p.2 → q.1 < q.2 →
      ({p.1, p.2} : Set J) = {q.1, q.2} → p = q := by
    intro p q hp hq he
    rcases Set.pair_eq_pair_iff.mp he with h | h
    · exact Prod.ext h.1 h.2
    · have : p.2 < p.1 := by simpa [h.1, h.2] using hq
      exact (hp.asymm this).elim
  have hlnd : l.Nodup := by
    apply (List.nodup_flatMap.mp hc.1).2.imp
    intro p q hd hpq
    subst hpq
    exact hd (by simp : p.1 ∈ [p.1, p.2]) (by simp)
  refine ⟨hlnd.map_on ?_, fun q => ?_⟩
  · intro p hp q hq hpq
    have hs : ({p.1, p.2} : Set J) = {q.1, q.2} := by
      rw [← hset p, ← hset q, hpq]
    have hx : p.1 ∈ ({q.1, q.2} : Set J) := by rw [← hs]; simp
    have hpw : l.Pairwise
        (fun a b : J × J => List.Disjoint [a.1, a.2] [b.1, b.2]) :=
      (List.nodup_flatMap.mp hc.1).2
    haveI : Std.Symm
        (fun a b : J × J => List.Disjoint [a.1, a.2] [b.1, b.2]) :=
      ⟨fun _ _ h => List.disjoint_comm.mp h⟩
    by_contra hne'
    exact hpw.forall hp hq hne' (by simp : p.1 ∈ [p.1, p.2])
      (by simpa only [Set.mem_insert_iff, Set.mem_singleton_iff, List.mem_cons,
        List.not_mem_nil, or_false] using hx)
  · constructor
    · intro hq
      obtain ⟨p, hp, rfl⟩ := List.mem_map.mp hq
      exact Finset.mem_filter.mpr ⟨Finset.mem_univ _, hasc p hp,
        by rw [hset]; exact hD p hp⟩
    · intro hq
      have hq' := (Finset.mem_filter.mp hq).2
      obtain ⟨p, hp, hxp⟩ := List.mem_flatMap.mp (hc.2 q.1)
      refine List.mem_map.mpr ⟨p, hp, heq _ _ (hasc p hp) hq'.1 ?_⟩
      obtain ⟨s, _, hu⟩ := D.property.2 q.1
      rw [hset]
      exact (hu _ ⟨hD p hp, by simpa using hxp⟩).trans
        (hu _ ⟨hq'.2, by simp⟩).symm

/-- 元の対の向きと昇順の向きの差。 -/
def matchingPairOrientation (p : J × J) : R :=
  if p.1 < p.2 then 1 else -1

omit [Fintype J] in
/-- 完全な端点列の各対は相手写像に従い、元の第一端点の集合が向きを選ぶ。 -/
theorem matchingPairOrientationSelection (D : PerfectMatching J)
    (l : List (J × J))
    (hc : IsCompleteWord (matchingPairWord l))
    (hD : ∀ p ∈ l, ({p.1, p.2} : Set J) ∈ D.val) :
    ∀ p ∈ l, perfectMatchingMate D p.1 = p.2 ∧
      ((orderedMatchingPair p).1 ∈ ({x | ∃ q ∈ l, q.1 = x} : Set J) ↔ p.1 < p.2) := by
  intro p hp
  have hne : p.1 ≠ p.2 := by
    have hpair := (List.nodup_flatMap.mp hc.1).1 p hp
    simpa using hpair
  constructor
  · exact perfectMatchingMate_eq_of_pair D p.1 p.2 hne.symm (hD p hp)
  · unfold orderedMatchingPair
    split_ifs with h
    · exact iff_of_true ⟨p, hp, rfl⟩ h
    · refine iff_of_false ?_ h
      rintro ⟨q, hq, hqe⟩
      have hpw : l.Pairwise (fun a b : J × J => List.Disjoint [a.1, a.2] [b.1, b.2]) :=
        (List.nodup_flatMap.mp hc.1).2
      haveI : Std.Symm (fun a b : J × J => List.Disjoint [a.1, a.2] [b.1, b.2]) :=
        ⟨fun _ _ hd => List.disjoint_comm.mp hd⟩
      have hpq : p = q := by
        by_contra hneq
        exact hpw.forall hp hq hneq (by simp : p.2 ∈ [p.1, p.2])
          (by simp [hqe] : p.2 ∈ [q.1, q.2])
      subst q
      exact hne (by simpa using hqe)

/-- 昇順対の各端点を元の向きへ戻すときの符号積。 -/
theorem orientedMatchingPairValue (F : List J → R)
    (hswap : ∀ (u : List J) (a b : J) (v : List J),
      IsCompleteWord (u ++ a :: b :: v) →
        F (u ++ b :: a :: v) = -F (u ++ a :: b :: v))
    (D : PerfectMatching J) (l : List (J × J)) (S : Set J)
    (hen : IsMatchingPairEnumeration D (l.map orderedMatchingPair))
    (hS : ∀ p ∈ l, ((orderedMatchingPair p).1 ∈ S ↔ p.1 < p.2)) :
    F (matchingPairWord l) =
      (l.map (matchingPairOrientation (R := R))).prod * matchingValue F D := by
  classical
  have hbase := matchingPairEnumeration_complete D _ hen
  have haux := orientationSignWithPrefix F hswap S (l.map orderedMatchingPair) []
    (by simpa using hbase)
  simp only [List.nil_append] at haux
  rw [matchingValue_enumeration F hswap D _ hen] at haux
  convert haux using 2
  · rw [List.flatMap_map]
    apply List.flatMap_congr
    intro p hp
    by_cases h : p.1 < p.2
    · rw [if_pos ((hS p hp).mpr h)]
      simp [orderedMatchingPair, h]
    · rw [if_neg (fun hm => h ((hS p hp).mp hm))]
      simp [orderedMatchingPair, h]
  · rw [List.map_map]
    congr 1
    apply List.map_congr_left
    intro p hp
    by_cases h : p.1 < p.2
    · simp only [Function.comp, if_pos ((hS p hp).mpr h), matchingPairOrientation,
        if_pos h]
    · simp only [Function.comp, if_neg (fun hm => h ((hS p hp).mp hm)),
        matchingPairOrientation, if_neg h]

/-- A complete matching word chooses exactly one first endpoint from each pair,
so its orientation signs give the value relative to the matching. -/
theorem orientedMatchingPairValue_of_matching (F : List J → R)
    (hswap : ∀ (u : List J) (a b : J) (v : List J),
      IsCompleteWord (u ++ a :: b :: v) →
        F (u ++ b :: a :: v) = -F (u ++ a :: b :: v))
    (D : PerfectMatching J) (l : List (J × J))
    (hc : IsCompleteWord (matchingPairWord l))
    (hD : ∀ p ∈ l, ({p.1, p.2} : Set J) ∈ D.val) :
    F (matchingPairWord l) =
      (l.map (matchingPairOrientation (R := R))).prod * matchingValue F D := by
  let S : Set J := {x | ∃ p ∈ l, p.1 = x}
  have hS : ∀ p ∈ l, ((orderedMatchingPair p).1 ∈ S ↔ p.1 < p.2) := by
    intro p hp
    exact (matchingPairOrientationSelection D l hc hD p hp).2
  exact orientedMatchingPairValue F hswap D l S
    (orderedMatchingPairs_enumeration D l hc hD) hS

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
