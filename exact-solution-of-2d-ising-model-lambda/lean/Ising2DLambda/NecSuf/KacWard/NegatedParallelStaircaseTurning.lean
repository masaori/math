/- 同じ添字順で符号を反転した二区間の階段。
隣接差には可換加法群、回転和には可換加法と対角零・二接合の相殺だけを使う。 -/
import Ising2DLambda.NecSuf.KacWard.ReversedParallelStaircaseTurning

namespace Ising2DLambda.NecSuf.KacWard

def negatedTwoPhaseStep {G : Type*} [AddCommGroup G]
    (p : ℕ) (a b : G) (s : ℕ) : G :=
  -(twoPhaseStaircase p a b (s + 1) - twoPhaseStaircase p a b s)

/-- 隣接差の符号を反転しても、二区間の順序は変わらない。 -/
theorem negatedTwoPhaseStep_eq_necSuf {G : Type*} [AddCommGroup G]
    (p : ℕ) (a b : G) (s : ℕ) :
    negatedTwoPhaseStep p a b s = twoBlockSequence p (-a) (-b) s := by
  unfold negatedTwoPhaseStep
  rw [twoPhaseStaircase_difference_necSuf]
  by_cases hs : s < p <;> simp [twoBlockSequence, hs]

/-- 本文の歩列の同定、有限和への代入、二区間相殺を同じ順で行う。
weight 全体の反対称性は不要で、現れる二値についての三等式だけを残す。 -/
theorem negatedTwoPhase_cyclicAdjacentSum_zero_necSuf
    {G M : Type*} [AddCommGroup G] [AddCommMonoid M]
    (weight : G → G → M) (p q : ℕ) (a b : G)
    (haa : weight (-a) (-a) = 0) (hbb : weight (-b) (-b) = 0)
    (hab : weight (-a) (-b) + weight (-b) (-a) = 0) :
    cyclicAdjacentSum weight (p + q) (negatedTwoPhaseStep p a b) = 0 := by
  have hsteps : negatedTwoPhaseStep p a b = twoBlockSequence p (-a) (-b) := by
    funext s
    exact negatedTwoPhaseStep_eq_necSuf p a b s
  calc
    cyclicAdjacentSum weight (p + q) (negatedTwoPhaseStep p a b) =
        cyclicAdjacentSum weight (p + q) (twoBlockSequence p (-a) (-b)) :=
      congrArg (cyclicAdjacentSum weight (p + q)) hsteps
    _ = 0 := twoBlock_cyclicAdjacentSum_zero_necSuf weight p q (-a) (-b) haa hbb hab

end Ising2DLambda.NecSuf.KacWard
