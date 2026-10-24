import Ising2DLambda.AlgebraicEigenvalue.MatchingPairReverseColor
import Ising2DLambda.AlgebraicEigenvalue.MatchingPairPermutation

namespace Ising2DLambda.AlgebraicEigenvalue
variable {J : Type*} [Fintype J] [LinearOrder J]
open Classical

/-- 復元した二つの相手写像で色に応じて進むと元の置換になる。 -/
theorem recoveredMatchingPair_permutation_eq (σ : Equiv.Perm J)
    (heven : ∀ i, Even (finitePermutationOrbitLength σ i)) :
    matchingPairPermutation (recoveredFirstInvolution σ heven)
      (recoveredSecondInvolution σ heven) = σ := by
  apply Equiv.ext
  intro i
  let τ := recoveredFirstInvolution σ heven
  let υ := recoveredSecondInvolution σ heven
  have hcolor : i ∈ matchingPairColor τ υ ↔ i ∈ finitePermutationEvenColor σ :=
    recoveredMatchingPair_color_eq σ heven i
  by_cases hi : i ∈ finitePermutationEvenColor σ
  · have hpair : i ∈ matchingPairColor τ υ := hcolor.mpr hi
    calc
      matchingPairPermutation τ υ i = τ.val i := by
        simp [matchingPairPermutation, matchingPairSuccessor, hpair]
      _ = σ i := by
        simp [τ, recoveredFirstInvolution, alternatingNeighbor, hi]
  · have hpair : i ∉ matchingPairColor τ υ := fun h => hi (hcolor.mp h)
    calc
      matchingPairPermutation τ υ i = υ.val i := by
        simp [matchingPairPermutation, matchingPairSuccessor, hpair]
      _ = σ i := by
        simp [υ, recoveredSecondInvolution, alternatingNeighbor, hi]

end Ising2DLambda.AlgebraicEigenvalue
