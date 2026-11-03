import Ising2DLambda.NecSuf.KacWard.SmoothingStraightVisitCount

namespace Ising2DLambda.NecSuf.KacWard

/-- The cyclic successor after exchanging the exits at two indices. -/
def smoothedSuccessorMap {m : ℕ} (k l r : Fin (m + 1)) : Fin (m + 1) :=
  if r = k then cyclicSuccessor l
  else if r = l then cyclicSuccessor k
  else cyclicSuccessor r

theorem smoothedSuccessorEdge_eq_map {E : Type*} {m : ℕ}
    (γ : Fin (m + 1) → E) (k l r : Fin (m + 1)) :
    smoothedSuccessorEdge γ k l r = γ (smoothedSuccessorMap k l r) := by
  by_cases hrk : r = k
  · simp [smoothedSuccessorEdge, smoothedSuccessorMap, hrk]
  · by_cases hrl : r = l
    · by_cases hlk : l = k <;>
        simp [smoothedSuccessorEdge, smoothedSuccessorMap, hrl, hlk]
    · simp [smoothedSuccessorEdge, smoothedSuccessorMap, hrk, hrl]

end Ising2DLambda.NecSuf.KacWard
