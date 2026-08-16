/-
「対称化した列は q↔1/q で不変である（有限箱の等式）」の Lean 具体版・第四歩の橋渡し。

第四歩の後半（係数和の狭義単調性 `strictMono_sum_of_nonneg_coeff`）を
`Polynomial.eval` へ移し（`Polynomial.eval_eq_sum_range`）、前半 `ne_eval_inv_of_strictMonoOn` と束ねる。
結論: 非負係数・次数 ≥ 1・正の最高次係数の f ∈ ℚ[X] は q > 0, q ≠ 1 で f(q) ≠ f(1/q)。
-/
import Mathlib.Algebra.Polynomial.Eval.Degree
import Mathlib.Algebra.Polynomial.Degree.Defs
import Ising3DCut.LimitQuantity.SymmetrizedReciprocalInvariantStepFour
import Ising3DCut.LimitQuantity.SymmetrizedReciprocalInvariantStepFourMonotone

namespace Ising3DCut.LimitQuantity

open Polynomial

/-- 第四歩の橋渡し。`f.eval` は `(0,∞)` 上で狭義単調増加。 -/
theorem eval_strictMono_of_nonneg_coeff {f : ℚ[X]}
    (hc : ∀ i, 0 ≤ f.coeff i) (hn : 1 ≤ f.natDegree) (hlead : 0 < f.leadingCoeff)
    {a b : ℚ} (ha : 0 < a) (hab : a < b) : f.eval a < f.eval b := by
  rw [Polynomial.eval_eq_sum_range, Polynomial.eval_eq_sum_range]
  exact strictMono_sum_of_nonneg_coeff hc hn hlead ha hab

/-- 第四歩の結論。`q > 0`, `q ≠ 1` なら `f(q) ≠ f(1/q)`。 -/
theorem eval_ne_eval_inv_of_nonneg_coeff {f : ℚ[X]}
    (hc : ∀ i, 0 ≤ f.coeff i) (hn : 1 ≤ f.natDegree) (hlead : 0 < f.leadingCoeff)
    {q : ℚ} (hq : 0 < q) (hq1 : q ≠ 1) : f.eval q ≠ f.eval (1 / q) :=
  ne_eval_inv_of_strictMonoOn (g := fun x => f.eval x)
    (fun _ _ ha hab => eval_strictMono_of_nonneg_coeff hc hn hlead ha hab) hq hq1

end Ising3DCut.LimitQuantity
