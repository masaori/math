import Ising2DLambda.Tools.EvenEdgeSetCount
import Ising2DLambda.NecSuf.Tools.EvenEdgeSetCount

namespace Ising2DLambda.Tools

/-- The finite labelled graph statement follows by specializing the necessary and sufficient proof. -/
theorem finiteConnectedGraph_evenEdgeSet_count_from_necSuf {n : ℕ}
    (G : FiniteSimpleGraph n) [DecidableRel G.Adj]
    (hG : FiniteGraphConnected G) :
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
  simpa only [IsEvenEdgeSubsetOf, IsEvenEdgeSet, edgeParity,
    Ising2DLambda.NecSuf.Tools.IsEvenIncidence,
    Ising2DLambda.NecSuf.Tools.incidenceParity, Fintype.card_fin] using
    (Ising2DLambda.NecSuf.Tools.evenEdgeSet_count G T hT.2 hTree root)

end Ising2DLambda.Tools
