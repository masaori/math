/-
# 共役添字の `P̌_{M+1-μ}`（**具体版**）

対応する人手証明のラベル: `periodicity_of_check_fermi` (3) の `P̌_{M_col+1-μ}` の式
（`structured-latex/content/eigenvalue_problem_diagonalization_and_exponential_form.ts` の
`evenfermi_002_claim_periodicity`）

## 人手証明との対応

人手の証明の最後の段落と 1 対 1 に対応させる。`ν := M_col + 1 - μ` と書く。

* 分母が `ℂ^×` に属すること: `u := 2_ℂ (√M_col)_ℂ` と `d_ν := u γ_2(-θ̃_ν)` は
  `diagonalization_check_P_D` の Step 1 を `ν` で読んだもの（`checkU_ne_zero`・`checkD_ne_zero` を `ν` で）。
  主張の分母 `u γ_2(θ̃_μ)` が `d_ν` に等しいことは人手の 2 行の鎖 `d_ν = u γ_2(-θ̃_ν) = u γ_2(θ̃_μ)` で、
  1 行目は `d_ν` の定義（`checkD_ne_zero` の式そのもの）、2 行目は `γ_2(-θ̃_ν) = γ_2(θ̃_μ)`（`gamma2_neg_thetaTilde_conj`）の
  書き換え（`checkPmat_conj_denominator_ne_zero` の `rwa`）である。
* `P̌_ν` の 3 行の鎖（`checkPmat_conj`）:
  1. `diagonalization_check_P_D` を `ν` で（`checkPmat` の定義）。
  2. `γ_2(θ̃_ν) = γ_2(-θ̃_μ)`（`gamma2_thetaTilde_conj`）を `|·|` の中の 2 箇所へ同時に代入。
  3. `γ_2(-θ̃_ν) = γ_2(θ̃_μ)`（`gamma2_neg_thetaTilde_conj`）を分母の 2 箇所へ同時に代入。

Lean の `/` は分母が `0` でも値を返すので、鎖の等式そのものは分母の非零を使わない。
人手の主張の「分母が `ℂ^×` に属する」は `checkPmat_conj_denominator_ne_zero` として別に立てる。

**必要十分版**は置かない。鎖の 2 行目・3 行目は等しい元の代入だけで、
代入先の演算（`|·|`・積・商）のどの性質も使わないので、抽象度を上げて取り除ける構造が無い
（`lean/docs/ch016-formalization.md` の「2 本立ての対応表と「必要十分版で判明した本質」」）。
-/
import Ising2D.EigenvalueProblem.DiagonalizationAndExponentialForm.ClaimEigenATildeDiag

namespace Ising2D

open Matrix

/-- **人手 `periodicity_of_check_fermi` (3) の分母**: `u γ_2(θ̃_μ) ∈ ℂ^×`
（`ν := M_col + 1 - μ` について `diagonalization_check_P_D` Step 1 の `d_ν = u γ_2(-θ̃_ν) ∈ ℂ^×` と、
`γ_2(-θ̃_ν) = γ_2(θ̃_μ)` による同じ元であること）。 -/
theorem checkPmat_conj_denominator_ne_zero (P : IsingParam) {M : ℕ} (hM : M ≠ 0) (μ : ℤ) :
    (2 : ℂ) * sqrtM M * gamma2 P.const (thetaTilde M μ) ≠ 0 := by
  have hd : (2 : ℂ) * sqrtM M * gamma2 P.const (-thetaTilde M ((M : ℤ) + 1 - μ)) ≠ 0 :=
    checkD_ne_zero P hM ((M : ℤ) + 1 - μ)   -- `diagonalization_check_P_D` Step 1 を `ν` で
  rwa [gamma2_neg_thetaTilde_conj P.const hM μ] at hd
                                            -- `γ_2(-θ̃_ν) = γ_2(θ̃_μ)` より同じ元

/-- **人手 `periodicity_of_check_fermi` (3)**: `P̌_{M_col+1-μ}` は `P̌_μ` の式の
`γ_2(θ̃_μ)` と `γ_2(-θ̃_μ)` を入れ替えたもの（人手の 3 行の鎖）。 -/
theorem checkPmat_conj (K : IsingConst) {M : ℕ} (hM : M ≠ 0) (μ : ℤ) :
    checkPmat K M ((M : ℤ) + 1 - μ)
      = !![-((absGamma2 K (-thetaTilde M μ) : ℝ) : ℂ) /
              (2 * sqrtM M * gamma2 K (thetaTilde M μ)),
            ((absGamma2 K (-thetaTilde M μ) : ℝ) : ℂ) /
              (2 * sqrtM M * gamma2 K (thetaTilde M μ));
          1 / (2 * sqrtM M), 1 / (2 * sqrtM M)] := by
  have habs : absGamma2 K (thetaTilde M ((M : ℤ) + 1 - μ)) = absGamma2 K (-thetaTilde M μ) := by
    unfold absGamma2
    rw [gamma2_thetaTilde_conj K hM μ]
  calc checkPmat K M ((M : ℤ) + 1 - μ)
      = !![-((absGamma2 K (thetaTilde M ((M : ℤ) + 1 - μ)) : ℝ) : ℂ) /
              (2 * sqrtM M * gamma2 K (-thetaTilde M ((M : ℤ) + 1 - μ))),
            ((absGamma2 K (thetaTilde M ((M : ℤ) + 1 - μ)) : ℝ) : ℂ) /
              (2 * sqrtM M * gamma2 K (-thetaTilde M ((M : ℤ) + 1 - μ)));
          1 / (2 * sqrtM M), 1 / (2 * sqrtM M)] := rfl
                                            -- 1 行目: `diagonalization_check_P_D` を `ν` で
    _ = !![-((absGamma2 K (-thetaTilde M μ) : ℝ) : ℂ) /
              (2 * sqrtM M * gamma2 K (-thetaTilde M ((M : ℤ) + 1 - μ))),
            ((absGamma2 K (-thetaTilde M μ) : ℝ) : ℂ) /
              (2 * sqrtM M * gamma2 K (-thetaTilde M ((M : ℤ) + 1 - μ)));
          1 / (2 * sqrtM M), 1 / (2 * sqrtM M)] := by
        rw [habs]                           -- 2 行目: `γ_2(θ̃_ν) = γ_2(-θ̃_μ)` を 2 箇所へ同時代入
    _ = !![-((absGamma2 K (-thetaTilde M μ) : ℝ) : ℂ) /
              (2 * sqrtM M * gamma2 K (thetaTilde M μ)),
            ((absGamma2 K (-thetaTilde M μ) : ℝ) : ℂ) /
              (2 * sqrtM M * gamma2 K (thetaTilde M μ));
          1 / (2 * sqrtM M), 1 / (2 * sqrtM M)] := by
        rw [gamma2_neg_thetaTilde_conj K hM μ]
                                            -- 3 行目: `γ_2(-θ̃_ν) = γ_2(θ̃_μ)` を 2 箇所へ同時代入

end Ising2D
