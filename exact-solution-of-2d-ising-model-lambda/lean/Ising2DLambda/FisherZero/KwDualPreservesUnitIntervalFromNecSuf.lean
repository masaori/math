/- `claim_kw_dual_preserves_unit_interval` の具体版を必要十分版から導く。 -/
import Ising2DLambda.FisherZero.KwDualPreservesUnitInterval
import Ising2DLambda.NecSuf.FisherZero.KwDualPreservesUnitInterval

namespace Ising2DLambda.FisherZero

/-- 有理数内の双対変換の保存則を必要十分版の特殊化として得る。 -/
theorem kwDualTransform_preservesUnitInterval_from_necSuf
    {q : ℚ} (hq : q ∈ unitIntervalRationals) :
    kwDualRational q ∈ unitIntervalRationals := by
  rcases hq with ⟨hqPositive, hqLtOne⟩
  have hOnePlusGtOne : 1 < 1 + q := by
    have h := add_lt_add_left hqPositive (1 : ℚ)
    simpa [add_comm] using h
  have hOnePlusPositive : 0 < 1 + q :=
    lt_trans (by norm_num : (0 : ℚ) < 1) hOnePlusGtOne
  have hOnePlusNe : 1 + q ≠ 0 := ne_of_gt hOnePlusPositive
  let t : ℚ := (1 + q)⁻¹
  have hInverse : (1 + q) * t = 1 := by
    dsimp [t]
    exact mul_inv_cancel₀ hOnePlusNe
  have hTPositive : 0 < t := by
    by_contra h
    have hNonpositive : t ≤ 0 := le_of_not_gt h
    have hProductNonpositive : (1 + q) * t ≤ 0 :=
      mul_nonpos_of_nonneg_of_nonpos (le_of_lt hOnePlusPositive) hNonpositive
    have hOneNonpositive : (1 : ℚ) ≤ 0 := by rw [← hInverse]; exact hProductNonpositive
    exact (not_le.mpr (by norm_num : (0 : ℚ) < 1)) hOneNonpositive
  have hOneMinusPositive : 0 < 1 - q := sub_pos.mpr hqLtOne
  have hNegQNegative : -q < 0 := neg_lt_zero.mpr hqPositive
  have hNegQLtQ : -q < q := lt_trans hNegQNegative hqPositive
  have hOneMinusLtOnePlus : 1 - q < 1 + q := by
    have h := add_lt_add_left hNegQLtQ (1 : ℚ)
    simpa [sub_eq_add_neg] using h
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
