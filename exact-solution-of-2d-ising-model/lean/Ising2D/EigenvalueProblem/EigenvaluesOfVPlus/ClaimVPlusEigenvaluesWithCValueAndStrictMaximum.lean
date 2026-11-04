/-
# `V^{(+)} Q̌_ε = Λ̌_ε Q̌_ε` と `max_ε Λ̌_ε = Λ̌_{(1,…,1)} = Λ^{(1/2)}_M`

対応する人手証明（正本は `structured-latex/content/eigenvalue_problem_eigenvalues_of_V_plus.ts`）:

* `eigenvalues_of_V_plus_claim_c_value_eigenvalues_and_strict_maximum`
  （ラベル **`V_plus_eigenvalues_with_c_value_and_strict_maximum`**）

主張（`K_1, K_2 > 0`）:

1. `V^{(+)} = (2 sinh 2K_2)^{M/2} exp(Σ_{μ ∈ 𝓜̌} γ(θ~_μ)(ň_μ - ½ I))`
2. `V^{(+)} Q̌_ε = Λ̌_ε Q̌_ε`
3. `Λ^{(1/2)}_M = Λ̌_{(1,…,1)} = (2 sinh 2K_2)^{M/2} exp(½ Σ_μ γ(θ~_μ))`
4. `ε ≠ (1,…,1) ⇒ Λ̌_ε < Λ̌_{(1,…,1)}`。とくに `Λ̌_{(1,…,1)}` は族 `(Λ̌_ε)_ε` の最大値で、`max_ε Λ̌_ε = Λ̌_{(1,…,1)}`

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
- (3) 前の鎖 2 行: `max_eigenvalue_of_V_plus_simple` (1) を右辺から左辺へ（`checkBigLambda_univ_eq_LambdaM`）、
  `eigenvalues_of_V_plus` (2) の `Λ̌_max := Λ̌_{(1,…,1)}`（Lean の `Λ̌_max` は `checkBigLambda … Finset.univ`
  そのものなので `rfl`）。後の鎖 2 行: 同じ置き方を右辺から左辺へ（`rfl`）、`eigenvalues_of_V_plus` (2) の
  `Λ̌_max` の値（`checkBigLambda_max_eq`。人手の `Σ_{μ=1}^{M_col}` は `Fin M` の上の和で、`μ = j + 1` は `checkIdxOfFin`）
- (4) 前半の鎖 2 行: `max_eigenvalue_of_V_plus_simple` (2)（`checkBigLambda_lt_max_of_gammaFn`）、
  `Λ̌_max := Λ̌_{(1,…,1)}`（Lean では同じ項）。Lean の (4) は前半を第 5 の連言、後半を第 6 の連言に置く。
- (4) 後半: `def_maximum_value_of_real_family` の (1)（`ε = (1,…,1)`、Lean の `Finset.univ` で `rfl`）と (2)
  （`ε = (1,…,1)` なら等号から `le_of_eq`、`ε ≠ (1,…,1)` なら前半の鎖から `le_of_lt`）で
  `IsMaxValueOfRealFamily`、続けて `def_max_of_real_family`（`maxOfRealFamily_eq`）で `max_ε Λ̌_ε = Λ̌_{(1,…,1)}`。
  族の添字 `ε ∈ {0,1}^{𝓜̌}` は Lean の `T : Finset (CheckIdx M)` である（上の表し方）。

