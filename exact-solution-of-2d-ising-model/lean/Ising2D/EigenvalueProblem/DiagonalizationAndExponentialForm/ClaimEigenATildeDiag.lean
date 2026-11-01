/-
# `A(θ~_μ)` の固有値・固有ベクトルと対角化 `A = P̌ Ď P̌⁻¹`（**具体版**）

対応する人手証明のラベル: `eigenvector_of_A_theta_tilde`, `diagonalization_check_P_D`
（`structured-latex/content/eigenvalue_problem_diagonalization_and_exponential_form.ts` の
`Athetatilde_004_claim_eigenvector`, `Athetatilde_005_claim_diagonalization`）

**必要十分版**: `Ising2D/NecSuf/TwoByTwoSkew.lean`。各段との対応はそのファイルの冒頭に書き、
具体版をその特殊化として導く定理（`*_of_necSuf`）は `ClaimEigenATildeDiagFromNecSuf.lean` に置く。

## 人手証明との対応

人手証明の略記 `g_1 := γ_1(θ)`、`a := γ_2(θ)`、`b := γ_2(-θ)`、`r := |a|` をそのまま使う
（`r` は `absGamma2 K θ`）。根拠に引く `relation_of_gamma_2_theta_tilde` (1) の `b = -ā` は
`gamma2_neg_eq_neg_conj`（その `θ := θ~_μ` への特殊化が (1) の形式化 `gamma2_neg_thetaTilde_eq`。
本ファイルの Step 1・Step 2 の定理は任意の実数 `θ` について述べるので、特殊化する前の定理を引く）、
(2) の `ab = -r^2` は `gamma2_mul_gamma2_neg_eq_neg_absGamma2_sq`（(2) の形式化
`gamma2_mul_gamma2_neg_eq_neg_absSq` の `r^2` の置き方を変えた言い換え）、
`abs_basic_properties` の `a ā = r^2` は `gamma2_mul_conj_eq_absGamma2_sq` である。

各箇条の［］内は、同じ段の必要十分版（`Ising2D.NecSuf.` を省く）である。

* `eigenvector_of_A_theta_tilde` Step 1: 準備の因数分解の恒等式 `factor_identity_thetaTilde`［`skew2_factor_identity`］と、
  `det(A(θ) - λI)` の鎖 `charPoly_factor_thetaTilde`［`skew2_charPoly`・`skew2_charPoly_factor`］、零因子が無いことによる
  `det_AMat_sub_smul_eq_zero_iff`［`skew2_det_eq_zero_iff`］、固有値が `λ_{±,μ}` に限るという statement の主張
  `eigenvalue_AMat_iff`（固有値の定義 `def_eigenvalue` から `det(A(θ) - λI) = 0` までの同値の鎖。最後の段は
  `MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimNonzeroKernelIffDetZeroTwoByTwo.lean` の
  `exists_ne_zero_mulVec_eq_zero_iff_det_fin_two`（人手 `nonzero_kernel_iff_det_zero_two_by_two`））［`skew2_eigenvalue_iff`］、
  `λ_+ ≠ λ_-` の `lambdaPlusR_ne_lambdaMinusR`［`skew2_eigenvalues_ne`］。
* `eigenvector_of_A_theta_tilde` の statement の「`c v_{±,μ}`（`c ∈ ℂ^×`）は固有ベクトル」:
  `isEigenvector_smul_eigen_pos`・`isEigenvector_smul_eigen_neg`。
* `eigenvector_of_A_theta_tilde` Step 2: 成分ごとの鎖 `AMat_mulVec_eigen_pos`・`AMat_mulVec_eigen_neg`
  （第 1 成分は `b = -ā` と `a ā = r^2`、第 2 成分は `-b = ā` による）［`skew2_mulVec_pos`・`skew2_mulVec_neg`。
  第 1 成分は合成 `ab = -s^2` の 1 段、第 2 成分は仮定なし］、`v_± ≠ 0` の
  `eigenvector_pos_ne_zero`・`eigenvector_neg_ne_zero`［置かない］、`c ∈ ℂ^×` 倍の鎖
  `AMat_mulVec_smul_eigen_pos`・`AMat_mulVec_smul_eigen_neg`［`mulVec_smul_of_mulVec_eq`］。
* `diagonalization_check_P_D` Step 1: `√M ≠ 0` は `def_check_fermi` と同じ `√M`（`sqrtM`）についての
  `sqrtM_ne_zero`（`DefinitionCheckFermi.lean`）を引く［置かない］。`P̌_μ`・`c` もこの `sqrtM` で書く。
