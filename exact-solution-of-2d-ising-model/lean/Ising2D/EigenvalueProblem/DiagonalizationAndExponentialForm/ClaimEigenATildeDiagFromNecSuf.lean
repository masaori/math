/-
# `A(θ~_μ)` の固有値・固有ベクトルと対角化を**必要十分版から導出**する

対応する人手証明のラベル: `eigenvector_of_A_theta_tilde`, `diagonalization_check_P_D`
（`structured-latex/content/eigenvalue_problem_diagonalization_and_exponential_form.ts` の
`Athetatilde_004_claim_eigenvector`, `Athetatilde_005_claim_diagonalization`）

具体版（人手と 1 対 1）は `ClaimEigenATildeDiag.lean`、必要十分版は `Ising2D/NecSuf/TwoByTwoSkew.lean`。
各定理は、具体版の同名の定理（末尾の `_of_necSuf` を除いた名前）と同じ主張を、必要十分版の特殊化として示す。

特殊化の中身は、係数を `ℂ`、`g := γ_1(θ)`、`a := γ_2(θ)`、`b := γ_2(-θ)`、`s := |γ_2(θ)|` とし、
`A(θ) = !![g, a; -b, g]`（`AMat_eq`、人手 `def_gamma1_gamma2_of_theta`）、
`λ_{±,μ} = g ± s`（`lambdaPlusR_ofReal`・`lambdaMinusR_ofReal`）、
`a b = -s^2`（`gamma2_mul_gamma2_neg_eq_neg_absGamma2_sq`、人手 `relation_of_gamma_2_theta_tilde` (2)）
を渡すことだけである。仮定として渡す `γ_2` の関係は `a b = -r^2` だけで、具体版の Step 2 が経る
`b = -ā` と `a ā = r^2` の 2 段は渡していない（`a b = -r^2` 自体は上流で `b = -ā` から導かれている）。
`λ_+ ≠ λ_-` と `det P̌_μ ≠ 0` には `2r ≠ 0`（`r > 0` から）、`det P̌_μ` には列が `c v_{±,μ}` であること
（`checkPmat_col_pos`・`checkPmat_col_neg`）と `c = 1/(2√M b)`、`(√M)^2 = M` を渡す。
-/
import Ising2D.EigenvalueProblem.DiagonalizationAndExponentialForm.ClaimEigenATildeDiag
import Ising2D.NecSuf.TwoByTwoSkew

namespace Ising2D

open Matrix

variable (K : IsingConst) (θ : ℝ)

/-- **`charPoly_factor_thetaTilde`（Step 1）を `NecSuf.skew2_charPoly`・`NecSuf.skew2_charPoly_factor` の特殊化として導いたもの**。 -/
theorem charPoly_factor_thetaTilde_of_necSuf (lam : ℂ) :
    (AMat K θ - lam • (1 : Matrix (Fin 2) (Fin 2) ℂ)).det
      = (lam - ((lambdaPlusR K θ : ℝ) : ℂ)) * (lam - ((lambdaMinusR K θ : ℝ) : ℂ)) := by
  rw [AMat_eq, lambdaPlusR_ofReal, lambdaMinusR_ofReal, NecSuf.skew2_charPoly,
    NecSuf.skew2_charPoly_factor _ _ _ _ _ (gamma2_mul_gamma2_neg_eq_neg_absGamma2_sq K θ)]

/-- **`det_AMat_sub_smul_eq_zero_iff`（Step 1 の結論）を `NecSuf.skew2_det_eq_zero_iff` の特殊化として導いたもの**。 -/
theorem det_AMat_sub_smul_eq_zero_iff_of_necSuf (lam : ℂ) :
    (AMat K θ - lam • (1 : Matrix (Fin 2) (Fin 2) ℂ)).det = 0
      ↔ lam = ((lambdaPlusR K θ : ℝ) : ℂ) ∨ lam = ((lambdaMinusR K θ : ℝ) : ℂ) := by
  rw [AMat_eq, lambdaPlusR_ofReal, lambdaMinusR_ofReal]
  exact NecSuf.skew2_det_eq_zero_iff _ _ _ _ lam (gamma2_mul_gamma2_neg_eq_neg_absGamma2_sq K θ)

