import Ising2DLambda.Tools.EvenEdgeTreeComplementBijection
import Ising2DLambda.Tools.ForestEdgeScan
import Ising2DLambda.Tools.FiniteTreeEdgeCount
import Mathlib.Data.Finset.Powerset
import Mathlib.Tactic

namespace Ising2DLambda.Tools

/-- A connected finite graph has one even edge subset for each choice of its non-tree edges. -/
theorem finiteConnectedGraph_evenEdgeSet_count {n : ℕ} (G : FiniteSimpleGraph n)
    [DecidableRel G.Adj] (hG : FiniteGraphConnected G) :
    Nat.card {A : Finset (Sym2 (Fin n)) // IsEvenEdgeSubsetOf n G A} =
      2 ^ (G.edgeFinset.card + 1 - n) := by
  classical
  obtain ⟨T, hT⟩ := finiteGraphConnected_has_spanningTree G hG
  letI : Nonempty (Fin n) := hG.1
  have hConnected : T.Connected := by
    refine { preconnected := ?_, nonempty := hG.1 }
    intro u v
    exact (hT.1.1.2 u v).some.1.reachable
  have hTree : T.IsTree := by
    refine { connected := hConnected, isAcyclic := ?_ }
    intro u p hp
    exact hT.1.2 u ⟨p, hp⟩
  let root : Fin n := Classical.choice hG.1
  have hbij := evenEdge_treeComplementBijection n G T hT.2 hTree root
  have hcard := Fintype.card_congr (Equiv.ofBijective _ hbij)
  have hsubset : T.edgeFinset ⊆ G.edgeFinset := SimpleGraph.edgeFinset_mono hT.2
  have hcount := finiteTree_edge_count n T hTree
  have hle := Finset.card_le_card hsubset
  have hout : (G.edgeFinset \ T.edgeFinset).card = G.edgeFinset.card + 1 - n := by
    rw [Finset.card_sdiff_of_subset hsubset]
    omega
  rw [Nat.card_eq_fintype_card, hcard]
  have hpowerset :
      Fintype.card {C : Finset (Sym2 (Fin n)) // C ⊆ G.edgeFinset \ T.edgeFinset} =
        2 ^ (G.edgeFinset \ T.edgeFinset).card := by
    rw [Fintype.card_subtype]
    convert (Finset.card_powerset (G.edgeFinset \ T.edgeFinset)) using 1
    congr 1
    ext C
    simp only [Finset.mem_filter, Finset.mem_univ, true_and, Finset.mem_powerset]
  rw [hpowerset, hout]

end Ising2DLambda.Tools
