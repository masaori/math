/-
# 半整数運動量のフェルミオン `ψ̌_μ`, `ψ̌_μ^†` の定義と、`γ_1, γ_2` の周期性

対応する人手証明（正本は `structured-latex/content/eigenvalue_problem_diagonalization_and_exponential_form.ts`）:

* `evenfermi_001_definition_check_fermi`（ラベル `def_check_fermi`）
* `evenfermi_002_claim_periodicity`（ラベル `periodicity_of_check_fermi`）

## 形式化の方針

* 人手の定義は行ベクトル記法 `(ψ̌_μ^†, ψ̌_μ) := (Ž_μ, Y̌_μ) P̌_μ` である。本ファイルは、
  人手が「すなわち」として与えている**明示式**

      ψ̌_μ^† := (-r/(2√M b)) Ž_μ + (1/(2√M)) Y̌_μ
      ψ̌_μ   := (+r/(2√M b)) Ž_μ + (1/(2√M)) Y̌_μ
      （a := γ_2(θ̃_μ), b := γ_2(-θ̃_μ), r := |a|）

  を定義として採用する。この式は 013 章（`Ž, Y̌`）と 008 章（`γ_1, γ_2`）だけで書けるので、
  `P̌_μ`（`checkPmat`、`ClaimEigenATildeDiag.lean`）を import せずに定義できる。
  行ベクトル記法との一致は `ClaimCommutationVPlusCheckPsi.lean` の `checkPsi_row_eq_rowMul_checkPmat` で確かめる。
* `r := |γ_2(θ̃_μ)|` は `Real.sqrt (Complex.normSq (γ_2(θ̃_μ)))` で表す。
  **008 章の `ψ` と違い、平方根の分枝を選ぶ仮定（`hbr`）が要らない**のはこのためである
  （人手 `anticommutator_of_check_psi` の Step 1 の指摘そのもの）。
  `r` は非負実数として一意に定まり、`(r : ℂ)^2 = -(γ_2(θ̃_μ)γ_2(-θ̃_μ))` が無条件に成り立つ
  （`checkR_sq`）。
* 人手の「定義が意味をもつ」段落は、係数の分母 `u := 2_ℂ s`・`d := u b` が `ℂ^×` に属することを
  `diagonalization_check_P_D` Step 1 から引く（Lean では `checkU_ne_zero`・`checkD_ne_zero`、`ClaimEigenATildeDiag.lean`。
  Lean の割り算は分母 `0` でも値を返すので、定義そのものに仮定は要らない）。`r > 0`（人手は `relation_of_gamma_2_theta_tilde` (4)）を
  使う定理は、`γ_2(θ̃_μ) ≠ 0`（`gamma_2_theta_tilde_nonzero`）を仮定
  `hga : gamma2 K (thetaTilde M μ) ≠ 0` として受け取る（`checkR_pos`・`checkR_ne_zero`）。
  `gamma_2_theta_tilde_nonzero` の無条件版 `gamma2_thetaTilde_ne_zero` で `hga` を落とした版は `ClaimCheckFermiResultsUnconditional.lean` に置く。
  （`γ_2(-θ̃_μ) ≠ 0` は `gamma2_neg_eq_zero_iff` から従うので別に仮定しない。）
-/
import Ising2D.EigenvalueProblem.ReductionToATheta.DefinitionThetaGamma
import Ising2D.EigenvalueProblem.DiagonalizationAndExponentialForm.ClaimGamma1LowerBound
import Ising2D.EigenvalueProblem.DiagonalizationAndExponentialForm.ClaimConjugateIndex
import Ising2D.EigenvalueProblem.DiagonalizationAndExponentialForm.ClaimRecoverZYFromCheckZY
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimSquareOfRealNumberIsProduct
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.DefinitionRealMatrixOfRealEntryMatrix

namespace Ising2D

variable {M : ℕ}

/-! ## `γ_1` の `2π` 周期性（人手 `periodicity_of_check_fermi` (1)）

`γ_2` 側（`gamma2_add_two_pi_mul_int`）は `DefinitionThetaGamma.lean` にある。 -/

/-- 人手 `periodicity_of_check_fermi` (1) の `γ_1` 側: `γ_1(θ + 2π k_ℝ) = γ_1(θ)`（人手の 3 行）。
人手の `γ_1` は ℝ の値なので、ℝ の `gamma1R` の上で書く。 -/
theorem gamma1R_add_two_pi_mul_int (K : IsingConst) (θ : ℝ) (k : ℤ) :
    gamma1R K (θ + 2 * Real.pi * (k : ℝ)) = gamma1R K θ :=
  calc gamma1R K (θ + 2 * Real.pi * (k : ℝ))
      = K.c1 * K.c2star - K.s1 * K.s2star * Real.cos (θ + 2 * Real.pi * (k : ℝ)) := by
        rw [gamma1R]                              -- 1 行目: `def_gamma1_gamma2_of_theta` を `θ + 2π k_ℝ` に適用
    _ = K.c1 * K.c2star - K.s1 * K.s2star * Real.cos θ := by
        rw [real_cos_add_two_pi_mul_int θ k]      -- 2 行目: `cos` の `2π` 周期性を `n = k` で
    _ = gamma1R K θ := by
        rw [gamma1R]                              -- 3 行目: `def_gamma1_gamma2_of_theta`

