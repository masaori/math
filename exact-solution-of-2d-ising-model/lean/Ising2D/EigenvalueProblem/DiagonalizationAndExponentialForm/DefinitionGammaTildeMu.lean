/-
# `γ(θ~_μ) > 0` と `λ_{±,μ} = e^{±γ(θ~_μ)}`（**具体版**）

対応する人手証明のラベル: `def_gamma_theta`（`θ = θ~_μ` での値）, `gamma_theta_tilde_mu_positive`（`γ(θ~_μ) > 0`）,
`lambda_eq_exp_gamma_theta_tilde`
（`structured-latex/content/eigenvalue_problem_diagonalization_and_exponential_form.ts` の
`Athetatilde_008_claim_gamma_theta_tilde_positive`, `Athetatilde_009_claim_lambda_eq_exp_gamma`）

**必要十分版**: `Ising2D/NecSuf/ArcoshExp.lean`
（`Ising2D.NecSuf.sinh_arcosh_of_sq` / `exp_arcosh_of_sq` / `exp_neg_arcosh_of_sq` /
`arcosh_pos_of_one_lt`）。`λ_{±,μ} = e^{±γ(θ~_μ)}` の具体版はその系として導出する。
`gammaTilde_pos` は人手の鎖どおりに示し、必要十分版の特殊化としての導出は
`ClaimGammaThetaTildeMuPositiveFromNecSuf.lean` に置く。

## 形式化の方針

* `arccosh` は mathlib の `Real.arcosh` を使う（`lean/README.md` の
  「mathlib に `Real.arccosh` は無い」は**誤り**である。詳細は
  `Ising2D/NecSuf/Arcosh.lean` 冒頭。綴りは `arcosh`）。
* `γ(θ) := arccosh(γ_1(θ))` は人手 `def_gamma_theta`（実数 `θ` 全体）で、Lean では
  `Ising2D.gammaFn` として定義済みなので、**`θ = θ~_μ` での値 `gammaTilde` を置くだけ**でよい。
  well-defined 性（人手証明が `γ_1 ≥ 1` を要求している点）は 012 章の
  `Ising2D.one_le_gamma1R`（すべての実数 `θ` で成立）が与える。
* 本章に固有なのは **`γ(θ~_μ) > 0`（狭義）** である。これは
  `gamma1_gt_1_theta_tilde`（`Ising2D.one_lt_gamma1R_thetaTilde`）から従い、
  その源は `gamma_2_theta_tilde_nonzero` である。
  008 章（整数運動量）では `γ(θ_μ) ≥ 0` しか言えない。
-/
import Ising2D.EigenvalueProblem.DiagonalizationAndExponentialForm.ClaimDetATilde
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealNegationOfZeroIsZero

namespace Ising2D

variable (P : IsingParam)

/-- **人手 `def_gamma_theta` の `θ = θ~_μ` での値**: `γ(θ~_μ) = arccosh(γ_1(θ~_μ))`。 -/
noncomputable def gammaTilde (M : ℕ) (μ : ℤ) : ℝ := gammaFn P (thetaTilde M μ)

/-- `cosh γ(θ~_μ) = γ_1(θ~_μ)`（人手 `def_gamma_theta` の `cosh γ(θ) = γ_1(θ)`）。 -/
theorem cosh_gammaTilde (M : ℕ) (μ : ℤ) :
    Real.cosh (gammaTilde P M μ) = gamma1R P.const (thetaTilde M μ) :=
  cosh_gammaFn P (thetaTilde M μ)

/-- `γ(θ~_μ) ≥ 0`。 -/
theorem gammaTilde_nonneg (M : ℕ) (μ : ℤ) : 0 ≤ gammaTilde P M μ :=
  gammaFn_nonneg P (thetaTilde M μ)

