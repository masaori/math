import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairReconstructedOrbit
import Ising2DLambda.AlgebraicEigenvalue.MatchingPairEvenOrbit
import Ising2DLambda.NecSuf.KacWard.TaggedDifferenceOrbitSeparation
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairEvenOrbit

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
  · exact Ising2DLambda.NecSuf.AlgebraicEigenvalue.even_of_color_flip
      (matchingPairPermutation τ υ) (fun j => j ∈ matchingPairColor τ υ)
      (matchingPairSuccessor_color τ υ) _ _
      (finitePermutationMinimalPeriod_spec _ _).2.1
  constructor
  · exact finitePermutationOrbitEnumeration_bijective _ _
  constructor
  · calc
      finitePermutationOrbit (matchingPairPermutation τ υ)
          (matchingPairComponentMinimum τ υ i) =
          matchingPairComponent τ υ (matchingPairComponentMinimum τ υ i) :=
        by
          let C : J → Prop := fun j => j ∈ matchingPairColor τ υ
          have hτcolor (j : J) : C (τ.val j) ↔ ¬ C j :=
            matchingPairColor_alternates τ υ j
          have hυcolor (j : J) : C (υ.val j) ↔ ¬ C j :=
            matchingPairSecondColor_alternates τ υ j
          exact Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairPermutation_orbit_eq_component
            τ.val υ.val C τ.property.2 υ.property.2 hτcolor hυcolor _
      _ = matchingPairComponent τ υ i :=
        matchingPairComponent_basepoint τ υ i _ hm
  constructor
  · exact (finitePermutationMinimalPeriod_spec _ _).2.1
  constructor
  · let C : J → Prop := fun j => j ∈ matchingPairColor τ υ
    have hτcolor (j : J) : C (τ.val j) ↔ ¬ C j :=
      matchingPairColor_alternates τ υ j
    have hυcolor (j : J) : C (υ.val j) ↔ ¬ C j :=
      matchingPairSecondColor_alternates τ υ j
    exact Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairSuccessor_color_necSuf
      τ.val υ.val C hτcolor hυcolor
  · intro j
    rfl

end Ising2DLambda.NecSuf.KacWard
