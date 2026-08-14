/- 必要十分版を正の実数・実対数・分配多項式の上界へ特殊化する。 -/
import Ising2DLambda.ThermodynamicLimit.FreeEnergyDensityUpperBound
import Ising2DLambda.NecSuf.ThermodynamicLimit.FreeEnergyDensityUpperBound

namespace Ising2DLambda.ThermodynamicLimit

open PartitionPolynomial

/-- 必要十分版から `claim_free_energy_density_upper_bound` を導く。 -/
theorem freeEnergyDensity_le_upperBound_from_necSuf
    (L : PositiveNatural) (t : StrictlyPositiveReal) :
    freeEnergyDensity L t ≤
      realLogarithm (⟨2, by norm_num⟩ : StrictlyPositiveReal) +
        2 * realLogarithm (⟨1 + t.1, by linarith [t.2]⟩ : StrictlyPositiveReal) := by
  letI : NeZero L.1 := ⟨Nat.ne_of_gt L.2⟩
  let two : StrictlyPositiveReal := ⟨2, by norm_num⟩
  let onePlus : StrictlyPositiveReal := ⟨1 + t.1, by linarith [t.2]⟩
  let partitionValue : StrictlyPositiveReal :=
    ⟨Polynomial.aeval t.1 (partitionPolynomial L.1),
      partitionPolynomial_eval_real_pos L.1 t.2⟩
  let twoPower : StrictlyPositiveReal := ⟨two.1 ^ (L.1 ^ 2), pow_pos two.2 _⟩
  let onePlusPower : StrictlyPositiveReal :=
    ⟨onePlus.1 ^ (2 * L.1 ^ 2), pow_pos onePlus.2 _⟩
  let coefficient : ℝ := (((1 / ((L.1 : ℚ) ^ 2) : ℚ) : ℝ))
  have hupper : partitionValue.1 ≤ (twoPower.1 * onePlusPower.1) := by
    change Polynomial.aeval t.1 (partitionPolynomial L.1) ≤
      (2 : ℝ) ^ (L.1 ^ 2) * (1 + t.1) ^ (2 * L.1 ^ 2)
    convert partitionPolynomial_eval_real_le_upperBound L t using 1 <;> norm_cast
  have hcancelOne : coefficient * (L.1 ^ 2 : ℝ) = 1 := by
    dsimp [coefficient]
    norm_num [div_eq_mul_inv]
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
      hupper
      (realLogarithm_mul twoPower onePlusPower)
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
      (by ring)
      hcancelOne hcancelTwo
  change coefficient * realLogarithm partitionValue ≤
    realLogarithm two + 2 * realLogarithm onePlus
  simpa using habstract

end Ising2DLambda.ThermodynamicLimit
