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
  `det(A(θ) - λI)` の鎖 `charPoly_factor_thetaTilde`（先頭の 7 行は `def_matrix_difference`・`def_matrix_scalar_multiple`・
  `def_identity_matrix`・`def_kronecker_delta`（`kroneckerDelta_self`・`kroneckerDelta_of_ne`）の成分と、`x·1 = x`・`x·0 = 0`・`y - 0 = y`。成分の式は
  `MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimIdentityScalarMultipleAndDifferenceOnVectors.lean` の
  `matrix_sub_apply`・`matrix_smul_apply`・`identity_matrix_apply`）［`skew2_charPoly`・`skew2_charPoly_factor`］、零因子が無いことによる
  `det_AMat_sub_smul_eq_zero_iff`［`skew2_det_eq_zero_iff`］、固有値が `λ_{±,μ}` に限るという statement の主張
  `eigenvalue_AMat_iff`（固有値の定義 `def_eigenvalue` から `det(A(θ) - λI) = 0` までの同値の鎖。最後の段は
  `MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimNonzeroKernelIffDetZeroTwoByTwo.lean` の
  `exists_ne_zero_mulVec_eq_zero_iff_det_fin_two`（人手 `nonzero_kernel_iff_det_zero_two_by_two`）、2〜5 段は同じフォルダの
  `ClaimIdentityScalarMultipleAndDifferenceOnVectors.lean` の `vec_sub_eq_zero_iff`（`matrix_difference_zero_iff_equal`）・
  `identity_matrix_mulVec`（`identity_matrix_is_left_unit_of_mat_mult`）・`smul_mulVec_eq`（`scalar_multiple_factors_out_of_left_factor`）・
  `sub_mulVec_eq`（`matrix_difference_mul_vector`））［`skew2_eigenvalue_iff`］、
  `λ_+ ≠ λ_-` の `lambdaPlusR_ne_lambdaMinusR`［`skew2_eigenvalues_ne`］。
* `eigenvector_of_A_theta_tilde` の statement の「`c v_{±,μ}`（`c ∈ ℂ^×`）は固有ベクトル」:
  `isEigenvector_smul_eigen_pos`・`isEigenvector_smul_eigen_neg`。
* `eigenvector_of_A_theta_tilde` Step 2: 成分ごとの鎖 `AMat_mulVec_eigen_pos`・`AMat_mulVec_eigen_neg`
  （第 1 成分は `b = -ā` と `a ā = r^2` による。第 2 成分は人手どおり `b` のまま括り出し、`b = -ā` を使わない）
  ［`skew2_mulVec_pos`・`skew2_mulVec_neg`。第 1 成分は合成 `ab = -s^2` の 1 段、第 2 成分は仮定なし］、`v_± ≠ 0` の
  `eigenvector_pos_ne_zero`・`eigenvector_neg_ne_zero`［置かない］、`c ∈ ℂ^×` 倍の鎖
  `AMat_mulVec_smul_eigen_pos`・`AMat_mulVec_smul_eigen_neg`［`mulVec_smul_of_mulVec_eq`］。
* `diagonalization_check_P_D` Step 1: `s = (√M)_ℂ ≠ 0_ℂ` は `def_check_fermi` と同じ `√M`（`sqrtM`）についての
  `sqrtM_ne_zero`（`DefinitionCheckFermi.lean`）を引く。`2_ℂ = (2,0) ≠ 0_ℂ` は成分の比較の `complex_two_ne_zero_by_re`。
  `u := 2_ℂ s ∈ ℂ^×`・`d := u b ∈ ℂ^×`（群の積）は `checkU_ne_zero`・`checkD_ne_zero`［置かない］。
  `c = 1_ℂ/d = 1_ℂ d^{-1} = d^{-1}`（3 行）は `checkC_eq_inv`、`c ∈ ℂ^×` は `checkC_ne_zero`［置かない］。
  `P̌_μ`・`c` もこの `sqrtM` で書き、分数は `def_complex_quotient` の商（`div_eq_mul_inv` で開く）と読む。
* `diagonalization_check_P_D` Step 2: 第 1 成分の 5 行の鎖 `checkC_mul`（`c x = x/d`）、第 2 成分の 13 行の鎖 `checkC_mul_b`
  （どちらも人手と 1 段ずつの `calc`）、列が `v_{±,μ}` に一致すること
  `checkPmat_col_pos`・`checkPmat_col_neg`［置かない。`c` の具体形の確認］、列ごとに見た `A P̌ = P̌ Ď` の
  `AMat_mul_checkPmat`［`skew2_mul_of_cols`］。
* `diagonalization_check_P_D` Step 3: 前置き (a) `s s = ℓ` の `sqrtM_mul_sqrtM`（5 行）、(b) `ℓ, q ∈ ℂ^×` の
  `checkM_ne_zero`・`checkW_ne_zero`、(c) `1_ℂ + 1_ℂ = 2_ℂ` の `one_add_one_eq_two_complex`（4 行）、(d) `d u = 2_ℂ q` の
  `checkD_mul_checkU`（12 行）［置かない］。`det P̌` の 29 行の鎖は 28 行目までの `det_checkPmat_eq_mul_inv` と 29 行目の
  `det_checkPmat`（人手と 1 段ずつの `calc`）、`ρ`・`-1_ℂ` の第 1 成分の比較と群の積・逆元による `det_checkPmat_ne_zero`［`det_of_cols`・`det_of_cols_ne_zero`。
  必要十分版は列の形 `c(∓s, b)` から環の四則で値を出す別の経路のまま］。
