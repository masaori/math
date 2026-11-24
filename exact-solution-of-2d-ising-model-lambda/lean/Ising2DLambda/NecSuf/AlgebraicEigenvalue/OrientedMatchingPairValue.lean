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

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
