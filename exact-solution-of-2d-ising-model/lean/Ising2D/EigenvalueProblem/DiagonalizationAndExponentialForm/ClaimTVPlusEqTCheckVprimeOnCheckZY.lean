/-
# `T_{(V^{(+)})}` と `T_{(V̌')}` は `Ž, Y̌` 上で一致する

対応する人手証明のラベル: `T_V_plus_eq_T_check_Vprime_on_check_Z_Y`
（`structured-latex/content/eigenvalue_problem_diagonalization_and_exponential_form.ts` の
`evenfermi_007_claim_T_eq_on_check_Z_Y`）

## 人手証明との対応

行ベクトルと `2×2` 行列の積 `(A_0, B_0) G` は `Ising2D.rowMul`、その結合律は `rowMul_rowMul`、
`(ψ̌_μ^†, ψ̌_μ) = (Ž_μ, Y̌_μ) P̌_μ` は `checkPsi_row_eq_rowMul_checkPmat`
（いずれも `ClaimCommutationVPlusCheckPsi.lean`）である。

| 人手の箇所 | Lean |
| --- | --- |
| Step 1 の 3 行の鎖 `(Ž_μ, Y̌_μ) = (ψ̌_μ^†, ψ̌_μ) P̌_μ^{-1}` | `checkZY_row_eq_rowMul_checkPmat_inv` の `calc` |
| 鎖の 1 行目が使う `P̌_μ P̌_μ^{-1} = I` | `Matrix.mul_nonsing_inv` と `det_checkPmat_ne_zero`（`diagonalization_check_P_D`） |
| 鎖の 1 行目が使う `(A_0, B_0) I = (A_0, B_0)` | `rowMul_one`（`ClaimCommutationVPlusCheckPsi.lean`） |
| 「すなわち」の 2 式 `Ž_μ = q_{11}ψ̌_μ^† + q_{21}ψ̌_μ`、`Y̌_μ = q_{12}ψ̌_μ^† + q_{22}ψ̌_μ` | `checkZ_eq_checkPmat_inv_col`・`checkY_eq_checkPmat_inv_col` |
| Step 3 の 5 行の鎖（`Ž_μ` と `Y̌_μ`） | `eq_on_checkZY_of_eq_on_checkPsi` の 2 つの `calc` |
| Step 2 の 2 つの鎖と主張 | `TVPlus_eq_TCheckVprime_on_checkZY` |

人手の proof 冒頭の段落（`V_plus_factors_invertible`・`T_V_plus_is_conjugation`・`def_check_Vprime` (2)・`mat_conj` から
`T_{(V^{(+)})}`・`T_{(V̌')}` が ℂ 線型であることを得る）は、このファイルでは引かない。Step 3 の `T₁`・`T₂` を任意の
ℂ 線型写像として受け取り、`TVPlus_eq_TCheckVprime_on_checkZY` は `T_{(V̌')}` の側に可逆元 `V̌'` による共役 `TConj` の
線型写像を渡す。`T_{(V^{(+)})}` の側は呼び出し元（`ClaimTVPlusEqTCheckVprime.lean`）が同じく `TConj` の線型写像を渡す。

必要十分版は `Ising2D/NecSuf/RowVectorRightInverse.lean`、そこからの導出は `ClaimTVPlusEqTCheckVprimeOnCheckZYFromNecSuf.lean`。

人手の `q_{ij}` は `(checkPmat P.const M μ)⁻¹` の成分で、添字は `q_{11} = q 0 0`、`q_{21} = q 1 0`、
`q_{12} = q 0 1`、`q_{22} = q 1 1` である。`diagonalization_check_P_D` は `P : IsingParam` を取るので、
人手の statement の `K_1, K_2 ∈ ℝ_{>0}` を `P` で受け取る。
-/
import Ising2D.EigenvalueProblem.DiagonalizationAndExponentialForm.ClaimActionTCheckVprime
import Ising2D.EigenvalueProblem.DiagonalizationAndExponentialForm.ClaimCommutationVPlusCheckPsi

namespace Ising2D

open Matrix

variable {M : ℕ}

/-! ## 人手 Step 1: `Ž_μ, Y̌_μ` を `ψ̌_μ^†, ψ̌_μ` で書く -/

