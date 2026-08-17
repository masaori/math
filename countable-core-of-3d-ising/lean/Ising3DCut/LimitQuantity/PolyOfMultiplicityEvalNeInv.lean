/-
「対称化した極限量に対して粗視化は必要でない」の Lean 具体版・$Z_L(q)\neq Z_L(1/q)$ への準備。

`eval_ne_eval_inv_of_nonneg_coeff` の三前提（係数非負・次数 $\ge1$・最高次係数 $>0$）を
`polyOfMultiplicity` について束ね、$E\ge1$・$\Omega(E)\neq0$・$q>0$・$q\neq1$ の下で
$P(q)\neq P(1/q)$ を得る。零モデルの $Z_L$ への適用（$\Omega(\#E_L)\ge1$）は別ファイルで行う。
-/
import Ising3DCut.LimitQuantity.PolyOfMultiplicityCoeffNonneg
import Ising3DCut.LimitQuantity.PolyOfMultiplicityDegree
import Ising3DCut.LimitQuantity.SymmetrizedReciprocalInvariantStepFourEval

namespace Ising3DCut.LimitQuantity

open Polynomial

/-- 三前提を束ねた結論。$E\ge1$、$\Omega(E)\neq0$、$q>0$、$q\neq1$ なら $P(q)\neq P(1/q)$。 -/
theorem eval_polyOfMultiplicity_ne_eval_inv {E : ℕ} {Ω : ℕ → ℕ} (hE : 1 ≤ E) (h : Ω E ≠ 0)
    {q : ℚ} (hq : 0 < q) (hq1 : q ≠ 1) :
    (polyOfMultiplicity E Ω).eval q ≠ (polyOfMultiplicity E Ω).eval (1 / q) :=
  eval_ne_eval_inv_of_nonneg_coeff (fun i => coeff_polyOfMultiplicity_nonneg E Ω i)
    (one_le_natDegree_polyOfMultiplicity hE h) (leadingCoeff_polyOfMultiplicity_pos h) hq hq1

end Ising3DCut.LimitQuantity
