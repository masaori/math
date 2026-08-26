import Ising3DCut.LimitQuantity.NumeratorDividesTwiceThresholdBoxValueMinusOne
import Ising3DCut.NecSuf.NumeratorDividesTwiceThresholdBoxValueMinusOne

namespace Ising3DCut.LimitQuantity

/-- `numerator_divides_twice_threshold_box_value_minus_one` を必要十分版から導いた版。 -/
theorem numerator_divides_twice_threshold_box_value_minus_one_viaNecSuf
    {a c n Z : ℕ} (hc : 1 ≤ c)
    (hdvd : a ∣ 2 * (c - 1)) (hZ : Z = c ^ n) :
    a ∣ 2 * (Z - 1) := by
  apply Ising3DCut.NecSuf.relation_of_relation_preserving_map_and_target_equality
      (fun x y : ℕ => x ∣ y) (fun x : ℕ => 2 * x)
      a (c - 1) (c ^ n - 1) (2 * (Z - 1))
  · exact hdvd
  · exact pred_dvd_pow_sub_one hc n
  · intro x y hxy
    exact mul_dvd_mul_left 2 hxy
  · intro x y z hxy hyz
    exact hxy.trans hyz
  · rw [hZ]

end Ising3DCut.LimitQuantity
