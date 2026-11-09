/-
# 半整数運動量のフェルミオン `ψ̌_μ`, `ψ̌_μ^†` の定義と、`γ_1, γ_2` の周期性

対応する人手証明（正本は `structured-latex/content/eigenvalue_problem_diagonalization_and_exponential_form.ts`）:

* `evenfermi_001_definition_check_fermi`（ラベル `def_check_fermi`）
* `evenfermi_002_claim_periodicity`（ラベル `periodicity_of_check_fermi`）

## 形式化の方針

* 原文の定義は行ベクトル記法 `(ψ̌_μ^†, ψ̌_μ) := (Ž_μ, Y̌_μ) P̌_μ` である。本ファイルは、
  原文が「すなわち」として与えている**明示式**

      ψ̌_μ^† := (-r/(2√M b)) Ž_μ + (1/(2√M)) Y̌_μ
      ψ̌_μ   := (+r/(2√M b)) Ž_μ + (1/(2√M)) Y̌_μ
      （a := γ_2(θ̃_μ), b := γ_2(-θ̃_μ), r := |a|）

  を定義として採用する。この式は 013 章（`Ž, Y̌`）と 008 章（`γ_1, γ_2`）だけで書けるので、
  `P̌_μ`（`checkPmat`、`ClaimEigenATildeDiag.lean`）を import せずに定義できる。
  行ベクトル記法との一致は `ClaimCommutationVPlusCheckPsi.lean` の `checkPsi_row_eq_rowMul_checkPmat` で確かめる。
* `r := |γ_2(θ̃_μ)|` は `Real.sqrt (Complex.normSq (γ_2(θ̃_μ)))` で表す。
  **008 章の `ψ` と違い、平方根の分枝を選ぶ仮定（`hbr`）が要らない**のはこのためである
  （原文 `anticommutator_of_check_psi` の Step 1 の指摘そのもの）。
  `r` は非負実数として一意に定まり、`(r : ℂ)^2 = -(γ_2(θ̃_μ)γ_2(-θ̃_μ))` が無条件に成り立つ
  （`checkR_sq`）。
* 原文が statement へ格上げしている「定義が意味をもつ条件」`γ_2(θ̃_μ) ≠ 0`
  （015 章の `gamma_2_theta_tilde_nonzero`）は、各定理の仮定
  `hga : gamma2 K (thetaTilde M μ) ≠ 0` として明示する。
  **015 章がこれを無条件に閉じれば、本章の仮定はそのまま消える。**
  （`γ_2(-θ̃_μ) ≠ 0` は `gamma2_neg_eq_zero_iff` から従うので別に仮定しない。）
-/
import Ising2D.EigenvalueProblem.ReductionToATheta.DefinitionThetaGamma
import Ising2D.EigenvalueProblem.DiagonalizationAndExponentialForm.ClaimConjugateIndex
import Ising2D.EigenvalueProblem.DiagonalizationAndExponentialForm.ClaimRecoverZYFromCheckZY
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimSquareOfRealNumberIsProduct

namespace Ising2D

variable {M : ℕ}

/-! ## `γ_1` の `2π` 周期性（原文 `periodicity_of_check_fermi` (1)）

`γ_2` 側（`gamma2_add_two_pi_mul_int`）は `DefinitionThetaGamma.lean` にある。 -/

/-- 原文 `periodicity_of_check_fermi` (1) の `γ_1` 側: `γ_1(θ + 2π k_ℝ) = γ_1(θ)`（人手の 3 行）。 -/
theorem gamma1_add_two_pi_mul_int (K : IsingConst) (θ : ℝ) (k : ℤ) :
    gamma1 K (θ + 2 * Real.pi * (k : ℝ)) = gamma1 K θ :=
  calc gamma1 K (θ + 2 * Real.pi * (k : ℝ))
      = ((K.c1 * K.c2star - K.s1 * K.s2star * Real.cos (θ + 2 * Real.pi * (k : ℝ)) : ℝ) : ℂ) := by
        rw [gamma1]                               -- 1 行目: `def_gamma1_gamma2_of_theta` を `θ + 2π k_ℝ` に適用
    _ = ((K.c1 * K.c2star - K.s1 * K.s2star * Real.cos θ : ℝ) : ℂ) := by
        rw [real_cos_add_two_pi_mul_int θ k]      -- 2 行目: `cos` の `2π` 周期性を `n = k` で
    _ = gamma1 K θ := by
        rw [gamma1]                               -- 3 行目: `def_gamma1_gamma2_of_theta`

