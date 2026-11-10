import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- Counting the same finite family by cells and by graph cycles gives Euler number one. -/
theorem cellEuler_eq_one_of_even_edge_counts
    (vertexCount edgeCount cellCount evenEdgeCount : ℕ)
    (hboundary : evenEdgeCount = 2 ^ cellCount)
    (hgraph : evenEdgeCount = 2 ^ (edgeCount + 1 - vertexCount))
    (hvertices : vertexCount ≤ edgeCount + 1) :
    (vertexCount : ℤ) - edgeCount + cellCount = 1 := by
  have hpowers : 2 ^ cellCount = 2 ^ (edgeCount + 1 - vertexCount) := by
    calc
      2 ^ cellCount = evenEdgeCount := hboundary.symm
      _ = 2 ^ (edgeCount + 1 - vertexCount) := hgraph
  have hcells : cellCount = edgeCount + 1 - vertexCount :=
    Nat.pow_right_injective (by decide : 1 < 2) hpowers
  omega

end Ising2DLambda.NecSuf.KacWard
