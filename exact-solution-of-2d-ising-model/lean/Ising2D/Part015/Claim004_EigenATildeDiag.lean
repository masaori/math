/-
# `A(θ~_μ)` の固有値・固有ベクトルと対角化 `A = P̌ Ď P̌⁻¹`（**具体版**）

対応する人手証明のラベル: `eigenvector_of_A_theta_tilde`, `diagonalization_check_P_D`
（`structured-latex/content/015_A_theta_tilde_diagonalization.ts` の
`Athetatilde_004_claim_eigenvector`, `Athetatilde_005_claim_diagonalization`）

**抽象版**: `Ising2D/Abstract/TwoByTwoSkew.lean`
（`Ising2D.Abstract.skew2_mulVec` / `skew2_charPoly_factor` / `eq_conj_of_mul_eq`）。

## 形式化の方針

* 008 章の `A(θ)` は `θ ∈ ℝ` について述べられた 2×2 の主張なので、
  **固有ベクトルと対角化の骨格は既存の定理に `θ := θ~_μ` を代入するだけで得られる**
  （`Ising2D.AMat_mulVec_eigen`, `Ising2D.AMat_mul_Pmat`,
  `Ising2D.AMat_eq_Pmat_mul_Dmat_mul_inv`、`Part008/Claim027_EigenATheta.lean`）。
  本ファイルで新しく要るのは、**平方根の分岐が `|γ_2|` に確定すること**
  （`Part015/Claim003_RelationGamma2Tilde.lean` の (4)(5)）を代入して
  人手証明の形（`λ_± = γ_1 ± |γ_2|`、`v_± = c(∓|γ_2|, γ_2(-θ~))`）に直すことだけである。
* 008 章の `Pmat K θ t sM` は `t^2 = γ_2(θ)γ_2(-θ)` を満たす `t` でパラメトライズされている。
  半整数運動量では (5) により `t := i|γ_2(θ~_μ)|` と取れる（`checkT`）。
  このとき `Pmat` の第 1 列第 1 成分 `i t/(2√M γ_2(-θ~)) = -|γ_2|/(2√M γ_2(-θ~))` となり、
  人手証明の `P̌_μ` に文字どおり一致する（`checkPmat_eq_Pmat`）。
  対角成分も `γ_1 ∓ i t = γ_1 ± |γ_2| = λ_{±,μ}` となり `Ď_μ` に一致する。
* **人手証明と違い `γ_2 = 0` の場合分けが無い**のは
  `gamma_2_theta_tilde_nonzero`（`Ising2D.gamma2_thetaTilde_ne_zero`）が無条件だからである。
  Lean 側では `Pmat` の可逆性（`det P̌ ≠ 0`）にそれが効く。
-/
import Ising2D.Part015.Claim003_RelationGamma2Tilde
import Ising2D.Abstract.TwoByTwoSkew

namespace Ising2D

open Matrix

variable (K : IsingConst) (θ : ℝ)

/-! ## 固有値（人手証明 `eigenvector_of_A_theta_tilde` の `λ_{±,μ}`） -/

/-- 人手証明の `λ_{+,μ} = γ_1(θ~_μ) + |γ_2(θ~_μ)|`（実数値）。 -/
noncomputable def lambdaPlusR : ℝ := gamma1R K θ + absGamma2 K θ

/-- 人手証明の `λ_{-,μ} = γ_1(θ~_μ) - |γ_2(θ~_μ)|`（実数値）。 -/
noncomputable def lambdaMinusR : ℝ := gamma1R K θ - absGamma2 K θ

/-- `λ_{±,μ}` は**実数**である（人手証明の statement の `∈ ℝ`）。 -/
theorem lambdaPlusR_ofReal :
    ((lambdaPlusR K θ : ℝ) : ℂ) = gamma1 K θ + ((absGamma2 K θ : ℝ) : ℂ) := by
  rw [lambdaPlusR, gamma1_eq_ofReal, Complex.ofReal_add]

theorem lambdaMinusR_ofReal :
    ((lambdaMinusR K θ : ℝ) : ℂ) = gamma1 K θ - ((absGamma2 K θ : ℝ) : ℂ) := by
  rw [lambdaMinusR, gamma1_eq_ofReal, Complex.ofReal_sub]

/-! ## 固有ベクトル（人手証明 `eigenvector_of_A_theta_tilde` Step 1・Step 2） -/

/-- **人手証明 Step 1**: 特性多項式の因数分解 `= (λ - λ_+)(λ - λ_-)`。
`Part008` の `charPoly_factor` に (4) を代入したもの。 -/
theorem charPoly_factor_thetaTilde (lam : ℂ) :
    lam ^ 2 - 2 * gamma1 K θ * lam + (gamma1 K θ ^ 2 + gamma2 K θ * gamma2 K (-θ))
      = (lam - ((lambdaPlusR K θ : ℝ) : ℂ)) * (lam - ((lambdaMinusR K θ : ℝ) : ℂ)) := by
  rw [lambdaPlusR_ofReal, lambdaMinusR_ofReal]
  exact charPoly_factor K θ _ (by
    rw [sq_absGamma2]) lam

