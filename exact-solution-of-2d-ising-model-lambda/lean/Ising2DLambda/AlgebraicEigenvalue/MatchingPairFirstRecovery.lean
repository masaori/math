import Ising2DLambda.AlgebraicEigenvalue.MatchingPairReconstructedOrbit
import Ising2DLambda.AlgebraicEigenvalue.AlternatingNeighborMatchings

namespace Ising2DLambda.AlgebraicEigenvalue
variable {J : Type*} [Fintype J] [LinearOrder J]

theorem matchingPair_first_neighbor_recovered
    (τ υ : FixedPointFreeInvolution J) (i : J) :
    alternatingNeighbor (matchingPairPermutation τ υ) (matchingPairColor τ υ) i = τ.val i := by
  classical
  by_cases hi : i ∈ matchingPairColor τ υ
  · calc
      alternatingNeighbor (matchingPairPermutation τ υ) (matchingPairColor τ υ) i =
          matchingPairPermutation τ υ i := by rw [alternatingNeighbor, if_pos hi]
      _ = τ.val i := by simp [matchingPairPermutation, matchingPairSuccessor, hi]
  · calc
      alternatingNeighbor (matchingPairPermutation τ υ) (matchingPairColor τ υ) i =
          (matchingPairPermutation τ υ).symm i := by rw [alternatingNeighbor, if_neg hi]
      _ = matchingPairPredecessor τ υ i := rfl
      _ = τ.val i := by rw [matchingPairPredecessor, if_neg hi]

theorem matchingPair_first_pairs_recovered
    (τ υ : FixedPointFreeInvolution J) :
    alternatingNeighborPairs (matchingPairPermutation τ υ) (matchingPairColor τ υ) =
      involutionPairs τ := by
  ext p
  constructor
  · rintro ⟨i, rfl⟩
    exact ⟨i, by rw [matchingPair_first_neighbor_recovered]⟩
  · rintro ⟨i, rfl⟩
    exact ⟨i, by rw [matchingPair_first_neighbor_recovered]⟩

end Ising2DLambda.AlgebraicEigenvalue
