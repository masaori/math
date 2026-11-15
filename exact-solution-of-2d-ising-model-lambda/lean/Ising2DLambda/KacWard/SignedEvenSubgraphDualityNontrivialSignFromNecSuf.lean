import Ising2DLambda.KacWard.SignedEvenSubgraphDualityUpToSignFromNecSuf
import Ising2DLambda.KacWard.DispersionCriticalProductNonzeroFromNecSuf
import Ising2DLambda.NecSuf.KacWard.SignedEvenSubgraphDualityNontrivialSign

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.FisherZero
open Polynomial

/-- The abstract finite-product and fixed-point steps yield the concrete positive branch. -/
theorem signedEvenSubgraphDuality_nontrivial_positive_sign_from_necSuf
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
  let q : QbarPoly := (signedEvenSubgraphPolynomial L (spinComponentFin s.1)
    (spinComponentFin s.2)).map (Int.castRingHom Qbar)
  let f : QbarPoly := signedEvenSubgraphDualityCleared L
    (spinComponentFin s.1) (spinComponentFin s.2)
  let c : Qbar := 2 ^ (L ^ 2)
  let d : Qbar := (kacWardDeterminant (kacWardTransitionMatrix L z s)).eval x
  let factor : FourierModePair L s → Qbar := fun m =>
    (dispersionPolynomial m.1.1 m.1.2).eval x
  have hsign : f = Polynomial.C c * q ∨ f = -(Polynomial.C c * q) := by
    simpa only [f, q, c, map_pow, map_ofNat] using
      signedEvenSubgraphDuality_up_to_sign_from_necSuf L z hz s
  have hpow : (1 + x) ^ (2 * L ^ 2) = (2 : Qbar) ^ (L ^ 2) := by
    calc
      (1 + x) ^ (2 * L ^ 2) = ((1 + x) ^ 2) ^ (L ^ 2) := by rw [pow_mul]
      _ = (2 : Qbar) ^ (L ^ 2) := by rw [hscale]
  have heval : f.eval x = (Polynomial.C c * q).eval x := by
    dsimp [f, c, q]
    rw [signedEvenSubgraphDualityCleared_eval L (spinComponentFin s.1)
      (spinComponentFin s.2) x hplus, hfixed, hpow, Polynomial.eval_mul,
      Polynomial.eval_C]
  have hsquare : d = (q.eval x) ^ 2 := by
    simpa only [d, q, eval_pow] using congrArg (Polynomial.eval x)
      (kacWardDeterminant_eq_signedEvenSubgraphPolynomial_sq (L := L) z hz s)
  have hproduct : d = ∏ m : FourierModePair L s, factor m := by
    simpa only [d, factor, eval_prod] using congrArg (Polynomial.eval x)
      (dispersion_mode_product (L := L) z hz s)
  have hfactor : ∀ m : FourierModePair L s, factor m ≠ 0 := by
    intro m
    exact dispersion_critical_nonzero data L hL s hs m.1.1 m.1.2
      m.2.1 m.2.2 x hx hx0 hx1
  have hc : c ≠ 0 := pow_ne_zero _ (by norm_num)
  have hresult := Ising2DLambda.NecSuf.KacWard.duality_nontrivial_positive_sign
    f q c d x factor hc hsign heval hsquare hproduct hfactor
  simpa only [f, q, c, map_pow, map_ofNat] using hresult

end Ising2DLambda.KacWard
