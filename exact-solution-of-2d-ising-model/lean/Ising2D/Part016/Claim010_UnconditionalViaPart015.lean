/-
# 015 章の成果を入れて本章の仮定を落とす（`γ_2 ≠ 0`・`λ_± = e^{±γ}`・重み `γ(θ̃_μ)`）

対応する人手証明のラベル（本ファイルは新しい主張を立てず、既出の主張から
015 章由来の仮定を除去するだけ）:
`def_check_fermi`, `anticommutator_of_check_psi`, `commutation_V_plus_check_psi`,
`action_of_T_check_Vprime_on_check_psi`, `T_V_plus_eq_T_check_Vprime_on_check_Z_Y`,
`T_V_plus_eq_T_check_Vprime`, `V_plus_eq_c_check_Vprime`

## 経緯

本章（016）の形式化を進めている間に、並行セッションの 015 章
（`Ising2D/Part015/`）が `origin/main` に入った。そこで用意された

* `Ising2D.gamma2_thetaTilde_ne_zero_checkIndex`（`γ_2(θ̃_μ) ≠ 0`、無条件）
* `Ising2D.gammaTilde` と `Ising2D.lambdaPlusR_eq_exp` / `lambdaMinusR_eq_exp`
  （`λ_{±,μ} = e^{±γ(θ̃_μ)}`）
* `Ising2D.checkPmat`（原文の `P̌_μ`）

を使って、016 章の各定理から 015 章由来の仮定をすべて落とす。
**残るのは 014 章の `T_V_plus_check_Z_Y`（`hT`）だけ**である。

## `def_check_fermi` と `P̌_μ` の突き合わせ

`Ising2D/Part016/Definition001_CheckFermi.lean` は、015 章の完成を待たずに閉じるため
原文が「すなわち」として与える明示式を `ψ̌^†, ψ̌` の定義に採った。
本ファイルの `checkPsiDag_eq_checkPmat_col` / `checkPsi_eq_checkPmat_col` が、
**その定義が原文の行ベクトル記法 `(ψ̌_μ^†, ψ̌_μ) = (Ž_μ, Y̌_μ) P̌_μ` と一致すること**を示す。
-/
import Ising2D.Part016.Claim009_VPlusEqCCheckVprime
import Ising2D.Part015.Definition008_GammaTildeMu

namespace Ising2D

variable {M : ℕ}

/-! ## `r_μ` は 015 章の `|γ_2(θ̃_μ)|` そのもの -/

theorem checkR_eq_absGamma2 (K : IsingConst) (M : ℕ) (μ : ℤ) :
    checkR K M μ = absGamma2 K (thetaTilde M μ) := rfl

/-! ## 原文の行ベクトル記法 `(ψ̌_μ^†, ψ̌_μ) = (Ž_μ, Y̌_μ) P̌_μ` との一致 -/

/-- **原文 `def_check_fermi` の行ベクトル記法との一致**（`P̌_μ` の第 0 列が `ψ̌_μ^†`）。 -/
theorem checkPsiDag_eq_checkPmat_col (K : IsingConst) (M : ℕ) (μ : ℤ) :
    checkPsiDag K M μ
      = checkPmat K M μ 0 0 • checkZ M μ + checkPmat K M μ 1 0 • checkY M μ := by
  simp [checkPsiDag, checkP, checkQ, checkPmat, sqrtM, checkR_eq_absGamma2]

/-- **原文 `def_check_fermi` の行ベクトル記法との一致**（`P̌_μ` の第 1 列が `ψ̌_μ`）。 -/
theorem checkPsi_eq_checkPmat_col (K : IsingConst) (M : ℕ) (μ : ℤ) :
    checkPsi K M μ
      = checkPmat K M μ 0 1 • checkZ M μ + checkPmat K M μ 1 1 • checkY M μ := by
  simp [checkPsi, checkP, checkQ, checkPmat, sqrtM, checkR_eq_absGamma2, neg_div]

/-! ## 重み `γ(θ̃_μ)`（015 章 `def_gamma_theta_tilde_mu`）を `ℤ → ℂ` の形で -/

variable (P : IsingParam)

