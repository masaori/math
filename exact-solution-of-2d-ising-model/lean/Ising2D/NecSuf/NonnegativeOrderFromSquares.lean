/-
# 平方の大小から非負の元の大小へ（**必要十分版**）

対応する人手証明のラベル: `nonnegative_real_order_from_squares`（`structured-latex/content/020_critical_point.ts`）。
具体版は `Ising2D/MathematicalTools/RealSquareRootExponentialAndHyperbolicFunctions/ClaimNonnegativeRealOrderFromSquares.lean`、
導出は同じフォルダの `ClaimNonnegativeRealOrderFromSquaresFromNecSuf.lean`。

## 何が効いているか / 効いていないか

| 具体版の段 | 必要十分版 | 効いている仮定 |
| --- | --- | --- |
| `v < u` と仮定する | `lt_of_not_ge` | 順序が全順序であること（`LinearOrder`） |
| `0 ≤ v < u` なので `u > 0` | `lt_of_le_of_lt` | 前順序の推移律 |
| 1 行目 `v^2 = v·v` | （無い。主張を `v·v`・`u·u` で述べる） | — |
| 2 行目 `v·v ≤ v·u` | `mul_le_mul_of_nonneg_left` | 非負の元を左から掛けても `≤` が保たれる（`PosMulMono`） |
| 3 行目 `v·u < u·u` | `mul_lt_mul_of_pos_right` | 正の元を右から掛けると `<` が保たれる（`MulPosStrictMono`） |
| 4 行目 `u·u = u^2` | （無い） | — |

* 効いているのは、全順序と、乗法の片側ずつの単調性（左からの非負の元の掛け算で `≤`、右からの正の元の掛け算で `<`）だけである。
  加法、乗法の結合則・交換則・単位元、`0` が乗法の零であること、実数であることは効いていない。`u ≥ 0` も使わない（具体版も同じ）。
* 全順序は外せない。`u ≤ v` でないことから `v < u` を得る段がある。
* 冪 `^2` はモノイドの構造を要するので、必要十分版は平方を `u·u` で述べる。具体版の 1 行目・4 行目は冪の定義を開く段で、ここには無い。
-/
import Mathlib.Algebra.Order.GroupWithZero.Defs

namespace Ising2D.NecSuf

variable {R : Type*} [Mul R] [Zero R] [LinearOrder R] [PosMulMono R] [MulPosStrictMono R]

/-- **`nonnegative_real_order_from_squares`** の必要十分版: `0 ≤ v` かつ `u·u ≤ v·v` なら `u ≤ v`（具体版と同じ背理法の段）。 -/
theorem order_from_squares' {u v : R} (hv : 0 ≤ v) (h : u * u ≤ v * v) : u ≤ v := by
  by_contra hnot
  have hvu : v < u := lt_of_not_ge hnot                                     -- `v < u` と仮定する
  have hupos : 0 < u := lt_of_le_of_lt hv hvu                               -- `0 ≤ v < u` なので `u > 0`
  have hlt : v * v < u * u :=
    calc v * v
        ≤ v * u := mul_le_mul_of_nonneg_left hvu.le hv                      -- 具体版の 2 行目
      _ < u * u := mul_lt_mul_of_pos_right hvu hupos                        -- 具体版の 3 行目
  exact absurd h (not_le.mpr hlt)                                           -- `u·u ≤ v·v` に矛盾する

end Ising2D.NecSuf
