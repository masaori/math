/-
人手証明「開境界密度の下からの評価（t が 1 以下の場合）」
（`claim_open_free_energy_density_lower_bound_le_one`）の具体版と必要十分版からの導出。

値の側は `2 t^{E_L} ≤ 2^{L²} t^{E_L} = Σ_τ t^{E_L} ≤ Σ_τ t^{b(τ)} = Z^op_{L,L}(t)` と
`t^{2L²} ≤ t^{E_L} ≤ 2 t^{E_L}` を辿り、対数の側は
`ι(2)·log t = ι(1/L²)·ι(2L²)·log t = ι(1/L²)·log(t^{2L²}) ≤ ι(1/L²)·log Z = ψ^op_L(t)` を辿る。
-/
import Ising2DLambda.ThermodynamicLimit.OpenSquareFreeEnergyDensity
import Ising2DLambda.ThermodynamicLimit.FreeEnergyDensityUpperBound
import Ising2DLambda.ThermodynamicLimit.RealLogNaturalPower
import Ising2DLambda.NecSuf.ThermodynamicLimit.OpenFreeEnergyDensityLowerBound

namespace Ising2DLambda.ThermodynamicLimit

open Finset

/-- 開境界正方形の辺数 `E_L = 2L(L-1)`（`card_openEdge` と同じ形 `L(L-1)+(L-1)L` で持つ）。 -/
def openSquareEdgeCount (L : ℕ) : ℕ := L * (L - 1) + (L - 1) * L

/-- 人手証明の第一の鎖: `2 t^{E_L} ≤ Z^op_{L,L}(t)`（`0 < t ≤ 1`）。 -/
theorem two_mul_pow_edgeCount_le_openPartitionValue
    (L : PositiveNatural) (t : StrictlyPositiveReal) (ht1 : t.1 ≤ 1) :
    2 * t.1 ^ openSquareEdgeCount L.1 ≤ openPartitionValue L.1 L.1 t.1 := by
  have hpowPos : 0 < t.1 ^ openSquareEdgeCount L.1 := pow_pos_by_induction t.2 _
  have hTwoLe : (2 : ℝ) ≤ ((2 ^ L.1 ^ 2 : ℕ) : ℝ) := by
    have h : 2 ^ 1 ≤ 2 ^ L.1 ^ 2 :=
      Nat.pow_le_pow_right (by norm_num) (Nat.one_le_pow _ _ L.2)
    exact_mod_cast (by simpa using h : 2 ≤ 2 ^ L.1 ^ 2)
  rw [openPartitionValue_eq_sum]
  calc
    2 * t.1 ^ openSquareEdgeCount L.1
        ≤ ((2 ^ L.1 ^ 2 : ℕ) : ℝ) * t.1 ^ openSquareEdgeCount L.1 :=
          mul_le_mul_of_nonneg_right hTwoLe hpowPos.le
    _ = ∑ _τ : OpenConfig L.1 L.1, t.1 ^ openSquareEdgeCount L.1 := by
          rw [sum_const, card_univ, card_openConfig, nsmul_eq_mul]
          simp [pow_two]
    _ ≤ ∑ τ : OpenConfig L.1 L.1, t.1 ^ openBrokenBondCount L.1 L.1 τ :=
          sum_le_sum fun τ _ =>
            pow_le_pow_of_le_one_of_exp_le_by_induction t.2 ht1
              (openBrokenBondCount_le L.1 L.1 τ)

/-- 人手証明の第二の評価: `t^{2L²} ≤ 2 t^{E_L}`（`0 < t ≤ 1`）。 -/
theorem pow_twoSquare_le_two_mul_pow_edgeCount
    (L : PositiveNatural) (t : StrictlyPositiveReal) (ht1 : t.1 ≤ 1) :
    t.1 ^ (2 * L.1 ^ 2) ≤ 2 * t.1 ^ openSquareEdgeCount L.1 := by
  have hedgeCap : openSquareEdgeCount L.1 ≤ 2 * L.1 ^ 2 := by
    have h₁ := Nat.mul_le_mul_left L.1 (Nat.sub_le L.1 1)
    have h₂ := Nat.mul_le_mul_right L.1 (Nat.sub_le L.1 1)
    unfold openSquareEdgeCount
    simpa [pow_two, two_mul] using Nat.add_le_add h₁ h₂
  have hpowPos : 0 < t.1 ^ openSquareEdgeCount L.1 := pow_pos_by_induction t.2 _
  calc
    t.1 ^ (2 * L.1 ^ 2) ≤ t.1 ^ openSquareEdgeCount L.1 :=
      pow_le_pow_of_le_one_of_exp_le_by_induction t.2 ht1 hedgeCap
    _ = 1 * t.1 ^ openSquareEdgeCount L.1 := (one_mul _).symm
    _ ≤ 2 * t.1 ^ openSquareEdgeCount L.1 :=
      mul_le_mul_of_nonneg_right (by norm_num) hpowPos.le

