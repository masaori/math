/-
# `V^{(+)}` と `ψ̌` の交換関係

対応する人手証明のラベル: `commutation_V_plus_check_psi`
（`structured-latex/content/eigenvalue_problem_diagonalization_and_exponential_form.ts` の
`evenfermi_004_claim_commutation_V_plus_psi`）

## 人手証明との対応

人手の行ベクトルと `2×2` 行列の積 `(A_0, B_0) G`（`calc_of_TxT_check_Z_Y` の定め方）は `Ising2D.rowMul`、
行ベクトルへの作用 `(T(A_0), T(B_0))` は `Ising2D.rowApply`
（`MathematicalTools/InvertibleMatricesLinearMapCorrespondenceAndConjugation/DefinitionTgAndTV.lean`）である。

| 人手の箇所 | Lean |
| --- | --- |
| proof 冒頭の結合律 `((A_0, B_0)G)H = (A_0, B_0)(GH)` | `rowMul_rowMul` |
| Step 1（`T_{(V^{(+)})}` の線型性を行ベクトルへ持ち上げる） | `rowApply_rowMul` |
| `def_check_fermi` の `(ψ̌_μ^†, ψ̌_μ) = (Ž_μ, Y̌_μ) P̌_μ` | `checkPsiDag_eq_checkPmat_col`・`checkPsi_eq_checkPmat_col`・`checkPsi_row_eq_rowMul_checkPmat` |
| Step 2 の 9 行の鎖 | `rowApply_checkPsi_row` の `calc` |
| 第 1 列・第 2 列を比べる | `TVPlus_checkPsiDag_of_action`・`TVPlus_checkPsi_of_action` |
| `λ_{±,μ} = e^{±γ(θ̃_μ)}` を各列へ代入する | `TVPlus_checkPsiDag_psi_of_action` |
| 主張（仮定なし） | `TVPlus_checkPsiDag_checkPsi`（`ClaimCheckFermiResultsUnconditional.lean`） |

人手の proof が引くブロックの扱い:

* `T_V_plus_check_Z_Y`: 仮定 `hT : ActsBy T (Ž_μ) (Y̌_μ) (A(θ̃_μ))` として受け取る。
  `ClaimCheckFermiResultsUnconditional.lean` の `TVPlus_checkPsiDag_checkPsi` が、具体的な `V^{(+)}` について
  `TVPlus_actsBy_checkZY` で埋める。
* `diagonalization_check_P_D`: `AMat_thetaTilde_eq_checkPmat_mul_checkDmat_mul_inv`（`A = P̌ Ď P̌^{-1}`）と、
  `P̌^{-1} P̌ = I` に使う `det_checkPmat_ne_zero`（`ClaimEigenATildeDiag.lean`）。どちらも `P : IsingParam` を取るので、
  人手の statement の `K_1, K_2 ∈ ℝ_{>0}` を `P` で受け取る。
* `lambda_eq_exp_gamma_theta_tilde`: 仮定 `hlamPlus` / `hlamMinus`（`λ_{±,μ} = e^{±g}`）として受け取る。
  `TVPlus_checkPsiDag_checkPsi` が `lambdaPlusR_eq_exp_gammaTildeC`・`lambdaMinusR_eq_exp_gammaTildeC` で埋める。
* `V_plus_factors_invertible`・`T_V_plus_is_conjugation`・`linearity_of_T`（人手の Step 1 が `T_{(V^{(+)})}` の線型性を得るのに引く）:
  `T` を任意の `ℂ` 線型写像として受け取るので、このファイルでは引かない。`TVPlus_checkPsiDag_checkPsi` が
  可逆元 `V^{(+)}` による共役 `TConj` の線型写像を渡す。
-/
import Ising2D.EigenvalueProblem.DiagonalizationAndExponentialForm.ClaimAnticommutatorCheckPsi
import Ising2D.EigenvalueProblem.DiagonalizationAndExponentialForm.ClaimEigenATildeDiag
import Ising2D.MathematicalTools.InvertibleMatricesLinearMapCorrespondenceAndConjugation.DefinitionTgAndTV

namespace Ising2D

open Matrix

variable {M : ℕ}

/-! ## 行ベクトルと `2×2` 行列の積（人手 proof の冒頭と Step 1） -/

section RowVector

variable {A : Type*} [AddCommMonoid A] [Module ℂ A]

