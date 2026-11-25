import Ising2DLambda.NecSuf.KacWard.TaggedDifferenceCycleCover
import Ising2DLambda.AlgebraicEigenvalue.MatchingPairSecondColoring

namespace Ising2DLambda.NecSuf.KacWard

open Ising2DLambda.AlgebraicEigenvalue

/-- If the second mate preserves the projection, the first-colour components
    cover the whole projected image. -/
theorem projectedCycleSupportUnion_eq_range {J E : Type*}
    [Fintype J] [LinearOrder J] (τ υ : FixedPointFreeInvolution J)
    (p : J → E) (hp : ∀ j, p (υ.val j) = p j) :
    {e | ∃ i j : J, j ∈ matchingPairComponent τ υ i ∧
      j ∈ matchingPairColor τ υ ∧ p j = e} = Set.range p := by
  classical
  ext e
  constructor
  · rintro ⟨i, j, hj, hc, rfl⟩
    exact ⟨j, rfl⟩
  · rintro ⟨i, rfl⟩
    have hcover := alternatingCycle_cover τ.val υ.val τ.property.2 υ.property.2
    have hfirst : i ∈ matchingPairComponent τ υ i := by
      simpa [Ising2DLambda.AlgebraicEigenvalue.matchingPairComponent,
        Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponent,
        Ising2DLambda.AlgebraicEigenvalue.finitePermutationOrbit,
        Ising2DLambda.NecSuf.AlgebraicEigenvalue.permutationOrbit,
        Ising2DLambda.AlgebraicEigenvalue.finiteMapIterate,
        Ising2DLambda.AlgebraicEigenvalue.matchingPairStep,
        Ising2DLambda.NecSuf.AlgebraicEigenvalue.involutionPairStep] using hcover.1 i
    have hsecond : υ.val i ∈ matchingPairComponent τ υ i := by
      simpa [Ising2DLambda.AlgebraicEigenvalue.matchingPairComponent,
        Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponent,
        Ising2DLambda.AlgebraicEigenvalue.finitePermutationOrbit,
        Ising2DLambda.NecSuf.AlgebraicEigenvalue.permutationOrbit,
        Ising2DLambda.AlgebraicEigenvalue.finiteMapIterate,
        Ising2DLambda.AlgebraicEigenvalue.matchingPairStep,
        Ising2DLambda.NecSuf.AlgebraicEigenvalue.involutionPairStep] using (hcover.2.2 i).2
    by_cases hc : i ∈ matchingPairColor τ υ
    · exact ⟨i, i, hfirst, hc, rfl⟩
    · refine ⟨i, υ.val i, hsecond,
        (matchingPairSecondColor_alternates τ υ i).2 hc, hp i⟩

end Ising2DLambda.NecSuf.KacWard
