import Mathlib.Combinatorics.SimpleGraph.Paths

namespace Ising2DLambda.Tools

/-- A finite simple graph with numbered vertices; any finite vertex set can be enumerated. -/
abbrev FiniteSimpleGraph (n : ℕ) := SimpleGraph (Fin n)

/-- A nonempty vertex walk with no repeated vertices; a singleton is allowed. -/
abbrev FiniteSimplePath {n : ℕ} (G : FiniteSimpleGraph n) (u v : Fin n) :=
  {p : G.Walk u v // p.IsPath}

end Ising2DLambda.Tools
