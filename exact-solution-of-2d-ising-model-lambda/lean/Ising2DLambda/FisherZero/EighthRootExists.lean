/-
「代数的数には四乗が負の単位元になる元がある」（ラベル `claim_eighth_root_exists`）の具体版。
人手証明と同じく、二の平方根 `s`（`claim_sqrt_two_exists`）と虚数単位 `ω`（`claim_imaginary_unit_exists`）を取り、
`s ≠ 0` から逆元 `s⁻¹` を作って `ζ := (1 + ω) · s⁻¹` と置く。
準備の十一段で `ζ · ζ = ω` を示し、主張の左辺 `ζ⁴` から七段で `-1` へ着く。
住処は Qbar であり、R / C は現れない。
-/
import Ising2DLambda.FisherZero.SqrtTwoExists
import Ising2DLambda.FisherZero.ImaginaryUnitExists

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `claim_eighth_root_exists` の具体版。 -/
theorem eighthRoot_exists : ∃ zeta : Qbar, zeta ^ 4 = -1 := by
  -- 準備: 二の平方根と虚数単位。
  obtain ⟨s, hs⟩ := sqrtTwo_exists
  obtain ⟨omega, homega⟩ := imaginaryUnit_exists
  -- 準備: `s = 0` なら `s · s = 0` で `2 ≠ 0` に反する。
  have hsNe : s ≠ 0 := by
    intro hs0
    have h20 : (2 : Qbar) = 0 := by
      calc (2 : Qbar) = s * s := hs.symm
        _ = 0 * 0 := by rw [hs0]
        _ = 0 := mul_zero 0
    exact two_ne_zero h20
  -- 準備: 体の逆元。
  have hsInv : s * s⁻¹ = 1 := mul_inv_cancel₀ hsNe
  -- 準備の十一段: `ζ · ζ = ω`。
  have hSq : ((1 + omega) * s⁻¹) * ((1 + omega) * s⁻¹) = omega := by
    calc ((1 + omega) * s⁻¹) * ((1 + omega) * s⁻¹)
        = ((1 + omega) * (1 + omega)) * (s⁻¹ * s⁻¹) := by
          -- 積の可換則と結合則
          rw [mul_mul_mul_comm]
      _ = (1 * 1 + 1 * omega + (omega * 1 + omega * omega)) * (s⁻¹ * s⁻¹) := by
          -- 分配則
          rw [add_mul, mul_add, mul_add, add_assoc]
      _ = (1 + omega + (omega + omega * omega)) * (s⁻¹ * s⁻¹) := by
          -- 単位元との積
          rw [one_mul, one_mul, mul_one]
      _ = (1 + omega + (omega + -1)) * (s⁻¹ * s⁻¹) := by
          -- `ω · ω = -1`
          rw [homega]
      _ = (omega + omega + (1 + -1)) * (s⁻¹ * s⁻¹) := by
          -- 加法の可換則と結合則
          abel_nf
      _ = (omega + omega) * (s⁻¹ * s⁻¹) := by
          -- `1 + (-1) = 0` と零元との和
          rw [add_neg_cancel, add_zero]
      _ = (omega * (1 + 1)) * (s⁻¹ * s⁻¹) := by
          -- 分配則と単位元との積
          rw [mul_add, mul_one]
      _ = (omega * 2) * (s⁻¹ * s⁻¹) := by
          -- `1 + 1 = 2`
          rw [one_add_one_eq_two]
      _ = (omega * (s * s)) * (s⁻¹ * s⁻¹) := by
          -- `s · s = 2`
          rw [hs]
      _ = omega * ((s * s⁻¹) * (s * s⁻¹)) := by
          -- 積の可換則と結合則
          rw [mul_assoc, mul_mul_mul_comm]
      _ = omega * (1 * 1) := by
          -- `s · s⁻¹ = 1`
          rw [hsInv]
      _ = omega := by
          -- 単位元との積
          rw [one_mul, mul_one]
  refine ⟨(1 + omega) * s⁻¹, ?_⟩
  -- 主張の左辺からの七段。
  calc ((1 + omega) * s⁻¹) ^ 4
      = ((1 + omega) * s⁻¹) ^ 3 * ((1 + omega) * s⁻¹) := pow_succ _ 3
    _ = (((1 + omega) * s⁻¹) ^ 2 * ((1 + omega) * s⁻¹)) * ((1 + omega) * s⁻¹) := by
        rw [pow_succ _ 2]
    _ = ((((1 + omega) * s⁻¹) ^ 1 * ((1 + omega) * s⁻¹)) * ((1 + omega) * s⁻¹)) *
          ((1 + omega) * s⁻¹) := by
        rw [pow_succ _ 1]
    _ = ((((1 + omega) * s⁻¹) * ((1 + omega) * s⁻¹)) * ((1 + omega) * s⁻¹)) *
          ((1 + omega) * s⁻¹) := by
        rw [pow_one]
    _ = (((1 + omega) * s⁻¹) * ((1 + omega) * s⁻¹)) *
          (((1 + omega) * s⁻¹) * ((1 + omega) * s⁻¹)) := by
        rw [mul_assoc]
    _ = omega * omega := by rw [hSq]
    _ = -1 := homega

end Ising2DLambda.FisherZero
