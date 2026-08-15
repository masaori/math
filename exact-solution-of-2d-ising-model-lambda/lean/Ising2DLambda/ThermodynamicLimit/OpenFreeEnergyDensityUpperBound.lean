/-
人手証明「開境界密度の上からの評価」の具体版と必要十分版からの導出。
開境界の配位数と辺数から値を一様に抑え、その後は周期境界版と同じ対数の展開を辿る。
-/
import Ising2DLambda.ThermodynamicLimit.OpenSquareFreeEnergyDensity
import Ising2DLambda.ThermodynamicLimit.FreeEnergyDensityUpperBound
import Ising2DLambda.NecSuf.ThermodynamicLimit.FreeEnergyDensityUpperBound

namespace Ising2DLambda.ThermodynamicLimit

open Finset

/-- 開境界正方形の値の上界。人手証明の有限和の三段を辿る。 -/
theorem openPartitionValue_le_upperBound
    (L : PositiveNatural) (t : StrictlyPositiveReal) :
    openPartitionValue L.1 L.1 t.1 ≤
      ((2 ^ L.1 ^ 2 : ℕ) : ℝ) * (1 + t.1) ^ (2 * L.1 ^ 2) := by
  have htBase : t.1 ≤ 1 + t.1 := by linarith
  have hOneBase : 1 ≤ 1 + t.1 := by nlinarith [t.2]
  have hedgeCap : L.1 * (L.1 - 1) + (L.1 - 1) * L.1 ≤ 2 * L.1 ^ 2 := by
    have h₁ := Nat.mul_le_mul_left L.1 (Nat.sub_le L.1 1)
    have h₂ := Nat.mul_le_mul_right L.1 (Nat.sub_le L.1 1)
    simpa [pow_two, two_mul] using Nat.add_le_add h₁ h₂
  rw [openPartitionValue_eq_sum]
  calc
    ∑ τ : OpenConfig L.1 L.1, t.1 ^ openBrokenBondCount L.1 L.1 τ
        ≤ ∑ τ : OpenConfig L.1 L.1, (1 + t.1) ^ openBrokenBondCount L.1 L.1 τ := by
          exact sum_le_sum fun τ _ =>
            pow_le_pow_of_pos_of_le_by_induction t.2 htBase _
    _ ≤ ∑ _τ : OpenConfig L.1 L.1, (1 + t.1) ^ (2 * L.1 ^ 2) := by
          exact sum_le_sum fun τ _ =>
            pow_le_pow_of_one_le_of_exp_le_by_induction hOneBase
              (le_trans (openBrokenBondCount_le L.1 L.1 τ) hedgeCap)
    _ = ((2 ^ L.1 ^ 2 : ℕ) : ℝ) * (1 + t.1) ^ (2 * L.1 ^ 2) := by
          rw [sum_const, card_univ, card_openConfig, nsmul_eq_mul]
          simp [pow_two]

/-- `claim_open_free_energy_density_upper_bound` の具体版。 -/
theorem openSquareFreeEnergyDensity_le_upperBound
    (L : PositiveNatural) (t : StrictlyPositiveReal) :
    openSquareFreeEnergyDensity L t ≤
      realLogarithm (⟨2, by norm_num⟩ : StrictlyPositiveReal) +
        2 * realLogarithm (⟨1 + t.1, by linarith [t.2]⟩ : StrictlyPositiveReal) := by
  let two : StrictlyPositiveReal := ⟨2, by norm_num⟩
  let onePlus : StrictlyPositiveReal := ⟨1 + t.1, by linarith [t.2]⟩
  let coefficient : ℝ := (((1 / ((L.1 : ℚ) ^ 2) : ℚ) : ℝ))
  let partitionValue : StrictlyPositiveReal :=
    ⟨openPartitionValue L.1 L.1 t.1, openPartitionValue_pos L.1 L.1 t.2⟩
  let twoPower : StrictlyPositiveReal := ⟨((2 ^ L.1 ^ 2 : ℕ) : ℝ), by positivity⟩
  let onePlusPower : StrictlyPositiveReal :=
    ⟨(1 + t.1) ^ (2 * L.1 ^ 2), pow_pos onePlus.2 _⟩
  let upperValue : StrictlyPositiveReal :=
    ⟨twoPower.1 * onePlusPower.1, mul_pos twoPower.2 onePlusPower.2⟩
  have hlog : realLogarithm partitionValue ≤ realLogarithm upperValue :=
    realLogarithm_mono partitionValue upperValue (openPartitionValue_le_upperBound L t)
  have hTwoPower : twoPower = ⟨two.1 ^ (L.1 ^ 2), pow_pos two.2 _⟩ := by
    apply Subtype.ext
    change (((2 ^ L.1 ^ 2 : ℕ) : ℝ)) = (2 : ℝ) ^ (L.1 ^ 2)
    norm_cast
  have hCoeffSq : coefficient * (L.1 ^ 2 : ℝ) = 1 := by
    dsimp [coefficient]
    norm_cast
    field_simp [Nat.ne_of_gt L.2]
  have hCoeffTwiceSq : coefficient * (2 * L.1 ^ 2 : ℝ) = 2 := by
    calc
      coefficient * (2 * L.1 ^ 2 : ℝ) = 2 * (coefficient * (L.1 ^ 2 : ℝ)) := by ring
      _ = 2 := by rw [hCoeffSq, mul_one]
  have hcoefficient : 0 ≤ coefficient := by dsimp [coefficient]; positivity
  calc
    openSquareFreeEnergyDensity L t = coefficient * realLogarithm partitionValue := rfl
    _ ≤ coefficient * realLogarithm upperValue :=
      mul_le_mul_of_nonneg_left hlog hcoefficient
    _ = coefficient * (realLogarithm twoPower + realLogarithm onePlusPower) := by
      rw [realLogarithm_mul]
    _ = coefficient * ((L.1 ^ 2 : ℝ) * realLogarithm two +
          (2 * L.1 ^ 2 : ℝ) * realLogarithm onePlus) := by
      rw [hTwoPower, realLogarithm_naturalPower two (L.1 ^ 2),
        realLogarithm_naturalPower onePlus (2 * L.1 ^ 2)]
      norm_num
    _ = (coefficient * (L.1 ^ 2 : ℝ)) * realLogarithm two +
          (coefficient * (2 * L.1 ^ 2 : ℝ)) * realLogarithm onePlus := by ring
    _ = realLogarithm two + 2 * realLogarithm onePlus := by
      rw [hCoeffSq, hCoeffTwiceSq, one_mul]
    _ = realLogarithm (⟨2, by norm_num⟩ : StrictlyPositiveReal) +
          2 * realLogarithm (⟨1 + t.1, by linarith [t.2]⟩ : StrictlyPositiveReal) := by rfl

