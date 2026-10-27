import Ising2DLambda.KacWard.TaggedDifferenceOrbitSeparation
import Ising2DLambda.AlgebraicEigenvalue.MatchingPairReconstructedOrbit
import Ising2DLambda.AlgebraicEigenvalue.MatchingPairEvenOrbit

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
attribute [local instance] Classical.propDecidable

/-- 実際の活動点上の長短二対を、標識を保って交互閉路に並べる。 -/
theorem taggedActive_alternatingCycle {L : ℕ}
    (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L))
    (i : {i : OrientedEdge L // i ∈ concreteTaggedActiveVertices D t}) :
    let τ := concreteShortInvolution D t
    let υ := concreteLongInvolution D t
    let m := matchingPairComponentMinimum τ υ i
    let σ := matchingPairPermutation τ υ
    let n := finitePermutationMinimalPeriod σ m
    Even n ∧
      Function.Bijective (finitePermutationOrbitEnumeration σ m) ∧
      finitePermutationOrbit σ m = matchingPairComponent τ υ i ∧
      finiteMapIterate σ n m = m ∧
      (∀ j, σ j ∈ matchingPairColor τ υ ↔ j ∉ matchingPairColor τ υ) ∧
      (∀ j, σ j = if j ∈ matchingPairColor τ υ then τ.val j else υ.val j) := by
  dsimp
  let τ := concreteShortInvolution D t
  let υ := concreteLongInvolution D t
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

end Ising2DLambda.KacWard