/-- **人手 Step 1 の鎖**: `(Ž_μ, Y̌_μ) = (ψ̌_μ^†, ψ̌_μ) P̌_μ^{-1}`。 -/
theorem checkZY_row_eq_rowMul_checkPmat_inv (P : IsingParam) (hM : M ≠ 0) (μ : ℤ) :
    (checkZ M μ, checkY M μ)
      = rowMul (checkPsiDag P.const M μ, checkPsi P.const M μ) (checkPmat P.const M μ)⁻¹ := by
  have hdet : IsUnit (checkPmat P.const M μ).det :=
    isUnit_iff_ne_zero.2 (det_checkPmat_ne_zero P hM μ)               -- `det P̌_μ ≠ 0`
  calc (checkZ M μ, checkY M μ)
      = rowMul (checkZ M μ, checkY M μ) (checkPmat P.const M μ * (checkPmat P.const M μ)⁻¹) := by
        rw [Matrix.mul_nonsing_inv _ hdet, rowMul_one]                  -- `P̌_μ P̌_μ^{-1} = I`、`(A_0, B_0) I = (A_0, B_0)`
    _ = rowMul (rowMul (checkZ M μ, checkY M μ) (checkPmat P.const M μ)) (checkPmat P.const M μ)⁻¹ :=
        (rowMul_rowMul _ _ _).symm                                      -- 結合法則
    _ = rowMul (checkPsiDag P.const M μ, checkPsi P.const M μ) (checkPmat P.const M μ)⁻¹ := by
        rw [checkPsi_row_eq_rowMul_checkPmat]                           -- `ψ̌_μ^†, ψ̌_μ` の定義

/-- **人手 Step 1 の「すなわち」の第 1 式**: `Ž_μ = q_{11} ψ̌_μ^† + q_{21} ψ̌_μ`（`q := P̌_μ^{-1}`）。 -/
theorem checkZ_eq_checkPmat_inv_col (P : IsingParam) (hM : M ≠ 0) (μ : ℤ) :
    checkZ M μ
      = (checkPmat P.const M μ)⁻¹ 0 0 • checkPsiDag P.const M μ
        + (checkPmat P.const M μ)⁻¹ 1 0 • checkPsi P.const M μ :=
  congrArg Prod.fst (checkZY_row_eq_rowMul_checkPmat_inv P hM μ)        -- 行ベクトルと `2×2` 行列の積の定義

/-- **人手 Step 1 の「すなわち」の第 2 式**: `Y̌_μ = q_{12} ψ̌_μ^† + q_{22} ψ̌_μ`（`q := P̌_μ^{-1}`）。 -/
theorem checkY_eq_checkPmat_inv_col (P : IsingParam) (hM : M ≠ 0) (μ : ℤ) :
    checkY M μ
      = (checkPmat P.const M μ)⁻¹ 0 1 • checkPsiDag P.const M μ
        + (checkPmat P.const M μ)⁻¹ 1 1 • checkPsi P.const M μ :=
  congrArg Prod.snd (checkZY_row_eq_rowMul_checkPmat_inv P hM μ)        -- 行ベクトルと `2×2` 行列の積の定義

/-! ## 人手 Step 3: フェルミオン上の一致を線型性で `Ž, Y̌` へ移す -/

/-- **人手 Step 3**: 2 つの ℂ 線型写像が `ψ̌_μ^†` と `ψ̌_μ` の上で一致すれば、`Ž_μ` と `Y̌_μ` の上でも一致する。 -/
theorem eq_on_checkZY_of_eq_on_checkPsi (P : IsingParam) (hM : M ≠ 0) (μ : ℤ)
    {T₁ T₂ : TensorPow M →ₗ[ℂ] TensorPow M}
    (hdag : T₁ (checkPsiDag P.const M μ) = T₂ (checkPsiDag P.const M μ))
    (hpsi : T₁ (checkPsi P.const M μ) = T₂ (checkPsi P.const M μ)) :
    T₁ (checkZ M μ) = T₂ (checkZ M μ) ∧ T₁ (checkY M μ) = T₂ (checkY M μ) := by
  set q := (checkPmat P.const M μ)⁻¹
  set a := checkPsiDag P.const M μ
  set b := checkPsi P.const M μ
  constructor
  · calc T₁ (checkZ M μ)
        = T₁ (q 0 0 • a + q 1 0 • b) := by
          rw [← checkZ_eq_checkPmat_inv_col P hM μ]                     -- Step 1
      _ = q 0 0 • T₁ a + q 1 0 • T₁ b := by
          rw [map_add, map_smul, map_smul]                              -- `T₁` の線型性
      _ = q 0 0 • T₂ a + q 1 0 • T₂ b := by
          rw [hdag, hpsi]                                               -- Step 2
      _ = T₂ (q 0 0 • a + q 1 0 • b) := by
          rw [map_add, map_smul, map_smul]                              -- `T₂` の線型性
      _ = T₂ (checkZ M μ) := by
          rw [← checkZ_eq_checkPmat_inv_col P hM μ]                     -- Step 1
  · calc T₁ (checkY M μ)
        = T₁ (q 0 1 • a + q 1 1 • b) := by
          rw [← checkY_eq_checkPmat_inv_col P hM μ]                     -- Step 1
      _ = q 0 1 • T₁ a + q 1 1 • T₁ b := by
          rw [map_add, map_smul, map_smul]                              -- `T₁` の線型性
      _ = q 0 1 • T₂ a + q 1 1 • T₂ b := by
          rw [hdag, hpsi]                                               -- Step 2
      _ = T₂ (q 0 1 • a + q 1 1 • b) := by
          rw [map_add, map_smul, map_smul]                              -- `T₂` の線型性
      _ = T₂ (checkY M μ) := by
          rw [← checkY_eq_checkPmat_inv_col P hM μ]                     -- Step 1

