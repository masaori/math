/- 形式的平方根の存在の具体版が、必要十分版の特殊化として得られることの記録。 -/
import Ising2DLambda.KacWard.FormalSquareRootExistence
import Ising2DLambda.NecSuf.KacWard.FormalSquareRootExistence

namespace Ising2DLambda.KacWard

open PowerSeries Ising2DLambda.AlgebraicEigenvalue

noncomputable instance invertibleTwoQbar : Invertible (2 : Qbar) :=
  invertibleOfNonzero (by norm_num)

/-- 具体版の係数列は、必要十分版の係数列を Qbar で取ったものに等しい。 -/
theorem sqrtCoeff_eq_necSuf (d : ℕ → Qbar) :
    ∀ n, sqrtCoeff d n = Ising2DLambda.NecSuf.KacWard.sqrtCoeff d n := by
  intro n
  induction n using Nat.strong_induction_on with
  | _ n ih =>
    cases n with
    | zero => rw [sqrtCoeff_zero, Ising2DLambda.NecSuf.KacWard.sqrtCoeff_zero]
    | succ m =>
      rw [sqrtCoeff_succ, Ising2DLambda.NecSuf.KacWard.sqrtCoeff_succ, invOf_eq_inv]
      congr 2
      refine Finset.sum_congr rfl fun i hi => ?_
      have hi' := Finset.mem_range.mp hi
      rw [ih (i + 1) (by omega), ih (m - i) (by omega)]

/-- 具体版が必要十分版の特殊化として得られることの記録。 -/
theorem formalSquareRoot_exists_from_necSuf (d : ℕ → Qbar) (hd0 : d 0 = 1) :
    constantCoeff (mk (sqrtCoeff d)) = 1 ∧ mk (sqrtCoeff d) * mk (sqrtCoeff d) = mk d := by
  have hcoeff : sqrtCoeff d = Ising2DLambda.NecSuf.KacWard.sqrtCoeff d :=
    funext (sqrtCoeff_eq_necSuf d)
  rw [hcoeff]
  exact ⟨Ising2DLambda.NecSuf.KacWard.constantCoeff_mk_sqrtCoeff d,
    Ising2DLambda.NecSuf.KacWard.mk_sqrtCoeff_mul_self d hd0⟩

end Ising2DLambda.KacWard
