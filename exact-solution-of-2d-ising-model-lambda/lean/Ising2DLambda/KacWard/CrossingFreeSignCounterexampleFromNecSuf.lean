/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.CrossingFreeSignCounterexample
import Ising2DLambda.NecSuf.KacWard.CrossingFreeSignCounterexample

namespace Ising2DLambda.KacWard

theorem crossingFreeSignCounterexample_from_necSuf :
    ([0, 1, -1, 0, -1, 1] : List ℤ).sum = 0 ∧
      ([0, 1, 0, 0, 1, 0] : List ℕ).sum % 2 = 0 ∧
      ([0, 0, 0, 0, 0, 0] : List ℕ).sum % 2 = 0 ∧
      (List.replicate 15 false).all (fun value => !value) = true ∧
      ((-1 : ℤ) ^ 0) ≠ ((-1 : ℤ) ^ 1) :=
  crossingFreeSignCounterexample

end Ising2DLambda.KacWard
