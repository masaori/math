import Ising2DLambda.KacWard.SignedEvenSubgraphDualityFixedPointSign
import Ising2DLambda.KacWard.DispersionCriticalProductNonzero

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.FisherZero

/-- At a root of the self-dual equation, every nontrivial twist takes the positive branch. -/
theorem signedEvenSubgraphDuality_nontrivial_positive_sign
    (data : RealClosedSubfieldData) (L : ℕ) [NeZero L] (hL : 1 ≤ L)
    (z : Qbar) (hz : z ^ (4 : ℕ) = -1)
    (s : SpinStructure) (hs : s ≠ (false, false))
    (x : Qbar) (hx : x ^ 2 + 2 * x - 1 = 0) :
    signedEvenSubgraphDualityCleared L (spinComponentFin s.1)
      (spinComponentFin s.2) =
      2 ^ (L ^ 2) *
        (signedEvenSubgraphPolynomial L (spinComponentFin s.1)
          (spinComponentFin s.2)).map (Int.castRingHom Qbar) := by
  have hx0 : x ≠ 0 := by
    intro h
    rw [h] at hx
    norm_num at hx
  have hx1 : x ^ 2 ≠ 1 := by
    intro h
    have htwo : (2 : Qbar) * x = 0 := by linear_combination hx - h
    exact hx0 ((mul_eq_zero.mp htwo).resolve_left (by norm_num))
  have hplus : 1 + x ≠ 0 := by
    intro h
    have hminus : x = -1 := by linear_combination h
    rw [hminus] at hx
    norm_num at hx
  have hscale : (1 + x) ^ 2 = (2 : Qbar) := by linear_combination hx
  have hfixed : (1 - x) / (1 + x) = x := by
    apply (div_eq_iff hplus).2
    linear_combination -hx
  have hnonzero := signedEvenSubgraph_critical_nonzero
    data L hL z hz s hs x hx hx0 hx1
  exact signedEvenSubgraphDuality_fixed_point_positive_sign
    L z x hz s hplus hfixed hscale hnonzero

end Ising2DLambda.KacWard
