import Ising2DLambda.Tools.EvenEdgeSymmDiff

namespace Ising2DLambda.Tools

theorem simpleGraph_edge_incidence_even (n : ℕ) (G : SimpleGraph (Fin n))
    [DecidableRel G.Adj] (A : Finset (Sym2 (Fin n)))
    (hA : A ⊆ G.edgeFinset) :
    ∀ e ∈ A, (∑ v : Fin n, if v ∈ e then (1 : ZMod 2) else 0) = 0 := by
  classical
  -- Each selected edge has exactly two distinct ends, hence contributes twice.
  intro e he
  induction e using Sym2.ind with
  | _ a b =>
    have hab : a ≠ b := (SimpleGraph.mem_edgeFinset.mp (hA he)).ne
    have hcard : (Finset.univ.filter (fun v : Fin n => v = a ∨ v = b)).card = 2 := by
      have heq : Finset.univ.filter (fun v : Fin n => v = a ∨ v = b) = {a, b} := by
        ext v
        simp [Finset.mem_filter, eq_comm]
      rw [heq]
      simp [hab]
    simpa [Sym2.mem_iff, hcard] using (show (2 : ZMod 2) = 0 by decide)

theorem evenEdgeSubset_root_of_other_even (n : ℕ) (G : SimpleGraph (Fin n))
    [DecidableRel G.Adj] (A : Finset (Sym2 (Fin n))) (root : Fin n)
    (hA : A ⊆ G.edgeFinset)
    (hother : ∀ v ≠ root, edgeParity n A v = 0) :
    edgeParity n A root = 0 := by
  classical
  have hedge := simpleGraph_edge_incidence_even n G A hA
  -- Recount the vertex-edge incidences edge by edge.
  have htotal : (∑ v : Fin n, edgeParity n A v) = 0 := by
    simp only [edgeParity]
    rw [Finset.sum_comm]
    apply Finset.sum_eq_zero
    intro e _
    by_cases he : e ∈ A
    · simpa [he] using hedge e he
    · simp [he]
  -- All non-root summands vanish; the total is even, so the root summand vanishes.
  rw [← Finset.add_sum_erase _ _ (Finset.mem_univ root)] at htotal
  have hrest : (∑ v ∈ Finset.univ.erase root, edgeParity n A v) = 0 := by
    apply Finset.sum_eq_zero
    intro v hv
    exact hother v (Finset.mem_erase.mp hv).1
  simpa [hrest] using htotal

end Ising2DLambda.Tools
