import Ising2DLambda.KacWard.OneSidedParallelReturnFromWalk
import Ising2DLambda.KacWard.ParallelStaircaseTransverseWidth
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

/-- 一側閉包の反転平行階段は、最大横断水準で切った実際の閉歩道の周期部分より高い。 -/
theorem oneSidedParallelReturnFromWalk_avoids_periodicLift {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hwind : (horizontalDirectedWindingNumber γ,
      verticalDirectedWindingNumber γ) ≠ (0, 0))
    (k₀ : ℤ)
    (hmax : ∀ i : ℕ,
      windingTransverseCoordinateFromWalk γ (periodicPlaneLiftFromWalk γ (k₀ + i)) ≤
        windingTransverseCoordinateFromWalk γ (periodicPlaneLiftFromWalk γ k₀))
    (t c : ℕ) (ht : 0 < t) :
    let wh := horizontalDirectedWindingNumber γ
    let wv := verticalDirectedWindingNumber γ
    let S := periodicPlaneLiftFromWalk γ k₀
    let n := L * wh.natAbs + L * wv.natAbs
    ∀ i < c * (m + 1), ∀ j < c * n,
      periodicPlaneLiftFromWalk γ (k₀ + i) ≠
        oneSidedParallelReturn L wh wv (S + t • (wh, -wv)) c j := by
  dsimp only
  let wh := horizontalDirectedWindingNumber γ
  let wv := verticalDirectedWindingNumber γ
  let S := periodicPlaneLiftFromWalk γ k₀
  let n := L * wh.natAbs + L * wv.natAbs
  let κ := windingTransverseCoordinate wh wv
  have hn : 0 < n := by
    by_cases hh : wh = 0
    · have hv : wv ≠ 0 := by
        intro he
        exact hwind (by simp [wh, wv, hh, he])
      have hp : 0 < L * wv.natAbs := Nat.mul_pos (NeZero.pos L)
        (Nat.pos_of_ne_zero (by simpa using hv))
      omega
    · have hp : 0 < L * wh.natAbs := Nat.mul_pos (NeZero.pos L)
        (Nat.pos_of_ne_zero (by simpa using hh))
      omega
  have hpositive : 0 < wh ^ 2 + wv ^ 2 := by
    by_cases hh : wh = 0
    · have hv : wv ≠ 0 := by
        intro he
        exact hwind (by simp [wh, wv, hh, he])
      nlinarith [sq_pos_of_ne_zero hv]
    · nlinarith [sq_pos_of_ne_zero hh, sq_nonneg wv]
  intro i hi j hj heq
  have hrem : j % n ≤ L * wh.natAbs + L * wv.natAbs := by
    have := Nat.mod_lt j hn
    omega
  have hwidth := (windingParallelStaircase_transverse_width_bound
    L wh wv (0, 0) (j % n) hrem).2
  have hG : κ (windingParallelStaircase L wh wv (j % n)) ≤ 0 := by
    simpa [κ] using hwidth
  have hQ : κ (S + t • (wh, -wv)) = κ S + (t : ℤ) * (wh ^ 2 + wv ^ 2) := by
    simp [κ, windingTransverseCoordinate, Prod.smul_mk]
    ring
  have hr : κ (oneSidedParallelReturn L wh wv (S + t • (wh, -wv)) c j) =
      κ S + (t : ℤ) * (wh ^ 2 + wv ^ 2) -
        κ (windingParallelStaircase L wh wv (j % n)) := by
    simp [κ, n, oneSidedParallelReturn, windingTransverseCoordinate,
      Prod.smul_mk]
    ring
  have htop := hmax i
  change κ (periodicPlaneLiftFromWalk γ (k₀ + i)) ≤ κ S at htop
  rw [heq, hr] at htop
  have ht' : (0 : ℤ) < t := by exact_mod_cast ht
  nlinarith

end Ising2DLambda.KacWard