* `diagonalization_check_P_D` Step 4: 右から `P̌⁻¹` を掛ける 4 行の鎖（`identity_matrix_is_right_unit_of_mat_mult`
  （`mul_identity_matrix`）・`def_invertible_elements_of_R` の `g g^{-1} = I`・`mat_mult_associative`・Step 2）と 1 段ずつの `calc`
  `AMat_thetaTilde_eq_checkPmat_mul_checkDmat_mul_inv`［`eq_conj_of_mul_eq`］。
* 人手証明にあった Step 3（固有空間が 1 次元で、固有ベクトルは `v_{±,μ}` の `ℂ^×` 倍に限ること）は後段で使われないので、
  本文から参照用ノート `claims_unused_by_chapter_goals_not_adopted` へ退避されている。形式化していない。

人手証明と同じく `γ_2 = 0` の場合分けは無い。`gamma_2_theta_tilde_nonzero`
（`Ising2D.gamma2_thetaTilde_ne_zero`）が無条件だからである。
-/
import Ising2D.EigenvalueProblem.DiagonalizationAndExponentialForm.ClaimRelationGamma2Tilde
import Ising2D.EigenvalueProblem.DiagonalizationAndExponentialForm.DefinitionCheckFermi
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimNonzeroKernelIffDetZeroTwoByTwo
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityScalarMultipleAndDifferenceOnVectors
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityAndScalarMultipleInMatrixProduct
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesSum
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesDifference

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
  rw [lambdaPlusR, gamma1_eq_ofReal, real_inclusion_add]  -- 実数の和の像は像の和（`real_inclusion_preserves_sum`）

theorem lambdaMinusR_ofReal :
    ((lambdaMinusR K θ : ℝ) : ℂ) = gamma1 K θ - ((absGamma2 K θ : ℝ) : ℂ) := by
  rw [lambdaMinusR, gamma1_eq_ofReal, real_inclusion_sub]  -- 実数の差の像は像の差（`real_inclusion_preserves_difference`）

/-! ## 固有ベクトル（人手証明 `eigenvector_of_A_theta_tilde` Step 1・Step 2） -/

/-- `abs_basic_properties` の `a ā = |a|^2`（`a := γ_2(θ)`、`r := |a|`）。 -/
theorem gamma2_mul_conj_eq_absGamma2_sq :
    gamma2 K θ * (starRingEnd ℂ) (gamma2 K θ) = ((absGamma2 K θ : ℝ) : ℂ) ^ 2 := by
  rw [Complex.mul_conj, ← Complex.ofReal_pow, absGamma2_sq]

