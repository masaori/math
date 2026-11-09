/-
# `det A(θ~_μ) = 1` と `γ_1(θ~_μ) > 1`（**具体版**）

対応する人手証明のラベル: `det_A_theta_tilde`, `gamma1_gt_1_theta_tilde`
（`structured-latex/content/eigenvalue_problem_diagonalization_and_exponential_form.ts` の
`Athetatilde_006_claim_det_A`, `Athetatilde_007_claim_gamma1_gt_1`）

**必要十分版**: `Ising2D/NecSuf/GammaDetIdentity.lean`（`Ising2D.NecSuf.gamma_det_identity`。
`det A = 1` は可換環の多項式恒等式である）と
`Ising2D/NecSuf/ArcoshExp.lean`（`gamma1_gt_1_theta_tilde` の準備・背理の鎖・結論の段の
`Ising2D.NecSuf.sq_pos_of_pos_implication_chain`・`sq_le_one_of_le_one_chain`・`one_lt_of_sq_gt_one`）。
導出は `ClaimDetATildeFromNecSuf.lean`。

## 形式化の方針

* 人手証明の Step 0〜Step 6 を 1 つずつ置く。`θ := θ~_μ`、`u := cos θ`、`v := sin θ` は
  `ℂ` へ埋めた `(Real.cos θ : ℂ)`・`(Real.sin θ : ℂ)` で書く（`γ_1, γ_2` が `ℂ` の元として定義されているため）。
  * Step 0: (i)(ii) は `IsingParam.c1_sq_sub_s1_sq`・`IsingParam.c2star_sq_sub_s2star_sq`、
    (iii) は引数 `hdual`。
  * Step 1: `det_AMat_eq_gamma1_sq_add`。
  * Step 2: `exp_I_mul_exp_neg_I_mul`（`exp(iθ)exp(-iθ) = 1`）と `gamma2_mul_gamma2_neg_sin_form`
    （鎖の 3 行目まで）・`gamma2_mul_gamma2_neg_cos_form`（最後の行）。
  * Step 3〜5: `gamma1_sq_add_gamma2_mul_thetaTilde` の中の鎖（Step 3 の 2 式・Step 4 の (iii) による
    `c_2` の消去・Step 5 の (i)(ii)）。
  * Step 6: `lambda_mul_lambda_thetaTilde`。最後の `γ_1^2 = 1 + r^2` は `gamma1R_sq_thetaTilde`。
* **双対関係が要る。** `det A(θ) = 1` は `A(θ)` の定義だけからは出ず、
  (iii) `c_2 s_2^* = c_2^*`（双対関係 `sinh 2K_2 · sinh 2K_2^* = 1` の帰結）が要る。
  人手証明 Step 0 は (iii) を `duality_c2_star_eq_s2_star_c2` として引用している。
  本章の定理は (iii) を引数 `hdual` に取る形のまま置く。
  `IsingParam` の上では (iii) は定理 `IsingParam.c2_mul_s2star_eq_c2star`
  （`EigenvalueProblem/ReductionToATheta/ClaimDualityC2StarEqS2StarC2.lean`）で埋まる。
* `γ_1(θ~_μ) ≥ 1` は `Ising2D.one_le_gamma1R`（**すべての実数 `θ`** で成立。
  人手 `gamma1_lower_bound_all_theta`）として証明済みなので、`gamma1_gt_1_theta_tilde` の準備の第一の含意の鎖（`g ≥ 1 ⟹ g > 0`）はそれで置き換わる。
  本章に固有なのは `g^2` の鎖（`γ_1^2 = 1 + |γ_2|^2 > 1`、`gamma_2_theta_tilde_nonzero` による）と、
  背理の鎖（`0 < g ∧ g ≤ 1 ⟹ g^2 ≤ 1`）と結論の段（`g^2 > 1` と背理の鎖から `g > 1`）である。
