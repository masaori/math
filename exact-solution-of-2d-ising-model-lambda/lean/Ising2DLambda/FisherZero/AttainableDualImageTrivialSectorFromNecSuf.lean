/-
実現できる双対像と自明セクターの一致を必要十分版から導く。
具体版が必要十分版の二つの包含仮定をどう埋めるかを独立に確認する。
-/
import Ising2DLambda.FisherZero.AttainableDualImageTrivialSector

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
    refine ⟨brokenEdgeSet L (reconstructedConfiguration L A), ?_, ?_⟩
    · exact mem_image_of_mem (brokenEdgeSet L) (mem_univ _)
    · exact reconstructedConfiguration_dualBrokenEdgeSet L A hSector

end Ising2DLambda.FisherZero