/-- **`eigenvalue_AMat_iff`（Step 1 の主張）を `NecSuf.skew2_eigenvalue_iff` の特殊化として導いたもの**。 -/
theorem eigenvalue_AMat_iff_of_necSuf (lam : ℂ) :
    IsEigenvalue (AMat K θ) lam
      ↔ lam = ((lambdaPlusR K θ : ℝ) : ℂ) ∨ lam = ((lambdaMinusR K θ : ℝ) : ℂ) := by
  rw [AMat_eq, lambdaPlusR_ofReal, lambdaMinusR_ofReal]
  exact NecSuf.skew2_eigenvalue_iff _ _ _ _ lam (gamma2_mul_gamma2_neg_eq_neg_absGamma2_sq K θ)

/-- **`lambdaPlusR_ne_lambdaMinusR`（Step 1 の末尾）を `NecSuf.skew2_eigenvalues_ne` の特殊化（係数 `ℝ`）として導いたもの**。 -/
theorem lambdaPlusR_ne_lambdaMinusR_of_necSuf (P : IsingParam) {M : ℕ} (hM : M ≠ 0) (μ : ℤ) :
    lambdaPlusR P.const (thetaTilde M μ) ≠ lambdaMinusR P.const (thetaTilde M μ) := by
  have hr := absGamma2_thetaTilde_pos P hM μ
  exact NecSuf.skew2_eigenvalues_ne _ _ (ne_of_gt (by linarith))

/-- **`AMat_mulVec_eigen_pos`（Step 2）を `NecSuf.skew2_mulVec_pos` の特殊化として導いたもの**。 -/
theorem AMat_mulVec_eigen_pos_of_necSuf :
    AMat K θ *ᵥ ![-((absGamma2 K θ : ℝ) : ℂ), gamma2 K (-θ)]
      = ((lambdaPlusR K θ : ℝ) : ℂ) • ![-((absGamma2 K θ : ℝ) : ℂ), gamma2 K (-θ)] := by
  rw [AMat_eq, lambdaPlusR_ofReal]
  exact NecSuf.skew2_mulVec_pos _ _ _ _ (gamma2_mul_gamma2_neg_eq_neg_absGamma2_sq K θ)

/-- **`AMat_mulVec_eigen_neg`（Step 2）を `NecSuf.skew2_mulVec_neg` の特殊化として導いたもの**。 -/
theorem AMat_mulVec_eigen_neg_of_necSuf :
    AMat K θ *ᵥ ![((absGamma2 K θ : ℝ) : ℂ), gamma2 K (-θ)]
      = ((lambdaMinusR K θ : ℝ) : ℂ) • ![((absGamma2 K θ : ℝ) : ℂ), gamma2 K (-θ)] := by
  rw [AMat_eq, lambdaMinusR_ofReal]
  exact NecSuf.skew2_mulVec_neg _ _ _ _ (gamma2_mul_gamma2_neg_eq_neg_absGamma2_sq K θ)

/-- **`AMat_mulVec_smul_eigen_pos`（Step 2 の `c` 倍）を `NecSuf.mulVec_smul_of_mulVec_eq` の特殊化として導いたもの**。 -/
theorem AMat_mulVec_smul_eigen_pos_of_necSuf (c : ℂ) :
    AMat K θ *ᵥ (c • ![-((absGamma2 K θ : ℝ) : ℂ), gamma2 K (-θ)])
      = ((lambdaPlusR K θ : ℝ) : ℂ) • (c • ![-((absGamma2 K θ : ℝ) : ℂ), gamma2 K (-θ)]) :=
  NecSuf.mulVec_smul_of_mulVec_eq (AMat_mulVec_eigen_pos_of_necSuf K θ) c

/-- **`AMat_mulVec_smul_eigen_neg`（Step 2 の `c` 倍）を `NecSuf.mulVec_smul_of_mulVec_eq` の特殊化として導いたもの**。 -/
theorem AMat_mulVec_smul_eigen_neg_of_necSuf (c : ℂ) :
    AMat K θ *ᵥ (c • ![((absGamma2 K θ : ℝ) : ℂ), gamma2 K (-θ)])
      = ((lambdaMinusR K θ : ℝ) : ℂ) • (c • ![((absGamma2 K θ : ℝ) : ℂ), gamma2 K (-θ)]) :=
  NecSuf.mulVec_smul_of_mulVec_eq (AMat_mulVec_eigen_neg_of_necSuf K θ) c

