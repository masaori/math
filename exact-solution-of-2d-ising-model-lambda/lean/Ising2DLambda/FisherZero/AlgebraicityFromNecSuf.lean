/- 具体版が必要十分版の特殊化であることの導出。住処: Qbar。 -/
import Ising2DLambda.FisherZero.Algebraicity
import Ising2DLambda.NecSuf.FisherZero.Algebraicity

namespace Ising2DLambda.FisherZero

open Ising2DLambda PartitionPolynomial AlgebraicEigenvalue

theorem fisherZero_algebraicity_from_necSuf
    (L : ℕ) [NeZero L] (xi : Qbar) (hxi : xi ∈ FisherZeroSet L) :
    ∃ f : Polynomial ℤ, f ≠ 0 ∧ qbarPolynomialEval xi f = 0 := by
  apply Ising2DLambda.NecSuf.FisherZero.nonzero_root_witness_necSuf
    qbarPolynomialEval xi (partitionPolynomial L)
    (Polynomial.aeval (1 : ℚ)) ((2 ^ L ^ 2 : ℕ) : ℚ)
  · exact map_zero _
  · exact Ising2DLambda.FreeEntropy.partitionPolynomial_eval_one L
  · exact ne_of_gt (by positivity)
  · exact (mem_fisherZero).1 hxi

end Ising2DLambda.FisherZero
