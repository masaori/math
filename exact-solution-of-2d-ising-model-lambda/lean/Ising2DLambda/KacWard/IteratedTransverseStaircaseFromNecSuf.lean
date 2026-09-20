/-
具体版が必要十分版の反復階段の特殊化として得られることの導出。
-/
import Ising2DLambda.KacWard.IteratedTransverseStaircase

namespace Ising2DLambda.KacWard

/-- `claim_iterated_transverse_staircase_lower_bound` を必要十分版から導いたもの。 -/
theorem iteratedTransverseStaircase_lower_bound_from_necSuf (wh wv : ℤ)
    (base : ℤ × ℤ) (hwind : (wh, wv) ≠ (0, 0)) :
    (∀ s : ℕ, windingTransverseCoordinate wh wv (iteratedTransverseStaircase wh wv base s) <
      windingTransverseCoordinate wh wv (iteratedTransverseStaircase wh wv base (s + 1))) ∧
    (∀ s : ℕ, windingTransverseCoordinate wh wv base + (s : ℤ) ≤
      windingTransverseCoordinate wh wv (iteratedTransverseStaircase wh wv base s)) ∧
    Function.Injective (iteratedTransverseStaircase wh wv base) :=
  (iteratedTransverseStaircase_lower_bound wh wv base hwind).2

end Ising2DLambda.KacWard
