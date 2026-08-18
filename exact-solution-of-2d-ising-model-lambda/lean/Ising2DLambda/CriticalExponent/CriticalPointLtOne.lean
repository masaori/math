/-
人手証明 `claim_critical_point_lt_one` の具体版。

  人手証明                                                    このファイル
  第 5 条件で s = w*w                                           `data.sqrtTwo_square`
  w*w + 1*1 = v*v                                               `realClosed_sum_of_two_squares_is_square`
  v = 0 なら二平方和の零性から 1 = 0                           `realClosed_sq_add_sq_eq_zero`
  u := w*v⁻¹ ≠ 0（体は零因子を持たない）                        `mul_ne_zero`
  1 - x_c = u*u を体の四則で導く                                `one_sub_criticalPoint_eq_square`
  u ≠ 0 を狭義順序の定義へ当てる                                結論

住処: Qbar。実数体・複素数体は現れない。
-/
import Ising2DLambda.FisherZero.DistanceSquaredToCriticalPoint
import Ising2DLambda.FisherZero.RealClosedSumOfTwoSquaresIsSquare
import Ising2DLambda.FisherZero.RealClosedSumOfTwoSquaresZero
import Mathlib.Tactic.FieldSimp

namespace Ising2DLambda.CriticalExponent

open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.FisherZero

private theorem one_sub_criticalPoint_eq_square
    (data : RealClosedSubfieldSqrtTwoData s) (hs : s * s = 2) :
    ∃ u : data.toRealClosedSubfieldData.carrier,
      u ≠ 0 ∧
      (1 : data.toRealClosedSubfieldData.carrier) -
        criticalPointRealClosed data.toRealClosedSubfieldData s hs = u * u := by
  let base := data.toRealClosedSubfieldData
  obtain ⟨w, hw0, hsw⟩ := data.sqrtTwo_square
  obtain ⟨v, hv⟩ := realClosed_sum_of_two_squares_is_square base w 1
  have hv0 : v ≠ 0 := by
    intro hvZero
    have hsumQ : (w : Qbar) * (w : Qbar) + (1 : Qbar) * (1 : Qbar) = 0 := by
      have hcast := congrArg (fun z : base.carrier => (z : Qbar)) hv
      push_cast at hcast
      rw [hvZero] at hcast
      simpa using hcast
    exact one_ne_zero (realClosed_sq_add_sq_eq_zero base w 1 hsumQ).2
  let xc := criticalPointRealClosed base s hs
  have hxc : xc = -1 + w * w := by
    apply Subtype.ext
    rw [criticalPointRealClosed_val]
    push_cast
    rw [← hsw]
  have hsCarrier : (w * w) * (w * w) = (1 + 1 : base.carrier) := by
    apply Subtype.ext
    push_cast
    rw [← hsw]
    norm_num
    exact hs
  have hsv : w * w + 1 = v * v := by simpa using hv
  -- (2 - w*w) * (v*v) = w*w （人手証明の展開・s*s=2 の代入・加法の三行に対応）
  have hkey : ((2 : base.carrier) - w * w) * (v * v) = w * w := by
    rw [← hsv]
    calc
      ((2 : base.carrier) - w * w) * (w * w + 1)
          = 2 * (w * w) + 2 - (w * w) * (w * w) - w * w := by ring
      _ = 2 * (w * w) + 2 - (1 + 1) - w * w := by rw [hsCarrier]
      _ = w * w := by ring
  refine ⟨w * v⁻¹, mul_ne_zero hw0 (inv_ne_zero hv0), ?_⟩
  change (1 : base.carrier) - xc = w * v⁻¹ * (w * v⁻¹)
  rw [hxc]
  have hsub : (1 : base.carrier) - (-1 + w * w) = 2 - w * w := by ring
  rw [hsub, eq_comm]
  calc
    w * v⁻¹ * (w * v⁻¹) = (w * w) * (v⁻¹ * v⁻¹) := by ring
    _ = (((2 : base.carrier) - w * w) * (v * v)) * (v⁻¹ * v⁻¹) := by rw [hkey]
    _ = ((2 : base.carrier) - w * w) * ((v * v⁻¹) * (v * v⁻¹)) := by ring
    _ = ((2 : base.carrier) - w * w) * ((1 : base.carrier) * 1) := by
          rw [mul_inv_cancel₀ hv0]
    _ = (2 : base.carrier) - w * w := by ring

/-- 臨界点は実閉部分体の狭義順序で乗法単位元より小さい。 -/
theorem criticalPoint_lt_one
    (data : RealClosedSubfieldSqrtTwoData s) (hs : s * s = 2) :
    realAlgebraicLt data.toRealClosedSubfieldData
      (criticalPointRealClosed data.toRealClosedSubfieldData s hs) 1 := by
  obtain ⟨u, hu0, hu⟩ := one_sub_criticalPoint_eq_square data hs
  exact ⟨u, hu0, hu⟩

end Ising2DLambda.CriticalExponent
