import Ising2DLambda.KacWard.SignedEvenSubgraphDualityFixedPointSign
import Ising2DLambda.KacWard.SignedEvenSubgraphDualityUpToSignFromNecSuf
import Ising2DLambda.NecSuf.KacWard.SignedEvenSubgraphDualityFixedPointSign

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

/-- The generic fixed-point sign argument specializes to the actual torus polynomials. -/
theorem signedEvenSubgraphDuality_fixed_point_positive_sign_from_necSuf
    (L : ℕ) [NeZero L] (z x : Qbar) (hz : z ^ 4 = -1)
    (s : SpinStructure) (hx : 1 + x ≠ 0)
    (hfixed : (1 - x) / (1 + x) = x) (hscale : (1 + x) ^ 2 = 2)
    (hq : ((signedEvenSubgraphPolynomial L (spinComponentFin s.1)
      (spinComponentFin s.2)).map (Int.castRingHom Qbar)).eval x ≠ 0) :
    signedEvenSubgraphDualityCleared L (spinComponentFin s.1)
      (spinComponentFin s.2) =
      2 ^ (L ^ 2) *
        (signedEvenSubgraphPolynomial L (spinComponentFin s.1)
          (spinComponentFin s.2)).map (Int.castRingHom Qbar) := by
  let q : QbarPoly := 2 ^ (L ^ 2) *
    (signedEvenSubgraphPolynomial L (spinComponentFin s.1)
      (spinComponentFin s.2)).map (Int.castRingHom Qbar)
  let f : QbarPoly := signedEvenSubgraphDualityCleared L
    (spinComponentFin s.1) (spinComponentFin s.2)
  have hsign : f = q ∨ f = -q := signedEvenSubgraphDuality_up_to_sign_from_necSuf L z hz s
  have hpow : (1 + x) ^ (2 * L ^ 2) = (2 : Qbar) ^ (L ^ 2) := by
    calc
      (1 + x) ^ (2 * L ^ 2) = ((1 + x) ^ 2) ^ (L ^ 2) := by rw [pow_mul]
      _ = (2 : Qbar) ^ (L ^ 2) := by rw [hscale]
  have heval : f.eval x = q.eval x := by
    dsimp [f, q]
    rw [signedEvenSubgraphDualityCleared_eval L (spinComponentFin s.1)
      (spinComponentFin s.2) x hx, hfixed, hpow, Polynomial.eval_mul,
      Polynomial.eval_pow, Polynomial.eval_ofNat]
  have hqnon : q.eval x ≠ 0 := by
    dsimp [q]
    rw [Polynomial.eval_mul, Polynomial.eval_pow, Polynomial.eval_ofNat]
    exact mul_ne_zero (pow_ne_zero _ (by norm_num)) hq
  exact Ising2DLambda.NecSuf.KacWard.duality_fixed_point_positive_sign
    f q x hsign heval hqnon

end Ising2DLambda.KacWard
