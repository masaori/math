import Mathlib.Combinatorics.SimpleGraph.Connectivity.Connected

namespace Ising2DLambda.NecSuf.Tools

/-- A walk crosses a cut whenever its endpoints lie on opposite sides. -/
theorem crossingEdge_of_preconnected {V : Type*} (G : SimpleGraph V)
    (hG : G.Preconnected) (U : Set V) (a b : V)
    (ha : a ∈ U) (hb : b ∉ U) :
    ∃ u v : V, u ∈ U ∧ v ∉ U ∧ G.Adj u v := by
  by_contra hno
  obtain ⟨p⟩ := hG a b
  have hwalk : ∀ {x y : V} (q : G.Walk x y), x ∈ U → y ∈ U := by
    intro x y q
    induction q with
    | nil => exact id
    | @cons x z y hxz q ih =>
      intro hx
      by_cases hz : z ∈ U
      · exact ih hz
      · exact False.elim (hno ⟨x, z, hx, hz, hxz⟩)
  exact hb (hwalk p ha)

end Ising2DLambda.NecSuf.Tools
