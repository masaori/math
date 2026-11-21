/-
章「離散 Whitney 系: トーラス上の閉歩道の回転数」の、非後退な一歩の三つの場合
（直進・左回転・右回転）と、その上の一歩の回転数（`def_step_turning`）・回転位相
（`def_rotation_phase`）の値の表の具体版。

本文は、`f ∈ Next(e)` について `dir(f) - dir(e)` が `0`・`1`・`-1` のどれであるかで
一歩の回転数と回転位相を三つの場合に分けて定める。ここではその三つの場合を `Turn` の
三つの構成子に取り、各場合の値を本文の表のとおりに与える。値の住処は ℤ と Qbar であり、
ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnity

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

/-- 非後退な一歩の三つの場合。`dir(f) = dir(e)`・`dir(e)+1`・`dir(e)-1` に当たる。 -/
inductive Turn
  | straight
  | left
  | right
  deriving DecidableEq

/-- 一歩の回転数の表（`def_step_turning`）。直進 0・左回転 1・右回転 -1。 -/
def turnValue : Turn → ℤ
  | .straight => 0
  | .left => 1
  | .right => -1

/-- 回転位相の表（`def_rotation_phase`）。直進 1・左回転 `z`・右回転 `z⁻¹`。
本文は `z` に `ζ₈^4 = -1` を満たす代数的数を取る。 -/
noncomputable def phaseOfTurn (z : Qbar) : Turn → Qbar
  | .straight => 1
  | .left => z
  | .right => z⁻¹

/-- 辺対を逆順にして両辺を反転したときの場合の対応。左回転と右回転が入れ替わる。 -/
def reverseTurn : Turn → Turn
  | .straight => .straight
  | .left => .right
  | .right => .left

end Ising2DLambda.KacWard
