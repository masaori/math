/-
# `V^{(+)}` と `ψ̌` の交換関係

対応する人手証明のラベル: `commutation_V_plus_check_psi`
（`structured-latex/content/016_even_sector_fermions.ts` の
`evenfermi_004_claim_commutation_V_plus_psi`）

## 014 章・015 章への依存（**仮定として受け取る**）

原文の proof は次の 2 つを使う。いずれも本セッションの担当範囲外であり、
並行して形式化中なので**仮定として明示**する。

* `T_V_plus_check_Z_Y`（**014 章**）: `(T_{(V^{(+)})}(Ž_μ), T_{(V^{(+)})}(Y̌_μ)) = (Ž_μ, Y̌_μ) A(θ̃_μ)`
  → 仮定 `hT : ActsBy T (checkZ M μ) (checkY M μ) (AMat K (thetaTilde M μ))`
* `diagonalization_check_P_D`（**015 章**）: `A(θ̃_μ) = P̌_μ Ď_μ P̌_μ^{-1}`
  → 本ファイルでは使わない。原文が「対角化を経由して固有ベクトルを読む」ところを、
  **`ψ̌^†, ψ̌` の係数ベクトルが `A(θ̃_μ)` の固有ベクトルであることを直接示す**ことで置き換える
  （008 章の `Ising2D.AMat_mulVec_eigen` がそのまま使える）。
  この置き換えは原文の内容と同値である。`P̌_μ` の列が固有ベクトルであることは
  `diagonalization_check_P_D` の証明そのものだからである。
* `lambda_eq_exp_gamma_theta_tilde`（**015 章**）: `λ_{±,μ} = e^{±γ(θ̃_μ)}`
  → 本ファイルは固有値を `γ_1(θ̃_μ) ± r_μ`（`r_μ = |γ_2(θ̃_μ)|`）の形で無条件に出し、
  `e^{±γ}` への書き換えは仮定 `hlamPlus` / `hlamMinus` として分離する。

## 形式化の方針

原文 proof の Step 1（`T` の線型性を行ベクトルへ持ち上げる）と Step 2（結合律による計算）は、
008 章で用意した `Ising2D.ActsBy.eigen`（`B v = λ v ⇒ T(v_0 z + v_1 y) = λ (v_0 z + v_1 y)`）
1 本に対応する。原文が proof 冒頭で明示的に確かめている
「行ベクトル×行列の結合律」は、`ActsBy.eigen` の証明の中に吸収されている。
-/
import Ising2D.Part016.Claim003_AnticommutatorCheckPsi
import Ising2D.Part008.Claim027_EigenATheta

namespace Ising2D

open Matrix

variable {M : ℕ}

/-! ## `ψ̌^†`, `ψ̌` の係数ベクトルは `A(θ̃_μ)` の固有ベクトル -/

/-- `ψ̌_μ^†` の係数ベクトル `(p_μ, q)` は、008 章の固有ベクトル `(-r, γ_2(-θ̃_μ))` の
スカラー倍である。 -/
theorem checkPsiDag_coeff_eq (K : IsingConst) (M : ℕ) (hM : M ≠ 0) {μ : ℤ}
    (hga : gamma2 K (thetaTilde M μ) ≠ 0) :
    ![checkP K M μ, checkQ M]
      = (1 / (2 * sqrtM M * gamma2 K (-thetaTilde M μ)))
          • ![-((checkR K M μ : ℝ) : ℂ), gamma2 K (-thetaTilde M μ)] := by
  have hs : sqrtM M ≠ 0 := sqrtM_ne_zero hM
  have hgb : gamma2 K (-thetaTilde M μ) ≠ 0 := fun h =>
    hga ((gamma2_neg_eq_zero_iff K _).1 h)
  funext i
  fin_cases i <;> simp [checkP, checkQ] <;> field_simp

/-- `ψ̌_μ` の係数ベクトル `(-p_μ, q)` も同様（`r` の符号を反転した形）。 -/
theorem checkPsi_coeff_eq (K : IsingConst) (M : ℕ) (hM : M ≠ 0) {μ : ℤ}
    (hga : gamma2 K (thetaTilde M μ) ≠ 0) :
    ![-checkP K M μ, checkQ M]
      = (1 / (2 * sqrtM M * gamma2 K (-thetaTilde M μ)))
          • ![-(-((checkR K M μ : ℝ) : ℂ)), gamma2 K (-thetaTilde M μ)] := by
  have hs : sqrtM M ≠ 0 := sqrtM_ne_zero hM
  have hgb : gamma2 K (-thetaTilde M μ) ≠ 0 := fun h =>
    hga ((gamma2_neg_eq_zero_iff K _).1 h)
  funext i
  fin_cases i <;> simp [checkP, checkQ] <;> field_simp