/-- `relation_of_gamma_2_theta_tilde` (2) を `ab = -r^2` の形で書いたもの。 -/
theorem gamma2_mul_gamma2_neg_eq_neg_absGamma2_sq :
    gamma2 K θ * gamma2 K (-θ) = -((absGamma2 K θ : ℝ) : ℂ) ^ 2 := by
  rw [gamma2_mul_gamma2_neg_eq_neg_absSq, Complex.ofReal_neg, Complex.ofReal_pow]

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
      = (!![AMat K θ 0 0 - (lam • (1 : Matrix (Fin 2) (Fin 2) ℂ)) 0 0,
            AMat K θ 0 1 - (lam • (1 : Matrix (Fin 2) (Fin 2) ℂ)) 0 1;
            AMat K θ 1 0 - (lam • (1 : Matrix (Fin 2) (Fin 2) ℂ)) 1 0,
            AMat K θ 1 1 - (lam • (1 : Matrix (Fin 2) (Fin 2) ℂ)) 1 1] : Matrix (Fin 2) (Fin 2) ℂ).det := by
        rw [Matrix.eta_fin_two (AMat K θ - lam • (1 : Matrix (Fin 2) (Fin 2) ℂ))]
        simp only [matrix_sub_apply]                                      -- `def_matrix_difference`
    _ = (!![AMat K θ 0 0 - lam * (1 : Matrix (Fin 2) (Fin 2) ℂ) 0 0,
            AMat K θ 0 1 - lam * (1 : Matrix (Fin 2) (Fin 2) ℂ) 0 1;
            AMat K θ 1 0 - lam * (1 : Matrix (Fin 2) (Fin 2) ℂ) 1 0,
            AMat K θ 1 1 - lam * (1 : Matrix (Fin 2) (Fin 2) ℂ) 1 1] : Matrix (Fin 2) (Fin 2) ℂ).det := by
        simp only [matrix_smul_apply]                                     -- `def_matrix_scalar_multiple`
    _ = (!![AMat K θ 0 0 - lam * kroneckerDelta 0 0, AMat K θ 0 1 - lam * kroneckerDelta 0 1;
            AMat K θ 1 0 - lam * kroneckerDelta 1 0, AMat K θ 1 1 - lam * kroneckerDelta 1 1] :
            Matrix (Fin 2) (Fin 2) ℂ).det := by
        simp only [identity_matrix_apply]; rfl                            -- `def_identity_matrix`
    _ = (!![AMat K θ 0 0 - lam * 1, AMat K θ 0 1 - lam * 0;
            AMat K θ 1 0 - lam * 0, AMat K θ 1 1 - lam * 1] : Matrix (Fin 2) (Fin 2) ℂ).det := by
        have h00 : kroneckerDelta (0 : Fin 2) 0 = 1 := kroneckerDelta_self 0
        have h11 : kroneckerDelta (1 : Fin 2) 1 = 1 := kroneckerDelta_self 1
        have h01 : kroneckerDelta (0 : Fin 2) 1 = 0 := kroneckerDelta_of_ne (by decide)
        have h10 : kroneckerDelta (1 : Fin 2) 0 = 0 := kroneckerDelta_of_ne (by decide)
        rw [h00, h11, h01, h10]                                           -- `def_kronecker_delta`
    _ = (!![AMat K θ 0 0 - lam, AMat K θ 0 1 - lam * 0;
            AMat K θ 1 0 - lam * 0, AMat K θ 1 1 - lam] : Matrix (Fin 2) (Fin 2) ℂ).det := by
        simp only [mul_one]                                               -- `x·1 = x`
    _ = (!![AMat K θ 0 0 - lam, AMat K θ 0 1 - 0;
            AMat K θ 1 0 - 0, AMat K θ 1 1 - lam] : Matrix (Fin 2) (Fin 2) ℂ).det := by
        simp only [mul_zero]                                              -- `x·0 = 0`
    _ = (!![AMat K θ 0 0 - lam, AMat K θ 0 1; AMat K θ 1 0, AMat K θ 1 1 - lam] :
            Matrix (Fin 2) (Fin 2) ℂ).det := by
        simp only [sub_zero]                                              -- `y - 0 = y`
    _ = (!![g₁ - lam, a; -b, g₁ - lam] : Matrix (Fin 2) (Fin 2) ℂ).det := by
        rw [AMat_eq]; rfl                                                 -- `def_gamma1_gamma2_of_theta`
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
        simp only [vec_sub_eq_zero_iff]                                 -- `matrix_difference_zero_iff_equal`
    _ ↔ ∃ v : Fin 2 → ℂ, v ≠ 0 ∧ AMat K θ *ᵥ v - lam • ((1 : Matrix (Fin 2) (Fin 2) ℂ) *ᵥ v) = 0 := by
        simp only [identity_matrix_mulVec]                              -- `identity_matrix_is_left_unit_of_mat_mult`
    _ ↔ ∃ v : Fin 2 → ℂ, v ≠ 0 ∧ AMat K θ *ᵥ v - (lam • (1 : Matrix (Fin 2) (Fin 2) ℂ)) *ᵥ v = 0 := by
        simp only [← smul_mulVec_eq]                                    -- `scalar_multiple_factors_out_of_left_factor`
    _ ↔ ∃ v : Fin 2 → ℂ, v ≠ 0 ∧ (AMat K θ - lam • (1 : Matrix (Fin 2) (Fin 2) ℂ)) *ᵥ v = 0 := by
        simp only [sub_mulVec_eq]                                       -- `matrix_difference_mul_vector`
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
  · -- 第 2 成分（`b = -ā` を使わない）
    calc (AMat K θ *ᵥ ![-r, b]) 1
        = (-b) * (-r) + g₁ * b := by
          -- `def_gamma1_gamma2_of_theta` と行列とベクトルの積の定義
          rw [AMat_eq]; simp [Matrix.mulVec, dotProduct, Fin.sum_univ_two, ← hg₁, ← ha, ← hb₀]
      _ = b * r + g₁ * b := by rw [neg_mul_neg]                   -- ℂ の四則 `(-b)(-r) = b r`
      _ = r * b + g₁ * b := by rw [mul_comm b r]                  -- ℂ の乗法の可換則
      _ = (r + g₁) * b := by rw [add_mul]                          -- 分配則で `b` を括り出す
      _ = (g₁ + r) * b := by rw [add_comm r g₁]                    -- ℂ の加法の交換則
      _ = ((g₁ + r) • ![-r, b]) 1 := by simp                       -- `λ_+ = g_1 + r`、`(v_+)_2 = b`

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
  · -- 第 2 成分（`b = -ā` を使わない）
    calc (AMat K θ *ᵥ ![r, b]) 1
        = (-b) * r + g₁ * b := by
          -- `def_gamma1_gamma2_of_theta` と行列とベクトルの積の定義
          rw [AMat_eq]; simp [Matrix.mulVec, dotProduct, Fin.sum_univ_two, ← hg₁, ← ha, ← hb₀]
      _ = b * (-r) + g₁ * b := by rw [neg_mul_comm]               -- ℂ の四則 `(-b) r = b (-r)`
      _ = (-r) * b + g₁ * b := by rw [mul_comm b (-r)]            -- ℂ の乗法の可換則
      _ = (-r + g₁) * b := by rw [add_mul]                         -- 分配則で `b` を括り出す
      _ = (g₁ - r) * b := by rw [add_comm, ← sub_eq_add_neg]       -- ℂ の加法の交換則（`g_1 + (-r) = g_1 - r`）
      _ = ((g₁ - r) • ![r, b]) 1 := by simp                        -- `λ_- = g_1 - r`、`(v_-)_2 = b`

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

/-- 人手証明の任意定数の選択 `c := 1/(2√M b)`（`1_ℂ/d`、`d := u b`、`u := 2_ℂ s`、`s := (√M)_ℂ`）。 -/
noncomputable def checkC (K : IsingConst) (M : ℕ) (μ : ℤ) : ℂ :=
  1 / (2 * sqrtM M * gamma2 K (-thetaTilde M μ))

/-- **人手証明 Step 1**: `u = 2_ℂ s ∈ ℂ^×`（`2_ℂ = (2,0) ≠ 0_ℂ`・`s ≠ 0_ℂ` と `multiplicative_group_of_cc` の群の積）。 -/
theorem checkU_ne_zero {M : ℕ} (hM : M ≠ 0) : (2 : ℂ) * sqrtM M ≠ 0 :=
  mul_ne_zero complex_two_ne_zero_by_re (sqrtM_ne_zero hM)

/-- **人手証明 Step 1**: `d = u b ∈ ℂ^×`（`b ≠ 0_ℂ` と `multiplicative_group_of_cc` の群の積）。 -/
theorem checkD_ne_zero (P : IsingParam) {M : ℕ} (hM : M ≠ 0) (μ : ℤ) :
    (2 : ℂ) * sqrtM M * gamma2 P.const (-thetaTilde M μ) ≠ 0 :=
  mul_ne_zero (checkU_ne_zero hM) (gamma2_neg_thetaTilde_ne_zero P hM μ)