/-- **人手証明 `gamma_theta_tilde_mu_positive`**: `γ(θ~_μ) > 0`（**狭義**）。
人手の準備（`g := γ_1(θ~_μ)`、`t := γ(θ~_μ)`、`g > 1`、`t = arccosh g`、`t ≥ 0`、`cosh t = g`）と、
背理の鎖 `g = cosh t = cosh 0 = (exp 0 + exp(−0))/2 = (exp 0 + exp 0)/2 = (1 + 1)/2 = 1` の 6 行と、
`1 > 1` の矛盾から `t ≠ 0`、`t ≥ 0` と合わせて `t > 0` とする結論に 1 対 1 に対応する。
人手は `μ ∈ 𝓜̌` で述べるが、ここは `g > 1` を `μ ∈ ℤ` 全体で与える `one_lt_gamma1R_thetaTilde`（仮定 `hdual`）から取る。
`μ ∈ 𝓜̌` で述べた版は `TheoremMaxEigenvalueSimple.lean` の `gammaFn_thetaTilde_pos`（同じ鎖）。
`arccosh_properties` (1)・(2)・`def_cosh_sinh`・`scalar_exp_zero` は本文に具体版の宣言が無く、mathlib の
`Real.arcosh_nonneg`・`Real.cosh_arcosh`・`Real.cosh_eq`・`Real.exp_zero` で受け取る。
必要十分版 `NecSuf.arcosh_pos_of_one_lt` は同じ手順で、その特殊化は
`ClaimGammaThetaTildeMuPositiveFromNecSuf.lean` の `gammaTilde_pos_of_necSuf`。 -/
theorem gammaTilde_pos (hdual : P.const.c2 * P.const.s2star = P.const.c2star)
    {M : ℕ} (hM : M ≠ 0) (μ : ℤ) : 0 < gammaTilde P M μ := by
  -- 準備: `g := γ_1(θ~_μ)`、`t := γ(θ~_μ)`
  have hg : 1 < gamma1R P.const (thetaTilde M μ) := one_lt_gamma1R_thetaTilde P hdual hM μ
    -- `gamma1_gt_1_theta_tilde`
  have hg1 : 1 ≤ gamma1R P.const (thetaTilde M μ) := hg.le
    -- とくに `g ≥ 1`
  have ht : gammaTilde P M μ = Real.arcosh (gamma1R P.const (thetaTilde M μ)) := rfl
    -- `def_gamma_theta`
  have ht0 : 0 ≤ gammaTilde P M μ := by rw [ht]; exact Real.arcosh_nonneg hg1
    -- `arccosh_properties` (1)（`y = g`）
  have hcosh : Real.cosh (gammaTilde P M μ) = gamma1R P.const (thetaTilde M μ) := by
    rw [ht]; exact Real.cosh_arcosh hg1
    -- `arccosh_properties` (2)（`y = g`）
  -- `t = 0` と仮定すると `g = 1`
  have hne : gammaTilde P M μ ≠ 0 := by
    intro h0
    have hchain : gamma1R P.const (thetaTilde M μ) = 1 :=
      calc gamma1R P.const (thetaTilde M μ)
          = Real.cosh (gammaTilde P M μ) := hcosh.symm          -- 準備の `cosh t = g`
        _ = Real.cosh 0 := by rw [h0]                            -- 仮定 `t = 0`
        _ = (Real.exp 0 + Real.exp (-0)) / 2 := Real.cosh_eq 0   -- `def_cosh_sinh`
        _ = (Real.exp 0 + Real.exp 0) / 2 := by
            rw [real_negation_of_zero_is_zero]                    -- `real_negation_of_zero_is_zero`
        _ = (1 + 1) / 2 := by rw [Real.exp_zero]                 -- `scalar_exp_zero`（`K = ℝ`）
        _ = 1 := by norm_num                                     -- ℝ の四則
    -- 準備の `g > 1` と合わせて `1 > 1`（ℝ の順序に矛盾）
    have h11 : (1 : ℝ) < 1 := by rw [hchain] at hg; exact hg
    exact lt_irrefl (1 : ℝ) h11
  -- `t ≠ 0` と準備の `t ≥ 0` から `t > 0`
  exact lt_of_le_of_ne ht0 (Ne.symm hne)

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
