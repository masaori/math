/-
人手証明 `claim_leading_distance_positive` の具体版。

  人手証明                                                   このファイル
  d₁(L) ∈ D_L から Fisher 零点 ξ を取る                       `hdMem`
  d₁(L) = 0 なら dsq_c(ξ) = 0、ゆえに ξ = x_c となる矛盾     `hdne`
  dsq_c(ξ) は R の二つの平方の和なので w·w と書ける           `hdSq`
  d₁(L) ≠ 0 から w ≠ 0                                       `hwne`
  d₁(L) - 0 = w·w を狭義順序の定義へ当てる                    結論

住処: Qbar。実数体・複素数体は現れない。
-/
import Ising2DLambda.CriticalExponent.LeadingDistance
import Ising2DLambda.FisherZero.CriticalDistanceSquaredZeroIff
import Ising2DLambda.FisherZero.CriticalPointNotFisherZero
import Ising2DLambda.FisherZero.RealClosedSumOfTwoSquaresIsSquare

namespace Ising2DLambda.CriticalExponent

open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.FisherZero

/-- 先頭距離は、実閉部分体の狭義順序で零元より大きい。 -/
theorem leadingDistance_positive (L : ℕ) [NeZero L] (hL : 2 ≤ L)
    (data : RealClosedSubfieldData) (s : Qbar) (hs : s * s = 2) :
    realAlgebraicLt data 0 (leadingDistance L hL data s hs) := by
  let d := leadingDistance L hL data s hs
  have hdMin := leadingDistance_isMin L hL data s hs
  have hdMem : d ∈ leadingDistanceFinset L data s hs := hdMin.1
  obtain ⟨xi, hxi, hxiDist⟩ :=
    (mem_leadingDistanceFinset L data s hs d).1 hdMem

  -- d₁(L) = 0 なら xi = x_c となり、x_c が Fisher 零点でないことに反する。
  have hdne : d ≠ 0 := by
    intro hd0
    have hdist0 : distanceSquaredToCriticalPoint data s hs xi = 0 := hxiDist.trans hd0
    have hxic : xi = -1 + s :=
      (distanceSquaredToCriticalPoint_eq_zero_iff data s hs xi).1 hdist0
    have hcritical : (criticalPoint s : Qbar) ∉ FisherZeroSet L := by
      apply criticalPoint_not_mem_fisherZero L s
      simpa using hs
    apply hcritical
    simpa [criticalPoint, selfDualRootPlus] using hxic ▸ hxi

  -- 距離の二乗を R の零でない元の平方として書く。
  let ab := realClosedComponents data xi
  let a := ab.1
  let b := ab.2
  obtain ⟨w, hw⟩ := realClosed_sum_of_two_squares_is_square data
    (a - criticalPointRealClosed data s hs) b
  have hdistSq : distanceSquaredToCriticalPoint data s hs xi = w * w := by
    simpa [distanceSquaredToCriticalPoint, ab, a, b] using hw
  have hdSq : d = w * w := hxiDist.symm.trans hdistSq
  have hwne : w ≠ 0 := by
    intro hw0
    apply hdne
    simpa [hw0] using hdSq

  -- 狭義順序の定義へ当てる。
  exact ⟨w, hwne, by simpa using hdSq⟩

end Ising2DLambda.CriticalExponent
