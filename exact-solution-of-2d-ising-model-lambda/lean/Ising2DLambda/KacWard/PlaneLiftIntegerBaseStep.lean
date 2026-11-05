import Ising2DLambda.KacWard.PlaneLift

namespace Ising2DLambda.KacWard

/-- 実際の辺列から得た整数添字の一周期分は、各辺の変位で進む。 -/
theorem planeLiftIntegerBase_step {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L) (j : ℕ) (hj : j < m + 1) :
    planeLiftIntegerBase γ ((j : ℤ) + 1) =
      planeLiftIntegerBase γ j + orientedEdgeLatticeStep (γ ⟨j, hj⟩) := by
  have hfin : Fin.ofNat (m + 2) j = (⟨j, hj⟩ : Fin (m + 1)).castSucc := by
    apply Fin.ext
    simp [Fin.ofNat, Nat.mod_eq_of_lt (by omega : j < m + 2)]
  have hnext : Fin.ofNat (m + 2) (j + 1) = (⟨j, hj⟩ : Fin (m + 1)).succ := by
    apply Fin.ext
    simp [Fin.ofNat, Nat.mod_eq_of_lt (by omega : j + 1 < m + 2)]
  change planeLift γ (Fin.ofNat (m + 2) (j + 1)) =
    planeLift γ (Fin.ofNat (m + 2) j) + orientedEdgeLatticeStep (γ ⟨j, hj⟩)
  rw [hnext, hfin]
  exact planeLift_succ γ ⟨j, hj⟩

end Ising2DLambda.KacWard
