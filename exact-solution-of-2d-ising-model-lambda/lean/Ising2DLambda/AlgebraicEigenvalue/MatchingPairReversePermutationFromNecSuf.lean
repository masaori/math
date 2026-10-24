import Ising2DLambda.AlgebraicEigenvalue.MatchingPairReversePermutation
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairReversePermutation

namespace Ising2DLambda.AlgebraicEigenvalue
variable {J : Type*} [Fintype J] [LinearOrder J]
open Classical

theorem recoveredMatchingPair_permutation_eq_from_necSuf (σ : Equiv.Perm J)
    (heven : ∀ i, Even (finitePermutationOrbitLength σ i)) :
    matchingPairPermutation (recoveredFirstInvolution σ heven)
      (recoveredSecondInvolution σ heven) = σ := by
  let τ := recoveredFirstInvolution σ heven
  let υ := recoveredSecondInvolution σ heven
  let C : Set J := finitePermutationEvenColor σ
  let D : Set J := matchingPairColor τ υ
  have hcolor (i : J) : i ∈ D ↔ i ∈ C :=
    recoveredMatchingPair_color_eq σ heven i
  have hfirst (i : J) (hi : i ∈ C) : τ.val i = σ i := by
    simp [τ, C, recoveredFirstInvolution, alternatingNeighbor, hi]
  have hsecond (i : J) (hi : i ∉ C) : υ.val i = σ i := by
    simp [υ, C, recoveredSecondInvolution, alternatingNeighbor, hi]
  apply Equiv.ext
  intro i
  have h := congrFun (NecSuf.AlgebraicEigenvalue.recoveredMatchingPair_permutation_eq_necSuf
    σ C D τ.val υ.val hcolor hfirst hsecond) i
  simpa [matchingPairPermutation, matchingPairSuccessor, D] using h

end Ising2DLambda.AlgebraicEigenvalue
