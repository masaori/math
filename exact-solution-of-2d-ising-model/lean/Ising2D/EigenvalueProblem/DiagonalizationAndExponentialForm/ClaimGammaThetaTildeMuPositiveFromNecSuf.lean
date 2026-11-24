/-
# `γ(θ~_μ) > 0`（具体版を必要十分版から導く）

具体版 `TheoremMaxEigenvalueSimple.lean` の `gammaFn_thetaTilde_pos`（`μ ∈ 𝓜̌`）と
`DefinitionGammaTildeMu.lean` の `gammaTilde_pos`（`μ ∈ ℤ`、仮定 `hdual`）の主張を、必要十分版
`Ising2D/NecSuf/ArcoshExp.lean` の `arcosh_pos_of_one_lt` の `g := γ_1(θ~_μ)` への特殊化として得る。
人手のラベルは `gamma_theta_tilde_mu_positive`。
-/
import Ising2D.EigenvalueProblem.DiagonalizationAndExponentialForm.TheoremMaxEigenvalueSimple
import Ising2D.EigenvalueProblem.DiagonalizationAndExponentialForm.DefinitionGammaTildeMu
import Ising2D.NecSuf.ArcoshExp

namespace Ising2D

/-- `gammaFn_thetaTilde_pos` を `NecSuf.arcosh_pos_of_one_lt`（`g := γ_1(θ~_μ)`）の特殊化として得る。 -/
theorem gammaFn_thetaTilde_pos_of_necSuf (P : IsingParam) {M : ℕ} (hM : M ≠ 0) {μ : ℤ}
    (hμ : CheckIndex M μ) : 0 < gammaFn P (thetaTilde M μ) :=
  NecSuf.arcosh_pos_of_one_lt (one_lt_gamma1R_thetaTilde_checkIndex P hM hμ)

/-- `gammaTilde_pos` を `NecSuf.arcosh_pos_of_one_lt`（`g := γ_1(θ~_μ)`）の特殊化として得る。 -/
theorem gammaTilde_pos_of_necSuf (P : IsingParam)
    (hdual : P.const.c2 * P.const.s2star = P.const.c2star)
    {M : ℕ} (hM : M ≠ 0) (μ : ℤ) : 0 < gammaTilde P M μ :=
  NecSuf.arcosh_pos_of_one_lt (one_lt_gamma1R_thetaTilde P hdual hM μ)

end Ising2D
