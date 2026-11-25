/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.VertexCrossingFactorization
import Ising2DLambda.NecSuf.KacWard.VertexCrossingFactorization

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

/-- 具体版が必要十分版の特殊化として得られることの記録。 -/
theorem vertex_crossing_number_factorization_from_necSuf {m : ℕ} {V : Type}
    [DecidableEq V] (vertex : Fin m → V) (visit : Fin m → LocalVisit) (v : V) :
    (((Finset.univ ×ˢ Finset.univ).filter fun p : Fin m × Fin m =>
        p.1 < p.2 ∧ IndexCrossing vertex visit p.1 p.2).filter
          fun p => vertex p.1 = v).card
      = (Finset.univ.filter fun k : Fin m => vertex k = v ∧
          (visit k).turn = .straight ∧ (visit k).vertical = false).card
        * (Finset.univ.filter fun k : Fin m => vertex k = v ∧
          (visit k).turn = .straight ∧ (visit k).vertical = true).card :=
  vertex_crossing_number_factorization vertex visit v

end Ising2DLambda.KacWard
