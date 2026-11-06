import Ising2DLambda.KacWard.OneSidedClosureProjectedLiftFromWalk
import Ising2DLambda.KacWard.ClosedWalkPlaneDisplacement

namespace Ising2DLambda.KacWard

/-- 閉じた単位格子路を射影した実際の辺列の巻き付きは零である。 -/
theorem projectedClosedUnitPath_winding_zero (L m : ℕ) [NeZero L]
    (W : ℕ → ℤ × ℤ)
    (hclosed : W (m + 1) = W 0)
    (hunit : ∀ j < m + 1, W (j + 1) - W j = (0, 1) ∨
      W (j + 1) - W j = (1, 0) ∨ W (j + 1) - W j = (0, -1) ∨
      W (j + 1) - W j = (-1, 0))
    (hwalk : closedNonbacktrackingWalk
      (fun j : Fin (m + 1) =>
        projectedUnitStep L (W j.val) (W (j.val + 1) - W j.val))) :
    let Γ : Fin (m + 1) → OrientedEdge L := fun j =>
      projectedUnitStep L (W j.val) (W (j.val + 1) - W j.val)
    verticalDirectedWindingNumber Γ = 0 ∧
      horizontalDirectedWindingNumber Γ = 0 := by
  dsimp only
  let Γ : Fin (m + 1) → OrientedEdge L := fun j =>
    projectedUnitStep L (W j.val) (W (j.val + 1) - W j.val)
  have hdisplacement := closedWalk_planeDisplacement Γ hwalk
  have hsum : (∑ j : Fin (m + 1), orientedEdgeLatticeStep (Γ j)) =
      W (m + 1) - W 0 := by
    calc
      _ = ∑ j : Fin (m + 1), (W (j.val + 1) - W j.val) := by
        apply Finset.sum_congr rfl
        intro j _
        exact projectedUnitStep_displacement L (W j.val)
          (W (j.val + 1) - W j.val) (hunit j.val j.isLt)
      _ = ∑ j ∈ Finset.range (m + 1), (W (j + 1) - W j) := by
        exact Fin.sum_univ_eq_sum_range (fun j : ℕ => W (j + 1) - W j) (m + 1)
      _ = W (m + 1) - W 0 := by
        exact Finset.sum_range_sub W (m + 1)
  have hzero : (∑ j : Fin (m + 1), orientedEdgeLatticeStep (Γ j)) = 0 := by
    rw [hsum, hclosed]
    simp
  have hrow : (L : ℤ) * verticalDirectedWindingNumber Γ = 0 := by
    rw [← hdisplacement.1]
    calc
      _ = (∑ j : Fin (m + 1), orientedEdgeLatticeStep (Γ j)).1 := by
        rw [Prod.fst_sum]
      _ = 0 := congrArg Prod.fst hzero
  have hcol : (L : ℤ) * horizontalDirectedWindingNumber Γ = 0 := by
    rw [← hdisplacement.2]
    calc
      _ = (∑ j : Fin (m + 1), orientedEdgeLatticeStep (Γ j)).2 := by
        rw [Prod.snd_sum]
      _ = 0 := congrArg Prod.snd hzero
  constructor
  · exact (mul_eq_zero.mp hrow).resolve_left (by exact_mod_cast (NeZero.ne L))
  · exact (mul_eq_zero.mp hcol).resolve_left (by exact_mod_cast (NeZero.ne L))

end Ising2DLambda.KacWard
