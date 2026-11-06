import Ising2DLambda.KacWard.VertexSimpleBoundaryNonloopPropagation
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

private theorem closedWalkSuccessor_surjective {m : ℕ} :
    Function.Surjective (@closedWalkSuccessor m) := by
  intro k
  cases k using Fin.cases with
  | zero =>
      exact ⟨Fin.last m, by simp [closedWalkSuccessor]⟩
  | succ p =>
      exact ⟨p.castSucc, by simp [closedWalkSuccessor, Fin.succ]⟩

/-- A vertex-simple nonbacktracking walk of side length at least two uses each
underlying edge at most once. -/
theorem vertexSimple_base_injective {L m : ℕ} (hL : 2 ≤ L)
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hcontact : contactPairCount γ hγ = 0) :
    Function.Injective (fun k : Fin (m + 1) => (γ k).1) := by
  intro j k hbase
  have hinj : Function.Injective (orientedTarget ∘ γ) :=
    (contactPairCount_eq_zero_iff_pass_vertices_injective γ hγ).mp hcontact
  have hclass : γ k = γ j ∨ γ k = reversal (γ j) := by
    rcases hj : γ j with ⟨b, false | true⟩ <;>
      rcases hk : γ k with ⟨c, false | true⟩ <;>
      simp_all [reversal]
  rcases hclass with heq | hreverse
  · exact hinj (by simp [heq])
  · obtain ⟨p, hp⟩ := closedWalkSuccessor_surjective k
    have hconnect : orientedTarget (γ p) = orientedSource (γ k) := by
      rw [← hp]
      exact (Finset.mem_filter.mp (closedWalkPass_valid γ hγ p)).2.1
    have hjp : j = p := hinj (by
      change orientedTarget (γ j) = orientedTarget (γ p)
      rw [hconnect]
      simpa [hreverse, reversal, orientedSource, orientedTarget] using
        (show orientedTarget (γ j) = orientedSource (reversal (γ j)) by
          cases γ j with
          | mk b d => cases d <;> rfl))
    have hneq := closedWalk_nonloop_successor_distinct_base hL γ hγ p
    have hp' : closedWalkSuccessor j = k := by simpa [hjp] using hp
    have hcontra : (γ j).1 ≠ (γ k).1 := by
      have hneq' : (γ j).1 ≠ (γ (closedWalkSuccessor j)).1 := by
        simpa [hjp] using hneq
      simpa [hp'] using hneq'
    exact False.elim (hcontra hbase)

end Ising2DLambda.KacWard
