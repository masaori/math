import Ising2DLambda.AlgebraicEigenvalue.MatchingPairReconstructedOrbit
import Ising2DLambda.AlgebraicEigenvalue.MatchingPairEvenOrbit
import Ising2DLambda.NecSuf.KacWard.TaggedDifferenceOrbitSeparation

namespace Ising2DLambda.NecSuf.KacWard

open Ising2DLambda.AlgebraicEigenvalue
attribute [local instance] Classical.propDecidable

variable {J : Type*} [Fintype J] [LinearOrder J]

/-- 二つの不動点のない相手写像から、相異なる点を一周する偶数長の交互閉路を得る。 -/
theorem alternatingCycle (τ υ : FixedPointFreeInvolution J) (i : J) :
    let m := matchingPairComponentMinimum τ υ i
    let σ := matchingPairPermutation τ υ
    let n := finitePermutationMinimalPeriod σ m
    Even n ∧
      Function.Bijective (finitePermutationOrbitEnumeration σ m) ∧
      finitePermutationOrbit σ m = matchingPairComponent τ υ i ∧
      finiteMapIterate σ n m = m ∧
      (∀ j, σ j ∈ matchingPairColor τ υ ↔ j ∉ matchingPairColor τ υ) ∧
      (∀ j : J, σ j = if j ∈ matchingPairColor τ υ then τ.val j else υ.val j) := by
  dsimp
  have hm : matchingPairComponentMinimum τ υ i ∈ matchingPairComponent τ υ i :=
    matchingPairComponentMinimum_mem τ υ i
  constructor
  · rw [finitePermutationMinimalPeriod_eq_orbitLength]
    exact matchingPairPermutation_even_orbit τ υ _
  constructor
  · exact finitePermutationOrbitEnumeration_bijective _ _
  constructor
  · calc
      finitePermutationOrbit (matchingPairPermutation τ υ)
          (matchingPairComponentMinimum τ υ i) =
          matchingPairComponent τ υ (matchingPairComponentMinimum τ υ i) :=
        matchingPairPermutation_orbit_eq_component τ υ _
      _ = matchingPairComponent τ υ i :=
        matchingPairComponent_basepoint τ υ i _ hm
  constructor
  · exact (finitePermutationMinimalPeriod_spec _ _).2.1
  constructor
  · exact matchingPairSuccessor_color τ υ
  · intro j
    rfl

end Ising2DLambda.NecSuf.KacWard
