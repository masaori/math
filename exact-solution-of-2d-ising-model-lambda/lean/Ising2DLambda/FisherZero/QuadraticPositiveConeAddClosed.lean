/-
「正錐と加法の両立」の具体版。
本文と同じく、二元の表示の条件九通りを場合分けし、六つの符号場合の補題と
表示の各成分の加法の可換則による転送で正錐への所属を得る。
-/
import Ising2DLambda.FisherZero.QuadraticPositiveAddNonnegative
import Ising2DLambda.FisherZero.QuadraticPositiveAddNonnegativeNegativeSecond
import Ising2DLambda.FisherZero.QuadraticPositiveAddNonnegativeNegativeFirst
import Ising2DLambda.FisherZero.QuadraticPositiveAddNegativeSecondNegativeSecond
import Ising2DLambda.FisherZero.QuadraticPositiveAddNegativeFirstNegativeFirst
import Ising2DLambda.FisherZero.QuadraticPositiveAddMixedSigns

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 本文の「転送」: 表示の各成分の加法の可換則により、
`η+ξ` の正錐への所属から `ξ+η` の所属を得る。 -/
theorem quadraticPositiveCone_add_transfer
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2)
    (xi eta : QuadraticFieldElement s)
    (h : quadraticAddElement s eta xi ∈ quadraticPositiveCone s) :
    quadraticAddElement s xi eta ∈ quadraticPositiveCone s := by
  change quadraticCoefficientPositive
    (quadraticRepresentation s (quadraticAddElement s xi eta))
  change quadraticCoefficientPositive
    (quadraticRepresentation s (quadraticAddElement s eta xi)) at h
  -- 本文の鎖: rep(ξ+η) = (a+a', b+b') = (a'+a, b'+b) = rep(η+ξ)
  rw [quadraticRepresentation_add s hs xi eta]
  rw [quadraticRepresentation_add s hs eta xi] at h
  rw [add_comm (quadraticRepresentation s xi).1 (quadraticRepresentation s eta).1,
    add_comm (quadraticRepresentation s xi).2 (quadraticRepresentation s eta).2]
  exact h

/-- `claim_quadratic_positive_cone_add_closed` の具体版。
本文と同じ九通りの場合分けで、六補題と転送を当てる。 -/
theorem quadraticPositiveCone_add_mem
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2)
    (xi eta : QuadraticFieldElement s)
    (hxi : xi ∈ quadraticPositiveCone s)
    (heta : eta ∈ quadraticPositiveCone s) :
    quadraticAddElement s xi eta ∈ quadraticPositiveCone s := by
  have hxi' : quadraticCoefficientPositive (quadraticRepresentation s xi) := hxi
  have heta' : quadraticCoefficientPositive (quadraticRepresentation s eta) := heta
  rcases hxi' with hxi1 | hxi2 | hxi3
  · rcases heta' with heta1 | heta2 | heta3
    · -- ともに非負係数条件
      exact quadraticPositive_add_of_nonnegativeCoefficients s hs xi eta hxi1 heta1
    · -- 非負係数条件と負の第二係数条件
      exact quadraticPositive_add_of_nonnegative_negativeSecond s hs xi eta hxi1 heta2
    · -- 非負係数条件と負の第一係数条件
      exact quadraticPositive_add_of_nonnegative_negativeFirst s hs xi eta hxi1 heta3
  · rcases heta' with heta1 | heta2 | heta3
    · -- 負の第二係数条件と非負係数条件: 役割を入れ替えて転送
      exact quadraticPositiveCone_add_transfer s hs xi eta
        (quadraticPositive_add_of_nonnegative_negativeSecond s hs eta xi heta1 hxi2)
    · -- ともに負の第二係数条件
      exact quadraticPositive_add_of_negativeSecond_negativeSecond s hs xi eta hxi2 heta2
    · -- 負の第二係数条件と負の第一係数条件
      exact quadraticPositive_add_of_mixedSigns s hs xi eta hxi2 heta3
  · rcases heta' with heta1 | heta2 | heta3
    · -- 負の第一係数条件と非負係数条件: 役割を入れ替えて転送
      exact quadraticPositiveCone_add_transfer s hs xi eta
        (quadraticPositive_add_of_nonnegative_negativeFirst s hs eta xi heta1 hxi3)
    · -- 負の第一係数条件と負の第二係数条件: 役割を入れ替えて転送
      exact quadraticPositiveCone_add_transfer s hs xi eta
        (quadraticPositive_add_of_mixedSigns s hs eta xi heta2 hxi3)
    · -- ともに負の第一係数条件
      exact quadraticPositive_add_of_negativeFirst_negativeFirst s hs xi eta hxi3 heta3

end Ising2DLambda.FisherZero
