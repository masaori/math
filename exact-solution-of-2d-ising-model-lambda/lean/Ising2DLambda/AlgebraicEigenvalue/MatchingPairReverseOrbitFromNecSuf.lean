import Ising2DLambda.AlgebraicEigenvalue.MatchingPairReverseOrbit
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairReverseOrbit

namespace Ising2DLambda.AlgebraicEigenvalue
variable {J : Type*} [Fintype J] [LinearOrder J]

theorem recoveredMatchingPair_component_eq_orbit_from_necSuf (σ : Equiv.Perm J)
    (heven : ∀ i, Even (finitePermutationOrbitLength σ i)) (i : J) :
    matchingPairComponent (recoveredFirstInvolution σ heven)
      (recoveredSecondInvolution σ heven) i = finitePermutationOrbit σ i := by
  let τ := recoveredFirstInvolution σ heven
  let υ := recoveredSecondInvolution σ heven
  let C : Set J := finitePermutationEvenColor σ
  have hτfirst (j : J) (hj : j ∈ C) : τ.val j = σ j := by
    simp [τ, C, recoveredFirstInvolution, alternatingNeighbor, hj]
  have hτsecond (j : J) (hj : j ∉ C) : τ.val j = σ.symm j := by
    simp [τ, C, recoveredFirstInvolution, alternatingNeighbor, hj]
  have hυfirst (j : J) (hj : j ∈ C) : υ.val j = σ.symm j := by
    simp [υ, C, recoveredSecondInvolution, alternatingNeighbor, hj]
  have hυsecond (j : J) (hj : j ∉ C) : υ.val j = σ j := by
    simp [υ, C, recoveredSecondInvolution, alternatingNeighbor, hj]
  exact NecSuf.AlgebraicEigenvalue.recoveredMatchingPair_component_eq_orbit
    σ C τ.val υ.val τ.property.2 υ.property.2
    hτfirst hτsecond hυfirst hυsecond i

end Ising2DLambda.AlgebraicEigenvalue