/-- 原文 `periodicity_of_check_fermi` (2): `θ̃_{μ+kM} = θ̃_μ + 2π k_ℝ`。 -/
theorem thetaTilde_add_int_mul (M : ℕ) (hM : M ≠ 0) (μ k : ℤ) :
    thetaTilde M (μ + k * M) = thetaTilde M μ + 2 * Real.pi * (k : ℝ) := by
  have hM' : (M : ℝ) ≠ 0 := Nat.cast_ne_zero.2 hM
  rw [thetaTilde, thetaTilde]
  push_cast
  field_simp
  ring

/-- 原文 `periodicity_of_check_fermi` (2): `γ_1(θ̃_{μ+kM}) = γ_1(θ̃_μ)`。 -/
theorem gamma1_thetaTilde_add_int_mul (K : IsingConst) (hM : M ≠ 0) (μ k : ℤ) :
    gamma1 K (thetaTilde M (μ + k * M)) = gamma1 K (thetaTilde M μ) := by
  rw [thetaTilde_add_int_mul M hM, gamma1_add_two_pi_mul_int]

/-- 原文 `periodicity_of_check_fermi` (2): `γ_2(θ̃_{μ+kM}) = γ_2(θ̃_μ)`。 -/
theorem gamma2_thetaTilde_add_int_mul (K : IsingConst) (hM : M ≠ 0) (μ k : ℤ) :
    gamma2 K (thetaTilde M (μ + k * M)) = gamma2 K (thetaTilde M μ) := by
  rw [thetaTilde_add_int_mul M hM, gamma2_add_two_pi_mul_int]

/-- 人手 `periodicity_of_check_fermi` の準備の第二: `k ∈ ℤ` について `(-k)_ℝ = -k_ℝ`（人手の 6 行）。 -/
theorem periodicity_prep_int_cast_neg (k : ℤ) : ((-k : ℤ) : ℝ) = -(k : ℝ) :=
  calc ((-k : ℤ) : ℝ)
      = ((-k : ℤ) : ℝ) + ((k : ℝ) + (-(k : ℝ))) := by
        rw [add_neg_cancel, add_zero]             -- 1 行目: `k_ℝ + (-k_ℝ) = 0_ℝ` と零の性質
    _ = (((-k : ℤ) : ℝ) + (k : ℝ)) + (-(k : ℝ)) := (add_assoc _ _ _).symm
                                                  -- 2 行目: ℝ の加法の結合律
    _ = (((-k + k : ℤ)) : ℝ) + (-(k : ℝ)) := by
        rw [Int.cast_add]                         -- 3 行目: `ι_{ℤ→ℝ}` は和を保つ
    _ = ((0 : ℤ) : ℝ) + (-(k : ℝ)) := by
        rw [neg_add_cancel]                       -- 4 行目: ℤ で `(-k) + k = 0`
    _ = (0 : ℝ) + (-(k : ℝ)) := by
        rw [Int.cast_zero]                        -- 5 行目: `ι_{ℤ→ℝ}` は零を保つ
    _ = -(k : ℝ) := zero_add _                    -- 6 行目: 零の性質

