/-
# `gamma1_gt_1_theta_tilde`（具体版を必要十分版から導く）

具体版 `ClaimDetATilde.lean` の `gamma1_gt_1_prep_absGamma2_sq_pos`・`gamma1R_thetaTilde_sq_le_one_of_le_one`・
`one_lt_gamma1R_thetaTilde` の主張を、必要十分版 `Ising2D/NecSuf/ArcoshExp.lean` の
`sq_pos_of_pos_implication_chain`・`sq_le_one_of_le_one_chain`・`one_lt_of_sq_gt_one` の
`R := ℝ`（`a := |γ_2(θ~_μ)|`、`t := γ_1(θ~_μ)`）への特殊化として得る。
`g^2` の鎖（`one_lt_gamma1R_sq_thetaTilde`）には必要十分版を置いていないので、結論の段の導出はそれを具体版から受け取る。人手のラベルは `gamma1_gt_1_theta_tilde`。
-/
import Ising2D.EigenvalueProblem.DiagonalizationAndExponentialForm.ClaimDetATilde

namespace Ising2D

variable (P : IsingParam)

/-- `gamma1_gt_1_prep_absGamma2_sq_pos` を `NecSuf.sq_pos_of_pos_implication_chain`（`R := ℝ`）の特殊化として得る。 -/
theorem gamma1_gt_1_prep_absGamma2_sq_pos_of_necSuf {M : ℕ} (hM : M ≠ 0) (μ : ℤ) :
    0 < absGamma2 P.const (thetaTilde M μ) ^ 2 :=
  NecSuf.sq_pos_of_pos_implication_chain (absGamma2_thetaTilde_pos P hM μ)

/-- `gamma1R_thetaTilde_sq_le_one_of_le_one` を `NecSuf.sq_le_one_of_le_one_chain`（`R := ℝ`）の特殊化として得る。 -/
theorem gamma1R_thetaTilde_sq_le_one_of_le_one_of_necSuf (M : ℕ) (μ : ℤ)
    (hg0 : 0 < gamma1R P.const (thetaTilde M μ)) (h : gamma1R P.const (thetaTilde M μ) ≤ 1) :
    gamma1R P.const (thetaTilde M μ) ^ 2 ≤ 1 :=
  NecSuf.sq_le_one_of_le_one_chain hg0 h

/-- `one_lt_gamma1R_thetaTilde` を `NecSuf.one_lt_of_sq_gt_one`（`R := ℝ`）の特殊化として得る。 -/
theorem one_lt_gamma1R_thetaTilde_of_necSuf (hdual : P.const.c2 * P.const.s2star = P.const.c2star)
    {M : ℕ} (hM : M ≠ 0) (μ : ℤ) : 1 < gamma1R P.const (thetaTilde M μ) :=
  NecSuf.one_lt_of_sq_gt_one
    (lt_of_lt_of_le one_pos (one_le_gamma1R P (thetaTilde M μ)))
    (one_lt_gamma1R_sq_thetaTilde P hdual hM μ)

end Ising2D
