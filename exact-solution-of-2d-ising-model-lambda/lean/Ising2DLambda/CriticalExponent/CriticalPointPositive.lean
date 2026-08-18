/-
人手証明 `claim_critical_point_positive` の具体版。

  人手証明                                                    このファイル
  第 5 条件で s = w*w                                           `data.sqrtTwo_square`
  w*w + 1*1 = v*v                                               `realClosed_sum_of_two_squares_is_square`
  v = 0 なら二平方和の零性から 1 = 0                           `realClosed_sq_add_sq_eq_zero`
  x_c = (v⁻¹)*(v⁻¹) を体の四則で導く                      `criticalPoint_eq_invSquare`
  v⁻¹ ≠ 0 を狭義順序の定義へ当てる                              結論

住処: Qbar。実数体・複素数体は現れない。
-/
import Ising2DLambda.FisherZero.DistanceSquaredToCriticalPoint
import Ising2DLambda.FisherZero.RealClosedSumOfTwoSquaresIsSquare
import Ising2DLambda.FisherZero.RealClosedSumOfTwoSquaresZero
import Mathlib.Tactic.FieldSimp

namespace Ising2DLambda.CriticalExponent

open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.FisherZero

private theorem criticalPoint_eq_invSquare
    (data : RealClosedSubfieldSqrtTwoData s) (hs : s * s = 2) :
    ∃ v : data.toRealClosedSubfieldData.carrier,
      v ≠ 0 ∧
      criticalPointRealClosed data.toRealClosedSubfieldData s hs = v⁻¹ * v⁻¹ := by
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
  refine ⟨v, hv0, ?_⟩
  change xc = v⁻¹ * v⁻¹
  rw [hxc]
  field_simp [hv0]
  simp only [pow_two]
  rw [← hsv]
  calc
    (-1 + w * w) * (w * w + 1) = (w * w) * (w * w) - 1 := by ring
    _ = (1 + 1) - 1 := by rw [hsCarrier]
    _ = 1 := by ring

/-- 臨界点は実閉部分体の狭義順序で零元より大きい。 -/
theorem criticalPoint_positive
    (data : RealClosedSubfieldSqrtTwoData s) (hs : s * s = 2) :
    realAlgebraicLt data.toRealClosedSubfieldData 0
      (criticalPointRealClosed data.toRealClosedSubfieldData s hs) := by
  obtain ⟨v, hv0, hxc⟩ := criticalPoint_eq_invSquare data hs
  exact ⟨v⁻¹, inv_ne_zero hv0, by simpa using hxc⟩

end Ising2DLambda.CriticalExponent
