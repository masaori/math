/-
「双対変換の値は分母を零にしない」の必要十分版。

本文と同じ十一等号と、逆元が零なら 1 = 0 となる三等号を独立に証明する。
加法は可換群、乗法には右の零元との積と右分配則だけを要求する。
逆元は関数として全域に持たず、(1 + xi) * inverse = 1 を満たす一つの元で足りる。
零因子の消去は因子 1 + 1 にだけ必要であり、その条件を hCancelTwo に切り出す。
乗法の結合則・交換則・単位元の法則・体・代数閉性・標数零は使わない。
-/
import Mathlib.Algebra.Ring.Defs

namespace Ising2DLambda.NecSuf.FisherZero

universe u

/-- `claim_kw_dual_transform_domain` の証明手順を必要十分な仮定へ薄めた版。 -/
theorem kw_dual_transform_domain_necSuf
    {A : Type u} [AddCommGroup A] [One A] [Mul A] [RightDistribClass A]
    (xi inverse dualValue : A)
    (hDefinition : dualValue = (1 - xi) * inverse)
    (hInverse : (1 + xi) * inverse = 1)
    (hCancelTwo : ∀ b : A, (1 + 1) * b = 0 → b = 0)
    (hMulZero : ∀ a : A, a * 0 = 0)
    (hOne : (1 : A) ≠ 0) :
    1 + dualValue ≠ 0 := by
  -- 本文の準備。2 はここでは 1 + 1 の名前であり、自然数の埋め込みは不要。
  let two : A := 1 + 1
  have hCalculation : 1 + dualValue = two * inverse := by
    calc
      1 + dualValue = 1 + (1 - xi) * inverse := by rw [hDefinition]
      _ = (1 + xi) * inverse + (1 - xi) * inverse := by rw [hInverse]
      _ = ((1 + xi) + (1 - xi)) * inverse := by rw [← add_mul]
      _ = ((1 + xi) + (1 + (-xi))) * inverse := by rw [sub_eq_add_neg]
      _ = (1 + (xi + (1 + (-xi)))) * inverse := by
        rw [add_assoc 1 xi (1 + (-xi))]
      _ = (1 + ((xi + 1) + (-xi))) * inverse := by
        rw [← add_assoc xi 1 (-xi)]
      _ = (1 + ((1 + xi) + (-xi))) * inverse := by rw [add_comm xi 1]
      _ = (1 + (1 + (xi + (-xi)))) * inverse := by rw [add_assoc 1 xi (-xi)]
      _ = (1 + (1 + 0)) * inverse := by rw [add_neg_cancel]
      _ = (1 + 1) * inverse := by rw [add_zero]
      _ = two * inverse := rfl
  -- 本文の背理法。零因子の消去の後、逆元の等式を三等号で矛盾へ運ぶ。
  have hFinal : two * inverse ≠ 0 := by
    intro hZero
    have hInverseZero : inverse = 0 := hCancelTwo inverse hZero
    have hOneZero : (1 : A) = 0 := by
      calc
        1 = (1 + xi) * inverse := hInverse.symm
        _ = (1 + xi) * 0 := by rw [hInverseZero]
        _ = 0 := hMulZero _
    exact hOne hOneZero
  intro hZero
  apply hFinal
  calc
    two * inverse = 1 + dualValue := hCalculation.symm
    _ = 0 := hZero

end Ising2DLambda.NecSuf.FisherZero
