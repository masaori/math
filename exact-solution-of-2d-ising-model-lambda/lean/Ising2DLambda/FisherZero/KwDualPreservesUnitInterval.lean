/-
「双対変換は零と一の間の有理数を保つ」の具体版。
人手証明と同じく、有理数の逆元 t を取り、値の有理数性・正値性・1 未満を
三つの鎖で示す。住処は Q と Qbar であり、R / C は現れない。
-/
import Ising2DLambda.FisherZero.KwDualTransformDomain

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `def_unit_interval_rationals` の具体版。 -/
def unitIntervalRationals : Set ℚ := Set.Ioo 0 1

/-- 有理数の中で計算した双対変換の値。 -/
def kwDualRational (q : ℚ) : ℚ := (1 - q) * (1 + q)⁻¹

/-- `claim_kw_dual_preserves_unit_interval` の具体版。 -/
theorem kwDualTransform_preservesUnitInterval
    {q : ℚ} (hq : q ∈ unitIntervalRationals) :
    kwDualRational q ∈ unitIntervalRationals ∧
      kwDualTransform (algebraMap ℚ Qbar q) = algebraMap ℚ Qbar (kwDualRational q) := by
  rcases hq with ⟨hqPositive, hqLtOne⟩
  have hOnePlusPositive : 0 < 1 + q := by linarith
  have hOnePlusNe : 1 + q ≠ 0 := ne_of_gt hOnePlusPositive
  let t : ℚ := (1 + q)⁻¹
  have hInverse : (1 + q) * t = 1 := by
    dsimp [t]
    exact mul_inv_cancel₀ hOnePlusNe
  have hTPositive : 0 < t := by
    dsimp [t]
    exact inv_pos.mpr hOnePlusPositive
  have hOneMinusPositive : 0 < 1 - q := by linarith
  have hOneMinusLtOnePlus : 1 - q < 1 + q := by linarith
  have hValue : kwDualRational q = (1 - q) * t := by rfl
  have hValuePositive : 0 < kwDualRational q := by
    calc
      0 < (1 - q) * t := mul_pos hOneMinusPositive hTPositive
      _ = kwDualRational q := hValue.symm
  have hValueLtOne : kwDualRational q < 1 := by
    calc
      kwDualRational q = (1 - q) * t := hValue
      _ < (1 + q) * t := mul_lt_mul_of_pos_right hOneMinusLtOnePlus hTPositive
      _ = 1 := hInverse
  constructor
  · exact ⟨hValuePositive, hValueLtOne⟩
  · simp [kwDualTransform, kwDualRational]

end Ising2DLambda.FisherZero
