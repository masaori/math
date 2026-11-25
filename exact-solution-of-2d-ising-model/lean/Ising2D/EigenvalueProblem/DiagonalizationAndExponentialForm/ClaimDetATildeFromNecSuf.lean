/-
# `gamma1_gt_1_theta_tilde`（具体版を必要十分版から導く）

具体版 `ClaimDetATilde.lean` の `gamma1_gt_1_prep_absGamma2_sq_pos`・`gamma1R_thetaTilde_sq_le_one_of_le_one`・
`one_lt_gamma1R_thetaTilde` の主張を、必要十分版 `Ising2D/NecSuf/ArcoshExp.lean` の
`sq_pos_of_pos_implication_chain`・`sq_le_one_of_le_one_chain`・`one_lt_of_sq_gt_one` の
`R := ℝ`（`a := |γ_2(θ~_μ)|`、`t := γ_1(θ~_μ)`）への特殊化として得る。
`sq_pos_of_pos_implication_chain` の仮定 `0·a = 0` には `real_zero_times_is_zero`（`x → |γ_2(θ~_μ)|`）を渡す。
`g^2` の鎖（`one_lt_gamma1R_sq_thetaTilde`）には必要十分版を置いていないので、結論の段の導出はそれを具体版から受け取る。人手のラベルは `gamma1_gt_1_theta_tilde`。

具体版 `det_AMat_thetaTilde_eq_one`（人手 `det_A_theta_tilde`）は、必要十分版 `Ising2D/NecSuf/GammaDetIdentity.lean` の
多項式恒等式 `NecSuf.gamma_det_identity` を ℂ に特殊化して `det_AMat_thetaTilde_eq_one_of_necSuf` としても得る。
-/
import Ising2D.EigenvalueProblem.DiagonalizationAndExponentialForm.ClaimDetATilde
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealZeroTimesIsZero
import Ising2D.NecSuf.GammaDetIdentity
import Ising2D.NecSuf.ArcoshExp

namespace Ising2D

variable (P : IsingParam)

/-- `gamma1_gt_1_prep_absGamma2_sq_pos` を `NecSuf.sq_pos_of_pos_implication_chain`（`R := ℝ`）の特殊化として得る。 -/
theorem gamma1_gt_1_prep_absGamma2_sq_pos_of_necSuf {M : ℕ} (hM : M ≠ 0) (μ : ℤ) :
    0 < absGamma2 P.const (thetaTilde M μ) ^ 2 :=
  NecSuf.sq_pos_of_pos_implication_chain (real_zero_times_is_zero _) (absGamma2_thetaTilde_pos P hM μ)

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

/-- **必要十分版からの導出**（同じ主張の別証明）: `det A(θ~_μ) = 1` は
`NecSuf.gamma_det_identity`（任意の可換環の多項式恒等式）を ℂ に特殊化したものである。 -/
theorem det_AMat_thetaTilde_eq_one_of_necSuf
    (hdual : P.const.c2 * P.const.s2star = P.const.c2star) (M : ℕ) (μ : ℤ) :
    (AMat P.const (thetaTilde M μ)).det = 1 := by
  set θ := thetaTilde M μ with hθ
  have H1 : (P.const.c1 : ℂ) ^ 2 - (P.const.s1 : ℂ) ^ 2 = 1 := P.c1_sq_sub_s1_sq_inclusion
  have H2 : (P.const.c2star : ℂ) ^ 2 - (P.const.s2star : ℂ) ^ 2 = 1 :=
    P.c2star_sq_sub_s2star_sq_inclusion
  have H3 : (P.const.c2 : ℂ) * (P.const.s2star : ℂ) = (P.const.c2star : ℂ) :=
    c2_mul_s2star_inclusion P.const hdual
  have HPy : (Real.cos θ : ℂ) ^ 2 + (Real.sin θ : ℂ) ^ 2 = 1 := by
    rw [real_inclusion_sq_via_product, real_inclusion_sq_via_product, real_inclusion_add,
      Real.cos_sq_add_sin_sq, Complex.ofReal_one]
      -- 準備の像の読み方の和: `real_inclusion_preserves_sum`
  rw [det_AMat_eq_gamma1_sq_add, gamma2_mul_gamma2_neg_sin_form P.const θ _ rfl, gamma1_eq_inclusion_form]
  linear_combination
    NecSuf.gamma_det_identity (P.const.c1 : ℂ) (P.const.s1 : ℂ) (P.const.c2 : ℂ)
      (P.const.c2star : ℂ) (P.const.s2star : ℂ) (Real.cos θ : ℂ) (Real.sin θ : ℂ)
      HPy H1 H2 H3

end Ising2D
