import Mathlib.Combinatorics.SimpleGraph.Finite

namespace Ising2DLambda.Tools

/-- A finite simple graph with numbered vertices; any finite vertex set can be enumerated. -/
abbrev FiniteSimpleGraph (n : ℕ) := SimpleGraph (Fin n)

end Ising2DLambda.Tools
