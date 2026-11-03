import Ising2DLambda.KacWard.FirstHitConnectingStaircase
import Ising2DLambda.NecSuf.KacWard.PeriodicLiftClosureFromWalk

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

/-- 最初の当たりを与える、移動後の周期持ち上げの添字。 -/
noncomputable def firstHitLiftIndexFromWalk {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L) (k0 : ℤ) (u : ℕ)
    (hnonempty : (firstHitStepSetFromWalk γ k0 u).Nonempty) : ℤ := by
  classical
  have hmem := Finset.min'_mem (firstHitStepSetFromWalk γ k0 u) hnonempty
  have hh : ∃ k : ℤ,
      iteratedTransverseStaircase (horizontalDirectedWindingNumber γ)
        (verticalDirectedWindingNumber γ) (periodicPlaneLiftFromWalk γ k0)
        (firstHitStepFromWalk γ k0 u hnonempty) =
      transverseTranslatedPeriodicPlaneLiftFromWalk γ (u : ℤ) k :=
    (Finset.mem_filter.mp hmem).2
  exact Classical.choose hh

/-- `def_periodic_lift_closure_cycle`。実際の閉歩道の持ち上げと接続階段を四部分に並べる。 -/
noncomputable def periodicLiftClosureFromWalk {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L) (k0 : ℤ) (u c : ℕ)
    (hnonempty : (firstHitStepSetFromWalk γ k0 u).Nonempty) :
    Fin (2 * firstHitStepFromWalk γ k0 u hnonempty + 2 * (c * (m + 1)) + 1) →
      ℤ × ℤ := by
  let h := firstHitStepFromWalk γ k0 u hnonempty
  let p := c * (m + 1)
  let k1 := firstHitLiftIndexFromWalk γ k0 u hnonempty
  let B := windingShift L (verticalDirectedWindingNumber γ)
    (horizontalDirectedWindingNumber γ)
  exact fourPartClosure h p
    (fun j => iteratedTransverseStaircase (horizontalDirectedWindingNumber γ)
      (verticalDirectedWindingNumber γ) (periodicPlaneLiftFromWalk γ k0) j)
    (fun j => transverseTranslatedPeriodicPlaneLiftFromWalk γ (u : ℤ) (k1 + j))
    (fun j => iteratedTransverseStaircase (horizontalDirectedWindingNumber γ)
      (verticalDirectedWindingNumber γ) (periodicPlaneLiftFromWalk γ k0)
      (h - j) + c • B)
    (fun j => periodicPlaneLiftFromWalk γ (k0 + (p - j)))

end Ising2DLambda.KacWard
