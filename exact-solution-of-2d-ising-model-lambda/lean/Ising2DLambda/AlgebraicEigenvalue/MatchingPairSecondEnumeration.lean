import Ising2DLambda.AlgebraicEigenvalue.MatchingPairFirstEnumeration
import Ising2DLambda.AlgebraicEigenvalue.MatchingPairSecondColoring
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairSecondEnumeration

namespace Ising2DLambda.AlgebraicEigenvalue

open scoped Classical
open Ising2DLambda.NecSuf.AlgebraicEigenvalue (ascendingMatePair)

variable {J : Type*} [Fintype J] [LinearOrder J]

/-- The actual second-color word enumerates the second matching's ascending
pairs and recovers its oriented endpoint word. -/
theorem matchingPairSecondEnumeration (τ υ : FixedPointFreeInvolution J)
    (w : List J) (hw : w.Nodup)
    (hcolor : ∀ i : J, i ∈ w ↔ i ∈ matchingPairColor τ υ) :
    let C := matchingPairColor τ υ
    let w₂ := w.map τ.val
    let l := w₂.map (ascendingMatePair υ.val)
    IsMatchingEnumeration (involutionToPerfectMatching υ) l ∧
      l.flatMap (fun p => if p.1 ∉ C then [p.1, p.2] else [p.2, p.1]) =
        w₂.flatMap (fun i => [i, υ.val i]) := by
  classical
  dsimp
  let C := matchingPairColor τ υ
  let S : Finset J := Finset.univ.filter (· ∉ C)
  have hinj : Function.Injective τ.val := (τ.property.2).injective
  have hw₂ : (w.map τ.val).Nodup := hw.map hinj
  have hcolor₂ (i : J) : i ∈ w.map τ.val ↔ i ∉ C := by
    constructor
    · intro him
      obtain ⟨j, hj, rfl⟩ := List.mem_map.mp him
      intro hmate
      exact ((matchingPairColor_alternates τ υ j).mp hmate) ((hcolor j).mp hj)
    · intro hi
      have hmate : τ.val i ∈ C := (matchingPairColor_alternates τ υ i).mpr hi
      exact List.mem_map.mpr ⟨τ.val i, (hcolor _).mpr hmate, τ.property.2 i⟩
  have hflip (i : J) : υ.val i ∉ C ↔ i ∈ C := by
    simpa [C] using not_congr (matchingPairSecondColor_alternates τ υ i)
  have hchoose (i : J) (hi : i ∉ C) :
      (if (ascendingMatePair υ.val i).1 ∉ C then
        (ascendingMatePair υ.val i).1 else (ascendingMatePair υ.val i).2) = i := by
    by_cases hlt : i < υ.val i
    · simp [ascendingMatePair, hlt, hi]
    · have hmate : υ.val i ∈ C := by
        by_contra h
        exact hi ((hflip i).mp h)
      simp [ascendingMatePair, hlt, hmate]
  constructor
  · constructor
    · apply hw₂.map_on
      intro i hi j hj he
      have hiC := (hcolor₂ i).mp hi
      have hjC := (hcolor₂ j).mp hj
      calc
        i = (if (ascendingMatePair υ.val i).1 ∉ C then
          (ascendingMatePair υ.val i).1 else (ascendingMatePair υ.val i).2) :=
            (hchoose i hiC).symm
        _ = (if (ascendingMatePair υ.val j).1 ∉ C then
          (ascendingMatePair υ.val j).1 else (ascendingMatePair υ.val j).2) := by rw [he]
        _ = j := hchoose j hjC
    · intro p
      have hmem : p ∈ (w.map τ.val).map (ascendingMatePair υ.val) ↔
          p ∈ S.image (ascendingMatePair υ.val) := by
        constructor
        · intro hp
          obtain ⟨i, hi, rfl⟩ := List.mem_map.mp hp
          exact Finset.mem_image.mpr ⟨i, by simpa [S] using (hcolor₂ i).mp hi, rfl⟩
        · intro hp
          obtain ⟨i, hi, rfl⟩ := Finset.mem_image.mp hp
          exact List.mem_map.mpr ⟨i, (hcolor₂ i).mpr (by simpa [S] using hi), rfl⟩
      rw [hmem]
      exact Finset.ext_iff.mp (selectedAscendingPairs_eq_matchingOrientedPairs υ S (by
        intro i
        simpa [S] using hflip i)) p
  · rw [List.flatMap_map]
    apply List.flatMap_congr
    intro i hi
    have hiC : i ∉ C := (hcolor₂ i).mp hi
    by_cases hlt : i < υ.val i
    · simp [C, ascendingMatePair, hlt, hiC]
    · have hmate : υ.val i ∈ C := by
        by_contra h
        exact hiC ((hflip i).mp h)
      simp [C, ascendingMatePair, hlt, hmate]

/-- The abstract color-transfer argument yields the endpoint-word equality. -/
theorem matchingPairSecondEnumeration_from_necSuf
    (τ υ : FixedPointFreeInvolution J) (w : List J) (hw : w.Nodup)
    (hcolor : ∀ i : J, i ∈ w ↔ i ∈ matchingPairColor τ υ) :
    let w₂ := w.map τ.val
    let l := w₂.map (ascendingMatePair υ.val)
    l.Nodup ∧
      l.flatMap (fun p => if p.1 ∉ matchingPairColor τ υ then
        [p.1, p.2] else [p.2, p.1]) =
        w₂.flatMap (fun i => [i, υ.val i]) := by
  exact NecSuf.AlgebraicEigenvalue.matchingPairSecondEnumeration_necSuf
    τ.val υ.val (matchingPairColor τ υ) w τ.property.2
    (matchingPairColor_alternates τ υ)
    (matchingPairSecondColor_alternates τ υ) hw hcolor

end Ising2DLambda.AlgebraicEigenvalue
