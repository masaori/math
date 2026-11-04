/-
# `cosh` は偶関数（**具体版**）

人手証明（正本は `structured-latex/content/020_critical_point.ts`）:
- `critical_claim_cosh_is_even`（ラベル `cosh_is_even`）

人手の 4 行の鎖と `cosh_is_even` の `calc` は 1 対 1 である。`def_cosh_sinh` は Lean で定義し直しておらず、
mathlib の `Real.cosh` の等式 `Real.cosh_eq`（`cosh x = (exp x + exp(−x))/2`）が人手の定義の式そのものとしてその役を担う。
必要十分版は `Ising2D/NecSuf/SymmetrizedSumIsEven.lean` の `NecSuf.symmetrized_sum_is_even'`、
具体版をその特殊化として得る導出は `ClaimCoshIsEvenFromNecSuf.lean`。
-/
import Mathlib.Analysis.Complex.Trigonometric

namespace Ising2D

/-- **人手 `cosh_is_even`**: `x ∈ ℝ` について `cosh(−x) = cosh x`。 -/
theorem cosh_is_even (x : ℝ) : Real.cosh (-x) = Real.cosh x :=
  calc Real.cosh (-x)
      = (Real.exp (-x) + Real.exp (-(-x))) / 2 := Real.cosh_eq (-x)
                                                        -- `cosh` の定義（`def_cosh_sinh`）
    _ = (Real.exp (-x) + Real.exp x) / 2 := by rw [neg_neg]
                                                        -- `−(−x) = x`
    _ = (Real.exp x + Real.exp (-x)) / 2 := by rw [add_comm (Real.exp (-x))]
                                                        -- ℝ の加法の交換律
    _ = Real.cosh x := (Real.cosh_eq x).symm            -- `cosh` の定義（`def_cosh_sinh`）

end Ising2D