* `diagonalization_check_P_D` Step 2: 第 2 成分の約分 `checkC_mul_b`、列が `v_{±,μ}` に一致すること
  `checkPmat_col_pos`・`checkPmat_col_neg`［置かない。`c` の具体形の確認］、列ごとに見た `A P̌ = P̌ Ď` の
  `AMat_mul_checkPmat`［`skew2_mul_of_cols`］。
* `diagonalization_check_P_D` Step 3: `det P̌` の鎖 `det_checkPmat` と `det_checkPmat_ne_zero`［`det_of_cols`・`det_of_cols_ne_zero`］。
* `diagonalization_check_P_D` Step 4: 右から `P̌⁻¹` を掛ける鎖
  `AMat_thetaTilde_eq_checkPmat_mul_checkDmat_mul_inv`［`eq_conj_of_mul_eq`］。
* 人手証明にあった Step 3（固有空間が 1 次元で、固有ベクトルは `v_{±,μ}` の `ℂ^×` 倍に限ること）は後段で使われないので、
  本文から参照用ノート `claims_unused_by_chapter_goals_not_adopted` へ退避されている。形式化していない。

人手証明と同じく `γ_2 = 0` の場合分けは無い。`gamma_2_theta_tilde_nonzero`
（`Ising2D.gamma2_thetaTilde_ne_zero`）が無条件だからである。
-/
import Ising2D.EigenvalueProblem.DiagonalizationAndExponentialForm.ClaimRelationGamma2Tilde
import Ising2D.EigenvalueProblem.DiagonalizationAndExponentialForm.DefinitionCheckFermi
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimNonzeroKernelIffDetZeroTwoByTwo

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

/-- `abs_basic_properties` の `a ā = |a|^2`（`a := γ_2(θ)`、`r := |a|`）。 -/
theorem gamma2_mul_conj_eq_absGamma2_sq :
    gamma2 K θ * (starRingEnd ℂ) (gamma2 K θ) = ((absGamma2 K θ : ℝ) : ℂ) ^ 2 := by
  rw [Complex.mul_conj, ← Complex.ofReal_pow, absGamma2_sq]

/-- `relation_of_gamma_2_theta_tilde` (2) を `ab = -r^2` の形で書いたもの。 -/
theorem gamma2_mul_gamma2_neg_eq_neg_absGamma2_sq :
    gamma2 K θ * gamma2 K (-θ) = -((absGamma2 K θ : ℝ) : ℂ) ^ 2 := by
  rw [gamma2_mul_gamma2_neg_eq_neg_absSq, Complex.ofReal_pow]

/-- **人手証明 Step 1 の準備**: 因数分解の恒等式
`(λ - (g_1+r))(λ - (g_1-r)) = λ^2 - 2g_1λ + (g_1^2 - r^2)`。 -/
theorem factor_identity_thetaTilde (g₁ r lam : ℂ) :
    (lam - (g₁ + r)) * (lam - (g₁ - r)) = lam ^ 2 - 2 * g₁ * lam + (g₁ ^ 2 - r ^ 2) :=
  calc (lam - (g₁ + r)) * (lam - (g₁ - r))
      = lam ^ 2 - (g₁ - r) * lam - (g₁ + r) * lam + (g₁ + r) * (g₁ - r) := by ring  -- 分配則
    _ = lam ^ 2 - 2 * g₁ * lam + (g₁ + r) * (g₁ - r) := by ring                       -- 同類項の統合
    _ = lam ^ 2 - 2 * g₁ * lam + (g₁ ^ 2 - g₁ * r + r * g₁ - r ^ 2) := by ring        -- 分配則
    _ = lam ^ 2 - 2 * g₁ * lam + (g₁ ^ 2 - r ^ 2) := by ring                           -- 可換則と加法逆元

