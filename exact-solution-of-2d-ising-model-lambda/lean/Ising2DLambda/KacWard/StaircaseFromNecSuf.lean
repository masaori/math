/-
二相の階段と反復階段の具体版（`KacWard/Staircase.lean`）が、必要十分版の同名の定義を
点の型 `ℤ × ℤ` に特殊化したものに一致することの記録。導出（`*_from_necSuf`）だけが使う。
-/
import Ising2DLambda.KacWard.Staircase
import Ising2DLambda.NecSuf.KacWard.WindingParallelStaircase
import Ising2DLambda.NecSuf.KacWard.IteratedTransverseStaircase

namespace Ising2DLambda.KacWard

theorem twoPhaseStaircase_eq_necSuf (H : ℕ) (firstStep secondStep : ℤ × ℤ) :
    twoPhaseStaircase H firstStep secondStep =
      Ising2DLambda.NecSuf.KacWard.twoPhaseStaircase H firstStep secondStep :=
  rfl

theorem orderedTwoPhaseStaircase_eq_necSuf (firstBeforeSecond : Prop)
    [Decidable firstBeforeSecond] (H V : ℕ) (firstStep secondStep : ℤ × ℤ) :
    orderedTwoPhaseStaircase firstBeforeSecond H V firstStep secondStep =
      Ising2DLambda.NecSuf.KacWard.orderedTwoPhaseStaircase firstBeforeSecond H V
        firstStep secondStep :=
  rfl

theorem iteratedStaircase_eq_necSuf (n : ℕ) (path : ℕ → ℤ × ℤ) (period base : ℤ × ℤ) :
    iteratedStaircase n path period base =
      Ising2DLambda.NecSuf.KacWard.iteratedStaircase n path period base :=
  rfl

end Ising2DLambda.KacWard
