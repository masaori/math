/-
必要十分版: 閉歩道の終辺から始辺への回転を追加すると、位相積は循環総回転数の冪になる。

人手証明と同じ四段（開いた辺列の位相積、閉じる一歩の位相、整数指数の指数法則、
循環総回転数の定義）で進む。必要な仮定は底 `z` が零でないことだけである。
これは整数指数の指数法則 `zpow_add₀` が要求し、零では一般に破れる。
辺・閉性・トーラスは、回転の有限列と閉じる一歩を作るための具体側のデータであり、
この四段の代数計算そのものには現れない。
-/
import Ising2DLambda.NecSuf.KacWard.TotalTurning

namespace Ising2DLambda.NecSuf.KacWard

/-- 位相積へ閉じる一歩を掛けると、回転数の和へ閉じる一歩を加えた冪になる。 -/
theorem phase_prod_mul_closing_eq_zpow_sum_add_necSuf {K : Type*} [Field K]
    {z : K} (hz : z ≠ 0) (turns : List Turn) (closing : Turn) :
    (turns.map (phaseOfTurn z)).prod * phaseOfTurn z closing =
      z ^ ((turns.map turnValue).sum + turnValue closing) := by
  rw [phase_prod_eq_zpow_sum_necSuf hz turns,
    phaseOfTurn_eq_zpow_necSuf z closing, ← zpow_add₀ hz]

end Ising2DLambda.NecSuf.KacWard
