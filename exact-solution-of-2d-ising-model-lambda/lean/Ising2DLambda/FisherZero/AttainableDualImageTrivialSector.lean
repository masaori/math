/-
「実現できる破れた辺集合の双対像は自明セクターの全体である」の具体版。
人手証明と同じく、双対破れ像の偶性・巻き付き零性と、自明セクターからの配位復元を
二つの包含へそれぞれ用いる。住処は有限集合と N であり、R / C は現れない。
-/
import Ising2DLambda.FisherZero.TrivialSectorConfigurationReconstruction

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
  ext A
  simp only [mem_image, mem_filter, mem_univ, true_and]
  constructor
  · rintro ⟨B, hB, hBA⟩
    -- 順方向: 実現配位を取り出し、本文の二等号でその双対像へ移す。
    rw [attainableBrokenEdgeSets, mem_image] at hB
    obtain ⟨sigma, _, hsigma⟩ := hB
    have hEven := dualBrokenEdgeSet_isEven L sigma
    have hWinding := dualBrokenEdgeSet_winding_zero L sigma
    have hDual : B.image (dualEdgeEquiv L) = dualBrokenEdgeSet L sigma := by
      calc
        B.image (dualEdgeEquiv L)
            = (brokenEdgeSet L sigma).image (dualEdgeEquiv L) := by rw [hsigma]
        _ = dualBrokenEdgeSet L sigma := rfl
    -- 偶性と二つの巻き付き偶奇をセクターの定義へ代入する。
    rw [← hBA, hDual]
    exact ⟨hEven, hWinding⟩
  · intro hSector
    -- 逆方向: 原像数二から非空性を出し、配位を一つ取り出す。
    have hcard := trivialSectorConfiguration_fiber_card_two L A hSector
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
