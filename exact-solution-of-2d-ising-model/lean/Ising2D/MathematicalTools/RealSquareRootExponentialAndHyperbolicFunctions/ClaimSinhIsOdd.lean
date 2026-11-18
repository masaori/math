/-
# `sinh` は奇関数（**具体版**）

人手証明（正本は `structured-latex/content/020_critical_point.ts`）:
- `critical_claim_sinh_is_odd`（ラベル `sinh_is_odd`）

人手の 5 行の鎖と `sinh_is_odd` の `calc` は 1 対 1 である。`def_cosh_sinh` は Lean で定義し直しておらず、
mathlib の `Real.sinh` の等式 `Real.sinh_eq`（`sinh x = (exp x − exp(−x))/2`）が人手の定義の式そのものとしてその役を担う。
mathlib の `Real.sinh_neg` は使わない（人手の鎖をそのまま書くため）。
-/
import Mathlib.Analysis.Complex.Trigonometric

namespace Ising2D

/-- **人手 `sinh_is_odd`**: `x ∈ ℝ` について `sinh(−x) = −sinh x`。 -/
theorem sinh_is_odd (x : ℝ) : Real.sinh (-x) = -Real.sinh x :=
  calc Real.sinh (-x)
      = (Real.exp (-x) - Real.exp (-(-x))) / 2 := Real.sinh_eq (-x)
                                                        -- `sinh` の定義（`def_cosh_sinh`）
    _ = (Real.exp (-x) - Real.exp x) / 2 := by rw [neg_neg]
                                                        -- `−(−x) = x`
    _ = (-(Real.exp x - Real.exp (-x))) / 2 := by rw [neg_sub]
                                                        -- `a − b = −(b − a)`
    _ = -((Real.exp x - Real.exp (-x)) / 2) := neg_div 2 (Real.exp x - Real.exp (-x))
                                                        -- 分子の符号を分数の外へ出す
    _ = -Real.sinh x := by rw [← Real.sinh_eq x]        -- `sinh` の定義（`def_cosh_sinh`）

end Ising2D