/-- **人手証明 Step 2**: `v_{+,μ} = (-|γ_2|, γ_2(-θ~))` は固有値 `λ_{+,μ}` の固有ベクトル。 -/
theorem AMat_mulVec_eigen_pos :
    AMat K θ *ᵥ ![-((absGamma2 K θ : ℝ) : ℂ), gamma2 K (-θ)]
      = ((lambdaPlusR K θ : ℝ) : ℂ) • ![-((absGamma2 K θ : ℝ) : ℂ), gamma2 K (-θ)] := by
  rw [lambdaPlusR_ofReal]
  exact AMat_mulVec_eigen K θ _ (by rw [sq_absGamma2])

/-- **人手証明 Step 2**: `v_{-,μ} = (+|γ_2|, γ_2(-θ~))` は固有値 `λ_{-,μ}` の固有ベクトル。 -/
theorem AMat_mulVec_eigen_neg :
    AMat K θ *ᵥ ![((absGamma2 K θ : ℝ) : ℂ), gamma2 K (-θ)]
      = ((lambdaMinusR K θ : ℝ) : ℂ) • ![((absGamma2 K θ : ℝ) : ℂ), gamma2 K (-θ)] := by
  have h : (-(((absGamma2 K θ : ℝ) : ℂ))) ^ 2 = -(gamma2 K θ * gamma2 K (-θ)) := by
    rw [neg_pow]
    simp [sq_absGamma2]
  have := AMat_mulVec_eigen K θ (-((absGamma2 K θ : ℝ) : ℂ)) h
  rw [lambdaMinusR_ofReal]
  simpa [sub_eq_add_neg] using this

/-- **人手証明 Step 1 の末尾**: `λ_{+,μ} ≠ λ_{-,μ}`（`|γ_2| > 0` による）。 -/
theorem lambdaPlusR_ne_lambdaMinusR (P : IsingParam) {M : ℕ} (hM : M ≠ 0) (μ : ℤ) :
    lambdaPlusR P.const (thetaTilde M μ) ≠ lambdaMinusR P.const (thetaTilde M μ) := by
  have hr := absGamma2_thetaTilde_pos P hM μ
  rw [lambdaPlusR, lambdaMinusR]
  intro h
  linarith

/-! ## 対角化（人手証明 `diagonalization_check_P_D`） -/

/-- 008 章の `Pmat` に渡す平方根パラメータ。半整数運動量では (5) により
`t := i|γ_2(θ)|` と取れる（`t^2 = γ_2(θ)γ_2(-θ)`）。 -/
noncomputable def checkT : ℂ := Complex.I * ((absGamma2 K θ : ℝ) : ℂ)

theorem checkT_sq : checkT K θ ^ 2 = gamma2 K θ * gamma2 K (-θ) := sq_I_absGamma2 K θ

/-- **人手証明の `P̌_μ`**（正規化 `c = 1/(2√M γ_2(-θ~_μ))` を代入した明示形）。 -/
noncomputable def checkPmat (K : IsingConst) (M : ℕ) (μ : ℤ) : Matrix (Fin 2) (Fin 2) ℂ :=
  !![-((absGamma2 K (thetaTilde M μ) : ℝ) : ℂ) /
        (2 * ((Real.sqrt M : ℝ) : ℂ) * gamma2 K (-thetaTilde M μ)),
      ((absGamma2 K (thetaTilde M μ) : ℝ) : ℂ) /
        (2 * ((Real.sqrt M : ℝ) : ℂ) * gamma2 K (-thetaTilde M μ));
    1 / (2 * ((Real.sqrt M : ℝ) : ℂ)), 1 / (2 * ((Real.sqrt M : ℝ) : ℂ))]

/-- **人手証明の `Ď_μ = diag(λ_{+,μ}, λ_{-,μ})`**。 -/
noncomputable def checkDmat (K : IsingConst) (M : ℕ) (μ : ℤ) : Matrix (Fin 2) (Fin 2) ℂ :=
  !![((lambdaPlusR K (thetaTilde M μ) : ℝ) : ℂ), 0;
    0, ((lambdaMinusR K (thetaTilde M μ) : ℝ) : ℂ)]

/-- `P̌_μ` は 008 章の `P_μ` に `t = i|γ_2|`, `√M = Real.sqrt M` を入れたものである。 -/
theorem checkPmat_eq_Pmat (M : ℕ) (μ : ℤ) :
    checkPmat K M μ
      = Pmat K (thetaTilde M μ) (checkT K (thetaTilde M μ)) ((Real.sqrt M : ℝ) : ℂ) := by
  have hI : Complex.I * Complex.I = -1 := Complex.I_mul_I
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [checkPmat, Pmat, checkT, ← mul_assoc, hI, neg_div]

