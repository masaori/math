import Ising2DLambda.KacWard.DeterminantSignedEvenSubgraphSquare
import Ising2DLambda.NecSuf.KacWard.DeterminantSignedEvenSubgraphSquare

/-!
具体版 `kacWardDeterminant_eq_signedEvenSubgraphPolynomial_sq`（`claim_determinant_signed_even_subgraph_square`）を、
必要十分版 `eq_sq_of_det_eq_of_pfaffian_sq_eq_det` を
行列の型 `Matrix (OrientedEdge L) (OrientedEdge L) Qbar[X]`・値の型 `Qbar[X]`・行列式 `Matrix.det`・
Pfaffian `qbarPolynomialPfaffian`・平方 `p ↦ p ^ 2`・行列 `K^as`・`D^{a,b}_L`・`Q^{a,b}_L` に特殊化して得る導出版。
-/

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue Ising2DLambda.PartitionPolynomial
open scoped Classical

variable {L : ℕ} [NeZero L]

theorem kacWardDeterminant_eq_signedEvenSubgraphPolynomial_sq_from_necSuf (z : Qbar)
    (hz : z ^ (4 : ℕ) = -1) (s : SpinStructure) :
    kacWardDeterminant (kacWardTransitionMatrix L z s) =
      ((signedEvenSubgraphPolynomial L (spinComponentFin s.1) (spinComponentFin s.2)).map
        (Int.castRingHom Qbar)) ^ 2 :=
  Ising2DLambda.NecSuf.KacWard.eq_sq_of_det_eq_of_pfaffian_sq_eq_det
    Matrix.det qbarPolynomialPfaffian (fun p => p ^ 2) (gaugedTerminalMatrix L z s)
    (kacWardDeterminant (kacWardTransitionMatrix L z s))
    ((signedEvenSubgraphPolynomial L (spinComponentFin s.1) (spinComponentFin s.2)).map
      (Int.castRingHom Qbar))
    (gaugedTerminalMatrix_determinant L z hz s)
    (qbarPolynomialPfaffian_sq_eq_det _ (gaugedTerminalMatrix_isZeroDiagonalSkew z hz s))
    (gaugedPfaffian_eq_signedEvenSubgraphPolynomial z hz s)

end Ising2DLambda.KacWard
