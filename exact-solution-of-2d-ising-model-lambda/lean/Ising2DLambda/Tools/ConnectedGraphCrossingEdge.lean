import Ising2DLambda.Tools.FiniteSimpleGraph
import Mathlib.Combinatorics.SimpleGraph.Connectivity.Connected

namespace Ising2DLambda.Tools

/-- A path from a vertex in a proper nonempty set to a vertex outside it crosses its boundary. -/
theorem connectedGraph_crossingEdge (n : ℕ) (G : FiniteSimpleGraph n)
    (hG : FiniteGraphConnected G) (U : Finset (Fin n))
    (hU : U.Nonempty) (hproper : U ≠ Finset.univ) :
    ∃ u v : Fin n, u ∈ U ∧ v ∉ U ∧ G.Adj u v := by
  classical
  by_contra hno
  -- Choose vertices on opposite sides and a simple path between them.
  obtain ⟨a, ha⟩ := hU
  obtain ⟨b, hb⟩ : ∃ b : Fin n, b ∉ U := by
    by_contra h
    push Not at h
    exact hproper (Finset.eq_univ_of_forall h)
  obtain ⟨p, _⟩ := hG.2 a b
  -- If no edge crosses the cut, membership propagates along each path step.
  have hwalk : ∀ {x y : Fin n} (q : G.Walk x y), x ∈ U → y ∈ U := by
    intro x y q
    induction q with
    | nil => exact id
    | @cons x z y hxz q ih =>
      intro hx
      by_cases hz : z ∈ U
      · exact ih hz
      · exact False.elim (hno ⟨x, z, hx, hz, hxz⟩)
  -- The endpoint would then belong to both sides.
  exact False.elim (hb (hwalk p ha))

end Ising2DLambda.Tools
