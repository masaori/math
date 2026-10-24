import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairOrbitExchange

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue
variable {J : Type*}

/- 有限性・順序・不動点の不在を使わない。二つの対合性は二歩置換と軌道の交換に必要。 -/

/-- 二歩の軌道と第一の相手の軌道の合併。 -/
def matchingPairComponent (τ υ : J → J) (hτ : Function.Involutive τ) (hυ : Function.Involutive υ) (i : J) : Set J :=
  permutationOrbit (involutionPairStep τ υ hτ hυ) i ∪
    permutationOrbit (involutionPairStep τ υ hτ hυ) (τ i)

/-- 本文の二場合。相手の軌道に始点がある場合だけ、合併の順序を交換する。 -/
theorem matchingPairComponent_basepoint (τ υ : J → J) (hτ : Function.Involutive τ) (hυ : Function.Involutive υ) (i j : J)
    (h : j ∈ matchingPairComponent τ υ hτ hυ i) :
    matchingPairComponent τ υ hτ hυ j = matchingPairComponent τ υ hτ hυ i := by
  let p := involutionPairStep τ υ hτ hυ
  rcases h with h | h
  · have hmate : τ j ∈ permutationOrbit p (τ i) :=
      matchingPairStep_mate_mem τ υ hτ hυ i j h
    have hleft := permutationOrbit_basepoint_necSuf p i j h
    have hright := permutationOrbit_basepoint_necSuf p (τ i) (τ j) hmate
    calc
      matchingPairComponent τ υ hτ hυ j =
          permutationOrbit p j ∪ permutationOrbit p (τ j) := rfl
      _ = permutationOrbit p i ∪ permutationOrbit p (τ j) :=
        congrArg (fun S => S ∪ permutationOrbit p (τ j)) hleft
      _ = permutationOrbit p i ∪ permutationOrbit p (τ i) :=
        congrArg (fun S => permutationOrbit p i ∪ S) hright
      _ = matchingPairComponent τ υ hτ hυ i := rfl
  · have hmate : τ j ∈ permutationOrbit p (τ (τ i)) :=
      matchingPairStep_mate_mem τ υ hτ hυ (τ i) j h
    have hreturn : τ j ∈ permutationOrbit p i := by
      rw [hτ i] at hmate
      exact hmate
    have hleft := permutationOrbit_basepoint_necSuf p (τ i) j h
    have hright := permutationOrbit_basepoint_necSuf p i (τ j) hreturn
    calc
      matchingPairComponent τ υ hτ hυ j =
          permutationOrbit p j ∪ permutationOrbit p (τ j) := rfl
      _ = permutationOrbit p (τ i) ∪ permutationOrbit p (τ j) :=
        congrArg (fun S => S ∪ permutationOrbit p (τ j)) hleft
      _ = permutationOrbit p (τ i) ∪ permutationOrbit p i :=
        congrArg (fun S => permutationOrbit p (τ i) ∪ S) hright
      _ = permutationOrbit p i ∪ permutationOrbit p (τ i) :=
        Set.union_comm _ _
      _ = matchingPairComponent τ υ hτ hυ i := rfl

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
