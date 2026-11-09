import Mathlib.Combinatorics.SimpleGraph.Finite

namespace Ising2DLambda.Tools

/-- An edge of the unprocessed induced tree has not been selected. -/
theorem rootedLeafEdge_unselected (n : ℕ) (G T : SimpleGraph (Fin n))
    [DecidableRel G.Adj] [DecidableRel T.Adj] (hTG : T ≤ G)
    (U : Finset (Fin n)) (A : Finset (Sym2 (Fin n)))
    (hinside : ∀ f ∈ A, f ∈ T.edgeFinset → ∃ w ∈ f, w ∉ U)
    (leaf parent : {w : Fin n // w ∈ U})
    (hadj : (T.induce (U : Set (Fin n))).Adj leaf parent) :
    s(leaf.1, parent.1) ∉ A := by
  classical
  have hT : T.Adj leaf.1 parent.1 := hadj
  have heT : s(leaf.1, parent.1) ∈ T.edgeFinset :=
    SimpleGraph.mem_edgeFinset.mpr hT
  have _heG : s(leaf.1, parent.1) ∈ G.edgeFinset :=
    SimpleGraph.mem_edgeFinset.mpr (hTG hT)
  have hendpoints : ∀ w : Fin n, w ∈ s(leaf.1, parent.1) → w ∈ U := by
    intro w hw
    rcases Sym2.mem_iff.mp hw with rfl | rfl
    · exact leaf.2
    · exact parent.2
  intro heA
  obtain ⟨w, hwe, hwU⟩ := hinside _ heA heT
  exact hwU (hendpoints w hwe)

end Ising2DLambda.Tools
