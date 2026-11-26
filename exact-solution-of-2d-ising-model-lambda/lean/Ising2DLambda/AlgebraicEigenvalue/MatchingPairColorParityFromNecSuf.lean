import Ising2DLambda.AlgebraicEigenvalue.MatchingPairPermutationFromNecSuf
import Ising2DLambda.AlgebraicEigenvalue.MatchingPairReconstructedOrbit
import Ising2DLambda.AlgebraicEigenvalue.EvenOrbitColoring
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairMinimumColorParity

namespace Ising2DLambda.AlgebraicEigenvalue

variable {J : Type*} [Fintype J] [LinearOrder J]

/-- 成分最小元からの偶数番目と第一色の一致を具体版へ接続する。 -/
theorem matchingPairColor_iterate_iff_even_from_necSuf
    (τ υ : FixedPointFreeInvolution J) (i : J) (n : ℕ) :
    (matchingPairPermutation τ υ)^[n] (matchingPairComponentMinimum τ υ i) ∈
      matchingPairColor τ υ ↔ Even n := by
  exact NecSuf.AlgebraicEigenvalue.matchingPairMinimum_iterate_color_iff_even τ υ i n

/-- 最小元からの短い反復座標で、二つの第一色を同定する。 -/
theorem matchingPair_evenColor_iff_from_necSuf
    (τ υ : FixedPointFreeInvolution J) (i : J) :
    i ∈ finitePermutationEvenColor (matchingPairPermutation τ υ) ↔
      i ∈ matchingPairColor τ υ := by
  let σ := matchingPairPermutation τ υ
  have hsets : matchingPairComponent τ υ i = finitePermutationOrbit σ i :=
    (matchingPairPermutation_orbit_eq_component τ υ i).symm
  have hpoints : matchingPairComponentPoints τ υ i = finitePermutationOrbitPoints σ i := by
    apply Finset.ext
    intro j
    simpa [matchingPairComponentPoints, finitePermutationOrbitPoints] using
      Set.ext_iff.mp hsets j
  have hmin : matchingPairComponentMinimum τ υ i = finitePermutationOrbitMinimum σ i := by
    simpa only [matchingPairComponentMinimum, finitePermutationOrbitMinimum, hpoints]
  let r := finitePermutationOrbitCoordinate σ i
  have hr := (finitePermutationOrbitCoordinate_spec σ i).2
  have hcolor : i ∈ matchingPairColor τ υ ↔ Even r := by
    rw [← hr, ← hmin]
    exact matchingPairColor_iterate_iff_even_from_necSuf τ υ i r
  rw [finitePermutationEvenColor_mem]
  exact Nat.even_iff.symm.trans hcolor.symm

/-- 有限置換の反復座標で選ぶ偶数色は、マッチング対から構成した第一色である。 -/
theorem matchingPair_evenColor_eq_from_necSuf
    (τ υ : FixedPointFreeInvolution J) :
    finitePermutationEvenColor (matchingPairPermutation τ υ) = matchingPairColor τ υ := by
  ext i
  exact matchingPair_evenColor_iff_from_necSuf τ υ i

end Ising2DLambda.AlgebraicEigenvalue
