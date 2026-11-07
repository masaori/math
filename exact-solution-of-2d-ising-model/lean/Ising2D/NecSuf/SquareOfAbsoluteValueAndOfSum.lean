/-
# 絶対値の二乗と、二つの元の和の二乗の評価（**必要十分版**）

対応する人手証明のラベル: `square_of_real_absolute_value`, `square_of_real_sum_is_at_most_twice_sum_of_squares`
（`structured-latex/content/000_calculation_formulae_00_09.ts`）。具体版は
`Ising2D/MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimSquareOfRealAbsoluteValueAndOfRealSum.lean`、
導出は同じフォルダの `ClaimSquareOfRealAbsoluteValueAndOfRealSumFromNecSuf.lean`。

## 何が効いているか / 効いていないか

| 具体版 | 必要十分版（同じ場合分けと並び） | 効いている仮定 |
| --- | --- | --- |
| `square_of_real_absolute_value` | `sq_abs'` | 全順序と、加法の群と左から同じ元を足しても `≤` が保たれること（`AddLeftMono`。絶対値の定め方の場合分け `abs_of_nonneg`・`abs_of_neg` に要る）、符号の付け替え `(-a)(-a) = aa` |
| `square_of_real_sum_is_at_most_twice_sum_of_squares` | `add_sq_le_two_mul_add'` | 全順序（平方が非負であることは符号の場合分けから来る）、順序と加法・乗法の両立（`IsOrderedRing`）、分配則。乗法の可換性は効いていない |

* `sq_abs'` は環 `Ring` を置く。鎖が使うのは、絶対値の場合分けに要る加法の群（`AddGroup`）と、`(-q)^2 = q^2` に要る
  符号の付け替え（`Monoid` と `HasDistribNeg`）だけである。しかし `AddGroup` と `HasDistribNeg` を別々に仮定すると、それぞれが
  別の符号反転 `Neg` を持ち込み、`|q|` の中の `-q` と `(-q)^2` の `-q` が同じ演算にならない。二つを一つの符号反転で結ぶ最小の既製の型として `Ring` を置いた。
  この型が連れてくる加法の可換性・分配法則・乗法の結合則は、鎖の段としては使っていない。順序と乗法の両立も効いていない。
* `add_sq_le_two_mul_add'` は環 `Ring` で通る。人手の展開は `ab` と `ba` を分けたまま `(a + b)^2 + (a - b)^2 = 2a^2 + 2b^2` に着くので、
  乗法の可換性は効いていない。平方が非負であること（`sq_nonneg`）に全順序と `IsOrderedRing` が要る。体であること、実数であること、完備性は効いていない。
-/
import Mathlib.Algebra.Order.Ring.Abs
import Mathlib.Tactic.Ring
import Mathlib.Tactic.NoncommRing

namespace Ising2D.NecSuf

section AbsoluteValue

variable {R : Type*} [Ring R] [LinearOrder R] [AddLeftMono R]

/-- **`square_of_real_absolute_value`** の必要十分版: `|q|^2 = q^2`（具体版と同じ場合分け）。 -/
theorem sq_abs' (q : R) : |q| ^ 2 = q ^ 2 := by
  rcases le_or_gt 0 q with hq | hq
  · rw [abs_of_nonneg hq]                                                      -- 絶対値の定め方（`q ≥ 0`）（1 行の鎖）
  · calc |q| ^ 2
        = (-q) ^ 2 := by rw [abs_of_neg hq]                                   -- 絶対値の定め方（`q < 0`）
      _ = q ^ 2 := neg_sq q                                                   -- `(-a)(-b) = ab`（`a, b → q`）

end AbsoluteValue

section SumOfSquares

variable {R : Type*} [Ring R] [LinearOrder R] [IsOrderedRing R]

/-- **`square_of_real_sum_is_at_most_twice_sum_of_squares`** の必要十分版: `(a + b)^2 ≤ 2a^2 + 2b^2`（具体版と同じ 4 段）。
乗法の可換性は仮定しない（展開を `ab + ba` のまま書くので要らない）。 -/
theorem add_sq_le_two_mul_add' (a b : R) :
    (a + b) ^ 2 ≤ 2 * a ^ 2 + 2 * b ^ 2 :=
  calc (a + b) ^ 2
      = (a + b) ^ 2 + 0 := (add_zero _).symm                                  -- 加法の単位元
    _ ≤ (a + b) ^ 2 + (a - b) ^ 2 :=
        add_le_add le_rfl (sq_nonneg (a - b))                                 -- 準備の `0 ≤ (a - b)^2`（平方は非負。全順序と `IsOrderedRing`）と順序と加法の両立
    _ = (a ^ 2 + a * b + b * a + b ^ 2) + (a ^ 2 - a * b - b * a + b ^ 2) := by
        noncomm_ring                                                          -- 分配則による展開を 2 か所へ（可換性を使わない）
    _ = 2 * a ^ 2 + 2 * b ^ 2 := by noncomm_ring                              -- 加法と減法の計算

end SumOfSquares

end Ising2D.NecSuf
