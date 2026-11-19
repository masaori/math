import Ising2DLambda.FisherZero.SquareRootAdjoinedWeightedSquareSumExcludesMinusOne
import Ising2DLambda.NecSuf.FisherZero.SquareRootAdjoinedWeightedSquareSumExcludesMinusOne

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 必要十分版を代数的数の部分体とその正錐へ代入する。 -/
theorem squareRootAdjoinedWeightedSquareSum_ne_neg_one_from_necSuf
    (F : Subfield Qbar) (CF : Set Qbar) (hCF : IsSubfieldPositiveCone F CF)
    (a b : Qbar) (ha : a ∈ CF) (hb : b * b = a) (hbF : b ∉ F) :
    (-1 : Qbar) ∉ positiveWeightedSquareSums
      (Subfield.closure ((F : Set Qbar) ∪ ({b} : Set Qbar))) CF := by
  have haF : a ∈ F := hCF.subset _ ha
  have hrep : ∀ y ∈ (Subfield.closure ((F : Set Qbar) ∪ ({b} : Set Qbar)) : Set Qbar),
      ∃ u v : Qbar, u ∈ F ∧ v ∈ F ∧ y = u + v * b := by
    intro y hy
    have h : y ∈ quadraticLinearValues F b := by
      rw [quadraticLinearValues_eq_adjoin F a b haF hb hbF]
      exact hy
    exact h
  have hbase : (-1 : Qbar) ∉
      Ising2DLambda.NecSuf.FisherZero.weightedSquareSums (F : Set Qbar) CF := by
    intro h
    obtain ⟨ι, hι, c, y, hc, hy, hsum⟩ := h
    exact (subfieldWeightedSquareSum_ne_neg_one F CF hCF)
      ⟨ι, hι, c, y, hc, hy, hsum⟩
  intro h
  obtain ⟨ι, hι, c, y, hc, hy, hsum⟩ := h
  have hgeneric : (-1 : Qbar) ∈
      Ising2DLambda.NecSuf.FisherZero.weightedSquareSums
        (Subfield.closure ((F : Set Qbar) ∪ ({b} : Set Qbar)) : Set Qbar) CF :=
    ⟨ι, hι, c, y, hc, hy, hsum⟩
  exact (Ising2DLambda.NecSuf.FisherZero.squareRootAdjoinedWeightedSquareSum_ne_neg_one
    F CF _ hCF.subset hCF.mul_mem hbase a b ha hb hbF hrep) hgeneric

end Ising2DLambda.FisherZero
