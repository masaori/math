/-
「実現できる破れた辺集合の双対像は自明セクターの全体である」の具体版。
人手証明と同じく、双対破れ像の偶性・巻き付き零性と、自明セクターからの配位復元を
二つの包含へそれぞれ用いる。住処は有限集合と N であり、R / C は現れない。
-/
import Ising2DLambda.FisherZero.TrivialSectorConfigurationReconstruction
import Ising2DLambda.NecSuf.FisherZero.AttainableDualImageTrivialSector

namespace Ising2DLambda.FisherZero

open Finset Ising2DLambda.PartitionPolynomial

/-- 実現できる破れた辺集合を双対辺写像で送った像の全体。 -/
noncomputable def attainableDualBrokenEdgeSets (L : ℕ) [NeZero L] :
    Finset (Finset (Edge L)) :=
  (attainableBrokenEdgeSets L).image fun B => B.image (dualEdgeEquiv L)

/-- 自明セクターに属する偶部分グラフの全体。 -/
noncomputable def trivialSectorEdgeSets (L : ℕ) [NeZero L] :
    Finset (Finset (Edge L)) := by
  classical
  exact univ.filter fun A => IsInTorusHomologySector L A (0, 0)

/-- `claim_attainable_dual_image_trivial_sector` の具体版。 -/
theorem attainableDualBrokenEdgeSets_eq_trivialSectorEdgeSets
    (L : ℕ) [NeZero L] :
    attainableDualBrokenEdgeSets L = trivialSectorEdgeSets L := by
  classical
  rw [attainableDualBrokenEdgeSets, trivialSectorEdgeSets]
  apply Ising2DLambda.NecSuf.FisherZero.image_eq_admissible_filter_necSuf
  · intro B hB
    rw [attainableBrokenEdgeSets, mem_image] at hB
    obtain ⟨sigma, _, rfl⟩ := hB
    change IsInTorusHomologySector L (dualBrokenEdgeSet L sigma) (0, 0)
    exact ⟨dualBrokenEdgeSet_isEven L sigma, dualBrokenEdgeSet_winding_zero L sigma⟩
  · intro A hSector
    have hcard := trivialSectorConfiguration_fiber_card_two L A hSector
    have hne : (univ.filter fun sigma : Config L => dualBrokenEdgeSet L sigma = A).Nonempty :=
      card_ne_zero.mp (by omega)
    obtain ⟨sigma, hsigma⟩ := hne
    simp only [mem_filter, mem_univ, true_and] at hsigma
    refine ⟨brokenEdgeSet L sigma, ?_, ?_⟩
    · exact mem_image_of_mem (brokenEdgeSet L) (mem_univ sigma)
    · simpa only [dualBrokenEdgeSet] using hsigma

end Ising2DLambda.FisherZero
