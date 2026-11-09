import Mathlib.Combinatorics.SimpleGraph.Paths

namespace Ising2DLambda.Tools

/-- A finite simple graph with numbered vertices; any finite vertex set can be enumerated. -/
abbrev FiniteSimpleGraph (n : ℕ) := SimpleGraph (Fin n)

/-- A nonempty vertex walk with no repeated vertices; a singleton is allowed. -/
abbrev FiniteSimplePath {n : ℕ} (G : FiniteSimpleGraph n) (u v : Fin n) :=
  {p : G.Walk u v // p.IsPath}

/-- A graph is connected when it has a vertex and every ordered pair has a simple path. -/
def FiniteGraphConnected {n : ℕ} (G : FiniteSimpleGraph n) : Prop :=
  Nonempty (Fin n) ∧ ∀ u v : Fin n, Nonempty (FiniteSimplePath G u v)

/-- A closed walk with distinct vertices except for its common start and end. -/
abbrev FiniteSimpleCycle {n : ℕ} (G : FiniteSimpleGraph n) (u : Fin n) :=
  {p : G.Walk u u // p.IsCycle}

/-- A connected finite simple graph without a simple cycle. -/
def FiniteTree {n : ℕ} (G : FiniteSimpleGraph n) : Prop :=
  FiniteGraphConnected G ∧ ∀ u : Fin n, ¬ Nonempty (FiniteSimpleCycle G u)

/-- A spanning tree has the same vertex type and only edges from the ambient graph. -/
def FiniteSpanningTree {n : ℕ} (G T : FiniteSimpleGraph n) : Prop :=
  FiniteTree T ∧ T ≤ G

/-- Keep exactly the edges whose two endpoints lie in the chosen vertex set. -/
abbrev FiniteInducedSubgraph {n : ℕ} (G : FiniteSimpleGraph n) (U : Set (Fin n)) :=
  G.induce U

end Ising2DLambda.Tools
