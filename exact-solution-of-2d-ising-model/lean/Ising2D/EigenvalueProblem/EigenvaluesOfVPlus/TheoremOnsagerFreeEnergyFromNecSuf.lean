/-
# Onsager の自由エネルギーの表式（具体版を必要十分版から導く）

具体版 `TheoremOnsagerFreeEnergy.lean` の `log_LambdaM`（人手 `onsager_free_energy_expression` の証明の第 1 式）を、
必要十分版 `Ising2D/NecSuf/LogSqueeze.lean` の `NecSuf.log_rpow_mul_exp` を `A := 2 sinh 2K_2`、`r := M/2`、
`S := (1/2) Σ γ(θ^{(δ)}_{M,μ})` に特殊化して得る。同じ証明の極限の鎖の第 2・3 行（定数倍と定数の和の極限）は、
`NecSuf.tendsto_affine` を `α := (1/2) log(2 sinh 2K_2)`、`β := 1/2`、`u := (1/M) Σ γ(θ^{(δ)}_{M,μ})` に特殊化して得る
（`onsager_free_energy_affine_limit_of_necSuf`。型は具体版の証明の途中の極限）。それに第 5 行の四則と第 1 行の代入を続けて、
具体版 `onsager_free_energy_expression` と同じ型の `onsager_free_energy_expression_of_necSuf` を得る。
`log_LambdaM_of_necSuf` の型は具体版 `log_LambdaM` と同じである。
-/
import Ising2D.EigenvalueProblem.EigenvaluesOfVPlus.TheoremOnsagerFreeEnergy
import Ising2D.NecSuf.LogSqueeze

namespace Ising2D

open Filter
open scoped Topology

/-- `log_LambdaM` を `NecSuf.log_rpow_mul_exp` の特殊化として得る。 -/
theorem log_LambdaM_of_necSuf (P : IsingParam) (δ : ℝ) (M : ℕ) :
    Real.log (LambdaM P δ M)
      = (M : ℝ) / 2 * Real.log (2 * Real.sinh (2 * P.K2))
        + 1 / 2 * ∑ μ ∈ Finset.Icc 1 M, gammaFn P (tagPoint δ M μ) :=
  NecSuf.log_rpow_mul_exp (two_sinh_pos P) _ _

/-- `onsager_free_energy_expression` の極限の鎖の第 2・3 行を `NecSuf.tendsto_affine` の特殊化として得る。 -/
theorem onsager_free_energy_affine_limit_of_necSuf (P : IsingParam) {δ : ℝ} (hδ0 : 0 ≤ δ) (hδ1 : δ < 1) :
    Tendsto (fun M : ℕ => 1 / 2 * Real.log (2 * Real.sinh (2 * P.K2))
        + 1 / 2 * (1 / (M : ℝ) * ∑ μ ∈ Finset.Icc 1 M, gammaFn P (tagPoint δ M μ))) atTop
      (𝓝 (1 / 2 * Real.log (2 * Real.sinh (2 * P.K2))
        + 1 / 2 * (1 / (2 * Real.pi) * ∫ θ in (0:ℝ)..(2 * Real.pi), gammaFn P θ))) :=
  NecSuf.tendsto_affine _ _ (riemann_sum_to_integral (gamma_is_continuous P) hδ0 hδ1.le)

/-- `onsager_free_energy_expression`（具体版と同じ型）を、`NecSuf.tendsto_affine` の特殊化
`onsager_free_energy_affine_limit_of_necSuf` に、極限の鎖の第 5 行（ℝ の四則）と第 1 行（`inv_M_log_LambdaM` の代入）を続けて得る。 -/
theorem onsager_free_energy_expression_of_necSuf (P : IsingParam) {δ : ℝ} (hδ0 : 0 ≤ δ) (hδ1 : δ < 1) :
    Tendsto (fun M : ℕ => 1 / (M : ℝ) * Real.log (LambdaM P δ M)) atTop
      (𝓝 (1 / 2 * Real.log (2 * Real.sinh (2 * P.K2))
        + 1 / (4 * Real.pi) * ∫ θ in (0:ℝ)..(2 * Real.pi), gammaFn P θ)) := by
  have hpi : (0 : ℝ) < Real.pi := Real.pi_pos
  have haff := onsager_free_energy_affine_limit_of_necSuf P hδ0 hδ1
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

end Ising2D
