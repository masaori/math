import Ising2DLambda.KacWard.SignedEvenSubgraphDualitySquares
import Ising2DLambda.AlgebraicEigenvalue.QbarPolynomialZeroProduct

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

/-- The two actual torus polynomials differ only by a sign. -/
theorem signedEvenSubgraphDuality_up_to_sign (L : ℕ) [NeZero L]
    (z : Qbar) (hz : z ^ 4 = -1) (s : SpinStructure) :
    signedEvenSubgraphDualityCleared L (spinComponentFin s.1)
        (spinComponentFin s.2) =
        2 ^ (L ^ 2) *
          (signedEvenSubgraphPolynomial L (spinComponentFin s.1)
            (spinComponentFin s.2)).map (Int.castRingHom Qbar) ∨
      signedEvenSubgraphDualityCleared L (spinComponentFin s.1)
        (spinComponentFin s.2) =
        -(2 ^ (L ^ 2) *
          (signedEvenSubgraphPolynomial L (spinComponentFin s.1)
            (spinComponentFin s.2)).map (Int.castRingHom Qbar)) := by
  let f : QbarPoly := signedEvenSubgraphDualityCleared L
    (spinComponentFin s.1) (spinComponentFin s.2)
  let q : QbarPoly := 2 ^ (L ^ 2) *
    (signedEvenSubgraphPolynomial L (spinComponentFin s.1)
      (spinComponentFin s.2)).map (Int.castRingHom Qbar)
  have hsq : f ^ 2 = q ^ 2 := signedEvenSubgraphDuality_squares L z hz s
  have hprod : (f - q) * (f + q) = 0 := by
    calc
      (f - q) * (f + q) = f ^ 2 - q ^ 2 := by ring
      _ = q ^ 2 - q ^ 2 := by rw [hsq]
      _ = 0 := sub_self _
  rcases qbarPolynomial_zero_product (f - q) (f + q) hprod with hdiff | hsum
  · exact Or.inl (sub_eq_zero.mp hdiff)
  · exact Or.inr (add_eq_zero_iff_eq_neg.mp hsum)

end Ising2DLambda.KacWard