/-- 人手 `periodicity_of_check_fermi` (2) の第二の鎖: `-θ̃_{μ+kM} = (-θ̃_μ) + 2π(-k)_ℝ`（人手の 4 行）。 -/
theorem neg_thetaTilde_add_int_mul (M : ℕ) (hM : M ≠ 0) (μ k : ℤ) :
    -thetaTilde M (μ + k * M) = -thetaTilde M μ + 2 * Real.pi * ((-k : ℤ) : ℝ) :=
  calc -thetaTilde M (μ + k * M)
      = -(thetaTilde M μ + 2 * Real.pi * (k : ℝ)) := by
        rw [thetaTilde_add_int_mul M hM]          -- 1 行目: 上の鎖（`thetaTilde_add_int_mul`）
    _ = (-thetaTilde M μ) + (-(2 * Real.pi * (k : ℝ))) := neg_add _ _
                                                  -- 2 行目: ℝ で `-(u+v) = (-u)+(-v)`
    _ = (-thetaTilde M μ) + 2 * Real.pi * (-(k : ℝ)) := by
        rw [neg_mul_eq_mul_neg]                   -- 3 行目: ℝ で `-(uv) = u(-v)`（`u → 2π`, `v → k_ℝ`）
    _ = -thetaTilde M μ + 2 * Real.pi * ((-k : ℤ) : ℝ) := by
        rw [periodicity_prep_int_cast_neg]        -- 4 行目: 準備の第二

/-- 原文 `periodicity_of_check_fermi` (2): `γ_2(-θ̃_{μ+kM}) = γ_2(-θ̃_μ)`（人手の 2 行）。 -/
theorem gamma2_neg_thetaTilde_add_int_mul (K : IsingConst) (hM : M ≠ 0) (μ k : ℤ) :
    gamma2 K (-thetaTilde M (μ + k * M)) = gamma2 K (-thetaTilde M μ) :=
  calc gamma2 K (-thetaTilde M (μ + k * M))
      = gamma2 K (-thetaTilde M μ + 2 * Real.pi * ((-k : ℤ) : ℝ)) := by
        rw [neg_thetaTilde_add_int_mul M hM]      -- 1 行目: 上の第二の鎖
    _ = gamma2 K (-thetaTilde M μ) := gamma2_add_two_pi_mul_int K (-thetaTilde M μ) (-k)
                                                  -- 2 行目: (1) を `θ = -θ̃_μ`, `-k ∈ ℤ` で

/-! ## 共役添字 `M+1-μ`（原文 `periodicity_of_check_fermi` (3)） -/

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
2 行目の人手の 1 つの恒等式 `-(u-v) = v+(-u)` は、mathlib の `neg_sub`（`-(u-v) = v-u`）と
`sub_eq_add_neg`（差の定義）を続けて読む。 -/
theorem neg_thetaTilde_conj_eq_add_two_pi_neg_one (hM : M ≠ 0) (μ : ℤ) :
    -thetaTilde M ((M : ℤ) + 1 - μ) = thetaTilde M μ + 2 * Real.pi * ((-1 : ℤ) : ℝ) :=
  calc -thetaTilde M ((M : ℤ) + 1 - μ)
      = -(2 * Real.pi - thetaTilde M μ) := by
        rw [thetaTilde_conj hM μ]                 -- 1 行目: `conjugate_index_of_check_Z_Y` (1)
    _ = thetaTilde M μ + (-(2 * Real.pi)) := by
        rw [neg_sub, sub_eq_add_neg]              -- 2 行目: ℝ で `-(u-v) = v+(-u)`
    _ = thetaTilde M μ + 2 * Real.pi * (-1) := by
        rw [mul_neg_one]                          -- 3 行目: ℝ で `-u = u(-1_ℝ)`
    _ = thetaTilde M μ + 2 * Real.pi * (-((1 : ℤ) : ℝ)) := by
        rw [Int.cast_one]                         -- 4 行目: `ι_{ℤ→ℝ}` は単位元を保つ
    _ = thetaTilde M μ + 2 * Real.pi * ((-1 : ℤ) : ℝ) := by
        rw [periodicity_prep_int_cast_neg 1]      -- 5 行目: 準備の第二を `k = 1` で

