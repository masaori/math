/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.CrossingNumberVertexDecomposition
import Ising2DLambda.NecSuf.KacWard.CrossingNumberVertexDecomposition

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

/-- 具体版が必要十分版の特殊化として得られることの記録。 -/
theorem crossing_number_vertex_decomposition_from_necSuf
    {m : ℕ} {V : Type} [DecidableEq V] [Fintype V]
    (vertex : Fin m → V) (visit : Fin m → LocalVisit) :
    ((Finset.univ ×ˢ Finset.univ).filter fun p : Fin m × Fin m =>
        p.1 < p.2 ∧ IndexCrossing vertex visit p.1 p.2).card
      = ∑ v : V, (((Finset.univ ×ˢ Finset.univ).filter fun p : Fin m × Fin m =>
          p.1 < p.2 ∧ IndexCrossing vertex visit p.1 p.2).filter
            fun p => vertex p.1 = v).card :=
  crossing_number_vertex_decomposition vertex visit

end Ising2DLambda.KacWard
