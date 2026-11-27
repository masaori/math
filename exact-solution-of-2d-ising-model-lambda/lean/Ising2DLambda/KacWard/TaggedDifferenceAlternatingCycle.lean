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
  -- 本文の第一段: 基準マッチング `𝒟₀`（`claim_reference_long_matching`）と `D` の相手写像は
  -- `claim_perfect_matching_involution` により不動点のない対合で、
  -- `claim_tagged_difference_two_step_orbit` の活動点への制限も同じ値を取るので不動点のない対合である。
  let D₀ : PerfectMatching (OrientedEdge L) :=
    ⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩
  let τ : FixedPointFreeInvolution {i : OrientedEdge L // i ∈ concreteTaggedActiveVertices D t} :=
    ⟨taggedConcreteShortMate D t,
      (fun i h => perfectMatchingMate_ne D i.1 (congrArg Subtype.val h)),
      (fun i => Subtype.ext (perfectMatchingMate_involutive D i.1))⟩
  let υ : FixedPointFreeInvolution {i : OrientedEdge L // i ∈ concreteTaggedActiveVertices D t} :=
    ⟨taggedConcreteLongMate D t,
      (fun i h => perfectMatchingMate_ne D₀ i.1 (congrArg Subtype.val h)),
      (fun i => Subtype.ext (perfectMatchingMate_involutive D₀ i.1))⟩
  have hτ : concreteShortInvolution D t = τ := rfl
  have hυ : concreteLongInvolution D t = υ := rfl
  rw [hτ, hυ]
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

/-- 本文の主張のうち、周期が偶数であることと周期で始点へ帰ることだけを取り出す。
引く側が軌道の列挙を使わないとき、列挙の全単射を結論の型に持ち込まないためにこちらを引く。 -/
theorem taggedActive_alternatingCycle_even_return {L : ℕ}
    (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L))
    (i : {i : OrientedEdge L // i ∈ concreteTaggedActiveVertices D t}) :
    let τ := concreteShortInvolution D t
    let υ := concreteLongInvolution D t
    let m := matchingPairComponentMinimum τ υ i
    let σ := matchingPairPermutation τ υ
    let n := finitePermutationMinimalPeriod σ m
    Even n ∧ finiteMapIterate σ n m = m :=
  ⟨(taggedActive_alternatingCycle D t i).1, (taggedActive_alternatingCycle D t i).2.2.2.1⟩

end Ising2DLambda.KacWard