/-- 原文 `def_check_Vprime` の重み `γ(θ̃_μ)` を `Ising2D.checkX` へ渡す形にしたもの。 -/
noncomputable def gammaTildeC (P : IsingParam) (M : ℕ) : ℤ → ℂ :=
  fun μ => ((gammaTilde P M μ : ℝ) : ℂ)

/-- `γ_1` の共役添字不変性（実数版）。 -/
theorem gamma1R_thetaTilde_conj (K : IsingConst) (hM : M ≠ 0) (μ : ℤ) :
    gamma1R K (thetaTilde M ((M : ℤ) + 1 - μ)) = gamma1R K (thetaTilde M μ) := by
  have h := gamma1_thetaTilde_conj K hM μ
  rw [gamma1_eq_ofReal, gamma1_eq_ofReal] at h
  exact_mod_cast h

/-- **原文 `periodicity_of_check_fermi` (3) の `γ` 版**: `γ(θ̃_{M+1-μ}) = γ(θ̃_μ)`。

`γ = arcosh ∘ γ_1` は `γ_1` の値だけで決まるので、`γ_1` の共役添字不変性から従う。 -/
theorem gammaTilde_conj (hM : M ≠ 0) (μ : ℤ) :
    gammaTilde P M ((M : ℤ) + 1 - μ) = gammaTilde P M μ := by
  rw [gammaTilde, gammaTilde, gammaFn, gammaFn, gamma1R_thetaTilde_conj P.const hM]

theorem gammaTildeC_conj (hM : M ≠ 0) (μ : ℤ) :
    gammaTildeC P M ((M : ℤ) + 1 - μ) = gammaTildeC P M μ := by
  show ((gammaTilde P M ((M : ℤ) + 1 - μ) : ℝ) : ℂ) = ((gammaTilde P M μ : ℝ) : ℂ)
  rw [gammaTilde_conj P hM]

/-! ## 015 章由来の仮定の解消 -/

/-- 015 章 `gamma_2_theta_tilde_nonzero`: 本章の仮定 `hga` は無条件に成り立つ。 -/
theorem gamma2_thetaTilde_ne_zero_of_checkIndex (hM : M ≠ 0) :
    ∀ μ : ℤ, CheckIndex M μ → gamma2 P.const (thetaTilde M μ) ≠ 0 :=
  fun _ hμ => gamma2_thetaTilde_ne_zero_checkIndex P hM hμ

/-- 015 章 `lambda_eq_exp_gamma_theta_tilde`: 本章の仮定 `hlamPlus` は無条件に成り立つ。 -/
theorem gamma1_add_checkR_eq_exp
    (hdual : P.const.c2 * P.const.s2star = P.const.c2star) (M : ℕ) (μ : ℤ) :
    gamma1 P.const (thetaTilde M μ) + ((checkR P.const M μ : ℝ) : ℂ)
      = Complex.exp (gammaTildeC P M μ) := by
  have h : lambdaPlusR P.const (thetaTilde M μ) = Real.exp (gammaTilde P M μ) :=
    lambdaPlusR_eq_exp P hdual M μ
  have hc := congrArg (fun r : ℝ => ((r : ℝ) : ℂ)) h
  simpa [lambdaPlusR_ofReal, gammaTildeC, Complex.ofReal_exp, checkR_eq_absGamma2]
    using hc

/-- 015 章 `lambda_eq_exp_gamma_theta_tilde`: 本章の仮定 `hlamMinus` は無条件に成り立つ。 -/
theorem gamma1_sub_checkR_eq_exp
    (hdual : P.const.c2 * P.const.s2star = P.const.c2star) (M : ℕ) (μ : ℤ) :
    gamma1 P.const (thetaTilde M μ) - ((checkR P.const M μ : ℝ) : ℂ)
      = Complex.exp (-gammaTildeC P M μ) := by
  have h : lambdaMinusR P.const (thetaTilde M μ) = Real.exp (-gammaTilde P M μ) :=
    lambdaMinusR_eq_exp P hdual M μ
  have hc := congrArg (fun r : ℝ => ((r : ℝ) : ℂ)) h
  simpa [lambdaMinusR_ofReal, gammaTildeC, Complex.ofReal_exp, checkR_eq_absGamma2]
    using hc

/-! ## 015 章の仮定を落とした版の主張 -/

