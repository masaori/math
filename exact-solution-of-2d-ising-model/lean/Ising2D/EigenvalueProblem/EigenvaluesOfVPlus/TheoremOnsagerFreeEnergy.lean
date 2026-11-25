/-
# Onsager の自由エネルギーの表式

人手証明（`def_Theta_delta_M`・`def_Lambda_delta_M` の正本は `structured-latex/content/eigenvalue_problem_eigenvalues_of_V_plus.ts`、
`onsager_free_energy_expression` の正本は `structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts`）:
- `freeenergy_definition_Theta_delta_M`（ラベル `def_Theta_delta_M`）: 代表点の族 `θ^{(δ)}_{M,μ} = 2π(μ-δ)/M` の定義（`tagPoint δ M μ`）
- `freeenergy_definition_Lambda_delta_M`（ラベル `def_Lambda_delta_M`）: `Λ^{(δ)}_M` の定義（`LambdaM`）
- `freeenergy_005_theorem_onsager_expression`（ラベル `onsager_free_energy_expression`）

**具体版**（人手証明と同じ抽象度）。`log_LambdaM` は人手の証明の第 1 式の鎖（積の対数・冪の対数・
`log(exp y) = y`）どおりに、`onsager_free_energy_expression` は極限の鎖（定数を加えた列の極限・定数倍の列の極限・
`riemann_sum_to_integral`）どおりに書く。必要十分版 `Ising2D/NecSuf/LogSqueeze.lean`
（`Ising2D.NecSuf.log_rpow_mul_exp` / `Ising2D.NecSuf.tendsto_affine`）の特殊化としての導出は
`TheoremOnsagerFreeEnergyFromNecSuf.lean` にある。

  `Λ^{(δ)}_M := (2 sinh 2K_2)^{M/2} exp((1/2) Σ_{μ=1}^{M} γ(θ^{(δ)}_{M,μ}))`
  `(1/M) log Λ^{(δ)}_M → (1/2) log(2 sinh 2K_2) + (1/4π) ∫_0^{2π} γ(θ) dθ`

## 他章への依存

`Λ^{(δ)}_M` は本ファイル内で人手証明の式そのままに定義する（011 章の `c(M)` や
`eigenvalues_of_V` の `Λ_max` との同定は本章の主張ではない）。
`γ` は `Ising2D.gammaFn`（`EigenvalueProblem/DiagonalizationAndExponentialForm/ClaimGamma1LowerBound.lean`）。
-/
import Ising2D.ThermodynamicLimit.ColumnLimitAndClosedForm.ClaimGammaContinuous
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.TheoremRiemannSumToIntegral
import Ising2D.MathematicalTools.RealSquareRootExponentialAndHyperbolicFunctions.ClaimCoshSinhBasicProperties

namespace Ising2D

open Filter MeasureTheory
open scoped Topology

/-- 人手証明 `def_Lambda_delta_M` の `Λ^{(δ)}_M := (2 sinh 2K_2)^{M/2} exp((1/2) Σ_{μ=1}^{M} γ(θ^{(δ)}_{M,μ}))`。
`θ^{(δ)}_{M,μ} = 2π(μ-δ)/M`（人手証明 `def_Theta_delta_M`。`tagPoint δ M μ`）。人手の `Σ_{μ=1}^{M}` を `Finset.Icc 1 M` の上の和で書く
（`Fin M` の上の和への付け替えは `sum_Icc_one_gammaFn_tagPoint_eq_sum_fin`）。 -/
noncomputable def LambdaM (P : IsingParam) (δ : ℝ) (M : ℕ) : ℝ :=
  (2 * Real.sinh (2 * P.K2)) ^ ((M : ℝ) / 2) *
    Real.exp (1 / 2 * ∑ μ ∈ Finset.Icc 1 M, gammaFn P (tagPoint δ M μ))

/-- `2 sinh 2K_2 > 0`（原文 `K_2 > 0`）。 -/
theorem two_sinh_pos (P : IsingParam) : 0 < 2 * Real.sinh (2 * P.K2) := by
  have : 0 < 2 * P.K2 := by linarith [P.K2_pos]
  have := real_sinh_pos_of_pos this
  linarith

theorem LambdaM_pos (P : IsingParam) (δ : ℝ) (M : ℕ) : 0 < LambdaM P δ M := by
  unfold LambdaM
  have h := two_sinh_pos P
  positivity

/-- 人手証明 proof の第 1 式:
`log Λ^{(δ)}_M = (M/2) log(2 sinh 2K_2) + (1/2) Σ γ(θ)`。
人手の 4 行の鎖（`def_Lambda_delta_M`、積の対数、冪の対数、`log(exp y) = y`）と 1 対 1。 -/
theorem log_LambdaM (P : IsingParam) (δ : ℝ) (M : ℕ) :
    Real.log (LambdaM P δ M)
      = (M : ℝ) / 2 * Real.log (2 * Real.sinh (2 * P.K2))
        + 1 / 2 * ∑ μ ∈ Finset.Icc 1 M, gammaFn P (tagPoint δ M μ) := by
  -- 人手の準備: `2 sinh 2K_2 > 0`（`K_2 > 0`）
  have hA : 0 < 2 * Real.sinh (2 * P.K2) := two_sinh_pos P
  calc Real.log (LambdaM P δ M)
      -- 第 1 行（∵ `Λ^{(δ)}_M` の定義。`def_Lambda_delta_M`）
      = Real.log ((2 * Real.sinh (2 * P.K2)) ^ ((M : ℝ) / 2) *
          Real.exp (1 / 2 * ∑ μ ∈ Finset.Icc 1 M, gammaFn P (tagPoint δ M μ))) := rfl
    -- 第 2 行（∵ 積の対数 `log(ab) = log a + log b`。`a > 0`（`hA` と冪の正値性）、`b > 0`（`exp` の正値性））
    _ = Real.log ((2 * Real.sinh (2 * P.K2)) ^ ((M : ℝ) / 2))
          + Real.log (Real.exp (1 / 2 * ∑ μ ∈ Finset.Icc 1 M, gammaFn P (tagPoint δ M μ))) :=
        Real.log_mul (Real.rpow_pos_of_pos hA _).ne' (Real.exp_pos _).ne'
    -- 第 3 行（∵ 冪の対数 `log(x^r) = r log x`。`x > 0`）
    _ = (M : ℝ) / 2 * Real.log (2 * Real.sinh (2 * P.K2))
          + Real.log (Real.exp (1 / 2 * ∑ μ ∈ Finset.Icc 1 M, gammaFn P (tagPoint δ M μ))) := by
        rw [Real.log_rpow hA]
    -- 第 4 行（∵ `log(exp(y)) = y`）
    _ = (M : ℝ) / 2 * Real.log (2 * Real.sinh (2 * P.K2))
          + 1 / 2 * ∑ μ ∈ Finset.Icc 1 M, gammaFn P (tagPoint δ M μ) := by
        rw [Real.log_exp]