/-- 人手 `periodicity_of_check_fermi` (2) の第一の鎖: `θ̃_{μ+kM} = θ̃_μ + 2π k_ℝ`（人手の 17 行）。

人手の `(M_col)_ℝ` は `M_col ∈ ℤ` の `ι_{ℤ→ℝ}` による像で、Lean では `((M : ℤ) : ℝ)` と書く
（`thetaTilde` の分母と、分子の `(kM_col)_ℝ` から 3 行目で分ける因子の両方）。
人手の `2π` は 1 つの実数で、Lean の `2 * Real.pi` に当たる。9 行目の分配法則が作る形は `2π(k_ℝ(M_col)_ℝ)` である。
人手 `def_real_quotient`（`y/z := y z^{-1}`）は mathlib の `div_eq_mul_inv`、その乗法の逆元（`z z^{-1} = 1_ℝ`）は
`mul_inv_cancel₀` で受ける。 -/
theorem thetaTilde_add_int_mul (M : ℕ) (hM : M ≠ 0) (μ k : ℤ) :
    thetaTilde M (μ + k * M) = thetaTilde M μ + 2 * Real.pi * (k : ℝ) := by
  have hM' : ((M : ℤ) : ℝ) ≠ 0 := Int.cast_ne_zero.2 (Int.natCast_ne_zero.2 hM)
  calc thetaTilde M (μ + k * M)
      = 2 * Real.pi * (((μ + k * M : ℤ) : ℝ) - 1 / 2) / ((M : ℤ) : ℝ) := rfl
                                                  -- 1 行目: `θ̃` の定義を `μ+kM_col` で（`antiperiodic_exp_sum`）
    _ = 2 * Real.pi * (((μ : ℝ) + ((k * M : ℤ) : ℝ)) - 1 / 2) / ((M : ℤ) : ℝ) := by
        rw [Int.cast_add]                         -- 2 行目: `ι_{ℤ→ℝ}` は和を保つ
    _ = 2 * Real.pi * (((μ : ℝ) + (k : ℝ) * ((M : ℤ) : ℝ)) - 1 / 2) / ((M : ℤ) : ℝ) := by
        rw [Int.cast_mul]                         -- 3 行目: `ι_{ℤ→ℝ}` は積を保つ
    _ = 2 * Real.pi * (((k : ℝ) * ((M : ℤ) : ℝ) + (μ : ℝ)) - 1 / 2) / ((M : ℤ) : ℝ) := by
        rw [add_comm (μ : ℝ)]                     -- 4 行目: ℝ の加法の交換律
    _ = 2 * Real.pi * (((k : ℝ) * ((M : ℤ) : ℝ) + (μ : ℝ)) + (-(1 / 2))) / ((M : ℤ) : ℝ) := by
        rw [sub_eq_add_neg]                       -- 5 行目: `def_real_difference`
    _ = 2 * Real.pi * ((k : ℝ) * ((M : ℤ) : ℝ) + ((μ : ℝ) + (-(1 / 2)))) / ((M : ℤ) : ℝ) := by
        rw [add_assoc]                            -- 6 行目: ℝ の加法の結合律
    _ = 2 * Real.pi * ((k : ℝ) * ((M : ℤ) : ℝ) + ((μ : ℝ) - 1 / 2)) / ((M : ℤ) : ℝ) := by
        rw [← sub_eq_add_neg]                     -- 7 行目: `def_real_difference` を右辺から左辺へ
    _ = 2 * Real.pi * (((μ : ℝ) - 1 / 2) + (k : ℝ) * ((M : ℤ) : ℝ)) / ((M : ℤ) : ℝ) := by
        rw [add_comm ((k : ℝ) * ((M : ℤ) : ℝ))]         -- 8 行目: ℝ の加法の交換律
    _ = (2 * Real.pi * ((μ : ℝ) - 1 / 2) + 2 * Real.pi * ((k : ℝ) * ((M : ℤ) : ℝ))) / ((M : ℤ) : ℝ) := by
        rw [mul_add]                              -- 9 行目: ℝ の分配法則
    _ = (2 * Real.pi * ((μ : ℝ) - 1 / 2) + 2 * Real.pi * ((k : ℝ) * ((M : ℤ) : ℝ))) * ((M : ℤ) : ℝ)⁻¹ := by
        rw [div_eq_mul_inv (2 * Real.pi * ((μ : ℝ) - 1 / 2) + 2 * Real.pi * ((k : ℝ) * ((M : ℤ) : ℝ)))]
                                                  -- 10 行目: `def_real_quotient`
    _ = 2 * Real.pi * ((μ : ℝ) - 1 / 2) * ((M : ℤ) : ℝ)⁻¹
          + 2 * Real.pi * ((k : ℝ) * ((M : ℤ) : ℝ)) * ((M : ℤ) : ℝ)⁻¹ := by
        rw [add_mul]                              -- 11 行目: ℝ の右からの分配律
    _ = 2 * Real.pi * ((μ : ℝ) - 1 / 2) / ((M : ℤ) : ℝ)
          + 2 * Real.pi * ((k : ℝ) * ((M : ℤ) : ℝ)) * ((M : ℤ) : ℝ)⁻¹ := by
        rw [← div_eq_mul_inv (2 * Real.pi * ((μ : ℝ) - 1 / 2))]
                                                  -- 12 行目: `def_real_quotient` を右辺から左辺へ
    _ = thetaTilde M μ + 2 * Real.pi * ((k : ℝ) * ((M : ℤ) : ℝ)) * ((M : ℤ) : ℝ)⁻¹ := rfl
                                                  -- 13 行目: `θ̃_μ` の定義（`antiperiodic_exp_sum`）
    _ = thetaTilde M μ + 2 * Real.pi * (k : ℝ) * ((M : ℤ) : ℝ) * ((M : ℤ) : ℝ)⁻¹ := by
        rw [← mul_assoc (2 * Real.pi) (k : ℝ)]   -- 14 行目: ℝ の乗法の結合律を右辺から左辺へ
    _ = thetaTilde M μ + 2 * Real.pi * (k : ℝ) * (((M : ℤ) : ℝ) * ((M : ℤ) : ℝ)⁻¹) := by
        rw [mul_assoc (2 * Real.pi * (k : ℝ))]   -- 15 行目: ℝ の乗法の結合律
    _ = thetaTilde M μ + 2 * Real.pi * (k : ℝ) * 1 := by
        rw [mul_inv_cancel₀ hM']                  -- 16 行目: `def_real_quotient` の乗法の逆元（`(M_col)_ℝ ≠ 0_ℝ`）
    _ = thetaTilde M μ + 2 * Real.pi * (k : ℝ) := by
        rw [mul_one]                              -- 17 行目: ℝ の乗法の単位元

/-- 人手 `periodicity_of_check_fermi` (2): `γ_1(θ̃_{μ+kM}) = γ_1(θ̃_μ)`（人手の 2 行。ℝ の値なので `gamma1R` の上で書く）。 -/
theorem gamma1R_thetaTilde_add_int_mul (K : IsingConst) (hM : M ≠ 0) (μ k : ℤ) :
    gamma1R K (thetaTilde M (μ + k * M)) = gamma1R K (thetaTilde M μ) :=
  calc gamma1R K (thetaTilde M (μ + k * M))
      = gamma1R K (thetaTilde M μ + 2 * Real.pi * (k : ℝ)) := by
        rw [thetaTilde_add_int_mul M hM]          -- 1 行目: 上の第一の鎖
    _ = gamma1R K (thetaTilde M μ) := gamma1R_add_two_pi_mul_int K (thetaTilde M μ) k
                                                  -- 2 行目: (1) を `θ = θ̃_μ` で

/-- 人手 `periodicity_of_check_fermi` (2): `γ_2(θ̃_{μ+kM}) = γ_2(θ̃_μ)`。 -/
theorem gamma2_thetaTilde_add_int_mul (K : IsingConst) (hM : M ≠ 0) (μ k : ℤ) :
    gamma2 K (thetaTilde M (μ + k * M)) = gamma2 K (thetaTilde M μ) := by
  rw [thetaTilde_add_int_mul M hM, gamma2_add_two_pi_mul_int]

/-- 人手 `periodicity_of_check_fermi` の準備の第二: `k ∈ ℤ` について `(-k)_ℝ = -k_ℝ`（人手の 7 行）。 -/
theorem periodicity_prep_int_cast_neg (k : ℤ) : ((-k : ℤ) : ℝ) = -(k : ℝ) :=
  calc ((-k : ℤ) : ℝ)
      = ((-k : ℤ) : ℝ) + 0 := (add_zero _).symm   -- 1 行目: `0_ℝ` は ℝ の和の単位元
    _ = ((-k : ℤ) : ℝ) + ((k : ℝ) + (-(k : ℝ))) := by
        rw [add_neg_cancel]                       -- 2 行目: ℝ の加法逆元 `k_ℝ + (-k_ℝ) = 0_ℝ`
    _ = (((-k : ℤ) : ℝ) + (k : ℝ)) + (-(k : ℝ)) := (add_assoc _ _ _).symm
                                                  -- 3 行目: ℝ の加法の結合律
    _ = (((-k + k : ℤ)) : ℝ) + (-(k : ℝ)) := by
        rw [Int.cast_add]                         -- 4 行目: `ι_{ℤ→ℝ}` は和を保つ
    _ = ((0 : ℤ) : ℝ) + (-(k : ℝ)) := by
        rw [neg_add_cancel]                       -- 5 行目: ℤ で `(-k) + k = 0`
    _ = (0 : ℝ) + (-(k : ℝ)) := by
        rw [Int.cast_zero]                        -- 6 行目: `ι_{ℤ→ℝ}` は零を保つ
    _ = -(k : ℝ) := zero_add _                    -- 7 行目: `0_ℝ` は ℝ の和の単位元

/-- 人手 `periodicity_of_check_fermi` (2) の第二の鎖: `-θ̃_{μ+kM} = (-θ̃_μ) + 2π(-k)_ℝ`（人手の 4 行）。 -/
theorem neg_thetaTilde_add_int_mul (M : ℕ) (hM : M ≠ 0) (μ k : ℤ) :
    -thetaTilde M (μ + k * M) = -thetaTilde M μ + 2 * Real.pi * ((-k : ℤ) : ℝ) :=
  calc -thetaTilde M (μ + k * M)
      = -(thetaTilde M μ + 2 * Real.pi * (k : ℝ)) := by
        rw [thetaTilde_add_int_mul M hM]          -- 1 行目: 上の鎖（`thetaTilde_add_int_mul`）
    _ = (-thetaTilde M μ) + (-(2 * Real.pi * (k : ℝ))) := neg_add _ _
                                                  -- 2 行目: ℝ で `-(p+q) = (-p)+(-q)`（`p → θ̃_μ`, `q → 2πk_ℝ`）
    _ = (-thetaTilde M μ) + 2 * Real.pi * (-(k : ℝ)) := by
        rw [neg_mul_eq_mul_neg]                   -- 3 行目: ℝ で `-(pq) = p(-q)`（`p → 2π`, `q → k_ℝ`）
    _ = -thetaTilde M μ + 2 * Real.pi * ((-k : ℤ) : ℝ) := by
        rw [periodicity_prep_int_cast_neg]        -- 4 行目: 準備の第二

/-- 人手 `periodicity_of_check_fermi` (2): `γ_2(-θ̃_{μ+kM}) = γ_2(-θ̃_μ)`（人手の 2 行）。 -/
theorem gamma2_neg_thetaTilde_add_int_mul (K : IsingConst) (hM : M ≠ 0) (μ k : ℤ) :
    gamma2 K (-thetaTilde M (μ + k * M)) = gamma2 K (-thetaTilde M μ) :=
  calc gamma2 K (-thetaTilde M (μ + k * M))
      = gamma2 K (-thetaTilde M μ + 2 * Real.pi * ((-k : ℤ) : ℝ)) := by
        rw [neg_thetaTilde_add_int_mul M hM]      -- 1 行目: 上の第二の鎖
    _ = gamma2 K (-thetaTilde M μ) := gamma2_add_two_pi_mul_int K (-thetaTilde M μ) (-k)
                                                  -- 2 行目: (1) を `θ = -θ̃_μ`, `-k ∈ ℤ` で

/-! ## 共役添字 `M+1-μ`（人手 `periodicity_of_check_fermi` (3)） -/

/-- 人手 `periodicity_of_check_fermi` (3) の `θ̃_ν` の鎖（`ν := M+1-μ`）: `θ̃_ν = (-θ̃_μ) + 2π(1)_ℝ`（人手の 5 行）。 -/
theorem thetaTilde_conj_eq_neg_add_two_pi (hM : M ≠ 0) (μ : ℤ) :
    thetaTilde M ((M : ℤ) + 1 - μ) = -thetaTilde M μ + 2 * Real.pi * ((1 : ℤ) : ℝ) :=
  calc thetaTilde M ((M : ℤ) + 1 - μ)
      = 2 * Real.pi - thetaTilde M μ := thetaTilde_conj hM μ
                                                  -- 1 行目: `conjugate_index_of_check_Z_Y` (1)
    _ = 2 * Real.pi + (-thetaTilde M μ) := sub_eq_add_neg _ _
                                                  -- 2 行目: ℝ の差の定義
    _ = (-thetaTilde M μ) + 2 * Real.pi := add_comm _ _
                                                  -- 3 行目: ℝ の加法の交換律
    _ = (-thetaTilde M μ) + 2 * Real.pi * 1 := by
        rw [mul_one]                              -- 4 行目: `1_ℝ` は積の単位元
    _ = -thetaTilde M μ + 2 * Real.pi * ((1 : ℤ) : ℝ) := by
        rw [Int.cast_one]                         -- 5 行目: `ι_{ℤ→ℝ}` は単位元を保つ

/-- 人手 `periodicity_of_check_fermi` (3) の `-θ̃_ν` の鎖: `-θ̃_ν = θ̃_μ + 2π(-1)_ℝ`（人手の 5 行）。
2 行目の人手の 1 つの恒等式 `-(p-q) = q+(-p)` は、mathlib の `neg_sub`（`-(p-q) = q-p`）と
`sub_eq_add_neg`（差の定義）を続けて読む。 -/
theorem neg_thetaTilde_conj_eq_add_two_pi_neg_one (hM : M ≠ 0) (μ : ℤ) :
    -thetaTilde M ((M : ℤ) + 1 - μ) = thetaTilde M μ + 2 * Real.pi * ((-1 : ℤ) : ℝ) :=
  calc -thetaTilde M ((M : ℤ) + 1 - μ)
      = -(2 * Real.pi - thetaTilde M μ) := by
        rw [thetaTilde_conj hM μ]                 -- 1 行目: `conjugate_index_of_check_Z_Y` (1)
    _ = thetaTilde M μ + (-(2 * Real.pi)) := by
        rw [neg_sub, sub_eq_add_neg]              -- 2 行目: ℝ で `-(p-q) = q+(-p)`（`p → 2π`, `q → θ̃_μ`）
    _ = thetaTilde M μ + 2 * Real.pi * (-1) := by
        rw [mul_neg_one]                          -- 3 行目: ℝ で `-p = p(-1_ℝ)`（`p → 2π`）
    _ = thetaTilde M μ + 2 * Real.pi * (-((1 : ℤ) : ℝ)) := by
        rw [Int.cast_one]                         -- 4 行目: `ι_{ℤ→ℝ}` は単位元を保つ
    _ = thetaTilde M μ + 2 * Real.pi * ((-1 : ℤ) : ℝ) := by
        rw [periodicity_prep_int_cast_neg 1]      -- 5 行目: 準備の第二を `k = 1` で

/-- 人手 `periodicity_of_check_fermi` (3): `γ_2(θ̃_{M+1-μ}) = γ_2(-θ̃_μ)`（人手の 2 行）。 -/
theorem gamma2_thetaTilde_conj (K : IsingConst) (hM : M ≠ 0) (μ : ℤ) :
    gamma2 K (thetaTilde M ((M : ℤ) + 1 - μ)) = gamma2 K (-thetaTilde M μ) :=
  calc gamma2 K (thetaTilde M ((M : ℤ) + 1 - μ))
      = gamma2 K (-thetaTilde M μ + 2 * Real.pi * ((1 : ℤ) : ℝ)) := by
        rw [thetaTilde_conj_eq_neg_add_two_pi hM] -- 1 行目: 上の `θ̃_ν` の鎖
    _ = gamma2 K (-thetaTilde M μ) := gamma2_add_two_pi_mul_int K (-thetaTilde M μ) 1
                                                  -- 2 行目: (1) を `θ = -θ̃_μ`, `k = 1` で

/-- 人手 `periodicity_of_check_fermi` (3): `γ_2(-θ̃_{M+1-μ}) = γ_2(θ̃_μ)`（人手の 2 行）。 -/
theorem gamma2_neg_thetaTilde_conj (K : IsingConst) (hM : M ≠ 0) (μ : ℤ) :
    gamma2 K (-thetaTilde M ((M : ℤ) + 1 - μ)) = gamma2 K (thetaTilde M μ) :=
  calc gamma2 K (-thetaTilde M ((M : ℤ) + 1 - μ))
      = gamma2 K (thetaTilde M μ + 2 * Real.pi * ((-1 : ℤ) : ℝ)) := by
        rw [neg_thetaTilde_conj_eq_add_two_pi_neg_one hM]
                                                  -- 1 行目: 上の `-θ̃_ν` の鎖
    _ = gamma2 K (thetaTilde M μ) := gamma2_add_two_pi_mul_int K (thetaTilde M μ) (-1)
                                                  -- 2 行目: (1) を `θ = θ̃_μ`, `k = -1` で

/-- 人手 `periodicity_of_check_fermi` の準備の第三: `x ∈ ℝ` について ℝ の等式 `cos(-x) = cos x`。
人手は `cos_of_negated_real`（`θ → x`。具体版 `real_inclusion_cos_neg`）で `(cos(-x))_ℂ = (cos x)_ℂ` を得て、
`inclusion_rr_to_cc_is_injective`（`a → cos(-x)`, `b → cos x`）を当てる。 -/
theorem periodicity_prep_cos_neg (x : ℝ) : Real.cos (-x) = Real.cos x :=
  inclusion_rr_to_cc_is_injective (real_inclusion_cos_neg x)

/-- 人手 `periodicity_of_check_fermi` (3): `γ_1(θ̃_{M+1-μ}) = γ_1(θ̃_μ)`（人手の 5 行）。
人手の `γ_1` は ℝ の値なので、ℝ の `gamma1R` の上で書く。 -/
theorem gamma1R_thetaTilde_conj (K : IsingConst) (hM : M ≠ 0) (μ : ℤ) :
    gamma1R K (thetaTilde M ((M : ℤ) + 1 - μ)) = gamma1R K (thetaTilde M μ) :=
  calc gamma1R K (thetaTilde M ((M : ℤ) + 1 - μ))
      = gamma1R K (-thetaTilde M μ + 2 * Real.pi * ((1 : ℤ) : ℝ)) := by
        rw [thetaTilde_conj_eq_neg_add_two_pi hM] -- 1 行目: 上の `θ̃_ν` の鎖
    _ = gamma1R K (-thetaTilde M μ) := gamma1R_add_two_pi_mul_int K (-thetaTilde M μ) 1
                                                  -- 2 行目: (1) を `θ = -θ̃_μ`, `k = 1` で
    _ = K.c1 * K.c2star - K.s1 * K.s2star * Real.cos (-thetaTilde M μ) := by
        rw [gamma1R]                              -- 3 行目: `def_gamma1_gamma2_of_theta` を `-θ̃_μ` に適用
    _ = K.c1 * K.c2star - K.s1 * K.s2star * Real.cos (thetaTilde M μ) := by
        rw [periodicity_prep_cos_neg]             -- 4 行目: 準備の第三の `cos(-x) = cos x` を `x = θ̃_μ` で
    _ = gamma1R K (thetaTilde M μ) := by
        rw [gamma1R]                              -- 5 行目: `def_gamma1_gamma2_of_theta`

/-! ## `r := |γ_2(θ̃_μ)|` -/

/-- 人手 `def_check_fermi` の `r := |γ_2(θ̃_μ)| ∈ ℝ_{≥0}`。

**008 章の `ψ` と違い、これは平方根の分枝を選ばない量である。** -/
noncomputable def checkR (K : IsingConst) (M : ℕ) (μ : ℤ) : ℝ :=
  Real.sqrt (Complex.normSq (gamma2 K (thetaTilde M μ)))

theorem checkR_nonneg (K : IsingConst) (M : ℕ) (μ : ℤ) : 0 ≤ checkR K M μ :=
  Real.sqrt_nonneg _

/-- **分枝の議論が要らないことの核**: `(r : ℂ)^2 = -(γ_2(θ̃_μ) γ_2(-θ̃_μ))` が**無条件**に成り立つ。

008 章では `t^2 = γ_2(θ_μ)γ_2(-θ_μ)` を満たす `t` を仮定として受け取るため
`t = ±r i` の自由度が残り、`μ` と `ν` で同じ分枝を選ぶ仮定 `hbr` が必要だった。 -/
theorem checkR_sq (K : IsingConst) (M : ℕ) (μ : ℤ) :
    ((checkR K M μ : ℝ) : ℂ) ^ 2
      = -(gamma2 K (thetaTilde M μ) * gamma2 K (-thetaTilde M μ)) := by
  rw [gamma2_mul_gamma2_neg_eq_neg_normSq, neg_neg, checkR, ← Complex.ofReal_pow,
    Real.sq_sqrt (Complex.normSq_nonneg _)]

theorem checkR_pos (K : IsingConst) (M : ℕ) {μ : ℤ}
    (hga : gamma2 K (thetaTilde M μ) ≠ 0) : 0 < checkR K M μ :=
  Real.sqrt_pos.2 ((Complex.normSq_pos).2 hga)

theorem checkR_ne_zero (K : IsingConst) (M : ℕ) {μ : ℤ}
    (hga : gamma2 K (thetaTilde M μ) ≠ 0) : ((checkR K M μ : ℝ) : ℂ) ≠ 0 := by
  simpa using (checkR_pos K M hga).ne'

/-- 人手 `abs_basic_properties` (1) の `|(x, y)| = √(x^2 + y^2)` を、`checkR` の表し方 `√(normSq ·)` で読んだもの。
二乗は `def_power_of_real_number` の冪（mathlib の `^ 2`）である。mathlib の `Complex.normSq ⟨x, y⟩` は積 `x x + y y` なので、
`square_of_real_number_is_product` で冪へ戻す。 -/
theorem sqrt_normSq_mk_eq_sqrt_sq_add_sq (x y : ℝ) :
    Real.sqrt (Complex.normSq ⟨x, y⟩) = Real.sqrt (x ^ 2 + y ^ 2) := by
  rw [Complex.normSq_mk, ← square_of_real_number_is_product x, ← square_of_real_number_is_product y]

/-- 人手 `anticommutator_of_check_psi` の準備 5 の `r_ν` の鎖: `r_{M+1-μ} = r_μ`。

人手の 13 行の鎖と 1 対 1 の `calc` である（`a_μ = (x, y)`、`x := a_μ.re`、`y := a_μ.im`）。
`|·|` は `√(normSq ·)` で表す（`checkR` の定義）ので、`abs_basic_properties` (1) の 2 行は
`sqrt_normSq_mk_eq_sqrt_sq_add_sq` で読む。 -/
theorem checkR_conj (K : IsingConst) (hM : M ≠ 0) (μ : ℤ) :
    checkR K M ((M : ℤ) + 1 - μ) = checkR K M μ := by
  set a : ℂ := gamma2 K (thetaTilde M μ) with ha
  set x : ℝ := a.re with hx
  set y : ℝ := a.im with hy
  calc checkR K M ((M : ℤ) + 1 - μ)
      = Real.sqrt (Complex.normSq (gamma2 K (thetaTilde M ((M : ℤ) + 1 - μ)))) := rfl
                                                    -- `r_ν` の定義（`r_ν = |a_ν|`）
    _ = Real.sqrt (Complex.normSq (gamma2 K (-thetaTilde M μ))) := by
          rw [gamma2_thetaTilde_conj K hM]          -- 上の `a_ν = b_μ`（`periodicity_of_check_fermi` (3)）
    _ = Real.sqrt (Complex.normSq (-(starRingEnd ℂ) a)) := by
          rw [gamma2_neg_eq_neg_conj]               -- `relation_of_gamma_2_theta_tilde` (1)
    _ = Real.sqrt (Complex.normSq ((-1 : ℂ) * (starRingEnd ℂ) a)) := by
          rw [neg_one_mul]                          -- `multiply_by_minus_one`
    _ = Real.sqrt (Complex.normSq ((-1 : ℂ) * ⟨x, -y⟩)) := by
          rw [show (starRingEnd ℂ) a = ⟨x, -y⟩ from Complex.ext (Complex.conj_re a) (Complex.conj_im a)]
                                                    -- `def_complex_conjugate`
    _ = Real.sqrt (Complex.normSq ((⟨-1, 0⟩ : ℂ) * ⟨x, -y⟩)) := by
          rw [show (-1 : ℂ) = ⟨-1, 0⟩ from Complex.ext (by simp) (by simp)]
                                                    -- `-1_ℂ = (-1_ℝ)_ℂ = (-1_ℝ, 0_ℝ)`（`inclusion_rr_to_cc`）
    _ = Real.sqrt (Complex.normSq ⟨-x, y⟩) := by
          rw [show (⟨-1, 0⟩ : ℂ) * ⟨x, -y⟩ = ⟨-x, y⟩ from
            Complex.ext (by simp [Complex.mul_re]) (by simp [Complex.mul_im])]
                                                    -- `definition_of_cc` の積:
                                                    -- `((-1)x - 0(-y), (-1)(-y) + 0x) = (-x, y)`
    _ = Real.sqrt ((-x) ^ 2 + y ^ 2) := sqrt_normSq_mk_eq_sqrt_sq_add_sq (-x) y
                                                    -- `abs_basic_properties` (1)
    _ = Real.sqrt ((-x) * (-x) + y ^ 2) := by
          rw [square_of_real_number_is_product (-x)] -- `square_of_real_number_is_product`（`r → -x`）
    _ = Real.sqrt (x * x + y ^ 2) := by
          rw [neg_mul_neg]                          -- ℝ の四則演算 `(-a)(-b) = ab`（`a → x`, `b → x`）
    _ = Real.sqrt (x ^ 2 + y ^ 2) := by
          rw [← square_of_real_number_is_product x] -- `square_of_real_number_is_product`（`r → x`）
    _ = Real.sqrt (Complex.normSq a) := by
          rw [← sqrt_normSq_mk_eq_sqrt_sq_add_sq x y, hx, hy, Complex.eta]
                                                    -- `abs_basic_properties` (1)（`a_μ = (x, y)`）
    _ = checkR K M μ := rfl                         -- `r_μ` の定義

/-! ## `√M`（人手 `def_check_fermi` の係数の分母） -/

/-- 人手 `def_check_fermi` の `√M`（`M ∈ ℕ` の実数の平方根）を ℂ の元として。 -/
noncomputable def sqrtM (M : ℕ) : ℂ := (Real.sqrt M : ℂ)

/-- 人手 `diagonalization_check_P_D` Step 1 の `s = (√M_col, 0) ≠ (0, 0)`（`inclusion_rr_to_cc`。第 1 成分が `0` でない）。
`def_check_fermi` の係数の分母 `u`・`d` が `ℂ^×` に属すること（`checkU_ne_zero`・`checkD_ne_zero`）はこれを引く。

人手の 2 段に 1 段ずつ対応させる。
1. `M_col ≥ 2` より `√M_col > 0`（Lean では `M ≠ 0` から `Real.sqrt_pos`。この段の人手の根拠は状態台帳の (d4c44m) で扱う）。
2. `s = 0_ℂ` を仮定すると第 1 成分が `√M_col = 0` になり 1 と矛盾する（`definition_of_cc` の等号は成分ごと、
   `inclusion_rr_to_cc` の第 1 成分は `√M_col`）。 -/
theorem sqrtM_ne_zero {M : ℕ} (hM : M ≠ 0) : sqrtM M ≠ 0 := by
  have hpos : 0 < Real.sqrt M := Real.sqrt_pos.2 (Nat.cast_pos.2 (Nat.pos_of_ne_zero hM))
                                      -- 段 1: `√M_col > 0`
  intro h
  have hre : (sqrtM M).re = (0 : ℂ).re := congrArg Complex.re h
                                      -- 仮定 `s = 0_ℂ` の第 1 成分（`definition_of_cc` の `ℝ^2` の元の等号は成分ごと）
  have h0 : Real.sqrt M = 0 :=
    calc Real.sqrt M
        = ((Real.sqrt M : ℝ) : ℂ).re := (Complex.ofReal_re _).symm
                                      -- `inclusion_rr_to_cc`: `s = (√M_col, 0)` の第 1 成分を右辺から左辺へ
      _ = (sqrtM M).re := rfl         -- `s` の定義
      _ = (0 : ℂ).re := hre           -- 仮定の第 1 成分
      _ = 0 := Complex.zero_re        -- `0_ℂ = (0, 0)` の第 1 成分
  exact hpos.ne' h0                   -- 段 2: 第 1 成分 `√M_col` は `0` でない

/-- `(√M)^2 = M`。 -/
@[simp]
theorem sqrtM_sq (M : ℕ) : sqrtM M ^ 2 = (M : ℂ) := by
  have : Real.sqrt M ^ 2 = (M : ℝ) := Real.sq_sqrt (by positivity)
  simp only [sqrtM, ← Complex.ofReal_pow, this, Complex.ofReal_natCast]

/-! ## `ψ̌_μ^†`, `ψ̌_μ` の定義（人手 `def_check_fermi`） -/

/-- 人手 `def_check_fermi` の `Ž_μ` の係数 `p_μ := -r_μ/(2√M γ_2(-θ̃_μ))`。 -/
noncomputable def checkP (K : IsingConst) (M : ℕ) (μ : ℤ) : ℂ :=
  -((checkR K M μ : ℝ) : ℂ) / (2 * sqrtM M * gamma2 K (-thetaTilde M μ))

/-- 人手 `def_check_fermi` の `Y̌_μ` の係数 `q := 1/(2√M)`（`μ` に依らない）。 -/
noncomputable def checkQ (M : ℕ) : ℂ := 1 / (2 * sqrtM M)

/-- **人手 `def_check_fermi`**: `ψ̌_μ^† := (-r/(2√M b)) Ž_μ + (1/(2√M)) Y̌_μ`。 -/
noncomputable def checkPsiDag (K : IsingConst) (M : ℕ) (μ : ℤ) : TensorPow M :=
  checkP K M μ • checkZ M μ + checkQ M • checkY M μ

/-- **人手 `def_check_fermi`**: `ψ̌_μ := (+r/(2√M b)) Ž_μ + (1/(2√M)) Y̌_μ`。 -/
noncomputable def checkPsi (K : IsingConst) (M : ℕ) (μ : ℤ) : TensorPow M :=
  (-checkP K M μ) • checkZ M μ + checkQ M • checkY M μ

/-- 人手の「すなわち」の明示式との一致（`ψ̌^†` 側）。 -/
theorem checkPsiDag_eq (K : IsingConst) (M : ℕ) (μ : ℤ) :
    checkPsiDag K M μ
      = (-((checkR K M μ : ℝ) : ℂ) / (2 * sqrtM M * gamma2 K (-thetaTilde M μ)))
          • checkZ M μ + (1 / (2 * sqrtM M)) • checkY M μ := rfl

/-- 人手の「すなわち」の明示式との一致（`ψ̌` 側）。 -/
theorem checkPsi_eq (K : IsingConst) (M : ℕ) (μ : ℤ) :
    checkPsi K M μ
      = (((checkR K M μ : ℝ) : ℂ) / (2 * sqrtM M * gamma2 K (-thetaTilde M μ)))
          • checkZ M μ + (1 / (2 * sqrtM M)) • checkY M μ := by
  rw [checkPsi, checkP, checkQ]
  congr 2
  rw [neg_div, neg_neg]

end Ising2D