/-- **人手証明 Step 1**: `det(A(θ) - λI) = (λ - λ_{+,μ})(λ - λ_{-,μ})`。 -/
theorem charPoly_factor_thetaTilde (lam : ℂ) :
    (AMat K θ - lam • (1 : Matrix (Fin 2) (Fin 2) ℂ)).det
      = (lam - ((lambdaPlusR K θ : ℝ) : ℂ)) * (lam - ((lambdaMinusR K θ : ℝ) : ℂ)) := by
  set g₁ := gamma1 K θ with hg₁
  set a := gamma2 K θ with ha
  set b := gamma2 K (-θ) with hb₀
  set r : ℂ := ((absGamma2 K θ : ℝ) : ℂ)
  have hab : a * b = -r ^ 2 := gamma2_mul_gamma2_neg_eq_neg_absGamma2_sq K θ
  rw [lambdaPlusR_ofReal, lambdaMinusR_ofReal]
  calc (AMat K θ - lam • (1 : Matrix (Fin 2) (Fin 2) ℂ)).det
      = (!![g₁ - lam, a; -b, g₁ - lam] : Matrix (Fin 2) (Fin 2) ℂ).det := by
        -- `def_gamma1_gamma2_of_theta`
        rw [AMat_eq]
        congr 1
        ext i j
        fin_cases i <;> fin_cases j <;> simp <;> rfl
    _ = (g₁ - lam) * (g₁ - lam) - a * (-b) := Matrix.det_fin_two_of _ _ _ _  -- 行列式の定義
    _ = (g₁ - lam) * (g₁ - lam) + a * b := by ring                           -- ℂ の四則
    _ = g₁ ^ 2 - g₁ * lam - lam * g₁ + lam ^ 2 + a * b := by ring              -- 分配則
    _ = g₁ ^ 2 - g₁ * lam - g₁ * lam + lam ^ 2 + a * b := by ring              -- 乗法の可換則
    _ = g₁ ^ 2 - 2 * g₁ * lam + lam ^ 2 + a * b := by ring                     -- 同類項の統合
    _ = lam ^ 2 - 2 * g₁ * lam + (g₁ ^ 2 + a * b) := by ring                   -- 加法の交換則と結合則
    _ = lam ^ 2 - 2 * g₁ * lam + (g₁ ^ 2 - r ^ 2) := by rw [hab, ← sub_eq_add_neg]  -- `ab = -r^2`
    _ = (lam - (g₁ + r)) * (lam - (g₁ - r)) :=
        (factor_identity_thetaTilde g₁ r lam).symm                             -- 準備の恒等式

/-- **人手証明 Step 1 の結論**: `det(A(θ) - λI) = 0` となるのは
`λ = λ_{±,μ}` のときに限る（`ℂ` が零因子を持たないこと）。 -/
theorem det_AMat_sub_smul_eq_zero_iff (lam : ℂ) :
    (AMat K θ - lam • (1 : Matrix (Fin 2) (Fin 2) ℂ)).det = 0
      ↔ lam = ((lambdaPlusR K θ : ℝ) : ℂ) ∨ lam = ((lambdaMinusR K θ : ℝ) : ℂ) := by
  rw [charPoly_factor_thetaTilde, mul_eq_zero, sub_eq_zero, sub_eq_zero]

/-- **人手証明 Step 1 の主張**（statement の「`A(θ~_μ)` の固有値は `λ_{±,μ}` の 2 つ」）:
`λ ∈ ℂ` が `A(θ)` の固有値（`def_eigenvalue`）であるのは `λ = λ_{±,μ}` のときに限る。

人手証明 Step 1 の同値の鎖を 1 行ずつ辿り、最後に `det_AMat_sub_smul_eq_zero_iff` で `λ = λ_{±,μ}` へ着く。 -/
theorem eigenvalue_AMat_iff (lam : ℂ) :
    IsEigenvalue (AMat K θ) lam
      ↔ lam = ((lambdaPlusR K θ : ℝ) : ℂ) ∨ lam = ((lambdaMinusR K θ : ℝ) : ℂ) :=
  calc IsEigenvalue (AMat K θ) lam
      ↔ ∃ v : Fin 2 → ℂ, v ≠ 0 ∧ AMat K θ *ᵥ v = lam • v := Iff.rfl  -- `def_eigenvalue`
    _ ↔ ∃ v : Fin 2 → ℂ, v ≠ 0 ∧ AMat K θ *ᵥ v - lam • v = 0 := by
        simp only [sub_eq_zero]                                         -- 移項
    _ ↔ ∃ v : Fin 2 → ℂ, v ≠ 0 ∧ AMat K θ *ᵥ v - lam • ((1 : Matrix (Fin 2) (Fin 2) ℂ) *ᵥ v) = 0 := by
        simp only [Matrix.one_mulVec]                                   -- 単位行列の性質 `Iv = v`
    _ ↔ ∃ v : Fin 2 → ℂ, v ≠ 0 ∧ AMat K θ *ᵥ v - (lam • (1 : Matrix (Fin 2) (Fin 2) ℂ)) *ᵥ v = 0 := by
        simp only [Matrix.smul_mulVec]                                  -- スカラー倍の括り出し `λ(Iv) = (λI)v`
    _ ↔ ∃ v : Fin 2 → ℂ, v ≠ 0 ∧ (AMat K θ - lam • (1 : Matrix (Fin 2) (Fin 2) ℂ)) *ᵥ v = 0 := by
        simp only [Matrix.sub_mulVec]                                   -- 行列とベクトルの積の分配則
    _ ↔ (AMat K θ - lam • (1 : Matrix (Fin 2) (Fin 2) ℂ)).det = 0 :=
        exists_ne_zero_mulVec_eq_zero_iff_det_fin_two _                 -- `nonzero_kernel_iff_det_zero_two_by_two`
    _ ↔ lam = ((lambdaPlusR K θ : ℝ) : ℂ) ∨ lam = ((lambdaMinusR K θ : ℝ) : ℂ) :=
        det_AMat_sub_smul_eq_zero_iff K θ lam                           -- 準備の因数分解と零因子が無いこと

