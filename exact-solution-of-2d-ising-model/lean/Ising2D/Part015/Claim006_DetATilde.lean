/-
# `det A(θ~_μ) = 1` と `γ_1(θ~_μ) > 1`（**具体版**）

対応する人手証明のラベル: `det_A_theta_tilde`, `gamma1_gt_1_theta_tilde`
（`structured-latex/content/015_A_theta_tilde_diagonalization.ts` の
`Athetatilde_006_claim_det_A`, `Athetatilde_007_claim_gamma1_gt_1`）

**必要十分版**: `Ising2D/NecSuf/GammaDetIdentity.lean`（`Ising2D.NecSuf.gamma_det_identity`。
`det A = 1` は可換環の多項式恒等式である）と
`Ising2D/NecSuf/ArcoshExp.lean`（`Ising2D.NecSuf.one_lt_of_sq_gt_one`）。

## 形式化の方針

* 人手証明も「008 章 `det_A_theta` の証明と同じ計算であり、`θ` が整数運動量であることを
  どこにも使っていない」と明記している。Lean 側でも既存の `Ising2D.det_AMat_eq_one`
  （`Part008/Claim027_EigenATheta.lean`、任意の `θ ∈ ℝ`）に `θ := θ~_μ` を代入するだけでよい。
* **双対関係が要る点は 008 章と同じ。** `det A(θ) = 1` は `A(θ)` の定義だけからは出ず、
  (iii) `c_2 s_2^* = c_2^*`（双対関係 `sinh 2K_2 · sinh 2K_2^* = 1` の帰結）が要る。
  人手証明 Step 0 は (iii) を `duality_c2_star_eq_s2_star_c2` として引用している。
  `Ising2D.IsingParam` は `K_1, K_2, K_2^*` を独立な正数として持つだけなので、
  (iii) は仮定 `hdual` として明示する（`Part008/Definition016_TV.lean` と同じ扱い）。
  (i) `c_1^2 - s_1^2 = 1`、(ii) `(c_2^*)^2 - (s_2^*)^2 = 1` は
  `IsingParam.const` の定義（`cosh`/`sinh`）から自動的に従う。
* `γ_1(θ~_μ) ≥ 1` は既に 012 章の `Ising2D.one_le_gamma1R`（**すべての実数 `θ`** で成立）
  として証明済みなので、人手証明 Step 1（`γ_1 > 0`）はそれで置き換わる。
  本章に固有なのは Step 2（`γ_1^2 = 1 + |γ_2|^2 > 1`、`gamma_2_theta_tilde_nonzero` による）と
  Step 3（`t > 0 ∧ t^2 > 1 ⟹ t > 1`）である。
-/
import Ising2D.Part015.Claim004_EigenATildeDiag
import Ising2D.NecSuf.GammaDetIdentity
import Ising2D.NecSuf.ArcoshExp

namespace Ising2D

variable (P : IsingParam)

/-- (i) `c_1^2 - s_1^2 = 1`（`cosh^2 - sinh^2 = 1`）。 -/
theorem IsingParam.c1_sq_sub_s1_sq : P.const.c1 ^ 2 - P.const.s1 ^ 2 = 1 := by
  simp [IsingParam.const, Real.cosh_sq_sub_sinh_sq]

/-- (ii) `(c_2^*)^2 - (s_2^*)^2 = 1`。 -/
theorem IsingParam.c2star_sq_sub_s2star_sq : P.const.c2star ^ 2 - P.const.s2star ^ 2 = 1 := by
  simp [IsingParam.const, Real.cosh_sq_sub_sinh_sq]

/-- **人手証明 `det_A_theta_tilde` の第 1 式**: `det A(θ~_μ) = 1`。
仮定 `hdual` は人手証明 Step 0 の (iii) `c_2 s_2^* = c_2^*`（双対関係の帰結）。 -/
theorem det_AMat_thetaTilde_eq_one (hdual : P.const.c2 * P.const.s2star = P.const.c2star)
    (M : ℕ) (μ : ℤ) : (AMat P.const (thetaTilde M μ)).det = 1 :=
  det_AMat_eq_one P.const (thetaTilde M μ) P.c1_sq_sub_s1_sq P.c2star_sq_sub_s2star_sq hdual

/-- **必要十分版からの導出**（同じ主張の別証明）: `det A(θ~_μ) = 1` は
`NecSuf.gamma_det_identity`（任意の可換環の多項式恒等式）を ℂ に特殊化したものである。 -/
theorem det_AMat_thetaTilde_eq_one_of_necSuf
    (hdual : P.const.c2 * P.const.s2star = P.const.c2star) (M : ℕ) (μ : ℤ) :
    (AMat P.const (thetaTilde M μ)).det = 1 := by
  set θ := thetaTilde M μ with hθ
  have H1 : (P.const.c1 : ℂ) ^ 2 - (P.const.s1 : ℂ) ^ 2 = 1 := by
    rw [← Complex.ofReal_pow, ← Complex.ofReal_pow, ← Complex.ofReal_sub,
      P.c1_sq_sub_s1_sq, Complex.ofReal_one]
  have H2 : (P.const.c2star : ℂ) ^ 2 - (P.const.s2star : ℂ) ^ 2 = 1 := by
    rw [← Complex.ofReal_pow, ← Complex.ofReal_pow, ← Complex.ofReal_sub,
      P.c2star_sq_sub_s2star_sq, Complex.ofReal_one]
  have H3 : (P.const.c2 : ℂ) * (P.const.s2star : ℂ) = (P.const.c2star : ℂ) := by
    rw [← Complex.ofReal_mul, hdual]
  have HPy : (Real.cos θ : ℂ) ^ 2 + (Real.sin θ : ℂ) ^ 2 = 1 := by
    rw [← Complex.ofReal_pow, ← Complex.ofReal_pow, ← Complex.ofReal_add,
      Real.cos_sq_add_sin_sq, Complex.ofReal_one]
  rw [det_AMat, gamma2_mul_gamma2_neg, gamma1]
  simp only [Complex.ofReal_sub, Complex.ofReal_mul]
  linear_combination
    NecSuf.gamma_det_identity (P.const.c1 : ℂ) (P.const.s1 : ℂ) (P.const.c2 : ℂ)
      (P.const.c2star : ℂ) (P.const.s2star : ℂ) (Real.cos θ : ℂ) (Real.sin θ : ℂ)
      HPy H1 H2 H3

