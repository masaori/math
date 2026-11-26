/-
章「離散 Whitney 系: トーラス上の閉歩道の回転数」の四を法とする剰余類への射影
`def_direction_residue_projection` の具体版。閉歩道の循環総回転数が 4 の倍数であることの具体版は、
実際の向き付き辺列について `WalkDirectionDifference.lean` に置く。
住処: ℤ と ℤ/4ℤ。ℝ / ℂ は現れない。
-/
import Ising2DLambda.KacWard.Turn
import Mathlib.Data.ZMod.Basic

namespace Ising2DLambda.KacWard

/-- `def_direction_residue_projection`。整数の四を法とする剰余類。 -/
def directionResidueProjection (n : ℤ) : ZMod 4 := n

theorem directionResidueProjection_add (a b : ℤ) :
    directionResidueProjection (a + b) =
      directionResidueProjection a + directionResidueProjection b := by
  simp [directionResidueProjection]

end Ising2DLambda.KacWard
