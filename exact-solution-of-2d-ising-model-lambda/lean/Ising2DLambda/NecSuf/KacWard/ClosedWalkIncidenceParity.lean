import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

/-- A closed finite edge sequence contributes equally many sources and targets at each vertex. -/
theorem closedWalk_source_target_count {E V : Type*} [DecidableEq V]
    {m : ℕ} (γ : Fin (m + 1) → E) (source target : E → V)
    (hstep : ∀ k : Fin m, target (γ (Fin.castSucc k)) = source (γ (Fin.succ k)))
    (hclose : target (γ (Fin.last m)) = source (γ 0)) (v : V) :
    (∑ k : Fin (m + 1), if target (γ k) = v then 1 else 0) =
      ∑ k : Fin (m + 1), if source (γ k) = v then 1 else 0 := by
  rw [Fin.sum_univ_castSucc, Fin.sum_univ_succ]
  simp_rw [hstep]
  rw [hclose]
  omega

theorem closedWalk_incidence_even {E V : Type*} [DecidableEq V]
    {m : ℕ} (γ : Fin (m + 1) → E) (source target : E → V)
    (hstep : ∀ k : Fin m, target (γ (Fin.castSucc k)) = source (γ (Fin.succ k)))
    (hclose : target (γ (Fin.last m)) = source (γ 0)) (v : V) :
    (∑ k : Fin (m + 1),
        ((if source (γ k) = v then 1 else 0) +
          (if target (γ k) = v then 1 else 0))) % 2 = 0 := by
  rw [Finset.sum_add_distrib, closedWalk_source_target_count γ source target hstep hclose v]
  omega

end Ising2DLambda.NecSuf.KacWard
