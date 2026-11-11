/-
# 章 016 の `ψ̌` で `Ising2D.CheckFermi` の仮定を埋める

正本: `structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts`（`check_number_operator_is_hermitian` (3)）
および `content/eigenvalue_problem_diagonalization_and_exponential_form.ts`（`def_check_fermi`, `anticommutator_of_check_psi`）。

## 経緯（一次情報）

章 018 の形式化に着手した時点で `Ising2D/Part016/` は存在せず、`Ising2D.CheckFermi`
（`EigenvalueProblem/EigenvectorOfMaxEigenvalue/CheckFermiInput.lean`）は `ψ̌_μ^†, ψ̌_μ` の正準反交換関係と `(ψ̌_μ^†)^* = ψ̌_{M+1-μ}` を
**仮定として**受け取っていた（`lean/docs/ch018-formalization.md` の 0 章の表）。

その後 `Ising2D/Part016/` が main に入り、`Ising2D.checkPsi_car'`
（`EigenvalueProblem/DiagonalizationAndExponentialForm/ClaimCheckFermiResultsUnconditional.lean`）が CAR を**無条件に**（仮定は `M ≠ 0` だけ）
与えるようになった。本ファイルはそれを使って `CheckFermi` の
**インスタンスを実際に構成する**（`Ising2D.checkFermiOf`）。

`hstar`（`(ψ̌_μ^†)^* = ψ̌_{M+1-μ}`）だけは章 016 側に対応する定理が無かったので、
`Ising2D.checkZ_conjTranspose` / `checkY_conjTranspose`
（`ThermodynamicLimit/ColumnLimitAndClosedForm/ClaimCheckQHermitian.lean`）と、係数の共役 `star_checkP` から
本ファイルで証明する（`checkPsiDag_conjTranspose`）。`star_checkP` は人手 `check_number_operator_is_hermitian` (3) の
`\overline{α_μ} = -α_ν` の主鎖 13 行と準備 (a)〜(d) に 1 段ずつ対応し、`complex_conjugate_of_inverse`・`checkD_ne_zero`・
`gamma2_neg_thetaTilde_eq`・`gamma2_thetaTilde_conj`・`gamma2_neg_thetaTilde_conj` を使う。これが**噛み合わせのための橋渡し補題**である。
-/
import Ising2D.ThermodynamicLimit.ColumnLimitAndClosedForm.ClaimCheckQHermitian
import Ising2D.EigenvalueProblem.DiagonalizationAndExponentialForm.ClaimCheckFermiResultsUnconditional
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimComplexConjugateOfInverse

namespace Ising2D

open Matrix

variable {M : ℕ}

/-! ## 係数の複素共役 -/

/-- `q = 1/(2√M)` は実数なので共役で不変。 -/
theorem star_checkQ (M : ℕ) : star (checkQ M) = checkQ M := by
  have h : checkQ M = ((1 / (2 * Real.sqrt M) : ℝ) : ℂ) := by
    rw [checkQ, sqrtM]; push_cast; ring
  rw [h, Complex.star_def, Complex.conj_ofReal]

/-- 人手 `check_number_operator_is_hermitian` (3) の準備 (b): `\overline{u} = u`（`u := 2_ℂ s`、`s := (√M_col)_ℂ`。人手の 5 行）。 -/
theorem star_two_mul_sqrtM (M : ℕ) : (starRingEnd ℂ) (2 * sqrtM M) = 2 * sqrtM M :=
  calc (starRingEnd ℂ) (2 * sqrtM M)
      = (starRingEnd ℂ) 2 * (starRingEnd ℂ) (sqrtM M) := complex_conjugate_of_product_eq 2 (sqrtM M)
                                      -- 2 行目: `complex_conjugate_of_product`（`z → 2_ℂ`, `w → s`）（1 行目の `u` の定義は `rfl`）
    _ = (starRingEnd ℂ) ((2 : ℝ) : ℂ) * (starRingEnd ℂ) (sqrtM M) := by rw [Complex.ofReal_ofNat]
                                      -- `2_ℂ` は略記 `r_ℂ` の `r = 2`（Lean のリテラル `(2 : ℂ)` との読み替え）
    _ = ((2 : ℝ) : ℂ) * (starRingEnd ℂ) (sqrtM M) := by rw [conj_real_inclusion 2]
                                      -- 3 行目: `complex_conjugate_of_real_inclusion`（`r → 2`）
    _ = ((2 : ℝ) : ℂ) * sqrtM M := by rw [sqrtM, conj_real_inclusion (Real.sqrt M)]
                                      -- 4 行目: `complex_conjugate_of_real_inclusion`（`r → √M_col`。`s` の定義）
    _ = 2 * sqrtM M := by rw [Complex.ofReal_ofNat]
                                      -- 略記の読み替え（5 行目の `u` の定義は `rfl`）

