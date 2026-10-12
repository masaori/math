/-
「正錐と乗法の両立」の具体版。
本文と同じく、二元の表示の条件九通りを場合分けし、六つの符号場合の補題と
表示の各積の乗法の可換則と第二係数の加法の可換則による転送で正錐への所属を得る。
-/
import Ising2DLambda.FisherZero.QuadraticPositiveMulNonnegative
import Ising2DLambda.FisherZero.QuadraticPositiveMulNonnegativeNegativeSecond
import Ising2DLambda.FisherZero.QuadraticPositiveMulNonnegativeNegativeFirst
import Ising2DLambda.FisherZero.QuadraticPositiveMulNegativeSecondNegativeSecond
import Ising2DLambda.FisherZero.QuadraticPositiveMulNegativeFirstNegativeFirst
import Ising2DLambda.FisherZero.QuadraticPositiveMulMixedSigns

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 本文の「転送」: 表示の各積の乗法の可換則と第二係数の加法の可換則により、
`η*ξ` の正錐への所属から `ξ*η` の所属を得る。 -/
theorem quadraticPositiveCone_mul_transfer
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2)
    (xi eta : QuadraticFieldElement s)
    (h : quadraticMulElement s hs eta xi ∈ quadraticPositiveCone s) :
    quadraticMulElement s hs xi eta ∈ quadraticPositiveCone s := by
  let a : ℚ := (quadraticRepresentation s xi).1
  let b : ℚ := (quadraticRepresentation s xi).2
  let a' : ℚ := (quadraticRepresentation s eta).1
  let b' : ℚ := (quadraticRepresentation s eta).2
  have hrep : quadraticRepresentation s (quadraticMulElement s hs xi eta) =
      quadraticRepresentation s (quadraticMulElement s hs eta xi) := by
    calc
      quadraticRepresentation s (quadraticMulElement s hs xi eta) =
          (a * a' + 2 * (b * b'), a * b' + b * a') :=
        quadraticRepresentation_mul s hs xi eta
      _ = (a' * a + 2 * (b' * b), b' * a + a' * b) := by
        rw [mul_comm a a', mul_comm b b', mul_comm a b', mul_comm b a']
      _ = (a' * a + 2 * (b' * b), a' * b + b' * a) :=
        congrArg (fun z : ℚ => (a' * a + 2 * (b' * b), z))
          (add_comm (b' * a) (a' * b))
      _ = quadraticRepresentation s (quadraticMulElement s hs eta xi) :=
        (quadraticRepresentation_mul s hs eta xi).symm
  change quadraticCoefficientPositive
    (quadraticRepresentation s (quadraticMulElement s hs xi eta))
  change quadraticCoefficientPositive
    (quadraticRepresentation s (quadraticMulElement s hs eta xi)) at h
  exact hrep.symm ▸ h

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
    · -- ともに非負係数条件
      exact quadraticPositive_mul_of_nonnegativeCoefficients s hs xi eta hxi1 heta1
    · -- 非負係数条件と負の第二係数条件
      exact quadraticPositive_mul_of_nonnegative_negativeSecond s hs xi eta hxi1 heta2
    · -- 非負係数条件と負の第一係数条件
      exact quadraticPositive_mul_of_nonnegative_negativeFirst s hs xi eta hxi1 heta3
  · rcases heta' with heta1 | heta2 | heta3
    · -- 負の第二係数条件と非負係数条件: 役割を入れ替えて転送
      have hrev := quadraticPositive_mul_of_nonnegative_negativeSecond s hs eta xi heta1 hxi2
      exact quadraticPositiveCone_mul_transfer s hs xi eta hrev
    · -- ともに負の第二係数条件
      exact quadraticPositive_mul_of_negativeSecond_negativeSecond s hs xi eta hxi2 heta2
    · -- 負の第二係数条件と負の第一係数条件
      exact quadraticPositive_mul_of_mixedSigns s hs xi eta hxi2 heta3
  · rcases heta' with heta1 | heta2 | heta3
    · -- 負の第一係数条件と非負係数条件: 役割を入れ替えて転送
      have hrev := quadraticPositive_mul_of_nonnegative_negativeFirst s hs eta xi heta1 hxi3
      exact quadraticPositiveCone_mul_transfer s hs xi eta hrev
    · -- 負の第一係数条件と負の第二係数条件: 役割を入れ替えて転送
      have hrev := quadraticPositive_mul_of_mixedSigns s hs eta xi heta2 hxi3
      exact quadraticPositiveCone_mul_transfer s hs xi eta hrev
    · -- ともに負の第一係数条件
      exact quadraticPositive_mul_of_negativeFirst_negativeFirst s hs xi eta hxi3 heta3

end Ising2DLambda.FisherZero