/-- **人手 proof 冒頭の結合律**: `((A_0, B_0) G) H = (A_0, B_0)(G H)`。

第 `l` 列は左辺が `Σ_k h_{kl}(g_{1k}A_0 + g_{2k}B_0)`、右辺が `(Σ_k g_{1k}h_{kl})A_0 + (Σ_k g_{2k}h_{kl})B_0` で、
`ℂ` 上のスカラー倍の分配律で一致する。 -/
theorem rowMul_rowMul (p : A × A) (G H : Matrix (Fin 2) (Fin 2) ℂ) :
    rowMul (rowMul p G) H = rowMul p (G * H) := by
  simp only [rowMul, Matrix.mul_apply, Fin.sum_univ_two, Prod.mk.injEq]
  constructor <;> module

/-- 行ベクトルと単位行列の積: `(A_0, B_0) I = (A_0, B_0)`（行ベクトルと `2×2` 行列の積の定義）。
`T_V_plus_eq_T_check_Vprime_on_check_Z_Y` の Step 1 が使う。 -/
theorem rowMul_one (p : A × A) : rowMul p (1 : Matrix (Fin 2) (Fin 2) ℂ) = p := by
  simp [rowMul]

/-- **人手 Step 1**: `T((A_0, B_0) G) = (T(A_0), T(B_0)) G`（`T` の線型性を 2 列へ同時適用）。 -/
theorem rowApply_rowMul (T : A →ₗ[ℂ] A) (p : A × A) (G : Matrix (Fin 2) (Fin 2) ℂ) :
    rowApply T (rowMul p G) = rowMul (rowApply T p) G := by
  calc rowApply T (rowMul p G)
      = (T (G 0 0 • p.1 + G 1 0 • p.2), T (G 0 1 • p.1 + G 1 1 • p.2)) := rfl
        -- 行ベクトルへの作用の定め方
    _ = (G 0 0 • T p.1 + G 1 0 • T p.2, G 0 1 • T p.1 + G 1 1 • T p.2) := by
        simp only [map_add, map_smul]                                   -- `T` の線型性を 2 列へ同時適用
    _ = rowMul (rowApply T p) G := rfl                                  -- 行ベクトルと `2×2` 行列の積の定義

end RowVector

/-! ## `def_check_fermi` の行ベクトル記法 `(ψ̌_μ^†, ψ̌_μ) = (Ž_μ, Y̌_μ) P̌_μ` -/

/-- `def_check_fermi` の `r_μ` は `diagonalization_check_P_D` の `|γ_2(θ̃_μ)|` そのもの（定義が同じ）。 -/
theorem checkR_eq_absGamma2 (K : IsingConst) (M : ℕ) (μ : ℤ) :
    checkR K M μ = absGamma2 K (thetaTilde M μ) := rfl

/-- **`def_check_fermi` の行ベクトル記法との一致**（`P̌_μ` の第 0 列が `ψ̌_μ^†`）。 -/
theorem checkPsiDag_eq_checkPmat_col (K : IsingConst) (M : ℕ) (μ : ℤ) :
    checkPsiDag K M μ
      = checkPmat K M μ 0 0 • checkZ M μ + checkPmat K M μ 1 0 • checkY M μ := by
  simp [checkPsiDag, checkP, checkQ, checkPmat, sqrtM, checkR_eq_absGamma2]

/-- **`def_check_fermi` の行ベクトル記法との一致**（`P̌_μ` の第 1 列が `ψ̌_μ`）。 -/
theorem checkPsi_eq_checkPmat_col (K : IsingConst) (M : ℕ) (μ : ℤ) :
    checkPsi K M μ
      = checkPmat K M μ 0 1 • checkZ M μ + checkPmat K M μ 1 1 • checkY M μ := by
  simp [checkPsi, checkP, checkQ, checkPmat, sqrtM, checkR_eq_absGamma2, neg_div]

/-- **`def_check_fermi`**: `(ψ̌_μ^†, ψ̌_μ) = (Ž_μ, Y̌_μ) P̌_μ`（上の 2 列を並べたもの）。 -/
theorem checkPsi_row_eq_rowMul_checkPmat (K : IsingConst) (M : ℕ) (μ : ℤ) :
    (checkPsiDag K M μ, checkPsi K M μ) = rowMul (checkZ M μ, checkY M μ) (checkPmat K M μ) := by
  rw [checkPsiDag_eq_checkPmat_col, checkPsi_eq_checkPmat_col]
  rfl

