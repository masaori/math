import Ising3DCut.LimitQuantity.SymmetrizedReciprocalInvariantBundle

/-!
「対称化した列は q↔1/q で不変である（有限箱の等式）」の Lean 必要十分版。

具体版（零モデル $Z_L$）が使ったのは
  回文 `reflect E f = f`・次数 `≤ E`・`q ≠ 0`・`f(1/q) ≠ 0`
だけであり、係数の非負性・$\Omega(0)\ge1$・辺集合・重複度の由来（二部性）は使っていない。
したがって主張は任意の有理係数多項式 `f` と自然数 `E` について、この四つの仮定だけで述べられる。
第一〜第三歩（`StepOne`〜`StepThree`）は既に一般の `f` について書かれているので、
束ねた定理をそのまま必要十分版として掲げる。
-/

namespace Ising3DCut.NecSuf

open Polynomial

/-- 回文・次数上界・`q ≠ 0`・`f(1/q) ≠ 0` だけから、各素数 `p` で
対称化した付値 `2 v_p(f(q)) - E v_p(q)` は `q` と `1/q` で一致する。 -/
theorem symmetrized_padicValRat_reciprocal_invariant_of_palindrome
    {p E : ℕ} [Fact p.Prime] {f : ℚ[X]}
    (hpal : reflect E f = f) (hdeg : f.natDegree ≤ E)
    {q : ℚ} (hq : q ≠ 0) (hfq' : f.eval (1 / q) ≠ 0) :
    2 * padicValRat p (f.eval q) - (E : ℤ) * padicValRat p q =
      2 * padicValRat p (f.eval (1 / q)) - (E : ℤ) * padicValRat p q⁻¹ :=
  Ising3DCut.LimitQuantity.symmetrized_padicValRat_eval_reciprocal_invariant hpal hdeg hq hfq'

end Ising3DCut.NecSuf