/-- **人手証明 Step 2**: `v_{+,μ} = (-r, b)` は固有値 `λ_{+,μ} = g_1 + r` の固有ベクトル。 -/
theorem AMat_mulVec_eigen_pos :
    AMat K θ *ᵥ ![-((absGamma2 K θ : ℝ) : ℂ), gamma2 K (-θ)]
      = ((lambdaPlusR K θ : ℝ) : ℂ) • ![-((absGamma2 K θ : ℝ) : ℂ), gamma2 K (-θ)] := by
  set g₁ := gamma1 K θ with hg₁
  set a := gamma2 K θ with ha
  set b := gamma2 K (-θ) with hb₀
  set r : ℂ := ((absGamma2 K θ : ℝ) : ℂ)
  have hb : b = -(starRingEnd ℂ) a := gamma2_neg_eq_neg_conj K θ
  have haa : a * (starRingEnd ℂ) a = r ^ 2 := gamma2_mul_conj_eq_absGamma2_sq K θ
  rw [lambdaPlusR_ofReal]
  ext i
  fin_cases i
  · -- 第 1 成分
    calc (AMat K θ *ᵥ ![-r, b]) 0
        = g₁ * (-r) + a * b := by
          -- `def_gamma1_gamma2_of_theta` と行列とベクトルの積の定義
          rw [AMat_eq]; simp [Matrix.mulVec, dotProduct, Fin.sum_univ_two, ← hg₁, ← ha, ← hb₀]
      _ = -(g₁ * r) + a * (-(starRingEnd ℂ) a) := by rw [hb, mul_neg]           -- `b = -ā`
      _ = -(g₁ * r) - r ^ 2 := by rw [mul_neg, haa, ← sub_eq_add_neg]          -- `a ā = r^2`
      _ = (g₁ + r) * (-r) := by ring                                          -- 分配則
      _ = ((g₁ + r) • ![-r, b]) 0 := by simp                                   -- `(v_+)_1 = -r`
  · -- 第 2 成分
    calc (AMat K θ *ᵥ ![-r, b]) 1
        = (-b) * (-r) + g₁ * b := by
          -- `def_gamma1_gamma2_of_theta` と行列とベクトルの積の定義
          rw [AMat_eq]; simp [Matrix.mulVec, dotProduct, Fin.sum_univ_two, ← hg₁, ← ha, ← hb₀]
      _ = (starRingEnd ℂ) a * (-r) + g₁ * (-(starRingEnd ℂ) a) := by
          rw [hb, neg_neg]                                       -- `-b = ā` を 2 箇所へ同時適用
      _ = (-r - g₁) * (starRingEnd ℂ) a := by ring                -- `ā` を括り出す
      _ = (g₁ + r) * (-(starRingEnd ℂ) a) := by ring              -- `-r - g_1 = -(g_1 + r)`
      _ = ((g₁ + r) • ![-r, b]) 1 := by simp [hb]                  -- `(v_+)_2 = b = -ā`