/-- **人手証明 Step 2 の第 1 成分の鎖**: `x ∈ ℂ` について `c x = x/d`（5 行）。 -/
theorem checkC_mul (K : IsingConst) (M : ℕ) (μ : ℤ) (x : ℂ) :
    checkC K M μ * x = x / (2 * sqrtM M * gamma2 K (-thetaTilde M μ)) := by
  set d : ℂ := 2 * sqrtM M * gamma2 K (-thetaTilde M μ) with hd
  calc checkC K M μ * x
      = 1 / d * x := rfl                    -- 1 行目: `c` の定義
    _ = (1 * d⁻¹) * x := by
        rw [div_eq_mul_inv]                 -- 2 行目: `def_complex_quotient`（`z → 1_ℂ`, `w → d`）
    _ = d⁻¹ * x := by
        rw [one_mul]                        -- 3 行目: `complex_numbers_form_a_field` の積の単位元
    _ = x * d⁻¹ := by
        rw [mul_comm]                       -- 4 行目: `complex_numbers_form_a_field` の積の可換律
    _ = x / d := by
        rw [← div_eq_mul_inv]               -- 5 行目: `def_complex_quotient`（`z → x`, `w → d`）を右辺から左辺へ

/-- **人手証明 Step 2 の第 2 成分**: `c b = 1/(2√M)`（13 行。`u := 2_ℂ s`、`d := u b`）。 -/
theorem checkC_mul_b (P : IsingParam) {M : ℕ} (hM : M ≠ 0) (μ : ℤ) :
    checkC P.const M μ * gamma2 P.const (-thetaTilde M μ) = 1 / (2 * sqrtM M) := by
  set b : ℂ := gamma2 P.const (-thetaTilde M μ) with hb
  set u : ℂ := 2 * sqrtM M with hu
  set d : ℂ := u * b with hd
  have hu0 : u ≠ 0 := checkU_ne_zero hM
  have hd0 : d ≠ 0 := checkD_ne_zero P hM μ
  calc checkC P.const M μ * b
      = 1 / d * b := rfl                    -- 1 行目: `c` の定義
    _ = (1 * d⁻¹) * b := by
        rw [div_eq_mul_inv]                 -- 2 行目: `def_complex_quotient`（`z → 1_ℂ`, `w → d`）
    _ = d⁻¹ * b := by
        rw [one_mul]                        -- 3 行目: `complex_numbers_form_a_field` の積の単位元
    _ = 1 * (d⁻¹ * b) := by
        rw [one_mul]                        -- 4 行目: `complex_numbers_form_a_field` の積の単位元を右辺から左辺へ
    _ = (u⁻¹ * u) * (d⁻¹ * b) := by
        rw [inv_mul_cancel₀ hu0]            -- 5 行目: `multiplicative_group_of_cc` の逆元（`u ∈ ℂ^×`）を右辺から左辺へ
    _ = u⁻¹ * (u * (d⁻¹ * b)) := by
        rw [mul_assoc u⁻¹ u]                -- 6 行目: `complex_numbers_form_a_field` の積の結合律
    _ = u⁻¹ * ((u * d⁻¹) * b) := by
        rw [← mul_assoc u d⁻¹ b]            -- 7 行目: `complex_numbers_form_a_field` の積の結合律を右辺から左辺へ
    _ = u⁻¹ * ((d⁻¹ * u) * b) := by
        rw [mul_comm u d⁻¹]                 -- 8 行目: `complex_numbers_form_a_field` の積の可換律
    _ = u⁻¹ * (d⁻¹ * (u * b)) := by
        rw [mul_assoc d⁻¹ u b]              -- 9 行目: `complex_numbers_form_a_field` の積の結合律
    _ = u⁻¹ * (d⁻¹ * d) := rfl              -- 10 行目: `d` の定義を右辺から左辺へ
    _ = u⁻¹ * 1 := by
        rw [inv_mul_cancel₀ hd0]            -- 11 行目: `multiplicative_group_of_cc` の逆元（`d ∈ ℂ^×`）
    _ = 1 * u⁻¹ := by
        rw [mul_comm]                       -- 12 行目: `complex_numbers_form_a_field` の積の可換律
    _ = 1 / u := by
        rw [← div_eq_mul_inv]               -- 13 行目: `def_complex_quotient`（`z → 1_ℂ`, `w → u`）を右辺から左辺へ

/-- **人手証明 Step 2**: `P̌_μ` の第 1 列は `v_{+,μ} = c(-r, b)` である
（第 1 成分は `checkC_mul` を `x → -r_ℂ` に、第 2 成分は `checkC_mul_b`）。 -/
theorem checkPmat_col_pos (P : IsingParam) {M : ℕ} (hM : M ≠ 0) (μ : ℤ) :
    (fun k => checkPmat P.const M μ k 0)
      = checkC P.const M μ
          • ![-((absGamma2 P.const (thetaTilde M μ) : ℝ) : ℂ), gamma2 P.const (-thetaTilde M μ)] := by
  ext k
  fin_cases k
  · simp only [Pi.smul_apply, smul_eq_mul]
    rw [checkC_mul]
    rfl
  · show (1 : ℂ) / (2 * sqrtM M) = checkC P.const M μ * gamma2 P.const (-thetaTilde M μ)
    rw [checkC_mul_b P hM μ]