/-- 人手証明 proof の第 2 式（`M > 0` で割った形）:
`(1/M) log Λ^{(δ)}_M = (1/2) log(2 sinh 2K_2) + (1/2)·(1/M)Σ γ(θ)`。 -/
theorem inv_M_log_LambdaM (P : IsingParam) (δ : ℝ) {M : ℕ} (hM : M ≠ 0) :
    1 / (M : ℝ) * Real.log (LambdaM P δ M)
      = 1 / 2 * Real.log (2 * Real.sinh (2 * P.K2))
        + 1 / 2 * (1 / (M : ℝ) * ∑ μ ∈ Finset.Icc 1 M, gammaFn P (tagPoint δ M μ)) := by
  have hMR : (M : ℝ) ≠ 0 := Nat.cast_ne_zero.2 hM
  rw [log_LambdaM]
  field_simp

/-- **人手証明 `onsager_free_energy_expression` そのもの**:

  `(1/M) log Λ^{(δ)}_M → (1/2) log(2 sinh 2K_2) + (1/4π) ∫_0^{2π} γ(θ) dθ`

右辺は `δ` に依らない。 -/
theorem onsager_free_energy_expression (P : IsingParam) {δ : ℝ} (hδ0 : 0 ≤ δ) (hδ1 : δ < 1) :
    Tendsto (fun M : ℕ => 1 / (M : ℝ) * Real.log (LambdaM P δ M)) atTop
      (𝓝 (1 / 2 * Real.log (2 * Real.sinh (2 * P.K2))
        + 1 / (4 * Real.pi) * ∫ θ in (0:ℝ)..(2 * Real.pi), gammaFn P θ)) := by
  have hpi : (0 : ℝ) < Real.pi := Real.pi_pos
  -- 人手の極限の鎖の第 4 行の収束（∵ `gamma_is_continuous` と `riemann_sum_to_integral`。実数解析への移行点）
  have hsum := riemann_sum_to_integral (gamma_is_continuous P) hδ0 hδ1.le
  -- 人手の極限の鎖の第 3 行（∵ 収束する実数列の定数倍は収束し、極限が定数倍になる）
  have hmul := hsum.const_mul (1 / 2 : ℝ)
  -- 人手の極限の鎖の第 2 行（∵ 収束する実数列に定数を加えた列は収束し、極限に定数が加わる）
  have haff := hmul.const_add (1 / 2 * Real.log (2 * Real.sinh (2 * P.K2)))
  -- 人手の極限の鎖の第 5 行（∵ ℝ の四則 `1/2 · 1/(2π) = 1/(4π)`）
  have hval : 1 / 2 * Real.log (2 * Real.sinh (2 * P.K2))
      + 1 / 2 * (1 / (2 * Real.pi) * ∫ θ in (0:ℝ)..(2 * Real.pi), gammaFn P θ)
      = 1 / 2 * Real.log (2 * Real.sinh (2 * P.K2))
        + 1 / (4 * Real.pi) * ∫ θ in (0:ℝ)..(2 * Real.pi), gammaFn P θ := by
    field_simp
    ring
  rw [← hval]
  -- 人手の極限の鎖の第 1 行（∵ 上で得た `(1/M) log Λ^{(δ)}_M` の表示を代入。`M > 0` の項で一致）
  refine Filter.Tendsto.congr' ?_ haff
  filter_upwards [Filter.eventually_gt_atTop 0] with M hM
  exact (inv_M_log_LambdaM P δ hM.ne').symm

/-- 人手証明の「**右辺は `δ` に依らない**」を、2 つの `δ` の極限が一致する形で述べたもの。 -/
theorem onsager_free_energy_expression_indep_delta (P : IsingParam)
    {δ₁ δ₂ : ℝ} (h1 : 0 ≤ δ₁) (h1' : δ₁ < 1) (h2 : 0 ≤ δ₂) (h2' : δ₂ < 1) {L₁ L₂ : ℝ}
    (hL₁ : Tendsto (fun M : ℕ => 1 / (M : ℝ) * Real.log (LambdaM P δ₁ M)) atTop (𝓝 L₁))
    (hL₂ : Tendsto (fun M : ℕ => 1 / (M : ℝ) * Real.log (LambdaM P δ₂ M)) atTop (𝓝 L₂)) :
    L₁ = L₂ := by
  have e1 := tendsto_nhds_unique hL₁ (onsager_free_energy_expression P h1 h1')
  have e2 := tendsto_nhds_unique hL₂ (onsager_free_energy_expression P h2 h2')
  rw [e1, e2]

end Ising2D
