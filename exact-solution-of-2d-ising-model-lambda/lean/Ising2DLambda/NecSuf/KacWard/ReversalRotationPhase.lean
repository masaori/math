/-
必要十分版: 逆順にした辺対では回転差の符号が反転するため、二つの回転位相の積が 1 になる。

人手証明が使うのは、回転差が 0・1・-1 のいずれかであること、左回転と右回転の位相が
互いに逆元であることだけである。辺、トーラス、加法構造は必要ない。
-/
import Mathlib.Algebra.Field.Basic

namespace Ising2DLambda.NecSuf.KacWard

inductive Turn
  | straight
  | left
  | right
  deriving DecidableEq

/-- 三つの非後退回転へ与える位相。 -/
def phaseOfTurn {K : Type*} [Field K] (z : K) : Turn → K
  | .straight => 1
  | .left => z
  | .right => z⁻¹

/-- 辺対を逆順にして両辺を反転すると、左回転と右回転が入れ替わる。 -/
def reverseTurn : Turn → Turn
  | .straight => .straight
  | .left => .right
  | .right => .left

/-- 回転位相と逆回転の位相の積が 1 になるために必要なのは、左回転の位相が非零なことだけである。 -/
theorem reverse_phase_mul_necSuf {K : Type*} [Field K] {z : K} (hz : z ≠ 0)
    (turn : Turn) : phaseOfTurn z (reverseTurn turn) * phaseOfTurn z turn = 1 := by
  cases turn
  · simp [phaseOfTurn, reverseTurn]
  · simp [phaseOfTurn, reverseTurn, hz]
  · simp [phaseOfTurn, reverseTurn, hz]

end Ising2DLambda.NecSuf.KacWard
