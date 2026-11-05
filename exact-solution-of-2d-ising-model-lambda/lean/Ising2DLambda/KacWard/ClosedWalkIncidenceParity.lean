import Ising2DLambda.KacWard.ClosedWalkPasses
import Ising2DLambda.NecSuf.KacWard.ClosedWalkIncidenceParity

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

/-- A closed walk has an even number of edge endpoints at each actual torus vertex. -/
theorem closedWalk_incidence_even {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (v : Vertex L) :
    (∑ k : Fin (m + 1),
        ((if orientedSource (γ k) = v then 1 else 0) +
          (if orientedTarget (γ k) = v then 1 else 0))) % 2 = 0 := by
  have hstep : ∀ k : Fin m,
      orientedTarget (γ (Fin.castSucc k)) = orientedSource (γ (Fin.succ k)) := by
    intro k
    have h := hγ.1 k
    simp only [nonbacktrackingSuccessors, Finset.mem_filter,
      Finset.mem_univ, true_and] at h
    exact h.1
  have hclose : orientedTarget (γ (Fin.last m)) = orientedSource (γ 0) := by
    have h := hγ.2
    simp only [nonbacktrackingSuccessors, Finset.mem_filter,
      Finset.mem_univ, true_and] at h
    exact h.1
  have hcounts :
      (∑ k : Fin (m + 1), if orientedTarget (γ k) = v then 1 else 0) =
        ∑ k : Fin (m + 1), if orientedSource (γ k) = v then 1 else 0 := by
    rw [Fin.sum_univ_castSucc, Fin.sum_univ_succ]
    simp_rw [hstep]
    rw [hclose]
    omega
  rw [Finset.sum_add_distrib, hcounts]
  omega

theorem closedWalk_incidence_even_from_necSuf {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (v : Vertex L) :
    (∑ k : Fin (m + 1),
        ((if orientedSource (γ k) = v then 1 else 0) +
          (if orientedTarget (γ k) = v then 1 else 0))) % 2 = 0 := by
  have hstep : ∀ k : Fin m,
      orientedTarget (γ (Fin.castSucc k)) = orientedSource (γ (Fin.succ k)) := by
    intro k
    exact (Finset.mem_filter.mp (hγ.1 k)).2.1
  have hclose : orientedTarget (γ (Fin.last m)) = orientedSource (γ 0) :=
    (Finset.mem_filter.mp hγ.2).2.1
  exact Ising2DLambda.NecSuf.KacWard.closedWalk_incidence_even
    γ orientedSource orientedTarget hstep hclose v

end Ising2DLambda.KacWard
