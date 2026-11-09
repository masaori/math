import Ising2DLambda.NecSuf.Tools.RootedLeafEdge
import Mathlib.Combinatorics.SimpleGraph.Finite

namespace Ising2DLambda.Tools

/-- The abstract incidence argument specializes to an edge of the induced tree. -/
theorem rootedLeafEdge_unselected_from_necSuf (n : ℕ) (G T : SimpleGraph (Fin n))
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
  exact Ising2DLambda.NecSuf.Tools.unprocessedEdge_unselected
    (fun w e => w ∈ e) A T.edgeFinset (U : Set (Fin n))
    (s(leaf.1, parent.1)) hinside heT hendpoints

end Ising2DLambda.Tools