/-- **人手証明 `det_A_theta_tilde` の第 2 式**: `γ_1^2 + γ_2(θ~)γ_2(-θ~) = 1`。 -/
theorem gamma1_sq_add_gamma2_mul_thetaTilde
    (hdual : P.const.c2 * P.const.s2star = P.const.c2star) (M : ℕ) (μ : ℤ) :
    gamma1 P.const (thetaTilde M μ) ^ 2
      + gamma2 P.const (thetaTilde M μ) * gamma2 P.const (-thetaTilde M μ) = 1 := by
  have h := det_AMat_thetaTilde_eq_one P hdual M μ
  rwa [det_AMat] at h

/-- **人手証明 `det_A_theta_tilde` の最後の式**: `γ_1(θ~_μ)^2 = 1 + |γ_2(θ~_μ)|^2`（実数の等式）。 -/
theorem gamma1R_sq_thetaTilde (hdual : P.const.c2 * P.const.s2star = P.const.c2star)
    (M : ℕ) (μ : ℤ) :
    gamma1R P.const (thetaTilde M μ) ^ 2 = 1 + absGamma2 P.const (thetaTilde M μ) ^ 2 := by
  have h := gamma1_sq_add_gamma2_mul_thetaTilde P hdual M μ
  rw [gamma2_mul_gamma2_neg_eq_neg_absSq, gamma1_eq_ofReal] at h
  have hC : ((gamma1R P.const (thetaTilde M μ) ^ 2
      - absGamma2 P.const (thetaTilde M μ) ^ 2 : ℝ) : ℂ) = ((1 : ℝ) : ℂ) := by
    push_cast
    push_cast at h
    linear_combination h
  have := Complex.ofReal_injective hC
  linarith [this]

/-- **人手証明 `det_A_theta_tilde` の第 3 式**: `λ_{+,μ} λ_{-,μ} = 1`。 -/
theorem lambda_mul_lambda_thetaTilde (hdual : P.const.c2 * P.const.s2star = P.const.c2star)
    (M : ℕ) (μ : ℤ) :
    lambdaPlusR P.const (thetaTilde M μ) * lambdaMinusR P.const (thetaTilde M μ) = 1 := by
  have h := gamma1R_sq_thetaTilde P hdual M μ
  rw [lambdaPlusR, lambdaMinusR]
  nlinarith [h]

/-! ## `γ_1(θ~_μ) > 1`（人手証明 `gamma1_gt_1_theta_tilde`） -/

/-- **人手証明 Step 2**: `γ_1(θ~_μ)^2 > 1`（`|γ_2(θ~_μ)| > 0` による）。 -/
theorem one_lt_gamma1R_sq_thetaTilde (hdual : P.const.c2 * P.const.s2star = P.const.c2star)
    {M : ℕ} (hM : M ≠ 0) (μ : ℤ) : 1 < gamma1R P.const (thetaTilde M μ) ^ 2 := by
  have h := gamma1R_sq_thetaTilde P hdual M μ
  have hr := absGamma2_thetaTilde_pos P hM μ
  nlinarith [h, hr]

/-- **人手証明 `gamma1_gt_1_theta_tilde`**: `γ_1(θ~_μ) > 1`（**狭義**）。

008 章（整数運動量）では `γ_1(θ_μ) ≥ 1` しか言えず、臨界点の `θ_μ = 0` で等号が起こる。 -/
theorem one_lt_gamma1R_thetaTilde (hdual : P.const.c2 * P.const.s2star = P.const.c2star)
    {M : ℕ} (hM : M ≠ 0) (μ : ℤ) : 1 < gamma1R P.const (thetaTilde M μ) :=
  NecSuf.one_lt_of_sq_gt_one
    (lt_of_lt_of_le one_pos (one_le_gamma1R P (thetaTilde M μ)))
    (one_lt_gamma1R_sq_thetaTilde P hdual hM μ)

/-- 人手証明が併記している `γ_1(θ~_μ) ≥ 1`（012 章の `one_le_gamma1R` の特殊化でもある）。 -/
theorem one_le_gamma1R_thetaTilde (M : ℕ) (μ : ℤ) : 1 ≤ gamma1R P.const (thetaTilde M μ) :=
  one_le_gamma1R P (thetaTilde M μ)

end Ising2D
