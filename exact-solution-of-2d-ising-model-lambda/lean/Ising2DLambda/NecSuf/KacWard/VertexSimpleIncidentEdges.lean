import Ising2DLambda.NecSuf.KacWard.ClosedWalkIncidenceParity

namespace Ising2DLambda.NecSuf.KacWard

/-- At a vertex visited once, the incoming and outgoing incidences are the only two. -/
theorem vertexSimple_incident_edges {m : ℕ} {E V : Type*}
    [DecidableEq V] (γ : Fin (m + 1) → E) (source target : E → V)
    (hstep : ∀ k : Fin m, target (γ k.castSucc) = source (γ k.succ))
    (hclose : target (γ (Fin.last m)) = source (γ 0))
    (hinj : Function.Injective (target ∘ γ)) (k : Fin (m + 1)) :
    (∑ j : Fin (m + 1),
      ((if source (γ j) = target (γ k) then 1 else 0) +
        (if target (γ j) = target (γ k) then 1 else 0))) = 2 := by
  classical
  have hcounts :
      (∑ j : Fin (m + 1), if source (γ j) = target (γ k) then 1 else 0) =
        ∑ j : Fin (m + 1), if target (γ j) = target (γ k) then 1 else 0 := by
    exact (closedWalk_source_target_count γ source target hstep hclose (target (γ k))).symm
  have htarget :
      (∑ j : Fin (m + 1), if target (γ j) = target (γ k) then 1 else 0) = 1 := by
    have heq (j : Fin (m + 1)) : target (γ j) = target (γ k) ↔ j = k :=
      hinj.eq_iff
    simp_rw [heq]
    simp
  rw [Finset.sum_add_distrib, hcounts, htarget]

end Ising2DLambda.NecSuf.KacWard
