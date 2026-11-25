/-
# `relation_of_gamma_2_theta_tilde` の (2) の等式と狭義の負・(4)・(5)・`|γ_2| > 0`（具体版を必要十分版から導く）

具体版 `ClaimRelationGamma2Tilde.lean` の `absGamma2_pos_of_ne_zero` を `NecSuf.absOf_pos` の特殊化として、`absGamma2_thetaTilde_sq_pos`・`neg_absGamma2_thetaTilde_sq_neg` の主張を、
必要十分版 `Ising2D/NecSuf/NegConjPair.lean` の `sq_pos_of_pos_chain`・`neg_neg_of_pos_chain` の
`R := ℝ`（`a := |γ_2(θ~_μ)|`、`x := |γ_2(θ~_μ)|^2`）への特殊化として得る。
(2) の等式・(4)・(5) の具体版 `gamma2_mul_gamma2_neg_eq_neg_absSq`・`sq_absGamma2`・`sq_I_absGamma2` の主張を、
`NecSuf.mul_of_eq_neg_conj`・`sq_absOf_eq_neg_mul`・`sq_I_mul_absOf_eq_mul`（`z := γ_2(θ)`、`w := γ_2(-θ)`、仮定は (1) の `gamma2_neg_eq_neg_conj`）の特殊化として得る。
第一の鎖の仮定 `0·a = 0` には、具体版の第 1 段と同じ `real_zero_times_is_zero`（`x → |γ_2(θ~_μ)|`）を渡す。人手のラベルは `relation_of_gamma_2_theta_tilde`。
-/
import Ising2D.EigenvalueProblem.DiagonalizationAndExponentialForm.ClaimRelationGamma2Tilde
import Ising2D.NecSuf.NegConjPair

namespace Ising2D

/-- (2) の等式の具体版 `gamma2_mul_gamma2_neg_eq_neg_absSq` を `NecSuf.mul_of_eq_neg_conj` の特殊化として得る。
必要十分版の右辺 `-((normSq : ℝ) : ℂ)` の符号反転を像の中へ入れるのは `Complex.ofReal_neg`。 -/
theorem gamma2_mul_gamma2_neg_eq_neg_absSq_of_necSuf (K : IsingConst) (θ : ℝ) :
    gamma2 K θ * gamma2 K (-θ) = ((-(absGamma2 K θ ^ 2) : ℝ) : ℂ) := by
  rw [Complex.ofReal_neg, absGamma2_sq]
  exact NecSuf.mul_of_eq_neg_conj (gamma2_neg_eq_neg_conj K θ)

/-- (4) の具体版 `sq_absGamma2` を `NecSuf.sq_absOf_eq_neg_mul` の特殊化として得る。 -/
theorem sq_absGamma2_of_necSuf (K : IsingConst) (θ : ℝ) :
    ((absGamma2 K θ : ℝ) : ℂ) ^ 2 = -(gamma2 K θ * gamma2 K (-θ)) :=
  NecSuf.sq_absOf_eq_neg_mul (gamma2_neg_eq_neg_conj K θ)

/-- (5) の具体版 `sq_I_absGamma2` を `NecSuf.sq_I_mul_absOf_eq_mul` の特殊化として得る。 -/
theorem sq_I_absGamma2_of_necSuf (K : IsingConst) (θ : ℝ) :
    (Complex.I * ((absGamma2 K θ : ℝ) : ℂ)) ^ 2 = gamma2 K θ * gamma2 K (-θ) :=
  NecSuf.sq_I_mul_absOf_eq_mul (gamma2_neg_eq_neg_conj K θ)

/-- (4) の `|γ_2(θ)| > 0` の具体版 `absGamma2_pos_of_ne_zero` を `NecSuf.absOf_pos`（`z := γ_2(θ)`）の特殊化として得る。 -/
theorem absGamma2_pos_of_ne_zero_of_necSuf (K : IsingConst) (θ : ℝ) (hga : gamma2 K θ ≠ 0) :
    0 < absGamma2 K θ :=
  NecSuf.absOf_pos hga

/-- `absGamma2_thetaTilde_sq_pos` を `NecSuf.sq_pos_of_pos_chain`（`R := ℝ`）の特殊化として得る。 -/
theorem absGamma2_thetaTilde_sq_pos_of_necSuf (P : IsingParam) {M : ℕ} (hM : M ≠ 0) (μ : ℤ) :
    0 < absGamma2 P.const (thetaTilde M μ) ^ 2 :=
  NecSuf.sq_pos_of_pos_chain (real_zero_times_is_zero _) (absGamma2_thetaTilde_pos P hM μ)

/-- `neg_absGamma2_thetaTilde_sq_neg` を `NecSuf.neg_neg_of_pos_chain`（`R := ℝ`）の特殊化として得る。 -/
theorem neg_absGamma2_thetaTilde_sq_neg_of_necSuf (P : IsingParam) {M : ℕ} (hM : M ≠ 0) (μ : ℤ) :
    -(absGamma2 P.const (thetaTilde M μ) ^ 2) < 0 :=
  NecSuf.neg_neg_of_pos_chain (NecSuf.sq_pos_of_pos_chain (real_zero_times_is_zero _) (absGamma2_thetaTilde_pos P hM μ))

end Ising2D
