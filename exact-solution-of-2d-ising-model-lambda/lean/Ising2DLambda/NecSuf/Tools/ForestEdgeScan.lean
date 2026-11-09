import Ising2DLambda.NecSuf.Tools.ForestAddDisconnectedEdge

namespace Ising2DLambda.NecSuf.Tools

open SimpleGraph

/-- Only the finite list of inspected pairs is needed; the vertex type may be infinite. -/
noncomputable def forestEdgeScanStep {V : Type*} (G F : SimpleGraph V)
    (uv : V × V) : SimpleGraph V := by
  classical
  exact if G.Adj uv.1 uv.2 ∧ ¬ F.Reachable uv.1 uv.2 then
    F ⊔ edge uv.1 uv.2
  else F

noncomputable def forestEdgeScan {V : Type*} (G : SimpleGraph V)
    (pairs : List (V × V)) : SimpleGraph V :=
  pairs.foldl (forestEdgeScanStep G) ⊥

theorem forestEdgeScan_invariant {V : Type*} (G : SimpleGraph V)
    (pairs : List (V × V)) :
    (forestEdgeScan G pairs).IsAcyclic ∧ forestEdgeScan G pairs ≤ G := by
  classical
  unfold forestEdgeScan
  have hstep : ∀ (F : SimpleGraph V) (uv : V × V),
      F.IsAcyclic ∧ F ≤ G →
      (forestEdgeScanStep G F uv).IsAcyclic ∧ forestEdgeScanStep G F uv ≤ G := by
    intro F uv hF
    unfold forestEdgeScanStep
    split_ifs with h
    · exact forest_addDisconnectedEdge G F hF.2 hF.1 uv.1 uv.2 h.1 h.2
    · exact hF
  induction pairs using List.reverseRecOn with
  | nil => simp
  | append_singleton pairs uv ih =>
      rw [List.foldl_append, List.foldl_cons, List.foldl_nil]
      exact hstep _ uv ih

end Ising2DLambda.NecSuf.Tools
