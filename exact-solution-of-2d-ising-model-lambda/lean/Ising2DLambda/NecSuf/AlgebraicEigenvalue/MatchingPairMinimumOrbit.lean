import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairMinimumPermutation
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairReconstructedOrbit
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.PermutationOrbitMinimum

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

variable {J : Type*} [Fintype J] [LinearOrder J]

/-- 最小元から選んだ第一色の後続置換は、二つの相手写像の成分を巡る。 -/
theorem matchingPairMinimumPermutation_orbit_eq_component
    (τ υ : FixedPointFreeInvolution J) (i : J) :
    permutationOrbit (matchingPairMinimumPermutation τ υ) i =
      matchingPairComponent τ.val υ.val τ.property.2 υ.property.2 i := by
  exact matchingPairPermutation_orbit_eq_component τ.val υ.val
    (fun j => j ∈ matchingPairFirstColor τ υ) τ.property.2 υ.property.2
    (matchingPairFirstColor_first_mate τ υ)
    (matchingPairFirstColor_second_mate τ υ) i

/-- 同じ有限集合から取った軌道の最小元と成分の最小元は一致する。 -/
theorem matchingPairComponentMinimum_eq_permutationOrbitMinimum
    (τ υ : FixedPointFreeInvolution J) (i : J) :
    matchingPairComponentMinimum τ υ i =
      permutationOrbitMinimum (matchingPairMinimumPermutation τ υ) i := by
  apply le_antisymm
  · apply matchingPairComponentMinimum_le
    rw [← matchingPairMinimumPermutation_orbit_eq_component τ υ i]
    exact permutationOrbitMinimum_mem _ _
  · apply permutationOrbitMinimum_le
    rw [matchingPairMinimumPermutation_orbit_eq_component τ υ i]
    exact matchingPairComponentMinimum_mem τ υ i

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
