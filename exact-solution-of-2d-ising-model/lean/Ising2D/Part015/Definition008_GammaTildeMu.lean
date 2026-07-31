/-
# `γ(θ~_μ) := arccosh(γ_1(θ~_μ))` と `λ_{±,μ} = e^{±γ(θ~_μ)}`（**具体版**）

対応する人手証明のラベル: `def_gamma_theta_tilde_mu`, `lambda_eq_exp_gamma_theta_tilde`
（`structured-latex/content/015_A_theta_tilde_diagonalization.ts` の
`Athetatilde_008_definition_gamma_theta_tilde`, `Athetatilde_009_claim_lambda_eq_exp_gamma`）

**必要十分版**: `Ising2D/NecSuf/ArcoshExp.lean`
（`Ising2D.NecSuf.sinh_arcosh_of_sq` / `exp_arcosh_of_sq` / `exp_neg_arcosh_of_sq` /
`arcosh_pos_of_one_lt`）。具体版はその系として導出する。

## 形式化の方針

* `arccosh` は mathlib の `Real.arcosh` を使う（`lean/README.md` の
  「mathlib に `Real.arccosh` は無い」は**誤り**である。詳細は
  `Ising2D/NecSuf/Arcosh.lean` 冒頭。綴りは `arcosh`）。
* `γ(θ) := arccosh(γ_1(θ))` は 012 章で既に `Ising2D.gammaFn`（実数 `θ` 全体）として
  定義済みなので、**半整数運動量への特殊化 `gammaTilde` を置くだけ**でよい。
  well-defined 性（人手証明が `γ_1 ≥ 1` を要求している点）は 012 章の
  `Ising2D.one_le_gamma1R`（すべての実数 `θ` で成立）が与える。
* 本章に固有なのは **`γ(θ~_μ) > 0`（狭義）** である。これは
  `gamma1_gt_1_theta_tilde`（`Ising2D.one_lt_gamma1R_thetaTilde`）から従い、
  その源は `gamma_2_theta_tilde_nonzero` である。
  008 章（整数運動量）では `γ(θ_μ) ≥ 0` しか言えない。
-/
import Ising2D.Part015.Claim006_DetATilde

namespace Ising2D

variable (P : IsingParam)

/-- **人手証明 `def_gamma_theta_tilde_mu`**: `γ(θ~_μ) := arccosh(γ_1(θ~_μ))`。 -/
noncomputable def gammaTilde (M : ℕ) (μ : ℤ) : ℝ := gammaFn P (thetaTilde M μ)

/-- `cosh γ(θ~_μ) = γ_1(θ~_μ)`（`arccosh` の定義性質）。 -/
theorem cosh_gammaTilde (M : ℕ) (μ : ℤ) :
    Real.cosh (gammaTilde P M μ) = gamma1R P.const (thetaTilde M μ) :=
  cosh_gammaFn P (thetaTilde M μ)

/-- `γ(θ~_μ) ≥ 0`。 -/
theorem gammaTilde_nonneg (M : ℕ) (μ : ℤ) : 0 ≤ gammaTilde P M μ :=
  gammaFn_nonneg P (thetaTilde M μ)

/-- **人手証明 `def_gamma_theta_tilde_mu` の後半**: `γ(θ~_μ) > 0`（**狭義**）。 -/
theorem gammaTilde_pos (hdual : P.const.c2 * P.const.s2star = P.const.c2star)
    {M : ℕ} (hM : M ≠ 0) (μ : ℤ) : 0 < gammaTilde P M μ :=
  NecSuf.arcosh_pos_of_one_lt (one_lt_gamma1R_thetaTilde P hdual hM μ)

/-! ## `λ_{±,μ} = e^{±γ(θ~_μ)}`（人手証明 `lambda_eq_exp_gamma_theta_tilde`） -/

/-- **人手証明 Step 1**: `sinh γ(θ~_μ) = |γ_2(θ~_μ)|`。 -/
theorem sinh_gammaTilde (hdual : P.const.c2 * P.const.s2star = P.const.c2star)
    (M : ℕ) (μ : ℤ) :
    Real.sinh (gammaTilde P M μ) = absGamma2 P.const (thetaTilde M μ) :=
  NecSuf.sinh_arcosh_of_sq (one_le_gamma1R P (thetaTilde M μ))
    (absGamma2_nonneg _ _) (gamma1R_sq_thetaTilde P hdual M μ)

/-- **人手証明 Step 2**: `λ_{+,μ} = e^{+γ(θ~_μ)}`。 -/
theorem lambdaPlusR_eq_exp (hdual : P.const.c2 * P.const.s2star = P.const.c2star)
    (M : ℕ) (μ : ℤ) :
    lambdaPlusR P.const (thetaTilde M μ) = Real.exp (gammaTilde P M μ) := by
  rw [lambdaPlusR]
  exact (NecSuf.exp_arcosh_of_sq (one_le_gamma1R P (thetaTilde M μ))
    (absGamma2_nonneg _ _) (gamma1R_sq_thetaTilde P hdual M μ)).symm

/-- **人手証明 Step 2**: `λ_{-,μ} = e^{-γ(θ~_μ)}`。 -/
theorem lambdaMinusR_eq_exp (hdual : P.const.c2 * P.const.s2star = P.const.c2star)
    (M : ℕ) (μ : ℤ) :
    lambdaMinusR P.const (thetaTilde M μ) = Real.exp (-gammaTilde P M μ) := by
  rw [lambdaMinusR]
  exact (NecSuf.exp_neg_arcosh_of_sq (one_le_gamma1R P (thetaTilde M μ))
    (absGamma2_nonneg _ _) (gamma1R_sq_thetaTilde P hdual M μ)).symm

/-- **人手証明 Step 3（固有値の分離）**: `λ_{+,μ} > 1 > λ_{-,μ} > 0`。

008 章（整数運動量）では臨界点で `λ_+ = λ_- = 1` が起こりうるのに対し、
半整数運動量では `γ(θ~_μ) > 0` が確定しているので**必ず分離する**。 -/
theorem lambda_separation (hdual : P.const.c2 * P.const.s2star = P.const.c2star)
    {M : ℕ} (hM : M ≠ 0) (μ : ℤ) :
    1 < lambdaPlusR P.const (thetaTilde M μ)
      ∧ lambdaMinusR P.const (thetaTilde M μ) < 1
      ∧ 0 < lambdaMinusR P.const (thetaTilde M μ) := by
  have hγ := gammaTilde_pos P hdual hM μ
  refine ⟨?_, ?_, ?_⟩
  · rw [lambdaPlusR_eq_exp P hdual M μ]
    simpa using Real.exp_lt_exp.2 hγ
  · rw [lambdaMinusR_eq_exp P hdual M μ]
    have : Real.exp (-gammaTilde P M μ) < Real.exp 0 := Real.exp_lt_exp.2 (by linarith)
    simpa using this
  · rw [lambdaMinusR_eq_exp P hdual M μ]
    exact Real.exp_pos _

end Ising2D
