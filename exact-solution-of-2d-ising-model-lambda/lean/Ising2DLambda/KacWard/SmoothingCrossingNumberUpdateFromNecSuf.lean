/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.SmoothingCrossingNumberUpdate
import Ising2DLambda.NecSuf.KacWard.SmoothingCrossingNumberUpdate

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

/-- 具体版が必要十分版の特殊化として得られることの記録。 -/
theorem smoothing_crossing_number_update_from_necSuf {m : ℕ} {V : Type}
    [DecidableEq V] [Fintype V]
    (vertex : Fin m → V) (visit visit' : Fin m → LocalVisit) (a b : Fin m)
    (hcross : IndexCrossing vertex visit a b)
    (hother : ∀ r, r ≠ a → r ≠ b → visit' r = visit r)
    (ha : (visit' a).turn ≠ .straight) (hb : (visit' b).turn ≠ .straight) :
    ((Finset.univ ×ˢ Finset.univ).filter fun p : Fin m × Fin m =>
        p.1 < p.2 ∧ IndexCrossing vertex visit p.1 p.2).card + 1
      = ((Finset.univ ×ˢ Finset.univ).filter fun p : Fin m × Fin m =>
          p.1 < p.2 ∧ IndexCrossing vertex visit' p.1 p.2).card
        + (Finset.univ.filter fun k : Fin m => vertex k = vertex a ∧
            (visit k).turn = .straight ∧ (visit k).vertical = false).card
        + (Finset.univ.filter fun k : Fin m => vertex k = vertex a ∧
            (visit k).turn = .straight ∧ (visit k).vertical = true).card :=
  smoothing_crossing_number_update vertex visit visit' a b hcross hother ha hb

end Ising2DLambda.KacWard
