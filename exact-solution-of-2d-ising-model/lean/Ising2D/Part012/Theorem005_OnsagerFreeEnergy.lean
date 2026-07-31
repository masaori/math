/-
# Onsager の自由エネルギーの表式

人手証明（正本は `structured-latex/content/012_free_energy.ts`）:
- `freeenergy_005_theorem_onsager_expression`（ラベル `onsager_free_energy_expression`）

**具体版**（人手証明と同じ抽象度）。必要十分版は
`Ising2D/NecSuf/LogSqueeze.lean`（`Ising2D.NecSuf.log_rpow_mul_exp` /
`Ising2D.NecSuf.tendsto_affine`）と `Ising2D/NecSuf/RiemannSum.lean`
（`Ising2D.NecSuf.tendsto_riemann_sum`）。

  `Λ^{(δ)}_M := (2 sinh 2K_2)^{M/2} exp((1/2) Σ_{θ ∈ Θ^{(δ)}_M} γ(θ))`
  `(1/M) log Λ^{(δ)}_M → (1/2) log(2 sinh 2K_2) + (1/4π) ∫_0^{2π} γ(θ) dθ`

## 他章への依存

`Λ^{(δ)}_M` は本ファイル内で人手証明の式そのままに定義する（011 章の `c(M)` や
`eigenvalues_of_V` の `Λ_max` との同定は本章の主張ではない）。
`γ` は `Ising2D.gammaFn`（`Part012/Claim001_Gamma1LowerBound.lean`）。
-/
import Ising2D.Part012.Claim002_GammaContinuous
import Ising2D.Part012.Theorem004_RiemannSumToIntegral
import Ising2D.NecSuf.LogSqueeze

namespace Ising2D

open Filter MeasureTheory
open scoped Topology

/-- 人手証明の `Λ^{(δ)}_M := (2 sinh 2K_2)^{M/2} exp((1/2) Σ_{θ ∈ Θ^{(δ)}_M} γ(θ))`。
`Θ^{(δ)}_M = { 2π(μ-δ)/M | μ = 1,…,M }`（`tagPoint`）。 -/
noncomputable def LambdaM (P : IsingParam) (δ : ℝ) (M : ℕ) : ℝ :=
  (2 * Real.sinh (2 * P.K2)) ^ ((M : ℝ) / 2) *
    Real.exp (1 / 2 * ∑ μ ∈ Finset.Icc 1 M, gammaFn P (tagPoint δ M μ))

/-- `2 sinh 2K_2 > 0`（原文 `K_2 > 0`）。 -/
theorem two_sinh_pos (P : IsingParam) : 0 < 2 * Real.sinh (2 * P.K2) := by
  have : 0 < 2 * P.K2 := by linarith [P.K2_pos]
  have := Real.sinh_pos_iff.2 this
  linarith

theorem LambdaM_pos (P : IsingParam) (δ : ℝ) (M : ℕ) : 0 < LambdaM P δ M := by
  unfold LambdaM
  have h := two_sinh_pos P
  positivity

/-- 人手証明 proof の第 1 式:
`log Λ^{(δ)}_M = (M/2) log(2 sinh 2K_2) + (1/2) Σ γ(θ)`。 -/
theorem log_LambdaM (P : IsingParam) (δ : ℝ) (M : ℕ) :
    Real.log (LambdaM P δ M)
      = (M : ℝ) / 2 * Real.log (2 * Real.sinh (2 * P.K2))
        + 1 / 2 * ∑ μ ∈ Finset.Icc 1 M, gammaFn P (tagPoint δ M μ) :=
  NecSuf.log_rpow_mul_exp (two_sinh_pos P) _ _

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
  -- 第 2 項は riemann_sum_to_integral（実数解析への移行点）から
  have hsum := riemann_sum_to_integral (gamma_is_continuous P) hδ0 hδ1
  -- 収束列のアフィン変換（必要十分版 tendsto_affine）
  have haff := NecSuf.tendsto_affine
    (1 / 2 * Real.log (2 * Real.sinh (2 * P.K2))) (1 / 2) hsum
  have hval : 1 / 2 * Real.log (2 * Real.sinh (2 * P.K2))
      + 1 / 2 * (1 / (2 * Real.pi) * ∫ θ in (0:ℝ)..(2 * Real.pi), gammaFn P θ)
      = 1 / 2 * Real.log (2 * Real.sinh (2 * P.K2))
        + 1 / (4 * Real.pi) * ∫ θ in (0:ℝ)..(2 * Real.pi), gammaFn P θ := by
    field_simp
    ring
  rw [← hval]
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
