/- `claim_leading_distance_positive` の具体版が必要十分版の特殊化として得られること。 -/
import Ising2DLambda.CriticalExponent.LeadingDistance
import Ising2DLambda.FisherZero.CriticalDistanceSquaredZeroIff
import Ising2DLambda.FisherZero.CriticalPointNotFisherZero
import Ising2DLambda.FisherZero.RealClosedSumOfTwoSquaresIsSquare
import Ising2DLambda.NecSuf.CriticalExponent.LeadingDistancePositive

namespace Ising2DLambda.CriticalExponent

open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.FisherZero

theorem leadingDistance_positive_from_necSuf
    (L : ℕ) [NeZero L] (hL : 2 ≤ L)
    (data : RealClosedSubfieldData) (s : Qbar) (hs : s * s = 2) :
    realAlgebraicLt data 0 (leadingDistance L hL data s hs) := by
  apply Ising2DLambda.NecSuf.CriticalExponent.leadingDistance_positive_necSuf
    (candidate := fun xi : Qbar => xi ∈ FisherZeroSet L)
    (distance := distanceSquaredToCriticalPoint data s hs)
    (criticalPoint := -1 + s)
    (square := fun w : data.carrier => w * w)
    (lt := realAlgebraicLt data)
  · have hdMin := leadingDistance_isMin L hL data s hs
    obtain ⟨xi, hxi, hdist⟩ :=
      (mem_leadingDistanceFinset L data s hs
        (leadingDistance L hL data s hs)).1 hdMin.1
    exact ⟨xi, hxi, hdist⟩
  · exact distanceSquaredToCriticalPoint_eq_zero_iff data s hs
  · have hcritical : (criticalPoint s : Qbar) ∉ FisherZeroSet L := by
      apply criticalPoint_not_mem_fisherZero L s
      simpa using hs
    simpa [criticalPoint, selfDualRootPlus] using hcritical
  · intro xi
    let ab := realClosedComponents data xi
    let a := ab.1
    let b := ab.2
    obtain ⟨w, hw⟩ := realClosed_sum_of_two_squares_is_square data
      (a - criticalPointRealClosed data s hs) b
    refine ⟨w, ?_⟩
    simpa [distanceSquaredToCriticalPoint, ab, a, b] using hw
  · simp
  · intro y w hw hy
    exact ⟨w, hw, by simpa [hy]⟩

end Ising2DLambda.CriticalExponent
