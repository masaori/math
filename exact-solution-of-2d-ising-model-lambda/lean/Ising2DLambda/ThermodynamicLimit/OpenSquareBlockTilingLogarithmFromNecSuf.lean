/- 必要十分版を開境界正方形の値・実対数・自由エネルギー密度へ特殊化する。 -/
import Ising2DLambda.ThermodynamicLimit.OpenSquareBlockTilingLogarithm
import Ising2DLambda.NecSuf.ThermodynamicLimit.OpenSquareBlockTilingLogarithm

namespace Ising2DLambda.ThermodynamicLimit

/-- 必要十分版から `0 < t ≤ 1` の場合を導く。 -/
theorem openSquareFreeEnergyDensity_blockTiling_bounds_of_le_one_from_necSuf
    (a k : PositiveNatural) (t : StrictlyPositiveReal) (ht1 : t.1 ≤ 1) :
    blockTilingCorrection a k t + openSquareFreeEnergyDensity a t ≤
        openSquareFreeEnergyDensity (squareSide a k) t ∧
      openSquareFreeEnergyDensity (squareSide a k) t ≤ openSquareFreeEnergyDensity a t := by
  let P : StrictlyPositiveReal :=
    ⟨openPartitionValue a.1 a.1 t.1, openPartitionValue_pos a.1 a.1 t.2⟩
  let Q : StrictlyPositiveReal :=
    ⟨openPartitionValue (k.1 * a.1) (k.1 * a.1) t.1,
      openPartitionValue_pos (k.1 * a.1) (k.1 * a.1) t.2⟩
  let lower : StrictlyPositiveReal :=
    ⟨t.1 ^ ((k.1 - 1) * (k.1 * a.1)) * (t.1 ^ ((k.1 - 1) * a.1) * P.1 ^ k.1) ^ k.1,
      mul_pos (pow_pos t.2 _) (pow_pos (mul_pos (pow_pos t.2 _) (pow_pos P.2 _)) _)⟩
  let upper : StrictlyPositiveReal := ⟨(P.1 ^ k.1) ^ k.1, pow_pos (pow_pos P.2 _) _⟩
  let coefficient : ℝ := (((1 / (((squareSide a k).1 : ℚ) ^ 2) : ℚ) : ℝ))
  have hcoefficient : 0 ≤ coefficient := by
    dsimp [coefficient, squareSide]
    positivity
  have hblock := openPartitionValue_squareBlockTiling_bounds_of_le_one a.1 k.1 a.2 k.2 t.2 ht1
  have habstract :=
    NecSuf.ThermodynamicLimit.scaled_map_twoSided_bounds_necSuf
      (fun u v : StrictlyPositiveReal => u.1 ≤ v.1) (fun x y : ℝ => x ≤ y)
      realLogarithm (· + ·) (fun c y : ℝ => c * y) (· * ·)
      lower Q upper t P coefficient
      ((2 * (k.1 - 1) * (k.1 * a.1) : ℕ) : ℝ) ((k.1 ^ 2 : ℕ) : ℝ) ((k.1 ^ 2 : ℕ) : ℝ)
      ((((2 * (k.1 - 1) : ℕ) : ℚ) / ((k.1 * a.1 : ℕ) : ℚ) : ℚ) : ℝ)
      (((1 / ((a.1 : ℚ) ^ 2) : ℚ) : ℝ))
      (fun h => realLogarithm_mono _ _ h)
      (fun h => mul_le_mul_of_nonneg_left h hcoefficient)
      hblock.1 hblock.2
      (realLogarithm_blockTiling_lower_expand a.1 k.1 t P)
      (realLogarithm_blockTiling_upper_expand k.1 P)
      (fun u v c1 c2 => by ring)
      (fun u c1 => by ring)
      (blockTiling_coefficient_cancel_t a k)
      (blockTiling_coefficient_cancel_P a k)
      (blockTiling_coefficient_cancel_P a k)
  exact habstract

/-- 必要十分版から `1 ≤ t` の場合を導く。順序の向きを反転して同じ定理へ渡す。 -/
theorem openSquareFreeEnergyDensity_blockTiling_bounds_of_one_le_from_necSuf
    (a k : PositiveNatural) (t : StrictlyPositiveReal) (ht : 1 ≤ t.1) :
    openSquareFreeEnergyDensity a t ≤ openSquareFreeEnergyDensity (squareSide a k) t ∧
      openSquareFreeEnergyDensity (squareSide a k) t ≤
        blockTilingCorrection a k t + openSquareFreeEnergyDensity a t := by
  let P : StrictlyPositiveReal :=
    ⟨openPartitionValue a.1 a.1 t.1, openPartitionValue_pos a.1 a.1 t.2⟩
  let Q : StrictlyPositiveReal :=
    ⟨openPartitionValue (k.1 * a.1) (k.1 * a.1) t.1,
      openPartitionValue_pos (k.1 * a.1) (k.1 * a.1) t.2⟩
  let lower : StrictlyPositiveReal := ⟨(P.1 ^ k.1) ^ k.1, pow_pos (pow_pos P.2 _) _⟩
  let upper : StrictlyPositiveReal :=
    ⟨t.1 ^ ((k.1 - 1) * (k.1 * a.1)) * (t.1 ^ ((k.1 - 1) * a.1) * P.1 ^ k.1) ^ k.1,
      mul_pos (pow_pos t.2 _) (pow_pos (mul_pos (pow_pos t.2 _) (pow_pos P.2 _)) _)⟩
  let coefficient : ℝ := (((1 / (((squareSide a k).1 : ℚ) ^ 2) : ℚ) : ℝ))
  have hcoefficient : 0 ≤ coefficient := by
    dsimp [coefficient, squareSide]
    positivity
  have hblock := openPartitionValue_squareBlockTiling_bounds_of_one_le a.1 k.1 a.2 k.2 ht
  -- 反転した順序で、`upper`（補正つき）を「下側」に、`lower`（`(P^k)^k`）を「上側」に置く。
  have habstract :=
    NecSuf.ThermodynamicLimit.scaled_map_twoSided_bounds_necSuf
      (fun u v : StrictlyPositiveReal => v.1 ≤ u.1) (fun x y : ℝ => y ≤ x)
      realLogarithm (· + ·) (fun c y : ℝ => c * y) (· * ·)
      upper Q lower t P coefficient
      ((2 * (k.1 - 1) * (k.1 * a.1) : ℕ) : ℝ) ((k.1 ^ 2 : ℕ) : ℝ) ((k.1 ^ 2 : ℕ) : ℝ)
      ((((2 * (k.1 - 1) : ℕ) : ℚ) / ((k.1 * a.1 : ℕ) : ℚ) : ℚ) : ℝ)
      (((1 / ((a.1 : ℚ) ^ 2) : ℚ) : ℝ))
      (fun h => realLogarithm_mono _ _ h)
      (fun h => mul_le_mul_of_nonneg_left h hcoefficient)
      hblock.2 hblock.1
      (realLogarithm_blockTiling_lower_expand a.1 k.1 t P)
      (realLogarithm_blockTiling_upper_expand k.1 P)
      (fun u v c1 c2 => by ring)
      (fun u c1 => by ring)
      (blockTiling_coefficient_cancel_t a k)
      (blockTiling_coefficient_cancel_P a k)
      (blockTiling_coefficient_cancel_P a k)
  exact ⟨habstract.2, habstract.1⟩

end Ising2DLambda.ThermodynamicLimit
