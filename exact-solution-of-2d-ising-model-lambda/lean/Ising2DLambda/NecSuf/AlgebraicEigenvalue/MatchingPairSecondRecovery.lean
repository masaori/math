import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairFirstRecovery

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue
variable {J : Type*}

theorem matchingPair_second_neighbor_recovered
    (τ υ : J → J) (C : J → Prop) (hτ : Function.Involutive τ)
    (hυ : Function.Involutive υ)
    (hτcolor : ∀ i, C (τ i) ↔ ¬ C i) (hυcolor : ∀ i, C (υ i) ↔ ¬ C i)
    (i : J) :
    alternatingNeighbor
      (matchingPairPermutation τ υ C hτ hυ hτcolor hυcolor).symm
      (matchingPairPermutation τ υ C hτ hυ hτcolor hυcolor)
      (fun j => C j) i = υ i := by
  classical
  by_cases hi : C i
  · calc
      alternatingNeighbor
          (matchingPairPermutation τ υ C hτ hυ hτcolor hυcolor).symm
          (matchingPairPermutation τ υ C hτ hυ hτcolor hυcolor)
          (fun j => C j) i =
          (matchingPairPermutation τ υ C hτ hυ hτcolor hυcolor).symm i := by
            change (if C i then (matchingPairPermutation τ υ C hτ hυ hτcolor hυcolor).symm i
              else matchingPairPermutation τ υ C hτ hυ hτcolor hυcolor i) = _
            exact if_pos hi
      _ = matchingPairPredecessor τ υ C i := rfl
      _ = υ i := by rw [matchingPairPredecessor, if_pos hi]
  · calc
      alternatingNeighbor
          (matchingPairPermutation τ υ C hτ hυ hτcolor hυcolor).symm
          (matchingPairPermutation τ υ C hτ hυ hτcolor hυcolor)
          (fun j => C j) i =
          matchingPairPermutation τ υ C hτ hυ hτcolor hυcolor i := by
            change (if C i then (matchingPairPermutation τ υ C hτ hυ hτcolor hυcolor).symm i
              else matchingPairPermutation τ υ C hτ hυ hτcolor hυcolor i) = _
            exact if_neg hi
      _ = matchingPairSuccessor τ υ C i := rfl
      _ = υ i := by rw [matchingPairSuccessor, if_neg hi]

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
