/-
# `sinh γ(θ~_μ) = |γ_2(θ~_μ)|` と `λ_{±,μ} = e^{±γ(θ~_μ)}`（具体版を必要十分版から導く）

具体版 `DefinitionGammaTildeMu.lean` の `sinh_gammaTilde`・`lambdaPlusR_eq_exp`・`lambdaMinusR_eq_exp` の主張を、
必要十分版 `Ising2D/NecSuf/ArcoshExp.lean` の `sinh_arcosh_of_sq`・`exp_arcosh_of_sq`・`exp_neg_arcosh_of_sq` の
`g := γ_1(θ~_μ)`、`r := |γ_2(θ~_μ)|` への特殊化として得る。人手のラベルは `lambda_eq_exp_gamma_theta_tilde`。
特殊化に要る仮定は `g ≥ 1`・`r ≥ 0`・`g^2 = 1 + r^2` だけで、具体版が使う `t > 0`・`r > 0`（仮定 `M ≠ 0`）は要らない。
-/
import Ising2D.EigenvalueProblem.DiagonalizationAndExponentialForm.DefinitionGammaTildeMu
import Ising2D.NecSuf.ArcoshExp

namespace Ising2D

/-- `sinh_gammaTilde` を `NecSuf.sinh_arcosh_of_sq`（`g := γ_1(θ~_μ)`、`r := |γ_2(θ~_μ)|`）の特殊化として得る。 -/
theorem sinh_gammaTilde_of_necSuf (P : IsingParam)
    (hdual : P.const.c2 * P.const.s2star = P.const.c2star) (M : ℕ) (μ : ℤ) :
    Real.sinh (gammaTilde P M μ) = absGamma2 P.const (thetaTilde M μ) :=
  NecSuf.sinh_arcosh_of_sq (one_le_gamma1R P (thetaTilde M μ))
    (absGamma2_nonneg _ _) (gamma1R_sq_thetaTilde P hdual M μ)

/-- `lambdaPlusR_eq_exp` を `NecSuf.exp_arcosh_of_sq` の特殊化として得る。 -/
theorem lambdaPlusR_eq_exp_of_necSuf (P : IsingParam)
    (hdual : P.const.c2 * P.const.s2star = P.const.c2star) (M : ℕ) (μ : ℤ) :
    lambdaPlusR P.const (thetaTilde M μ) = Real.exp (gammaTilde P M μ) :=
  (NecSuf.exp_arcosh_of_sq (one_le_gamma1R P (thetaTilde M μ))
    (absGamma2_nonneg _ _) (gamma1R_sq_thetaTilde P hdual M μ)).symm

/-- `lambdaMinusR_eq_exp` を `NecSuf.exp_neg_arcosh_of_sq` の特殊化として得る。 -/
theorem lambdaMinusR_eq_exp_of_necSuf (P : IsingParam)
    (hdual : P.const.c2 * P.const.s2star = P.const.c2star) (M : ℕ) (μ : ℤ) :
    lambdaMinusR P.const (thetaTilde M μ) = Real.exp (-gammaTilde P M μ) :=
  (NecSuf.exp_neg_arcosh_of_sq (one_le_gamma1R P (thetaTilde M μ))
    (absGamma2_nonneg _ _) (gamma1R_sq_thetaTilde P hdual M μ)).symm

end Ising2D