/-- 二つの評価を継いだ `t^{2L²} ≤ Z^op_{L,L}(t)`。 -/
theorem pow_twoSquare_le_openPartitionValue
    (L : PositiveNatural) (t : StrictlyPositiveReal) (ht1 : t.1 ≤ 1) :
    t.1 ^ (2 * L.1 ^ 2) ≤ openPartitionValue L.1 L.1 t.1 :=
  le_trans (pow_twoSquare_le_two_mul_pow_edgeCount L t ht1)
    (two_mul_pow_edgeCount_le_openPartitionValue L t ht1)

/-- `claim_open_free_energy_density_lower_bound_le_one` の具体版。 -/
theorem openSquareFreeEnergyDensity_lowerBound_of_le_one
    (L : PositiveNatural) (t : StrictlyPositiveReal) (ht1 : t.1 ≤ 1) :
    2 * realLogarithm t ≤ openSquareFreeEnergyDensity L t := by
  let coefficient : ℝ := (((1 / ((L.1 : ℚ) ^ 2) : ℚ) : ℝ))
  let partitionValue : StrictlyPositiveReal :=
    ⟨openPartitionValue L.1 L.1 t.1, openPartitionValue_pos L.1 L.1 t.2⟩
  let tPower : StrictlyPositiveReal := ⟨t.1 ^ (2 * L.1 ^ 2), pow_pos t.2 _⟩
  have hCoeffSq : coefficient * (L.1 ^ 2 : ℝ) = 1 := by
    dsimp [coefficient]
    norm_cast
    field_simp [Nat.ne_of_gt L.2]
  have hCoeffTwiceSq : coefficient * (2 * L.1 ^ 2 : ℝ) = 2 := by
    calc
      coefficient * (2 * L.1 ^ 2 : ℝ) = 2 * (coefficient * (L.1 ^ 2 : ℝ)) := by ring
      _ = 2 := by rw [hCoeffSq, mul_one]
  have hcoefficient : 0 ≤ coefficient := by dsimp [coefficient]; positivity
  have hlog : realLogarithm tPower ≤ realLogarithm partitionValue :=
    realLogarithm_mono tPower partitionValue (pow_twoSquare_le_openPartitionValue L t ht1)
  calc
    2 * realLogarithm t = (coefficient * (2 * L.1 ^ 2 : ℝ)) * realLogarithm t := by
      rw [hCoeffTwiceSq]
    _ = coefficient * ((2 * L.1 ^ 2 : ℝ) * realLogarithm t) := by ring
    _ = coefficient * realLogarithm tPower := by
      rw [realLogarithm_naturalPower t (2 * L.1 ^ 2)]
      norm_num
    _ ≤ coefficient * realLogarithm partitionValue :=
      mul_le_mul_of_nonneg_left hlog hcoefficient
    _ = openSquareFreeEnergyDensity L t := rfl

/-- 必要十分版から開境界密度の下界を導く。 -/
theorem openSquareFreeEnergyDensity_lowerBound_of_le_one_from_necSuf
    (L : PositiveNatural) (t : StrictlyPositiveReal) (ht1 : t.1 ≤ 1) :
    2 * realLogarithm t ≤ openSquareFreeEnergyDensity L t := by
  let coefficient : ℝ := (((1 / ((L.1 : ℚ) ^ 2) : ℚ) : ℝ))
  let partitionValue : StrictlyPositiveReal :=
    ⟨openPartitionValue L.1 L.1 t.1, openPartitionValue_pos L.1 L.1 t.2⟩
  let tPower : StrictlyPositiveReal := ⟨t.1 ^ (2 * L.1 ^ 2), pow_pos t.2 _⟩
  have hCoeffSq : coefficient * (L.1 ^ 2 : ℝ) = 1 := by
    dsimp [coefficient]
    norm_cast
    field_simp [Nat.ne_of_gt L.2]
  have hCoeffTwiceSq : coefficient * (2 * L.1 ^ 2 : ℝ) = 2 := by
    calc
      coefficient * (2 * L.1 ^ 2 : ℝ) = 2 * (coefficient * (L.1 ^ 2 : ℝ)) := by ring
      _ = 2 := by rw [hCoeffSq, mul_one]
  have habstract :=
    NecSuf.ThermodynamicLimit.scaled_map_lowerBound_necSuf
      (fun u v : StrictlyPositiveReal => u.1 ≤ v.1) (fun a b : ℝ => a ≤ b)
      realLogarithm (fun c y : ℝ => c * y) (· * ·)
      partitionValue tPower t coefficient (2 * L.1 ^ 2 : ℝ) 2
      (fun h => realLogarithm_mono _ _ h)
      (fun h => mul_le_mul_of_nonneg_left h (by dsimp [coefficient]; positivity))
      (pow_twoSquare_le_openPartitionValue L t ht1)
      (by
        change realLogarithm ⟨t.1 ^ (2 * L.1 ^ 2), pow_pos t.2 _⟩ =
          (2 * L.1 ^ 2 : ℝ) * realLogarithm t
        calc
          _ = ((2 * L.1 ^ 2 : ℕ) : ℝ) * realLogarithm t :=
            realLogarithm_naturalPower t (2 * L.1 ^ 2)
          _ = _ := by norm_num)
      (by ring) hCoeffTwiceSq
  change 2 * realLogarithm t ≤ coefficient * realLogarithm partitionValue
  simpa using habstract

end Ising2DLambda.ThermodynamicLimit
