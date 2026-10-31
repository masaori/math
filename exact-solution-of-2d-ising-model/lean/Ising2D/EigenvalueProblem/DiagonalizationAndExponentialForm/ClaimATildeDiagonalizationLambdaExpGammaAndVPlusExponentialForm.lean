/-
# `A(θ̃_μ)` の対角化と `V^{(+)}` の指数表示の章の章末の主張

対応する人手証明（正本は `structured-latex/content/eigenvalue_problem_diagonalization_and_exponential_form.ts`）:

* `diagonalization_and_exponential_form_claim_A_theta_tilde_diagonalization_lambda_exp_gamma_and_V_plus_exponential_form`
  （ラベル **`A_theta_tilde_diagonalization_lambda_exp_gamma_and_V_plus_exponential_form`**）

主張（`μ ∈ 𝓜̌` は `j : Fin M` の `checkIdx M j = j + 1` で走る）:
(1) `det P̌_μ ≠ 0` かつ `A(θ̃_μ) = P̌_μ diag(λ_{+,μ}, λ_{-,μ}) P̌_μ^{-1}`、
(2) `λ_{±,μ} = e^{±γ(θ̃_μ)}`、
(3) `γ(θ) = arccosh(cosh 2K_1 cosh 2K_2^* − sinh 2K_1 sinh 2K_2^* cos θ)`（`θ ∈ ℝ`）、
(4) `(ψ̌_μ^†, ψ̌_μ) = (Ž_μ, Y̌_μ) P̌_μ`、`ň_μ = ψ̌_μ^† ψ̌_{M+1-μ}`、
(5) ある `c ∈ ℂ^×` で `V^{(+)} = c exp(Σ_{μ ∈ 𝓜̌} γ(θ̃_μ)(ň_μ - ½ I))`。

## 人手証明との対応

人手の証明は既存の主張と定義を挙げるだけである。

* (1): `diagonalization_check_P_D`（`det_checkPmat_ne_zero`、
  `AMat_thetaTilde_eq_checkPmat_mul_checkDmat_mul_inv`。`Ď_μ` は `checkDmat` で、その定義が `diag(λ_+, λ_-)`）
* (2): `lambda_eq_exp_gamma_theta_tilde`（`lambdaPlusR_eq_exp`、`lambdaMinusR_eq_exp`。
  双対関係は定理 `IsingParam.c2_mul_s2star_eq_c2star` で与える）
* (3): `def_gamma_theta`・`def_gamma1_gamma2_of_theta`・`def_indexed_hyperbolic_abbreviations` の展開（`gammaFn_eq`）
* (4): `def_check_fermi`（`checkPsiDag_eq_checkPmat_col`、`checkPsi_eq_checkPmat_col`）と
  `def_check_number_operator`（`checkFermiOf_nOp`）
* (5): `V_plus_eq_c_exp_sum_gamma_check_number_operator`

人手の主張は既存の主張を並べるだけなので、必要十分版は置かない。
-/
import Ising2D.EigenvalueProblem.DiagonalizationAndExponentialForm.ClaimVPlusEqCExpSumCheckNumberOperator
import Ising2D.EigenvalueProblem.DiagonalizationAndExponentialForm.ClaimCheckFermiResultsUnconditional
import Ising2D.EigenvalueProblem.DiagonalizationAndExponentialForm.ClaimEigenATildeDiag

namespace Ising2D

variable {M : ℕ}

/-- **人手 `A_theta_tilde_diagonalization_lambda_exp_gamma_and_V_plus_exponential_form`**。 -/
theorem A_theta_tilde_diagonalization_lambda_exp_gamma_and_V_plus_exponential_form
    (P : IsingParam) (hM : M ≠ 0) :
    (∀ j : Fin M,
        (checkPmat P.const M (checkIdx M j)).det ≠ 0
          ∧ AMat P.const (thetaTilde M (checkIdx M j))
            = checkPmat P.const M (checkIdx M j)
              * !![((lambdaPlusR P.const (thetaTilde M (checkIdx M j)) : ℝ) : ℂ), 0;
                  0, ((lambdaMinusR P.const (thetaTilde M (checkIdx M j)) : ℝ) : ℂ)]
              * (checkPmat P.const M (checkIdx M j))⁻¹)
      ∧ (∀ j : Fin M,
          lambdaPlusR P.const (thetaTilde M (checkIdx M j)) = Real.exp (gammaTilde P M (checkIdx M j))
            ∧ lambdaMinusR P.const (thetaTilde M (checkIdx M j))
              = Real.exp (-gammaTilde P M (checkIdx M j)))
      ∧ (∀ θ : ℝ,
          gammaFn P θ = Real.arcosh (Real.cosh (2 * P.K1) * Real.cosh (2 * P.K2star)
            - Real.sinh (2 * P.K1) * Real.sinh (2 * P.K2star) * Real.cos θ))
      ∧ (∀ j : Fin M,
          checkPsiDag P.const M (checkIdx M j)
              = checkPmat P.const M (checkIdx M j) 0 0 • checkZ M (checkIdx M j)
                + checkPmat P.const M (checkIdx M j) 1 0 • checkY M (checkIdx M j)
            ∧ checkPsi P.const M (checkIdx M j)
              = checkPmat P.const M (checkIdx M j) 0 1 • checkZ M (checkIdx M j)
                + checkPmat P.const M (checkIdx M j) 1 1 • checkY M (checkIdx M j)
            ∧ (checkFermiOf P hM).nOp j
              = checkPsiDag P.const M (checkIdx M j)
                * checkPsi P.const M ((M : ℤ) + 1 - checkIdx M j))
      ∧ (∃ c : ℂ, c ≠ 0 ∧
          VPlus M (Real.sinh (2 * P.K2)) (P.K1 : ℂ) (P.K2star : ℂ)
            = c • matExp (∑ j : Fin M, gammaTildeC P M (checkIdx M j) •
                ((checkFermiOf P hM).nOp j - (1 / 2 : ℂ) • (1 : TensorPow M)))) :=
  ⟨fun j => ⟨det_checkPmat_ne_zero P hM (checkIdx M j),                         -- 人手の (1)
      AMat_thetaTilde_eq_checkPmat_mul_checkDmat_mul_inv P hM (checkIdx M j)⟩,
    fun j => ⟨lambdaPlusR_eq_exp P P.c2_mul_s2star_eq_c2star M (checkIdx M j),    -- 人手の (2)
      lambdaMinusR_eq_exp P P.c2_mul_s2star_eq_c2star M (checkIdx M j)⟩,
    gammaFn_eq P,                                                                  -- 人手の (3)
    fun j => ⟨checkPsiDag_eq_checkPmat_col P.const M (checkIdx M j),              -- 人手の (4)
      checkPsi_eq_checkPmat_col P.const M (checkIdx M j), checkFermiOf_nOp P hM j⟩,
    V_plus_eq_c_exp_sum_gamma_check_number_operator P hM⟩                         -- 人手の (5)

end Ising2D
