/-
# ℕ から ℤ への包含写像は積を保つ（**具体版**）

正本: `structured-latex/content/000_calculation_formulae_00_09.ts`
（`calc_formulae_claim_inclusion_nn_to_zz_preserves_product`、ラベル **`inclusion_nn_to_zz_preserves_product`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| `x` を固定し、ℕ の数学的帰納法（`φ(y) :⇔ ι(x·y) = ι(x)·ι(y)`） | `induction y` |
| `y = 0_ℕ` の鎖 `ι(x·0) = ι(0) = 0 = 0·ι(x) = ι(x)·0 = ι(x)·ι(0)` | `zero` の枝の `calc` の 5 段 |
| `y + 1_ℕ` の鎖 `ι(x·(y+1)) = ι(x·y + x) = ι(x·y) + ι(x) = ι(x)ι(y) + ι(x) = ι(x)ι(y) + ι(x)·1 = ι(x)(ι(y) + 1) = ι(x)ι(y+1)` | `succ` の枝の `calc` の 6 段 |

- `set_and_algebra_notation` の ℕ の積の再帰の式 `x·0 = 0`・`x·(y + 1) = x·y + x` は、Lean の ℕ の積の定義の式そのものなので `rfl` で読む。
- `set_and_algebra_notation` の ℤ の行のうち、乗法の交換律は `mul_comm`、乗法の単位元 `x·1 = x` は `mul_one`、
  分配律 `x(y + t) = xy + xt` は `mul_add` で読む。
- mathlib の `Nat.cast_mul`・`mul_zero`・`push_cast` は使わない（人手の論法をそのまま書くため）。

必要十分版は `Ising2D/NecSuf/MapMulOfRecAddOne.lean`、具体版をその系として導くのは
`ClaimInclusionOfNaturalNumbersIntoIntegersPreservesProductFromNecSuf.lean`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimInclusionOfNaturalNumbersIntoIntegersPreservesSum
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimIntegerZeroTimesIsZero

namespace Ising2D

/-- **人手 `inclusion_nn_to_zz_preserves_product`**: すべての `x, y ∈ ℕ` で `ι_{ℕ→ℤ}(x·y) = ι_{ℕ→ℤ}(x)·ι_{ℕ→ℤ}(y)`
（人手の論法: `x` を固定し `y` についての ℕ の数学的帰納法。`y + 1` の段は `inclusion_nn_to_zz_preserves_sum`）。 -/
theorem inclusion_nn_to_zz_preserves_product (x y : ℕ) :
    inclusionNNtoZZ (x * y) = inclusionNNtoZZ x * inclusionNNtoZZ y := by
  induction y with
  | zero =>
    calc inclusionNNtoZZ (x * 0)
        = inclusionNNtoZZ 0 := rfl                                         -- ℕ の積の再帰の式 `x·0_ℕ = 0_ℕ`
      _ = 0 := rfl                                                         -- `inclusion_nn_to_zz` の `ι(0_ℕ) := 0_ℤ`
      _ = 0 * inclusionNNtoZZ x := (int_zero_times_is_zero (inclusionNNtoZZ x)).symm  -- `int_zero_times_is_zero`（`x → ι(x)`）を右辺から左辺へ
      _ = inclusionNNtoZZ x * 0 := mul_comm 0 (inclusionNNtoZZ x)           -- ℤ の乗法の交換律（`x → 0_ℤ, y → ι(x)`）
      _ = inclusionNNtoZZ x * inclusionNNtoZZ 0 := rfl                     -- `inclusion_nn_to_zz` の `ι(0_ℕ) := 0_ℤ` を右辺から左辺へ
  | succ y ih =>
    calc inclusionNNtoZZ (x * (y + 1))
        = inclusionNNtoZZ (x * y + x) := rfl                               -- ℕ の積の再帰の式 `x·(y + 1) = x·y + x`
      _ = inclusionNNtoZZ (x * y) + inclusionNNtoZZ x :=
          inclusion_nn_to_zz_preserves_sum (x * y) x                       -- `inclusion_nn_to_zz_preserves_sum`（`x → x·y, y → x`）
      _ = inclusionNNtoZZ x * inclusionNNtoZZ y + inclusionNNtoZZ x := by rw [ih]  -- 帰納法の仮定
      _ = inclusionNNtoZZ x * inclusionNNtoZZ y + inclusionNNtoZZ x * 1 := by
          rw [mul_one (inclusionNNtoZZ x)]                                 -- ℤ の乗法の単位元（`x → ι(x)`）を右辺から左辺へ
      _ = inclusionNNtoZZ x * (inclusionNNtoZZ y + 1) :=
          (mul_add (inclusionNNtoZZ x) (inclusionNNtoZZ y) 1).symm         -- ℤ の分配律 `x(y + t) = xy + xt` を右辺から左辺へ
      _ = inclusionNNtoZZ x * inclusionNNtoZZ (y + 1) := rfl               -- `inclusion_nn_to_zz` の `ι(n + 1_ℕ) := ι(n) + 1_ℤ`（`n → y`）を右辺から左辺へ

end Ising2D
