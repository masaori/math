/-
# `V̌'` の固有値の Step 3・Step 3'（具体版の主張を必要十分版から導く）

具体版 `ClaimEigenvaluesCheckVprime.lean` の `CheckFermiSetup.Vprime_mul_Qproj`・`Qproj_mul_Vprime`（人手 `eigenvalues_of_check_Vprime`
Step 3・Step 3' の極限の鎖と 1 対 1 の calc）と同じ主張を、必要十分版 `Ising2D/NecSuf/JointEigenspace.lean` の
`NecSuf.exp_mul_eq_of_mul_eq_smul` と `Ising2D/NecSuf/SimpleEigenvalue.lean` の `NecSuf.mul_exp_eq_of_mul_eq_smul`
（ℂ 上の完備ノルム環で、`XQ = gQ ⇒ exp(X)Q = e^gQ` とその左右反転）の特殊化として得る。
-/
import Ising2D.EigenvalueProblem.DiagonalizationAndExponentialForm.ClaimEigenvaluesCheckVprime

namespace Ising2D

open Matrix

namespace CheckFermiSetup

variable {M : ℕ} (F : CheckFermiSetup M)

set_option backward.isDefEq.respectTransparency false in
/-- `Vprime_mul_Qproj` を `NecSuf.exp_mul_eq_of_mul_eq_smul`（`X → X̌`、`Q → Q̌_ε`、`g → ǧ(ε)`）の特殊化として得る。 -/
theorem Vprime_mul_Qproj_of_necSuf (g : CheckIdx M → ℝ) (T : Finset (CheckIdx M)) :
    F.Vprime g * F.Qproj T = ((Real.exp (F.gval g T) : ℝ) : ℂ) • F.Qproj T := by
  have h : NormedSpace.exp (F.Xop g) * F.Qproj T
      = Complex.exp ((F.gval g T : ℝ) : ℂ) • F.Qproj T :=
    open scoped Norms.Operator in
      NecSuf.exp_mul_eq_of_mul_eq_smul (F.Xop_mul_Qproj g T)
  rw [Vprime, matExp, h, Complex.ofReal_exp]

set_option backward.isDefEq.respectTransparency false in
/-- `Qproj_mul_Vprime` を `NecSuf.mul_exp_eq_of_mul_eq_smul`（`X → X̌`、`Q → Q̌_ε`、`g → ǧ(ε)`）の特殊化として得る。 -/
theorem Qproj_mul_Vprime_of_necSuf (g : CheckIdx M → ℝ) (T : Finset (CheckIdx M)) :
    F.Qproj T * F.Vprime g = ((Real.exp (F.gval g T) : ℝ) : ℂ) • F.Qproj T := by
  have h : F.Qproj T * NormedSpace.exp (F.Xop g)
      = Complex.exp ((F.gval g T : ℝ) : ℂ) • F.Qproj T :=
    open scoped Norms.Operator in
      NecSuf.mul_exp_eq_of_mul_eq_smul (F.Qproj_mul_Xop g T)
  rw [Vprime, matExp, h, Complex.ofReal_exp]

end CheckFermiSetup

end Ising2D
