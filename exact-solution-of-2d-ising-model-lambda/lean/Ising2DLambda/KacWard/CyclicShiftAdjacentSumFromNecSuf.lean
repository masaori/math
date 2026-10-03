/- 有限添字の必要十分版を巡回添字と整数へ特殊化する。 -/
import Ising2DLambda.KacWard.CyclicShiftAdjacentSum
import Ising2DLambda.NecSuf.KacWard.CyclicShiftAdjacentSum

namespace Ising2DLambda.KacWard

theorem cyclicShift_adjacent_integer_sum_from_necSuf {m : ℕ} [NeZero m]
    (k : ZMod m) (a : ZMod m → ZMod m → ℤ) :
    (∑ j, a (j + k) ((j + 1) + k)) = ∑ j, a j (j + 1) := by
  exact Ising2DLambda.NecSuf.KacWard.permutedAdjacentSum_necSuf
    (fun j => j + 1) (cyclicIndexShift k) (cyclicIndexShift_successor k) a

end Ising2DLambda.KacWard