/-- 原文 `periodicity_of_check_fermi` (3): `γ_2(θ̃_{M+1-μ}) = γ_2(-θ̃_μ)`（人手の 2 行）。 -/
theorem gamma2_thetaTilde_conj (K : IsingConst) (hM : M ≠ 0) (μ : ℤ) :
    gamma2 K (thetaTilde M ((M : ℤ) + 1 - μ)) = gamma2 K (-thetaTilde M μ) :=
  calc gamma2 K (thetaTilde M ((M : ℤ) + 1 - μ))
      = gamma2 K (-thetaTilde M μ + 2 * Real.pi * ((1 : ℤ) : ℝ)) := by
        rw [thetaTilde_conj_eq_neg_add_two_pi hM] -- 1 行目: 上の `θ̃_ν` の鎖
    _ = gamma2 K (-thetaTilde M μ) := gamma2_add_two_pi_mul_int K (-thetaTilde M μ) 1
                                                  -- 2 行目: (1) を `θ = -θ̃_μ`, `k = 1` で

/-- 原文 `periodicity_of_check_fermi` (3): `γ_2(-θ̃_{M+1-μ}) = γ_2(θ̃_μ)`（人手の 2 行）。 -/
theorem gamma2_neg_thetaTilde_conj (K : IsingConst) (hM : M ≠ 0) (μ : ℤ) :
    gamma2 K (-thetaTilde M ((M : ℤ) + 1 - μ)) = gamma2 K (thetaTilde M μ) :=
  calc gamma2 K (-thetaTilde M ((M : ℤ) + 1 - μ))
      = gamma2 K (thetaTilde M μ + 2 * Real.pi * ((-1 : ℤ) : ℝ)) := by
        rw [neg_thetaTilde_conj_eq_add_two_pi_neg_one hM]
                                                  -- 1 行目: 上の `-θ̃_ν` の鎖
    _ = gamma2 K (thetaTilde M μ) := gamma2_add_two_pi_mul_int K (thetaTilde M μ) (-1)
                                                  -- 2 行目: (1) を `θ = θ̃_μ`, `k = -1` で

/-- 原文 `periodicity_of_check_fermi` (3): `γ_1(θ̃_{M+1-μ}) = γ_1(θ̃_μ)`。
人手の 5 行のうち 1・2 行目は 1 対 1 の段である。3〜5 行目（`def_gamma1_gamma2_of_theta` の展開、
準備の `cos(-x) = cos x`、`def_gamma1_gamma2_of_theta`）は `gamma1_neg`（mathlib の `Real.cos_neg`）で受けている。 -/
theorem gamma1_thetaTilde_conj (K : IsingConst) (hM : M ≠ 0) (μ : ℤ) :
    gamma1 K (thetaTilde M ((M : ℤ) + 1 - μ)) = gamma1 K (thetaTilde M μ) :=
  calc gamma1 K (thetaTilde M ((M : ℤ) + 1 - μ))
      = gamma1 K (-thetaTilde M μ + 2 * Real.pi * ((1 : ℤ) : ℝ)) := by
        rw [thetaTilde_conj_eq_neg_add_two_pi hM] -- 1 行目: 上の `θ̃_ν` の鎖
    _ = gamma1 K (-thetaTilde M μ) := gamma1_add_two_pi_mul_int K (-thetaTilde M μ) 1
                                                  -- 2 行目: (1) を `θ = -θ̃_μ`, `k = 1` で
    _ = gamma1 K (thetaTilde M μ) := gamma1_neg K (thetaTilde M μ)
                                                  -- 3〜5 行目（上の注記）

/-! ## `r := |γ_2(θ̃_μ)|` -/

/-- 原文 `def_check_fermi` の `r := |γ_2(θ̃_μ)| ∈ ℝ_{≥0}`。

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

