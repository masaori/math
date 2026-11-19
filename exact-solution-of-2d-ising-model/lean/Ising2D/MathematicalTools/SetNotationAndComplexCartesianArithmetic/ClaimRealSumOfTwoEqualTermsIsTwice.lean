/-
# 同じ実数を二つ足すと 2 倍になる（**具体版**）

正本: `structured-latex/content/000_calculation_formulae_20_29.ts`
（`calculation_formulae_claim_real_sum_of_two_equal_terms_is_twice`、ラベル **`real_sum_of_two_equal_terms_is_twice`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 1 行目 `a + a = 1·a + 1·a`（乗法の単位元 `1·x = x`（`x → a`）を右辺から左辺へ 2 か所に同時適用） | `calc` の 1 段目（`one_mul`） |
| 2 行目 `= (1 + 1)·a`（分配則 `(x+y)t = xt+yt`（`x → 1, y → 1, t → a`）を右辺から左辺へ） | 2 段目（`add_mul` の逆向き） |
| 3 行目 `= 2·a`（`def_real_two` の `2 := 1 + 1` を右辺から左辺へ） | 3 段目（`one_add_one_eq_two`） |

- 順序体 `ℝ` の公理（`set_and_algebra_notation`）の段は mathlib の `one_mul`・`add_mul` をそれぞれ 1 回引く。
- 人手の `def_real_two`（`2 := 1 + 1`）は、mathlib の `ℝ` の数字 `2` を `one_add_one_eq_two` で読む。
- mathlib の `two_mul` は使わない（人手の鎖をそのまま書くため）。

必要十分版は `Ising2D/NecSuf/AddSelfEqTwoMul.lean`、具体版をその系として導くのは
`ClaimRealSumOfTwoEqualTermsIsTwiceFromNecSuf.lean`。
-/
import Mathlib.Data.Real.Basic

namespace Ising2D

/-- **人手 `real_sum_of_two_equal_terms_is_twice`**: `ℝ` で `a + a = 2·a`（人手の 3 行の鎖と 1 対 1 の `calc`）。 -/
theorem real_sum_of_two_equal_terms_is_twice (a : ℝ) : a + a = 2 * a :=
  calc a + a
      = 1 * a + 1 * a := by
        rw [one_mul a]                                         -- 乗法の単位元 `1·x = x`（`x → a`）を右辺から左辺へ 2 か所に同時適用
    _ = (1 + 1) * a := (add_mul 1 1 a).symm                    -- 分配則 `(x+y)t = xt+yt`（`x → 1, y → 1, t → a`）を右辺から左辺へ
    _ = 2 * a := by
        rw [one_add_one_eq_two]                                -- `def_real_two` の `2 := 1 + 1` を右辺から左辺へ

end Ising2D
