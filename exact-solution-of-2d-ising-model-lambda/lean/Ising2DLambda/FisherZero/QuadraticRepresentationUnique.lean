/-
「二次体の表示の一意性」の具体版。
人手証明と同じく係数の差 α, β を置き、十四段の等式列で α + βs = 0 を得て
一と s の一次独立性を適用し、二本の六段の等式列で元の係数の等号へ戻す。
-/
import Ising2DLambda.FisherZero.OneSLinearlyIndependent

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `claim_quadratic_representation_unique` の具体版。 -/
theorem quadraticRepresentationUnique
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2)
    (a b a' b' : ℚ)
    (hab : algebraMap ℚ Qbar a + algebraMap ℚ Qbar b * s =
      algebraMap ℚ Qbar a' + algebraMap ℚ Qbar b' * s) :
    a = a' ∧ b = b' := by
  let α : ℚ := a + (-a')
  let β : ℚ := b + (-b')
  have hzero : algebraMap ℚ Qbar α + algebraMap ℚ Qbar β * s = 0 := by
    calc
      algebraMap ℚ Qbar α + algebraMap ℚ Qbar β * s =
          (algebraMap ℚ Qbar a + (-(algebraMap ℚ Qbar a'))) +
            (algebraMap ℚ Qbar b + (-(algebraMap ℚ Qbar b'))) * s := by
              rw [show α = a + (-a') by rfl, show β = b + (-b') by rfl,
                map_add, map_neg, map_add, map_neg]
      _ = (algebraMap ℚ Qbar a + (-(algebraMap ℚ Qbar a'))) +
            (algebraMap ℚ Qbar b * s + (-(algebraMap ℚ Qbar b')) * s) := by
              rw [add_mul]
      _ = algebraMap ℚ Qbar a +
            ((-(algebraMap ℚ Qbar a')) +
              (algebraMap ℚ Qbar b * s + (-(algebraMap ℚ Qbar b')) * s)) := by
              rw [add_assoc]
      _ = algebraMap ℚ Qbar a +
            ((algebraMap ℚ Qbar b * s + (-(algebraMap ℚ Qbar b')) * s) +
              (-(algebraMap ℚ Qbar a'))) := by
              rw [add_comm (-(algebraMap ℚ Qbar a'))]
      _ = algebraMap ℚ Qbar a +
            (algebraMap ℚ Qbar b * s +
              ((-(algebraMap ℚ Qbar b')) * s + (-(algebraMap ℚ Qbar a')))) := by
              rw [add_assoc]
      _ = (algebraMap ℚ Qbar a + algebraMap ℚ Qbar b * s) +
            ((-(algebraMap ℚ Qbar b')) * s + (-(algebraMap ℚ Qbar a'))) := by
              rw [add_assoc]
      _ = (algebraMap ℚ Qbar a' + algebraMap ℚ Qbar b' * s) +
            ((-(algebraMap ℚ Qbar b')) * s + (-(algebraMap ℚ Qbar a'))) := by
              rw [hab]
      _ = algebraMap ℚ Qbar a' +
            (algebraMap ℚ Qbar b' * s +
              ((-(algebraMap ℚ Qbar b')) * s + (-(algebraMap ℚ Qbar a')))) := by
              rw [add_assoc]
      _ = algebraMap ℚ Qbar a' +
            ((algebraMap ℚ Qbar b' * s + (-(algebraMap ℚ Qbar b')) * s) +
              (-(algebraMap ℚ Qbar a'))) := by
              rw [add_assoc]
      _ = algebraMap ℚ Qbar a' +
            ((algebraMap ℚ Qbar b' + (-(algebraMap ℚ Qbar b'))) * s +
              (-(algebraMap ℚ Qbar a'))) := by
              rw [add_mul]
      _ = algebraMap ℚ Qbar a' + (0 * s + (-(algebraMap ℚ Qbar a'))) := by
              rw [add_neg_cancel]
      _ = algebraMap ℚ Qbar a' + (0 + (-(algebraMap ℚ Qbar a'))) := by
              rw [zero_mul]
      _ = algebraMap ℚ Qbar a' + (-(algebraMap ℚ Qbar a')) := by
              rw [zero_add]
      _ = 0 := by rw [add_neg_cancel]
  have hcoeff : α = 0 ∧ β = 0 := oneSLinearlyIndependent s hs α β hzero
  constructor
  · calc
      a = a + 0 := by rw [add_zero]
      _ = a + ((-a') + a') := by rw [neg_add_cancel]
      _ = (a + (-a')) + a' := by rw [add_assoc]
      _ = α + a' := by rfl
      _ = 0 + a' := by rw [hcoeff.1]
      _ = a' := by rw [zero_add]
  · calc
      b = b + 0 := by rw [add_zero]
      _ = b + ((-b') + b') := by rw [neg_add_cancel]
      _ = (b + (-b')) + b' := by rw [add_assoc]
      _ = β + b' := by rfl
      _ = 0 + b' := by rw [hcoeff.2]
      _ = b' := by rw [zero_add]

end Ising2DLambda.FisherZero
