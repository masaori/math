/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.ContactSplitTurningUpdate
import Ising2DLambda.NecSuf.KacWard.ContactSplitTurningUpdate

namespace Ising2DLambda.KacWard

/-- 具体版が必要十分版の特殊化として得られることの記録。 -/
theorem contact_split_turning_update_from_necSuf {E : Type} (τ : E → E → ℤ)
    (edge : ℕ → E) (m k l : ℕ) (σ ν : ℕ → ℕ)
    (hσ : ∀ r, σ r = if r = m then 1 else r + 1)
    (hνk : ν k = σ l) (hνl : ν l = σ k)
    (hother : ∀ r, r ≠ k → r ≠ l → ν r = σ r)
    (hk : 0 < k) (hkl : k < l) (hlm : l ≤ m) :
    ((∑ r ∈ Finset.Ioc k l, τ (edge r) (edge (if r = l then k + 1 else r + 1)))
      + ((∑ r ∈ Finset.Ioc l m, τ (edge r) (edge (if r = m then 1 else r + 1)))
        + ∑ r ∈ Finset.Ioc 0 k,
            τ (edge r) (edge (if r = k then (if l = m then 1 else l + 1) else r + 1))))
      - ∑ r ∈ Finset.Ioc 0 m, τ (edge r) (edge (σ r)) =
    (τ (edge k) (edge (σ l)) + τ (edge l) (edge (σ k)))
      - (τ (edge k) (edge (σ k)) + τ (edge l) (edge (σ l))) := by
  rw [smoothing_split_turning_sum τ edge m k l σ ν hσ hνk hνl hother hkl hlm]
  have hkMem : k ∈ Finset.Ioc 0 m := by
    rw [Finset.mem_Ioc]
    omega
  have hlMem : l ∈ Finset.Ioc 0 m := by
    rw [Finset.mem_Ioc]
    omega
  have hdiff := Ising2DLambda.NecSuf.KacWard.two_point_sum_difference_necSuf
    (fun r => τ (edge r) (edge (σ r))) (fun r => τ (edge r) (edge (ν r)))
    m k l hkMem hlMem (Nat.ne_of_lt hkl) (fun r _ hrk hrl => by rw [hother r hrk hrl])
  simpa only [hνk, hνl] using hdiff

end Ising2DLambda.KacWard
