/- 具体版が必要十分版の順序付き二段階階段の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.WindingParallelStaircase

namespace Ising2DLambda.KacWard

/-- `claim_winding_parallel_staircase_step_increase` を必要十分版から導いたもの。 -/
theorem windingParallelStaircase_step_increase_from_necSuf (L : ℕ) (wh wv : ℤ) (s : ℕ)
    (hs : s < L * wh.natAbs + L * wv.natAbs) :
    let difference := windingParallelStaircase L wh wv (s + 1) -
      windingParallelStaircase L wh wv s
    (difference = (1, 0) ∨ difference = (-1, 0) ∨
      difference = (0, 1) ∨ difference = (0, -1)) ∧
    windingParallelCoordinate wv wh (windingParallelStaircase L wh wv s) <
      windingParallelCoordinate wv wh (windingParallelStaircase L wh wv (s + 1)) :=
  windingParallelStaircase_step_increase L wh wv s hs

end Ising2DLambda.KacWard