人手の主張の (1)〜(3) と (4) の前半は既存の主張を並べて定義を代入するだけなので、必要十分版は置かない
（各行の必要十分版は `Ising2D.NecSuf.const_eq_of_trace_chains`・`Ising2D.NecSuf.sum_weight_lt_of_ne_univ`
が持つ）。(4) の後半の場合分け（`ε = (1,…,1)` は等号、他は `<` から `≤`）はこの定理で新しく書いた段で、
既存の必要十分版は受け持たない。この場合分けは既存の主張を寄せ集めたこの主張の中の 1 段なので、
主張全体に必要十分版を置かない方針に従い、この段にも置かない。一意性の段の必要十分版は `Ising2D.NecSuf.maximum_value_of_family_is_unique'`。
-/
import Ising2D.EigenvalueProblem.EigenvaluesOfVPlus.ClaimVPlusDataFromEigenvaluesOfVPlus
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.DefinitionMaximumValueOfRealFamily

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
            * Real.exp (1 / 2 * ∑ j : Fin M, gammaTilde P M (CheckFermiSetup.checkIdxOfFin j).1)
      ∧ (∀ T : Finset (CheckIdx M), T ≠ Finset.univ →
          checkBigLambda (checkFermiSetupOf P hM) (fun i => gammaTilde P M i.1)
              (Real.sinh (2 * P.K2)) T
            < checkBigLambda (checkFermiSetupOf P hM) (fun i => gammaTilde P M i.1)
              (Real.sinh (2 * P.K2)) Finset.univ)
      ∧ (IsMaxValueOfRealFamily
            (fun T : Finset (CheckIdx M) => checkBigLambda (checkFermiSetupOf P hM)
              (fun i => gammaTilde P M i.1) (Real.sinh (2 * P.K2)) T)
            (checkBigLambda (checkFermiSetupOf P hM) (fun i => gammaTilde P M i.1)
              (Real.sinh (2 * P.K2)) Finset.univ)
          ∧ ∀ h : ∃ m, IsMaxValueOfRealFamily
              (fun T : Finset (CheckIdx M) => checkBigLambda (checkFermiSetupOf P hM)
                (fun i => gammaTilde P M i.1) (Real.sinh (2 * P.K2)) T) m,
            maxOfRealFamily
                (fun T : Finset (CheckIdx M) => checkBigLambda (checkFermiSetupOf P hM)
                  (fun i => gammaTilde P M i.1) (Real.sinh (2 * P.K2)) T) h
              = checkBigLambda (checkFermiSetupOf P hM) (fun i => gammaTilde P M i.1)
                  (Real.sinh (2 * P.K2)) Finset.univ) := by
  set F := checkFermiSetupOf P hM with hF
  set g : CheckIdx M → ℝ := fun i => gammaTilde P M i.1 with hg
  have hc := VPlus_eq_smul_checkVprime_const P hM P.c2_mul_s2star_eq_c2star
  -- (2) で使う `V^{(+)} = c V̌'`（章 017 の `CheckFermiSetup.Vprime` の形）
  have hVeq : VPlus M (Real.sinh (2 * P.K2)) (P.K1 : ℂ) (P.K2star : ℂ)
      = ((((2 * Real.sinh (2 * P.K2)) ^ ((M : ℝ) / 2) : ℝ) : ℂ)) • F.Vprime g := by
    rw [hc, hF, hg, checkFermiSetupOf_Vprime]
  -- (4) 前半の鎖: `Λ̌_ε < Λ̌_max = Λ̌_{(1,…,1)}`
  have hlt : ∀ T : Finset (CheckIdx M), T ≠ Finset.univ →
      checkBigLambda F g (Real.sinh (2 * P.K2)) T
        < checkBigLambda F g (Real.sinh (2 * P.K2)) Finset.univ := by
    intro T hT
    calc checkBigLambda F g (Real.sinh (2 * P.K2)) T
        < checkBigLambda F g (Real.sinh (2 * P.K2)) Finset.univ :=
          checkBigLambda_lt_max_of_gammaFn F P g (fun _ => rfl) hT
                                                        -- `max_eigenvalue_of_V_plus_simple` (2)
      _ = checkBigLambda F g (Real.sinh (2 * P.K2)) Finset.univ := rfl
                                                        -- `eigenvalues_of_V_plus` (2) の `Λ̌_max := Λ̌_{(1,…,1)}`
  -- (4) 後半: `Λ̌_{(1,…,1)}` は族 `(Λ̌_ε)_ε` の最大値（`def_maximum_value_of_real_family` の (1)(2)）
  have hmax : IsMaxValueOfRealFamily
      (fun T : Finset (CheckIdx M) => checkBigLambda F g (Real.sinh (2 * P.K2)) T)
      (checkBigLambda F g (Real.sinh (2 * P.K2)) Finset.univ) := by
    refine ⟨⟨Finset.univ, rfl⟩, ?_⟩                -- (1): `ε = (1,…,1)` について `Λ̌_{(1,…,1)} = Λ̌_{(1,…,1)}`
    intro T                                         -- (2): `ε` を取る
    by_cases hT : T = Finset.univ
    · -- `ε = (1,…,1)` のとき `Λ̌_ε = Λ̌_{(1,…,1)}` なので `≤`
      have heq : checkBigLambda F g (Real.sinh (2 * P.K2)) T
          = checkBigLambda F g (Real.sinh (2 * P.K2)) Finset.univ := by rw [hT]
      exact le_of_eq heq
    · -- `ε ≠ (1,…,1)` のとき前半の鎖で `<` なので `≤`
      exact le_of_lt (hlt T hT)
  refine ⟨?_, ?_, ?_, ?_, ?_, ?_⟩
  · -- (1)
    rw [hc, checkVprime, checkX]  -- 人手の 1 行目（定数 c の決定）・2 行目・3 行目
    simp only [checkFermiOf_nOp]  -- 人手の 4 行目
  · -- (2)
    intro T
    exact VPlus_mul_Qproj F g (star_ofReal_self P.K1) (star_ofReal_self P.K2star)
      (sinh_two_K2_pos P) hVeq T
  · -- (3) 前の鎖
    calc LambdaM P (1 / 2) M
        = checkBigLambda F g (Real.sinh (2 * P.K2)) Finset.univ :=
          (checkBigLambda_univ_eq_LambdaM F P g (fun _ => rfl)).symm
                                                        -- `max_eigenvalue_of_V_plus_simple` (1) を右辺から左辺へ
      _ = checkBigLambda F g (Real.sinh (2 * P.K2)) Finset.univ := rfl
                                                        -- `eigenvalues_of_V_plus` (2) の `Λ̌_max := Λ̌_{(1,…,1)}`
  · -- (3) 後の鎖
    calc checkBigLambda F g (Real.sinh (2 * P.K2)) Finset.univ
        = checkBigLambda F g (Real.sinh (2 * P.K2)) Finset.univ := rfl
                                                        -- `Λ̌_max := Λ̌_{(1,…,1)}` を右辺から左辺へ
      _ = (2 * Real.sinh (2 * P.K2)) ^ ((M : ℝ) / 2)
            * Real.exp (1 / 2 * ∑ j : Fin M, g (CheckFermiSetup.checkIdxOfFin j)) :=
          checkBigLambda_max_eq F g _
                                                        -- `eigenvalues_of_V_plus` (2) の `Λ̌_max` の値
  · -- (4) 前半
    exact hlt
  · -- (4) 後半: 最大値であることと、`def_max_of_real_family` の記号で `max_ε Λ̌_ε = Λ̌_{(1,…,1)}`
    exact ⟨hmax, fun h => maxOfRealFamily_eq _ h hmax⟩

end Ising2D
