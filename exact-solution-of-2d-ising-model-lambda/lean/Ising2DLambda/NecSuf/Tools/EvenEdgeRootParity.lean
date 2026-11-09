import Ising2DLambda.NecSuf.Tools.EvenEdgeSymmDiff

namespace Ising2DLambda.NecSuf.Tools

/-- Each selected edge has even total incidence. This is the only edge property used. -/
theorem incidenceParity_root_of_other_even {E V : Type*}
    [Fintype E] [DecidableEq E] [Fintype V] [DecidableEq V]
    (incident : V → E → Prop) [DecidableRel incident]
    (A : Finset E) (root : V)
    (hedge : ∀ e ∈ A, (∑ v : V, if incident v e then (1 : ZMod 2) else 0) = 0)
    (hother : ∀ v ≠ root, incidenceParity incident A v = 0) :
    incidenceParity incident A root = 0 := by
  classical
  have htotal : (∑ v : V, incidenceParity incident A v) = 0 := by
    simp only [incidenceParity]
    rw [Finset.sum_comm]
    apply Finset.sum_eq_zero
    intro e _
    by_cases he : e ∈ A
    · simpa [he] using hedge e he
    · simp [he]
  rw [← Finset.add_sum_erase _ _ (Finset.mem_univ root)] at htotal
  have hrest : (∑ v ∈ Finset.univ.erase root, incidenceParity incident A v) = 0 := by
    apply Finset.sum_eq_zero
    intro v hv
    exact hother v (Finset.mem_erase.mp hv).1
  simpa [hrest] using htotal

end Ising2DLambda.NecSuf.Tools
