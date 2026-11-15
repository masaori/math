import Ising2DLambda.KacWard.SignedEvenSubgraphDualityUpToSign

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

/-- The fixed-point evaluation selects the sign for the actual torus polynomial,
provided that the signed polynomial does not vanish at that point. -/
theorem signedEvenSubgraphDuality_fixed_point_positive_sign
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
  -- The polynomial zero-product leaves the two possible signs.
  have hsign : f = q ∨ f = -q := signedEvenSubgraphDuality_up_to_sign L z hz s
  -- The fixed-point equation turns the denominator-clearing factor into 2^(L²).
  have hpow : (1 + x) ^ (2 * L ^ 2) = (2 : Qbar) ^ (L ^ 2) := by
    calc
      (1 + x) ^ (2 * L ^ 2) = ((1 + x) ^ 2) ^ (L ^ 2) := by rw [pow_mul]
      _ = (2 : Qbar) ^ (L ^ 2) := by rw [hscale]
  have heval : f.eval x = q.eval x := by
    dsimp [f, q]
    rw [signedEvenSubgraphDualityCleared_eval L (spinComponentFin s.1)
      (spinComponentFin s.2) x hx, hfixed, hpow, Polynomial.eval_mul,
      Polynomial.eval_pow, Polynomial.eval_ofNat]
  -- The value used to distinguish the signs can be cancelled.
  have hqnon : q.eval x ≠ 0 := by
    dsimp [q]
    rw [Polynomial.eval_mul, Polynomial.eval_pow, Polynomial.eval_ofNat]
    exact mul_ne_zero (pow_ne_zero _ (by norm_num)) hq
  rcases hsign with hpos | hneg
  · exact hpos
  · have hsame : q.eval x = -q.eval x := by
      calc
        q.eval x = f.eval x := heval.symm
        _ = (-q).eval x := congrArg (fun p : QbarPoly => p.eval x) hneg
        _ = -q.eval x := by simp
    have htwo : (2 : Qbar) * q.eval x = 0 := by
      calc
        (2 : Qbar) * q.eval x = q.eval x - (-q.eval x) := by ring
        _ = 0 := sub_eq_zero.mpr hsame
    exact False.elim (hqnon ((mul_eq_zero.mp htwo).resolve_left (by norm_num)))

end Ising2DLambda.KacWard