/-- 人手 `check_number_operator_is_hermitian` (3) の準備 (a): `r ∈ ℝ` について `\overline{-(r_ℂ)} = -(r_ℂ)`（人手の 5 行）。 -/
theorem star_neg_real_inclusion (r : ℝ) : (starRingEnd ℂ) (-(r : ℂ)) = -(r : ℂ) :=
  calc (starRingEnd ℂ) (-(r : ℂ))
      = (starRingEnd ℂ) ((-1) * (r : ℂ)) := by rw [neg_one_mul]
                                      -- 1 行目: `multiply_by_minus_one`
    _ = (starRingEnd ℂ) (-1) * (starRingEnd ℂ) (r : ℂ) := complex_conjugate_of_product_eq _ _
                                      -- 2 行目: `complex_conjugate_of_product`（`z → -1_ℂ`, `w → r_ℂ`）
    _ = (starRingEnd ℂ) ((-1 : ℝ) : ℂ) * (starRingEnd ℂ) (r : ℂ) := by
        rw [Complex.ofReal_neg, Complex.ofReal_one]
                                      -- `-1_ℂ` は略記 `r_ℂ` の `r = -1`（`inclusion_rr_to_cc`）
    _ = ((-1 : ℝ) : ℂ) * (starRingEnd ℂ) (r : ℂ) := by rw [conj_real_inclusion (-1)]
                                      -- 3 行目: `complex_conjugate_of_real_inclusion`（`r → -1`）
    _ = (-1) * (starRingEnd ℂ) (r : ℂ) := by rw [Complex.ofReal_neg, Complex.ofReal_one]
                                      -- 略記の読み替え
    _ = (-1) * (r : ℂ) := by rw [conj_real_inclusion r]
                                      -- 4 行目: `complex_conjugate_of_real_inclusion`（`r → r`）
    _ = -(r : ℂ) := neg_one_mul _     -- 5 行目: `multiply_by_minus_one` を右辺から左辺へ

/-- 人手 `check_number_operator_is_hermitian` (3) の準備 (c) の前半: `\overline{b_μ} = (-1_ℂ)γ_2(θ̃_μ)`
（`b_μ := γ_2(-θ̃_μ)`、`ν := M_col+1-μ`。人手の 8 行）。 -/
theorem star_gamma2_neg_thetaTilde (K : IsingConst) (hM : M ≠ 0) (μ : ℤ) :
    (starRingEnd ℂ) (gamma2 K (-thetaTilde M μ)) = (-1) * gamma2 K (thetaTilde M μ) :=
  calc (starRingEnd ℂ) (gamma2 K (-thetaTilde M μ))
      = (starRingEnd ℂ) (gamma2 K (thetaTilde M ((M : ℤ) + 1 - μ))) := by
        rw [gamma2_thetaTilde_conj K hM μ]
                                      -- 2 行目: `periodicity_of_check_fermi` (3) の `γ_2(θ̃_ν) = γ_2(-θ̃_μ)` を右辺から左辺へ
                                      -- （1 行目の `b_μ` の定義は `rfl`）
    _ = 1 * (starRingEnd ℂ) (gamma2 K (thetaTilde M ((M : ℤ) + 1 - μ))) := (one_mul _).symm
                                      -- 3 行目: `complex_numbers_form_a_field` の積の単位元を右辺から左辺へ
    _ = ((-1) * (-1)) * (starRingEnd ℂ) (gamma2 K (thetaTilde M ((M : ℤ) + 1 - μ))) := by
        rw [complex_minus_one_mul_minus_one]
                                      -- 4 行目: `minus_one_times_minus_one_is_one_in_cc` を右辺から左辺へ
    _ = (-1) * ((-1) * (starRingEnd ℂ) (gamma2 K (thetaTilde M ((M : ℤ) + 1 - μ)))) := mul_assoc _ _ _
                                      -- 5 行目: `complex_numbers_form_a_field` の積の結合律
    _ = (-1) * (-(starRingEnd ℂ) (gamma2 K (thetaTilde M ((M : ℤ) + 1 - μ)))) :=
        congrArg ((-1) * ·) (neg_one_mul _)
                                      -- 6 行目: `multiply_by_minus_one` を右辺から左辺へ
    _ = (-1) * gamma2 K (-thetaTilde M ((M : ℤ) + 1 - μ)) := by
        rw [gamma2_neg_thetaTilde_eq K M ((M : ℤ) + 1 - μ)]
                                      -- 7 行目: `relation_of_gamma_2_theta_tilde` (1)（`μ → ν`）を右辺から左辺へ
    _ = (-1) * gamma2 K (thetaTilde M μ) := by rw [gamma2_neg_thetaTilde_conj K hM μ]
                                      -- 8 行目: `periodicity_of_check_fermi` (3) の `γ_2(-θ̃_ν) = γ_2(θ̃_μ)`

