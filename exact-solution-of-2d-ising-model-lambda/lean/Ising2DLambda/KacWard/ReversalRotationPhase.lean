/-
章「トーラス上の Kac--Ward 行列式」の「反転辺対の回転位相の積は 1」
（`claim_reversal_rotation_phase_product`）の具体版。

人手証明の直進・左回転・右回転の三場合と同じ場合分けで、
逆順の辺対では回転の向きが逆になることを使う。
-/
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnity
import Ising2DLambda.NecSuf.KacWard.ReversalRotationPhase

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.NecSuf.KacWard

/-- 人手証明の三つの場合。回転差に応じた位相と、逆順・反転後の位相の積は 1。 -/
theorem reversal_rotation_phase_product {z : Qbar} (hz4 : z ^ 4 = -1)
    (turn : Turn) : phaseOfTurn z (reverseTurn turn) * phaseOfTurn z turn = 1 := by
  have hz : z ≠ 0 := by
    intro hzero
    have hpow : z ^ 4 = 0 := by simp [hzero]
    rw [hpow] at hz4
    norm_num at hz4
  exact reverse_phase_mul_necSuf hz turn

/-- 具体版が必要十分版の特殊化として得られることの記録。 -/
theorem reversal_rotation_phase_product_from_necSuf {z : Qbar} (hz : z ≠ 0)
    (turn : Turn) : phaseOfTurn z (reverseTurn turn) * phaseOfTurn z turn = 1 :=
  reverse_phase_mul_necSuf hz turn

end Ising2DLambda.KacWard
