import Ising2DLambda.KacWard.OneSidedParallelReturn
import Ising2DLambda.KacWard.PlaneLift

namespace Ising2DLambda.KacWard

/-- 一側閉包の第三部分を、実際の閉歩道から得た巻き付き数と基点で読む。 -/
theorem oneSidedParallelReturnFromWalk_injective {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hwind : (horizontalDirectedWindingNumber γ,
      verticalDirectedWindingNumber γ) ≠ (0, 0))
    (k₀ : ℤ) (t c : ℕ) :
    Function.Injective
      (oneSidedParallelReturn L
        (horizontalDirectedWindingNumber γ) (verticalDirectedWindingNumber γ)
        (periodicPlaneLiftFromWalk γ k₀ +
          t • (horizontalDirectedWindingNumber γ, -verticalDirectedWindingNumber γ)) c) := by
  let wh := horizontalDirectedWindingNumber γ
  let wv := verticalDirectedWindingNumber γ
  have hn : 0 < L * wh.natAbs + L * wv.natAbs := by
    by_cases hh : wh = 0
    · have hv : wv ≠ 0 := by
        intro he
        exact hwind (by simp [wh, wv, hh, he])
      have habs : 0 < wv.natAbs := Nat.pos_of_ne_zero (by simpa using hv)
      have hp : 0 < L * wv.natAbs := Nat.mul_pos (NeZero.pos L) habs
      omega
    · have habs : 0 < wh.natAbs := Nat.pos_of_ne_zero (by simpa using hh)
      have hp : 0 < L * wh.natAbs := Nat.mul_pos (NeZero.pos L) habs
      omega
  exact oneSidedParallelReturn_injective L wh wv
    (periodicPlaneLiftFromWalk γ k₀ + t • (wh, -wv)) c hn

end Ising2DLambda.KacWard