/-- 人手 `check_number_operator_is_hermitian` (3) の準備 (c): `\overline{d_μ} = (-1_ℂ)d_ν`
（`d_μ := u b_μ`、`d_ν := u b_ν`、`u := 2_ℂ s`。人手の 10 行）。 -/
theorem star_checkD (K : IsingConst) (hM : M ≠ 0) (μ : ℤ) :
    (starRingEnd ℂ) (2 * sqrtM M * gamma2 K (-thetaTilde M μ))
      = (-1) * (2 * sqrtM M * gamma2 K (-thetaTilde M ((M : ℤ) + 1 - μ))) :=
  calc (starRingEnd ℂ) (2 * sqrtM M * gamma2 K (-thetaTilde M μ))
      = (starRingEnd ℂ) (2 * sqrtM M) * (starRingEnd ℂ) (gamma2 K (-thetaTilde M μ)) :=
        complex_conjugate_of_product_eq _ _
                                      -- 2 行目: `complex_conjugate_of_product`（`z → u`, `w → b_μ`）（1 行目の `d_μ` の定義は `rfl`）
    _ = (2 * sqrtM M) * (starRingEnd ℂ) (gamma2 K (-thetaTilde M μ)) := by rw [star_two_mul_sqrtM]
                                      -- 3 行目: 準備 (b)
    _ = (2 * sqrtM M) * ((-1) * gamma2 K (thetaTilde M μ)) := by rw [star_gamma2_neg_thetaTilde K hM μ]
                                      -- 4 行目: 上の `\overline{b_μ}` の鎖
    _ = ((2 * sqrtM M) * (-1)) * gamma2 K (thetaTilde M μ) := (mul_assoc _ _ _).symm
                                      -- 5 行目: `complex_numbers_form_a_field` の積の結合律を右辺から左辺へ
    _ = ((-1) * (2 * sqrtM M)) * gamma2 K (thetaTilde M μ) := by rw [mul_comm (2 * sqrtM M) (-1)]
                                      -- 6 行目: `complex_numbers_form_a_field` の積の可換律
    _ = (-1) * ((2 * sqrtM M) * gamma2 K (thetaTilde M μ)) := mul_assoc _ _ _
                                      -- 7 行目: `complex_numbers_form_a_field` の積の結合律
    _ = (-1) * (2 * sqrtM M * gamma2 K (-thetaTilde M ((M : ℤ) + 1 - μ))) := by
        rw [gamma2_neg_thetaTilde_conj K hM μ]
                                      -- 8 行目: `periodicity_of_check_fermi` (3) の `γ_2(-θ̃_ν) = γ_2(θ̃_μ)` を右辺から左辺へ
                                      -- （9・10 行目の `b_ν`・`d_ν` の定義は `rfl`）

/-- 人手 `check_number_operator_is_hermitian` (3) の準備 (d) の前置き: `-1_ℂ = (-1,0) ≠ (0,0)`（`inclusion_rr_to_cc`。第 1 成分が `0` でない）。 -/
theorem check_hermitian_prep_neg_one_ne_zero : (-1 : ℂ) ≠ 0 := by
  intro h
  have hre : (-1 : ℂ).re = (0 : ℂ).re := congrArg Complex.re h
                                      -- 仮定 `-1_ℂ = 0_ℂ` の第 1 成分（`definition_of_cc` の等号は成分ごと）
  have h1 : (-1 : ℝ) = 0 :=
    calc (-1 : ℝ)
        = ((-1 : ℝ) : ℂ).re := (Complex.ofReal_re _).symm
                                      -- `inclusion_rr_to_cc`: `-1_ℂ = (-1, 0)` の第 1 成分を右辺から左辺へ
      _ = (-1 : ℂ).re := by rw [Complex.ofReal_neg, Complex.ofReal_one]
                                      -- `-1_ℂ` は略記 `r_ℂ` の `r = -1`（Lean の `-1 : ℂ` との読み替え）
      _ = (0 : ℂ).re := hre           -- 仮定の第 1 成分
      _ = 0 := Complex.zero_re        -- `0_ℂ = (0, 0)` の第 1 成分
  exact (by norm_num : (-1 : ℝ) ≠ 0) h1
                                      -- 第 1 成分が `ℝ` で `-1 ≠ 0`