/-- **人手証明 Step 2**: `P̌_μ` の第 2 列は `v_{-,μ} = c(+r, b)` である
（第 1 成分は `checkC_mul` を `x → r_ℂ` に、第 2 成分は `checkC_mul_b`）。 -/
theorem checkPmat_col_neg (P : IsingParam) {M : ℕ} (hM : M ≠ 0) (μ : ℤ) :
    (fun k => checkPmat P.const M μ k 1)
      = checkC P.const M μ
          • ![((absGamma2 P.const (thetaTilde M μ) : ℝ) : ℂ), gamma2 P.const (-thetaTilde M μ)] := by
  ext k
  fin_cases k
  · simp only [Pi.smul_apply, smul_eq_mul]
    rw [checkC_mul]
    rfl
  · show (1 : ℂ) / (2 * sqrtM M) = checkC P.const M μ * gamma2 P.const (-thetaTilde M μ)
    rw [checkC_mul_b P hM μ]

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

/-- **人手証明 Step 3 の前置き (a)**: `s s = ℓ`（`s := (√M)_ℂ`、`ℓ := (ι_{ℤ→ℝ}(M))_ℂ`。5 行）。
Lean の `ℓ` は `ℕ` からの直接のキャスト `(M : ℂ)` なので、5 行目は人手の「`ℓ` の定義」を、
`ℝ` を経る合成 `((M : ℝ) : ℂ)` と直接のキャストの一致 `Complex.ofReal_natCast` の 1 段で受ける。 -/
theorem sqrtM_mul_sqrtM (M : ℕ) : sqrtM M * sqrtM M = (M : ℂ) := by
  calc sqrtM M * sqrtM M
      = ((Real.sqrt M : ℝ) : ℂ) * ((Real.sqrt M : ℝ) : ℂ) := rfl
                                        -- 1 行目: `s` の定義
    _ = ((Real.sqrt M * Real.sqrt M : ℝ) : ℂ) := (Complex.ofReal_mul _ _).symm
                                        -- 2 行目: `real_inclusion_preserves_product`（`a, b → √M`）
    _ = ((Real.sqrt M ^ 2 : ℝ) : ℂ) := by rw [sq]
                                        -- 3 行目: `square_of_real_number_is_product`（`r → √M`）を右辺から左辺へ
    _ = (((M : ℝ)) : ℂ) := by rw [Real.sq_sqrt (Nat.cast_nonneg M)]
                                        -- 4 行目: `definition_of_sqrt_r_positive` の `y^2 = x`
    _ = (M : ℂ) := Complex.ofReal_natCast M
                                        -- 5 行目: `ℓ` の定義（`ι_{ℤ→ℝ}` と `inclusion_rr_to_cc` の合成）

/-- **人手証明 Step 3 の前置き (b)**: `ℓ ∈ ℂ^×`（(a) の `ℓ = s s` と `s ∈ ℂ^×`、`multiplicative_group_of_cc` の群の積）。 -/
theorem checkM_ne_zero {M : ℕ} (hM : M ≠ 0) : (M : ℂ) ≠ 0 := by
  rw [← sqrtM_mul_sqrtM M]
  exact mul_ne_zero (sqrtM_ne_zero hM) (sqrtM_ne_zero hM)

/-- **人手証明 Step 3 の前置き (b)**: `q := (2_ℂ ℓ) b ∈ ℂ^×`（`multiplicative_group_of_cc` の群の積）。 -/
theorem checkW_ne_zero (P : IsingParam) {M : ℕ} (hM : M ≠ 0) (μ : ℤ) :
    2 * (M : ℂ) * gamma2 P.const (-thetaTilde M μ) ≠ 0 :=
  mul_ne_zero (mul_ne_zero complex_two_ne_zero_by_re (checkM_ne_zero hM))
    (gamma2_neg_thetaTilde_ne_zero P hM μ)

/-- **人手証明 Step 3 の前置き (c)**: `1_ℂ + 1_ℂ = 2_ℂ`（4 行）。 -/
theorem one_add_one_eq_two_complex : (1 : ℂ) + 1 = 2 := by
  calc (1 : ℂ) + 1
      = ((1 : ℝ) : ℂ) + ((1 : ℝ) : ℂ) := by rw [Complex.ofReal_one]
                                        -- 1 行目: `inclusion_rr_to_cc` の略記 `1_ℂ = (1)_ℂ` を 2 か所へ
    _ = ((1 + 1 : ℝ) : ℂ) := (Complex.ofReal_add 1 1).symm
                                        -- 2 行目: `real_inclusion_preserves_sum`（`a, b → 1`）
    _ = ((2 : ℝ) : ℂ) := by rw [one_add_one_eq_two]
                                        -- 3 行目: `ℝ` で `1 + 1 = 2`
    _ = 2 := Complex.ofReal_ofNat 2
                                        -- 4 行目: `2_ℂ = (2_ℝ)_ℂ`

