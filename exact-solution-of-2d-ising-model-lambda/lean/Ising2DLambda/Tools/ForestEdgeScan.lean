import Ising2DLambda.Tools.ForestAddDisconnectedEdge

namespace Ising2DLambda.Tools

open SimpleGraph

/-- Inspect one ordered pair; add its edge exactly when it belongs to the graph and joins two components. -/
noncomputable def forestEdgeScanStep {n : ℕ} (G F : FiniteSimpleGraph n)
    (uv : Fin n × Fin n) : FiniteSimpleGraph n := by
  classical
  exact
  if G.Adj uv.1 uv.2 ∧ ¬ F.Reachable uv.1 uv.2 then
    F ⊔ edge uv.1 uv.2
  else F

/-- Inspect a finite list of ordered pairs, starting from the empty edge set. -/
noncomputable def forestEdgeScan {n : ℕ} (G : FiniteSimpleGraph n)
    (pairs : List (Fin n × Fin n)) : FiniteSimpleGraph n :=
  pairs.foldl (forestEdgeScanStep G) ⊥

/-- Every finite prefix of the edge scan remains an acyclic subgraph. -/
theorem forestEdgeScan_invariant {n : ℕ} (G : FiniteSimpleGraph n)
    (pairs : List (Fin n × Fin n)) :
    (forestEdgeScan G pairs).IsAcyclic ∧ forestEdgeScan G pairs ≤ G := by
  classical
  unfold forestEdgeScan
  have hstep : ∀ (F : FiniteSimpleGraph n) (uv : Fin n × Fin n),
      F.IsAcyclic ∧ F ≤ G →
      (forestEdgeScanStep G F uv).IsAcyclic ∧ forestEdgeScanStep G F uv ≤ G := by
    intro F uv hF
    unfold forestEdgeScanStep
    split_ifs with h
    · exact forest_addDisconnectedEdge n G F hF.2 hF.1 uv.1 uv.2 h.1 h.2
    · exact hF
  induction pairs using List.reverseRecOn with
  | nil => simp
  | append_singleton pairs uv ih =>
      rw [List.foldl_append, List.foldl_cons, List.foldl_nil]
      exact hstep _ uv ih

end Ising2DLambda.Tools
