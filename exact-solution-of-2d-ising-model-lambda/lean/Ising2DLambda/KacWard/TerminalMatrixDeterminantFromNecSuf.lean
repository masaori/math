/- 必要十分版へ実際の整数反転行列、整数包含と定数埋め込み、その行列式一を渡す。 -/
import Ising2DLambda.KacWard.TerminalMatrixDeterminant
import Ising2DLambda.NecSuf.KacWard.TerminalMatrixDeterminant

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue Ising2DLambda.PartitionPolynomial

/-- 有向辺の反転行列を、実際の整数から定数多項式への写像で移した特殊化。 -/
theorem polynomialReversalMatrix_determinant_from_necSuf (L : ℕ) :
    Matrix.det (polynomialReversalMatrix L) = 1 := by
  exact NecSuf.KacWard.mappedMatrix_determinant_one_necSuf
    integerConstantPolynomialHom (reversalMatrix L) (reversalMatrix_determinant L)

/-- 任意の行列に関する必要十分版に、本文の Kac--Ward 行列を代入する。 -/
theorem terminalMatrix_determinant_from_necSuf (L : ℕ) (z : Qbar) (s : SpinStructure) :
    Matrix.det (terminalMatrix L z s) =
      kacWardDeterminant (kacWardTransitionMatrix L z s) := by
  exact NecSuf.KacWard.mappedMatrix_mul_determinant_necSuf
    integerConstantPolynomialHom (reversalMatrix L) (spinKacWardPolynomialMatrix L z s)
    (reversalMatrix_determinant L)

end Ising2DLambda.KacWard
