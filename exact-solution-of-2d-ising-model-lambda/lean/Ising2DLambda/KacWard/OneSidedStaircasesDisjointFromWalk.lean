import Ising2DLambda.KacWard.ParallelSeparatedStaircases
import Ising2DLambda.KacWard.PeriodicPlaneLiftParallelIncrease
import Ising2DLambda.KacWard.PlaneLift
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

/-- 一側閉包の上り階段と下り階段は、実際の非零巻き付きの閉歩道について交わらない。 -/
theorem oneSidedStaircasesFromWalk_disjoint {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hwind : (horizontalDirectedWindingNumber γ,
      verticalDirectedWindingNumber γ) ≠ (0, 0))
    (k₀ : ℤ) (t c : ℕ) (ht : 0 < t) (hc : 0 < c) :
    let wh := horizontalDirectedWindingNumber γ
    let wv := verticalDirectedWindingNumber γ
    let S := periodicPlaneLiftFromWalk γ k₀
    let b := t * (wh.natAbs + wv.natAbs)
    ∀ i j : ℕ, i ≤ b → j ≤ b →
      iteratedTransverseStaircase wh wv (S + c • windingShift L wv wh) i ≠
        iteratedTransverseStaircase wh wv S j := by
  dsimp only
  let wh := horizontalDirectedWindingNumber γ
  let wv := verticalDirectedWindingNumber γ
  let S := periodicPlaneLiftFromWalk γ k₀
  have hnonzero : wv ≠ 0 ∨ wh ≠ 0 := by
    by_cases hv : wv = 0
    · right
      intro hh
      exact hwind (Prod.ext hh hv)
    · exact Or.inl hv
  have hwidth : |wh * wv| < wv ^ 2 + wh ^ 2 := by
    rw [abs_mul, ← sq_abs wh, ← sq_abs wv]
    rcases hnonzero with hv | hh
    · have hvpos : 1 ≤ |wv| := Int.one_le_abs hv
      nlinarith [sq_nonneg (|wh| - |wv|), mul_nonneg (abs_nonneg wh) (abs_nonneg wv)]
    · have hhpos : 1 ≤ |wh| := Int.one_le_abs hh
      nlinarith [sq_nonneg (|wh| - |wv|), mul_nonneg (abs_nonneg wh) (abs_nonneg wv)]
  have hLc : 1 ≤ (c : ℤ) * L := by
    have hL : 1 ≤ (L : ℤ) := by exact_mod_cast NeZero.pos L
    have hc' : 1 ≤ (c : ℤ) := by exact_mod_cast hc
    nlinarith
  have hseparated :
      |windingParallelCoordinate wv wh (S + c • windingShift L wv wh) -
        windingParallelCoordinate wv wh S| > |wh * wv| := by
    rw [map_add, map_nsmul, windingParallelCoordinate_windingShift]
    have hsum : 0 ≤ wv ^ 2 + wh ^ 2 := by positivity
    have hmul : wv ^ 2 + wh ^ 2 ≤ (c : ℤ) * L * (wv ^ 2 + wh ^ 2) := by
      nlinarith
    simp only [add_sub_cancel_left, nsmul_eq_mul]
    rw [abs_of_nonneg (by positivity : 0 ≤ (c : ℤ) * ((L : ℤ) * (wv ^ 2 + wh ^ 2)))]
    nlinarith
  intro i j hi hj
  exact parallelSeparatedIteratedTransverseStaircases_ne wh wv hwind
    (S + c • windingShift L wv wh) S t t i j ht ht hi hj hseparated

end Ising2DLambda.KacWard