/-- **人手証明 Step 2**: `v_{-,μ} = (+r, b)` は固有値 `λ_{-,μ} = g_1 - r` の固有ベクトル。 -/
theorem AMat_mulVec_eigen_neg :
    AMat K θ *ᵥ ![((absGamma2 K θ : ℝ) : ℂ), gamma2 K (-θ)]
      = ((lambdaMinusR K θ : ℝ) : ℂ) • ![((absGamma2 K θ : ℝ) : ℂ), gamma2 K (-θ)] := by
  set g₁ := gamma1 K θ with hg₁
  set a := gamma2 K θ with ha
  set b := gamma2 K (-θ) with hb₀
  set r : ℂ := ((absGamma2 K θ : ℝ) : ℂ)
  have hb : b = -(starRingEnd ℂ) a := gamma2_neg_eq_neg_conj K θ
  have haa : a * (starRingEnd ℂ) a = r ^ 2 := gamma2_mul_conj_eq_absGamma2_sq K θ
  rw [lambdaMinusR_ofReal]
  ext i
  fin_cases i
  · -- 第 1 成分
    calc (AMat K θ *ᵥ ![r, b]) 0
        = g₁ * r + a * b := by
          -- `def_gamma1_gamma2_of_theta` と行列とベクトルの積の定義
          rw [AMat_eq]; simp [Matrix.mulVec, dotProduct, Fin.sum_univ_two, ← hg₁, ← ha, ← hb₀]
      _ = g₁ * r + a * (-(starRingEnd ℂ) a) := by rw [hb]                      -- `b = -ā`
      _ = g₁ * r - r ^ 2 := by rw [mul_neg, haa, ← sub_eq_add_neg]             -- `a ā = r^2`
      _ = (g₁ - r) * r := by ring                                             -- 分配則
      _ = ((g₁ - r) • ![r, b]) 0 := by simp                                    -- `(v_-)_1 = +r`
  · -- 第 2 成分
    calc (AMat K θ *ᵥ ![r, b]) 1
        = (-b) * r + g₁ * b := by
          -- `def_gamma1_gamma2_of_theta` と行列とベクトルの積の定義
          rw [AMat_eq]; simp [Matrix.mulVec, dotProduct, Fin.sum_univ_two, ← hg₁, ← ha, ← hb₀]
      _ = (starRingEnd ℂ) a * r + g₁ * (-(starRingEnd ℂ) a) := by
          rw [hb, neg_neg]                                       -- `-b = ā` を 2 箇所へ同時適用
      _ = (r - g₁) * (starRingEnd ℂ) a := by ring                 -- `ā` を括り出す
      _ = (g₁ - r) * (-(starRingEnd ℂ) a) := by ring              -- `r - g_1 = -(g_1 - r)`
      _ = ((g₁ - r) • ![r, b]) 1 := by simp [hb]                   -- `(v_-)_2 = b = -ā`

/-- **人手証明 Step 2**: `b ≠ 0` より `v_{+,μ} = (-r, b) ≠ 0`。 -/
theorem eigenvector_pos_ne_zero (P : IsingParam) {M : ℕ} (hM : M ≠ 0) (μ : ℤ) :
    ![-((absGamma2 P.const (thetaTilde M μ) : ℝ) : ℂ), gamma2 P.const (-thetaTilde M μ)] ≠ 0 := by
  intro h
  exact gamma2_neg_thetaTilde_ne_zero P hM μ (by simpa using congrFun h 1)

/-- **人手証明 Step 2**: `b ≠ 0` より `v_{-,μ} = (+r, b) ≠ 0`。 -/
theorem eigenvector_neg_ne_zero (P : IsingParam) {M : ℕ} (hM : M ≠ 0) (μ : ℤ) :
    ![((absGamma2 P.const (thetaTilde M μ) : ℝ) : ℂ), gamma2 P.const (-thetaTilde M μ)] ≠ 0 := by
  intro h
  exact gamma2_neg_thetaTilde_ne_zero P hM μ (by simpa using congrFun h 1)

/-- **人手証明 Step 2**: `c` 倍しても固有ベクトルである（`v_{+,μ}` の側）。 -/
theorem AMat_mulVec_smul_eigen_pos (c : ℂ) :
    AMat K θ *ᵥ (c • ![-((absGamma2 K θ : ℝ) : ℂ), gamma2 K (-θ)])
      = ((lambdaPlusR K θ : ℝ) : ℂ) • (c • ![-((absGamma2 K θ : ℝ) : ℂ), gamma2 K (-θ)]) :=
  calc AMat K θ *ᵥ (c • ![-((absGamma2 K θ : ℝ) : ℂ), gamma2 K (-θ)])
      = c • (AMat K θ *ᵥ ![-((absGamma2 K θ : ℝ) : ℂ), gamma2 K (-θ)]) :=
        Matrix.mulVec_smul _ _ _                       -- スカラー倍は積の外へ出る
    _ = c • (((lambdaPlusR K θ : ℝ) : ℂ) • ![-((absGamma2 K θ : ℝ) : ℂ), gamma2 K (-θ)]) := by
        rw [AMat_mulVec_eigen_pos]                     -- `A(θ)v = λv` の代入
    _ = ((lambdaPlusR K θ : ℝ) : ℂ) • (c • ![-((absGamma2 K θ : ℝ) : ℂ), gamma2 K (-θ)]) :=
        smul_comm _ _ _                                -- 積の可換性とスカラー倍の結合

