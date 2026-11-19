/-
# 0 でない元どうしの積は 0 でない（**必要十分版**）

具体版: `Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealProductOfNonzeroIsNonzero.lean`
（人手 `real_product_of_nonzero_is_nonzero`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealProductOfNonzeroIsNonzeroFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `intro hab`・`apply hb` と `calc` の 5 段（単位元 → 逆元 → 結合律 → 仮定 → `x·0 = 0`） | `mul_ne_zero_of_leftInverse` の同じ並び |

## 何が効いているか / 効いていないか

- 効くのは、`1·y = y`、乗法の結合律、右から 0 を掛けると 0 になること（`y·0 = 0` を `y → c` に当てる）、
  `a` が左逆元 `c`（`c·a = 1`）を持つこと、`b ≠ 0` だけである。
- `a ≠ 0` は、具体版では体の公理から左逆元 `a⁻¹` を得るためだけに要る。ここでは左逆元の存在を直接仮定に置く。
- `y·0 = 0` は具体版では主張 `real_times_zero_is_zero` を引く段で、ここではその結論だけを仮定に置く。
- 乗法の可換律、加法、右逆元、順序、実数であることは効いていない。
-/
import Mathlib.Algebra.Group.Defs

namespace Ising2D.NecSuf

/-- **`real_product_of_nonzero_is_nonzero`** の必要十分版: 左逆元を持つ `a` と `b ≠ 0` について `a·b ≠ 0`。 -/
theorem mul_ne_zero_of_leftInverse {R : Type*} [Mul R] [One R] [Zero R]
    (hone_mul : ∀ y : R, 1 * y = y)
    (hmul_assoc : ∀ x y z : R, (x * y) * z = x * (y * z))
    (hmul_zero : ∀ y : R, y * 0 = 0)
    {a b c : R} (hca : c * a = 1) (hb : b ≠ 0) : a * b ≠ 0 := by
  intro hab
  apply hb
  calc b
      = 1 * b := (hone_mul b).symm          -- 単位元を右辺から左辺へ
    _ = (c * a) * b := by rw [hca]          -- 左逆元 `c·a = 1` を右辺から左辺へ
    _ = c * (a * b) := hmul_assoc c a b     -- 乗法の結合律
    _ = c * 0 := by rw [hab]                -- 仮定 `a·b = 0`
    _ = 0 := hmul_zero c                    -- 右から 0 を掛けると 0

end Ising2D.NecSuf
