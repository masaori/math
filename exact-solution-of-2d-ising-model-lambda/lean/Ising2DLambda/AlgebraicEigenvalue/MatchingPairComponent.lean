import Ising2DLambda.AlgebraicEigenvalue.MatchingPairOrbitExchange

namespace Ising2DLambda.AlgebraicEigenvalue
variable {J : Type*} [Fintype J]

/-- 二歩の軌道と第一の相手の軌道の合併。 -/
def matchingPairComponent (τ υ : FixedPointFreeInvolution J) (i : J) : Set J :=
  finitePermutationOrbit (matchingPairStep τ υ) i ∪
    finitePermutationOrbit (matchingPairStep τ υ) (τ.val i)

/-- 本文の二場合。相手の軌道に始点がある場合だけ、合併の順序を交換する。 -/
theorem matchingPairComponent_basepoint (τ υ : FixedPointFreeInvolution J) (i j : J)
    (h : j ∈ matchingPairComponent τ υ i) :
    matchingPairComponent τ υ j = matchingPairComponent τ υ i := by
  let p := matchingPairStep τ υ
  rcases h with h | h
  · have hmate : τ.val j ∈ finitePermutationOrbit p (τ.val i) :=
      matchingPairStep_mate_mem τ υ i j h
    have hleft := finitePermutationOrbit_basepoint p i j h
    have hright := finitePermutationOrbit_basepoint p (τ.val i) (τ.val j) hmate
    calc
      matchingPairComponent τ υ j =
          finitePermutationOrbit p j ∪ finitePermutationOrbit p (τ.val j) := rfl
      _ = finitePermutationOrbit p i ∪ finitePermutationOrbit p (τ.val j) :=
        congrArg (fun S => S ∪ finitePermutationOrbit p (τ.val j)) hleft
      _ = finitePermutationOrbit p i ∪ finitePermutationOrbit p (τ.val i) :=
        congrArg (fun S => finitePermutationOrbit p i ∪ S) hright
      _ = matchingPairComponent τ υ i := rfl
  · have hmate : τ.val j ∈ finitePermutationOrbit p (τ.val (τ.val i)) :=
      matchingPairStep_mate_mem τ υ (τ.val i) j h
    have hreturn : τ.val j ∈ finitePermutationOrbit p i := by
      rw [τ.property.2 i] at hmate
      exact hmate
    have hleft := finitePermutationOrbit_basepoint p (τ.val i) j h
    have hright := finitePermutationOrbit_basepoint p i (τ.val j) hreturn
    calc
      matchingPairComponent τ υ j =
          finitePermutationOrbit p j ∪ finitePermutationOrbit p (τ.val j) := rfl
      _ = finitePermutationOrbit p (τ.val i) ∪ finitePermutationOrbit p (τ.val j) :=
        congrArg (fun S => S ∪ finitePermutationOrbit p (τ.val j)) hleft
      _ = finitePermutationOrbit p (τ.val i) ∪ finitePermutationOrbit p i :=
        congrArg (fun S => finitePermutationOrbit p (τ.val i) ∪ S) hright
      _ = finitePermutationOrbit p i ∪ finitePermutationOrbit p (τ.val i) :=
        Set.union_comm _ _
      _ = matchingPairComponent τ υ i := rfl

end Ising2DLambda.AlgebraicEigenvalue
