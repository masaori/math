/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.MovedOrbitClosedWalk
import Ising2DLambda.NecSuf.KacWard.MovedOrbitClosedWalk

namespace Ising2DLambda.KacWard

variable {E : Type} [Fintype E] [DecidableEq E]

/-- 導出版: 同じ主張を必要十分版の三定理から得る。 -/
theorem movedOrbit_closed_nonbacktracking_from_necSuf (σ : Equiv.Perm E)
    (Next : E → E → Prop) (hyp : ∀ f, σ f ≠ f → Next f (σ f))
    (e : E) (he : σ e ≠ e) :
    (∀ k, σ ((⇑σ)^[k] e) ≠ (⇑σ)^[k] e) ∧
    (∀ k, Next ((⇑σ)^[k] e) ((⇑σ)^[k + 1] e)) ∧
    Next ((⇑σ)^[minimalReturnTime σ e - 1] e) e ∧
    (∀ j l, j < l → l < minimalReturnTime σ e → (⇑σ)^[j] e ≠ (⇑σ)^[l] e) := by
  refine ⟨Ising2DLambda.NecSuf.KacWard.moved_iterate_ne σ.injective he,
    Ising2DLambda.NecSuf.KacWard.orbit_relation_chain σ.injective hyp he, ?_,
    Ising2DLambda.NecSuf.KacWard.orbit_iterates_distinct σ.injective
      (minimalReturnTime_min σ e)⟩
  have h := Ising2DLambda.NecSuf.KacWard.orbit_relation_chain σ.injective hyp he
    (minimalReturnTime σ e - 1)
  have hr : minimalReturnTime σ e - 1 + 1 = minimalReturnTime σ e := by
    have := minimalReturnTime_pos σ e
    omega
  rw [hr, minimalReturnTime_return σ e] at h
  exact h

end Ising2DLambda.KacWard
