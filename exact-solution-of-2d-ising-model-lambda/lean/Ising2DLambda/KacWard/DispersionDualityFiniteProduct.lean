import Ising2DLambda.KacWard.DispersionDualityCleared
import Ising2DLambda.KacWard.DispersionModeProduct

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

/-- The mode product in the human proof, before identifying its cardinality
with `L²`. Both products are evaluations of the actual dispersion factors. -/
theorem dispersion_mode_product_duality_factor {L : ℕ} [NeZero L]
    (z x : Qbar) (hz4 : z ^ 4 = -1) (s : SpinStructure)
    (hx : 1 + x ≠ 0) :
    (1 + x) ^ (4 * Fintype.card (FourierModePair L s)) *
        (kacWardDeterminant (kacWardTransitionMatrix L z s)).eval
          (Ising2DLambda.FisherZero.kwDualTransform x) =
      4 ^ Fintype.card (FourierModePair L s) *
        (kacWardDeterminant (kacWardTransitionMatrix L z s)).eval x := by
  classical
  simp only [dispersion_mode_product z hz4 s, Polynomial.eval_prod]
  calc
    (1 + x) ^ (4 * Fintype.card (FourierModePair L s)) *
        ∏ m : FourierModePair L s,
          (dispersionPolynomial m.1.1 m.1.2).eval
            (Ising2DLambda.FisherZero.kwDualTransform x) =
        ∏ m : FourierModePair L s,
          ((1 + x) ^ 4 *
            (dispersionPolynomial m.1.1 m.1.2).eval
              (Ising2DLambda.FisherZero.kwDualTransform x)) := by
      rw [Finset.prod_mul_distrib, Finset.prod_const, Finset.card_univ]
      rw [← pow_mul]
    _ = ∏ m : FourierModePair L s,
          (4 * (dispersionPolynomial m.1.1 m.1.2).eval x) := by
      apply Finset.prod_congr rfl
      intro m _
      exact dispersionPolynomial_duality_factor m.1.1 m.1.2 x hx
    _ = 4 ^ Fintype.card (FourierModePair L s) *
          ∏ m : FourierModePair L s,
            (dispersionPolynomial m.1.1 m.1.2).eval x := by
      rw [Finset.prod_mul_distrib, Finset.prod_const, Finset.card_univ]

end Ising2DLambda.KacWard