/-- 人手 `check_number_operator_is_hermitian` (3) の準備 (d) の第一の鎖: `t((-1_ℂ)d^{-1}) = 1_ℂ`（`t := (-1_ℂ)d`、`d ∈ ℂ^×`。人手の 9 行）。 -/
theorem check_hermitian_prep_neg_one_mul_inv {d : ℂ} (hd : d ≠ 0) :
    ((-1) * d) * ((-1) * d⁻¹) = 1 :=
  calc ((-1) * d) * ((-1) * d⁻¹)
      = (-1) * (d * ((-1) * d⁻¹)) := mul_assoc _ _ _
                                      -- 2 行目: `complex_numbers_form_a_field` の積の結合律（1 行目の `t` の定義は `rfl`）
    _ = (-1) * ((d * (-1)) * d⁻¹) := by rw [← mul_assoc d (-1) d⁻¹]
                                      -- 3 行目: `complex_numbers_form_a_field` の積の結合律を右辺から左辺へ
    _ = (-1) * (((-1) * d) * d⁻¹) := by rw [mul_comm d (-1)]
                                      -- 4 行目: `complex_numbers_form_a_field` の積の可換律
    _ = (-1) * ((-1) * (d * d⁻¹)) := by rw [mul_assoc (-1) d d⁻¹]
                                      -- 5 行目: `complex_numbers_form_a_field` の積の結合律
    _ = ((-1) * (-1)) * (d * d⁻¹) := (mul_assoc _ _ _).symm
                                      -- 6 行目: `complex_numbers_form_a_field` の積の結合律を右辺から左辺へ
    _ = 1 * (d * d⁻¹) := by rw [complex_minus_one_mul_minus_one]
                                      -- 7 行目: `minus_one_times_minus_one_is_one_in_cc`
    _ = 1 * 1 := by rw [mul_inv_cancel₀ hd]
                                      -- 8 行目: `multiplicative_group_of_cc` の逆元（`d ∈ ℂ^×`）
    _ = 1 := one_mul 1                -- 9 行目: `complex_numbers_form_a_field` の積の単位元

/-- 人手 `check_number_operator_is_hermitian` (3) の準備 (d): `((-1_ℂ)d)^{-1} = (-1_ℂ)d^{-1}`（`d ∈ ℂ^×`。人手の第二の鎖 5 行）。 -/
theorem check_hermitian_prep_inv_neg_one_mul {d : ℂ} (hd : d ≠ 0) :
    ((-1) * d)⁻¹ = (-1) * d⁻¹ := by
  have ht : (-1) * d ≠ 0 := mul_ne_zero check_hermitian_prep_neg_one_ne_zero hd
                                      -- `t = (-1_ℂ)d ∈ ℂ^×`（`multiplicative_group_of_cc` の群の積）
  calc ((-1) * d)⁻¹
      = ((-1) * d)⁻¹ * 1 := (mul_one _).symm
                                      -- 1 行目: `complex_numbers_form_a_field` の積の単位元を右辺から左辺へ
    _ = ((-1) * d)⁻¹ * (((-1) * d) * ((-1) * d⁻¹)) := by rw [check_hermitian_prep_neg_one_mul_inv hd]
                                      -- 2 行目: 第一の鎖を右辺から左辺へ
    _ = (((-1) * d)⁻¹ * ((-1) * d)) * ((-1) * d⁻¹) := (mul_assoc _ _ _).symm
                                      -- 3 行目: `complex_numbers_form_a_field` の積の結合律を右辺から左辺へ
    _ = 1 * ((-1) * d⁻¹) := by rw [inv_mul_cancel₀ ht]
                                      -- 4 行目: `multiplicative_group_of_cc` の逆元（`t ∈ ℂ^×`）
    _ = (-1) * d⁻¹ := one_mul _       -- 5 行目: `complex_numbers_form_a_field` の積の単位元

