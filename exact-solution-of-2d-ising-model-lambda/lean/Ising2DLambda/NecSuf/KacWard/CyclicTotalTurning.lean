import Ising2DLambda.NecSuf.KacWard.EdgeSequenceTotalTurning

namespace Ising2DLambda.NecSuf.KacWard

/-- 非空の有限辺列について、隣接二辺の和に終辺から始辺への値を足す。 -/
def cyclicTotalTurning {E : Type*} {m : ℕ}
    (turn : E → E → ℤ) (γ : Fin (m + 1) → E) : ℤ :=
  edgeSequenceTotalTurning turn γ + turn (γ (Fin.last m)) (γ 0)

end Ising2DLambda.NecSuf.KacWard
