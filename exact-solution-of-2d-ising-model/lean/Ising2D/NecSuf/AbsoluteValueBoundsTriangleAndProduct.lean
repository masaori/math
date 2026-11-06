/-
# 絶対値: 絶対値との大小・0 以下の元の絶対値・三角不等式・積の絶対値（**必要十分版**）

対応する人手証明のラベル: `real_number_is_at_most_its_absolute_value`, `negative_absolute_value_is_at_most_real_number`,
`real_absolute_value_of_nonpositive`, `real_abs_triangle_inequality`, `real_abs_of_product`
（`structured-latex/content/000_calculation_formulae_00_09.ts`）。具体版は
`Ising2D/MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimRealAbsoluteValueBoundsTriangleAndProduct.lean`、
導出は同じフォルダの `ClaimRealAbsoluteValueBoundsTriangleAndProductFromNecSuf.lean`。

## 何が効いているか / 効いていないか

| 具体版 | 必要十分版（同じ場合分けと並び） | 効いている仮定 |
| --- | --- | --- |
| `real_number_is_at_most_its_absolute_value` | `le_abs'` | 加法についての群（可換でなくてよい）、全順序、左から同じ元を足しても `≤` が保たれること（`AddLeftMono`） |
| `negative_absolute_value_is_at_most_real_number` | `neg_abs_le'` | 同上 |
| `real_absolute_value_of_nonpositive` | `abs_of_nonpos'` | 同上 |
| `real_abs_triangle_inequality` | `abs_add_le'` | 同上に、加法の可換性（`AddCommGroup`）を足したもの。単調性は `IsOrderedAddMonoid` で置く（可換性の下では `AddLeftMono` と同じ内容で、`add_le_add` がこの形を要求する） |
| `real_abs_of_product` | `abs_mul'` | 上の 3 つの仮定（加法の群・全順序・`AddLeftMono`）に、符号の付け替え `-(ab) = a(-b) = (-a)b`・`ab = (-a)(-b)`、`a·0 = 0`、非負の元を左から掛けても `≤` が保たれること（`PosMulMono`。`0 ≤ a`、`0 ≤ b` から `0 ≤ ab`）を足したもの |

* 絶対値の定め方（`q ≥ 0` なら `|q| = q`、`q < 0` なら `|q| = -q`）を場合分けで使うので、全順序は外せない。`|q| = max(q, -q)` の `max` は全順序から来る。
* 加法の可換性が効くのは、三角不等式の `-(a + b) = (-a) + (-b)` の段と、`a ≤ |a|` に右から `b` を足す段（可換性と `AddLeftMono` から右の単調性が出る）だけである。
  ほかの 3 つの主張には効かない。
* 積の絶対値の `abs_mul'` は、符号の付け替え・`a·0 = 0`・`PosMulMono` を一度に与える型として非結合的な環 `NonUnitalNonAssocRing` を置く。
  この型が連れてくる加法の可換性と分配法則そのものは、上の段を与えるための便宜で、鎖の段としては使っていない。
  乗法の結合則・交換則・単位元は使わない（具体版の鎖は `a`、`b` の 2 つの因子の積しか扱わない）。
  正の元を掛けて `<` が保たれること、`0 < 1`、体であること、実数であることも効いていない。
-/
import Mathlib.Algebra.Order.AbsoluteValue.Basic
import Mathlib.Algebra.Order.Ring.Unbundled.Basic

namespace Ising2D.NecSuf

section AdditiveGroup

variable {R : Type*} [AddGroup R] [LinearOrder R] [AddLeftMono R]

/-- **`real_number_is_at_most_its_absolute_value`** の必要十分版: `q ≤ |q|`（具体版と同じ場合分け）。 -/
theorem le_abs' (q : R) : q ≤ |q| := by
  rcases le_or_gt 0 q with hq | hq
  · calc q
        = |q| := (abs_of_nonneg hq).symm                                      -- 絶対値の定め方（`q ≥ 0`）
      _ ≤ |q| := le_rfl
  · exact (calc q
        < 0 := hq
      _ < -q := neg_pos.mpr hq                                                -- `q < 0` の両辺の符号を反転する
      _ = |q| := (abs_of_neg hq).symm).le                                     -- 絶対値の定め方（`q < 0`）

/-- **`negative_absolute_value_is_at_most_real_number`** の必要十分版: `-|q| ≤ q`（具体版と同じ場合分け）。 -/
theorem neg_abs_le' (q : R) : -|q| ≤ q := by
  rcases le_or_gt 0 q with hq | hq
  · calc -|q|
        = -q := by rw [abs_of_nonneg hq]                                      -- 絶対値の定め方（`q ≥ 0`）
      _ ≤ 0 := neg_nonpos.mpr hq                                              -- `q ≥ 0` の両辺の符号を反転する
      _ ≤ q := hq
  · calc -|q|
        = -(-q) := by rw [abs_of_neg hq]                                      -- 絶対値の定め方（`q < 0`）
      _ = q := neg_neg q
      _ ≤ q := le_rfl

