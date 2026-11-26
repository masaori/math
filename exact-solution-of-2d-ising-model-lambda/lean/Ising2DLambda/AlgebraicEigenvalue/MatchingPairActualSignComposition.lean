import Ising2DLambda.AlgebraicEigenvalue.MatchingPairSignComposition
import Ising2DLambda.AlgebraicEigenvalue.MatchingPairFirstWordComplete
import Ising2DLambda.AlgebraicEigenvalue.MatchingPairFirstEnumeration
import Ising2DLambda.AlgebraicEigenvalue.MatchingPairSecondEnumeration

namespace Ising2DLambda.AlgebraicEigenvalue

open scoped Classical
open Ising2DLambda.AlgebraicEigenvalue.IndependentFiniteOrderedSign (finiteOrderedSign)

variable {J : Type*} [Fintype J] [LinearOrder J]

/-- Substitute the actual two matching enumerations into the word sign identity. -/
theorem matchingPairActualSignComposition (τ υ : FixedPointFreeInvolution J)
    (w : List J) (hw : w.Nodup)
    (hcolor : ∀ i : J, i ∈ w ↔ i ∈ matchingPairColor τ υ) :
    let C := matchingPairColor τ υ
    let lτ := w.map (concreteAscendingMatePair τ.val)
    let lυ := (w.map τ.val).map (concreteAscendingMatePair υ.val)
    finiteOrderedSign (matchingPairPermutation τ υ) =
      orientationSign lτ C * orientationSign lυ {i | i ∉ C} *
        perfectMatchingSign (involutionToPerfectMatching τ) *
          perfectMatchingSign (involutionToPerfectMatching υ) := by
  classical
  dsimp
  obtain ⟨hτenum, hτword⟩ := matchingPairFirstEnumeration τ υ w hw hcolor
  obtain ⟨hυenum, hυword⟩ := matchingPairSecondEnumeration τ υ w hw hcolor
  have hcomplete := matchingPairFirstWordComplete τ υ w hw hcolor
  have hfirst : w.flatMap (fun i => [i, τ.val i]) =
      (w.map (concreteAscendingMatePair τ.val)).flatMap (fun p =>
        if p.1 ∈ matchingPairColor τ υ then [p.1, p.2] else [p.2, p.1]) := hτword.symm
  have hsecond : w.flatMap (fun i => [τ.val i, υ.val (τ.val i)]) =
      ((w.map τ.val).map (concreteAscendingMatePair υ.val)).flatMap (fun p =>
        if p.1 ∉ matchingPairColor τ υ then [p.1, p.2] else [p.2, p.1]) := by
    simpa only [List.flatMap_map, Set.mem_setOf_eq] using hυword.symm
  exact matchingPairSignComposition τ υ
    (involutionToPerfectMatching τ) (involutionToPerfectMatching υ)
    (w.map (concreteAscendingMatePair τ.val))
    ((w.map τ.val).map (concreteAscendingMatePair υ.val))
    hτenum hυenum (matchingPairColor τ υ) {i | i ∉ matchingPairColor τ υ}
    w (fun i hi => (hcolor i).mp hi) hcomplete hfirst (by
      calc
        _ = ((w.map τ.val).map (concreteAscendingMatePair υ.val)).flatMap (fun p =>
            if p.1 ∉ matchingPairColor τ υ then [p.1, p.2] else [p.2, p.1]) := hsecond
        _ = _ := by
          apply List.flatMap_congr
          intro p hp
          by_cases h : p.1 ∉ matchingPairColor τ υ <;> simp [h])

end Ising2DLambda.AlgebraicEigenvalue