/-- **人手証明 Step 3 の前置き (d)**: `d u = 2_ℂ q`（`u := 2_ℂ s`、`d := u b`、`q := (2_ℂ ℓ) b`。12 行）。 -/
theorem checkD_mul_checkU (K : IsingConst) (M : ℕ) (μ : ℤ) :
    (2 * sqrtM M * gamma2 K (-thetaTilde M μ)) * (2 * sqrtM M)
      = 2 * (2 * (M : ℂ) * gamma2 K (-thetaTilde M μ)) := by
  set s : ℂ := sqrtM M with hs
  set b : ℂ := gamma2 K (-thetaTilde M μ) with hb
  set u : ℂ := 2 * s with hu
  set d : ℂ := u * b with hd
  set q : ℂ := 2 * (M : ℂ) * b with hq
  calc d * u
      = (u * b) * u := by rw [hd]               -- 1 行目: `d` の定義
    _ = u * (b * u) := mul_assoc _ _ _          -- 2 行目: 積の結合律
    _ = u * (u * b) := by rw [mul_comm b u]     -- 3 行目: 積の可換律
    _ = (u * u) * b := (mul_assoc _ _ _).symm   -- 4 行目: 積の結合律を右辺から左辺へ
    _ = ((2 * s) * (2 * s)) * b := by rw [hu]   -- 5 行目: `u` の定義を 2 か所へ
    _ = (2 * (s * (2 * s))) * b := by rw [mul_assoc (2 : ℂ) s (2 * s)]
                                                -- 6 行目: 積の結合律
    _ = (2 * ((s * 2) * s)) * b := by rw [← mul_assoc s (2 : ℂ) s]
                                                -- 7 行目: 積の結合律を右辺から左辺へ
    _ = (2 * ((2 * s) * s)) * b := by rw [mul_comm s (2 : ℂ)]
                                                -- 8 行目: 積の可換律
    _ = (2 * (2 * (s * s))) * b := by rw [mul_assoc (2 : ℂ) s s]
                                                -- 9 行目: 積の結合律
    _ = (2 * (2 * (M : ℂ))) * b := by rw [hs, sqrtM_mul_sqrtM M]
                                                -- 10 行目: 前置き (a)
    _ = 2 * ((2 * (M : ℂ)) * b) := mul_assoc _ _ _
                                                -- 11 行目: 積の結合律
    _ = 2 * q := by rw [hq]                     -- 12 行目: `q` の定義を右辺から左辺へ

/-- **人手証明 Step 1**: `c = 1_ℂ/d = 1_ℂ d^{-1} = d^{-1}`（3 行）。 -/
theorem checkC_eq_inv (K : IsingConst) (M : ℕ) (μ : ℤ) :
    checkC K M μ = (2 * sqrtM M * gamma2 K (-thetaTilde M μ))⁻¹ := by
  set d : ℂ := 2 * sqrtM M * gamma2 K (-thetaTilde M μ) with hd
  calc checkC K M μ
      = 1 / d := rfl                    -- 1 行目: `c` の定義
    _ = 1 * d⁻¹ := div_eq_mul_inv _ _   -- 2 行目: `def_complex_quotient`（`z → 1_ℂ`, `w → d`）
    _ = d⁻¹ := one_mul _                -- 3 行目: `complex_numbers_form_a_field` の積の単位元

/-- **人手証明 Step 1**: `c ∈ ℂ^×`（`c = d^{-1}` は `multiplicative_group_of_cc` の逆元）。 -/
theorem checkC_ne_zero (P : IsingParam) {M : ℕ} (hM : M ≠ 0) (μ : ℤ) :
    checkC P.const M μ ≠ 0 := by
  rw [checkC_eq_inv]
  exact inv_ne_zero (checkD_ne_zero P hM μ)

