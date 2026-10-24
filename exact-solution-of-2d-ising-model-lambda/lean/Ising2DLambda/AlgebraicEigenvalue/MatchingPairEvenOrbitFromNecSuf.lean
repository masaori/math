import Ising2DLambda.AlgebraicEigenvalue.MatchingPairEvenOrbit
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairEvenOrbit

namespace Ising2DLambda.AlgebraicEigenvalue
variable {J : Type*} [Fintype J] [LinearOrder J]

theorem matchingPairPermutation_even_orbit_from_necSuf
    (τ υ : FixedPointFreeInvolution J) (i : J) :
    Even (finitePermutationOrbitLength (matchingPairPermutation τ υ) i) := by
  rw [← finitePermutationMinimalPeriod_eq_orbitLength]
  exact NecSuf.AlgebraicEigenvalue.even_of_color_flip
    (matchingPairPermutation τ υ) (fun j => j ∈ matchingPairColor τ υ)
    (matchingPairSuccessor_color τ υ) _ i
    (finitePermutationMinimalPeriod_spec (matchingPairPermutation τ υ) i).2.1

end Ising2DLambda.AlgebraicEigenvalue