/-- **人手証明 Step 2**: `c` 倍しても固有ベクトルである（`v_{-,μ}` の側）。 -/
theorem AMat_mulVec_smul_eigen_neg (c : ℂ) :
    AMat K θ *ᵥ (c • ![((absGamma2 K θ : ℝ) : ℂ), gamma2 K (-θ)])
      = ((lambdaMinusR K θ : ℝ) : ℂ) • (c • ![((absGamma2 K θ : ℝ) : ℂ), gamma2 K (-θ)]) :=
  calc AMat K θ *ᵥ (c • ![((absGamma2 K θ : ℝ) : ℂ), gamma2 K (-θ)])
      = c • (AMat K θ *ᵥ ![((absGamma2 K θ : ℝ) : ℂ), gamma2 K (-θ)]) :=
        Matrix.mulVec_smul _ _ _                       -- スカラー倍は積の外へ出る
    _ = c • (((lambdaMinusR K θ : ℝ) : ℂ) • ![((absGamma2 K θ : ℝ) : ℂ), gamma2 K (-θ)]) := by
        rw [AMat_mulVec_eigen_neg]                     -- `A(θ)v = λv` の代入
    _ = ((lambdaMinusR K θ : ℝ) : ℂ) • (c • ![((absGamma2 K θ : ℝ) : ℂ), gamma2 K (-θ)]) :=
        smul_comm _ _ _                                -- 積の可換性とスカラー倍の結合

/-- **人手証明の statement**: `c ∈ ℂ^×` について `c v_{+,μ}` は `A(θ~_μ)` の `λ_{+,μ}` に属する固有ベクトル
（`def_eigenvector`）。`c v_{+,μ} ≠ 0` は `c ≠ 0` と `eigenvector_pos_ne_zero`、`A(c v_+) = λ_+ (c v_+)` は
`AMat_mulVec_smul_eigen_pos` による。 -/
theorem isEigenvector_smul_eigen_pos (P : IsingParam) {M : ℕ} (hM : M ≠ 0) (μ : ℤ) {c : ℂ} (hc : c ≠ 0) :
    IsEigenvector (AMat P.const (thetaTilde M μ)) ((lambdaPlusR P.const (thetaTilde M μ) : ℝ) : ℂ)
      (c • ![-((absGamma2 P.const (thetaTilde M μ) : ℝ) : ℂ), gamma2 P.const (-thetaTilde M μ)]) :=
  ⟨smul_ne_zero hc (eigenvector_pos_ne_zero P hM μ), AMat_mulVec_smul_eigen_pos _ _ c⟩

/-- **人手証明の statement**: `c ∈ ℂ^×` について `c v_{-,μ}` は `A(θ~_μ)` の `λ_{-,μ}` に属する固有ベクトル
（`def_eigenvector`）。 -/
theorem isEigenvector_smul_eigen_neg (P : IsingParam) {M : ℕ} (hM : M ≠ 0) (μ : ℤ) {c : ℂ} (hc : c ≠ 0) :
    IsEigenvector (AMat P.const (thetaTilde M μ)) ((lambdaMinusR P.const (thetaTilde M μ) : ℝ) : ℂ)
      (c • ![((absGamma2 P.const (thetaTilde M μ) : ℝ) : ℂ), gamma2 P.const (-thetaTilde M μ)]) :=
  ⟨smul_ne_zero hc (eigenvector_neg_ne_zero P hM μ), AMat_mulVec_smul_eigen_neg _ _ c⟩

/-- **人手証明 Step 1 の末尾**: `λ_{+,μ} ≠ λ_{-,μ}`（`|γ_2| > 0` による）。 -/
theorem lambdaPlusR_ne_lambdaMinusR (P : IsingParam) {M : ℕ} (hM : M ≠ 0) (μ : ℤ) :
    lambdaPlusR P.const (thetaTilde M μ) ≠ lambdaMinusR P.const (thetaTilde M μ) := by
  have hr := absGamma2_thetaTilde_pos P hM μ
  rw [lambdaPlusR, lambdaMinusR]
  intro h
  linarith

/-! ## 対角化（人手証明 `diagonalization_check_P_D`） -/

/-- **人手証明の `P̌_μ`**（正規化 `c = 1/(2√M γ_2(-θ~_μ))` を代入した明示形）。 -/
noncomputable def checkPmat (K : IsingConst) (M : ℕ) (μ : ℤ) : Matrix (Fin 2) (Fin 2) ℂ :=
  !![-((absGamma2 K (thetaTilde M μ) : ℝ) : ℂ) /
        (2 * sqrtM M * gamma2 K (-thetaTilde M μ)),
      ((absGamma2 K (thetaTilde M μ) : ℝ) : ℂ) /
        (2 * sqrtM M * gamma2 K (-thetaTilde M μ));
    1 / (2 * sqrtM M), 1 / (2 * sqrtM M)]

/-- **人手証明の `Ď_μ = diag(λ_{+,μ}, λ_{-,μ})`**。 -/
noncomputable def checkDmat (K : IsingConst) (M : ℕ) (μ : ℤ) : Matrix (Fin 2) (Fin 2) ℂ :=
  !![((lambdaPlusR K (thetaTilde M μ) : ℝ) : ℂ), 0;
    0, ((lambdaMinusR K (thetaTilde M μ) : ℝ) : ℂ)]

