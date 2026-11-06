import Ising2DLambda.KacWard.HeightOneBoundarySupport
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial Ising2DLambda.TransferMatrix

/-- The local interior and seam calculations cover every base edge, including side length one. -/
theorem heightOneBoundary_all_edges (L m : ℕ) [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L) (hγ : closedNonbacktrackingWalk γ)
    (hh : (∑ k : Fin (m + 1), horizontalSeamParity (γ k)) % 2 = 0)
    (hv : (∑ k : Fin (m + 1), verticalSeamParity (γ k)) % 2 = 0)
    (edge : Edge L) :
    cellSetEdgeCoefficient L (heightOneCells L m γ) edge ≠ 0 ↔
      walkBaseEdgeParity γ edge = 1 := by
  obtain ⟨w, rfl⟩ := (edgeEquiv L).surjective edge
  cases w with
  | inl p =>
    rcases p with ⟨i, j⟩
    by_cases hsingle : L = 1
    · subst L
      have hi : i = 0 := Subsingleton.elim _ _
      have hj : j = 0 := Subsingleton.elim _ _
      subst i; subst j
      simpa using heightOneBoundary_horizontal_seam_parity_singleCell m γ hh
    · by_cases hzero : i.val = 0
      · have hi : i = 0 := by
          apply ZMod.val_injective
          simpa using hzero
        subst i
        have hj : j.val < L := ZMod.val_lt j
        have hL : 2 ≤ L := by
          have := Nat.pos_of_ne_zero (NeZero.ne L)
          omega
        simpa [ZMod.natCast_zmod_val] using
          heightOneBoundary_horizontal_seam_parity L m γ hγ hh j.val hL hj
      · have hi : i.val - 1 + 1 < L := by
          have := ZMod.val_lt i
          omega
        have hj : j.val < L := ZMod.val_lt j
        have heq : ((i.val - 1 + 1 : ℕ) : ZMod L) = i := by
          have hpos : 0 < i.val := by omega
          simpa [Nat.sub_add_cancel (Nat.one_le_iff_ne_zero.mpr hzero)] using
            (ZMod.natCast_zmod_val i).symm
        simpa [heq, ZMod.natCast_zmod_val] using
          heightOneBoundary_horizontal_internal_parity L m γ (i.val - 1) j.val hi hj
  | inr p =>
    rcases p with ⟨i, j⟩
    by_cases hsingle : L = 1
    · subst L
      have hi : i = 0 := Subsingleton.elim _ _
      have hj : j = 0 := Subsingleton.elim _ _
      subst i; subst j
      simpa using heightOneBoundary_vertical_seam_parity_singleCell m γ hv
    · by_cases hzero : j.val = 0
      · have hj : j = 0 := by
          apply ZMod.val_injective
          simpa using hzero
        subst j
        have hi : i.val < L := ZMod.val_lt i
        have hL : 2 ≤ L := by
          have := Nat.pos_of_ne_zero (NeZero.ne L)
          omega
        simpa [ZMod.natCast_zmod_val] using
          heightOneBoundary_vertical_seam_parity L m γ hγ hv i.val hL hi
      · have hj : j.val - 1 + 1 < L := by
          have := ZMod.val_lt j
          omega
        have hi : i.val < L := ZMod.val_lt i
        have heq : ((j.val - 1 + 1 : ℕ) : ZMod L) = j := by
          have hpos : 0 < j.val := by omega
          simpa [Nat.sub_add_cancel (Nat.one_le_iff_ne_zero.mpr hzero)] using
            (ZMod.natCast_zmod_val j).symm
        simpa [heq, ZMod.natCast_zmod_val] using
          heightOneBoundary_vertical_internal_parity L m γ hγ i.val (j.val - 1) hi hj

end Ising2DLambda.KacWard
