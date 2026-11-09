import Ising2DLambda.NecSuf.Tools.EvenEdgeTreeComplementBijection
import Ising2DLambda.NecSuf.Tools.FiniteTreeEdgeCount
import Mathlib.Data.Finset.Powerset
import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.Tools

/-- Only a finite vertex set, an even-incidence predicate, and a spanning tree are used. -/
theorem evenEdgeSet_count {V : Type*} [Fintype V] [DecidableEq V]
    (G T : SimpleGraph V) [DecidableRel G.Adj] [DecidableRel T.Adj]
    (hTG : T ≤ G) (hTree : T.IsTree) (root : V) :
    Nat.card {A : Finset (Sym2 V) //
      A ⊆ G.edgeFinset ∧ IsEvenIncidence (fun v e => v ∈ e) A} =
      2 ^ (G.edgeFinset.card + 1 - Fintype.card V) := by
  classical
  have hbij := evenEdge_treeComplementBijection G T hTG hTree root
  have hcard := Fintype.card_congr (Equiv.ofBijective _ hbij)
  have hsubset : T.edgeFinset ⊆ G.edgeFinset := SimpleGraph.edgeFinset_mono hTG
  have hcount := finiteTree_edge_count T hTree
  have hle := Finset.card_le_card hsubset
  have hout : (G.edgeFinset \ T.edgeFinset).card =
      G.edgeFinset.card + 1 - Fintype.card V := by
    rw [Finset.card_sdiff_of_subset hsubset]
    omega
  rw [Nat.card_eq_fintype_card, hcard]
  have hpowerset :
      Fintype.card {C : Finset (Sym2 V) // C ⊆ G.edgeFinset \ T.edgeFinset} =
        2 ^ (G.edgeFinset \ T.edgeFinset).card := by
    rw [Fintype.card_subtype]
    convert (Finset.card_powerset (G.edgeFinset \ T.edgeFinset)) using 1
    congr 1
    ext C
    simp only [Finset.mem_filter, Finset.mem_univ, true_and, Finset.mem_powerset]
  rw [hpowerset, hout]

end Ising2DLambda.NecSuf.Tools