/-- **人手 `check_number_operator_is_hermitian` (3) の `\overline{α_μ} = -α_ν`**（人手の主鎖 13 行）。
`α_μ` は Lean の `checkP K M μ = -(r_ℂ)/(2 √M γ_2(-θ̃_μ))`（`def_check_fermi` の読みの `(-(r_ℂ))/d_μ`）、
`-α_ν` の `α_ν` は `checkP K M ν`（`ν := M+1-μ`）で、分子の `r_ν` は `checkR_conj` で `r_μ` に等しい。
引数が `IsingParam`（結合定数が正）なのは、`d_μ, d_ν ∈ ℂ^×`（`checkD_ne_zero`、人手の `diagonalization_check_P_D` Step 1）に
`γ_2(-θ̃) ≠ 0` が要り、それが結合定数の正値性を使うからである。 -/
theorem star_checkP (P : IsingParam) (hM : M ≠ 0) (μ : ℤ) :
    star (checkP P.const M μ) = -checkP P.const M ((M : ℤ) + 1 - μ) := by
  set r : ℂ := ((checkR P.const M μ : ℝ) : ℂ) with hr
  set dμ : ℂ := 2 * sqrtM M * gamma2 P.const (-thetaTilde M μ) with hdμ
  set dν : ℂ := 2 * sqrtM M * gamma2 P.const (-thetaTilde M ((M : ℤ) + 1 - μ)) with hdν
  have hdμ0 : dμ ≠ 0 := checkD_ne_zero P hM μ
                                      -- `d_μ ∈ ℂ^×`（`diagonalization_check_P_D` の Step 1 を `μ` に）
  have hdν0 : dν ≠ 0 := checkD_ne_zero P hM ((M : ℤ) + 1 - μ)
                                      -- `d_ν ∈ ℂ^×`（同じ Step 1 を `ν` に）
  calc star (checkP P.const M μ)
      = (starRingEnd ℂ) ((-r) / dμ) := rfl
                                      -- 1 行目: 前置きの `α_μ = (-(r_ℂ))/d_μ`（`def_check_fermi` の読み。Lean の `checkP` の定義）
    _ = (starRingEnd ℂ) ((-r) * dμ⁻¹) := by rw [div_eq_mul_inv]
                                      -- 2 行目: `def_complex_quotient`（`z → -(r_ℂ)`, `w → d_μ`）
    _ = (starRingEnd ℂ) (-r) * (starRingEnd ℂ) dμ⁻¹ := complex_conjugate_of_product_eq _ _
                                      -- 3 行目: `complex_conjugate_of_product`（`z → -(r_ℂ)`, `w → d_μ^{-1}`）
    _ = (-r) * (starRingEnd ℂ) dμ⁻¹ := by rw [hr, star_neg_real_inclusion]
                                      -- 4 行目: 準備 (a)
    _ = (-r) * ((starRingEnd ℂ) dμ)⁻¹ := by rw [complex_conjugate_of_inverse hdμ0]
                                      -- 5 行目: `complex_conjugate_of_inverse`（`w → d_μ`）
    _ = (-r) * ((-1) * dν)⁻¹ := by rw [hdμ, star_checkD P.const hM μ]
                                      -- 6 行目: 準備 (c)
    _ = (-r) * ((-1) * dν⁻¹) := by rw [check_hermitian_prep_inv_neg_one_mul hdν0]
                                      -- 7 行目: 準備 (d)
    _ = ((-r) * (-1)) * dν⁻¹ := (mul_assoc _ _ _).symm
                                      -- 8 行目: `complex_numbers_form_a_field` の積の結合律を右辺から左辺へ
    _ = ((-1) * (-r)) * dν⁻¹ := by rw [mul_comm (-r) (-1)]
                                      -- 9 行目: `complex_numbers_form_a_field` の積の可換律
    _ = (-1) * ((-r) * dν⁻¹) := mul_assoc _ _ _
                                      -- 10 行目: `complex_numbers_form_a_field` の積の結合律
    _ = (-1) * ((-r) / dν) := by rw [div_eq_mul_inv]
                                      -- 11 行目: `def_complex_quotient`（`z → -(r_ℂ)`, `w → d_ν`）を右辺から左辺へ
    _ = (-1) * checkP P.const M ((M : ℤ) + 1 - μ) := by
        rw [checkP, checkR_conj P.const hM μ]
                                      -- 12 行目: 前置きの `α_ν = (-(r_ℂ))/d_ν`（`r_ν = r` は `checkR_conj`）を右辺から左辺へ
    _ = -checkP P.const M ((M : ℤ) + 1 - μ) := neg_one_mul _
                                      -- 13 行目: `multiply_by_minus_one` を右辺から左辺へ

