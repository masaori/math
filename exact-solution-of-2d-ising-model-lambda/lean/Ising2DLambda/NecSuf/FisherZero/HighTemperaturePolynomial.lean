/-
同じ有限和を二通りに計算し、非零な共通因子を消去する段の必要十分版。
具体的な格子・スピン・多項式展開を外すと、可換環の整域性だけが残る。
-/
import Mathlib.Algebra.Ring.Regular

namespace Ising2DLambda.NecSuf.FisherZero

/-- `claim_high_temperature_polynomial_identity` の最後の二計算と消去の必要十分版。 -/
theorem common_sum_two_evaluations_necSuf {R : Type*} [CommRing R] [IsDomain R]
    (c z h common : R) (hc : c ≠ 0)
    (hleft : common = c * (c * z)) (hright : common = c * h) :
    c * z = h := by
  have hcommon : c * (c * z) = c * h := hleft.symm.trans hright
  exact mul_left_cancel₀ hc hcommon

end Ising2DLambda.NecSuf.FisherZero
