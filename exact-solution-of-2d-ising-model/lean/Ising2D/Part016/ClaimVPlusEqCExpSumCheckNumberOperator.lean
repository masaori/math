/-
# `V^{(+)} = c exp(Σ_{μ ∈ 𝓜̌} γ(θ~_μ)(ň_μ - ½ I))`

対応する人手証明（正本は `structured-latex/content/eigenvalue_problem_diagonalization_and_exponential_form.ts`）:

* `diagonalization_and_exponential_form_claim_V_plus_eq_c_exp_check_number_operators`
  （ラベル **`V_plus_eq_c_exp_sum_gamma_check_number_operator`**）

主張: ある `c ∈ ℂ^×` について `V^{(+)} = c exp(Σ_{μ ∈ 𝓜̌} γ(θ~_μ)(ň_μ - ½ I))`。

`ň_μ` は `Ising2D.checkFermiOf` の `nOp`（`ψ̌_μ^† ψ̌_{M+1-μ}`、`Ising2D.checkFermiOf_nOp`）、
`γ(θ~_μ)` は `Ising2D.gammaTildeC`、和の添字 `μ ∈ 𝓜̌` は `j : Fin M` の `checkIdx M j = j + 1` で走る
（`Ising2D.checkX` と同じ添字づけ）。

## 人手証明との対応

人手の証明は式変形 4 行で、各行が次の定理・定義の適用に当たる。

1. `V^{(+)} = c V̌'`: `V_plus_eq_c_check_Vprime`（`VPlus_eq_smul_checkVprime_of_dual`。
   双対関係は定理 `IsingParam.c2_mul_s2star_eq_c2star` で与える）
2. `V̌' = exp(X̌)`: `def_check_Vprime`（`checkVprime` の展開）
3. `X̌ = Σ γ(θ~_μ)(ψ̌_μ^† ψ̌_{M+1-μ} - ½ I)`: `def_check_Vprime`（`checkX` の展開）
4. `ψ̌_μ^† ψ̌_{M+1-μ} = ň_μ`: `def_check_number_operator`（`checkFermiOf_nOp`）

人手の主張は既存の主張に定義を代入するだけなので、必要十分版は置かない（1 行目の必要十分版は
`Ising2D.exists_smul_of_TConj_eq` が持つ）。
-/
import Ising2D.Part018.Claim011_CheckFermiFromPart016

namespace Ising2D

variable {M : ℕ}

/-- **人手 `V_plus_eq_c_exp_sum_gamma_check_number_operator`**。 -/
theorem V_plus_eq_c_exp_sum_gamma_check_number_operator (P : IsingParam) (hM : M ≠ 0) :
    ∃ c : ℂ, c ≠ 0 ∧
      VPlus M (Real.sinh (2 * P.K2)) (P.K1 : ℂ) (P.K2star : ℂ)
        = c • matExp (∑ j : Fin M, gammaTildeC P M (checkIdx M j) •
            ((checkFermiOf P hM).nOp j - (1 / 2 : ℂ) • (1 : TensorPow M))) := by
  obtain ⟨c, hc, h⟩ :=
    VPlus_eq_smul_checkVprime_of_dual P hM P.c2_mul_s2star_eq_c2star  -- 人手の 1 行目
  refine ⟨c, hc, ?_⟩
  rw [h, checkVprime, checkX]  -- 人手の 2 行目・3 行目
  simp only [checkFermiOf_nOp]  -- 人手の 4 行目

end Ising2D
