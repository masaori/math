import Mathlib.Tactic

/-!
必要十分版: 各出発位置の回転数と境界頂点の局所回転数の対応。

具体版 `vertexSimpleWalk_stepTurning_eq_boundary_turn_left` /
`vertexSimpleWalk_stepTurning_eq_neg_boundary_turn_right` と同じ手順
（一歩の回転数を方向対の回転数へ移す → 入方向を書き換える → 出方向を書き換える）を、
方向の住処を任意の加法群 `G`、方向対の回転数を任意の写像 `pairTurn : G → G → ℤ` に上げて述べる。
-/

namespace Ising2DLambda.NecSuf.KacWard

/-- Interior on the left. Only the step-to-pair identity and the two direction
matches are used; nothing about the shape of `pairTurn` is needed. -/
theorem boundary_turn_match_left
    {I G : Type*} (next : I → I) (direction : I → G)
    (stepTurn : I → ℤ) (pairTurn : G → G → ℤ) (incoming outgoing : I → G)
    (hstep : ∀ j, stepTurn j = pairTurn (direction j) (direction (next j)))
    (hin : ∀ j, direction j = incoming j)
    (hout : ∀ j, direction (next j) = outgoing j)
    (j : I) :
    stepTurn j = pairTurn (incoming j) (outgoing j) := by
  calc
    stepTurn j = pairTurn (direction j) (direction (next j)) := hstep j
    _ = pairTurn (incoming j) (direction (next j)) := by rw [hin j]
    _ = pairTurn (incoming j) (outgoing j) := by rw [hout j]

/-- Interior on the right. The reversal law `hrev` of the pair turn is needed:
without it the table directions (shifted by `c` and swapped) say nothing about the turn. -/
theorem boundary_turn_match_right
    {I G : Type*} [Add G] (c : G) (next : I → I) (direction : I → G)
    (stepTurn : I → ℤ) (pairTurn : G → G → ℤ) (incoming outgoing : I → G)
    (hrev : ∀ a b, pairTurn (b + c) (a + c) = -pairTurn a b)
    (hstep : ∀ j, stepTurn j = pairTurn (direction j) (direction (next j)))
    (hin : ∀ j, direction (next j) + c = incoming j)
    (hout : ∀ j, direction j + c = outgoing j)
    (j : I) :
    stepTurn j = -pairTurn (incoming j) (outgoing j) := by
  calc
    stepTurn j = pairTurn (direction j) (direction (next j)) := hstep j
    _ = -pairTurn (direction (next j) + c) (direction j + c) := by
      rw [hrev, neg_neg]
    _ = -pairTurn (incoming j) (direction j + c) := by rw [hin j]
    _ = -pairTurn (incoming j) (outgoing j) := by rw [hout j]

end Ising2DLambda.NecSuf.KacWard