-/
import Ising2D.EigenvalueProblem.DiagonalizationAndExponentialForm.ClaimEigenATildeDiag
import Ising2D.NecSuf.GammaDetIdentity
import Ising2D.NecSuf.ArcoshExp
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesProduct
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesSum

namespace Ising2D

variable (P : IsingParam)

/-- (i) `c_1^2 - s_1^2 = 1`（`cosh^2 - sinh^2 = 1`）。 -/
theorem IsingParam.c1_sq_sub_s1_sq : P.const.c1 ^ 2 - P.const.s1 ^ 2 = 1 := by
  simp [IsingParam.const, Real.cosh_sq_sub_sinh_sq]

/-- (ii) `(c_2^*)^2 - (s_2^*)^2 = 1`。 -/
theorem IsingParam.c2star_sq_sub_s2star_sq : P.const.c2star ^ 2 - P.const.s2star ^ 2 = 1 := by
  simp [IsingParam.const, Real.cosh_sq_sub_sinh_sq]

/-- **人手証明 Step 1**: `det A(θ) = γ_1(θ)^2 + γ_2(θ)γ_2(-θ)`。 -/
theorem det_AMat_eq_gamma1_sq_add (K : IsingConst) (θ : ℝ) :
    (AMat K θ).det = gamma1 K θ ^ 2 + gamma2 K θ * gamma2 K (-θ) :=
  calc (AMat K θ).det
      = (!![gamma1 K θ, gamma2 K θ; -gamma2 K (-θ), gamma1 K θ]
          : Matrix (Fin 2) (Fin 2) ℂ).det := by rw [AMat_eq]     -- `def_gamma1_gamma2_of_theta`
    _ = gamma1 K θ * gamma1 K θ - gamma2 K θ * (-gamma2 K (-θ)) :=
        Matrix.det_fin_two_of _ _ _ _                            -- 行列式の定義
    _ = gamma1 K θ ^ 2 + gamma2 K θ * gamma2 K (-θ) := by ring   -- ℂ の積と加法逆元

/-- **人手証明 Step 2 の準備**: `exp(iθ)exp(-iθ) = 1`（`theorem_exp_product` と `theorem_exp_zero`）。 -/
theorem exp_I_mul_exp_neg_I_mul (θ : ℝ) :
    Complex.exp (Complex.I * (θ : ℂ)) * Complex.exp (-(Complex.I * (θ : ℂ))) = 1 :=
  calc Complex.exp (Complex.I * (θ : ℂ)) * Complex.exp (-(Complex.I * (θ : ℂ)))
      = Complex.exp (Complex.I * (θ : ℂ) + -(Complex.I * (θ : ℂ))) :=
        (Complex.exp_add _ _).symm                               -- `theorem_exp_product`
    _ = Complex.exp 0 := by rw [add_neg_cancel]                  -- `iθ + (-iθ) = 0`
    _ = 1 := Complex.exp_zero                                    -- `theorem_exp_zero`

