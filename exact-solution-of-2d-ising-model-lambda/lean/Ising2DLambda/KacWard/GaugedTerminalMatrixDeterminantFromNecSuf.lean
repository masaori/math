/- 必要十分版へ、定数埋込み・向き付き辺の個数・実際の対角行列と端末行列、
自前の行列式の乗法性とスカラー倍の導出版を供給する。 -/
import Ising2DLambda.KacWard.GaugedTerminalMatrixDeterminant
import Ising2DLambda.NecSuf.KacWard.GaugedTerminalMatrixDeterminant
import Ising2DLambda.NecSuf.KacWard.TransitionEntries
import Ising2DLambda.KacWard.PolynomialDiagonalGaugeInverseFromNecSuf
import Ising2DLambda.KacWard.TerminalMatrixDeterminantFromNecSuf
import Ising2DLambda.AlgebraicEigenvalue.QbarPolynomialDeterminantMultiplicativityFromNecSuf
import Ising2DLambda.AlgebraicEigenvalue.QbarPolynomialDeterminantScalarFromNecSuf

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue Ising2DLambda.PartitionPolynomial

theorem gaugeScalar_pow_card_from_necSuf (L : ℕ) (z : Qbar) (hz : z ^ 4 = -1) :
    qbarConst (z ^ 2) ^ Fintype.card (OrientedEdge L) = 1 := by
  have hcard : Fintype.card (OrientedEdge L) = 4 * L ^ 2 := by
    change Fintype.card (Edge L × Bool) = _
    rw [Fintype.card_prod, card_edge, Fintype.card_bool]
    ring
  rw [hcard]
  exact NecSuf.KacWard.mapped_eighthRoot_square_power_necSuf
    (Polynomial.C : Qbar →+* QbarPoly).toMonoidHom z
    (NecSuf.KacWard.pow_eight_of_pow_four_neg_one hz) (L ^ 2)

theorem gaugedTerminalMatrix_determinant_from_necSuf (L : ℕ) [NeZero L]
    (z : Qbar) (hz : z ^ 4 = -1) (s : SpinStructure) :
    Matrix.det (gaugedTerminalMatrix L z s) =
      kacWardDeterminant (kacWardTransitionMatrix L z s) := by
  classical
  have hpos : 0 < L := NeZero.pos L
  letI : Nonempty (OrientedEdge L) := by
    change Nonempty (Fin (2 * L ^ 2) × Bool)
    exact ⟨(⟨0, by positivity⟩, false)⟩
  calc
    Matrix.det (gaugedTerminalMatrix L z s) =
        Matrix.det (qbarConst (z ^ 2) •
          ((polynomialDiagonalGaugeInverse L z s * terminalMatrix L z s) *
            polynomialDiagonalGauge L z s)) := rfl
    _ = Matrix.det (terminalMatrix L z s) :=
      NecSuf.KacWard.scaledConjugate_determinant_necSuf
        Matrix.det (fun c A => c • A) (Fintype.card (OrientedEdge L))
        qbarPolynomial_det_mul_from_necSuf qbarPolynomial_det_smul_from_necSuf
        (polynomialOrientedIdentity_determinant L)
        (polynomialDiagonalGaugeInverse L z s) (terminalMatrix L z s)
        (polynomialDiagonalGauge L z s) (qbarConst (z ^ 2))
        (polynomialDiagonalGauge_mul_inverse_from_necSuf L z hz s).2
        (gaugeScalar_pow_card_from_necSuf L z hz)
    _ = kacWardDeterminant (kacWardTransitionMatrix L z s) :=
      terminalMatrix_determinant_from_necSuf L z s

end Ising2DLambda.KacWard
