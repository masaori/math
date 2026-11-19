import Ising2DLambda.FisherZero.SubfieldWeightedSquareSumExcludesMinusOne
import Ising2DLambda.NecSuf.FisherZero.SubfieldWeightedSquareSumExcludesMinusOne

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 基礎体の正錐の条件を一般の錐の条件へ代入する。 -/
theorem subfieldWeightedSquareSum_ne_neg_one_from_necSuf
    (F : Subfield Qbar) (CF : Set Qbar) (hCF : IsSubfieldPositiveCone F CF) :
    (-1 : Qbar) ∉ positiveWeightedSquareSums F CF := by
  have hzero : (0 : Qbar) ∉ CF := by
    intro h
    exact (hCF.trichotomy 0 F.zero_mem).2.1 ⟨rfl, h⟩
  have hone : (1 : Qbar) ∈ CF := one_mem_of_isSubfieldPositiveCone F CF hCF
  have hminus : (-1 : Qbar) ∉ CF := by
    intro h
    have hsum := hCF.add_mem 1 (-1) hone h
    have : (1 : Qbar) + -1 = 0 := by ring
    exact hzero (this ▸ hsum)
  have htrich : ∀ y : Qbar, y ∈ F → y = 0 ∨ y ∈ CF ∨ -y ∈ CF :=
    fun y hy => (hCF.trichotomy y hy).1
  intro hrep
  obtain ⟨ι, hι, c, y, hc, hy, hsum⟩ := hrep
  have hgeneric : (-1 : Qbar) ∈
      Ising2DLambda.NecSuf.FisherZero.weightedSquareSums (F : Set Qbar) CF := by
    exact ⟨ι, hι, c, y, hc, hy, hsum⟩
  exact (Ising2DLambda.NecSuf.FisherZero.weightedSquareSums_ne_neg_one
    (F : Set Qbar) CF hminus hCF.add_mem hCF.mul_mem htrich) hgeneric

end Ising2DLambda.FisherZero
