/-
具体版が必要十分版の二段階階段の特殊化として得られることの導出。
-/
import Ising2DLambda.KacWard.WindingTransverseStaircase

namespace Ising2DLambda.KacWard

/-- `claim_winding_transverse_staircase_step_increase` を必要十分版から導いたもの。 -/
theorem windingTransverseStaircase_step_increase_from_necSuf (wh wv : ℤ) (s : ℕ)
    (hs : s < wh.natAbs + wv.natAbs) :
    let difference := windingTransverseStaircase wh wv (s + 1) -
      windingTransverseStaircase wh wv s
    (difference = (1, 0) ∨ difference = (-1, 0) ∨
      difference = (0, 1) ∨ difference = (0, -1)) ∧
    windingTransverseCoordinate wh wv (windingTransverseStaircase wh wv s) <
      windingTransverseCoordinate wh wv (windingTransverseStaircase wh wv (s + 1)) :=
  windingTransverseStaircase_step_increase wh wv s hs

end Ising2DLambda.KacWard
