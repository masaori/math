import Ising2DLambda.AlgebraicEigenvalue.MatchingPairFirstWordComplete
import Ising2DLambda.AlgebraicEigenvalue.MatchingPairOrientationProduct
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairFirstEnumeration

namespace Ising2DLambda.AlgebraicEigenvalue

open scoped Classical
open Ising2DLambda.NecSuf.AlgebraicEigenvalue (ascendingMatePair)

variable {J : Type*} [Fintype J] [LinearOrder J]

/-- The first-color endpoints enumerate the first matching's ascending pairs,
and orienting those pairs back toward the first color recovers the original word. -/
theorem matchingPairFirstEnumeration (τ υ : FixedPointFreeInvolution J)
    (w : List J) (hw : w.Nodup)
    (hcolor : ∀ i : J, i ∈ w ↔ i ∈ matchingPairColor τ υ) :
    let C := matchingPairColor τ υ
    let l := w.map (ascendingMatePair τ.val)
    IsMatchingEnumeration (involutionToPerfectMatching τ) l ∧
      l.flatMap (fun p => if p.1 ∈ C then [p.1, p.2] else [p.2, p.1]) =
        w.flatMap (fun i => [i, τ.val i]) := by
  classical
  dsimp
  let S : Finset J := Finset.univ.filter (· ∈ matchingPairColor τ υ)
  have hflip (i : J) : τ.val i ∈ matchingPairColor τ υ ↔
      i ∉ matchingPairColor τ υ := matchingPairColor_alternates τ υ i
  have hchoose (i : J) (hi : i ∈ matchingPairColor τ υ) :
      (if (ascendingMatePair τ.val i).1 ∈ matchingPairColor τ υ then
        (ascendingMatePair τ.val i).1 else (ascendingMatePair τ.val i).2) = i := by
    by_cases hlt : i < τ.val i
    · simp [ascendingMatePair, hlt, hi]
    · have hnot : τ.val i ∉ matchingPairColor τ υ := by
        intro h
        exact ((hflip i).mp h) hi
      simp [ascendingMatePair, hlt, hnot]
  constructor
  · constructor
    · apply hw.map_on
      intro i hi j hj he
      have hiC := (hcolor i).mp hi
      have hjC := (hcolor j).mp hj
      calc
        i = (if (ascendingMatePair τ.val i).1 ∈ matchingPairColor τ υ then
          (ascendingMatePair τ.val i).1 else (ascendingMatePair τ.val i).2) :=
            (hchoose i hiC).symm
        _ = (if (ascendingMatePair τ.val j).1 ∈ matchingPairColor τ υ then
          (ascendingMatePair τ.val j).1 else (ascendingMatePair τ.val j).2) := by rw [he]
        _ = j := hchoose j hjC
    · intro p
      have hmem : p ∈ w.map (ascendingMatePair τ.val) ↔ p ∈ S.image (ascendingMatePair τ.val) := by
        simp only [List.mem_map, Finset.mem_image]
        constructor
        · rintro ⟨i, hi, rfl⟩
          exact ⟨i, by simpa [S] using (hcolor i).mp hi, rfl⟩
        · rintro ⟨i, hi, rfl⟩
          exact ⟨i, (hcolor i).mpr (by simpa [S] using hi), rfl⟩
      rw [hmem]
      exact Finset.ext_iff.mp (selectedAscendingPairs_eq_matchingOrientedPairs τ S (by
        intro i
        simp [S, hflip i])) p
  · simp only [List.flatMap_map]
    apply List.flatMap_congr
    intro i hi
    have hiC : i ∈ matchingPairColor τ υ := (hcolor i).mp hi
    by_cases hlt : i < τ.val i
    · simp [ascendingMatePair, hlt, hiC]
    · have hnot : τ.val i ∉ matchingPairColor τ υ := by
        intro h
        exact ((hflip i).mp h) hiC
      simp [ascendingMatePair, hlt, hnot]

/-- The abstract one-endpoint-per-pair argument gives the concrete word result. -/
theorem matchingPairFirstEnumeration_from_necSuf
    (τ υ : FixedPointFreeInvolution J) (w : List J) (hw : w.Nodup)
    (hcolor : ∀ i : J, i ∈ w ↔ i ∈ matchingPairColor τ υ) :
    (w.map (ascendingMatePair τ.val)).Nodup ∧
      (w.map (ascendingMatePair τ.val)).flatMap
        (fun p => if p.1 ∈ matchingPairColor τ υ then [p.1, p.2] else [p.2, p.1]) =
        w.flatMap (fun i => [i, τ.val i]) := by
  exact NecSuf.AlgebraicEigenvalue.matchingPairFirstEnumeration_necSuf
    τ.val (matchingPairColor τ υ) w (matchingPairColor_alternates τ υ) hw hcolor

end Ising2DLambda.AlgebraicEigenvalue
