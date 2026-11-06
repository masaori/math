/-
# 実数の絶対値: 絶対値との大小・0 以下の実数の絶対値・三角不等式・積の絶対値（**具体版**）

対応する人手証明のラベル: `def_real_absolute_value`, `real_number_is_at_most_its_absolute_value`,
`negative_absolute_value_is_at_most_real_number`, `real_absolute_value_of_nonpositive`, `real_abs_triangle_inequality`, `real_abs_of_product`
（`structured-latex/content/000_calculation_formulae_00_09.ts` の `calc_formulae_definition_real_absolute_value`,
`calc_formulae_claim_real_number_is_at_most_its_absolute_value`, `calc_formulae_claim_negative_absolute_value_is_at_most_real_number`,
`calc_formulae_claim_real_absolute_value_of_nonpositive`, `calc_formulae_claim_real_abs_triangle_inequality`, `calc_formulae_claim_real_abs_of_product`）。

**必要十分版**: `Ising2D/NecSuf/AbsoluteValueBoundsTriangleAndProduct.lean`。具体版をその系として導くのは
`ClaimRealAbsoluteValueBoundsTriangleAndProductFromNecSuf.lean`。

## 人手証明との対応

* 人手 `def_real_absolute_value`（`q ≥ 0` なら `|q| = q`、`q < 0` なら `|q| = -q`）は、Lean の `|q|`（mathlib では `max q (-q)`）を
  mathlib の `abs_of_nonneg`・`abs_of_neg` で場合分けの形へ開いて読む。この 2 つが定義の 2 つの場合の行に当たる。
* 各定理は人手と同じ場合分けをし、各場合の鎖を人手の行と 1 対 1 の `calc` にした
  （`real_number_is_at_most_its_absolute_value` は 1 行・3 行、`negative_absolute_value_is_at_most_real_number` は 3 行・2 行、
  `real_absolute_value_of_nonpositive` の `q = 0` は 4 行、`real_abs_triangle_inequality` は前置きの 2 本の 2 行と 3 行・4 行、
  `real_abs_of_product` は 3 行・4 行・4 行・4 行）。人手の鎖が等号で終わる場合（`q ≥ 0` の `q = |q|`、`q < 0` の `-|q| = q`）は、
  主張の `≤` へ移す `le_rfl` を 1 段足した。
* 「非負の実数の積は非負」は `mul_nonneg`、「両辺の符号を反転する」は `neg_le_neg`・`neg_pos`・`neg_nonpos`、
  「ℝ で `-(ab) = a(-b)`」などの符号の付け替えは `mul_neg`・`neg_mul`・`neg_mul_neg` の 1 段ずつである。
-/
import Mathlib.Algebra.Order.AbsoluteValue.Basic
import Mathlib.Data.Real.Basic

namespace Ising2D

/-- **`real_number_is_at_most_its_absolute_value`**: `q ∈ ℝ` について `q ≤ |q|`。 -/
theorem real_number_is_at_most_its_absolute_value (q : ℝ) : q ≤ |q| := by
  rcases le_or_gt 0 q with hq | hq
  · -- `q ≥ 0` のとき
    calc q
        = |q| := (abs_of_nonneg hq).symm                                      -- `def_real_absolute_value`（`q ≥ 0`）
      _ ≤ |q| := le_rfl
  · -- `q < 0` のとき
    exact (calc q
        < 0 := hq                                                             -- `q < 0`
      _ < -q := neg_pos.mpr hq                                                -- `q < 0` の両辺の符号を反転する
      _ = |q| := (abs_of_neg hq).symm).le                                     -- `def_real_absolute_value`（`q < 0`）