/-! ## 人手 Step 2 の鎖 -/

/-- **人手 Step 2**: `(T(ψ̌_μ^†), T(ψ̌_μ)) = (λ_{+,μ} ψ̌_μ^†, λ_{-,μ} ψ̌_μ)`。 -/
theorem rowApply_checkPsi_row (P : IsingParam) (M : ℕ) (hM : M ≠ 0) (μ : ℤ)
    {T : TensorPow M →ₗ[ℂ] TensorPow M}
    (hT : ActsBy T (checkZ M μ) (checkY M μ) (AMat P.const (thetaTilde M μ))) :
    rowApply T (checkPsiDag P.const M μ, checkPsi P.const M μ)
      = (((lambdaPlusR P.const (thetaTilde M μ) : ℝ) : ℂ) • checkPsiDag P.const M μ,
         ((lambdaMinusR P.const (thetaTilde M μ) : ℝ) : ℂ) • checkPsi P.const M μ) := by
  have hrow := checkPsi_row_eq_rowMul_checkPmat P.const M μ
  have hdet : IsUnit (checkPmat P.const M μ).det :=
    isUnit_iff_ne_zero.2 (det_checkPmat_ne_zero P hM μ)
  calc rowApply T (checkPsiDag P.const M μ, checkPsi P.const M μ)
      = rowApply T (rowMul (checkZ M μ, checkY M μ) (checkPmat P.const M μ)) := by
        rw [hrow]                                                       -- `ψ̌_μ, ψ̌_μ^†` の定義
    _ = rowMul (rowApply T (checkZ M μ, checkY M μ)) (checkPmat P.const M μ) :=
        rowApply_rowMul _ _ _                                           -- Step 1
    _ = rowMul (rowMul (checkZ M μ, checkY M μ) (AMat P.const (thetaTilde M μ)))
          (checkPmat P.const M μ) := by
        rw [(actsBy_iff_rowApply_eq_rowMul).1 hT]                       -- `T` の `Ž, Y̌` への作用
    _ = rowMul (checkZ M μ, checkY M μ)
          (AMat P.const (thetaTilde M μ) * checkPmat P.const M μ) :=
        rowMul_rowMul _ _ _                                             -- 結合法則
    _ = rowMul (checkZ M μ, checkY M μ)
          (checkPmat P.const M μ * checkDmat P.const M μ * (checkPmat P.const M μ)⁻¹
            * checkPmat P.const M μ) := by
        rw [← AMat_thetaTilde_eq_checkPmat_mul_checkDmat_mul_inv P hM μ] -- `A = P̌ Ď P̌^{-1}`
    _ = rowMul (checkZ M μ, checkY M μ) (checkPmat P.const M μ * checkDmat P.const M μ) := by
        rw [Matrix.mul_assoc (checkPmat P.const M μ * checkDmat P.const M μ),
          Matrix.nonsing_inv_mul _ hdet, Matrix.mul_one]                -- `P̌^{-1} P̌ = I`
    _ = rowMul (rowMul (checkZ M μ, checkY M μ) (checkPmat P.const M μ)) (checkDmat P.const M μ) :=
        (rowMul_rowMul _ _ _).symm                                      -- 結合法則
    _ = rowMul (checkPsiDag P.const M μ, checkPsi P.const M μ) (checkDmat P.const M μ) := by
        rw [hrow]                                                       -- `ψ̌_μ, ψ̌_μ^†` の定義
    _ = (((lambdaPlusR P.const (thetaTilde M μ) : ℝ) : ℂ) • checkPsiDag P.const M μ,
         ((lambdaMinusR P.const (thetaTilde M μ) : ℝ) : ℂ) • checkPsi P.const M μ) := by
        simp [rowMul, checkDmat]                                        -- `Ď_μ` は対角行列

/-! ## 第 1 列・第 2 列を比べ、`λ_{±,μ} = e^{±γ(θ̃_μ)}` を代入する -/

