/- `claim_kw_dual_preserves_unit_interval` の具体版を必要十分版から導く。 -/
import Ising2DLambda.FisherZero.KwDualPreservesUnitInterval
import Ising2DLambda.NecSuf.FisherZero.KwDualPreservesUnitInterval

namespace Ising2DLambda.FisherZero

/-- 有理数内の双対変換の保存則を必要十分版の特殊化として得る。 -/
theorem kwDualTransform_preservesUnitInterval_from_necSuf
    {q : ℚ} (hq : q ∈ unitIntervalRationals) :
    kwDualRational q ∈ unitIntervalRationals := by
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
  have hCore := Ising2DLambda.NecSuf.FisherZero.kw_dual_preserves_unit_interval_necSuf
    (carrier := fun x : ℚ => x ∈ Set.univ)
    (lt := (· < ·)) (zero := 0) (one := 1)
    (oneMinus := 1 - q) (onePlus := 1 + q) (t := t)
    (value := kwDualRational q) (mul := (· * ·))
    (by simp) (by simp) (by intro; intro; simp)
    (by rfl) hOneMinusPositive hTPositive mul_pos
    hOneMinusLtOnePlus mul_lt_mul_of_pos_right hInverse
  exact ⟨hCore.2.1, hCore.2.2⟩

end Ising2DLambda.FisherZero
