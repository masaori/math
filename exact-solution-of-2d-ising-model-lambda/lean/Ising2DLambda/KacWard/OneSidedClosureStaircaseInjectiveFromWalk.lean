import Ising2DLambda.KacWard.IteratedTransverseStaircase
import Ising2DLambda.KacWard.PlaneLift

namespace Ising2DLambda.KacWard

/-- 実際の閉歩道の巻き付きが非零なら、一側閉包の二つの横断階段はそれぞれ単射である。 -/
theorem oneSidedClosureStaircasesFromWalk_injective {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L) (k₀ : ℤ) (t c : ℕ)
    (hwind : (horizontalDirectedWindingNumber γ,
      verticalDirectedWindingNumber γ) ≠ (0, 0)) :
    let wh := horizontalDirectedWindingNumber γ
    let wv := verticalDirectedWindingNumber γ
    let S := periodicPlaneLiftFromWalk γ k₀
    let b := t * (wh.natAbs + wv.natAbs)
    (∀ i j : ℕ, i < b → j < b →
      iteratedTransverseStaircase wh wv (S + c • windingShift L wv wh) i =
        iteratedTransverseStaircase wh wv (S + c • windingShift L wv wh) j → i = j) ∧
    (∀ i j : ℕ, 0 < i → i ≤ b → 0 < j → j ≤ b →
      iteratedTransverseStaircase wh wv S i =
        iteratedTransverseStaircase wh wv S j → i = j) := by
  dsimp only
  constructor
  · intro i j _ _ hij
    exact (iteratedTransverseStaircase_lower_bound _ _ _ hwind).2.2.2 hij
  · intro i j _ _ _ _ hij
    exact (iteratedTransverseStaircase_lower_bound _ _ _ hwind).2.2.2 hij

end Ising2DLambda.KacWard