/-- **`anticommutator_of_check_psi`（015 章の仮定なし）**。 -/
theorem checkPsi_car' (hM : M ≠ 0) {μ ν : ℤ}
    (hμ : CheckIndex M μ) (hν : CheckIndex M ν) :
    acomm (checkPsiDag P.const M μ) (checkPsiDag P.const M ν) = 0
      ∧ acomm (checkPsiDag P.const M μ) (checkPsi P.const M ν)
          = (if ν = (M : ℤ) + 1 - μ then (1 : ℂ) else 0) • (1 : TensorPow M)
      ∧ acomm (checkPsi P.const M μ) (checkPsi P.const M ν) = 0 :=
  checkPsi_car P.const hM hμ hν (gamma2_thetaTilde_ne_zero_checkIndex P hM hμ)

/-- **`action_of_T_check_Vprime_on_check_psi`（015 章の仮定なし）**。 -/
theorem TCheckVprime_checkPsi_pair (hM : M ≠ 0) (j : Fin M) :
    TConj (checkVprimeUnits P.const M (gammaTildeC P M)) (checkPsiDag P.const M (checkIdx M j))
        = Complex.exp (gammaTildeC P M (checkIdx M j))
          • checkPsiDag P.const M (checkIdx M j)
      ∧ TConj (checkVprimeUnits P.const M (gammaTildeC P M)) (checkPsi P.const M (checkIdx M j))
        = Complex.exp (-gammaTildeC P M (checkIdx M j)) • checkPsi P.const M (checkIdx M j) :=
  ⟨TCheckVprime_checkPsiDag P.const (gammaTildeC P M) hM
      (gamma2_thetaTilde_ne_zero_of_checkIndex P hM) j,
   TCheckVprime_checkPsi P.const (gammaTildeC P M) hM
      (gamma2_thetaTilde_ne_zero_of_checkIndex P hM) (fun μ _ => gammaTildeC_conj P hM μ) j⟩

/-- **`T_V_plus_eq_T_check_Vprime`（015 章の仮定なし。残るのは 014 章の `hT` だけ）**。 -/
theorem TVPlus_eq_TCheckVprime' (hM : M ≠ 0)
    (hdual : P.const.c2 * P.const.s2star = P.const.c2star)
    (uPlus : (TensorPow M)ˣ)
    (hT : ∀ j : Fin M, ActsBy (TConj uPlus).toLinearMap
      (checkZ M (checkIdx M j)) (checkY M (checkIdx M j))
      (AMat P.const (thetaTilde M (checkIdx M j)))) :
    ∀ x : TensorPow M,
      TConj uPlus x = TConj (checkVprimeUnits P.const M (gammaTildeC P M)) x :=
  TVPlus_eq_TCheckVprime P.const (gammaTildeC P M) hM
    (gamma2_thetaTilde_ne_zero_of_checkIndex P hM)
    (fun μ _ => gammaTildeC_conj P hM μ) uPlus hT
    (fun j => gamma1_add_checkR_eq_exp P hdual M (checkIdx M j))
    (fun j => gamma1_sub_checkR_eq_exp P hdual M (checkIdx M j))

/-- **`V_plus_eq_c_check_Vprime`（015 章の仮定なし。残るのは 014 章の `hT` だけ）**。

本章の結論そのもの: ある `c ∈ ℂ^×` について `V^{(+)} = c V̌'`。 -/
theorem VPlus_eq_smul_checkVprime' (hM : M ≠ 0)
    (hdual : P.const.c2 * P.const.s2star = P.const.c2star)
    (uPlus : (TensorPow M)ˣ)
    (hT : ∀ j : Fin M, ActsBy (TConj uPlus).toLinearMap
      (checkZ M (checkIdx M j)) (checkY M (checkIdx M j))
      (AMat P.const (thetaTilde M (checkIdx M j)))) :
    ∃ c : ℂ, c ≠ 0 ∧
      (uPlus : TensorPow M) = c • checkVprime P.const M (gammaTildeC P M) :=
  exists_smul_of_TConj_eq uPlus (checkVprimeUnits P.const M (gammaTildeC P M))
    (TVPlus_eq_TCheckVprime' P hM hdual uPlus hT)

end Ising2D
