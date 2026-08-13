/-
「一と s の一次独立性」の論理的な手順だけを残した必要十分版。
係数体から値の体への単射環準同型、s² = 2、および係数体に平方が 2 の元が
無いことだけを要求する。代数閉性・順序・可算性は使わない。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.FisherZero

/-- 非有理性の背理法と、残った係数の消去に必要な構造だけを要求する。 -/
theorem one_s_linearly_independent_necSuf
    {A K : Type} [Field A] [Field K] (embed : A →+* K)
    (hNoSquareTwo : ∀ q : A, q * q ≠ 2)
    (s : K) (hs : s * s = embed 2)
    (a b : A) (hab : embed a + embed b * s = 0) :
    a = 0 ∧ b = 0 := by
  have hb : b = 0 := by
    by_contra hbne
    let r : A := b⁻¹ * (-a)
    have hbs : embed b * s = -(embed a) := by
      calc
        embed b * s = 0 + embed b * s := by rw [zero_add]
        _ = (-embed a + embed a) + embed b * s := by rw [neg_add_cancel, zero_add]
        _ = -embed a + (embed a + embed b * s) := by rw [add_assoc]
        _ = -embed a + 0 := by rw [hab]
        _ = -embed a := by rw [add_zero]
    have hsr : s = embed r := by
      calc
        s = 1 * s := by rw [one_mul]
        _ = (embed (b⁻¹) * embed b) * s := by rw [← map_mul, inv_mul_cancel₀ hbne, map_one]
        _ = embed (b⁻¹) * (embed b * s) := by rw [mul_assoc]
        _ = embed (b⁻¹) * (-embed a) := by rw [hbs]
        _ = embed (b⁻¹ * (-a)) := by rw [map_mul, map_neg]
        _ = embed r := rfl
    apply hNoSquareTwo r
    apply RingHom.injective embed
    calc
      embed (r * r) = embed r * embed r := by rw [map_mul]
      _ = s * s := by rw [hsr]
      _ = embed 2 := hs
  constructor
  · apply RingHom.injective embed
    calc
      embed a = embed a + 0 := by rw [add_zero]
      _ = embed a + 0 * s := by rw [zero_mul]
      _ = embed a + embed b * s := by rw [hb, map_zero]
      _ = 0 := hab
      _ = embed 0 := by rw [map_zero]
  · exact hb

end Ising2DLambda.NecSuf.FisherZero