/-- **`real_absolute_value_of_nonpositive`** の必要十分版: `q ≤ 0` なら `|q| = -q`（`q < 0` と `q = 0` に分ける）。 -/
theorem abs_of_nonpos' {q : R} (hq : q ≤ 0) : |q| = -q := by
  rcases lt_or_eq_of_le hq with hlt | heq
  · exact abs_of_neg hlt
  · calc |q|
        = q := abs_of_nonneg heq.ge
      _ = 0 := heq
      _ = -0 := neg_zero.symm
      _ = -q := by rw [heq]

end AdditiveGroup

section AdditiveCommGroup

variable {R : Type*} [AddCommGroup R] [LinearOrder R] [IsOrderedAddMonoid R]

/-- **`real_abs_triangle_inequality`** の必要十分版: `|a + b| ≤ |a| + |b|`（具体版と同じ前置きと場合分け）。 -/
theorem abs_add_le' (a b : R) : |a + b| ≤ |a| + |b| := by
  have ha : a ≤ |a| := le_abs' a
  have hb : b ≤ |b| := le_abs' b
  have hna : -a ≤ |a| :=
    calc -a
        ≤ -(-|a|) := neg_le_neg (neg_abs_le' a)
      _ = |a| := neg_neg _
  have hnb : -b ≤ |b| :=
    calc -b
        ≤ -(-|b|) := neg_le_neg (neg_abs_le' b)
      _ = |b| := neg_neg _
  rcases le_or_gt 0 (a + b) with hab | hab
  · calc |a + b|
        = a + b := abs_of_nonneg hab
      _ ≤ |a| + b := add_le_add ha le_rfl                                     -- 右から `b` を足す（可換性と `AddLeftMono` による）
      _ ≤ |a| + |b| := add_le_add le_rfl hb
  · calc |a + b|
        = -(a + b) := abs_of_neg hab
      _ = (-a) + (-b) := neg_add a b                                          -- 加法の可換性が効く段
      _ ≤ |a| + (-b) := add_le_add hna le_rfl
      _ ≤ |a| + |b| := add_le_add le_rfl hnb

end AdditiveCommGroup

section Multiplicative

variable {R : Type*} [NonUnitalNonAssocRing R] [LinearOrder R] [AddLeftMono R] [PosMulMono R]

/-- **`real_abs_of_product`** の必要十分版: `|ab| = |a||b|`（具体版と同じ 4 つの場合分けと並び）。 -/
theorem abs_mul' (a b : R) : |a * b| = |a| * |b| := by
  rcases le_or_gt 0 a with ha | ha <;> rcases le_or_gt 0 b with hb | hb
  · have hab : 0 ≤ a * b := mul_nonneg ha hb
    calc |a * b|
        = a * b := abs_of_nonneg hab
      _ = |a| * b := by rw [abs_of_nonneg ha]
      _ = |a| * |b| := by rw [abs_of_nonneg hb]
  · have h0 : 0 ≤ a * (-b) := mul_nonneg ha (neg_pos.mpr hb).le
    have hab : a * b ≤ 0 := by
      have : a * b = -(a * (-b)) := by rw [mul_neg, neg_neg]
      rw [this]; exact neg_nonpos.mpr h0
    calc |a * b|
        = -(a * b) := abs_of_nonpos' hab
      _ = a * (-b) := (mul_neg a b).symm
      _ = |a| * (-b) := by rw [abs_of_nonneg ha]
      _ = |a| * |b| := by rw [abs_of_neg hb]
  · have h0 : 0 ≤ (-a) * b := mul_nonneg (neg_pos.mpr ha).le hb
    have hab : a * b ≤ 0 := by
      have : a * b = -((-a) * b) := by rw [neg_mul, neg_neg]
      rw [this]; exact neg_nonpos.mpr h0
    calc |a * b|
        = -(a * b) := abs_of_nonpos' hab
      _ = (-a) * b := (neg_mul a b).symm
      _ = |a| * b := by rw [abs_of_neg ha]
      _ = |a| * |b| := by rw [abs_of_nonneg hb]
  · have hab : 0 ≤ a * b := by
      rw [← neg_mul_neg]
      exact mul_nonneg (neg_pos.mpr ha).le (neg_pos.mpr hb).le
    calc |a * b|
        = a * b := abs_of_nonneg hab
      _ = (-a) * (-b) := (neg_mul_neg a b).symm
      _ = |a| * (-b) := by rw [abs_of_neg ha]
      _ = |a| * |b| := by rw [abs_of_neg hb]

end Multiplicative

end Ising2D.NecSuf
