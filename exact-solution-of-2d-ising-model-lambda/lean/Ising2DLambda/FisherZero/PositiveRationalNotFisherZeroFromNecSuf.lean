/- 具体版が必要十分版の特殊化であることの導出。住処: Q と Qbar。 -/
import Ising2DLambda.FisherZero.PositiveRationalNotFisherZero
import Ising2DLambda.NecSuf.FisherZero.PositiveRationalNotFisherZero

namespace Ising2DLambda.FisherZero

open Ising2DLambda PartitionPolynomial AlgebraicEigenvalue

theorem positiveRational_not_mem_fisherZero_from_necSuf
    (L : ℕ) [NeZero L] {q : ℚ} (hq : 0 < q) :
    (q : Qbar) ∉ FisherZeroSet L := by
  apply Ising2DLambda.NecSuf.FisherZero.embedded_nonzero_value_not_mem_zeroSet_necSuf
    (fun r : ℚ => (r : Qbar)) (q : Qbar)
    (Polynomial.aeval q (partitionPolynomial L))
    (qbarPolynomialEval (q : Qbar) (partitionPolynomial L))
    (FisherZeroSet L)
  · exact qbarPolynomialEval_partitionPolynomial_eq_ratEval L q
  · exact ne_of_gt (Ising2DLambda.FreeEntropy.partitionPolynomial_eval_pos L hq)
  · norm_num
  · exact Rat.cast_injective
  · exact mem_fisherZero

end Ising2DLambda.FisherZero
