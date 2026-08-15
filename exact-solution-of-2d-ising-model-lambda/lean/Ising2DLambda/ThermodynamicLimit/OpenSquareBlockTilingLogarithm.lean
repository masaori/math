/-
人手証明「ブロック敷き詰め評価の対数化」（`claim_open_square_block_tiling_logarithm`）の具体版。

ブロック敷き詰め評価へ実対数の単調性を施し、積の対数と自然数冪の対数を本文と同じ順で開き、
正の係数 `ι(1/(ka)²)` を掛けてから有理数の約分で `δ_{a,k}(t)` と `ψ^op_a(t)` へ書き戻す。
完備性・極限は使わない。
-/
import Ising2DLambda.ThermodynamicLimit.OpenSquareBlockTiling
import Ising2DLambda.ThermodynamicLimit.OpenSquareFreeEnergyDensity
import Ising2DLambda.ThermodynamicLimit.FreeEnergyDensityUpperBound
import Ising2DLambda.ThermodynamicLimit.RealLogNaturalPower

namespace Ising2DLambda.ThermodynamicLimit

/-- 補正項 `δ_{a,k}(t) := ι(2(k-1)/(ka)) · log_ℝ(t)`。有理数の商を作ってから ℝ へ移す。 -/
noncomputable def blockTilingCorrection (a k : PositiveNatural) (t : StrictlyPositiveReal) : ℝ :=
  ((((2 * (k.1 - 1) : ℕ) : ℚ) / ((k.1 * a.1 : ℕ) : ℚ) : ℚ) : ℝ) * realLogarithm t

/-- 一辺 `ka` の正方形（`k a ≥ 1`）。 -/
def squareSide (a k : PositiveNatural) : PositiveNatural := ⟨k.1 * a.1, Nat.mul_pos k.2 a.2⟩

/-- 人手証明の第一の等式列: 下側の値の対数を一行ずつ開く。 -/
lemma realLogarithm_blockTiling_lower_expand (a k : ℕ) (t P : StrictlyPositiveReal) :
    realLogarithm ⟨t.1 ^ ((k - 1) * (k * a)) * (t.1 ^ ((k - 1) * a) * P.1 ^ k) ^ k,
        mul_pos (pow_pos t.2 _) (pow_pos (mul_pos (pow_pos t.2 _) (pow_pos P.2 _)) _)⟩ =
      ((2 * (k - 1) * (k * a) : ℕ) : ℝ) * realLogarithm t +
        ((k ^ 2 : ℕ) : ℝ) * realLogarithm P := by
  let tOuter : StrictlyPositiveReal := ⟨t.1 ^ ((k - 1) * (k * a)), pow_pos t.2 _⟩
  let tInner : StrictlyPositiveReal := ⟨t.1 ^ ((k - 1) * a), pow_pos t.2 _⟩
  let pPow : StrictlyPositiveReal := ⟨P.1 ^ k, pow_pos P.2 _⟩
  let inner : StrictlyPositiveReal := ⟨tInner.1 * pPow.1, mul_pos tInner.2 pPow.2⟩
  let innerPow : StrictlyPositiveReal := ⟨inner.1 ^ k, pow_pos inner.2 _⟩
  calc
    realLogarithm ⟨tOuter.1 * innerPow.1, mul_pos tOuter.2 innerPow.2⟩
        = realLogarithm tOuter + realLogarithm innerPow :=
          -- 乗法を加法へ移す性質
          realLogarithm_mul tOuter innerPow
    _ = (((k - 1) * (k * a) : ℕ) : ℝ) * realLogarithm t +
          ((k : ℕ) : ℝ) * realLogarithm inner := by
          -- 自然数冪の法則を二箇所へ
          rw [realLogarithm_naturalPower t ((k - 1) * (k * a)),
            realLogarithm_naturalPower inner k]
    _ = (((k - 1) * (k * a) : ℕ) : ℝ) * realLogarithm t +
          ((k : ℕ) : ℝ) * (realLogarithm tInner + realLogarithm pPow) := by
          -- 乗法を加法へ移す性質
          rw [realLogarithm_mul tInner pPow]
    _ = (((k - 1) * (k * a) : ℕ) : ℝ) * realLogarithm t +
          ((k : ℕ) : ℝ) * ((((k - 1) * a : ℕ) : ℝ) * realLogarithm t +
            ((k : ℕ) : ℝ) * realLogarithm P) := by
          -- 自然数冪の法則を二箇所へ
          rw [realLogarithm_naturalPower t ((k - 1) * a),
            realLogarithm_naturalPower P k]
    _ = ((2 * (k - 1) * (k * a) : ℕ) : ℝ) * realLogarithm t +
          ((k ^ 2 : ℕ) : ℝ) * realLogarithm P := by
          -- 分配則と自然数の等式
          push_cast
          ring

