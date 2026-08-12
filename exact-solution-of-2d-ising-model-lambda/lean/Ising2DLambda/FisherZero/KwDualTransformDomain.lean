/-
「双対変換の定義と、値が定義域に留まること」の具体版。
人手証明と同じく、双対変換を定義し、分配則の三段の鎖で
`1 + KW ξ = 2 * (1 + ξ)⁻¹` を得たあと、零因子の消去と逆元の等式で非零性を示す。
住処は Qbar であり、R / C は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarNoZeroDivisors

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `def_kw_dual_transform` の具体版。 -/
noncomputable def kwDualTransform (xi : Qbar) : Qbar :=
  (1 - xi) * (1 + xi)⁻¹

/-- `claim_kw_dual_transform_domain` の具体版。 -/
theorem kwDualTransform_domain {xi : Qbar} (hDomain : 1 + xi ≠ 0) :
    1 + kwDualTransform xi ≠ 0 := by
  -- 準備。人手証明で使う逆元の等式と、2 ≠ 0 を先に置く。
  have hInverse : (1 + xi) * (1 + xi)⁻¹ = 1 := mul_inv_cancel₀ hDomain
  have hTwo : (2 : Qbar) ≠ 0 := by norm_num
  have hCalculation :
      1 + kwDualTransform xi = 2 * (1 + xi)⁻¹ := by
    calc
      1 + kwDualTransform xi
          = 1 + (1 - xi) * (1 + xi)⁻¹ := rfl
      _ = (1 + xi) * (1 + xi)⁻¹ + (1 - xi) * (1 + xi)⁻¹ := by
        rw [hInverse]
      _ = ((1 + xi) + (1 - xi)) * (1 + xi)⁻¹ := by
        rw [← add_mul]
      _ = 2 * (1 + xi)⁻¹ := by ring
  have hFinal : 2 * (1 + xi)⁻¹ ≠ 0 := by
    intro hZero
    have hInverseZero : (1 + xi)⁻¹ = 0 :=
      AlgebraicEigenvalue.qbarNoZeroDivisors hTwo hZero
    have hOneZero : (1 : Qbar) = 0 := by
      calc
        1 = (1 + xi) * (1 + xi)⁻¹ := hInverse.symm
        _ = (1 + xi) * 0 := by rw [hInverseZero]
        _ = 0 := mul_zero _
    exact one_ne_zero hOneZero
  intro hZero
  apply hFinal
  calc
    2 * (1 + xi)⁻¹ = 1 + kwDualTransform xi := hCalculation.symm
    _ = 0 := hZero

end Ising2DLambda.FisherZero
