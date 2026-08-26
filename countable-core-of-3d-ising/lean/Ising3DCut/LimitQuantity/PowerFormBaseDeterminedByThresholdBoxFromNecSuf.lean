/-
必要十分版 `NecSuf.value_determined_by_injective_observation` から、
「点数乗表示の底は閾値の箱の値から一意に決まる」の具体版を導く。
-/
import Ising3DCut.LimitQuantity.PowerFormBaseDeterminedByThresholdBox
import Ising3DCut.NecSuf.ValueDeterminedByInjectiveObservation

namespace Ising3DCut.LimitQuantity

/-- `power_form_base_is_determined_by_threshold_box` を必要十分版から導いた版。 -/
theorem power_form_base_is_determined_by_threshold_box_viaNecSuf
    {Z : ℕ → ℚ} {c c' : ℚ} {L₀ : ℕ}
    (hL₀ : 0 < L₀) (hcpos : 0 < c) (hc'pos : 0 < c')
    (hc : ∀ L, L₀ ≤ L → Z L = c ^ vertexNumber L)
    (hc' : ∀ L, L₀ ≤ L → Z L = c' ^ vertexNumber L) :
    c = c' := by
  have hn : 1 ≤ vertexNumber L₀ := one_le_vertexNumber hL₀
  have hpow : c ^ vertexNumber L₀ = c' ^ vertexNumber L₀ := by
    rw [← hc L₀ (le_refl L₀), hc' L₀ (le_refl L₀)]
  apply Ising3DCut.NecSuf.value_determined_by_injective_observation
    (s := Set.Ioi (0 : ℚ)) (observe := fun x : ℚ => x ^ vertexNumber L₀)
  · exact hcpos
  · exact hc'pos
  · intro x hx y hy hxy
    rcases lt_trichotomy x y with hlt | heq | hgt
    · exact absurd hxy (ne_of_lt (pow_lt_pow_left_of_pos hx hlt hn))
    · exact heq
    · exact absurd hxy.symm (ne_of_lt (pow_lt_pow_left_of_pos hy hgt hn))
  · exact hpow

end Ising3DCut.LimitQuantity