/-- 必要十分版から開境界密度の上界を導く。 -/
theorem openSquareFreeEnergyDensity_le_upperBound_from_necSuf
    (L : PositiveNatural) (t : StrictlyPositiveReal) :
    openSquareFreeEnergyDensity L t ≤
      realLogarithm (⟨2, by norm_num⟩ : StrictlyPositiveReal) +
        2 * realLogarithm (⟨1 + t.1, by linarith [t.2]⟩ : StrictlyPositiveReal) := by
  let two : StrictlyPositiveReal := ⟨2, by norm_num⟩
  let onePlus : StrictlyPositiveReal := ⟨1 + t.1, by linarith [t.2]⟩
  let partitionValue : StrictlyPositiveReal :=
    ⟨openPartitionValue L.1 L.1 t.1, openPartitionValue_pos L.1 L.1 t.2⟩
  let twoPower : StrictlyPositiveReal := ⟨two.1 ^ (L.1 ^ 2), pow_pos two.2 _⟩
  let onePlusPower : StrictlyPositiveReal :=
    ⟨onePlus.1 ^ (2 * L.1 ^ 2), pow_pos onePlus.2 _⟩
  let coefficient : ℝ := (((1 / ((L.1 : ℚ) ^ 2) : ℚ) : ℝ))
  have hupper : partitionValue.1 ≤ twoPower.1 * onePlusPower.1 := by
    change openPartitionValue L.1 L.1 t.1 ≤
      (2 : ℝ) ^ (L.1 ^ 2) * (1 + t.1) ^ (2 * L.1 ^ 2)
    convert openPartitionValue_le_upperBound L t using 1 <;> norm_cast
  have hcancelOne : coefficient * (L.1 ^ 2 : ℝ) = 1 := by
    dsimp [coefficient]
    norm_cast
    field_simp [Nat.ne_of_gt L.2]
  have hcancelTwo : coefficient * (2 * L.1 ^ 2 : ℝ) = 2 := by
    calc
      coefficient * (2 * L.1 ^ 2 : ℝ) = 2 * (coefficient * (L.1 ^ 2 : ℝ)) := by ring
      _ = 2 := by rw [hcancelOne, mul_one]
  have habstract :=
    NecSuf.ThermodynamicLimit.scaled_map_upperBound_necSuf
      (fun u v : StrictlyPositiveReal => u.1 ≤ v.1) (fun a b : ℝ => a ≤ b)
      (fun u v : StrictlyPositiveReal => ⟨u.1 * v.1, mul_pos u.2 v.2⟩)
      realLogarithm (· + ·) (fun c y : ℝ => c * y) (· * ·)
      partitionValue twoPower onePlusPower two onePlus coefficient
      (L.1 ^ 2 : ℝ) (2 * L.1 ^ 2 : ℝ) 1 2
      (fun h => realLogarithm_mono _ _ h)
      (fun h => mul_le_mul_of_nonneg_left h (by dsimp [coefficient]; positivity))
      hupper (realLogarithm_mul twoPower onePlusPower)
      (by
        change realLogarithm ⟨two.1 ^ (L.1 ^ 2), pow_pos two.2 _⟩ =
          (L.1 ^ 2 : ℝ) * realLogarithm two
        calc
          _ = ((L.1 ^ 2 : ℕ) : ℝ) * realLogarithm two :=
            realLogarithm_naturalPower two (L.1 ^ 2)
          _ = _ := by norm_num)
      (by
        change realLogarithm ⟨onePlus.1 ^ (2 * L.1 ^ 2), pow_pos onePlus.2 _⟩ =
          (2 * L.1 ^ 2 : ℝ) * realLogarithm onePlus
        calc
          _ = ((2 * L.1 ^ 2 : ℕ) : ℝ) * realLogarithm onePlus :=
            realLogarithm_naturalPower onePlus (2 * L.1 ^ 2)
          _ = _ := by norm_num)
      (by ring) hcancelOne hcancelTwo
  change coefficient * realLogarithm partitionValue ≤
    realLogarithm two + 2 * realLogarithm onePlus
  simpa using habstract

end Ising2DLambda.ThermodynamicLimit
