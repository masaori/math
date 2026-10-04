/- 横断二列の基点独立性を、任意の添字写像に対する必要十分版から導く。 -/
import Ising2DLambda.KacWard.OneSidedTransverseSteps
import Ising2DLambda.NecSuf.KacWard.OneSidedTransverseSteps

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

theorem oneSidedTransverseSteps_base_independent_from_necSuf
    (wh wv : ℤ) (base : ℤ × ℤ) (t : ℕ) (reverse : Bool)
    (i : ℕ) (_hi : i < t * (wh.natAbs + wv.natAbs)) :
    let b := t * (wh.natAbs + wv.natAbs)
    let index := fun j : ℕ => if reverse then b - j else j
    iteratedTransverseStaircase wh wv base (index (i + 1)) -
        iteratedTransverseStaircase wh wv base (index i) =
      iteratedTransverseStaircase wh wv 0 (index (i + 1)) -
        iteratedTransverseStaircase wh wv 0 (index i) := by
  -- 値の群を整数格子、元の道を横断階段、添字写像を二つの向きへ特殊化する。
  exact iteratedStaircase_reindexed_steps_base_independent_necSuf
    (wh.natAbs + wv.natAbs) (windingTransverseStaircase wh wv) (wh, -wv) base
    (fun j : ℕ => if reverse then t * (wh.natAbs + wv.natAbs) - j else j) i

/-- 必要十分版から得た基点独立性を、本文末尾の上り列と下り列へ特殊化する。 -/
theorem oneSidedTransverseSteps_closure_columns_from_necSuf
    (wh wv : ℤ) (S B : ℤ × ℤ) (t c i : ℕ)
    (hi : i < t * (wh.natAbs + wv.natAbs)) :
    let b := t * (wh.natAbs + wv.natAbs)
    (iteratedTransverseStaircase wh wv (S + c • B) (i + 1) -
        iteratedTransverseStaircase wh wv (S + c • B) i =
      iteratedTransverseStaircase wh wv 0 (i + 1) -
        iteratedTransverseStaircase wh wv 0 i) ∧
    (iteratedTransverseStaircase wh wv S (b - (i + 1)) -
        iteratedTransverseStaircase wh wv S (b - i) =
      iteratedTransverseStaircase wh wv 0 (b - (i + 1)) -
        iteratedTransverseStaircase wh wv 0 (b - i)) := by
  dsimp only
  constructor
  · exact oneSidedTransverseSteps_base_independent_from_necSuf
      wh wv (S + c • B) t false i hi
  · exact oneSidedTransverseSteps_base_independent_from_necSuf wh wv S t true i hi

end Ising2DLambda.KacWard