/-- **`negative_absolute_value_is_at_most_real_number`**: `q ∈ ℝ` について `-|q| ≤ q`。 -/
theorem negative_absolute_value_is_at_most_real_number (q : ℝ) : -|q| ≤ q := by
  rcases le_or_gt 0 q with hq | hq
  · -- `q ≥ 0` のとき
    calc -|q|
        = -q := by rw [abs_of_nonneg hq]                                      -- `def_real_absolute_value`（`q ≥ 0`）
      _ ≤ 0 := neg_nonpos.mpr hq                                              -- `q ≥ 0` の両辺の符号を反転する
      _ ≤ q := hq                                                             -- `q ≥ 0`
  · -- `q < 0` のとき
    calc -|q|
        = -(-q) := by rw [abs_of_neg hq]                                      -- `def_real_absolute_value`（`q < 0`）
      _ = q := neg_neg q                                                      -- ℝ で `-(-q) = q`
      _ ≤ q := le_rfl

/-- **`real_absolute_value_of_nonpositive`**: `q ≤ 0` なら `|q| = -q`（`q < 0` は定義そのもの、`q = 0` は 4 行の鎖）。 -/
theorem real_absolute_value_of_nonpositive {q : ℝ} (hq : q ≤ 0) : |q| = -q := by
  rcases lt_or_eq_of_le hq with hlt | heq
  · exact abs_of_neg hlt                                                      -- `def_real_absolute_value`（`q < 0`）
  · calc |q|
        = q := abs_of_nonneg heq.ge                                           -- `def_real_absolute_value`（`q ≥ 0`）
      _ = 0 := heq                                                            -- `q = 0`
      _ = -0 := neg_zero.symm                                                 -- ℝ で `-0 = 0`
      _ = -q := by rw [heq]                                                   -- `q = 0`

/-- **`real_abs_triangle_inequality`**: `a, b ∈ ℝ` について `|a + b| ≤ |a| + |b|`。 -/
theorem real_abs_triangle_inequality (a b : ℝ) : |a + b| ≤ |a| + |b| := by
  have ha : a ≤ |a| := real_number_is_at_most_its_absolute_value a            -- `real_number_is_at_most_its_absolute_value`（`q → a`）
  have hb : b ≤ |b| := real_number_is_at_most_its_absolute_value b            -- 同（`q → b`）
  have hna : -a ≤ |a| :=
    calc -a
        ≤ -(-|a|) := neg_le_neg (negative_absolute_value_is_at_most_real_number a)
                                                                              -- `negative_absolute_value_is_at_most_real_number`（`q → a`）の両辺の符号を反転する
      _ = |a| := neg_neg _                                                    -- ℝ で `-(-|a|) = |a|`
  have hnb : -b ≤ |b| :=
    calc -b
        ≤ -(-|b|) := neg_le_neg (negative_absolute_value_is_at_most_real_number b)
                                                                              -- 同（`q → b`）の両辺の符号を反転する
      _ = |b| := neg_neg _                                                    -- ℝ で `-(-|b|) = |b|`
  rcases le_or_gt 0 (a + b) with hab | hab
  · -- `a + b ≥ 0` のとき
    calc |a + b|
        = a + b := abs_of_nonneg hab                                          -- `def_real_absolute_value`（`a + b ≥ 0`）
      _ ≤ |a| + b := add_le_add ha le_rfl                                     -- `a ≤ |a|` の両辺に `b` を足す
      _ ≤ |a| + |b| := add_le_add le_rfl hb                                   -- `b ≤ |b|` の両辺に `|a|` を足す
  · -- `a + b < 0` のとき
    calc |a + b|
        = -(a + b) := abs_of_neg hab                                          -- `def_real_absolute_value`（`a + b < 0`）
      _ = (-a) + (-b) := neg_add a b                                          -- ℝ で `-(a + b) = (-a) + (-b)`
      _ ≤ |a| + (-b) := add_le_add hna le_rfl                                 -- `-a ≤ |a|` の両辺に `-b` を足す
      _ ≤ |a| + |b| := add_le_add le_rfl hnb                                  -- `-b ≤ |b|` の両辺に `|a|` を足す

