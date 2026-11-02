import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Data.Fintype.Basic
import Ising2DLambda.NecSuf.KacWard.TotalTurning

open scoped BigOperators

namespace Ising2DLambda.NecSuf.KacWard

/-- 隣接する要素ごとの整数値を、有限な非空列に沿って足す。 -/
def edgeSequenceTotalTurning {E : Type*} {m : ℕ}
    (turn : E → E → ℤ) (γ : Fin (m + 1) → E) : ℤ :=
  ∑ k : Fin m, turn (γ (Fin.castSucc k)) (γ (Fin.succ k))

end Ising2DLambda.NecSuf.KacWard
