/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.OneSidedClosureNonbacktracking
import Ising2DLambda.NecSuf.KacWard.ClosedWalkPeriodicDirectionNonbacktracking

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

/-- 必要十分版を実際の閉歩道へ特殊化する。 -/
theorem closedWalk_periodic_direction_nonbacktracking_from_necSuf {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) :
    let γz : ZMod (m + 1) → OrientedEdge L :=
      fun j => γ ⟨j.val, ZMod.val_lt j⟩
    ∀ j : ZMod (m + 1),
      directionNumber (γz (j + 1)) ≠ directionNumber (γz j) + 2 := by
  have hstep (e f : OrientedEdge L) (hf : f ∈ nonbacktrackingSuccessors e) :
      directionNumber f ≠ directionNumber e + 2 := by
    intro hd
    have hs : orientedSource f = orientedTarget e := (Finset.mem_filter.mp hf).2.1.symm
    have hr : orientedSource (reversal e) = orientedTarget e := by
      rcases e with ⟨edge, false | true⟩ <;> rfl
    have heq : f = reversal e := sourceDirection_bijective.1
      (Prod.ext (hs.trans hr.symm) (hd.trans (directionNumber_reversal e).symm))
    exact (Finset.mem_filter.mp hf).2.2 heq
  exact finiteWord_periodic_direction_nonbacktracking γ directionNumber
    (fun k => hstep _ _ (hγ.1 k)) (hstep _ _ hγ.2)

end Ising2DLambda.KacWard
