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

/-- Every inspected edge has connected endpoints after the whole scan. -/
theorem forestEdgeScan_inspected_reachable {n : ℕ} (G : FiniteSimpleGraph n)
    (pairs : List (Fin n × Fin n)) (uv : Fin n × Fin n)
    (hmem : uv ∈ pairs) (hadj : G.Adj uv.1 uv.2) :
    (forestEdgeScan G pairs).Reachable uv.1 uv.2 := by
  classical
  have hstep_le (F : FiniteSimpleGraph n) (ab : Fin n × Fin n) :
      F ≤ forestEdgeScanStep G F ab := by
    unfold forestEdgeScanStep
    split_ifs <;> simp
  have hstep_reachable (F : FiniteSimpleGraph n) (ab : Fin n × Fin n)
      (h : G.Adj ab.1 ab.2) :
      (forestEdgeScanStep G F ab).Reachable ab.1 ab.2 := by
    unfold forestEdgeScanStep
    split_ifs with hc
    · have ha : (F ⊔ edge ab.1 ab.2).Adj ab.1 ab.2 := by
        have he : (edge ab.1 ab.2).Adj ab.1 ab.2 := by
          exact (edge_adj _ _ _ _).2 ⟨Or.inl ⟨rfl, rfl⟩, G.ne_of_adj h⟩
        exact (show edge ab.1 ab.2 ≤ F ⊔ edge ab.1 ab.2 from le_sup_right) he
      exact ha.reachable
    · have hr : F.Reachable ab.1 ab.2 := by tauto
      exact hr
  induction pairs using List.reverseRecOn with
  | nil => simp at hmem
  | append_singleton prior ab ih =>
      rw [List.mem_append] at hmem
      rcases hmem with hprior | hlast
      · have hr := ih hprior
        have hr' := Reachable.mono (hstep_le (forestEdgeScan G prior) ab) hr
        simpa [forestEdgeScan, List.foldl_append] using hr'
      · simp at hlast
        subst ab
        simpa [forestEdgeScan, List.foldl_append] using
          hstep_reachable (forestEdgeScan G prior) uv hadj

/-- If every graph edge is inspected, the scan connects its two endpoints. -/
theorem forestEdgeScan_allEdges_reachable {n : ℕ} (G : FiniteSimpleGraph n)
    (pairs : List (Fin n × Fin n))
    (hcover : ∀ u v, G.Adj u v → (u, v) ∈ pairs)
    {u v : Fin n} (hadj : G.Adj u v) :
    (forestEdgeScan G pairs).Reachable u v :=
  forestEdgeScan_inspected_reachable G pairs (u, v) (hcover u v hadj) hadj

end Ising2DLambda.Tools
