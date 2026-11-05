import Ising2DLambda.KacWard.ContactPairCount
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

/-- The labelled edge traversals at a passage vertex have exactly two endpoint incidences. -/
theorem vertexSimple_incident_edges {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hcontact : contactPairCount γ hγ = 0) (k : Fin (m + 1)) :
    (∑ j : Fin (m + 1),
      ((if orientedSource (γ j) = orientedTarget (γ k) then 1 else 0) +
        (if orientedTarget (γ j) = orientedTarget (γ k) then 1 else 0))) = 2 := by
  have hstep : ∀ j : Fin m,
      orientedTarget (γ j.castSucc) = orientedSource (γ j.succ) := by
    intro j
    exact (Finset.mem_filter.mp (hγ.1 j)).2.1
  have hclose : orientedTarget (γ (Fin.last m)) = orientedSource (γ 0) :=
    (Finset.mem_filter.mp hγ.2).2.1
  have hinj := (contactPairCount_eq_zero_iff_pass_vertices_injective γ hγ).mp hcontact
  classical
  have hcounts :
      (∑ j : Fin (m + 1),
        if orientedSource (γ j) = orientedTarget (γ k) then 1 else 0) =
      ∑ j : Fin (m + 1),
        if orientedTarget (γ j) = orientedTarget (γ k) then 1 else 0 := by
    rw [Fin.sum_univ_succ, Fin.sum_univ_castSucc]
    simp_rw [← hstep]
    rw [← hclose]
    omega
  have htarget :
      (∑ j : Fin (m + 1),
        if orientedTarget (γ j) = orientedTarget (γ k) then 1 else 0) = 1 := by
    have heq (j : Fin (m + 1)) :
        orientedTarget (γ j) = orientedTarget (γ k) ↔ j = k := hinj.eq_iff
    simp_rw [heq]
    simp
  rw [Finset.sum_add_distrib, hcounts, htarget]

end Ising2DLambda.KacWard