/-- 人手証明の第二の等式列（上側）: `(P^k)^k` の対数。 -/
lemma realLogarithm_blockTiling_upper_expand (k : ℕ) (P : StrictlyPositiveReal) :
    realLogarithm ⟨(P.1 ^ k) ^ k, pow_pos (pow_pos P.2 _) _⟩ =
      ((k ^ 2 : ℕ) : ℝ) * realLogarithm P := by
  let pPow : StrictlyPositiveReal := ⟨P.1 ^ k, pow_pos P.2 _⟩
  calc
    realLogarithm ⟨pPow.1 ^ k, pow_pos pPow.2 _⟩
        = ((k : ℕ) : ℝ) * realLogarithm pPow := realLogarithm_naturalPower pPow k
    _ = ((k : ℕ) : ℝ) * (((k : ℕ) : ℝ) * realLogarithm P) := by
          rw [realLogarithm_naturalPower P k]
    _ = ((k ^ 2 : ℕ) : ℝ) * realLogarithm P := by push_cast; ring

/-- 係数の約分（`t` の項）: `ι(1/(ka)²) · ι(2(k-1)ka) = ι(2(k-1)/(ka))`。有理数の等式である。 -/
lemma blockTiling_coefficient_cancel_t (a k : PositiveNatural) :
    (((1 / (((squareSide a k).1 : ℚ) ^ 2) : ℚ) : ℝ)) *
        ((2 * (k.1 - 1) * (k.1 * a.1) : ℕ) : ℝ) =
      ((((2 * (k.1 - 1) : ℕ) : ℚ) / ((k.1 * a.1 : ℕ) : ℚ) : ℚ) : ℝ) := by
  have hk : (k.1 : ℝ) ≠ 0 := by exact_mod_cast (Nat.ne_of_gt k.2)
  have ha : (a.1 : ℝ) ≠ 0 := by exact_mod_cast (Nat.ne_of_gt a.2)
  simp only [squareSide]
  push_cast
  field_simp

/-- 係数の約分（`P` の項）: `ι(1/(ka)²) · ι(k²) = ι(1/a²)`。 -/
lemma blockTiling_coefficient_cancel_P (a k : PositiveNatural) :
    (((1 / (((squareSide a k).1 : ℚ) ^ 2) : ℚ) : ℝ)) * ((k.1 ^ 2 : ℕ) : ℝ) =
      (((1 / ((a.1 : ℚ) ^ 2) : ℚ) : ℝ)) := by
  have hk : (k.1 : ℝ) ≠ 0 := by exact_mod_cast (Nat.ne_of_gt k.2)
  have ha : (a.1 : ℝ) ≠ 0 := by exact_mod_cast (Nat.ne_of_gt a.2)
  simp only [squareSide]
  push_cast
  field_simp