/-- **人手 `T_V_plus_eq_T_check_Vprime_on_check_Z_Y` そのもの**（Step 2 の 2 つの鎖を `calc` で書き、Step 3 へ渡す）。

`T_{(V^{(+)})}` の側は `T_V_plus_check_Z_Y` の作用（`hT`）と `lambda_eq_exp_gamma_theta_tilde`（`hlamPlus`・`hlamMinus`）を
仮定として受け取り、`commutation_V_plus_check_psi`（`TVPlus_checkPsiDag_psi_of_action`）へ渡す。
`T_{(V̌')}` の側は `action_of_T_check_Vprime_on_check_psi`（`TCheckVprime_checkPsiDag`・`TCheckVprime_checkPsi`）である。 -/
theorem TVPlus_eq_TCheckVprime_on_checkZY (P : IsingParam) (g : ℤ → ℂ) (hM : M ≠ 0)
    (hgconj : ∀ μ : ℤ, CheckIndex M μ → g ((M : ℤ) + 1 - μ) = g μ)
    {TPlus : TensorPow M →ₗ[ℂ] TensorPow M}
    (hT : ∀ j : Fin M, ActsBy TPlus (checkZ M (checkIdx M j)) (checkY M (checkIdx M j))
      (AMat P.const (thetaTilde M (checkIdx M j))))
    (hlamPlus : ∀ j : Fin M,
      ((lambdaPlusR P.const (thetaTilde M (checkIdx M j)) : ℝ) : ℂ) = Complex.exp (g (checkIdx M j)))
    (hlamMinus : ∀ j : Fin M,
      ((lambdaMinusR P.const (thetaTilde M (checkIdx M j)) : ℝ) : ℂ) = Complex.exp (-g (checkIdx M j)))
    (j : Fin M) :
    TPlus (checkZ M (checkIdx M j))
        = TConj (checkVprimeUnits P.const M g) (checkZ M (checkIdx M j))
      ∧ TPlus (checkY M (checkIdx M j))
        = TConj (checkVprimeUnits P.const M g) (checkY M (checkIdx M j)) := by
  -- `gamma_2_theta_tilde_nonzero`（`action_of_T_check_Vprime_on_check_psi` の仮定）
  have hga : ∀ μ : ℤ, CheckIndex M μ → gamma2 P.const (thetaTilde M μ) ≠ 0 :=
    fun μ _ => gamma2_thetaTilde_ne_zero P hM μ
  have hcomm := TVPlus_checkPsiDag_psi_of_action P M hM (checkIdx M j)
    (hlamPlus j) (hlamMinus j) (hT j)
  refine eq_on_checkZY_of_eq_on_checkPsi (T₁ := TPlus)
    (T₂ := (TConj (checkVprimeUnits P.const M g)).toLinearMap) P hM (checkIdx M j) ?_ ?_
  · calc TPlus (checkPsiDag P.const M (checkIdx M j))
        = Complex.exp (g (checkIdx M j)) • checkPsiDag P.const M (checkIdx M j) :=
          hcomm.1                                                       -- `V^{(+)}` と `ψ̌` の交換関係
      _ = TConj (checkVprimeUnits P.const M g) (checkPsiDag P.const M (checkIdx M j)) :=
          (TCheckVprime_checkPsiDag P.const g hM hga j).symm            -- `T_{(V̌')}` の `ψ̌` への作用
  · calc TPlus (checkPsi P.const M (checkIdx M j))
        = Complex.exp (-g (checkIdx M j)) • checkPsi P.const M (checkIdx M j) :=
          hcomm.2                                                       -- `V^{(+)}` と `ψ̌` の交換関係
      _ = TConj (checkVprimeUnits P.const M g) (checkPsi P.const M (checkIdx M j)) :=
          (TCheckVprime_checkPsi P.const g hM hga hgconj j).symm        -- `T_{(V̌')}` の `ψ̌` への作用

end Ising2D