/-- **人手証明 Step 3 の鎖の 1〜28 行目**: `det P̌_μ = (-ρ) q^{-1}`（`ρ := r_ℂ`、`q := (2_ℂ ℓ) b`）。
人手の det ≠ 0 の段落が「鎖の最後から 2 行目」として引く形。 -/
theorem det_checkPmat_eq_mul_inv (P : IsingParam) {M : ℕ} (hM : M ≠ 0) (μ : ℤ) :
    (checkPmat P.const M μ).det
      = -((absGamma2 P.const (thetaTilde M μ) : ℝ) : ℂ) *
          (2 * (M : ℂ) * gamma2 P.const (-thetaTilde M μ))⁻¹ := by
  have hdu := checkD_mul_checkU P.const M μ
  have hu0 : (2 : ℂ) * sqrtM M ≠ 0 := checkU_ne_zero hM
  have hd0 := checkD_ne_zero P hM μ
  have hq0 := checkW_ne_zero P hM μ
  set ρ : ℂ := ((absGamma2 P.const (thetaTilde M μ) : ℝ) : ℂ) with hρ
  set u : ℂ := 2 * sqrtM M with hu
  set d : ℂ := u * gamma2 P.const (-thetaTilde M μ) with hd
  set q : ℂ := 2 * (M : ℂ) * gamma2 P.const (-thetaTilde M μ) with hq
  calc (checkPmat P.const M μ).det
      = (-ρ / d) * (1 / u) - (ρ / d) * (1 / u) :=
        Matrix.det_fin_two_of _ _ _ _
                                        -- 1 行目: `def_det_two_by_two`（`B → P̌_μ`）
    _ = ((-ρ) * d⁻¹) * (1 * u⁻¹) - (ρ * d⁻¹) * (1 * u⁻¹) := by
        simp only [div_eq_mul_inv]      -- 2 行目: `def_complex_quotient` を 4 か所へ
    _ = ((-ρ) * d⁻¹) * u⁻¹ - (ρ * d⁻¹) * u⁻¹ := by
        simp only [one_mul]             -- 3 行目: 積の単位元を 2 か所へ
    _ = (-ρ) * (d⁻¹ * u⁻¹) - ρ * (d⁻¹ * u⁻¹) := by
        rw [mul_assoc (-ρ), mul_assoc ρ]
                                        -- 4 行目: 積の結合律を 2 か所へ
    _ = (-ρ) * (d⁻¹ * u⁻¹) + -(ρ * (d⁻¹ * u⁻¹)) := sub_eq_add_neg _ _
                                        -- 5 行目: `def_complex_difference`
    _ = (-ρ) * (d⁻¹ * u⁻¹) + (-1) * (ρ * (d⁻¹ * u⁻¹)) := by
        rw [neg_one_mul]                -- 6 行目: `multiply_by_minus_one`
    _ = (-ρ) * (d⁻¹ * u⁻¹) + ((-1) * ρ) * (d⁻¹ * u⁻¹) := by
        rw [mul_assoc (-1 : ℂ) ρ]       -- 7 行目: 積の結合律を右辺から左辺へ
    _ = (-ρ) * (d⁻¹ * u⁻¹) + (-ρ) * (d⁻¹ * u⁻¹) := by
        rw [neg_one_mul]                -- 8 行目: `multiply_by_minus_one` を右辺から左辺へ
    _ = 1 * ((-ρ) * (d⁻¹ * u⁻¹)) + 1 * ((-ρ) * (d⁻¹ * u⁻¹)) := by
        rw [one_mul]                    -- 9 行目: 積の単位元を右辺から左辺へ 2 か所へ
    _ = (1 + 1) * ((-ρ) * (d⁻¹ * u⁻¹)) := (add_mul _ _ _).symm
                                        -- 10 行目: 右からの分配律を右辺から左辺へ
    _ = 2 * ((-ρ) * (d⁻¹ * u⁻¹)) := by
        rw [one_add_one_eq_two_complex] -- 11 行目: 前置き (c)
    _ = (2 * (-ρ)) * (d⁻¹ * u⁻¹) := (mul_assoc _ _ _).symm
                                        -- 12 行目: 積の結合律を右辺から左辺へ
    _ = ((-ρ) * 2) * (d⁻¹ * u⁻¹) := by
        rw [mul_comm (2 : ℂ) (-ρ)]      -- 13 行目: 積の可換律
    _ = (-ρ) * (2 * (d⁻¹ * u⁻¹)) := mul_assoc _ _ _
                                        -- 14 行目: 積の結合律
    _ = (-ρ) * (1 * (2 * (d⁻¹ * u⁻¹))) := by
        rw [one_mul]                    -- 15 行目: 積の単位元を右辺から左辺へ
    _ = (-ρ) * ((q⁻¹ * q) * (2 * (d⁻¹ * u⁻¹))) := by
        rw [inv_mul_cancel₀ hq0]        -- 16 行目: `multiplicative_group_of_cc` の逆元（`q ∈ ℂ^×`）を右辺から左辺へ
    _ = (-ρ) * (q⁻¹ * (q * (2 * (d⁻¹ * u⁻¹)))) := by
        rw [mul_assoc q⁻¹ q]            -- 17 行目: 積の結合律
    _ = (-ρ) * (q⁻¹ * ((q * 2) * (d⁻¹ * u⁻¹))) := by
        rw [mul_assoc q (2 : ℂ)]        -- 18 行目: 積の結合律を右辺から左辺へ
    _ = (-ρ) * (q⁻¹ * ((2 * q) * (d⁻¹ * u⁻¹))) := by
        rw [mul_comm q (2 : ℂ)]         -- 19 行目: 積の可換律
    _ = (-ρ) * (q⁻¹ * ((d * u) * (d⁻¹ * u⁻¹))) := by
        rw [hdu]                        -- 20 行目: 前置き (d) を右辺から左辺へ
    _ = (-ρ) * (q⁻¹ * (d * (u * (d⁻¹ * u⁻¹)))) := by
        rw [mul_assoc d u]              -- 21 行目: 積の結合律
    _ = (-ρ) * (q⁻¹ * (d * ((u * d⁻¹) * u⁻¹))) := by
        rw [mul_assoc u d⁻¹]            -- 22 行目: 積の結合律を右辺から左辺へ
    _ = (-ρ) * (q⁻¹ * (d * ((d⁻¹ * u) * u⁻¹))) := by
        rw [mul_comm u d⁻¹]             -- 23 行目: 積の可換律
    _ = (-ρ) * (q⁻¹ * (d * (d⁻¹ * (u * u⁻¹)))) := by
        rw [mul_assoc d⁻¹ u]            -- 24 行目: 積の結合律
    _ = (-ρ) * (q⁻¹ * (d * (d⁻¹ * 1))) := by
        rw [mul_inv_cancel₀ hu0]        -- 25 行目: `multiplicative_group_of_cc` の逆元（`u ∈ ℂ^×`）
    _ = (-ρ) * (q⁻¹ * (d * d⁻¹)) := by
        rw [mul_one]                    -- 26 行目: 積の単位元
    _ = (-ρ) * (q⁻¹ * 1) := by
        rw [mul_inv_cancel₀ hd0]        -- 27 行目: `multiplicative_group_of_cc` の逆元（`d ∈ ℂ^×`）
    _ = (-ρ) * q⁻¹ := by
        rw [mul_one]                    -- 28 行目: 積の単位元

/-- **人手証明 Step 3**: `det P̌_μ = (-ρ)/q = -|γ_2(θ~_μ)|/(2M γ_2(-θ~_μ))`（29 行。28 行目までは `det_checkPmat_eq_mul_inv`）。 -/
theorem det_checkPmat (P : IsingParam) {M : ℕ} (hM : M ≠ 0) (μ : ℤ) :
    (checkPmat P.const M μ).det
      = -((absGamma2 P.const (thetaTilde M μ) : ℝ) : ℂ) /
          (2 * (M : ℂ) * gamma2 P.const (-thetaTilde M μ)) := by
  rw [det_checkPmat_eq_mul_inv P hM μ]  -- 1〜28 行目
  exact (div_eq_mul_inv _ _).symm       -- 29 行目: `def_complex_quotient`（`z → -ρ`, `w → q`）を右辺から左辺へ

