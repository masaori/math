/-
# `relation_of_gamma_2_theta_tilde` (2) の狭義の負と (4) の `|γ_2| > 0`（具体版を必要十分版から導く）

具体版 `ClaimRelationGamma2Tilde.lean` の `absGamma2_pos_of_ne_zero` を `NecSuf.absOf_pos` の特殊化として、`absGamma2_thetaTilde_sq_pos`・`neg_absGamma2_thetaTilde_sq_neg` の主張を、
必要十分版 `Ising2D/NecSuf/NegConjPair.lean` の `sq_pos_of_pos_chain`・`neg_neg_of_pos_chain` の
`R := ℝ`（`a := |γ_2(θ~_μ)|`、`x := |γ_2(θ~_μ)|^2`）への特殊化として得る。人手のラベルは `relation_of_gamma_2_theta_tilde`。
-/
import Ising2D.EigenvalueProblem.DiagonalizationAndExponentialForm.ClaimRelationGamma2Tilde

namespace Ising2D

/-- (4) の `|γ_2(θ)| > 0` の具体版 `absGamma2_pos_of_ne_zero` を `NecSuf.absOf_pos`（`z := γ_2(θ)`）の特殊化として得る。 -/
theorem absGamma2_pos_of_ne_zero_of_necSuf (K : IsingConst) (θ : ℝ) (hga : gamma2 K θ ≠ 0) :
    0 < absGamma2 K θ :=
  NecSuf.absOf_pos hga

/-- `absGamma2_thetaTilde_sq_pos` を `NecSuf.sq_pos_of_pos_chain`（`R := ℝ`）の特殊化として得る。 -/
theorem absGamma2_thetaTilde_sq_pos_of_necSuf (P : IsingParam) {M : ℕ} (hM : M ≠ 0) (μ : ℤ) :
    0 < absGamma2 P.const (thetaTilde M μ) ^ 2 :=
  NecSuf.sq_pos_of_pos_chain (absGamma2_thetaTilde_pos P hM μ)

/-- `neg_absGamma2_thetaTilde_sq_neg` を `NecSuf.neg_neg_of_pos_chain`（`R := ℝ`）の特殊化として得る。 -/
theorem neg_absGamma2_thetaTilde_sq_neg_of_necSuf (P : IsingParam) {M : ℕ} (hM : M ≠ 0) (μ : ℤ) :
    -(absGamma2 P.const (thetaTilde M μ) ^ 2) < 0 :=
  NecSuf.neg_neg_of_pos_chain (NecSuf.sq_pos_of_pos_chain (absGamma2_thetaTilde_pos P hM μ))

end Ising2D
