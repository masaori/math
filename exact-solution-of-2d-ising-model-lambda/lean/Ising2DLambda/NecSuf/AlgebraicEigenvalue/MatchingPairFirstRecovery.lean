import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairPermutation
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.AlternatingNeighborMatchings

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue
variable {J : Type*}

theorem matchingPair_first_neighbor_recovered
    (τ υ : J → J) (C : J → Prop) (hτ : Function.Involutive τ)
    (hυ : Function.Involutive υ)
    (hτcolor : ∀ i, C (τ i) ↔ ¬ C i) (hυcolor : ∀ i, C (υ i) ↔ ¬ C i)
    (i : J) :
    alternatingNeighbor
      (matchingPairPermutation τ υ C hτ hυ hτcolor hυcolor)
      (matchingPairPermutation τ υ C hτ hυ hτcolor hυcolor).symm
      (fun j => C j) i = τ i := by
  classical
  by_cases hi : C i
  · calc
      alternatingNeighbor
          (matchingPairPermutation τ υ C hτ hυ hτcolor hυcolor)
          (matchingPairPermutation τ υ C hτ hυ hτcolor hυcolor).symm
          (fun j => C j) i =
          matchingPairPermutation τ υ C hτ hυ hτcolor hυcolor i := by
            change (if C i then matchingPairPermutation τ υ C hτ hυ hτcolor hυcolor i
              else (matchingPairPermutation τ υ C hτ hυ hτcolor hυcolor).symm i) = _
            exact if_pos hi
      _ = τ i := by simp [matchingPairPermutation, matchingPairSuccessor, hi]
  · calc
      alternatingNeighbor
          (matchingPairPermutation τ υ C hτ hυ hτcolor hυcolor)
          (matchingPairPermutation τ υ C hτ hυ hτcolor hυcolor).symm
          (fun j => C j) i =
          (matchingPairPermutation τ υ C hτ hυ hτcolor hυcolor).symm i := by
            change (if C i then matchingPairPermutation τ υ C hτ hυ hτcolor hυcolor i
              else (matchingPairPermutation τ υ C hτ hυ hτcolor hυcolor).symm i) = _
            exact if_neg hi
      _ = matchingPairPredecessor τ υ C i := rfl
      _ = τ i := by rw [matchingPairPredecessor, if_neg hi]

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