/-- **人手 `commutation_V_plus_check_psi` の第 1 列**: `T(ψ̌_μ^†) = λ_{+,μ} ψ̌_μ^†`。 -/
theorem TVPlus_checkPsiDag_of_action (P : IsingParam) (M : ℕ) (hM : M ≠ 0) (μ : ℤ)
    {T : TensorPow M →ₗ[ℂ] TensorPow M}
    (hT : ActsBy T (checkZ M μ) (checkY M μ) (AMat P.const (thetaTilde M μ))) :
    T (checkPsiDag P.const M μ)
      = ((lambdaPlusR P.const (thetaTilde M μ) : ℝ) : ℂ) • checkPsiDag P.const M μ := by
  calc T (checkPsiDag P.const M μ)
      = (rowApply T (checkPsiDag P.const M μ, checkPsi P.const M μ)).1 := rfl
    _ = ((lambdaPlusR P.const (thetaTilde M μ) : ℝ) : ℂ) • checkPsiDag P.const M μ := by
        rw [rowApply_checkPsi_row P M hM μ hT]                          -- Step 2 の等式の第 1 列

/-- **人手 `commutation_V_plus_check_psi` の第 2 列**: `T(ψ̌_μ) = λ_{-,μ} ψ̌_μ`。 -/
theorem TVPlus_checkPsi_of_action (P : IsingParam) (M : ℕ) (hM : M ≠ 0) (μ : ℤ)
    {T : TensorPow M →ₗ[ℂ] TensorPow M}
    (hT : ActsBy T (checkZ M μ) (checkY M μ) (AMat P.const (thetaTilde M μ))) :
    T (checkPsi P.const M μ)
      = ((lambdaMinusR P.const (thetaTilde M μ) : ℝ) : ℂ) • checkPsi P.const M μ := by
  calc T (checkPsi P.const M μ)
      = (rowApply T (checkPsiDag P.const M μ, checkPsi P.const M μ)).2 := rfl
    _ = ((lambdaMinusR P.const (thetaTilde M μ) : ℝ) : ℂ) • checkPsi P.const M μ := by
        rw [rowApply_checkPsi_row P M hM μ hT]                          -- Step 2 の等式の第 2 列

/-- **人手 `commutation_V_plus_check_psi`**（`T` の `Ž, Y̌` への作用と `λ_{±,μ}` の指数表示を仮定に取る形）。

`T_V_plus_check_Z_Y` を `hT`、`lambda_eq_exp_gamma_theta_tilde` を `hlamPlus` / `hlamMinus` として受け取り、
各列へ代入する。仮定を埋めた主張は `ClaimCheckFermiResultsUnconditional.lean` の `TVPlus_checkPsiDag_checkPsi`。 -/
theorem TVPlus_checkPsiDag_psi_of_action (P : IsingParam) (M : ℕ) (hM : M ≠ 0) (μ : ℤ) {g : ℂ}
    (hlamPlus : ((lambdaPlusR P.const (thetaTilde M μ) : ℝ) : ℂ) = Complex.exp g)
    (hlamMinus : ((lambdaMinusR P.const (thetaTilde M μ) : ℝ) : ℂ) = Complex.exp (-g))
    {T : TensorPow M →ₗ[ℂ] TensorPow M}
    (hT : ActsBy T (checkZ M μ) (checkY M μ) (AMat P.const (thetaTilde M μ))) :
    T (checkPsiDag P.const M μ) = Complex.exp g • checkPsiDag P.const M μ
      ∧ T (checkPsi P.const M μ) = Complex.exp (-g) • checkPsi P.const M μ := by
  constructor
  · calc T (checkPsiDag P.const M μ)
        = ((lambdaPlusR P.const (thetaTilde M μ) : ℝ) : ℂ) • checkPsiDag P.const M μ :=
          TVPlus_checkPsiDag_of_action P M hM μ hT                      -- 第 1 列
      _ = Complex.exp g • checkPsiDag P.const M μ := by rw [hlamPlus]   -- `λ_{+,μ} = e^{+γ(θ̃_μ)}`
  · calc T (checkPsi P.const M μ)
        = ((lambdaMinusR P.const (thetaTilde M μ) : ℝ) : ℂ) • checkPsi P.const M μ :=
          TVPlus_checkPsi_of_action P M hM μ hT                         -- 第 2 列
      _ = Complex.exp (-g) • checkPsi P.const M μ := by rw [hlamMinus]  -- `λ_{-,μ} = e^{-γ(θ̃_μ)}`

end Ising2D
