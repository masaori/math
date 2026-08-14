/-
「正錐と乗法の両立」の具体版。
本文と同じく、二元の表示の条件九通りを場合分けし、六つの符号場合の補題と
表示の各成分の乗法の可換則による転送で正錐への所属を得る。
-/
import Ising2DLambda.FisherZero.QuadraticPositiveMulNonnegative
import Ising2DLambda.FisherZero.QuadraticPositiveMulNonnegativeNegativeSecond
import Ising2DLambda.FisherZero.QuadraticPositiveMulNonnegativeNegativeFirst
import Ising2DLambda.FisherZero.QuadraticPositiveMulNegativeSecondNegativeSecond
import Ising2DLambda.FisherZero.QuadraticPositiveMulNegativeFirstNegativeFirst
import Ising2DLambda.FisherZero.QuadraticPositiveMulMixedSigns

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 本文の「転送」: 表示の各成分の乗法の可換則により、
`ηξ` の正錐への所属から `ξη` の所属を得る。 -/
theorem quadraticPositiveCone_mul_transfer
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2)
    (xi eta : QuadraticFieldElement s)
    (h : quadraticMulElement s hs eta xi ∈ quadraticPositiveCone s) :
    quadraticMulElement s hs xi eta ∈ quadraticPositiveCone s := by
  change quadraticCoefficientPositive
    (quadraticRepresentation s (quadraticMulElement s hs xi eta))
  change quadraticCoefficientPositive
    (quadraticRepresentation s (quadraticMulElement s hs eta xi)) at h
  -- 本文の鎖: rep(ξη) = (aa'+2bb', ab'+ba') = (a'a+2b'b, a'b+b'a) = rep(ηξ)
  rw [quadraticRepresentation_mul s hs xi eta]
  rw [quadraticRepresentation_mul s hs eta xi] at h
  rw [mul_comm (quadraticRepresentation s xi).1 (quadraticRepresentation s eta).1,
    mul_comm (quadraticRepresentation s xi).2 (quadraticRepresentation s eta).2,
    mul_comm (quadraticRepresentation s xi).1 (quadraticRepresentation s eta).2,
    mul_comm (quadraticRepresentation s xi).2 (quadraticRepresentation s eta).1,
    add_comm ((quadraticRepresentation s eta).2 * (quadraticRepresentation s xi).1)
      ((quadraticRepresentation s eta).1 * (quadraticRepresentation s xi).2)]
  exact h

/-- `claim_quadratic_positive_cone_mul_closed` の具体版。
本文と同じ九通りの場合分けで、六補題と転送を当てる。 -/
theorem quadraticPositiveCone_mul_mem
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2)
    (xi eta : QuadraticFieldElement s)
    (hxi : xi ∈ quadraticPositiveCone s)
    (heta : eta ∈ quadraticPositiveCone s) :
    quadraticMulElement s hs xi eta ∈ quadraticPositiveCone s := by
  have hxi' : quadraticCoefficientPositive (quadraticRepresentation s xi) := hxi
  have heta' : quadraticCoefficientPositive (quadraticRepresentation s eta) := heta
  rcases hxi' with hxi1 | hxi2 | hxi3
  · rcases heta' with heta1 | heta2 | heta3
    · exact quadraticPositive_mul_of_nonnegativeCoefficients s hs xi eta hxi1 heta1
    · exact quadraticPositive_mul_of_nonnegative_negativeSecond s hs xi eta hxi1 heta2
    · exact quadraticPositive_mul_of_nonnegative_negativeFirst s hs xi eta hxi1 heta3
  · rcases heta' with heta1 | heta2 | heta3
    · exact quadraticPositiveCone_mul_transfer s hs xi eta
        (quadraticPositive_mul_of_nonnegative_negativeSecond s hs eta xi heta1 hxi2)
    · exact quadraticPositive_mul_of_negativeSecond_negativeSecond s hs xi eta hxi2 heta2
    · exact quadraticPositive_mul_of_mixedSigns s hs xi eta hxi2 heta3
  · rcases heta' with heta1 | heta2 | heta3
    · exact quadraticPositiveCone_mul_transfer s hs xi eta
        (quadraticPositive_mul_of_nonnegative_negativeFirst s hs eta xi heta1 hxi3)
    · exact quadraticPositiveCone_mul_transfer s hs xi eta
        (quadraticPositive_mul_of_mixedSigns s hs eta xi heta2 hxi3)
    · exact quadraticPositive_mul_of_negativeFirst_negativeFirst s hs xi eta hxi3 heta3

end Ising2DLambda.FisherZero