/-- `claim_open_square_block_tiling_logarithm` の `0 < t ≤ 1` の場合。 -/
theorem openSquareFreeEnergyDensity_blockTiling_bounds_of_le_one
    (a k : PositiveNatural) (t : StrictlyPositiveReal) (ht1 : t.1 ≤ 1) :
    blockTilingCorrection a k t + openSquareFreeEnergyDensity a t ≤
        openSquareFreeEnergyDensity (squareSide a k) t ∧
      openSquareFreeEnergyDensity (squareSide a k) t ≤ openSquareFreeEnergyDensity a t := by
  -- 略記 P, Q と、その正値性
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
  -- ブロック敷き詰め評価
  have hblock := openPartitionValue_squareBlockTiling_bounds_of_le_one a.1 k.1 a.2 k.2 t.2 ht1
  -- 実対数の狭義単調性（等号なら等しい）
  have hlogLower : realLogarithm lower ≤ realLogarithm Q := realLogarithm_mono lower Q hblock.1
  have hlogUpper : realLogarithm Q ≤ realLogarithm upper := realLogarithm_mono Q upper hblock.2
  constructor
  · calc
      blockTilingCorrection a k t + openSquareFreeEnergyDensity a t
          = coefficient * ((2 * (k.1 - 1) * (k.1 * a.1) : ℕ) : ℝ) * realLogarithm t +
              coefficient * ((k.1 ^ 2 : ℕ) : ℝ) * realLogarithm P := by
            -- 二つの定義と、有理数の約分
            rw [blockTiling_coefficient_cancel_t a k, blockTiling_coefficient_cancel_P a k]
            rfl
      _ = coefficient * (((2 * (k.1 - 1) * (k.1 * a.1) : ℕ) : ℝ) * realLogarithm t +
              ((k.1 ^ 2 : ℕ) : ℝ) * realLogarithm P) := by ring
      _ = coefficient * realLogarithm lower := by
            -- 第一の等式列
            rw [realLogarithm_blockTiling_lower_expand a.1 k.1 t P]
      _ ≤ coefficient * realLogarithm Q :=
            -- 正の係数の乗法
            mul_le_mul_of_nonneg_left hlogLower hcoefficient
      _ = openSquareFreeEnergyDensity (squareSide a k) t := rfl
  · calc
      openSquareFreeEnergyDensity (squareSide a k) t
          = coefficient * realLogarithm Q := rfl
      _ ≤ coefficient * realLogarithm upper :=
            mul_le_mul_of_nonneg_left hlogUpper hcoefficient
      _ = coefficient * (((k.1 ^ 2 : ℕ) : ℝ) * realLogarithm P) := by
            -- 第二の等式列
            rw [realLogarithm_blockTiling_upper_expand k.1 P]
      _ = (coefficient * ((k.1 ^ 2 : ℕ) : ℝ)) * realLogarithm P := by ring
      _ = openSquareFreeEnergyDensity a t := by
            rw [blockTiling_coefficient_cancel_P a k]
            rfl

/-- `claim_open_square_block_tiling_logarithm` の `1 ≤ t` の場合。不等式の向きだけが入れ替わる。 -/
theorem openSquareFreeEnergyDensity_blockTiling_bounds_of_one_le
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
  have hlogLower : realLogarithm lower ≤ realLogarithm Q := realLogarithm_mono lower Q hblock.1
  have hlogUpper : realLogarithm Q ≤ realLogarithm upper := realLogarithm_mono Q upper hblock.2
  constructor
  · calc
      openSquareFreeEnergyDensity a t
          = (coefficient * ((k.1 ^ 2 : ℕ) : ℝ)) * realLogarithm P := by
            rw [blockTiling_coefficient_cancel_P a k]
            rfl
      _ = coefficient * (((k.1 ^ 2 : ℕ) : ℝ) * realLogarithm P) := by ring
      _ = coefficient * realLogarithm lower := by
            rw [realLogarithm_blockTiling_upper_expand k.1 P]
      _ ≤ coefficient * realLogarithm Q :=
            mul_le_mul_of_nonneg_left hlogLower hcoefficient
      _ = openSquareFreeEnergyDensity (squareSide a k) t := rfl
  · calc
      openSquareFreeEnergyDensity (squareSide a k) t
          = coefficient * realLogarithm Q := rfl
      _ ≤ coefficient * realLogarithm upper :=
            mul_le_mul_of_nonneg_left hlogUpper hcoefficient
      _ = coefficient * (((2 * (k.1 - 1) * (k.1 * a.1) : ℕ) : ℝ) * realLogarithm t +
              ((k.1 ^ 2 : ℕ) : ℝ) * realLogarithm P) := by
            rw [realLogarithm_blockTiling_lower_expand a.1 k.1 t P]
      _ = coefficient * ((2 * (k.1 - 1) * (k.1 * a.1) : ℕ) : ℝ) * realLogarithm t +
              coefficient * ((k.1 ^ 2 : ℕ) : ℝ) * realLogarithm P := by ring
      _ = blockTilingCorrection a k t + openSquareFreeEnergyDensity a t := by
            rw [blockTiling_coefficient_cancel_t a k, blockTiling_coefficient_cancel_P a k]
            rfl

end Ising2DLambda.ThermodynamicLimit
