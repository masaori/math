import Ising2DLambda.NecSuf.AlgebraicEigenvalue.PerfectMatchingEnumeration
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairWordOrientationSign

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open scoped Classical

variable {J R : Type*} [Fintype J] [LinearOrder J] [CommRing R]

/-- 対の二端点を昇順へ直す。 -/
def orderedMatchingPair (p : J × J) : J × J :=
  if p.1 < p.2 then p else (p.2, p.1)

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
    (hD : ∀ p ∈ l, ({p.1, p.2} : Set J) ∈ D.val)
    (hen : IsMatchingPairEnumeration D (l.map orderedMatchingPair)) :
    F (matchingPairWord l) =
      (l.map (matchingPairOrientation (R := R))).prod * matchingValue F D := by
  let S : Set J := {x | ∃ p ∈ l, p.1 = x}
  have hS : ∀ p ∈ l, ((orderedMatchingPair p).1 ∈ S ↔ p.1 < p.2) := by
    intro p hp
    exact (matchingPairOrientationSelection D l hc hD p hp).2
  exact orientedMatchingPairValue F hswap D l S hen hS

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
