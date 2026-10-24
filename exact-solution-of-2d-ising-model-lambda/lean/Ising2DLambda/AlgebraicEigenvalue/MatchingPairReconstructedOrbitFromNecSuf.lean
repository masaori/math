import Ising2DLambda.AlgebraicEigenvalue.MatchingPairReconstructedOrbit
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairReconstructedOrbit

namespace Ising2DLambda.AlgebraicEigenvalue
variable {J : Type*} [Fintype J] [LinearOrder J]

/-- 有限順序集合上の具体的な二色付けは、必要十分版の色反転仮定を満たす。 -/
theorem matchingPairPermutation_orbit_eq_component_from_necSuf
    (τ υ : FixedPointFreeInvolution J) (i : J) :
    finitePermutationOrbit (matchingPairPermutation τ υ) i = matchingPairComponent τ υ i := by
  let C : J → Prop := fun j => j ∈ matchingPairColor τ υ
  have hτcolor (j : J) : C (τ.val j) ↔ ¬ C j := matchingPairColor_alternates τ υ j
  have hυcolor (j : J) : C (υ.val j) ↔ ¬ C j := matchingPairSecondColor_alternates τ υ j
  exact NecSuf.AlgebraicEigenvalue.matchingPairPermutation_orbit_eq_component
    τ.val υ.val C τ.property.2 υ.property.2 hτcolor hυcolor i

end Ising2DLambda.AlgebraicEigenvalue
