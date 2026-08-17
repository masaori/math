/- 具体版が必要十分版（`finite_ncard_le_of_finset_card_le_necSuf`。1 の冪根の場合と共有）の
特殊化として得られることの導出。 -/
import Ising2DLambda.ThermodynamicLimit.FisherZeroSetFiniteCardBound
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.RootOfUnityFiniteCardBound

namespace Ising2DLambda.ThermodynamicLimit

open Ising2DLambda.FisherZero

theorem fisherZeroSet_finite_ncard_le_from_necSuf (L : ℕ) [NeZero L] :
    (FisherZeroSet L).Finite ∧ (FisherZeroSet L).ncard ≤ 2 * L ^ 2 := by
  apply Ising2DLambda.NecSuf.AlgebraicEigenvalue.finite_ncard_le_of_finset_card_le_necSuf
  intro S hS
  exact fisherZeroSet_finset_card_le L S fun w hw => hS hw

end Ising2DLambda.ThermodynamicLimit