/-- `Ď_μ` は 008 章の `D_μ` に `t = i|γ_2|` を入れたものである。 -/
theorem checkDmat_eq_Dmat (M : ℕ) (μ : ℤ) :
    checkDmat K M μ = Dmat K (thetaTilde M μ) (checkT K (thetaTilde M μ)) := by
  have hI : Complex.I * Complex.I = -1 := Complex.I_mul_I
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [checkDmat, Dmat, checkT, lambdaPlusR_ofReal, lambdaMinusR_ofReal, ← mul_assoc, hI]
  all_goals ring

/-- **人手証明 Step 3**: `det P̌_μ = -|γ_2(θ~_μ)|/(2M γ_2(-θ~_μ))`。 -/
theorem det_checkPmat (P : IsingParam) {M : ℕ} (hM : M ≠ 0) (μ : ℤ) :
    (checkPmat P.const M μ).det
      = -((absGamma2 P.const (thetaTilde M μ) : ℝ) : ℂ) /
          (2 * (M : ℂ) * gamma2 P.const (-thetaTilde M μ)) := by
  have hMpos : (0 : ℝ) < (M : ℝ) := by exact_mod_cast Nat.pos_of_ne_zero hM
  have hsM : ((Real.sqrt M : ℝ) : ℂ) ≠ 0 := by
    simp only [ne_eq, Complex.ofReal_eq_zero]
    exact Real.sqrt_ne_zero'.2 hMpos
  have hsq : ((Real.sqrt M : ℝ) : ℂ) ^ 2 = (M : ℂ) := by
    rw [← Complex.ofReal_pow, Real.sq_sqrt hMpos.le]
    simp
  have hh := gamma2_neg_thetaTilde_ne_zero P hM μ
  have hI : Complex.I * Complex.I = -1 := Complex.I_mul_I
  rw [checkPmat_eq_Pmat, det_Pmat _ _ _ _ hsM hh, checkT, hsq]
  rw [show Complex.I * (Complex.I * ((absGamma2 P.const (thetaTilde M μ) : ℝ) : ℂ))
      = -((absGamma2 P.const (thetaTilde M μ) : ℝ) : ℂ) by
    rw [← mul_assoc, hI]; ring]

/-- **人手証明 Step 3 の結論**: `det P̌_μ ≠ 0`（`P̌_μ` は可逆）。 -/
theorem det_checkPmat_ne_zero (P : IsingParam) {M : ℕ} (hM : M ≠ 0) (μ : ℤ) :
    (checkPmat P.const M μ).det ≠ 0 := by
  have hMpos : (0 : ℝ) < (M : ℝ) := by exact_mod_cast Nat.pos_of_ne_zero hM
  have hsM : ((Real.sqrt M : ℝ) : ℂ) ≠ 0 := by
    simp only [ne_eq, Complex.ofReal_eq_zero]
    exact Real.sqrt_ne_zero'.2 hMpos
  have hh := gamma2_neg_thetaTilde_ne_zero P hM μ
  have ht : checkT P.const (thetaTilde M μ) ≠ 0 := by
    rw [checkT]
    refine mul_ne_zero Complex.I_ne_zero ?_
    simp only [ne_eq, Complex.ofReal_eq_zero]
    exact ne_of_gt (absGamma2_thetaTilde_pos P hM μ)
  rw [checkPmat_eq_Pmat]
  exact det_Pmat_ne_zero _ _ _ _ ht hsM hh

/-- **人手証明 Step 2**: `A(θ~_μ) P̌_μ = P̌_μ Ď_μ`。 -/
theorem AMat_mul_checkPmat (P : IsingParam) {M : ℕ} (hM : M ≠ 0) (μ : ℤ) :
    AMat P.const (thetaTilde M μ) * checkPmat P.const M μ
      = checkPmat P.const M μ * checkDmat P.const M μ := by
  have hMpos : (0 : ℝ) < (M : ℝ) := by exact_mod_cast Nat.pos_of_ne_zero hM
  have hsM : ((Real.sqrt M : ℝ) : ℂ) ≠ 0 := by
    simp only [ne_eq, Complex.ofReal_eq_zero]
    exact Real.sqrt_ne_zero'.2 hMpos
  have hh := gamma2_neg_thetaTilde_ne_zero P hM μ
  rw [checkPmat_eq_Pmat, checkDmat_eq_Dmat]
  exact AMat_mul_Pmat _ _ _ _ (checkT_sq _ _) hsM hh

/-- **人手証明 `diagonalization_check_P_D`**: `A(θ~_μ) = P̌_μ Ď_μ P̌_μ⁻¹`（**場合分けなし**）。 -/
theorem AMat_thetaTilde_eq_checkPmat_mul_checkDmat_mul_inv
    (P : IsingParam) {M : ℕ} (hM : M ≠ 0) (μ : ℤ) :
    AMat P.const (thetaTilde M μ)
      = checkPmat P.const M μ * checkDmat P.const M μ * (checkPmat P.const M μ)⁻¹ :=
  Abstract.eq_conj_of_mul_eq (AMat_mul_checkPmat P hM μ)
    (isUnit_iff_ne_zero.2 (det_checkPmat_ne_zero P hM μ))

end Ising2D
