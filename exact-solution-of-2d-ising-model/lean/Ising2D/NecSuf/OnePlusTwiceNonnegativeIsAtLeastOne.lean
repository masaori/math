/-
# `1 + 2t² ≥ 1`（**必要十分版**）

対応する人手証明のラベル（具体版は
`Ising2D/MathematicalTools/RealSquareRootExponentialAndHyperbolicFunctions/ClaimCoshAtLeastOne.lean`）: `cosh_at_least_one`。

## 何が効いているか / 効いていないか

| 具体版（`ℝ` の `cosh`） | 必要十分版 | 仮定 |
| --- | --- | --- |
| `cosh_at_least_one`（含意の 3 式と鎖の 3 段） | `one_add_two_mul_sq_ge_one'`（同じ 3 式と 3 段） | 半環であること（`Semiring`）、全順序（`LinearOrder`）、`a ≤ b` なら `a + c = b` の `c` があること（`ExistsAddOfLE`）、非負の数を左から掛けると順序が保たれること（`PosMulMono`）、和が順序を保つこと（`AddLeftMono`）だけ |

* 人手の含意の鎖の 3 式（平方は非負、両辺に `2` を掛ける、両辺に `1` を加える）と、続く鎖の 3 段（半角公式、含意の鎖、四則）は、
  必要十分版の `h0`・`h1`・`h2` と `calc` の 3 段と同じ並びである。半角公式 `cosh x = 1 + 2sinh²(x/2)` は、仮定
  `hh : h = 1 + 2 * t ^ 2` として置く。
* `cosh`・`sinh`・`exp` の性質は効いていない（`h` と `t` は `hh` を満たす任意の元でよい）。乗法の可換性、符号反転と減法（環であること）、
  逆元（体であること）、完備性も効いていない。
* 全順序と `ExistsAddOfLE` は外せない（1 式目の「平方は非負」を、`t ≥ 0` と `t < 0` の場合分けで示すのに使う。mathlib の `sq_nonneg`）。
  `PosMulMono` は 1 式目と 2 式目（`2 ≥ 0` を左から掛ける）に、`AddLeftMono` は 1 式目と 3 式目（`1` を加える）と `2 ≥ 0` に要る。
  `2 ≥ 0`（`zero_le_two`）が使う `0 ≤ 1` は仮定に置かない。残りの仮定から mathlib の instance（`0 ≤ 1·1` を平方の非負性で示す）で出る。
-/
import Mathlib.Algebra.Order.Ring.Unbundled.Basic
import Mathlib.Algebra.Order.Monoid.NatCast

namespace Ising2D.NecSuf

/-- **`h ≥ 1`**（具体版 `cosh_at_least_one`）。`h = 1 + 2t²` と書ける `h` は `1` 以上である。 -/
theorem one_add_two_mul_sq_ge_one' {S : Type*} [Semiring S] [LinearOrder S] [ExistsAddOfLE S]
    [PosMulMono S] [AddLeftMono S]
    (h t : S) (hh : h = 1 + 2 * t ^ 2) : h ≥ 1 := by
  have h0 : t ^ 2 ≥ 0 := sq_nonneg t                    -- 平方は非負
  have h1 : 2 * t ^ 2 ≥ 2 * 0 :=
    mul_le_mul_of_nonneg_left h0 zero_le_two           -- 両辺に `2 ≥ 0` を掛ける
  have h2 : 1 + 2 * t ^ 2 ≥ 1 + 2 * 0 :=
    add_le_add_right h1 1                              -- 両辺に `1` を加える
  calc h
      = 1 + 2 * t ^ 2 := hh                             -- `h` の表示（具体版の半角公式）
    _ ≥ 1 + 2 * 0 := h2                                 -- 上の含意の鎖
    _ = 1 := by rw [mul_zero, add_zero]                 -- 半環の `a·0 = 0` と `a + 0 = a`

end Ising2D.NecSuf
