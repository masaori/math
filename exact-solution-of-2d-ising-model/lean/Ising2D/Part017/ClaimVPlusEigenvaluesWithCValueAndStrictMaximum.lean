/-
# `V^{(+)} Q̌_ε = Λ̌_ε Q̌_ε` と `max_ε Λ̌_ε = Λ̌_{(1,…,1)} = Λ^{(1/2)}_M`

対応する人手証明（正本は `structured-latex/content/eigenvalue_problem_eigenvalues_of_V_plus.ts`）:

* `eigenvalues_of_V_plus_claim_c_value_eigenvalues_and_strict_maximum`
  （ラベル **`V_plus_eigenvalues_with_c_value_and_strict_maximum`**）

主張（`K_1, K_2 > 0`）:

1. `V^{(+)} = (2 sinh 2K_2)^{M/2} exp(Σ_{μ ∈ 𝓜̌} γ(θ~_μ)(ň_μ - ½ I))`
2. `V^{(+)} Q̌_ε = Λ̌_ε Q̌_ε`
3. `Λ^{(1/2)}_M = Λ̌_{(1,…,1)} = (2 sinh 2K_2)^{M/2} exp(½ Σ_μ γ(θ~_μ))`
4. `ε ≠ (1,…,1) ⇒ Λ̌_ε < Λ̌_{(1,…,1)}`

`ε ∈ {0,1}^{𝓜̌}` は `ε_μ = 1` となる `μ` の集合 `T : Finset (CheckIdx M)` で表す
（`(1,…,1)` は `Finset.univ`）。`Q̌_ε` は `CheckFermiSetup.Qproj`、`Λ̌_ε` は `checkBigLambda`、
`Λ^{(1/2)}_M` は `LambdaM P (1/2) M`。`CheckFermiSetup` は `checkFermiSetupOf P hM`
（`ψ̌_μ` から作ったもの）、`γ(θ~_μ)` は `gammaTilde P M μ`。(1) の和の添字づけは
`V_plus_eq_c_exp_sum_gamma_check_number_operator` と同じく `j : Fin M` の `checkIdx M j = j + 1`。

## 人手証明との対応

- (1) 4 行: `constant_c_value_even_sector`（`VPlus_eq_smul_checkVprime_const`。双対関係は定理
  `IsingParam.c2_mul_s2star_eq_c2star` で与える）、`def_check_Vprime` の `V̌' := exp(X̌)` と `X̌`
  （`checkVprime`・`checkX` の展開）、`def_check_number_operator`（`checkFermiOf_nOp`）
- (2): `eigenvalues_of_V_plus` (1)（`VPlus_mul_Qproj`）
- (3) 1・2 行: `max_eigenvalue_of_V_plus_simple` (1) と `eigenvalues_of_V_plus` (2)
  （`checkBigLambda_univ_eq_LambdaM`。Lean の `Λ̌_max` は `checkBigLambda … Finset.univ` そのものなので
  2 行目は定義どおり）。3〜5 行: `Λ̌_ε` の定義に `ε_μ = 1` を代入し、`1 - ½ = ½` と分配法則
- (4): `max_eigenvalue_of_V_plus_simple` (2)（`checkBigLambda_lt_max_of_gammaFn`）

人手の主張は既存の主張を並べて定義を代入するだけなので、必要十分版は置かない
（各行の必要十分版は `Ising2D.NecSuf.const_eq_of_trace_ratio`・`Ising2D.NecSuf.sum_weight_lt_of_ne_univ`
が持つ）。
-/
import Ising2D.Part018.Claim012_VPlusDataFromPart017

namespace Ising2D

variable {M : ℕ}

