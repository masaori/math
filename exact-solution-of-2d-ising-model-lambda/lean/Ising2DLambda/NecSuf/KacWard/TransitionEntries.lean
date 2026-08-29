/-
必要十分版: 符号付き回転位相の 8 乗が 1 になることを、体の四則と
「s² = 1」「z⁴ = -1」「位相は 1, z, z⁻¹ のどれか」だけから示す。

人手証明（`claim_transition_entries_in_mu8` の第二の場合）と同じ手順:
  (s r)⁸ = s⁸ r⁸ = (s²)⁴ r⁸ = r⁸、そして r の三つの場合で r⁸ = 1。
体を仮定するのは右回転の場合が逆元 z⁻¹ を使うためである
（他の二つの場合は可換環で足りる）。
-/
import Mathlib.Algebra.Order.Field.Basic

namespace Ising2DLambda.NecSuf.KacWard

/-- 人手証明の準備の鎖。`z⁴ = -1` ならば `z⁸ = 1`（左回転の場合の 4 段）。 -/
theorem pow_eight_of_pow_four_neg_one {K : Type} [Field K]
    {z : K} (hz : z ^ 4 = -1) : z ^ 8 = 1 := by
  calc z ^ 8
      = (z ^ 4) ^ 2 := by rw [← pow_mul]      -- 指数法則 y⁸ = (y⁴)²。
    _ = (-1 : K) ^ 2 := by rw [hz]            -- 約束 z⁴ = -1 の代入。
    _ = 1 := neg_one_sq                       -- (-1)·(-1) = 1。

/-- 人手証明の本体。符号 `s`（`s² = 1`）と位相 `r ∈ {1, z, z⁻¹}` の積の 8 乗は 1。 -/
theorem signed_phase_pow_eight {K : Type} [Field K]
    {z s r : K} (hz : z ^ 4 = -1) (hs : s ^ 2 = 1)
    (hr : r = 1 ∨ r = z ∨ r = z⁻¹) : (s * r) ^ 8 = 1 := by
  -- 第一の鎖: (s r)⁸ = s⁸ r⁸ = (s²)⁴ r⁸ = 1⁴ r⁸ = r⁸。
  have hsr : (s * r) ^ 8 = r ^ 8 := by
    calc (s * r) ^ 8
        = s ^ 8 * r ^ 8 := mul_pow s r 8          -- 積の冪の分配。
      _ = (s ^ 2) ^ 4 * r ^ 8 := by rw [← pow_mul] -- 指数法則 y⁸ = (y²)⁴。
      _ = (1 : K) ^ 4 * r ^ 8 := by rw [hs]        -- 仮定 s² = 1 の代入。
      _ = r ^ 8 := by rw [one_pow, one_mul]        -- 単位元の冪と積。
  rw [hsr]
  -- 第二の鎖: r の三つの場合。
  rcases hr with h1 | hz1 | hzinv
  · -- 直進の場合: 1⁸ = 1。
    rw [h1, one_pow]
  · -- 左回転の場合: z⁸ = (z⁴)² = (-1)² = 1。
    rw [hz1]
    exact pow_eight_of_pow_four_neg_one hz
  · -- 右回転の場合: (z⁻¹)⁸ = (z⁸)⁻¹ = 1⁻¹ = 1。
    calc r ^ 8
        = (z ⁻¹) ^ 8 := by rw [hzinv]              -- 場合の仮定の代入。
      _ = (z ^ 8) ⁻¹ := inv_pow z 8                 -- 体の逆元の冪。
      _ = (1 : K) ⁻¹ := by rw [pow_eight_of_pow_four_neg_one hz] -- 左回転で示した z⁸ = 1。
      _ = 1 := inv_one                               -- 単位元の逆元。

end Ising2DLambda.NecSuf.KacWard
