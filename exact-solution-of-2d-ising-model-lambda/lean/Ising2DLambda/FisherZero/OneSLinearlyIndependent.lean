/-
「一と s の一次独立性」の具体版。
人手証明と同じく、b が非零なら s が有理数 r = b⁻¹(-a) に等しくなり、
r² = 2 が有理数平方の非二性と矛盾することから b = 0、続いて a = 0 を得る。
-/
import Ising2DLambda.FisherZero.NoRationalSquareTwo
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnity

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `claim_one_s_linearly_independent` の具体版。 -/
theorem oneSLinearlyIndependent
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2)
    (a b : ℚ) (hab : algebraMap ℚ Qbar a + algebraMap ℚ Qbar b * s = 0) :
    a = 0 ∧ b = 0 := by
  have hb : b = 0 := by
    by_contra hbne
    let r : ℚ := b⁻¹ * (-a)
    have hbs : algebraMap ℚ Qbar b * s = -(algebraMap ℚ Qbar a) := by
      calc
        algebraMap ℚ Qbar b * s = 0 + algebraMap ℚ Qbar b * s := by rw [zero_add]
        _ = (-(algebraMap ℚ Qbar a) + algebraMap ℚ Qbar a) +
              algebraMap ℚ Qbar b * s := by rw [neg_add_cancel, zero_add]
        _ = -(algebraMap ℚ Qbar a) +
              (algebraMap ℚ Qbar a + algebraMap ℚ Qbar b * s) := by
                rw [add_assoc]
        _ = -(algebraMap ℚ Qbar a) + 0 := by rw [hab]
        _ = -(algebraMap ℚ Qbar a) := by rw [add_zero]
    have hsr : s = algebraMap ℚ Qbar r := by
      calc
        s = 1 * s := by rw [one_mul]
        _ = (algebraMap ℚ Qbar (b⁻¹) * algebraMap ℚ Qbar b) * s := by
              rw [← map_mul, inv_mul_cancel₀ hbne, map_one]
        _ = algebraMap ℚ Qbar (b⁻¹) * (algebraMap ℚ Qbar b * s) := by
              rw [mul_assoc]
        _ = algebraMap ℚ Qbar (b⁻¹) * (-(algebraMap ℚ Qbar a)) := by rw [hbs]
        _ = algebraMap ℚ Qbar (b⁻¹ * (-a)) := by rw [map_mul, map_neg]
        _ = algebraMap ℚ Qbar r := rfl
    have hrSquare : r * r = 2 := by
      apply (algebraMap ℚ Qbar).injective
      calc
        algebraMap ℚ Qbar (r * r) = algebraMap ℚ Qbar r * algebraMap ℚ Qbar r := by
          rw [map_mul]
        _ = s * s := by rw [hsr]
        _ = algebraMap ℚ Qbar 2 := hs
    exact noRationalSquareTwo r hrSquare
  constructor
  · apply (algebraMap ℚ Qbar).injective
    calc
      algebraMap ℚ Qbar a = algebraMap ℚ Qbar a + 0 := by rw [add_zero]
      _ = algebraMap ℚ Qbar a + 0 * s := by rw [zero_mul]
      _ = algebraMap ℚ Qbar a + algebraMap ℚ Qbar b * s := by rw [hb, map_zero]
      _ = 0 := hab
      _ = algebraMap ℚ Qbar 0 := by rw [map_zero]
  · exact hb

end Ising2DLambda.FisherZero