/-- **人手証明 Step 2**（鎖の 3 行目まで）:
`γ_2(θ)γ_2(-θ) = -(s_2^*)^2((c_1u - s_1c_2)^2 + v^2)`。 -/
theorem gamma2_mul_gamma2_neg_sin_form (K : IsingConst) (θ : ℝ) :
    gamma2 K θ * gamma2 K (-θ)
      = -((K.s2star : ℂ) ^ 2 *
          (((K.c1 : ℂ) * (Real.cos θ : ℂ) - (K.s1 : ℂ) * (K.c2 : ℂ)) ^ 2
            + (Real.sin θ : ℂ) ^ 2)) := by
  set u : ℂ := (Real.cos θ : ℂ)
  set v : ℂ := (Real.sin θ : ℂ)
  set a₀ : ℂ := (K.c1 : ℂ) * u - (K.s1 : ℂ) * (K.c2 : ℂ)
  -- `def_gamma1_gamma2_of_theta` の 2 式を `a_0 ∓ iv` の形で書いたもの
  have hplus : gamma2 K θ
      = Complex.I * Complex.exp (Complex.I * (θ : ℂ)) * (K.s2star : ℂ) * (a₀ - Complex.I * v) := by
    rw [gamma2]; ring
  have hminus : gamma2 K (-θ)
      = Complex.I * Complex.exp (-(Complex.I * (θ : ℂ))) * (K.s2star : ℂ) * (a₀ + Complex.I * v) := by
    rw [gamma2_neg]; ring
  calc gamma2 K θ * gamma2 K (-θ)
      = (Complex.I * Complex.I)
          * (Complex.exp (Complex.I * (θ : ℂ)) * Complex.exp (-(Complex.I * (θ : ℂ))))
          * (K.s2star : ℂ) ^ 2 * (a₀ - Complex.I * v) * (a₀ + Complex.I * v) := by
        rw [hplus, hminus]; ring                                  -- 直前の 2 式と積の可換性
    _ = (-1) * 1 * (K.s2star : ℂ) ^ 2 * (a₀ - Complex.I * v) * (a₀ + Complex.I * v) := by
        rw [Complex.I_mul_I, exp_I_mul_exp_neg_I_mul]      -- `i·i = -1` と `exp(iθ)exp(-iθ) = 1`
    _ = -((K.s2star : ℂ) ^ 2 * (a₀ ^ 2 + v ^ 2)) := by
        linear_combination (K.s2star : ℂ) ^ 2 * v ^ 2 * Complex.I_sq  -- `(a_0-iv)(a_0+iv) = a_0^2+v^2`

/-- **人手証明 Step 2**（鎖の最後の行）:
`γ_2(θ)γ_2(-θ) = -(s_2^*)^2((c_1u - s_1c_2)^2 + 1 - u^2)`（`u^2 + v^2 = 1`）。 -/
theorem gamma2_mul_gamma2_neg_cos_form (K : IsingConst) (θ : ℝ) :
    gamma2 K θ * gamma2 K (-θ)
      = -((K.s2star : ℂ) ^ 2 *
          (((K.c1 : ℂ) * (Real.cos θ : ℂ) - (K.s1 : ℂ) * (K.c2 : ℂ)) ^ 2
            + 1 - (Real.cos θ : ℂ) ^ 2)) := by
  have hv : (Real.sin θ : ℂ) ^ 2 = 1 - (Real.cos θ : ℂ) ^ 2 := by
    rw [← Complex.ofReal_pow, ← Complex.ofReal_pow, Real.sin_sq]; push_cast; ring
  rw [gamma2_mul_gamma2_neg_sin_form, hv, add_sub_assoc]