/-- **人手 `V_plus_eigenvalues_with_c_value_and_strict_maximum`**。 -/
theorem V_plus_eigenvalues_with_c_value_and_strict_maximum (P : IsingParam) (hM : M ≠ 0) :
    VPlus M (Real.sinh (2 * P.K2)) (P.K1 : ℂ) (P.K2star : ℂ)
        = ((((2 * Real.sinh (2 * P.K2)) ^ ((M : ℝ) / 2) : ℝ) : ℂ))
          • matExp (∑ j : Fin M, gammaTildeC P M (checkIdx M j) •
              ((checkFermiOf P hM).nOp j - (1 / 2 : ℂ) • (1 : TensorPow M)))
      ∧ (∀ T : Finset (CheckIdx M),
          VPlus M (Real.sinh (2 * P.K2)) (P.K1 : ℂ) (P.K2star : ℂ)
              * (checkFermiSetupOf P hM).Qproj T
            = ((checkBigLambda (checkFermiSetupOf P hM) (fun i => gammaTilde P M i.1)
                (Real.sinh (2 * P.K2)) T : ℝ) : ℂ) • (checkFermiSetupOf P hM).Qproj T)
      ∧ LambdaM P (1 / 2) M
          = checkBigLambda (checkFermiSetupOf P hM) (fun i => gammaTilde P M i.1)
              (Real.sinh (2 * P.K2)) Finset.univ
      ∧ checkBigLambda (checkFermiSetupOf P hM) (fun i => gammaTilde P M i.1)
            (Real.sinh (2 * P.K2)) Finset.univ
          = (2 * Real.sinh (2 * P.K2)) ^ ((M : ℝ) / 2)
            * Real.exp (1 / 2 * ∑ i : CheckIdx M, gammaTilde P M i.1)
      ∧ (∀ T : Finset (CheckIdx M), T ≠ Finset.univ →
          checkBigLambda (checkFermiSetupOf P hM) (fun i => gammaTilde P M i.1)
              (Real.sinh (2 * P.K2)) T
            < checkBigLambda (checkFermiSetupOf P hM) (fun i => gammaTilde P M i.1)
              (Real.sinh (2 * P.K2)) Finset.univ) := by
  set F := checkFermiSetupOf P hM with hF
  set g : CheckIdx M → ℝ := fun i => gammaTilde P M i.1 with hg
  have hc := VPlus_eq_smul_checkVprime_const P hM P.c2_mul_s2star_eq_c2star
  -- (2) で使う `V^{(+)} = c V̌'`（章 017 の `CheckFermiSetup.Vprime` の形）
  have hVeq : VPlus M (Real.sinh (2 * P.K2)) (P.K1 : ℂ) (P.K2star : ℂ)
      = ((((2 * Real.sinh (2 * P.K2)) ^ ((M : ℝ) / 2) : ℝ) : ℂ)) • F.Vprime g := by
    rw [hc, hF, hg, checkFermiSetupOf_Vprime]
  refine ⟨?_, ?_, ?_, ?_, ?_⟩
  · -- (1)
    rw [hc, checkVprime, checkX]  -- 人手の 1 行目（定数 c の決定）・2 行目・3 行目
    simp only [checkFermiOf_nOp]  -- 人手の 4 行目
  · -- (2)
    intro T
    exact VPlus_mul_Qproj F g (star_ofReal_self P.K1) (star_ofReal_self P.K2star)
      (sinh_two_K2_pos P) hVeq T
  · -- (3) 1・2 行目
    exact (checkBigLambda_univ_eq_LambdaM F P g (fun _ => rfl)).symm
  · -- (3) 3〜5 行目
    have hgval : F.gval g Finset.univ = 1 / 2 * ∑ i : CheckIdx M, g i := by
      rw [CheckFermiSetup.gval, Finset.mul_sum]
      refine Finset.sum_congr rfl fun i _ => ?_
      simp only [Finset.mem_univ, if_true]
      ring
    rw [checkBigLambda, hgval]
  · -- (4)
    intro T hT
    exact checkBigLambda_lt_max_of_gammaFn F P g (fun _ => rfl) hT

end Ising2D
