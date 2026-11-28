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

noncomputable def forestEdgeScanEdges {n : ℕ} (G : FiniteSimpleGraphEdgeData n)
    (pairs : List (Fin n × Fin n)) : Finset (Sym2 (Fin n)) := by
  classical
  exact (forestEdgeScan G.toSimpleGraph pairs).edgeFinset

/-- Every finite prefix of the edge scan remains an acyclic subgraph. -/
theorem forestEdgeScan_invariant {n : ℕ} (G : FiniteSimpleGraphEdgeData n)
    (pairs : List (Fin n × Fin n)) :
    forestEdgeScanEdges G pairs ⊆ G.edges ∧
      (forestEdgeScan G.toSimpleGraph pairs).IsAcyclic := by
  classical
  have hscan : (forestEdgeScan G.toSimpleGraph pairs).IsAcyclic ∧
      forestEdgeScan G.toSimpleGraph pairs ≤ G.toSimpleGraph := by
    unfold forestEdgeScan
    have hstep : ∀ (F : FiniteSimpleGraph n) (uv : Fin n × Fin n),
        F.IsAcyclic ∧ F ≤ G.toSimpleGraph →
        (forestEdgeScanStep G.toSimpleGraph F uv).IsAcyclic ∧
          forestEdgeScanStep G.toSimpleGraph F uv ≤ G.toSimpleGraph := by
      intro F uv hF
      unfold forestEdgeScanStep
      split_ifs with h
      · let Fd := FiniteSimpleGraphEdgeData.ofSimpleGraph F
        have hFgraph : Fd.toSimpleGraph = F :=
          FiniteSimpleGraphEdgeData.toSimpleGraph_ofSimpleGraph F
        have hFGd : Fd.edges ⊆ G.edges := by
          apply (FiniteSimpleGraphEdgeData.toSimpleGraph_le_iff Fd G).mp
          rw [hFgraph]
          exact hF.2
        have hforest : Fd.toSimpleGraph.IsAcyclic := by
          rw [hFgraph]
          exact hF.1
        have huv : s(uv.1, uv.2) ∈ G.edges := h.1
        have hnot : ¬ Fd.toSimpleGraph.Reachable uv.1 uv.2 := by
          rw [hFgraph]
          exact h.2
        have hd := forest_addDisconnectedEdge n G Fd hFGd hforest uv.1 uv.2 huv hnot
        refine ⟨?_, ?_⟩
        · simpa only [hFgraph] using hd.1
        · intro a b hab
          have hab' : (Fd.toSimpleGraph ⊔ edge uv.1 uv.2).Adj a b := by
            simpa only [hFgraph] using hab
          have he : s(a, b) ∈ (Fd.toSimpleGraph ⊔ edge uv.1 uv.2).edgeFinset := by
            simpa only [SimpleGraph.mem_edgeFinset, SimpleGraph.mem_edgeSet] using hab'
          rw [hd.2.1] at he
          exact hd.2.2 he
      · exact hF
    induction pairs using List.reverseRecOn with
    | nil => simp
    | append_singleton pairs uv ih =>
        rw [List.foldl_append, List.foldl_cons, List.foldl_nil]
        exact hstep _ uv ih
  constructor
  · unfold forestEdgeScanEdges
    rw [← G.edgeFinset_toSimpleGraph]
    exact SimpleGraph.edgeFinset_mono hscan.2
  · exact hscan.1

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

/-- Scanning every ordered vertex pair produces a spanning tree of a connected finite graph. -/
theorem finiteGraphConnected_has_spanningTree {n : ℕ} (G : FiniteSimpleGraph n)
    (hG : FiniteGraphConnected G) :
    ∃ T : FiniteSimpleGraph n, FiniteSpanningTree G T := by
  classical
  let pairs : List (Fin n × Fin n) := (Finset.univ : Finset (Fin n × Fin n)).toList
  let T := forestEdgeScan G pairs
  have hcover : ∀ u v, G.Adj u v → (u, v) ∈ pairs := by
    intro u v _
    simp [pairs]
  have hedge : ∀ u v, G.Adj u v → T.Reachable u v := by
    intro u v huv
    exact forestEdgeScan_allEdges_reachable G pairs hcover huv
  have hreach : ∀ u v, G.Reachable u v → T.Reachable u v := by
    -- Replace each edge of the original walk by its path in the final forest.
    intro u v huv
    apply huv.elim
    intro p
    induction p with
    | nil => exact Reachable.refl _
    | cons ha p ih => exact (hedge _ _ ha).trans (ih p.reachable)
  have hconn : FiniteGraphConnected T := by
    refine ⟨hG.1, ?_⟩
    intro u v
    have hr : T.Reachable u v := hreach u v (hG.2 u v).some.1.reachable
    -- Erasing repeated vertices gives the simple path required by the paper's definition.
    exact ⟨hr.some.toPath⟩
  let Gd := FiniteSimpleGraphEdgeData.ofSimpleGraph G
  have hGd : Gd.toSimpleGraph = G :=
    FiniteSimpleGraphEdgeData.toSimpleGraph_ofSimpleGraph G
  have hinvariant := forestEdgeScan_invariant Gd pairs
  rw [hGd] at hinvariant
  have hTG : T ≤ G := by
    intro a b hab
    have he : s(a, b) ∈ T.edgeFinset := SimpleGraph.mem_edgeFinset.mpr hab
    have heG : s(a, b) ∈ Gd.edges := by
      apply hinvariant.1
      unfold forestEdgeScanEdges
      rw [hGd]
      exact he
    have hAdj : Gd.toSimpleGraph.Adj a b := heG
    simpa only [hGd] using hAdj
  refine ⟨T, ⟨⟨hconn, ?_⟩, hTG⟩⟩
  intro u ⟨p⟩
  exact hinvariant.2 p.1 p.2

end Ising2DLambda.Tools
