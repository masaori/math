/-
# 平方の大小から非負の実数の大小へ（具体版）

正本: `structured-latex/content/020_critical_point.ts`
（`critical_claim_nonnegative_real_order_from_squares`、ラベル **`nonnegative_real_order_from_squares`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| `v < u` と仮定する | `hvu` |
| `0 ≤ v < u` なので `u > 0` | `hupos` |
| `v^2 = v·v ≤ v·u < u·u = u^2` の 4 行 | `hlt` の `calc` の 4 段 |
| `u^2 ≤ v^2` に矛盾する | 最後の行 |

必要十分版は `Ising2D/NecSuf/NonnegativeOrderFromSquares.lean` の `NecSuf.order_from_squares'`
（全順序と `PosMulMono`・`MulPosStrictMono` だけ）。特殊化は `ClaimNonnegativeRealOrderFromSquaresFromNecSuf.lean`。
人手の `v^2` は `v·v` の略記で、Lean の `v ^ 2` は `sq` で `v * v` に読み替える。
-/
import Mathlib.Data.Real.Basic
import Mathlib.Algebra.Order.GroupWithZero.Defs

namespace Ising2D

/-- **`nonnegative_real_order_from_squares`**: `u, v ∈ ℝ_{≥0}` が `u^2 ≤ v^2` を満たすなら `u ≤ v`。
人手と同じく `v < u` を仮定して `v^2 < u^2` を導き、矛盾させる。`u ≥ 0` は人手の証明でも使わない。 -/
theorem nonnegative_real_order_from_squares {u v : ℝ} (_hu : 0 ≤ u) (hv : 0 ≤ v)
    (h : u ^ 2 ≤ v ^ 2) : u ≤ v := by
  by_contra hnot
  have hvu : v < u := lt_of_not_ge hnot                                     -- `v < u` と仮定する
  have hupos : 0 < u := lt_of_le_of_lt hv hvu                               -- `0 ≤ v < u` なので `u > 0`
  have hlt : v ^ 2 < u ^ 2 :=
    calc v ^ 2
        = v * v := sq v                                                     -- 1 行目: `v^2 = v·v`
      _ ≤ v * u := mul_le_mul_of_nonneg_left hvu.le hv                      -- 2 行目: `v < u` の両辺に `v ≥ 0` を掛ける
      _ < u * u := mul_lt_mul_of_pos_right hvu hupos                        -- 3 行目: `v < u` の両辺に `u > 0` を掛ける
      _ = u ^ 2 := (sq u).symm                                              -- 4 行目: `u·u = u^2`
  exact absurd h (not_le.mpr hlt)                                           -- `u^2 ≤ v^2` に矛盾する

end Ising2D
