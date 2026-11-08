/-
# 正の実数の二乗の一意性（具体版）

正本: `structured-latex/content/000_calculation_formulae_00_09.ts`
（`calc_formulae_000c0_claim_positive_real_square_injective`、ラベル **`positive_real_square_injective`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| `a = b ⇒ a^2 = b^2`（`a^2` の `a` へ `a = b` を代入する） | `positive_real_square_injective` の `mpr`（`rw [h]`） |
| `(a-b)(a+b)` から `0` までの 8 行の鎖（分配法則 2 回・乗法の交換法則・打ち消し・`square_of_real_number_is_product`（`r → a`、`r → b`）・`a^2 = b^2`・`b^2 − b^2 = 0`） | `factor_difference_of_squares_eq_zero` の `calc` の 8 段 |
| `a + b > 0`、`a + b ≠ 0`、ℝ は整域で `a - b = 0`、`b` を加えて `a = b` の 4 行 | `hpos`・`hne`・`hsub`・最後の行 |

- 人手の二乗は `def_power_of_real_number` の冪（`m = 2`）で、Lean の `a ^ 2`（`Monoid.npow`）である。積の形は
  `square_of_real_number_is_product` から引く（mathlib の `sq`・`pow_two`・`ring` は使わない）。

必要十分版は `Ising2D/NecSuf/PositiveSquareInjective.lean` の `NecSuf.positive_square_injective'`
（零因子の無い環で、`b a = a b`、前順序と `AddLeftStrictMono` だけ）。特殊化は `ClaimPositiveRealSquareInjectiveFromNecSuf.lean`。
-/
import Mathlib.Data.Real.Basic
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimSquareOfRealNumberIsProduct

namespace Ising2D

/-- **人手 `positive_real_square_injective` の逆向きの鎖**: `a^2 = b^2` なら `(a-b)(a+b) = 0`（人手の 8 行と 1 対 1 の `calc`）。 -/
theorem factor_difference_of_squares_eq_zero {a b : ℝ} (h : a ^ 2 = b ^ 2) :
    (a - b) * (a + b) = 0 :=
  calc (a - b) * (a + b)
      = (a - b) * a + (a - b) * b := mul_add (a - b) a b                      -- ℝ の分配法則
    _ = (a * a - b * a) + (a * b - b * b) := by rw [sub_mul a b a, sub_mul a b b]  -- ℝ の分配法則
    _ = (a * a - a * b) + (a * b - b * b) := by rw [mul_comm b a]             -- ℝ の乗法の交換法則 `b a = a b`
    _ = a * a - b * b := sub_add_sub_cancel (a * a) (a * b) (b * b)           -- `-ab` と `ab` が打ち消し合う
    _ = a ^ 2 - b * b := by rw [square_of_real_number_is_product a]           -- `square_of_real_number_is_product`（`r → a`）を右辺から左辺へ
    _ = a ^ 2 - b ^ 2 := by rw [square_of_real_number_is_product b]           -- `square_of_real_number_is_product`（`r → b`）を右辺から左辺へ
    _ = b ^ 2 - b ^ 2 := by rw [h]                                            -- `a^2 = b^2`
    _ = 0 := sub_self (b ^ 2)                                                 -- `b^2 − b^2 = 0`（ℝ の加法の逆元）

/-- **人手 `positive_real_square_injective`**: `a, b ∈ ℝ_{>0}` について `a^2 = b^2 ⟺ a = b`。 -/
theorem positive_real_square_injective {a b : ℝ} (ha : 0 < a) (hb : 0 < b) :
    a ^ 2 = b ^ 2 ↔ a = b := by
  constructor
  · intro h
    have h1 : (a - b) * (a + b) = 0 := factor_difference_of_squares_eq_zero h
    have hpos : a + b > 0 := add_pos ha hb               -- 正の実数の和は正
    have hne : a + b ≠ 0 := ne_of_gt hpos                -- 正の実数は 0 でない
    have hsub : a - b = 0 :=
      (mul_eq_zero.1 h1).resolve_right hne               -- ℝ は整域
    exact sub_eq_zero.1 hsub                             -- 両辺に `b` を加える
  · intro h
    rw [h]                                               -- `a^2` の `a` へ `a = b` を代入する

end Ising2D