/-- **`ψ̌_μ^†` 側の固有ベクトル方程式**: `A(θ̃_μ) (p_μ, q)ᵀ = (γ_1(θ̃_μ) + r_μ)(p_μ, q)ᵀ`。 -/
theorem AMat_mulVec_checkPsiDag_coeff (K : IsingConst) (M : ℕ) (hM : M ≠ 0) {μ : ℤ}
    (hga : gamma2 K (thetaTilde M μ) ≠ 0) :
    AMat K (thetaTilde M μ) *ᵥ ![checkP K M μ, checkQ M]
      = (gamma1 K (thetaTilde M μ) + ((checkR K M μ : ℝ) : ℂ))
          • ![checkP K M μ, checkQ M] := by
  have hs : ((checkR K M μ : ℝ) : ℂ) ^ 2
      = -(gamma2 K (thetaTilde M μ) * gamma2 K (-thetaTilde M μ)) := checkR_sq K M μ
  rw [checkPsiDag_coeff_eq K M hM hga, Matrix.mulVec_smul,
    AMat_mulVec_eigen K (thetaTilde M μ) _ hs, smul_comm]

/-- **`ψ̌_μ` 側の固有ベクトル方程式**: `A(θ̃_μ) (-p_μ, q)ᵀ = (γ_1(θ̃_μ) - r_μ)(-p_μ, q)ᵀ`。 -/
theorem AMat_mulVec_checkPsi_coeff (K : IsingConst) (M : ℕ) (hM : M ≠ 0) {μ : ℤ}
    (hga : gamma2 K (thetaTilde M μ) ≠ 0) :
    AMat K (thetaTilde M μ) *ᵥ ![-checkP K M μ, checkQ M]
      = (gamma1 K (thetaTilde M μ) - ((checkR K M μ : ℝ) : ℂ))
          • ![-checkP K M μ, checkQ M] := by
  have hs : (-((checkR K M μ : ℝ) : ℂ)) ^ 2
      = -(gamma2 K (thetaTilde M μ) * gamma2 K (-thetaTilde M μ)) := by
    rw [neg_pow]; simpa using checkR_sq K M μ
  rw [checkPsi_coeff_eq K M hM hga, Matrix.mulVec_smul,
    AMat_mulVec_eigen K (thetaTilde M μ) _ hs, smul_comm,
    show gamma1 K (thetaTilde M μ) + -((checkR K M μ : ℝ) : ℂ)
      = gamma1 K (thetaTilde M μ) - ((checkR K M μ : ℝ) : ℂ) by ring]

/-! ## 原文 `commutation_V_plus_check_psi`（014 章の作用を仮定した形） -/

/-- **原文 `commutation_V_plus_check_psi` 第 1 式**（固有値を `γ_1 + r` の形で述べた版）。 -/
theorem TVPlus_checkPsiDag_of_action (K : IsingConst) (M : ℕ) (hM : M ≠ 0) {μ : ℤ}
    (hga : gamma2 K (thetaTilde M μ) ≠ 0)
    {T : TensorPow M →ₗ[ℂ] TensorPow M}
    (hT : ActsBy T (checkZ M μ) (checkY M μ) (AMat K (thetaTilde M μ))) :
    T (checkPsiDag K M μ)
      = (gamma1 K (thetaTilde M μ) + ((checkR K M μ : ℝ) : ℂ)) • checkPsiDag K M μ := by
  have h := hT.eigen (AMat_mulVec_checkPsiDag_coeff K M hM hga)
  simpa [checkPsiDag] using h

/-- **原文 `commutation_V_plus_check_psi` 第 2 式**（固有値を `γ_1 - r` の形で述べた版）。 -/
theorem TVPlus_checkPsi_of_action (K : IsingConst) (M : ℕ) (hM : M ≠ 0) {μ : ℤ}
    (hga : gamma2 K (thetaTilde M μ) ≠ 0)
    {T : TensorPow M →ₗ[ℂ] TensorPow M}
    (hT : ActsBy T (checkZ M μ) (checkY M μ) (AMat K (thetaTilde M μ))) :
    T (checkPsi K M μ)
      = (gamma1 K (thetaTilde M μ) - ((checkR K M μ : ℝ) : ℂ)) • checkPsi K M μ := by
  have h := hT.eigen (AMat_mulVec_checkPsi_coeff K M hM hga)
  simpa [checkPsi] using h

/-- **原文 `commutation_V_plus_check_psi` そのもの**。

`λ_{±,μ} = e^{±γ(θ̃_μ)}`（015 章 `lambda_eq_exp_gamma_theta_tilde`）を
仮定 `hlamPlus` / `hlamMinus` として受け取る。 -/
theorem TVPlus_checkPsiDag_psi_of_action (K : IsingConst) (M : ℕ) (hM : M ≠ 0) {μ : ℤ}
    (hga : gamma2 K (thetaTilde M μ) ≠ 0) {g : ℂ}
    (hlamPlus : gamma1 K (thetaTilde M μ) + ((checkR K M μ : ℝ) : ℂ) = Complex.exp g)
    (hlamMinus : gamma1 K (thetaTilde M μ) - ((checkR K M μ : ℝ) : ℂ) = Complex.exp (-g))
    {T : TensorPow M →ₗ[ℂ] TensorPow M}
    (hT : ActsBy T (checkZ M μ) (checkY M μ) (AMat K (thetaTilde M μ))) :
    T (checkPsiDag K M μ) = Complex.exp g • checkPsiDag K M μ
      ∧ T (checkPsi K M μ) = Complex.exp (-g) • checkPsi K M μ :=
  ⟨by rw [TVPlus_checkPsiDag_of_action K M hM hga hT, hlamPlus],
   by rw [TVPlus_checkPsi_of_action K M hM hga hT, hlamMinus]⟩

end Ising2D
