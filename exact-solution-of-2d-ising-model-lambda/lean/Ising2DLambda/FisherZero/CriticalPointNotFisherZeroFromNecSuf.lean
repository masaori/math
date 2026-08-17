/- 具体版が必要十分版の特殊化であることの導出。住処: Qbar。 -/
import Ising2DLambda.FisherZero.CriticalPointNotFisherZero
import Ising2DLambda.NecSuf.FisherZero.CriticalPointNotFisherZero

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue Ising2DLambda.PartitionPolynomial

theorem criticalPoint_not_mem_fisherZero_from_necSuf (L : ℕ) [NeZero L] (s : Qbar)
    (hs : s * s = algebraMap ℚ Qbar 2) :
    (criticalPoint s : Qbar) ∉ FisherZeroSet L := by
  obtain ⟨xi, hcoe, hpos⟩ := criticalPartitionValue_mem_positiveCone L s hs
  refine Ising2DLambda.NecSuf.FisherZero.represented_positive_value_not_mem_zeroSet_necSuf
    (fun y : QuadraticFieldElement s => (y : Qbar)) (0 : Qbar)
    (quadraticRepresentation s) quadraticCoefficientPositive ((0 : ℚ), (0 : ℚ))
    ((criticalPoint s : Qbar)) xi
    (qbarPolynomialEval (criticalPoint s : Qbar) (partitionPolynomial L))
    (FisherZeroSet L)
    hcoe.symm hpos ?_ ?_ ?_
  · exact fun h => (quadraticRepresentation_eq_zero_iff s hs xi).1 h
  · intro hzero
    rcases hzero with ⟨-, -, hne⟩ | ⟨ha, -, -⟩ | ⟨ha, -, -⟩
    · exact hne rfl
    · exact lt_irrefl 0 ha
    · exact lt_irrefl 0 ha
  · exact fun h => (mem_fisherZero).1 h

end Ising2DLambda.FisherZero