/-- 原文 `anticommutator_of_check_psi` の準備 5 の `r_ν` の鎖: `r_{M+1-μ} = r_μ`。

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

/-! ## `√M`（原文 `def_check_fermi` の係数の分母） -/

/-- 原文 `def_check_fermi` の `√M`（`M ∈ ℕ` の実数の平方根）を ℂ の元として。 -/
noncomputable def sqrtM (M : ℕ) : ℂ := (Real.sqrt M : ℂ)

/-- `M ≠ 0` のとき `√M ≠ 0`（`def_check_fermi` の係数の分母が 0 でないこと。
`diagonalization_check_P_D` Step 1 の `√M > 0` もこれを引く）。 -/
theorem sqrtM_ne_zero {M : ℕ} (hM : M ≠ 0) : sqrtM M ≠ 0 := by
  simp only [sqrtM, ne_eq, Complex.ofReal_eq_zero]
  exact Real.sqrt_ne_zero'.2 (by exact_mod_cast Nat.pos_of_ne_zero hM)

/-- `(√M)^2 = M`。 -/
@[simp]
theorem sqrtM_sq (M : ℕ) : sqrtM M ^ 2 = (M : ℂ) := by
  have : Real.sqrt M ^ 2 = (M : ℝ) := Real.sq_sqrt (by positivity)
  simp only [sqrtM, ← Complex.ofReal_pow, this, Complex.ofReal_natCast]

/-! ## `ψ̌_μ^†`, `ψ̌_μ` の定義（原文 `def_check_fermi`） -/

/-- 原文 `def_check_fermi` の `Ž_μ` の係数 `p_μ := -r_μ/(2√M γ_2(-θ̃_μ))`。 -/
noncomputable def checkP (K : IsingConst) (M : ℕ) (μ : ℤ) : ℂ :=
  -((checkR K M μ : ℝ) : ℂ) / (2 * sqrtM M * gamma2 K (-thetaTilde M μ))

/-- 原文 `def_check_fermi` の `Y̌_μ` の係数 `q := 1/(2√M)`（`μ` に依らない）。 -/
noncomputable def checkQ (M : ℕ) : ℂ := 1 / (2 * sqrtM M)

/-- **原文 `def_check_fermi`**: `ψ̌_μ^† := (-r/(2√M b)) Ž_μ + (1/(2√M)) Y̌_μ`。 -/
noncomputable def checkPsiDag (K : IsingConst) (M : ℕ) (μ : ℤ) : TensorPow M :=
  checkP K M μ • checkZ M μ + checkQ M • checkY M μ

/-- **原文 `def_check_fermi`**: `ψ̌_μ := (+r/(2√M b)) Ž_μ + (1/(2√M)) Y̌_μ`。 -/
noncomputable def checkPsi (K : IsingConst) (M : ℕ) (μ : ℤ) : TensorPow M :=
  (-checkP K M μ) • checkZ M μ + checkQ M • checkY M μ

/-- 原文の「すなわち」の明示式との一致（`ψ̌^†` 側）。 -/
theorem checkPsiDag_eq (K : IsingConst) (M : ℕ) (μ : ℤ) :
    checkPsiDag K M μ
      = (-((checkR K M μ : ℝ) : ℂ) / (2 * sqrtM M * gamma2 K (-thetaTilde M μ)))
          • checkZ M μ + (1 / (2 * sqrtM M)) • checkY M μ := rfl

/-- 原文の「すなわち」の明示式との一致（`ψ̌` 側）。 -/
theorem checkPsi_eq (K : IsingConst) (M : ℕ) (μ : ℤ) :
    checkPsi K M μ
      = (((checkR K M μ : ℝ) : ℂ) / (2 * sqrtM M * gamma2 K (-thetaTilde M μ)))
          • checkZ M μ + (1 / (2 * sqrtM M)) • checkY M μ := by
  rw [checkPsi, checkP, checkQ]
  congr 2
  rw [neg_div, neg_neg]

end Ising2D
