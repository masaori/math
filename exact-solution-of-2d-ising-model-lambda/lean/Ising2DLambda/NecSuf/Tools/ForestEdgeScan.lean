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

/-- Every inspected edge has connected endpoints after the whole scan. -/
theorem forestEdgeScan_inspected_reachable {V : Type*} (G : SimpleGraph V)
    (pairs : List (V × V)) (uv : V × V)
    (hmem : uv ∈ pairs) (hadj : G.Adj uv.1 uv.2) :
    (forestEdgeScan G pairs).Reachable uv.1 uv.2 := by
  classical
  have hstep_le (F : SimpleGraph V) (ab : V × V) :
      F ≤ forestEdgeScanStep G F ab := by
    unfold forestEdgeScanStep
    split_ifs <;> simp
  have hstep_reachable (F : SimpleGraph V) (ab : V × V)
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

theorem forestEdgeScan_allEdges_reachable {V : Type*} (G : SimpleGraph V)
    (pairs : List (V × V))
    (hcover : ∀ u v, G.Adj u v → (u, v) ∈ pairs)
    {u v : V} (hadj : G.Adj u v) :
    (forestEdgeScan G pairs).Reachable u v :=
  forestEdgeScan_inspected_reachable G pairs (u, v) (hcover u v hadj) hadj

/-- A covered finite edge list suffices; the vertex type itself need not be finite. -/
theorem forestEdgeScan_spanningTree {V : Type*} (G : SimpleGraph V)
    (pairs : List (V × V)) (hcover : ∀ u v, G.Adj u v → (u, v) ∈ pairs)
    (hnonempty : Nonempty V) (hconnected : ∀ u v, G.Reachable u v) :
    (forestEdgeScan G pairs).IsTree := by
  let T := forestEdgeScan G pairs
  have hedge : ∀ u v, G.Adj u v → T.Reachable u v := by
    intro u v huv
    exact forestEdgeScan_allEdges_reachable G pairs hcover huv
  have hreach : ∀ u v, G.Reachable u v → T.Reachable u v := by
    intro u v huv
    apply huv.elim
    intro p
    induction p with
    | nil => exact Reachable.refl _
    | cons ha p ih => exact (hedge _ _ ha).trans (ih p.reachable)
  exact { preconnected := fun u v => hreach u v (hconnected u v)
          nonempty := hnonempty
          isAcyclic := (forestEdgeScan_invariant G pairs).1 }

end Ising2DLambda.NecSuf.Tools
