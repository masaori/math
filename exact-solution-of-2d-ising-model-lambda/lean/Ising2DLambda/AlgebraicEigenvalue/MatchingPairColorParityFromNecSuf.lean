import Ising2DLambda.AlgebraicEigenvalue.MatchingPairPermutationFromNecSuf
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairMinimumColorParity

namespace Ising2DLambda.AlgebraicEigenvalue

variable {J : Type*} [Fintype J] [LinearOrder J]

/-- 成分最小元からの偶数番目と第一色の一致を具体版へ接続する。 -/
theorem matchingPairColor_iterate_iff_even_from_necSuf
    (τ υ : FixedPointFreeInvolution J) (i : J) (n : ℕ) :
    (matchingPairPermutation τ υ)^[n] (matchingPairComponentMinimum τ υ i) ∈
      matchingPairColor τ υ ↔ Even n := by
  exact NecSuf.AlgebraicEigenvalue.matchingPairMinimum_iterate_color_iff_even τ υ i n

end Ising2DLambda.AlgebraicEigenvalue
