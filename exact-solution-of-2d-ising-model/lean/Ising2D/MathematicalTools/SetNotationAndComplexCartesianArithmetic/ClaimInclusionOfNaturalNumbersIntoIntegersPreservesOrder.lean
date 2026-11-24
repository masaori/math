/-
# ℕ から ℤ への包含写像は順序を保つ（**具体版**）

正本: `structured-latex/content/000_calculation_formulae_00_09.ts`
（`calc_formulae_claim_inclusion_nn_to_zz_preserves_order`、ラベル **`inclusion_nn_to_zz_preserves_order`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| `x ≤ y` と ℕ の順序と和 `x ≤ y ⇔ ∃d, x + d = y` から `x + d = y` の `d` を取る | `obtain ⟨d, hd⟩ := Nat.le.dest hxy` |
| 鎖 `ι(x) = 0 + ι(x) ≤ ι(d) + ι(x) = ι(x) + ι(d) = ι(x + d) = ι(y)` | `calc` の 5 段 |

- `set_and_algebra_notation` の ℕ の順序と和の行は、Lean の ℕ の `≤` から `x + d = y` の `d` を取り出す `Nat.le.dest` で読む。
- `set_and_algebra_notation` の ℤ の行のうち、和の単位元 `0 + x = x` は `zero_add`、加法の交換律は `add_comm`、
  順序と加法の両立 `x ≤ y ⇒ x + t ≤ y + t` は `add_le_add_left`（この mathlib では `b ≤ c ⇒ b + a ≤ c + a`）で読む。
  `≤` と `=` の連なりをつなぐのは `calc` である（`≤` が一度だけなので、等号の代入でつながり推移律は要らない。本文は ℤ の順序の推移律を挙げている）。
- mathlib の `Nat.cast_le`・`Int.ofNat_le`・`Nat.mono_cast` は使わない（人手の論法をそのまま書くため）。

必要十分版は `Ising2D/NecSuf/LeOfMapAddOfNonneg.lean`、具体版をその系として導くのは
`ClaimInclusionOfNaturalNumbersIntoIntegersPreservesOrderFromNecSuf.lean`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimInclusionOfNaturalNumbersIntoIntegersImageIsNonnegative
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimInclusionOfNaturalNumbersIntoIntegersPreservesSum

namespace Ising2D

/-- **人手 `inclusion_nn_to_zz_preserves_order`**: `x, y ∈ ℕ` が `x ≤ y` なら `ι_{ℕ→ℤ}(x) ≤ ι_{ℕ→ℤ}(y)`
（人手の論法: ℕ の順序と和で `x + d = y` の `d` を取り、像が 0 以上であることと和を保つことでつなぐ）。 -/
theorem inclusion_nn_to_zz_preserves_order (x y : ℕ) (hxy : x ≤ y) :
    inclusionNNtoZZ x ≤ inclusionNNtoZZ y := by
  obtain ⟨d, hd⟩ := Nat.le.dest hxy                                        -- ℕ の順序と和 `x ≤ y ⇔ ∃d, x + d = y`
  calc inclusionNNtoZZ x
      = 0 + inclusionNNtoZZ x := (zero_add (inclusionNNtoZZ x)).symm       -- ℤ の和の単位元 `0 + x = x`（`x → ι(x)`）を右辺から左辺へ
    _ ≤ inclusionNNtoZZ d + inclusionNNtoZZ x :=
        add_le_add_left (inclusion_nn_to_zz_image_is_nonnegative d) _      -- `inclusion_nn_to_zz_image_is_nonnegative`（`n → d`）に順序と加法の両立（`t → ι(x)`）
    _ = inclusionNNtoZZ x + inclusionNNtoZZ d := add_comm _ _              -- ℤ の加法の交換律（`x → ι(d), y → ι(x)`）
    _ = inclusionNNtoZZ (x + d) := (inclusion_nn_to_zz_preserves_sum x d).symm
                                                                           -- `inclusion_nn_to_zz_preserves_sum`（`y → d`）を右辺から左辺へ
    _ = inclusionNNtoZZ y := by rw [hd]                                    -- `x + d = y`

end Ising2D
