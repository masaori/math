import Ising2DLambda.KacWard.DispersionPolynomial
import Ising2DLambda.FisherZero.KwDualTransformDomain
import Ising2DLambda.KacWard.DispersionKwDuality

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue Polynomial

/-- The actual dispersion factor after clearing the four denominators. -/
theorem dispersionPolynomial_duality_cleared (varpi varsigma : Qbar) :
    ((1 + (X : QbarPoly)) ^ 2 + (1 - X) ^ 2) ^ 2 -
      (1 - X) * ((1 + X) ^ 2 - (1 - X) ^ 2) * (1 + X) *
        (C varpi + C varpi⁻¹ + C varsigma + C varsigma⁻¹) =
      4 * dispersionPolynomial varpi varsigma := by
  unfold dispersionPolynomial
  ring

/-- The dispersion identity at one mode after evaluating the KW rational map:
本文 `claim_dispersion_kw_duality` の等式 `(1+x)^4 Δ(KW(x); ϖ, ς) = 4 Δ(x; ϖ, ς)` を、
定数の埋め込み `Qbar → Qbar(x)` の像で評価し、埋め込みの単射性で `Qbar` の等式へ戻したもの。 -/
theorem dispersionPolynomial_duality_factor (varpi varsigma x : Qbar)
    (hx : 1 + x ≠ 0) :
    (1 + x) ^ 4 *
      (dispersionPolynomial varpi varsigma).eval
        (Ising2DLambda.FisherZero.kwDualTransform x) =
      4 * (dispersionPolynomial varpi varsigma).eval x := by
  let ι := algebraMap Qbar (RatFunc Qbar)
  have hι : 1 + ι x ≠ 0 := by
    rw [← map_one ι, ← map_add]
    exact (map_ne_zero ι).mpr hx
  -- 本文: `claim_dispersion_kw_duality`
  have h := dispersion_kw_duality (ι x) (ι varpi) (ι varsigma) hι
  apply ι.injective
  simp only [dispersionPolynomial, Polynomial.eval_sub, Polynomial.eval_add,
    Polynomial.eval_mul, Polynomial.eval_pow, Polynomial.eval_one,
    Polynomial.eval_X, Polynomial.eval_C, Ising2DLambda.FisherZero.kwDualTransform,
    map_mul, map_add, map_sub, map_pow, map_one, map_inv₀, map_ofNat]
  simpa only [div_eq_mul_inv] using h

end Ising2DLambda.KacWard
