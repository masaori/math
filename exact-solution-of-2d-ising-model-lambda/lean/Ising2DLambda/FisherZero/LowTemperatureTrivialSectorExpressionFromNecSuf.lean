/- 具体版が必要十分版の特殊化であることの導出。住処: Z。 -/
import Ising2DLambda.FisherZero.LowTemperatureTrivialSectorExpression

namespace Ising2DLambda.FisherZero

open Finset Ising2DLambda.PartitionPolynomial

theorem partitionPolynomial_eq_two_mul_trivialSectorGeneratingPolynomial_from_necSuf
    (L : ℕ) [NeZero L] :
    partitionPolynomial L = 2 * sectorGeneratingPolynomial L (0, 0) := by
  classical
  have hsum :
      lowTemperaturePolynomial L = sectorGeneratingPolynomial L (0, 0) := by
    rw [lowTemperaturePolynomial, sectorGeneratingPolynomial]
    apply Ising2DLambda.NecSuf.FisherZero.weighted_sum_eq_of_inverse_necSuf
      (attainableBrokenEdgeSets L) (trivialSectorEdgeSets L)
      (fun B => B.image (dualEdgeEquiv L))
      (fun A => A.image (dualEdgeEquiv L).symm)
      (sourceWeight := fun B => (Polynomial.X : Polynomial ℤ) ^ B.card)
      (targetWeight := fun A => (Polynomial.X : Polynomial ℤ) ^ A.card)
    · intro B hB
      rw [← attainableDualBrokenEdgeSets_eq_trivialSectorEdgeSets L]
      exact mem_image_of_mem _ hB
    · intro A hA
      rw [← attainableDualBrokenEdgeSets_eq_trivialSectorEdgeSets L] at hA
      rw [attainableDualBrokenEdgeSets, mem_image] at hA
      obtain ⟨B, hB, hBA⟩ := hA
      rw [← hBA]
      have hround :
          (B.image (dualEdgeEquiv L)).image (dualEdgeEquiv L).symm = B := by
        ext e
        simp
      rw [hround]
      exact hB
    · intro B _
      ext e
      simp
    · intro A _
      ext e
      simp
    · intro B _
      rw [card_image_dualEdgeEquiv]
  rw [partitionPolynomial_eq_two_mul_lowTemperaturePolynomial L, hsum]

end Ising2DLambda.FisherZero
