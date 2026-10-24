import Ising2DLambda.AlgebraicEigenvalue.MatchingPairFirstRecovery

namespace Ising2DLambda.AlgebraicEigenvalue
variable {J : Type*} [Fintype J] [LinearOrder J]

theorem matchingPair_second_neighbor_recovered
    (τ υ : FixedPointFreeInvolution J) (i : J) :
    alternatingNeighbor (matchingPairPermutation τ υ).symm (matchingPairColor τ υ) i = υ.val i := by
  classical
  by_cases hi : i ∈ matchingPairColor τ υ
  · calc
      alternatingNeighbor (matchingPairPermutation τ υ).symm (matchingPairColor τ υ) i =
          (matchingPairPermutation τ υ).symm i := by rw [alternatingNeighbor, if_pos hi]
      _ = matchingPairPredecessor τ υ i := rfl
      _ = υ.val i := by rw [matchingPairPredecessor, if_pos hi]
  · calc
      alternatingNeighbor (matchingPairPermutation τ υ).symm (matchingPairColor τ υ) i =
          ((matchingPairPermutation τ υ).symm).symm i := by rw [alternatingNeighbor, if_neg hi]
      _ = matchingPairPermutation τ υ i := rfl
      _ = υ.val i := by simp [matchingPairPermutation, matchingPairSuccessor, hi]

theorem matchingPair_second_pairs_recovered
    (τ υ : FixedPointFreeInvolution J) :
    alternatingNeighborPairs (matchingPairPermutation τ υ).symm (matchingPairColor τ υ) =
      involutionPairs υ := by
  ext p
  constructor
  · rintro ⟨i, rfl⟩
    exact ⟨i, by rw [matchingPair_second_neighbor_recovered]⟩
  · rintro ⟨i, rfl⟩
    exact ⟨i, by rw [matchingPair_second_neighbor_recovered]⟩

end Ising2DLambda.AlgebraicEigenvalue
