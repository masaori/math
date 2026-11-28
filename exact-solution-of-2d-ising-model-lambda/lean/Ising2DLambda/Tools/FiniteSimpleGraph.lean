import Mathlib.Combinatorics.SimpleGraph.Paths

namespace Ising2DLambda.Tools

/-! The paper specifies a graph by its finite vertex set and a set of unordered
distinct pairs.  `Fin n` is the numbered copy of that vertex set. -/
structure FiniteSimpleGraphEdgeData (n : ℕ) where
  edges : Finset (Sym2 (Fin n))
  noLoops : ∀ v : Fin n, s(v, v) ∉ edges

@[ext] theorem FiniteSimpleGraphEdgeData.ext {n : ℕ}
    {G H : FiniteSimpleGraphEdgeData n} (h : G.edges = H.edges) : G = H := by
  cases G with
  | mk eG _ =>
    cases H with
    | mk eH _ =>
      cases h
      rfl

def FiniteSimpleGraphEdgeData.toSimpleGraph {n : ℕ}
    (G : FiniteSimpleGraphEdgeData n) : SimpleGraph (Fin n) where
  Adj u v := s(u, v) ∈ G.edges
  symm := by
    constructor
    intro u v h
    simpa only [Sym2.eq_swap] using h
  loopless := by
    constructor
    intro v
    exact G.noLoops v

def FiniteSimpleGraphEdgeData.ofSimpleGraph {n : ℕ}
    (G : SimpleGraph (Fin n)) [DecidableRel G.Adj] :
    FiniteSimpleGraphEdgeData n where
  edges := G.edgeFinset
  noLoops := by
    intro v hv
    rcases G.loopless with ⟨hloopless⟩
    exact hloopless v (SimpleGraph.mem_edgeFinset.mp hv)

theorem FiniteSimpleGraphEdgeData.toSimpleGraph_ofSimpleGraph {n : ℕ}
    (G : SimpleGraph (Fin n)) [DecidableRel G.Adj] :
    (FiniteSimpleGraphEdgeData.ofSimpleGraph G).toSimpleGraph = G := by
  ext u v
  exact SimpleGraph.mem_edgeFinset

theorem FiniteSimpleGraphEdgeData.ofSimpleGraph_toSimpleGraph {n : ℕ}
    (G : FiniteSimpleGraphEdgeData n) [DecidableRel G.toSimpleGraph.Adj] :
    FiniteSimpleGraphEdgeData.ofSimpleGraph G.toSimpleGraph = G := by
  apply FiniteSimpleGraphEdgeData.ext
  ext e
  induction e using Sym2.inductionOn with
  | _ u v =>
    simp only [FiniteSimpleGraphEdgeData.ofSimpleGraph, SimpleGraph.mem_edgeFinset,
      SimpleGraph.mem_edgeSet]
    rfl

/-- A finite simple graph with numbered vertices; any finite vertex set can be enumerated. -/
abbrev FiniteSimpleGraph (n : ℕ) := SimpleGraph (Fin n)

noncomputable def finiteSimpleGraphEdgeEquiv (n : ℕ) :
    FiniteSimpleGraphEdgeData n ≃ FiniteSimpleGraph n where
  toFun := FiniteSimpleGraphEdgeData.toSimpleGraph
  invFun := by
    intro G
    classical
    exact FiniteSimpleGraphEdgeData.ofSimpleGraph G
  left_inv := by
    intro G
    classical
    exact FiniteSimpleGraphEdgeData.ofSimpleGraph_toSimpleGraph G
  right_inv := by
    intro G
    classical
    exact FiniteSimpleGraphEdgeData.toSimpleGraph_ofSimpleGraph G

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