/-! ## `(ψ̌_μ^†)^* = ψ̌_{M+1-μ}` -/

/-- **原文 `check_number_operator_is_hermitian` (3)**: `(ψ̌_μ^†)^* = ψ̌_{M+1-μ}`。

`Ising2D.CheckFermi` の場 `hstar` を埋める補題である。 -/
theorem checkPsiDag_conjTranspose (P : IsingParam) (hM : M ≠ 0) (μ : ℤ) :
    (checkPsiDag P.const M μ)ᴴ = checkPsi P.const M ((M : ℤ) + 1 - μ) := by
  rw [checkPsiDag, checkPsi, Matrix.conjTranspose_add, Matrix.conjTranspose_smul,
    Matrix.conjTranspose_smul, checkZ_conjTranspose hM, checkY_conjTranspose hM,
    star_checkP P hM μ, star_checkQ M]

/-! ## `CheckFermi` のインスタンス -/

/-- **章 016 から `Ising2D.CheckFermi` を構成する**（仮定は `M ≠ 0` だけ）。

`cre j` は `ψ̌_{j+1}^†`、`ann j` は `ψ̌_{M+1-(j+1)}` である
（`EigenvalueProblem/EigenvectorOfMaxEigenvalue/CheckFermiInput.lean` の `CheckFermi` の添字づけと同じ）。 -/
noncomputable def checkFermiOf (P : IsingParam) {M : ℕ} (hM : M ≠ 0) : CheckFermi M where
  cre j := checkPsiDag P.const M (checkIdx M j)
  ann j := checkPsi P.const M ((M : ℤ) + 1 - checkIdx M j)
  hcre j := ⟨checkIdx M j, checkP P.const M (checkIdx M j), checkQ M, rfl⟩
  hann j := ⟨(M : ℤ) + 1 - checkIdx M j, -checkP P.const M ((M : ℤ) + 1 - checkIdx M j),
    checkQ M, rfl⟩
  acomm_cre_cre i j := by
    have h := (checkPsi_car' P hM (checkIndex_checkIdx M i) (checkIndex_checkIdx M j)).1
    simpa [acomm] using h
  acomm_ann_ann i j := by
    have hi : CheckIndex M ((M : ℤ) + 1 - checkIdx M i) := by
      rw [checkIdx_rev]; exact checkIndex_checkIdx M (Fin.rev i)
    have hj : CheckIndex M ((M : ℤ) + 1 - checkIdx M j) := by
      rw [checkIdx_rev]; exact checkIndex_checkIdx M (Fin.rev j)
    have h := (checkPsi_car' P hM hi hj).2.2
    simpa [acomm] using h
  acomm_cre_ann i j := by
    have hj : CheckIndex M ((M : ℤ) + 1 - checkIdx M j) := by
      rw [checkIdx_rev]; exact checkIndex_checkIdx M (Fin.rev j)
    have h := (checkPsi_car' P hM (checkIndex_checkIdx M i) hj).2.1
    rw [acomm] at h
    rw [h]
    by_cases hij : i = j
    · subst hij
      rw [if_pos rfl, if_pos rfl, one_smul]
    · have hne : ¬((M : ℤ) + 1 - checkIdx M j = (M : ℤ) + 1 - checkIdx M i) := by
        intro hc
        exact hij (checkIdx_injective M (by omega)).symm
      rw [if_neg hne, if_neg hij, zero_smul]
  hstar j := checkPsiDag_conjTranspose P hM (checkIdx M j)

@[simp]
theorem checkFermiOf_cre (P : IsingParam) (hM : M ≠ 0) (j : Fin M) :
    (checkFermiOf P hM).cre j = checkPsiDag P.const M (checkIdx M j) := rfl

@[simp]
theorem checkFermiOf_ann (P : IsingParam) (hM : M ≠ 0) (j : Fin M) :
    (checkFermiOf P hM).ann j = checkPsi P.const M ((M : ℤ) + 1 - checkIdx M j) := rfl

/-- `ň_μ = ψ̌_μ^† ψ̌_{M+1-μ}`（章 016 の `checkX` の被加数と同じ形）。 -/
theorem checkFermiOf_nOp (P : IsingParam) (hM : M ≠ 0) (j : Fin M) :
    (checkFermiOf P hM).nOp j
      = checkPsiDag P.const M (checkIdx M j) * checkPsi P.const M ((M : ℤ) + 1 - checkIdx M j) :=
  rfl

end Ising2D