/-- **`real_abs_of_product`**: `a, b ∈ ℝ` について `|ab| = |a||b|`。`a`、`b` の符号で 4 つに場合を分ける。 -/
theorem real_abs_of_product (a b : ℝ) : |a * b| = |a| * |b| := by
  rcases le_or_gt 0 a with ha | ha <;> rcases le_or_gt 0 b with hb | hb
  · -- `a ≥ 0` かつ `b ≥ 0`
    have hab : 0 ≤ a * b := mul_nonneg ha hb                                  -- 非負の実数の積は非負
    calc |a * b|
        = a * b := abs_of_nonneg hab                                          -- `def_real_absolute_value`（`ab ≥ 0`）
      _ = |a| * b := by rw [abs_of_nonneg ha]                                 -- `def_real_absolute_value`（`a ≥ 0`）
      _ = |a| * |b| := by rw [abs_of_nonneg hb]                               -- `def_real_absolute_value`（`b ≥ 0`）
  · -- `a ≥ 0` かつ `b < 0`
    have h0 : 0 ≤ a * (-b) := mul_nonneg ha (neg_pos.mpr hb).le              -- `-b > 0` なので非負の実数の積
    have hab : a * b ≤ 0 := by
      have : a * b = -(a * (-b)) := by rw [mul_neg, neg_neg]                  -- `ab = -(a(-b))`
      rw [this]; exact neg_nonpos.mpr h0
    calc |a * b|
        = -(a * b) := real_absolute_value_of_nonpositive hab                  -- `real_absolute_value_of_nonpositive`（`q → ab`）
      _ = a * (-b) := (mul_neg a b).symm                                      -- ℝ で `-(ab) = a(-b)`
      _ = |a| * (-b) := by rw [abs_of_nonneg ha]                              -- `def_real_absolute_value`（`a ≥ 0`）
      _ = |a| * |b| := by rw [abs_of_neg hb]                                  -- `def_real_absolute_value`（`b < 0`）
  · -- `a < 0` かつ `b ≥ 0`
    have h0 : 0 ≤ (-a) * b := mul_nonneg (neg_pos.mpr ha).le hb              -- `-a > 0` なので非負の実数の積
    have hab : a * b ≤ 0 := by
      have : a * b = -((-a) * b) := by rw [neg_mul, neg_neg]                  -- `ab = -((-a)b)`
      rw [this]; exact neg_nonpos.mpr h0
    calc |a * b|
        = -(a * b) := real_absolute_value_of_nonpositive hab                  -- `real_absolute_value_of_nonpositive`（`q → ab`）
      _ = (-a) * b := (neg_mul a b).symm                                      -- ℝ で `-(ab) = (-a)b`
      _ = |a| * b := by rw [abs_of_neg ha]                                    -- `def_real_absolute_value`（`a < 0`）
      _ = |a| * |b| := by rw [abs_of_nonneg hb]                               -- `def_real_absolute_value`（`b ≥ 0`）
  · -- `a < 0` かつ `b < 0`
    have hab : 0 ≤ a * b := by
      rw [← neg_mul_neg]                                                      -- `ab = (-a)(-b)`
      exact mul_nonneg (neg_pos.mpr ha).le (neg_pos.mpr hb).le                -- `-a > 0`、`-b > 0` なので非負の実数の積
    calc |a * b|
        = a * b := abs_of_nonneg hab                                          -- `def_real_absolute_value`（`ab ≥ 0`）
      _ = (-a) * (-b) := (neg_mul_neg a b).symm                               -- ℝ で `ab = (-a)(-b)`
      _ = |a| * (-b) := by rw [abs_of_neg ha]                                 -- `def_real_absolute_value`（`a < 0`）
      _ = |a| * |b| := by rw [abs_of_neg hb]                                  -- `def_real_absolute_value`（`b < 0`）

end Ising2D
