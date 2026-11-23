/-
# 整数に 0 を左から掛けると 0 になる（**具体版**）

正本: `structured-latex/content/000_calculation_formulae_00_09.ts`
（`calc_formulae_claim_integer_zero_times_is_zero`、ラベル **`int_zero_times_is_zero`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 6 行の鎖（和の単位元を右辺から左辺へ → 加法の逆元を右辺から左辺へ → 加法の結合律を右辺から左辺へ → 分配律 `(y+z)t = yt+zt` を右辺から左辺へ → `0 + 0 = 0` → 加法の逆元） | `int_zero_times_is_zero` の `calc` の 6 段 |

- `set_and_algebra_notation` の ℤ の行のうち、和の単位元 `y + 0 = y` は `add_zero`、加法の逆元 `y + (−y) = 0` は `add_neg_cancel`、
  加法の結合律は `add_assoc`、分配律 `(y + z)·t = y·t + z·t` は `add_mul` で読む。
- mathlib の `zero_mul`・`MulZeroClass` は使わない（人手の鎖をそのまま書くため）。

必要十分版は `real_zero_times_is_zero` と同じ `Ising2D/NecSuf/ZeroMulOfRightDistrib.lean`、具体版をその系として導くのは
`ClaimIntegerZeroTimesIsZeroFromNecSuf.lean`。
-/
import Mathlib.Algebra.Ring.Int.Defs

namespace Ising2D

/-- **人手 `int_zero_times_is_zero`**: `x ∈ ℤ` について `0·x = 0`（人手の 6 行の鎖と 1 対 1 の `calc`）。 -/
theorem int_zero_times_is_zero (x : ℤ) : 0 * x = 0 :=
  calc 0 * x
      = 0 * x + 0 := (add_zero (0 * x)).symm                                   -- ℤ の和の単位元（`y → 0·x`）を右辺から左辺へ
    _ = 0 * x + (0 * x + -(0 * x)) := by rw [add_neg_cancel (0 * x)]            -- ℤ の加法の逆元（`y → 0·x`）を右辺から左辺へ
    _ = (0 * x + 0 * x) + -(0 * x) := (add_assoc (0 * x) (0 * x) (-(0 * x))).symm  -- ℤ の加法の結合律を右辺から左辺へ
    _ = (0 + 0) * x + -(0 * x) := by rw [add_mul (0 : ℤ) 0 x]                  -- ℤ の分配律 `(y+z)t = yt+zt` を右辺から左辺へ
    _ = 0 * x + -(0 * x) := by rw [add_zero (0 : ℤ)]                           -- ℤ の和の単位元（`y → 0`）
    _ = 0 := add_neg_cancel (0 * x)                                            -- ℤ の加法の逆元（`y → 0·x`）

end Ising2D
