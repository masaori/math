/- 実際の対角変換の両側逆関係と、定数埋込みの四つの保存則を必要十分版へ供給する。 -/
import Ising2DLambda.KacWard.PolynomialDiagonalGaugeInverse
import Ising2DLambda.NecSuf.KacWard.PolynomialDiagonalGaugeInverse

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

/-- 具体的な Qbar の対角変換、定数多項式への写像、元の両側逆関係を特殊化する。 -/
theorem polynomialDiagonalGauge_mul_inverse_from_necSuf (L : ℕ) (z : Qbar)
    (hz : z ^ (4 : ℕ) = -1) (s : SpinStructure) :
    polynomialDiagonalGauge L z s * polynomialDiagonalGaugeInverse L z s = 1 ∧
      polynomialDiagonalGaugeInverse L z s * polynomialDiagonalGauge L z s = 1 := by
  have hUV := diagonalGauge_mul_inverse L z hz s
  exact NecSuf.KacWard.mappedMatrices_mul_inverse_necSuf
    qbarConst Polynomial.C_0 Polynomial.C_1
    (fun _ _ => Polynomial.C_add) (fun _ _ => Polynomial.C_mul)
    (diagonalGauge L z s) (diagonalGaugeInverse L z s) hUV.1 hUV.2

end Ising2DLambda.KacWard
