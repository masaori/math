import Ising2DLambda.KacWard.TaggedDifferenceOrbitSeparation
import Ising2DLambda.NecSuf.KacWard.AlternatingCycleEnumeration

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
attribute [local instance] Classical.propDecidable

/-- 実際の活動辺上の二つの相手写像は、必要十分版の交互閉路の仮定を満たす。 -/
theorem taggedActive_alternatingCycle_from_necSuf {L : ℕ}
    (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L))
    (i : {i : OrientedEdge L // i ∈ concreteTaggedActiveVertices D t}) :
    let τ := concreteShortInvolution D t
    let υ := concreteLongInvolution D t
    let C : {i : OrientedEdge L // i ∈ concreteTaggedActiveVertices D t} → Prop :=
      fun j => j ∈ matchingPairColor τ υ
    let σ := Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairPermutation
      τ.val υ.val C τ.property.2 υ.property.2
      (fun j => matchingPairColor_alternates τ υ j)
      (fun j => matchingPairSecondColor_alternates τ υ j)
    let p := Ising2DLambda.NecSuf.AlgebraicEigenvalue.finiteInjectiveMinimalPeriod σ σ.injective i
    Even p ∧
      Function.Bijective (Ising2DLambda.NecSuf.AlgebraicEigenvalue.twoWayOrbitEnumeration σ σ.symm i p) ∧
      Ising2DLambda.NecSuf.AlgebraicEigenvalue.twoWayOrbit σ σ.symm i =
        Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponent
          τ.val υ.val τ.property.2 υ.property.2 i ∧
      σ^[p] i = i ∧
      (∀ j, C (σ j) ↔ ¬ C j) ∧
      (∀ j, σ j = if C j then τ.val j else υ.val j) := by
  let τ := concreteShortInvolution D t
  let υ := concreteLongInvolution D t
  let C : {i : OrientedEdge L // i ∈ concreteTaggedActiveVertices D t} → Prop :=
    fun j => j ∈ matchingPairColor τ υ
  have hτcolor (j) : C (τ.val j) ↔ ¬ C j := matchingPairColor_alternates τ υ j
  have hυcolor (j) : C (υ.val j) ↔ ¬ C j := matchingPairSecondColor_alternates τ υ j
  exact Ising2DLambda.NecSuf.KacWard.alternatingCycleEnumeration_necSuf
    τ.val υ.val C τ.property.2 υ.property.2 hτcolor hυcolor i

end Ising2DLambda.KacWard