/-- **人手証明 `det_A_theta_tilde` の第 2 式**（Step 3〜Step 5）: `γ_1^2 + γ_2(θ~)γ_2(-θ~) = 1`。 -/
theorem gamma1_sq_add_gamma2_mul_thetaTilde
    (hdual : P.const.c2 * P.const.s2star = P.const.c2star) (M : ℕ) (μ : ℤ) :
    gamma1 P.const (thetaTilde M μ) ^ 2
      + gamma2 P.const (thetaTilde M μ) * gamma2 P.const (-thetaTilde M μ) = 1 := by
  set θ := thetaTilde M μ
  set c₁ : ℂ := (P.const.c1 : ℂ)
  set s₁ : ℂ := (P.const.s1 : ℂ)
  set c₂ : ℂ := (P.const.c2 : ℂ)
  set c₂' : ℂ := (P.const.c2star : ℂ)
  set s₂' : ℂ := (P.const.s2star : ℂ)
  set u : ℂ := (Real.cos θ : ℂ)
  -- Step 0 の (i)(ii)(iii) を ℂ へ埋めたもの
  have H1 : c₁ ^ 2 - s₁ ^ 2 = 1 := by
    rw [← Complex.ofReal_pow, ← Complex.ofReal_pow, ← Complex.ofReal_sub,
      P.c1_sq_sub_s1_sq, Complex.ofReal_one]
  have H2 : c₂' ^ 2 - s₂' ^ 2 = 1 := by
    rw [← Complex.ofReal_pow, ← Complex.ofReal_pow, ← Complex.ofReal_sub,
      P.c2star_sq_sub_s2star_sq, Complex.ofReal_one]
  have H3 : c₂ * s₂' = c₂' := by rw [← Complex.ofReal_mul, hdual]
  -- Step 3: 展開
  have hγ₁ : gamma1 P.const θ ^ 2
      = c₁ ^ 2 * c₂' ^ 2 - 2 * c₁ * c₂' * s₁ * s₂' * u + s₁ ^ 2 * s₂' ^ 2 * u ^ 2 :=
    calc gamma1 P.const θ ^ 2
        = (c₁ * c₂' - s₁ * s₂' * u) ^ 2 := by
          rw [gamma1]; simp only [Complex.ofReal_sub, Complex.ofReal_mul]; rfl  -- 直前の表示の代入
      _ = c₁ ^ 2 * c₂' ^ 2 - 2 * c₁ * c₂' * s₁ * s₂' * u + s₁ ^ 2 * s₂' ^ 2 * u ^ 2 := by
          ring                                                             -- 分配則による展開
  have hγ₂ : gamma2 P.const θ * gamma2 P.const (-θ)
      = -c₁ ^ 2 * s₂' ^ 2 * u ^ 2 + 2 * c₁ * s₁ * c₂ * s₂' ^ 2 * u
          - s₁ ^ 2 * c₂ ^ 2 * s₂' ^ 2 - s₂' ^ 2 + s₂' ^ 2 * u ^ 2 :=
    calc gamma2 P.const θ * gamma2 P.const (-θ)
        = -(s₂' ^ 2 * (c₁ ^ 2 * u ^ 2 - 2 * c₁ * s₁ * c₂ * u + s₁ ^ 2 * c₂ ^ 2 + 1 - u ^ 2)) := by
          rw [gamma2_mul_gamma2_neg_cos_form]; ring   -- Step 2 の最終式で `(c_1u - s_1c_2)^2` を展開
      _ = -c₁ ^ 2 * s₂' ^ 2 * u ^ 2 + 2 * c₁ * s₁ * c₂ * s₂' ^ 2 * u
            - s₁ ^ 2 * c₂ ^ 2 * s₂' ^ 2 - s₂' ^ 2 + s₂' ^ 2 * u ^ 2 := by ring  -- 分配則
  -- Step 4: (iii) による `c_2` の消去
  have h4a : 2 * c₁ * s₁ * c₂ * s₂' ^ 2 * u = 2 * c₁ * s₁ * c₂' * s₂' * u :=
    calc 2 * c₁ * s₁ * c₂ * s₂' ^ 2 * u
        = 2 * c₁ * s₁ * (c₂ * s₂') * s₂' * u := by ring    -- 積の結合律と可換律
      _ = 2 * c₁ * s₁ * c₂' * s₂' * u := by rw [H3]       -- (iii)
  have h4b : s₁ ^ 2 * c₂ ^ 2 * s₂' ^ 2 = s₁ ^ 2 * c₂' ^ 2 :=
    calc s₁ ^ 2 * c₂ ^ 2 * s₂' ^ 2
        = s₁ ^ 2 * (c₂ * s₂') ^ 2 := by ring                -- 積の結合律と可換律
      _ = s₁ ^ 2 * c₂' ^ 2 := by rw [H3]                   -- (iii)
  have H1' : s₁ ^ 2 - c₁ ^ 2 + 1 = 0 := by linear_combination -H1
  calc gamma1 P.const θ ^ 2 + gamma2 P.const θ * gamma2 P.const (-θ)
      = (c₁ ^ 2 * c₂' ^ 2 - 2 * c₁ * c₂' * s₁ * s₂' * u + s₁ ^ 2 * s₂' ^ 2 * u ^ 2)
          + (-c₁ ^ 2 * s₂' ^ 2 * u ^ 2 + 2 * c₁ * s₁ * c₂' * s₂' * u
              - s₁ ^ 2 * c₂' ^ 2 - s₂' ^ 2 + s₂' ^ 2 * u ^ 2) := by
        rw [hγ₁, hγ₂, h4a, h4b]                              -- Step 3 の 2 式と Step 4 の代入
    _ = (c₁ ^ 2 - s₁ ^ 2) * c₂' ^ 2 - s₂' ^ 2 + s₂' ^ 2 * u ^ 2 * (s₁ ^ 2 - c₁ ^ 2 + 1) := by
        ring                                     -- `u` の 1 次の項の相殺と同類項の整理
    -- Step 5: (i)(ii) による結論
    _ = (c₁ ^ 2 - s₁ ^ 2) * c₂' ^ 2 - s₂' ^ 2 + s₂' ^ 2 * u ^ 2 * 0 := by rw [H1']  -- (i)
    _ = 1 * c₂' ^ 2 - s₂' ^ 2 := by rw [H1, mul_zero, add_zero]                     -- (i)
    _ = 1 := by rw [one_mul, H2]                                                    -- (ii)

/-- **人手証明 `det_A_theta_tilde` の第 1 式**: `det A(θ~_μ) = 1`（Step 1 と Step 5）。
仮定 `hdual` は人手証明 Step 0 の (iii) `c_2 s_2^* = c_2^*`（双対関係の帰結）。 -/
theorem det_AMat_thetaTilde_eq_one (hdual : P.const.c2 * P.const.s2star = P.const.c2star)
    (M : ℕ) (μ : ℤ) : (AMat P.const (thetaTilde M μ)).det = 1 := by
  rw [det_AMat_eq_gamma1_sq_add, gamma1_sq_add_gamma2_mul_thetaTilde P hdual M μ]

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
  rw [det_AMat_eq_gamma1_sq_add, gamma2_mul_gamma2_neg_sin_form, gamma1]
  simp only [Complex.ofReal_sub, Complex.ofReal_mul]
  linear_combination
    NecSuf.gamma_det_identity (P.const.c1 : ℂ) (P.const.s1 : ℂ) (P.const.c2 : ℂ)
      (P.const.c2star : ℂ) (P.const.s2star : ℂ) (Real.cos θ : ℂ) (Real.sin θ : ℂ)
      HPy H1 H2 H3

/-- **人手証明 Step 6**: `λ_{+,μ} λ_{-,μ} = 1`（`det_A_theta_tilde` の第 3 式）。 -/
theorem lambda_mul_lambda_thetaTilde (hdual : P.const.c2 * P.const.s2star = P.const.c2star)
    (M : ℕ) (μ : ℤ) :
    lambdaPlusR P.const (thetaTilde M μ) * lambdaMinusR P.const (thetaTilde M μ) = 1 := by
  set θ := thetaTilde M μ
  set r : ℂ := ((absGamma2 P.const θ : ℝ) : ℂ)
  have hC : ((lambdaPlusR P.const θ * lambdaMinusR P.const θ : ℝ) : ℂ) = ((1 : ℝ) : ℂ) :=
    calc ((lambdaPlusR P.const θ * lambdaMinusR P.const θ : ℝ) : ℂ)
        = (gamma1 P.const θ + r) * (gamma1 P.const θ - r) := by
          rw [Complex.ofReal_mul, lambdaPlusR_ofReal, lambdaMinusR_ofReal]  -- `eigenvector_of_A_theta_tilde`
      _ = gamma1 P.const θ ^ 2 - r ^ 2 := by ring                          -- 分配則による平方差
      _ = gamma1 P.const θ ^ 2 + gamma2 P.const θ * gamma2 P.const (-θ) := by
          rw [gamma2_mul_gamma2_neg_eq_neg_absGamma2_sq, ← sub_eq_add_neg]  -- `ab = -r^2`
      _ = 1 := gamma1_sq_add_gamma2_mul_thetaTilde P hdual M μ              -- Step 5
      _ = ((1 : ℝ) : ℂ) := Complex.ofReal_one.symm
  exact Complex.ofReal_injective hC

/-- **人手証明 `det_A_theta_tilde` の最後の式**: `γ_1(θ~_μ)^2 = 1 + |γ_2(θ~_μ)|^2`（実数の等式）。

人手の「まず ℂ の中で」の 13 行の鎖と 1 対 1 の `calc` で `((γ_1^2 : ℝ) : ℂ) = ((1 + r^2 : ℝ) : ℂ)` を示し、
`inclusion_rr_to_cc` の対の第 1 成分の比較（`Complex.ofReal_injective`）で ℝ の等式に戻す。
人手が像の記号を省く第 6〜8 行（左辺だけの行を第 1 行と数える）の `r^2` は `((r : ℂ))^2`（`r_ℂ` の ℂ の冪）である。
第 7 行の `relation_of_gamma_2_theta_tilde` (2) は、`γ_2(θ)γ_2(-θ) = -((r : ℂ))^2` の形の
`gamma2_mul_gamma2_neg_eq_neg_absGamma2_sq` で受ける。 -/
theorem gamma1R_sq_thetaTilde (hdual : P.const.c2 * P.const.s2star = P.const.c2star)
    (M : ℕ) (μ : ℤ) :
    gamma1R P.const (thetaTilde M μ) ^ 2 = 1 + absGamma2 P.const (thetaTilde M μ) ^ 2 := by
  set θ := thetaTilde M μ
  set g : ℝ := gamma1R P.const θ
  set r : ℝ := absGamma2 P.const θ
  have hg : gamma1 P.const θ = (g : ℂ) := gamma1_eq_ofReal P.const θ
  have hsecond : (g : ℂ) ^ 2 + gamma2 P.const θ * gamma2 P.const (-θ) = 1 := by
    rw [← hg]; exact gamma1_sq_add_gamma2_mul_thetaTilde P hdual M μ
  have hC : ((g ^ 2 : ℝ) : ℂ) = ((1 + r ^ 2 : ℝ) : ℂ) :=
    calc ((g ^ 2 : ℝ) : ℂ)
        = ((g * g : ℝ) : ℂ) := by rw [square_of_real_number_is_product g]
                          -- `square_of_real_number_is_product`（`r → γ_1(θ)`）
      _ = (g : ℂ) * (g : ℂ) := Complex.ofReal_mul g g
                          -- `real_inclusion_preserves_product`
      _ = (g : ℂ) ^ 2 := (sq (g : ℂ)).symm
                          -- `def_power_of_complex_number` より `zz = z^2`
      _ = (g : ℂ) ^ 2 + 0 := (add_zero _).symm
                          -- `complex_numbers_form_a_field` の零元
      _ = (g : ℂ) ^ 2 + (-((r : ℂ)) ^ 2 + (r : ℂ) ^ 2) := by rw [neg_add_cancel]
                          -- `complex_numbers_form_a_field` の加法逆元
      _ = (g : ℂ) ^ 2 + (gamma2 P.const θ * gamma2 P.const (-θ) + (r : ℂ) ^ 2) := by
          rw [gamma2_mul_gamma2_neg_eq_neg_absGamma2_sq]
                          -- `relation_of_gamma_2_theta_tilde` (2)
      _ = ((g : ℂ) ^ 2 + gamma2 P.const θ * gamma2 P.const (-θ)) + (r : ℂ) ^ 2 :=
          (add_assoc _ _ _).symm
                          -- `complex_numbers_form_a_field` の和の結合律
      _ = 1 + (r : ℂ) ^ 2 := by rw [hsecond]
                          -- 上の第 2 の等式の鎖（`gamma1_sq_add_gamma2_mul_thetaTilde`）
      _ = 1 + (r : ℂ) * (r : ℂ) := by rw [sq (r : ℂ)]
                          -- `def_power_of_complex_number` より `z^2 = zz`
      _ = 1 + ((r * r : ℝ) : ℂ) := by rw [real_inclusion_mul r r]
                          -- `real_inclusion_preserves_product`
      _ = ((1 + r * r : ℝ) : ℂ) := real_inclusion_add 1 (r * r)
                          -- `real_inclusion_preserves_finite_sum` を `m = 2` で（2 項の場合の `real_inclusion_preserves_sum`）
      _ = ((1 + r ^ 2 : ℝ) : ℂ) := by rw [square_of_real_number_is_product r]
                          -- `square_of_real_number_is_product`（`r → |γ_2(θ)|`）を右辺から左辺へ
  exact Complex.ofReal_injective hC

/-! ## `γ_1(θ~_μ) > 1`（人手証明 `gamma1_gt_1_theta_tilde`）

人手証明の準備の 2 本の含意の鎖のうち、第一の鎖の `g > 0` は `one_le_gamma1R`（人手 `gamma1_lower_bound_all_theta`）と
`0 < 1` から（`one_lt_gamma1R_thetaTilde` の冒頭）、第二の鎖の `γ_2 ≠ 0 ⟹ r ≠ 0 ⟹ r > 0` は `absGamma2_thetaTilde_pos`、
続く `r·r > 0·r ⟹ r·r > 0 ⟹ r^2 > 0` は `gamma1_gt_1_prep_absGamma2_sq_pos` である。
`g^2` の鎖は `one_lt_gamma1R_sq_thetaTilde`、背理の鎖は `gamma1R_thetaTilde_sq_le_one_of_le_one`、
結論の段は `one_lt_gamma1R_thetaTilde` である。 -/

/-- **人手証明 `gamma1_gt_1_theta_tilde` の準備の第二の含意の鎖の後半**: `r > 0` から `r^2 > 0`
（人手の 3 行 `r·r > 0·r`・`r·r > 0`・`r^2 > 0` と 1 対 1）。 -/
theorem gamma1_gt_1_prep_absGamma2_sq_pos {M : ℕ} (hM : M ≠ 0) (μ : ℤ) :
    0 < absGamma2 P.const (thetaTilde M μ) ^ 2 := by
  have hr := absGamma2_thetaTilde_pos P hM μ                 -- 準備の `r > 0`
  have h1 : 0 * absGamma2 P.const (thetaTilde M μ)
      < absGamma2 P.const (thetaTilde M μ) * absGamma2 P.const (thetaTilde M μ) :=
    mul_lt_mul_of_pos_right hr hr                             -- `r > 0` の両辺に `0 < r` を掛ける
  have h2 : 0 < absGamma2 P.const (thetaTilde M μ) * absGamma2 P.const (thetaTilde M μ) := by
    rw [zero_mul] at h1; exact h1                             -- `0·r = 0`
  rw [square_of_real_number_is_product]; exact h2
                          -- `square_of_real_number_is_product`（`r → |γ_2(θ)|`）を右辺から左辺へ

/-- **人手証明 `gamma1_gt_1_theta_tilde` の `g^2` の鎖**: `γ_1(θ~_μ)^2 > 1`（人手の 3 行と 1 対 1 の `calc`）。 -/
theorem one_lt_gamma1R_sq_thetaTilde (hdual : P.const.c2 * P.const.s2star = P.const.c2star)
    {M : ℕ} (hM : M ≠ 0) (μ : ℤ) : 1 < gamma1R P.const (thetaTilde M μ) ^ 2 := by
  have hr2 := gamma1_gt_1_prep_absGamma2_sq_pos P hM μ  -- 準備の `r^2 > 0`
  calc gamma1R P.const (thetaTilde M μ) ^ 2
      = 1 + absGamma2 P.const (thetaTilde M μ) ^ 2 := gamma1R_sq_thetaTilde P hdual M μ
                          -- `det_A_theta_tilde`（`γ_1(θ~_μ)^2 = 1 + |γ_2(θ~_μ)|^2`）
    _ > 1 + 0 := (add_lt_add_iff_left 1).2 hr2
                          -- 準備の `r^2 > 0` の両辺に `1` を加える
    _ = 1 := add_zero 1                                 -- `0` は加法の単位元

/-- **人手証明 `gamma1_gt_1_theta_tilde` の背理の鎖**: `g > 0` かつ `g ≤ 1` なら `g^2 ≤ 1`
（人手の 4 行と 1 対 1 の `calc`）。 -/
theorem gamma1R_thetaTilde_sq_le_one_of_le_one (M : ℕ) (μ : ℤ)
    (hg0 : 0 < gamma1R P.const (thetaTilde M μ)) (h : gamma1R P.const (thetaTilde M μ) ≤ 1) :
    gamma1R P.const (thetaTilde M μ) ^ 2 ≤ 1 :=
  calc gamma1R P.const (thetaTilde M μ) ^ 2
      = gamma1R P.const (thetaTilde M μ) * gamma1R P.const (thetaTilde M μ) :=
        square_of_real_number_is_product _
                          -- `square_of_real_number_is_product`（`r → g`）
    _ ≤ 1 * gamma1R P.const (thetaTilde M μ) := mul_le_mul_of_nonneg_right h hg0.le
                          -- `g ≤ 1` の両辺に準備の `0 < g` を掛ける
    _ ≤ 1 * 1 := mul_le_mul_of_nonneg_left h zero_le_one
                          -- `g ≤ 1` の両辺に `0 < 1` を掛ける（`≤` の単調性には `0 ≤ 1` で足りる）
    _ = 1 := mul_one 1
                          -- `1` は乗法の単位元

/-- **人手証明 `gamma1_gt_1_theta_tilde`**: `γ_1(θ~_μ) > 1`（**狭義**）。

`g ≤ 1` を仮定すると、`g^2` の鎖と背理の鎖から `1 < g^2 ≤ 1`、すなわち `1 < 1` となり ℝ の順序に矛盾する。
ℝ の順序は全順序なので `g > 1`（人手の結論の段）。必要十分版からの導出は
`ClaimDetATildeFromNecSuf.lean` の `one_lt_gamma1R_thetaTilde_of_necSuf`。

008 章（整数運動量）では `γ_1(θ_μ) ≥ 1` しか言えず、臨界点の `θ_μ = 0` で等号が起こる。 -/
theorem one_lt_gamma1R_thetaTilde (hdual : P.const.c2 * P.const.s2star = P.const.c2star)
    {M : ℕ} (hM : M ≠ 0) (μ : ℤ) : 1 < gamma1R P.const (thetaTilde M μ) := by
  have hg0 : 0 < gamma1R P.const (thetaTilde M μ) :=
    lt_of_lt_of_le one_pos (one_le_gamma1R P (thetaTilde M μ))   -- 準備の `g ≥ 1` と `1 > 0` に推移律
  exact lt_of_not_ge fun hle =>
    lt_irrefl (1 : ℝ) (lt_of_lt_of_le (one_lt_gamma1R_sq_thetaTilde P hdual hM μ)
      (gamma1R_thetaTilde_sq_le_one_of_le_one P M μ hg0 hle))

/-- 人手証明が併記している `γ_1(θ~_μ) ≥ 1`（012 章の `one_le_gamma1R` の特殊化でもある）。 -/
theorem one_le_gamma1R_thetaTilde (M : ℕ) (μ : ℤ) : 1 ≤ gamma1R P.const (thetaTilde M μ) :=
  one_le_gamma1R P (thetaTilde M μ)

end Ising2D
