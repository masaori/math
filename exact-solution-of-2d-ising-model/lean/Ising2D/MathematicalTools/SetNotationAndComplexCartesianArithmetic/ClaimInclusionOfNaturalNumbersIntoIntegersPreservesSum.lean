/-
# ℕ から ℤ への包含写像は和を保つ（**具体版**）

正本: `structured-latex/content/000_calculation_formulae_00_09.ts`
（`calc_formulae_claim_inclusion_nn_to_zz_preserves_sum`、ラベル **`inclusion_nn_to_zz_preserves_sum`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| `x` を固定し、ℕ の数学的帰納法（`φ(y) :⇔ ι(x + y) = ι(x) + ι(y)`） | `induction y` |
| `y = 0_ℕ` の鎖 `ι(x + 0) = ι(x) = ι(x) + 0_ℤ = ι(x) + ι(0_ℕ)` | `zero` の枝の `calc` の 3 段 |
| `y + 1_ℕ` の鎖 `ι(x + (y + 1)) = ι((x + y) + 1) = ι(x + y) + 1 = (ι(x) + ι(y)) + 1 = ι(x) + (ι(y) + 1) = ι(x) + ι(y + 1)` | `succ` の枝の `calc` の 5 段 |

- `set_and_algebra_notation` の ℕ の和の再帰の式 `x + 0 = x`・`x + (y + 1) = (x + y) + 1` は、Lean の ℕ の和の定義の式そのものなので `rfl` で読む。
- `set_and_algebra_notation` の ℤ の行のうち、和の単位元 `x + 0 = x` は `add_zero`、加法の結合律は `add_assoc` で読む。
- mathlib の `Nat.cast_add`・`push_cast` は使わない（人手の論法をそのまま書くため）。

必要十分版は `Ising2D/NecSuf/MapAddOfRecAddOne.lean`、具体版をその系として導くのは
`ClaimInclusionOfNaturalNumbersIntoIntegersPreservesSumFromNecSuf.lean`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.DefinitionInclusionOfNaturalNumbersIntoIntegers

namespace Ising2D

/-- **人手 `inclusion_nn_to_zz_preserves_sum`**: すべての `x, y ∈ ℕ` で `ι_{ℕ→ℤ}(x + y) = ι_{ℕ→ℤ}(x) + ι_{ℕ→ℤ}(y)`
（人手の論法: `x` を固定し `y` についての ℕ の数学的帰納法）。 -/
theorem inclusion_nn_to_zz_preserves_sum (x y : ℕ) :
    inclusionNNtoZZ (x + y) = inclusionNNtoZZ x + inclusionNNtoZZ y := by
  induction y with
  | zero =>
    calc inclusionNNtoZZ (x + 0)
        = inclusionNNtoZZ x := rfl                                         -- ℕ の和の再帰の式 `x + 0_ℕ = x`
      _ = inclusionNNtoZZ x + 0 := (add_zero (inclusionNNtoZZ x)).symm     -- ℤ の和の単位元（`x → ι(x)`）を右辺から左辺へ
      _ = inclusionNNtoZZ x + inclusionNNtoZZ 0 := rfl                     -- `inclusion_nn_to_zz` の `ι(0_ℕ) := 0_ℤ` を右辺から左辺へ
  | succ y ih =>
    calc inclusionNNtoZZ (x + (y + 1))
        = inclusionNNtoZZ ((x + y) + 1) := rfl                             -- ℕ の和の再帰の式 `x + (y + 1) = (x + y) + 1`
      _ = inclusionNNtoZZ (x + y) + 1 := rfl                               -- `inclusion_nn_to_zz` の `ι(n + 1_ℕ) := ι(n) + 1_ℤ`（`n → x + y`）
      _ = (inclusionNNtoZZ x + inclusionNNtoZZ y) + 1 := by rw [ih]         -- 帰納法の仮定
      _ = inclusionNNtoZZ x + (inclusionNNtoZZ y + 1) :=
          add_assoc (inclusionNNtoZZ x) (inclusionNNtoZZ y) 1              -- ℤ の加法の結合律
      _ = inclusionNNtoZZ x + inclusionNNtoZZ (y + 1) := rfl               -- `inclusion_nn_to_zz` の `ι(n + 1_ℕ) := ι(n) + 1_ℤ`（`n → y`）を右辺から左辺へ

end Ising2D
