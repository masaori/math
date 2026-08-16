import Ising3DCut.LimitQuantity.SymmetrizedReciprocalInvariantStepOne
import Ising3DCut.LimitQuantity.SymmetrizedReciprocalInvariantStepTwo
import Ising3DCut.LimitQuantity.SymmetrizedReciprocalInvariantStepThree

/-!
「対称化した列は q↔1/q で不変である（有限箱の等式）」の第一〜第三歩を一つに束ねる。
回文（`reflect E f = f`）・次数 `≤ E`・`q ≠ 0`・`f(1/q) ≠ 0` から、各素数 `p` で
対称化した付値 `2 v_p(f(q)) - E v_p(q)` が `q` と `1/q` で一致する。
第四歩（`f(q) ≠ f(1/q)`）は `SymmetrizedReciprocalInvariantStepFourEval.lean` にあり、
非自明性の主張として別に置く。
-/

namespace Ising3DCut.LimitQuantity

open Polynomial

/-- 第一〜第三歩を束ねた定理。 -/
theorem symmetrized_padicValRat_eval_reciprocal_invariant
    {p E : ℕ} [Fact p.Prime] {f : ℚ[X]}
    (hpal : reflect E f = f) (hdeg : f.natDegree ≤ E)
    {q : ℚ} (hq : q ≠ 0) (hZq' : f.eval (1 / q) ≠ 0) :
    2 * padicValRat p (f.eval q) - (E : ℤ) * padicValRat p q =
      2 * padicValRat p (f.eval (1 / q)) - (E : ℤ) * padicValRat p q⁻¹ := by
  have h1 := eval_eq_pow_mul_eval_inv_of_reflect_eq hpal hdeg hq
  have h2 := padicValRat_of_pow_mul (p := p) hq hZq' h1
  exact symmetrized_padicValRat_reciprocal_invariant h2

end Ising3DCut.LimitQuantity