/-- 人手証明の任意定数の選択 `c := 1/(2√M b)`。 -/
noncomputable def checkC (K : IsingConst) (M : ℕ) (μ : ℤ) : ℂ :=
  1 / (2 * sqrtM M * gamma2 K (-thetaTilde M μ))

/-- **人手証明 Step 2 の第 2 成分**: `c b = 1/(2√M)`。 -/
theorem checkC_mul_b (P : IsingParam) {M : ℕ} (hM : M ≠ 0) (μ : ℤ) :
    checkC P.const M μ * gamma2 P.const (-thetaTilde M μ) = 1 / (2 * sqrtM M) := by
  have hb := gamma2_neg_thetaTilde_ne_zero P hM μ
  have hs := sqrtM_ne_zero hM
  calc checkC P.const M μ * gamma2 P.const (-thetaTilde M μ)
      = 1 / (2 * sqrtM M * gamma2 P.const (-thetaTilde M μ))
          * gamma2 P.const (-thetaTilde M μ) := rfl                    -- `c` の定義
    _ = 1 / (2 * sqrtM M) := by field_simp            -- `b ≠ 0` と ℂ の四則

/-- **人手証明 Step 2**: `P̌_μ` の第 1 列は `v_{+,μ} = c(-r, b)` である。 -/
theorem checkPmat_col_pos (P : IsingParam) {M : ℕ} (hM : M ≠ 0) (μ : ℤ) :
    (fun k => checkPmat P.const M μ k 0)
      = checkC P.const M μ
          • ![-((absGamma2 P.const (thetaTilde M μ) : ℝ) : ℂ), gamma2 P.const (-thetaTilde M μ)] := by
  have hcb := checkC_mul_b P hM μ
  ext k
  fin_cases k
  · simp [checkPmat, checkC, div_eq_mul_inv]; ring
  · simp [checkPmat, hcb]

/-- **人手証明 Step 2**: `P̌_μ` の第 2 列は `v_{-,μ} = c(+r, b)` である。 -/
theorem checkPmat_col_neg (P : IsingParam) {M : ℕ} (hM : M ≠ 0) (μ : ℤ) :
    (fun k => checkPmat P.const M μ k 1)
      = checkC P.const M μ
          • ![((absGamma2 P.const (thetaTilde M μ) : ℝ) : ℂ), gamma2 P.const (-thetaTilde M μ)] := by
  have hcb := checkC_mul_b P hM μ
  ext k
  fin_cases k
  · simp [checkPmat, checkC, div_eq_mul_inv]; ring
  · simp [checkPmat, hcb]

/-- **人手証明 Step 2**: `A(θ~_μ) P̌_μ = P̌_μ Ď_μ`（行列の積を列ごとに見て、
`eigenvector_of_A_theta_tilde` を 2 列へ同時適用する）。 -/
theorem AMat_mul_checkPmat (P : IsingParam) {M : ℕ} (hM : M ≠ 0) (μ : ℤ) :
    AMat P.const (thetaTilde M μ) * checkPmat P.const M μ
      = checkPmat P.const M μ * checkDmat P.const M μ := by
  -- 列 `j` の `A(θ) (c v_±) = λ_± (c v_±)`（スカラー倍は積の外へ出る）
  have hcol0 : AMat P.const (thetaTilde M μ) *ᵥ (fun k => checkPmat P.const M μ k 0)
      = ((lambdaPlusR P.const (thetaTilde M μ) : ℝ) : ℂ) • (fun k => checkPmat P.const M μ k 0) := by
    rw [checkPmat_col_pos P hM μ, AMat_mulVec_smul_eigen_pos]
  have hcol1 : AMat P.const (thetaTilde M μ) *ᵥ (fun k => checkPmat P.const M μ k 1)
      = ((lambdaMinusR P.const (thetaTilde M μ) : ℝ) : ℂ) • (fun k => checkPmat P.const M μ k 1) := by
    rw [checkPmat_col_neg P hM μ, AMat_mulVec_smul_eigen_neg]
  ext i j
  fin_cases j
  · -- 第 1 列: `Ď` の右乗は第 1 列の `λ_+` 倍
    have h := congrFun hcol0 i
    simp only [Matrix.mulVec, dotProduct, Pi.smul_apply, smul_eq_mul] at h
    simp [Matrix.mul_apply, Fin.sum_univ_two, checkDmat, h, mul_comm]
  · -- 第 2 列: `Ď` の右乗は第 2 列の `λ_-` 倍
    have h := congrFun hcol1 i
    simp only [Matrix.mulVec, dotProduct, Pi.smul_apply, smul_eq_mul] at h
    simp [Matrix.mul_apply, Fin.sum_univ_two, checkDmat, h, mul_comm]