/-- **`AMat_mul_checkPmat`（`diagonalization_check_P_D` Step 2）を `NecSuf.skew2_mul_of_cols` の特殊化として導いたもの**。
列が `c v_{±,μ}` であることは具体版の `checkPmat_col_pos`・`checkPmat_col_neg` を渡す。 -/
theorem AMat_mul_checkPmat_of_necSuf (P : IsingParam) {M : ℕ} (hM : M ≠ 0) (μ : ℤ) :
    AMat P.const (thetaTilde M μ) * checkPmat P.const M μ
      = checkPmat P.const M μ * checkDmat P.const M μ := by
  rw [AMat_eq, checkDmat, lambdaPlusR_ofReal, lambdaMinusR_ofReal]
  exact NecSuf.skew2_mul_of_cols _ _ _ _ _
    (gamma2_mul_gamma2_neg_eq_neg_absGamma2_sq P.const (thetaTilde M μ))
    (checkPmat_col_pos P hM μ) (checkPmat_col_neg P hM μ)

/-- **`det_checkPmat`（`diagonalization_check_P_D` Step 3）を `NecSuf.det_of_cols` の特殊化として導いたもの**。
必要十分版の値 `-2c^2 r b` に `c = 1/(2√M b)` と `(√M)^2 = M` を入れると具体版の値になる。 -/
theorem det_checkPmat_of_necSuf (P : IsingParam) {M : ℕ} (hM : M ≠ 0) (μ : ℤ) :
    (checkPmat P.const M μ).det
      = -((absGamma2 P.const (thetaTilde M μ) : ℝ) : ℂ) /
          (2 * (M : ℂ) * gamma2 P.const (-thetaTilde M μ)) := by
  have hb := gamma2_neg_thetaTilde_ne_zero P hM μ
  have hs := sqrtM_cast_ne_zero hM
  have hM' : (M : ℂ) ≠ 0 := Nat.cast_ne_zero.2 hM
  have hsq : ((Real.sqrt M : ℝ) : ℂ) ^ 2 = (M : ℂ) := by
    rw [← Complex.ofReal_pow, Real.sq_sqrt (Nat.cast_nonneg M)]; push_cast; rfl
  rw [NecSuf.det_of_cols _ _ _ (checkPmat_col_pos P hM μ) (checkPmat_col_neg P hM μ), checkC]
  field_simp
  rw [hsq]
  ring

/-- **`det_checkPmat_ne_zero`（`diagonalization_check_P_D` Step 3 の結論）を `NecSuf.det_of_cols_ne_zero` の特殊化として導いたもの**。 -/
theorem det_checkPmat_ne_zero_of_necSuf (P : IsingParam) {M : ℕ} (hM : M ≠ 0) (μ : ℤ) :
    (checkPmat P.const M μ).det ≠ 0 := by
  have hb := gamma2_neg_thetaTilde_ne_zero P hM μ
  have hr : ((absGamma2 P.const (thetaTilde M μ) : ℝ) : ℂ) ≠ 0 := by
    simp only [ne_eq, Complex.ofReal_eq_zero]
    exact ne_of_gt (absGamma2_thetaTilde_pos P hM μ)
  have hc : checkC P.const M μ ≠ 0 :=
    one_div_ne_zero (mul_ne_zero (mul_ne_zero two_ne_zero (sqrtM_cast_ne_zero hM)) hb)
  exact NecSuf.det_of_cols_ne_zero _ _ _ (checkPmat_col_pos P hM μ) (checkPmat_col_neg P hM μ)
    (mul_ne_zero two_ne_zero hr) hc hb

/-- **`AMat_thetaTilde_eq_checkPmat_mul_checkDmat_mul_inv`（`diagonalization_check_P_D` Step 4）を
`NecSuf.eq_conj_of_mul_eq` の特殊化として導いたもの**。 -/
theorem AMat_thetaTilde_eq_checkPmat_mul_checkDmat_mul_inv_of_necSuf
    (P : IsingParam) {M : ℕ} (hM : M ≠ 0) (μ : ℤ) :
    AMat P.const (thetaTilde M μ)
      = checkPmat P.const M μ * checkDmat P.const M μ * (checkPmat P.const M μ)⁻¹ :=
  NecSuf.eq_conj_of_mul_eq (AMat_mul_checkPmat_of_necSuf P hM μ)
    (isUnit_iff_ne_zero.2 (det_checkPmat_ne_zero_of_necSuf P hM μ))

end Ising2D
