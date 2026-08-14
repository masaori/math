/-
人手証明「自由エネルギー密度の上からの評価」の具体版。

分配多項式の値の上界へ実対数の単調性を施し、積の対数と自然数冪の対数を
本文と同じ順で開く。最後の相殺は有理数側で行う。完備性・極限は使わない。
-/
import Ising2DLambda.ThermodynamicLimit.PartitionValueUpperBound
import Ising2DLambda.ThermodynamicLimit.RealLogNaturalPower

namespace Ising2DLambda.ThermodynamicLimit

open PartitionPolynomial

/-- 人手証明の準備第三。狭義単調性と相等の場合分けから弱い単調性を得る。 -/
lemma realLogarithm_mono (u v : StrictlyPositiveReal) (huv : u.1 ≤ v.1) :
    realLogarithm u ≤ realLogarithm v := by
  rcases huv.eq_or_lt with heq | hlt
  · exact le_of_eq (congrArg realLogarithm (Subtype.ext heq))
  · exact (realLogarithm_strictMono u v hlt).le

/-- `claim_free_energy_density_upper_bound`。人手証明の十二段を同じ順で辿る。 -/
theorem freeEnergyDensity_le_upperBound (L : PositiveNatural) (t : StrictlyPositiveReal) :
    freeEnergyDensity L t ≤
      realLogarithm (⟨2, by norm_num⟩ : StrictlyPositiveReal) +
        2 * realLogarithm (⟨1 + t.1, by linarith [t.2]⟩ : StrictlyPositiveReal) := by
  letI : NeZero L.1 := ⟨Nat.ne_of_gt L.2⟩
  let two : StrictlyPositiveReal := ⟨2, by norm_num⟩
  let onePlus : StrictlyPositiveReal := ⟨1 + t.1, by linarith [t.2]⟩
  let coefficient : ℝ := (((1 / ((L.1 : ℚ) ^ 2) : ℚ) : ℝ))
  let partitionValue : StrictlyPositiveReal :=
    ⟨Polynomial.aeval t.1 (partitionPolynomial L.1),
      partitionPolynomial_eval_real_pos L.1 t.2⟩
  let twoPower : StrictlyPositiveReal :=
    ⟨((2 ^ L.1 ^ 2 : ℕ) : ℝ), by positivity⟩
  let onePlusPower : StrictlyPositiveReal :=
    ⟨(1 + t.1) ^ (2 * L.1 ^ 2), pow_pos onePlus.2 _⟩
  let upperValue : StrictlyPositiveReal :=
    ⟨twoPower.1 * onePlusPower.1, mul_pos twoPower.2 onePlusPower.2⟩
  have hvalue : partitionValue.1 ≤ upperValue.1 := by
    exact partitionPolynomial_eval_real_le_upperBound L t
  have hlog : realLogarithm partitionValue ≤ realLogarithm upperValue :=
    realLogarithm_mono partitionValue upperValue hvalue
  have hTwoPower : twoPower = ⟨two.1 ^ (L.1 ^ 2), pow_pos two.2 _⟩ := by
    apply Subtype.ext
    change (((2 ^ L.1 ^ 2 : ℕ) : ℝ)) = (2 : ℝ) ^ (L.1 ^ 2)
    norm_cast
  have hCoeffSq : coefficient * (L.1 ^ 2 : ℝ) = 1 := by
    dsimp [coefficient]
    norm_num [div_eq_mul_inv]
  have hCoeffTwiceSq :
      coefficient * (2 * L.1 ^ 2 : ℝ) = 2 := by
    calc
      coefficient * (2 * L.1 ^ 2 : ℝ) = 2 * (coefficient * (L.1 ^ 2 : ℝ)) := by ring
      _ = 2 := by rw [hCoeffSq, mul_one]
  have hcoefficient : 0 ≤ coefficient := by
    dsimp [coefficient]
    positivity
  calc
    freeEnergyDensity L t =
        coefficient * finiteRealFreeEntropy L.1 t := rfl
    _ = coefficient * realLogarithm partitionValue := rfl
    _ ≤ coefficient * realLogarithm upperValue :=
      mul_le_mul_of_nonneg_left hlog hcoefficient
    _ = coefficient *
        (realLogarithm twoPower + realLogarithm onePlusPower) := by
      rw [realLogarithm_mul]
    _ = coefficient *
        ((L.1 ^ 2 : ℝ) * realLogarithm two +
          (2 * L.1 ^ 2 : ℝ) * realLogarithm onePlus) := by
      rw [hTwoPower]
      rw [realLogarithm_naturalPower two (L.1 ^ 2)]
      rw [realLogarithm_naturalPower onePlus (2 * L.1 ^ 2)]
      norm_num
    _ = (coefficient * (L.1 ^ 2 : ℝ)) * realLogarithm two +
        (coefficient * (2 * L.1 ^ 2 : ℝ)) * realLogarithm onePlus := by ring
    _ = 1 * realLogarithm two + 2 * realLogarithm onePlus := by
      rw [hCoeffSq, hCoeffTwiceSq]
    _ = realLogarithm two + 2 * realLogarithm onePlus := by rw [one_mul]
    _ = realLogarithm (⟨2, by norm_num⟩ : StrictlyPositiveReal) +
        2 * realLogarithm (⟨1 + t.1, by linarith [t.2]⟩ : StrictlyPositiveReal) := by rfl

end Ising2DLambda.ThermodynamicLimit
