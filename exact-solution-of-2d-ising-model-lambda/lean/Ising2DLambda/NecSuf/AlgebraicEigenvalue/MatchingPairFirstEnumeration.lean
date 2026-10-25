import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairOrientationProduct

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open scoped Classical

variable {J : Type*} [LinearOrder J]

/-- An involution and a color class selecting one endpoint per pair suffice to
enumerate the corresponding ascending pairs without repetition. -/
theorem matchingPairFirstEnumeration_necSuf
    (f : J → J) (C : Set J) (w : List J)
    (hflip : ∀ i : J, f i ∈ C ↔ i ∉ C)
    (hw : w.Nodup) (hcolor : ∀ i : J, i ∈ w ↔ i ∈ C) :
    (w.map (ascendingMatePair f)).Nodup ∧
      (w.map (ascendingMatePair f)).flatMap
        (fun p => if p.1 ∈ C then [p.1, p.2] else [p.2, p.1]) =
        w.flatMap (fun i => [i, f i]) := by
  classical
  have hchoose (i : J) (hi : i ∈ C) :
      (if (ascendingMatePair f i).1 ∈ C then
        (ascendingMatePair f i).1 else (ascendingMatePair f i).2) = i := by
    by_cases hlt : i < f i
    · simp [ascendingMatePair, hlt, hi]
    · have hnot : f i ∉ C := by
        intro h
        exact ((hflip i).mp h) hi
      simp [ascendingMatePair, hlt, hnot]
  constructor
  · apply hw.map_on
    intro i hi j hj he
    have hiC := (hcolor i).mp hi
    have hjC := (hcolor j).mp hj
    calc
      i = (if (ascendingMatePair f i).1 ∈ C then
        (ascendingMatePair f i).1 else (ascendingMatePair f i).2) :=
          (hchoose i hiC).symm
      _ = (if (ascendingMatePair f j).1 ∈ C then
        (ascendingMatePair f j).1 else (ascendingMatePair f j).2) := by rw [he]
      _ = j := hchoose j hjC
  · simp only [List.flatMap_map]
    apply List.flatMap_congr
    intro i hi
    have hiC : i ∈ C := (hcolor i).mp hi
    by_cases hlt : i < f i
    · simp [ascendingMatePair, hlt, hiC]
    · have hnot : f i ∉ C := by
        intro h
        exact ((hflip i).mp h) hiC
      simp [ascendingMatePair, hlt, hnot]

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