/-- **人手証明 Step 3**: `det P̌_μ = -|γ_2(θ~_μ)|/(2M γ_2(-θ~_μ))`。 -/
theorem det_checkPmat (P : IsingParam) {M : ℕ} (hM : M ≠ 0) (μ : ℤ) :
    (checkPmat P.const M μ).det
      = -((absGamma2 P.const (thetaTilde M μ) : ℝ) : ℂ) /
          (2 * (M : ℂ) * gamma2 P.const (-thetaTilde M μ)) := by
  set r : ℂ := ((absGamma2 P.const (thetaTilde M μ) : ℝ) : ℂ)
  set b := gamma2 P.const (-thetaTilde M μ)
  set s : ℂ := sqrtM M
  have hs : s ≠ 0 := sqrtM_ne_zero hM
  have hb : b ≠ 0 := gamma2_neg_thetaTilde_ne_zero P hM μ
  have hM' : (M : ℂ) ≠ 0 := Nat.cast_ne_zero.2 hM
  have hsq : (2 * s) ^ 2 = 4 * (M : ℂ) := by
    rw [mul_pow, sqrtM_sq]; ring
  calc (checkPmat P.const M μ).det
      = (-r / (2 * s * b)) * (1 / (2 * s)) - (r / (2 * s * b)) * (1 / (2 * s)) :=
        Matrix.det_fin_two_of _ _ _ _                                  -- 行列式の定義
    _ = -r / (4 * M * b) - r / (4 * M * b) := by
        rw [← hsq]; field_simp                                        -- `(2√M)^2 = 4M`
    _ = -r / (4 * M * b) + -r / (4 * M * b) := by ring                -- ℂ の四則
    _ = 2 * (-r / (4 * M * b)) := by ring                             -- 同類項の統合
    _ = -r / (2 * M * b) := by field_simp; ring                       -- `2M ≠ 0` と ℂ の四則

/-- **人手証明 Step 3 の結論**: `det P̌_μ ≠ 0`（`r > 0`、`2M ≠ 0`、`b ≠ 0` と零因子が無いこと）。 -/
theorem det_checkPmat_ne_zero (P : IsingParam) {M : ℕ} (hM : M ≠ 0) (μ : ℤ) :
    (checkPmat P.const M μ).det ≠ 0 := by
  have hr : ((absGamma2 P.const (thetaTilde M μ) : ℝ) : ℂ) ≠ 0 := by
    simp only [ne_eq, Complex.ofReal_eq_zero]
    exact ne_of_gt (absGamma2_thetaTilde_pos P hM μ)
  have hb := gamma2_neg_thetaTilde_ne_zero P hM μ
  have hM' : (M : ℂ) ≠ 0 := Nat.cast_ne_zero.2 hM
  rw [det_checkPmat P hM μ]
  exact div_ne_zero (neg_ne_zero.2 hr) (mul_ne_zero (mul_ne_zero two_ne_zero hM') hb)

/-- **人手証明 `diagonalization_check_P_D`**（Step 4）: `A(θ~_μ) = P̌_μ Ď_μ P̌_μ⁻¹`（**場合分けなし**）。 -/
theorem AMat_thetaTilde_eq_checkPmat_mul_checkDmat_mul_inv
    (P : IsingParam) {M : ℕ} (hM : M ≠ 0) (μ : ℤ) :
    AMat P.const (thetaTilde M μ)
      = checkPmat P.const M μ * checkDmat P.const M μ * (checkPmat P.const M μ)⁻¹ := by
  have hdet : IsUnit (checkPmat P.const M μ).det :=
    isUnit_iff_ne_zero.2 (det_checkPmat_ne_zero P hM μ)
  calc AMat P.const (thetaTilde M μ)
      = AMat P.const (thetaTilde M μ) * (checkPmat P.const M μ * (checkPmat P.const M μ)⁻¹) := by
        rw [Matrix.mul_nonsing_inv _ hdet, Matrix.mul_one]           -- `P̌ P̌⁻¹ = I`
    _ = (AMat P.const (thetaTilde M μ) * checkPmat P.const M μ) * (checkPmat P.const M μ)⁻¹ :=
        (Matrix.mul_assoc _ _ _).symm                                 -- 積の結合則
    _ = (checkPmat P.const M μ * checkDmat P.const M μ) * (checkPmat P.const M μ)⁻¹ := by
        rw [AMat_mul_checkPmat P hM μ]                                 -- Step 2

end Ising2D
