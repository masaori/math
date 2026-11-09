/-
# 実数の冪の包含は包含の冪に等しい（具体版）

正本: `structured-latex/content/020_critical_point.ts`
（`critical_claim_real_inclusion_preserves_power`、ラベル **`real_inclusion_preserves_power`**）

**必要十分版**: `Ising2D/NecSuf/MultiplicativeMapPreservesPower.lean` の `NecSuf.map_pow_of_map_one_of_map_mul'`。
具体版をその系として導くのは、同じフォルダの `ClaimRealInclusionPreservesPowerFromNecSuf.lean`。

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| `m = 0` の 3 行（`def_power_of_real_number` の `a^0 := 1` → `1_ℂ` は `(1_ℝ)_ℂ` の略記 → `def_power_of_complex_number` の `z^0 := 1_ℂ` を右辺から左辺へ） | `real_inclusion_of_power` の `zero` の `calc` の 3 段 |
| 帰納法の段の 4 行（`a^{m+1} := a^m a` → `real_inclusion_preserves_product` を右辺から左辺へ → 帰納法の仮定 → `z^{m+1} := z^m z` を右辺から左辺へ） | `real_inclusion_of_power` の `succ` の `calc` の 4 段 |

- 人手の ℝ の冪・ℂ の冪の 2 つの式は、mathlib の `Monoid` の冪の `pow_zero`・`pow_succ`（`a ^ (m + 1) = a ^ m * a`）である。
- `1_ℂ` が `(1_ℝ)_ℂ` であることは `Complex.ofReal_one`（構造体の実部 `1`、虚部 `0` で、`rfl` と同じ内容）である。
-/
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesProduct

namespace Ising2D

/-- **人手 `real_inclusion_preserves_power`**: `(r^m)_ℂ = (r_ℂ)^m`（`r ∈ ℝ`、`m ∈ ℤ_{≥0}`）。`m` についての帰納法。 -/
theorem real_inclusion_of_power (r : ℝ) (m : ℕ) : ((r ^ m : ℝ) : ℂ) = (r : ℂ) ^ m := by
  induction m with
  | zero =>
    calc ((r ^ 0 : ℝ) : ℂ)
        = ((1 : ℝ) : ℂ) := by rw [pow_zero]                     -- `def_power_of_real_number` の `a^0 := 1`（`a → r`）
      _ = (1 : ℂ) := Complex.ofReal_one                          -- `1_ℂ` は `inclusion_rr_to_cc` の略記 `(1_ℝ)_ℂ`
      _ = (r : ℂ) ^ 0 := (pow_zero _).symm                       -- `def_power_of_complex_number` の `z^0 := 1_ℂ` を右辺から左辺へ
  | succ m ih =>
    calc ((r ^ (m + 1) : ℝ) : ℂ)
        = ((r ^ m * r : ℝ) : ℂ) := by rw [pow_succ]              -- `def_power_of_real_number` の `a^{m+1} := a^m a`（`a → r`）
      _ = ((r ^ m : ℝ) : ℂ) * (r : ℂ) := (real_inclusion_mul _ _).symm
                                                                 -- `real_inclusion_preserves_product`（`a → r^m`、`b → r`）を右辺から左辺へ
      _ = (r : ℂ) ^ m * (r : ℂ) := by rw [ih]                    -- 帰納法の仮定
      _ = (r : ℂ) ^ (m + 1) := (pow_succ _ _).symm               -- `def_power_of_complex_number` の `z^{m+1} := z^m z` を右辺から左辺へ

end Ising2D
