/-
実現できる双対像と自明セクターの一致を必要十分版から導く。
具体版が必要十分版の二つの包含仮定をどう埋めるかを独立に確認する。
-/
import Ising2DLambda.FisherZero.AttainableDualImageTrivialSector
import Ising2DLambda.FisherZero.TrivialSectorConfigurationReconstructionFromNecSuf
import Ising2DLambda.NecSuf.FisherZero.AttainableDualImageTrivialSector

namespace Ising2DLambda.FisherZero

open Finset Ising2DLambda.PartitionPolynomial

theorem attainableDualBrokenEdgeSets_eq_trivialSectorEdgeSets_from_necSuf
    (L : ℕ) [NeZero L] :
    attainableDualBrokenEdgeSets L = trivialSectorEdgeSets L := by
  classical
  rw [attainableDualBrokenEdgeSets, trivialSectorEdgeSets]
  apply Ising2DLambda.NecSuf.FisherZero.image_eq_admissible_filter_necSuf
  · intro B hB
    rw [attainableBrokenEdgeSets, mem_image] at hB
    obtain ⟨sigma, _, rfl⟩ := hB
    exact ⟨dualBrokenEdgeSet_isEven L sigma, dualBrokenEdgeSet_winding_zero L sigma⟩
  · intro A hSector
    -- 復元の導出版から原像数二を供給し、本文と同じく非空性を経て証人を取る。
    have hcard := trivialSectorConfiguration_fiber_card_two_constructed_from_necSuf L A hSector
    have hne : (univ.filter fun sigma : Config L => dualBrokenEdgeSet L sigma = A).Nonempty :=
      card_ne_zero.mp (by omega)
    obtain ⟨sigma, hsigma⟩ := hne
    simp only [mem_filter, mem_univ, true_and] at hsigma
    refine ⟨brokenEdgeSet L sigma, ?_, ?_⟩
    · exact mem_image_of_mem (brokenEdgeSet L) (mem_univ sigma)
    · calc
        (brokenEdgeSet L sigma).image (dualEdgeEquiv L)
            = dualBrokenEdgeSet L sigma := rfl
        _ = A := hsigma

end Ising2DLambda.FisherZero
