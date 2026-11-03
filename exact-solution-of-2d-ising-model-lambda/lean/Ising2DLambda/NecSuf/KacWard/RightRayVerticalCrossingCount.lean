import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

/-- The number of steps of a finite integer lattice path crossing the right ray of a cell. -/
def rightRayVerticalCrossingCount (m : ℕ) (P : Fin (m + 2) → ℤ × ℤ)
    (r c : ℤ) : ℕ :=
  (Finset.univ.filter (fun k : Fin (m + 1) =>
    c < (P k.castSucc).2 ∧ (P k.castSucc).2 = (P k.succ).2 ∧
      (((P k.castSucc).1 = r ∧ (P k.succ).1 = r + 1) ∨
       ((P k.castSucc).1 = r + 1 ∧ (P k.succ).1 = r)))).card

end Ising2DLambda.NecSuf.KacWard