/-- **人手証明 Step 3 の結論**: `det P̌_μ ≠ 0_ℂ`（`ρ = (r,0)`・`-1_ℂ = (-1,0)` の第 1 成分が 0 でないことと、
`multiplicative_group_of_cc` の群の積・逆元）。 -/
theorem det_checkPmat_ne_zero (P : IsingParam) {M : ℕ} (hM : M ≠ 0) (μ : ℤ) :
    (checkPmat P.const M μ).det ≠ 0 := by
  have hr : 0 < absGamma2 P.const (thetaTilde M μ) := absGamma2_thetaTilde_pos P hM μ
                                        -- `relation_of_gamma_2_theta_tilde` (4) の `r > 0`
  have hρ : ((absGamma2 P.const (thetaTilde M μ) : ℝ) : ℂ) ≠ 0 := by
    intro h
    have hre := congrArg Complex.re h   -- 仮定 `ρ = 0_ℂ` の第 1 成分
    rw [Complex.ofReal_re, Complex.zero_re] at hre
                                        -- `inclusion_rr_to_cc`: `ρ = (r, 0)`、`0_ℂ = (0, 0)` の第 1 成分
    exact ne_of_gt hr hre               -- 第 1 成分が `ℝ` で `r ≠ 0`
  have hm1 : (-1 : ℂ) ≠ 0 := by
    intro h
    have h' : ((-1 : ℝ) : ℂ) = 0 := by rw [Complex.ofReal_neg, Complex.ofReal_one]; exact h
                                        -- `-1_ℂ` は略記 `r_ℂ` の `r = -1`
    have hre := congrArg Complex.re h'  -- 仮定 `-1_ℂ = 0_ℂ` の第 1 成分
    rw [Complex.ofReal_re, Complex.zero_re] at hre
                                        -- `inclusion_rr_to_cc`: `-1_ℂ = (-1, 0)`、`0_ℂ = (0, 0)` の第 1 成分
    exact absurd hre (by norm_num)      -- 第 1 成分が `ℝ` で `-1 ≠ 0`
  have hnegρ : -((absGamma2 P.const (thetaTilde M μ) : ℝ) : ℂ) ≠ 0 := by
    rw [← neg_one_mul]                  -- `multiply_by_minus_one`: `-ρ = (-1_ℂ) ρ`
    exact mul_ne_zero hm1 hρ            -- 群の積
  rw [det_checkPmat_eq_mul_inv P hM μ]  -- 鎖の最後から 2 行目 `(-ρ) q^{-1}`
  exact mul_ne_zero hnegρ (inv_ne_zero (checkW_ne_zero P hM μ))
                                        -- `q^{-1} ∈ ℂ^×`（逆元）と群の積

/-- **人手証明 `diagonalization_check_P_D`**（Step 4）: `A(θ~_μ) = P̌_μ Ď_μ P̌_μ⁻¹`（**場合分けなし**）。

人手の 4 行の鎖と 1 段ずつの `calc` である。人手の `P̌_μ^{-1}` は `def_invertible_elements_of_R`（`M → 1`）の逆元、すなわち
`P̌_μ h = I` かつ `h P̌_μ = I` を満たすただ 1 つの `h` で、`det P̌_μ ≠ 0` のとき mathlib の `(checkPmat …)⁻¹`
（`Matrix.mul_nonsing_inv`・`Matrix.nonsing_inv_mul` がこの 2 つの等式を与える）がその `h` である。
人手の右辺 `P̌_μ Ď_μ P̌_μ^{-1}` は `(P̌_μ Ď_μ) P̌_μ^{-1}` と読み（statement）、Lean の積は左結合なので鎖の最後の辺がそのまま右辺である。
`mat_mult_associative` は具体版が無く、既存の慣行どおり mathlib の `Matrix.mul_assoc` を引く。 -/
theorem AMat_thetaTilde_eq_checkPmat_mul_checkDmat_mul_inv
    (P : IsingParam) {M : ℕ} (hM : M ≠ 0) (μ : ℤ) :
    AMat P.const (thetaTilde M μ)
      = checkPmat P.const M μ * checkDmat P.const M μ * (checkPmat P.const M μ)⁻¹ := by
  have hdet : IsUnit (checkPmat P.const M μ).det :=
    isUnit_iff_ne_zero.2 (det_checkPmat_ne_zero P hM μ)   -- Step 3 の `det P̌_μ ≠ 0`
  calc AMat P.const (thetaTilde M μ)
      = AMat P.const (thetaTilde M μ) * 1 :=
        (mul_identity_matrix _).symm
          -- 1 行目: `identity_matrix_is_right_unit_of_mat_mult`（`m → 2`、`n → 2`、`A → A(θ~_μ)`）を右辺から左辺へ
    _ = AMat P.const (thetaTilde M μ) * (checkPmat P.const M μ * (checkPmat P.const M μ)⁻¹) := by
        rw [Matrix.mul_nonsing_inv _ hdet]
          -- 2 行目: `def_invertible_elements_of_R`（`M → 1`、`g → P̌_μ`）の `g g^{-1} = I` を右辺から左辺へ
    _ = (AMat P.const (thetaTilde M μ) * checkPmat P.const M μ) * (checkPmat P.const M μ)⁻¹ :=
        (Matrix.mul_assoc _ _ _).symm
          -- 3 行目: `mat_mult_associative`（`A → A(θ~_μ)`、`B → P̌_μ`、`C → P̌_μ^{-1}`）を右辺から左辺へ
    _ = (checkPmat P.const M μ * checkDmat P.const M μ) * (checkPmat P.const M μ)⁻¹ := by
        rw [AMat_mul_checkPmat P hM μ]
          -- 4 行目: Step 2 の `A(θ~_μ) P̌_μ = P̌_μ Ď_μ`

end Ising2D
