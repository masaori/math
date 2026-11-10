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

* 人手証明は、準備（像の読み方）、第一の準備の 7 本の鎖、第二の準備の 3 本の鎖、第三の準備（三つの双曲線の関係）、
  主張の左辺から始まる 4 本の鎖（第 2・第 1・第 3・最後の等式）から成る。鎖ごとに、人手の行と 1 段ずつの `calc` を置く。
  `θ := θ~_μ`、`u := cos θ`、`v := sin θ` は `ℂ` へ埋めた `(Real.cos θ : ℂ)`・`(Real.sin θ : ℂ)` で書く
  （`γ_1, γ_2` が `ℂ` の元として定義されているため）。
  * 第三の準備の三つの双曲線の関係: `c_1^2 - s_1^2 = 1` は `IsingParam.c1_sq_sub_s1_sq`（`ℂ` の式として `IsingParam.c1_sq_sub_s1_sq_inclusion`）、
    `(c_2^*)^2 - (s_2^*)^2 = 1` は `IsingParam.c2star_sq_sub_s2star_sq`（同 `IsingParam.c2star_sq_sub_s2star_sq_inclusion`）、
    `c_2 s_2^* = c_2^*` は引数 `hdual`（`ℂ` の式として `c2_mul_s2star_inclusion`）。
  * 第一の準備の 7 本の鎖 `-(-z) = z`・`ii = -1_ℂ`・`e_+e_- = 1_ℂ`・`(x - iy)(x + iy) = x^2 + y^2`・
    `(x - y)^2 = x^2 - 2_ℂ(xy) + y^2`・`u + iv = e_+`・`u^2 + v^2 = 1_ℂ` は `complex_neg_neg_chain`・
    `complex_I_mul_I_chain`・`exp_I_mul_exp_neg_I_mul`・`complex_sub_I_mul_mul_add_I_mul`・`complex_sub_sq_chain`・
    `complex_cos_add_I_mul_sin_chain`・`cos_sq_add_sin_sq_complex_chain` である。
  * 第二の準備の `γ_2(θ)`・`γ_2(-θ)`・積の 3 本の鎖は `gamma2_a0_form`・`gamma2_neg_a0_form`・`gamma2_mul_gamma2_neg_sin_form` である。
  * 第 2 の等式の鎖: 1〜29 行（展開と `c_2s_2^* = c_2^*` による `c_2` の消去）は `gamma1_sq_add_gamma2_mul_chain_first_half`、
    30〜57 行（`u` の 1 次の項の相殺、くくり出し、双曲線の関係の代入）は `gamma1_sq_add_gamma2_mul_chain_second_half`、
    鎖全体は `gamma1_sq_add_gamma2_mul_thetaTilde` である。
  * 第 1 の等式の鎖: 1〜9 行は `det_AMat_eq_gamma1_sq_add`、10 行目（上の第 2 の等式の鎖）を当てた主張は `det_AMat_thetaTilde_eq_one`。
  * 第 3 の等式の鎖と対の比較は `lambda_mul_lambda_thetaTilde`。
  * 最後の等式 `γ_1^2 = 1 + r^2` は `gamma1R_sq_thetaTilde`。
* **双対関係が要る。** `det A(θ) = 1` は `A(θ)` の定義だけからは出ず、
  (iii) `c_2 s_2^* = c_2^*`（双対関係 `sinh 2K_2 · sinh 2K_2^* = 1` の帰結）が要る。
  人手証明の第三の準備は (iii) を `duality_c2_star_eq_s2_star_c2` として引用している。
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
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesDifference
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimExpOfNegativeIRealAsCosMinusISin
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimMinusOneTimesMinusOneIsOneInCC

namespace Ising2D

variable (P : IsingParam)

/-- (i) `c_1^2 - s_1^2 = 1`（`cosh^2 - sinh^2 = 1`）。 -/
theorem IsingParam.c1_sq_sub_s1_sq : P.const.c1 ^ 2 - P.const.s1 ^ 2 = 1 := by
  simp [IsingParam.const, Real.cosh_sq_sub_sinh_sq]

/-- (ii) `(c_2^*)^2 - (s_2^*)^2 = 1`。 -/
theorem IsingParam.c2star_sq_sub_s2star_sq : P.const.c2star ^ 2 - P.const.s2star ^ 2 = 1 := by
  simp [IsingParam.const, Real.cosh_sq_sub_sinh_sq]

/-- 実数の 2 乗の像は像の 2 乗: `(c_ℂ)^2 = (c^2)_ℂ`（`c ∈ ℝ`）。人手 `det_A_theta_tilde` の最後の等式の鎖の最初の 3 行
（`square_of_real_number_is_product`・`real_inclusion_preserves_product`・`def_power_of_complex_number`）を、右辺から左辺へ並べた。 -/
theorem real_inclusion_sq_via_product (c : ℝ) : (c : ℂ) ^ 2 = ((c ^ 2 : ℝ) : ℂ) :=
  calc (c : ℂ) ^ 2
      = (c : ℂ) * (c : ℂ) := sq (c : ℂ)                    -- `def_power_of_complex_number` より `z^2 = zz`
    _ = ((c * c : ℝ) : ℂ) := real_inclusion_mul c c         -- `real_inclusion_preserves_product`
    _ = ((c ^ 2 : ℝ) : ℂ) := by rw [square_of_real_number_is_product c]
                          -- `square_of_real_number_is_product` を右辺から左辺へ

/-- `c_1^2 - s_1^2 = 1` を `ℂ` の式として読んだもの: `(c_1)_ℂ^2 - (s_1)_ℂ^2 = 1_ℂ`。人手の準備の像の読み方
（積の像は `real_inclusion_preserves_product`、差の像は `real_inclusion_preserves_difference`（具体版 `real_inclusion_sub`））で読む。 -/
theorem IsingParam.c1_sq_sub_s1_sq_inclusion :
    (P.const.c1 : ℂ) ^ 2 - (P.const.s1 : ℂ) ^ 2 = 1 :=
  calc (P.const.c1 : ℂ) ^ 2 - (P.const.s1 : ℂ) ^ 2
      = ((P.const.c1 ^ 2 : ℝ) : ℂ) - ((P.const.s1 ^ 2 : ℝ) : ℂ) := by
        rw [real_inclusion_sq_via_product, real_inclusion_sq_via_product]  -- 2 乗の像は像の 2 乗を 2 箇所へ
    _ = ((P.const.c1 ^ 2 - P.const.s1 ^ 2 : ℝ) : ℂ) :=
        real_inclusion_sub _ _                                  -- 準備の像の読み方の差: `real_inclusion_preserves_difference`
    _ = ((1 : ℝ) : ℂ) := by rw [P.c1_sq_sub_s1_sq]             -- `c_1^2 - s_1^2 = 1`（`cosh_sinh_basic_properties` (2)）
    _ = 1 := Complex.ofReal_one                                 -- `inclusion_rr_to_cc` の `1_ℂ = (1, 0)`

/-- `(c_2^*)^2 - (s_2^*)^2 = 1` を `ℂ` の式として読んだもの: `(c_2^*)_ℂ^2 - (s_2^*)_ℂ^2 = 1_ℂ`（`c_1^2 - s_1^2 = 1` と同じ読み方）。 -/
theorem IsingParam.c2star_sq_sub_s2star_sq_inclusion :
    (P.const.c2star : ℂ) ^ 2 - (P.const.s2star : ℂ) ^ 2 = 1 :=
  calc (P.const.c2star : ℂ) ^ 2 - (P.const.s2star : ℂ) ^ 2
      = ((P.const.c2star ^ 2 : ℝ) : ℂ) - ((P.const.s2star ^ 2 : ℝ) : ℂ) := by
        rw [real_inclusion_sq_via_product, real_inclusion_sq_via_product]  -- 2 乗の像は像の 2 乗を 2 箇所へ
    _ = ((P.const.c2star ^ 2 - P.const.s2star ^ 2 : ℝ) : ℂ) :=
        real_inclusion_sub _ _                                  -- 準備の像の読み方の差: `real_inclusion_preserves_difference`
    _ = ((1 : ℝ) : ℂ) := by rw [P.c2star_sq_sub_s2star_sq]     -- `(c_2^*)^2 - (s_2^*)^2 = 1`（`cosh_sinh_basic_properties` (2)）
    _ = 1 := Complex.ofReal_one                                 -- `inclusion_rr_to_cc` の `1_ℂ = (1, 0)`

/-- `c_2s_2^* = c_2^*` を `ℂ` の式として読んだもの: `(c_2)_ℂ (s_2^*)_ℂ = (c_2^*)_ℂ`（`real_inclusion_preserves_product` と `duality_c2_star_eq_s2_star_c2`）。 -/
theorem c2_mul_s2star_inclusion (K : IsingConst) (hdual : K.c2 * K.s2star = K.c2star) :
    (K.c2 : ℂ) * (K.s2star : ℂ) = (K.c2star : ℂ) :=
  calc (K.c2 : ℂ) * (K.s2star : ℂ)
      = ((K.c2 * K.s2star : ℝ) : ℂ) := real_inclusion_mul _ _  -- `real_inclusion_preserves_product`
    _ = (K.c2star : ℂ) := by rw [hdual]                        -- `duality_c2_star_eq_s2_star_c2`（`c_2s_2^* = c_2^*`）

/-- `def_gamma1_gamma2_of_theta` の `γ_1(θ) = c_1c_2^* - s_1s_2^*u` を `ℂ` の式として読む:
実数の積の像は像の積（`real_inclusion_preserves_product`）、差の像は像の差（`real_inclusion_sub`）。 -/
theorem gamma1_eq_inclusion_form (K : IsingConst) (θ : ℝ) :
    gamma1 K θ = (K.c1 : ℂ) * (K.c2star : ℂ) - (K.s1 : ℂ) * (K.s2star : ℂ) * (Real.cos θ : ℂ) :=
  calc gamma1 K θ
      = ((K.c1 * K.c2star - K.s1 * K.s2star * Real.cos θ : ℝ) : ℂ) := rfl
                          -- `def_gamma1_gamma2_of_theta`
    _ = ((K.c1 * K.c2star : ℝ) : ℂ) - ((K.s1 * K.s2star * Real.cos θ : ℝ) : ℂ) :=
        (real_inclusion_sub _ _).symm
                          -- 実数の差の像は像の差を右辺から左辺へ
    _ = (K.c1 : ℂ) * (K.c2star : ℂ) - (K.s1 : ℂ) * (K.s2star : ℂ) * (Real.cos θ : ℂ) := by
        rw [← real_inclusion_mul, ← real_inclusion_mul, ← real_inclusion_mul]
                          -- `real_inclusion_preserves_product` を 3 箇所へ右辺から左辺へ

/-- **人手証明 `det_A_theta_tilde` の第 1 の等式の鎖の 1〜9 行**（人手の 10 行のうち、最後の「上の第 2 の等式の鎖」の行を除く）:
`det A(θ) = γ_1(θ)^2 + γ_2(θ)γ_2(-θ)`。最後の行は `det_AMat_thetaTilde_eq_one` で `gamma1_sq_add_gamma2_mul_thetaTilde` を当てる。 -/
theorem det_AMat_eq_gamma1_sq_add (K : IsingConst) (θ : ℝ) :
    (AMat K θ).det = gamma1 K θ ^ 2 + gamma2 K θ * gamma2 K (-θ) :=
  calc (AMat K θ).det
      = (!![gamma1 K θ, gamma2 K θ; -gamma2 K (-θ), gamma1 K θ]
          : Matrix (Fin 2) (Fin 2) ℂ).det := by rw [AMat_eq]
                          -- 2 行目: `def_gamma1_gamma2_of_theta`
    _ = gamma1 K θ * gamma1 K θ - gamma2 K θ * (-gamma2 K (-θ)) := det_two_by_two_def _
                          -- 3 行目: `def_det_two_by_two`
    _ = gamma1 K θ * gamma1 K θ + (-(gamma2 K θ * (-gamma2 K (-θ)))) := sub_eq_add_neg _ _
                          -- 4 行目: `def_complex_difference`
    _ = gamma1 K θ * gamma1 K θ + (-1) * (gamma2 K θ * ((-1) * gamma2 K (-θ))) := by
        rw [neg_one_mul, neg_one_mul]
                          -- 5 行目: `multiply_by_minus_one` を 2 箇所へ
    _ = gamma1 K θ * gamma1 K θ + ((-1) * (-1)) * (gamma2 K θ * gamma2 K (-θ)) := by
        rw [mul_left_comm (gamma2 K θ) (-1 : ℂ), ← mul_assoc]
                          -- 6 行目: `complex_numbers_form_a_field` の積の結合律・可換律
    _ = gamma1 K θ * gamma1 K θ + 1 * (gamma2 K θ * gamma2 K (-θ)) := by
        rw [complex_minus_one_mul_minus_one]
                          -- 7 行目: `minus_one_times_minus_one_is_one_in_cc`
    _ = gamma1 K θ * gamma1 K θ + gamma2 K θ * gamma2 K (-θ) := by rw [one_mul]
                          -- 8 行目: `complex_numbers_form_a_field` の積の単位元
    _ = gamma1 K θ ^ 2 + gamma2 K θ * gamma2 K (-θ) := by rw [sq]
                          -- 9 行目: `def_power_of_complex_number` より `z^2 = zz` を右辺から左辺へ

/-- **人手証明 `det_A_theta_tilde` の第一の準備の `e_+e_- = 1_ℂ`**（人手の 4 行）。
人手の準備の `e_- := exp(-iθ)` の `-iθ` は `multiply_by_minus_one` の `-(iθ)` で、ここの `-(I * θ)` と同じ読みである。 -/
theorem exp_I_mul_exp_neg_I_mul (θ : ℝ) :
    Complex.exp (Complex.I * (θ : ℂ)) * Complex.exp (-(Complex.I * (θ : ℂ))) = 1 := by
  set ep : ℂ := Complex.exp (Complex.I * (θ : ℂ)) with hep
  set em : ℂ := Complex.exp (-(Complex.I * (θ : ℂ))) with hem
  calc ep * em
      = Complex.exp (Complex.I * (θ : ℂ)) * Complex.exp (-(Complex.I * (θ : ℂ))) := rfl
                          -- 1 行目: `e_±` の定義
    _ = Complex.exp (Complex.I * (θ : ℂ) + -(Complex.I * (θ : ℂ))) := (Complex.exp_add _ _).symm
                          -- 2 行目: `scalar_exp_product` を `K = ℂ` で
    _ = Complex.exp 0 := by rw [add_neg_cancel]
                          -- 3 行目: `complex_numbers_form_a_field` の加法逆元
    _ = 1 := Complex.exp_zero
                          -- 4 行目: `scalar_exp_zero` を `K = ℂ` で

/-- **人手証明 `det_A_theta_tilde` の第一の準備の `-(-z) = z`**（`z ∈ ℂ`、人手の 5 行）。 -/
theorem complex_neg_neg_chain (z : ℂ) : -(-z) = z :=
  calc -(-z)
      = (-1 : ℂ) * ((-1 : ℂ) * z) := by
        rw [neg_one_mul z, neg_one_mul (-z)]
                          -- 1 行目: `multiply_by_minus_one` を 2 箇所へ（mathlib の `neg_one_mul` を右辺から左辺へ当てる）
    _ = ((-1 : ℂ) * (-1 : ℂ)) * z := (mul_assoc _ _ _).symm
                          -- 2 行目: `complex_numbers_form_a_field` の積の結合律
    _ = (((-1) * (-1) : ℝ) : ℂ) * z := by
        rw [← real_inclusion_mul, Complex.ofReal_neg, Complex.ofReal_one]
                          -- 3 行目: `real_inclusion_preserves_product`（`-1_ℂ` は略記 `(-1)_ℂ`）
    _ = 1 * z := by
        rw [show ((-1) * (-1) : ℝ) = 1 by norm_num, Complex.ofReal_one]
                          -- 4 行目: ℝ の四則 `(-1)(-1) = 1`（`1_ℂ` は略記 `1_ℂ = (1)_ℂ`）
    _ = z := one_mul z
                          -- 5 行目: `complex_numbers_form_a_field` の積の単位元

/-- **人手証明 `det_A_theta_tilde` の第一の準備の `ii = -1_ℂ`**（人手の 4 行）。 -/
theorem complex_I_mul_I_chain : Complex.I * Complex.I = -1 :=
  calc Complex.I * Complex.I
      = (⟨0, 1⟩ : ℂ) * (⟨0, 1⟩ : ℂ) := rfl
                          -- 1 行目: `antiperiodic_exp_sum` の前置きの `i := (0,1)`
    _ = (⟨0 * 0 - 1 * 1, 0 * 1 + 1 * 0⟩ : ℂ) := rfl
                          -- 2 行目: `definition_of_cc` の積
    _ = (⟨-1, 0⟩ : ℂ) := by norm_num
                          -- 3 行目: ℝ の四則（成分ごと）
    _ = -1 := by rw [show (⟨-1, 0⟩ : ℂ) = ((-1 : ℝ) : ℂ) from rfl, Complex.ofReal_neg, Complex.ofReal_one]
                          -- 4 行目: `inclusion_rr_to_cc` を右辺から左辺へ（`-1_ℂ` は略記 `(-1)_ℂ`）

/-- **人手証明 `det_A_theta_tilde` の第一の準備の `(x - iy)(x + iy) = x^2 + y^2`**（`x, y ∈ ℂ`、人手の 13 行）。 -/
theorem complex_sub_I_mul_mul_add_I_mul (x y : ℂ) :
    (x - Complex.I * y) * (x + Complex.I * y) = x ^ 2 + y ^ 2 :=
  calc (x - Complex.I * y) * (x + Complex.I * y)
      = (x + (-(Complex.I * y))) * (x + Complex.I * y) := by rw [sub_eq_add_neg]
                          -- 1 行目: `def_complex_difference`
    _ = (x + (-1) * (Complex.I * y)) * (x + Complex.I * y) := by rw [neg_one_mul]
                          -- 2 行目: `multiply_by_minus_one`
    _ = x * x + x * (Complex.I * y) + ((-1) * (Complex.I * y)) * x
          + ((-1) * (Complex.I * y)) * (Complex.I * y) := by
        rw [add_mul, mul_add, mul_add, ← add_assoc]
                          -- 3 行目: `complex_numbers_form_a_field` の分配律
    _ = x * x + (Complex.I * y) * x + (-1) * ((Complex.I * y) * x)
          + (-1) * ((Complex.I * y) * (Complex.I * y)) := by
        rw [mul_comm x (Complex.I * y), mul_assoc (-1) (Complex.I * y) x,
          mul_assoc (-1) (Complex.I * y) (Complex.I * y)]
                          -- 4 行目: `complex_numbers_form_a_field` の積の結合律・可換律
    _ = x * x + ((Complex.I * y) * x + (-1) * ((Complex.I * y) * x))
          + (-1) * ((Complex.I * y) * (Complex.I * y)) := by
        rw [add_assoc (x * x) ((Complex.I * y) * x)]
                          -- 5 行目: `complex_numbers_form_a_field` の和の結合律
    _ = x * x + ((Complex.I * y) * x + (-((Complex.I * y) * x)))
          + (-1) * ((Complex.I * y) * (Complex.I * y)) := by
        rw [neg_one_mul ((Complex.I * y) * x)]
                          -- 6 行目: `multiply_by_minus_one` を右辺から左辺へ
    _ = x * x + 0 + (-1) * ((Complex.I * y) * (Complex.I * y)) := by rw [add_neg_cancel]
                          -- 7 行目: `complex_numbers_form_a_field` の加法逆元
    _ = x * x + (-1) * ((Complex.I * y) * (Complex.I * y)) := by rw [add_zero]
                          -- 8 行目: `complex_numbers_form_a_field` の零元
    _ = x * x + (-1) * ((Complex.I * Complex.I) * (y * y)) := by
        rw [mul_mul_mul_comm Complex.I y Complex.I y]
                          -- 9 行目: `complex_numbers_form_a_field` の積の結合律・可換律
    _ = x * x + (-1) * ((-1) * (y * y)) := by rw [complex_I_mul_I_chain]
                          -- 10 行目: 上の `ii = -1_ℂ`（`complex_I_mul_I_chain`）
    _ = x * x + (-(-(y * y))) := by rw [neg_one_mul (y * y), neg_one_mul (-(y * y))]
                          -- 11 行目: `multiply_by_minus_one` を 2 箇所へ右辺から左辺へ
    _ = x * x + y * y := by rw [complex_neg_neg_chain]
                          -- 12 行目: 上の `-(-z) = z`（`complex_neg_neg_chain`）
    _ = x ^ 2 + y ^ 2 := by rw [sq x, sq y]
                          -- 13 行目: `def_power_of_complex_number` より `z^2 = zz` を 2 箇所へ右辺から左辺へ

/-- **人手証明 `det_A_theta_tilde` の第一の準備の `(x - y)^2 = x^2 - 2_ℂ(xy) + y^2`**（`x, y ∈ ℂ`、人手の 15 行）。 -/
theorem complex_sub_sq_chain (x y : ℂ) :
    (x - y) ^ 2 = x ^ 2 - 2 * (x * y) + y ^ 2 :=
  calc (x - y) ^ 2
      = (x - y) * (x - y) := sq (x - y)
                          -- 1 行目: `def_power_of_complex_number` より `z^2 = (1_ℂz)z = zz`
    _ = (x + (-y)) * (x + (-y)) := by rw [sub_eq_add_neg]
                          -- 2 行目: `def_complex_difference` を 2 箇所へ
    _ = (x + (-1) * y) * (x + (-1) * y) := by rw [neg_one_mul]
                          -- 3 行目: `multiply_by_minus_one` を 2 箇所へ
    _ = x * x + x * ((-1) * y) + ((-1) * y) * x + ((-1) * y) * ((-1) * y) := by
        rw [add_mul, mul_add, mul_add, ← add_assoc]
                          -- 4 行目: `complex_numbers_form_a_field` の分配律
    _ = x * x + (-1) * (x * y) + (-1) * (x * y) + ((-1) * (-1)) * (y * y) := by
        rw [mul_comm ((-1) * y) x, mul_left_comm x (-1) y, mul_mul_mul_comm (-1) y (-1) y]
                          -- 5 行目: `complex_numbers_form_a_field` の積の結合律・可換律
    _ = x * x + ((-1) + (-1)) * (x * y) + ((-1) * (-1)) * (y * y) := by
        rw [add_assoc (x * x) ((-1) * (x * y)), ← add_mul (-1 : ℂ) (-1) (x * y)]
                          -- 6 行目: `complex_numbers_form_a_field` の分配律を右辺から左辺へ
    _ = x * x + (((-1) + (-1) : ℝ) : ℂ) * (x * y) + ((-1) * (-1)) * (y * y) := by
        rw [← real_inclusion_add, Complex.ofReal_neg, Complex.ofReal_one]
                          -- 7 行目: `real_inclusion_preserves_finite_sum` を `m = 2` で（2 項の場合の `real_inclusion_preserves_sum`。`-1_ℂ` は略記 `(-1)_ℂ`）
    _ = x * x + (((-1) + (-1) : ℝ) : ℂ) * (x * y) + (((-1) * (-1) : ℝ) : ℂ) * (y * y) := by
        rw [← real_inclusion_mul (-1) (-1), Complex.ofReal_neg, Complex.ofReal_one]
                          -- 8 行目: `real_inclusion_preserves_product`
    _ = x * x + (((-1) * 2 : ℝ) : ℂ) * (x * y) + 1 * (y * y) := by
        rw [show ((-1) + (-1) : ℝ) = (-1) * 2 by norm_num, show ((-1) * (-1) : ℝ) = 1 by norm_num,
          Complex.ofReal_one]
                          -- 9 行目: ℝ の四則を 2 箇所へ（`1_ℂ` は略記 `(1)_ℂ`）
    _ = x * x + ((-1) * 2) * (x * y) + 1 * (y * y) := by
        rw [← real_inclusion_mul (-1) 2, Complex.ofReal_neg, Complex.ofReal_one, Complex.ofReal_ofNat]
                          -- 10 行目: `real_inclusion_preserves_product` を右辺から左辺へ（`2_ℂ` は略記 `(2)_ℂ`）
    _ = x * x + (-1) * (2 * (x * y)) + 1 * (y * y) := by rw [mul_assoc (-1 : ℂ) 2 (x * y)]
                          -- 11 行目: `complex_numbers_form_a_field` の積の結合律
    _ = x * x + (-1) * (2 * (x * y)) + y * y := by rw [one_mul (y * y)]
                          -- 12 行目: `complex_numbers_form_a_field` の積の単位元
    _ = x * x + (-(2 * (x * y))) + y * y := by rw [neg_one_mul (2 * (x * y))]
                          -- 13 行目: `multiply_by_minus_one` を右辺から左辺へ
    _ = x * x - 2 * (x * y) + y * y := by rw [← sub_eq_add_neg]
                          -- 14 行目: `def_complex_difference` を右辺から左辺へ
    _ = x ^ 2 - 2 * (x * y) + y ^ 2 := by rw [sq x, sq y]
                          -- 15 行目: `def_power_of_complex_number` より `z^2 = (1_ℂz)z = zz` を 2 箇所へ右辺から左辺へ

/-- **人手証明 `det_A_theta_tilde` の第一の準備の `u + iv = e_+`**（`u = (cos θ)_ℂ`、`v = (sin θ)_ℂ`、
`e_+ = exp(iθ)`、人手の 19 行）。`e_- = exp(-iθ)` の `-iθ` は `-(iθ)`（Lean の `-(Complex.I * (θ : ℂ))`）。 -/
theorem complex_cos_add_I_mul_sin_chain (θ : ℝ) :
    (Real.cos θ : ℂ) + Complex.I * (Real.sin θ : ℂ) = Complex.exp (Complex.I * (θ : ℂ)) := by
  set ep : ℂ := Complex.exp (Complex.I * (θ : ℂ))
  set em : ℂ := Complex.exp (-(Complex.I * (θ : ℂ)))
  have h2 : (2 : ℂ) ≠ 0 := two_ne_zero
  calc (Real.cos θ : ℂ) + Complex.I * (Real.sin θ : ℂ)
      = (ep + em) / 2 + Complex.I * ((ep - em) / (2 * Complex.I)) := by
        rw [euler_cos_real_inclusion θ, euler_sin_real_inclusion θ]
                          -- 1 行目: `euler_formula_cos_sin` を 2 箇所へ
    _ = (ep + em) * (2 : ℂ)⁻¹ + Complex.I * ((ep - em) * (2 * Complex.I)⁻¹) := by
        rw [div_eq_mul_inv, div_eq_mul_inv]
                          -- 2 行目: 準備の商 `z/w := zw^{-1}` を 2 箇所へ
    _ = (ep + em) * (2 : ℂ)⁻¹ + (ep - em) * (Complex.I * (2 * Complex.I)⁻¹) := by
        rw [mul_left_comm Complex.I (ep - em)]
                          -- 3 行目: `complex_numbers_form_a_field` の積の結合律・可換律
    _ = (ep + em) * (2 : ℂ)⁻¹ + (ep - em) * (Complex.I * ((2 : ℂ)⁻¹ * Complex.I⁻¹)) := by
        rw [mul_inv (2 : ℂ) Complex.I]
                          -- 4 行目: `complex_numbers_form_a_field` の乗法の逆元の一意性より `(2i)^{-1} = 2^{-1}i^{-1}`
    _ = (ep + em) * (2 : ℂ)⁻¹ + (ep - em) * ((2 : ℂ)⁻¹ * (Complex.I * Complex.I⁻¹)) := by
        rw [mul_left_comm Complex.I (2 : ℂ)⁻¹]
                          -- 5 行目: `complex_numbers_form_a_field` の積の結合律・可換律
    _ = (ep + em) * (2 : ℂ)⁻¹ + (ep - em) * ((2 : ℂ)⁻¹ * 1) := by
        rw [mul_inv_cancel₀ Complex.I_ne_zero]
                          -- 6 行目: `complex_numbers_form_a_field` の乗法の逆元
    _ = (ep + em) * (2 : ℂ)⁻¹ + (ep - em) * (2 : ℂ)⁻¹ := by rw [mul_one]
                          -- 7 行目: `complex_numbers_form_a_field` の積の単位元
    _ = ((ep + em) + (ep - em)) * (2 : ℂ)⁻¹ := (add_mul _ _ _).symm
                          -- 8 行目: `complex_numbers_form_a_field` の分配律を右辺から左辺へ
    _ = ((ep + em) + (ep + (-em))) * (2 : ℂ)⁻¹ := by rw [sub_eq_add_neg ep em]
                          -- 9 行目: `def_complex_difference`
    _ = (ep + ep + (em + (-em))) * (2 : ℂ)⁻¹ := by rw [add_add_add_comm ep em ep (-em)]
                          -- 10 行目: `complex_numbers_form_a_field` の和の結合律・可換律
    _ = (ep + ep + 0) * (2 : ℂ)⁻¹ := by rw [add_neg_cancel em]
                          -- 11 行目: `complex_numbers_form_a_field` の加法逆元
    _ = (ep + ep) * (2 : ℂ)⁻¹ := by rw [add_zero]
                          -- 12 行目: `complex_numbers_form_a_field` の零元
    _ = (1 * ep + 1 * ep) * (2 : ℂ)⁻¹ := by rw [one_mul ep]
                          -- 13 行目: `complex_numbers_form_a_field` の積の単位元（右辺から左辺へ）
    _ = ((1 + 1) * ep) * (2 : ℂ)⁻¹ := by rw [← add_mul (1 : ℂ) 1 ep]
                          -- 14 行目: `complex_numbers_form_a_field` の分配律を右辺から左辺へ
    _ = ((((1 + 1 : ℝ)) : ℂ) * ep) * (2 : ℂ)⁻¹ := by
        rw [← real_inclusion_add, Complex.ofReal_one]
                          -- 15 行目: `real_inclusion_preserves_finite_sum` を `m = 2` で（`1_ℂ` は略記 `(1)_ℂ`）
    _ = ((2 : ℂ) * ep) * (2 : ℂ)⁻¹ := by
        rw [one_add_one_eq_two, Complex.ofReal_ofNat]
                          -- 16 行目: ℝ の四則 `1 + 1 = 2`（`2_ℂ` は略記 `(2)_ℂ`）
    _ = ep * ((2 : ℂ) * (2 : ℂ)⁻¹) := by rw [mul_comm (2 : ℂ) ep, mul_assoc]
                          -- 17 行目: `complex_numbers_form_a_field` の積の結合律・可換律
    _ = ep * 1 := by rw [mul_inv_cancel₀ h2]
                          -- 18 行目: `complex_numbers_form_a_field` の乗法の逆元
    _ = ep := mul_one ep
                          -- 19 行目: `complex_numbers_form_a_field` の積の単位元

/-- **人手証明 `det_A_theta_tilde` の第一の準備の `u^2 + v^2 = 1_ℂ`**（人手の 5 行）。 -/
theorem cos_sq_add_sin_sq_complex_chain (θ : ℝ) :
    (Real.cos θ : ℂ) ^ 2 + (Real.sin θ : ℂ) ^ 2 = 1 :=
  calc (Real.cos θ : ℂ) ^ 2 + (Real.sin θ : ℂ) ^ 2
      = ((Real.cos θ : ℂ) - Complex.I * (Real.sin θ : ℂ))
          * ((Real.cos θ : ℂ) + Complex.I * (Real.sin θ : ℂ)) :=
        (complex_sub_I_mul_mul_add_I_mul _ _).symm
                          -- 1 行目: 上の `(x - iy)(x + iy) = x^2 + y^2` を `x = u, y = v` で右辺から左辺へ
    _ = Complex.exp (-(Complex.I * (θ : ℂ))) * ((Real.cos θ : ℂ) + Complex.I * (Real.sin θ : ℂ)) := by
        rw [exp_neg_I_mul_real_eq_cos_sub_I_mul_sin θ]
                          -- 2 行目: `exp_of_negative_i_real_as_cos_minus_i_sin` を右辺から左辺へ
    _ = Complex.exp (-(Complex.I * (θ : ℂ))) * Complex.exp (Complex.I * (θ : ℂ)) := by
        rw [complex_cos_add_I_mul_sin_chain θ]
                          -- 3 行目: 上の `u + iv = e_+`（`complex_cos_add_I_mul_sin_chain`）
    _ = Complex.exp (Complex.I * (θ : ℂ)) * Complex.exp (-(Complex.I * (θ : ℂ))) := mul_comm _ _
                          -- 4 行目: `complex_numbers_form_a_field` の積の可換律
    _ = 1 := exp_I_mul_exp_neg_I_mul θ
                          -- 5 行目: 上の `e_+e_- = 1_ℂ`（`exp_I_mul_exp_neg_I_mul`）

/-- **人手証明 `det_A_theta_tilde` の第二の準備の `γ_2(θ)` の鎖**（人手の 3 行）:
`γ_2(θ) = i e_+ s_2^*(a_0 - iv)`。`a_0 := c_1u - s_1c_2` は、人手の前置きの読み（実数の和・差・積の像は像の和・差・積）の
とおり、`ℂ` へ埋めた `c_1, u, s_1, c_2` の式で書き、定義を仮定 `ha` で受ける。 -/
theorem gamma2_a0_form (K : IsingConst) (θ : ℝ) (a₀ : ℂ)
    (ha : a₀ = (K.c1 : ℂ) * (Real.cos θ : ℂ) - (K.s1 : ℂ) * (K.c2 : ℂ)) :
    gamma2 K θ
      = Complex.I * Complex.exp (Complex.I * (θ : ℂ)) * (K.s2star : ℂ) * (a₀ - Complex.I * (Real.sin θ : ℂ)) :=
  calc gamma2 K θ
      = Complex.I * Complex.exp (Complex.I * (θ : ℂ)) * (K.s2star : ℂ)
          * ((K.c1 : ℂ) * (Real.cos θ : ℂ) - Complex.I * (Real.sin θ : ℂ) - (K.s1 : ℂ) * (K.c2 : ℂ)) := rfl
                          -- 1 行目: `def_gamma1_gamma2_of_theta`
    _ = Complex.I * Complex.exp (Complex.I * (θ : ℂ)) * (K.s2star : ℂ)
          * (((K.c1 : ℂ) * (Real.cos θ : ℂ) - (K.s1 : ℂ) * (K.c2 : ℂ)) - Complex.I * (Real.sin θ : ℂ)) := by
        rw [sub_right_comm]
                          -- 2 行目: `complex_numbers_form_a_field` の和の結合律・可換律
                          -- （差は `def_complex_difference` の `z + (-w)`。mathlib の `sub_right_comm` は `a - b - c = a - c - b`）
    _ = Complex.I * Complex.exp (Complex.I * (θ : ℂ)) * (K.s2star : ℂ) * (a₀ - Complex.I * (Real.sin θ : ℂ)) := by
        rw [← ha]
                          -- 3 行目: `a_0` の定義（`ha` を右辺から左辺へ）

/-- **人手証明 `det_A_theta_tilde` の第二の準備の `γ_2(-θ)` の鎖**（人手の 9 行）:
`γ_2(-θ) = i e_- s_2^*(a_0 + iv)`。`A(θ)_{2,1}` の積は `def_A_theta` の読みのとおり左から括る
（Lean の `-Complex.I * e * s * P` は `(((-I) * e) * s) * P`）。人手の `(-x)y = -(xy)`（ℂ は体）は具体版が Lean に無く、
`AMat_two_one_eq_neg_gamma2_neg` と同じく mathlib の `neg_mul` で 1 回ずつ受ける。 -/
theorem gamma2_neg_a0_form (K : IsingConst) (θ : ℝ) (a₀ : ℂ)
    (ha : a₀ = (K.c1 : ℂ) * (Real.cos θ : ℂ) - (K.s1 : ℂ) * (K.c2 : ℂ)) :
    gamma2 K (-θ)
      = Complex.I * Complex.exp (-(Complex.I * (θ : ℂ))) * (K.s2star : ℂ) * (a₀ + Complex.I * (Real.sin θ : ℂ)) :=
  calc gamma2 K (-θ)
      = -(-gamma2 K (-θ)) := (complex_neg_neg_chain _).symm
                          -- 1 行目: 上の `-(-z) = z`（`complex_neg_neg_chain`）を右辺から左辺へ
    _ = -(AMat K θ 1 0) := by rw [AMat_two_one_eq_neg_gamma2_neg]
                          -- 2 行目: `def_gamma1_gamma2_of_theta` の `(2,1)` 成分（`AMat_two_one_eq_neg_gamma2_neg` を右辺から左辺へ）
    _ = -((-Complex.I) * Complex.exp (-(Complex.I * (θ : ℂ))) * (K.s2star : ℂ)
          * ((K.c1 : ℂ) * (Real.cos θ : ℂ) + Complex.I * (Real.sin θ : ℂ) - (K.s1 : ℂ) * (K.c2 : ℂ))) := rfl
                          -- 3 行目: `def_A_theta` の `(2,1)` 成分
    _ = -((-(Complex.I * Complex.exp (-(Complex.I * (θ : ℂ))))) * (K.s2star : ℂ)
          * ((K.c1 : ℂ) * (Real.cos θ : ℂ) + Complex.I * (Real.sin θ : ℂ) - (K.s1 : ℂ) * (K.c2 : ℂ))) := by
        rw [neg_I_mul_eq_neg_of_I_mul]
                          -- 4 行目: `negative_i_times_complex_is_negation_of_i_times`（`z → e_-`）
    _ = -((-(Complex.I * Complex.exp (-(Complex.I * (θ : ℂ))) * (K.s2star : ℂ)))
          * ((K.c1 : ℂ) * (Real.cos θ : ℂ) + Complex.I * (Real.sin θ : ℂ) - (K.s1 : ℂ) * (K.c2 : ℂ))) := by
        rw [neg_mul (Complex.I * Complex.exp (-(Complex.I * (θ : ℂ)))) (K.s2star : ℂ)]
                          -- 5 行目: ℂ で `(-x)y = -(xy)`（`x → ie_-`, `y → s_2^*`）
    _ = -(-(Complex.I * Complex.exp (-(Complex.I * (θ : ℂ))) * (K.s2star : ℂ)
          * ((K.c1 : ℂ) * (Real.cos θ : ℂ) + Complex.I * (Real.sin θ : ℂ) - (K.s1 : ℂ) * (K.c2 : ℂ)))) := by
        rw [neg_mul (Complex.I * Complex.exp (-(Complex.I * (θ : ℂ))) * (K.s2star : ℂ))]
                          -- 6 行目: ℂ で `(-x)y = -(xy)`（`x → (ie_-)s_2^*`, `y → c_1u + iv - s_1c_2`）
    _ = Complex.I * Complex.exp (-(Complex.I * (θ : ℂ))) * (K.s2star : ℂ)
          * ((K.c1 : ℂ) * (Real.cos θ : ℂ) + Complex.I * (Real.sin θ : ℂ) - (K.s1 : ℂ) * (K.c2 : ℂ)) :=
        complex_neg_neg_chain _
                          -- 7 行目: 上の `-(-z) = z`（`complex_neg_neg_chain`）
    _ = Complex.I * Complex.exp (-(Complex.I * (θ : ℂ))) * (K.s2star : ℂ)
          * (((K.c1 : ℂ) * (Real.cos θ : ℂ) - (K.s1 : ℂ) * (K.c2 : ℂ)) + Complex.I * (Real.sin θ : ℂ)) := by
        rw [add_sub_right_comm]
                          -- 8 行目: `complex_numbers_form_a_field` の和の結合律・可換律
                          -- （差は `def_complex_difference` の `z + (-w)`。mathlib の `add_sub_right_comm` は `a + b - c = a - c + b`）
    _ = Complex.I * Complex.exp (-(Complex.I * (θ : ℂ))) * (K.s2star : ℂ) * (a₀ + Complex.I * (Real.sin θ : ℂ)) := by
        rw [← ha]
                          -- 9 行目: `a_0` の定義（`ha` を右辺から左辺へ）

/-- **人手証明 `det_A_theta_tilde` の第二の準備の `γ_2(θ)γ_2(-θ)` の鎖**（人手の 10 行）:
`γ_2(θ)γ_2(-θ) = -((s_2^*)^2(a_0^2 + v^2))`。`a_0` は `gamma2_a0_form` と同じく定義を仮定 `ha` で受ける。 -/
theorem gamma2_mul_gamma2_neg_sin_form (K : IsingConst) (θ : ℝ) (a₀ : ℂ)
    (ha : a₀ = (K.c1 : ℂ) * (Real.cos θ : ℂ) - (K.s1 : ℂ) * (K.c2 : ℂ)) :
    gamma2 K θ * gamma2 K (-θ)
      = -((K.s2star : ℂ) ^ 2 * (a₀ ^ 2 + (Real.sin θ : ℂ) ^ 2)) := by
  set v : ℂ := (Real.sin θ : ℂ)
  set ep : ℂ := Complex.exp (Complex.I * (θ : ℂ)) with hep
  set em : ℂ := Complex.exp (-(Complex.I * (θ : ℂ))) with hem
  set s : ℂ := (K.s2star : ℂ)
  calc gamma2 K θ * gamma2 K (-θ)
      = (Complex.I * ep * s * (a₀ - Complex.I * v)) * gamma2 K (-θ) := by
        rw [gamma2_a0_form K θ a₀ ha]
                          -- 1 行目: 上の `γ_2(θ)` の表示（`gamma2_a0_form`）
    _ = (Complex.I * ep * s * (a₀ - Complex.I * v)) * (Complex.I * em * s * (a₀ + Complex.I * v)) := by
        rw [gamma2_neg_a0_form K θ a₀ ha]
                          -- 2 行目: 上の `γ_2(-θ)` の表示（`gamma2_neg_a0_form`）
    _ = (Complex.I * Complex.I) * (ep * em) * (s * s) * ((a₀ - Complex.I * v) * (a₀ + Complex.I * v)) := by
        rw [mul_mul_mul_comm (Complex.I * ep * s) (a₀ - Complex.I * v) (Complex.I * em * s),
          mul_mul_mul_comm (Complex.I * ep) s (Complex.I * em) s,
          mul_mul_mul_comm Complex.I ep Complex.I em]
                          -- 3 行目: `complex_numbers_form_a_field` の積の結合律・可換律
    _ = (-1) * (ep * em) * (s * s) * ((a₀ - Complex.I * v) * (a₀ + Complex.I * v)) := by
        rw [complex_I_mul_I_chain]
                          -- 4 行目: 上の `ii = -1_ℂ`（`complex_I_mul_I_chain`）
    _ = (-1) * 1 * (s * s) * ((a₀ - Complex.I * v) * (a₀ + Complex.I * v)) := by
        rw [hep, hem, exp_I_mul_exp_neg_I_mul]
                          -- 5 行目: 上の `e_+e_- = 1_ℂ`（`exp_I_mul_exp_neg_I_mul`）
    _ = (-1) * (s * s) * ((a₀ - Complex.I * v) * (a₀ + Complex.I * v)) := by rw [mul_one (-1 : ℂ)]
                          -- 6 行目: `complex_numbers_form_a_field` の積の単位元
    _ = (-1) * (s * s) * (a₀ ^ 2 + v ^ 2) := by rw [complex_sub_I_mul_mul_add_I_mul]
                          -- 7 行目: 上の `(x - iy)(x + iy) = x^2 + y^2` を `x = a_0, y = v` で
    _ = (-1) * ((s * s) * (a₀ ^ 2 + v ^ 2)) := mul_assoc _ _ _
                          -- 8 行目: `complex_numbers_form_a_field` の積の結合律
    _ = (-1) * (s ^ 2 * (a₀ ^ 2 + v ^ 2)) := by rw [← sq s]
                          -- 9 行目: `def_power_of_complex_number` より `z^2 = zz` を右辺から左辺へ
    _ = -(s ^ 2 * (a₀ ^ 2 + v ^ 2)) := neg_one_mul _
                          -- 10 行目: `multiply_by_minus_one`

/-- **人手証明 `det_A_theta_tilde` の第 2 の等式の鎖の前半**（人手の 1〜29 行。左辺だけの行は数えず、等号の行を 1 行目から数える。SageMath の overview は左辺だけの行を第 1 行と数えるので、同じ行の番号が 1 つ大きい）:
`γ_1(θ)^2 + γ_2(θ)γ_2(-θ)` を、`c_2` を (iii) `c_2s_2^* = c_2^*` で消した 8 項の和まで運ぶ。
`a_0` は `gamma2_a0_form` と同じく、`ℂ` へ埋めた `c_1, u, s_1, c_2` の式とし、定義を仮定 `ha` で受ける。
人手の `2_ℂ` は Lean の数字 `(2 : ℂ)`、`-1_ℂ` は `(-1 : ℂ)`（略記 `(-1)_ℂ`）である。
積は人手の読みのとおり左から括る（`2_ℂc_1c_2^*s_1s_2^*u` は `((((2c_1)c_2^*)s_1)s_2^*)u`）。 -/
theorem gamma1_sq_add_gamma2_mul_chain_first_half (K : IsingConst) (θ : ℝ)
    (hdual : K.c2 * K.s2star = K.c2star) (a₀ : ℂ)
    (ha : a₀ = (K.c1 : ℂ) * (Real.cos θ : ℂ) - (K.s1 : ℂ) * (K.c2 : ℂ)) :
    gamma1 K θ ^ 2 + gamma2 K θ * gamma2 K (-θ)
      = (K.c1 : ℂ) ^ 2 * (K.c2star : ℂ) ^ 2
          - 2 * (K.c1 : ℂ) * (K.c2star : ℂ) * (K.s1 : ℂ) * (K.s2star : ℂ) * (Real.cos θ : ℂ)
          + (K.s1 : ℂ) ^ 2 * (K.s2star : ℂ) ^ 2 * (Real.cos θ : ℂ) ^ 2
          - (K.c1 : ℂ) ^ 2 * (K.s2star : ℂ) ^ 2 * (Real.cos θ : ℂ) ^ 2
          + 2 * (K.c1 : ℂ) * (K.c2star : ℂ) * (K.s1 : ℂ) * (K.s2star : ℂ) * (Real.cos θ : ℂ)
          - (K.s1 : ℂ) ^ 2 * (K.c2star : ℂ) ^ 2 - (K.s2star : ℂ) ^ 2
          + (K.s2star : ℂ) ^ 2 * (Real.cos θ : ℂ) ^ 2 := by
  have H3 : (K.c2 : ℂ) * (K.s2star : ℂ) = (K.c2star : ℂ) := c2_mul_s2star_inclusion K hdual
  have hv : (Real.sin θ : ℂ) ^ 2 = 1 - (Real.cos θ : ℂ) ^ 2 :=
    eq_sub_of_add_eq' (cos_sq_add_sin_sq_complex_chain θ)   -- `u^2 + v^2 = 1_ℂ` を移項
  set c₁ : ℂ := (K.c1 : ℂ)
  set s₁ : ℂ := (K.s1 : ℂ)
  set c₂ : ℂ := (K.c2 : ℂ)
  set c₂' : ℂ := (K.c2star : ℂ)
  set s₂' : ℂ := (K.s2star : ℂ)
  set u : ℂ := (Real.cos θ : ℂ)
  set v : ℂ := (Real.sin θ : ℂ)
  have hsq_s2star_term : 2 * c₁ * s₁ * c₂ * s₂' ^ 2 * u = 2 * c₁ * s₁ * c₂ * (s₂' * s₂') * u := by rw [sq s₂']
  have hsq_c2_s2star_term : s₁ ^ 2 * c₂ ^ 2 * s₂' ^ 2 = s₁ ^ 2 * (c₂ * c₂) * (s₂' * s₂') := by rw [sq c₂, sq s₂']
  calc gamma1 K θ ^ 2 + gamma2 K θ * gamma2 K (-θ)
      = (c₁ * c₂' - s₁ * s₂' * u) ^ 2 + gamma2 K θ * gamma2 K (-θ) := by
        rw [gamma1_eq_inclusion_form]
                          -- 1 行目: `def_gamma1_gamma2_of_theta`（`gamma1_eq_inclusion_form`）
    _ = (c₁ * c₂' - s₁ * s₂' * u) ^ 2 + -(s₂' ^ 2 * (a₀ ^ 2 + v ^ 2)) := by
        rw [gamma2_mul_gamma2_neg_sin_form K θ a₀ ha]
                          -- 2 行目: 上の `γ_2(θ)γ_2(-θ)` の鎖（`gamma2_mul_gamma2_neg_sin_form`）
    _ = (c₁ * c₂' - s₁ * s₂' * u) ^ 2 - s₂' ^ 2 * (a₀ ^ 2 + v ^ 2) := (sub_eq_add_neg _ _).symm
                          -- 3 行目: `def_complex_difference` を右辺から左辺へ
    _ = (c₁ * c₂' - s₁ * s₂' * u) ^ 2 - s₂' ^ 2 * (a₀ ^ 2 + (1 - u ^ 2)) := by rw [hv]
                          -- 4 行目: 上の `u^2 + v^2 = 1_ℂ` を移項した `v^2 = 1 - u^2`
    _ = (c₁ * c₂' - s₁ * s₂' * u) ^ 2 - s₂' ^ 2 * (a₀ ^ 2 + (1 + -u ^ 2)) := by
        rw [sub_eq_add_neg (1 : ℂ) (u ^ 2)]
                          -- 5 行目: `def_complex_difference`
    _ = (c₁ * c₂' - s₁ * s₂' * u) ^ 2 - s₂' ^ 2 * (a₀ ^ 2 + 1 + -u ^ 2) := by
        rw [← add_assoc (a₀ ^ 2) 1 (-u ^ 2)]
                          -- 6 行目: `complex_numbers_form_a_field` の和の結合律
    _ = (c₁ * c₂' - s₁ * s₂' * u) ^ 2 - s₂' ^ 2 * (a₀ ^ 2 + 1 - u ^ 2) := by
        rw [← sub_eq_add_neg (a₀ ^ 2 + 1) (u ^ 2)]
                          -- 7 行目: `def_complex_difference` を右辺から左辺へ
    _ = (c₁ * c₂' - s₁ * s₂' * u) ^ 2 - s₂' ^ 2 * ((c₁ * u - s₁ * c₂) ^ 2 + 1 - u ^ 2) := by
        rw [ha]
                          -- 8 行目: `a_0` の定義
    _ = (c₁ * c₂') ^ 2 - 2 * ((c₁ * c₂') * (s₁ * s₂' * u)) + (s₁ * s₂' * u) ^ 2
          - s₂' ^ 2 * ((c₁ * u) ^ 2 - 2 * ((c₁ * u) * (s₁ * c₂)) + (s₁ * c₂) ^ 2 + 1 - u ^ 2) := by
        rw [complex_sub_sq_chain (c₁ * c₂') (s₁ * s₂' * u), complex_sub_sq_chain (c₁ * u) (s₁ * c₂)]
                          -- 9 行目: 上の `(x - y)^2 = x^2 - 2_ℂ(xy) + y^2`（`complex_sub_sq_chain`）を 2 箇所へ
    _ = (c₁ * c₂') * (c₁ * c₂') - 2 * ((c₁ * c₂') * (s₁ * s₂' * u)) + (s₁ * s₂' * u) * (s₁ * s₂' * u)
          - (s₂' * s₂') * ((c₁ * u) * (c₁ * u) - 2 * ((c₁ * u) * (s₁ * c₂)) + (s₁ * c₂) * (s₁ * c₂)
              + 1 - u * u) := by
        simp only [sq]
                          -- 10 行目: `def_power_of_complex_number` より `z^2 = zz`
    _ = (c₁ * c₁) * (c₂' * c₂') - 2 * c₁ * c₂' * s₁ * s₂' * u + (s₁ * s₁) * (s₂' * s₂') * (u * u)
          - (s₂' * s₂') * ((c₁ * c₁) * (u * u) - 2 * c₁ * s₁ * c₂ * u + (s₁ * s₁) * (c₂ * c₂)
              + 1 - u * u) := by
        ac_rfl
                          -- 11 行目: `complex_numbers_form_a_field` の積の結合律・可換律
    _ = c₁ ^ 2 * c₂' ^ 2 - 2 * c₁ * c₂' * s₁ * s₂' * u + s₁ ^ 2 * s₂' ^ 2 * u ^ 2
          - s₂' ^ 2 * (c₁ ^ 2 * u ^ 2 - 2 * c₁ * s₁ * c₂ * u + s₁ ^ 2 * c₂ ^ 2 + 1 - u ^ 2) := by
        rw [← sq c₁, ← sq c₂', ← sq s₁, ← sq s₂', ← sq u, ← sq c₂]
                          -- 12 行目: `def_power_of_complex_number` より `zz = z^2`
    _ = c₁ ^ 2 * c₂' ^ 2 - 2 * c₁ * c₂' * s₁ * s₂' * u + s₁ ^ 2 * s₂' ^ 2 * u ^ 2
          + -(s₂' ^ 2 * (c₁ ^ 2 * u ^ 2 - 2 * c₁ * s₁ * c₂ * u + s₁ ^ 2 * c₂ ^ 2 + 1 - u ^ 2)) :=
        sub_eq_add_neg _ _
                          -- 13 行目: `def_complex_difference`
    _ = c₁ ^ 2 * c₂' ^ 2 - 2 * c₁ * c₂' * s₁ * s₂' * u + s₁ ^ 2 * s₂' ^ 2 * u ^ 2
          + -(s₂' ^ 2 * (c₁ ^ 2 * u ^ 2 + -(2 * c₁ * s₁ * c₂ * u) + s₁ ^ 2 * c₂ ^ 2 + 1 + -u ^ 2)) := by
        rw [sub_eq_add_neg (c₁ ^ 2 * u ^ 2) (2 * c₁ * s₁ * c₂ * u),
          sub_eq_add_neg (c₁ ^ 2 * u ^ 2 + -(2 * c₁ * s₁ * c₂ * u) + s₁ ^ 2 * c₂ ^ 2 + 1) (u ^ 2)]
                          -- 14 行目: `def_complex_difference` を 2 箇所へ
    _ = c₁ ^ 2 * c₂' ^ 2 - 2 * c₁ * c₂' * s₁ * s₂' * u + s₁ ^ 2 * s₂' ^ 2 * u ^ 2
          + (-1) * (s₂' ^ 2 * (c₁ ^ 2 * u ^ 2 + (-1) * (2 * c₁ * s₁ * c₂ * u) + s₁ ^ 2 * c₂ ^ 2 + 1
              + (-1) * u ^ 2)) := by
        simp only [neg_one_mul]
                          -- 15 行目: `multiply_by_minus_one` を 3 箇所へ（右辺の 3 つの `(-1)z` を `-z` に戻して一致させる）
    _ = c₁ ^ 2 * c₂' ^ 2 - 2 * c₁ * c₂' * s₁ * s₂' * u + s₁ ^ 2 * s₂' ^ 2 * u ^ 2
          + ((-1) * (s₂' ^ 2 * (c₁ ^ 2 * u ^ 2)) + (-1) * (s₂' ^ 2 * ((-1) * (2 * c₁ * s₁ * c₂ * u)))
              + (-1) * (s₂' ^ 2 * (s₁ ^ 2 * c₂ ^ 2)) + (-1) * (s₂' ^ 2 * 1)
              + (-1) * (s₂' ^ 2 * ((-1) * u ^ 2))) := by
        simp only [mul_add]
                          -- 16 行目: `complex_numbers_form_a_field` の分配律
    _ = c₁ ^ 2 * c₂' ^ 2 - 2 * c₁ * c₂' * s₁ * s₂' * u + s₁ ^ 2 * s₂' ^ 2 * u ^ 2
          + (-1) * (s₂' ^ 2 * (c₁ ^ 2 * u ^ 2)) + (-1) * (s₂' ^ 2 * ((-1) * (2 * c₁ * s₁ * c₂ * u)))
          + (-1) * (s₂' ^ 2 * (s₁ ^ 2 * c₂ ^ 2)) + (-1) * (s₂' ^ 2 * 1)
          + (-1) * (s₂' ^ 2 * ((-1) * u ^ 2)) := by
        simp only [← add_assoc]
                          -- 17 行目: `complex_numbers_form_a_field` の和の結合律
    _ = c₁ ^ 2 * c₂' ^ 2 - 2 * c₁ * c₂' * s₁ * s₂' * u + s₁ ^ 2 * s₂' ^ 2 * u ^ 2
          + (-1) * (c₁ ^ 2 * s₂' ^ 2 * u ^ 2) + ((-1) * (-1)) * (2 * c₁ * s₁ * c₂ * s₂' ^ 2 * u)
          + (-1) * (s₁ ^ 2 * c₂ ^ 2 * s₂' ^ 2) + (-1) * (s₂' ^ 2 * 1)
          + ((-1) * (-1)) * (s₂' ^ 2 * u ^ 2) := by
        ac_rfl
                          -- 18 行目: `complex_numbers_form_a_field` の積の結合律・可換律
    _ = c₁ ^ 2 * c₂' ^ 2 - 2 * c₁ * c₂' * s₁ * s₂' * u + s₁ ^ 2 * s₂' ^ 2 * u ^ 2
          + (-1) * (c₁ ^ 2 * s₂' ^ 2 * u ^ 2) + ((-1) * (-1)) * (2 * c₁ * s₁ * c₂ * s₂' ^ 2 * u)
          + (-1) * (s₁ ^ 2 * c₂ ^ 2 * s₂' ^ 2) + (-1) * s₂' ^ 2
          + ((-1) * (-1)) * (s₂' ^ 2 * u ^ 2) := by
        rw [mul_one (s₂' ^ 2)]
                          -- 19 行目: `complex_numbers_form_a_field` の積の単位元
    _ = c₁ ^ 2 * c₂' ^ 2 - 2 * c₁ * c₂' * s₁ * s₂' * u + s₁ ^ 2 * s₂' ^ 2 * u ^ 2
          + (-1) * (c₁ ^ 2 * s₂' ^ 2 * u ^ 2) + (((-1) * (-1) : ℝ) : ℂ) * (2 * c₁ * s₁ * c₂ * s₂' ^ 2 * u)
          + (-1) * (s₁ ^ 2 * c₂ ^ 2 * s₂' ^ 2) + (-1) * s₂' ^ 2
          + (((-1) * (-1) : ℝ) : ℂ) * (s₂' ^ 2 * u ^ 2) := by
        rw [← real_inclusion_mul (-1) (-1), Complex.ofReal_neg, Complex.ofReal_one]
                          -- 20 行目: `real_inclusion_preserves_product` を 2 箇所へ（`-1_ℂ` は略記 `(-1)_ℂ`）
    _ = c₁ ^ 2 * c₂' ^ 2 - 2 * c₁ * c₂' * s₁ * s₂' * u + s₁ ^ 2 * s₂' ^ 2 * u ^ 2
          + (-1) * (c₁ ^ 2 * s₂' ^ 2 * u ^ 2) + 1 * (2 * c₁ * s₁ * c₂ * s₂' ^ 2 * u)
          + (-1) * (s₁ ^ 2 * c₂ ^ 2 * s₂' ^ 2) + (-1) * s₂' ^ 2
          + 1 * (s₂' ^ 2 * u ^ 2) := by
        rw [show ((-1) * (-1) : ℝ) = 1 by norm_num, Complex.ofReal_one]
                          -- 21 行目: ℝ の四則を 2 箇所へ（`1_ℂ` は略記 `(1)_ℂ`）
    _ = c₁ ^ 2 * c₂' ^ 2 - 2 * c₁ * c₂' * s₁ * s₂' * u + s₁ ^ 2 * s₂' ^ 2 * u ^ 2
          + (-1) * (c₁ ^ 2 * s₂' ^ 2 * u ^ 2) + 2 * c₁ * s₁ * c₂ * s₂' ^ 2 * u
          + (-1) * (s₁ ^ 2 * c₂ ^ 2 * s₂' ^ 2) + (-1) * s₂' ^ 2
          + s₂' ^ 2 * u ^ 2 := by
        rw [one_mul (2 * c₁ * s₁ * c₂ * s₂' ^ 2 * u), one_mul (s₂' ^ 2 * u ^ 2)]
                          -- 22 行目: `complex_numbers_form_a_field` の積の単位元を 2 箇所へ
    _ = c₁ ^ 2 * c₂' ^ 2 - 2 * c₁ * c₂' * s₁ * s₂' * u + s₁ ^ 2 * s₂' ^ 2 * u ^ 2
          + -(c₁ ^ 2 * s₂' ^ 2 * u ^ 2) + 2 * c₁ * s₁ * c₂ * s₂' ^ 2 * u
          + -(s₁ ^ 2 * c₂ ^ 2 * s₂' ^ 2) + -s₂' ^ 2 + s₂' ^ 2 * u ^ 2 := by
        simp only [neg_one_mul]
                          -- 23 行目: `multiply_by_minus_one` を 3 箇所へ右辺から左辺へ
    _ = c₁ ^ 2 * c₂' ^ 2 - 2 * c₁ * c₂' * s₁ * s₂' * u + s₁ ^ 2 * s₂' ^ 2 * u ^ 2
          - c₁ ^ 2 * s₂' ^ 2 * u ^ 2 + 2 * c₁ * s₁ * c₂ * s₂' ^ 2 * u
          - s₁ ^ 2 * c₂ ^ 2 * s₂' ^ 2 - s₂' ^ 2 + s₂' ^ 2 * u ^ 2 := by
        simp only [← sub_eq_add_neg]
                          -- 24 行目: `def_complex_difference` を 3 箇所へ右辺から左辺へ
    _ = c₁ ^ 2 * c₂' ^ 2 - 2 * c₁ * c₂' * s₁ * s₂' * u + s₁ ^ 2 * s₂' ^ 2 * u ^ 2
          - c₁ ^ 2 * s₂' ^ 2 * u ^ 2 + 2 * c₁ * s₁ * c₂ * (s₂' * s₂') * u
          - s₁ ^ 2 * (c₂ * c₂) * (s₂' * s₂') - s₂' ^ 2 + s₂' ^ 2 * u ^ 2 := by
        rw [hsq_s2star_term, hsq_c2_s2star_term]
                          -- 25 行目: `def_power_of_complex_number` より `z^2 = zz` を 3 箇所へ（`hsq_s2star_term`・`hsq_c2_s2star_term`）
    _ = c₁ ^ 2 * c₂' ^ 2 - 2 * c₁ * c₂' * s₁ * s₂' * u + s₁ ^ 2 * s₂' ^ 2 * u ^ 2
          - c₁ ^ 2 * s₂' ^ 2 * u ^ 2 + 2 * c₁ * s₁ * (c₂ * s₂') * s₂' * u
          - s₁ ^ 2 * ((c₂ * s₂') * (c₂ * s₂')) - s₂' ^ 2 + s₂' ^ 2 * u ^ 2 := by
        ac_rfl
                          -- 26 行目: `complex_numbers_form_a_field` の積の結合律・可換律
    _ = c₁ ^ 2 * c₂' ^ 2 - 2 * c₁ * c₂' * s₁ * s₂' * u + s₁ ^ 2 * s₂' ^ 2 * u ^ 2
          - c₁ ^ 2 * s₂' ^ 2 * u ^ 2 + 2 * c₁ * s₁ * (c₂ * s₂') * s₂' * u
          - s₁ ^ 2 * (c₂ * s₂') ^ 2 - s₂' ^ 2 + s₂' ^ 2 * u ^ 2 := by
        rw [← sq (c₂ * s₂')]
                          -- 27 行目: `def_power_of_complex_number` より `zz = z^2`
    _ = c₁ ^ 2 * c₂' ^ 2 - 2 * c₁ * c₂' * s₁ * s₂' * u + s₁ ^ 2 * s₂' ^ 2 * u ^ 2
          - c₁ ^ 2 * s₂' ^ 2 * u ^ 2 + 2 * c₁ * s₁ * c₂' * s₂' * u
          - s₁ ^ 2 * c₂' ^ 2 - s₂' ^ 2 + s₂' ^ 2 * u ^ 2 := by
        rw [H3]
                          -- 28 行目: 上の `c_2s_2^* = c_2^*`（`c2_mul_s2star_inclusion`）を 2 箇所へ
    _ = c₁ ^ 2 * c₂' ^ 2 - 2 * c₁ * c₂' * s₁ * s₂' * u + s₁ ^ 2 * s₂' ^ 2 * u ^ 2
          - c₁ ^ 2 * s₂' ^ 2 * u ^ 2 + 2 * c₁ * c₂' * s₁ * s₂' * u
          - s₁ ^ 2 * c₂' ^ 2 - s₂' ^ 2 + s₂' ^ 2 * u ^ 2 := by
        rw [mul_right_comm (2 * c₁) s₁ c₂']
                          -- 29 行目: `complex_numbers_form_a_field` の積の結合律・可換律

/-- **人手証明 `det_A_theta_tilde` の第 2 の等式の鎖の後半**（人手の 30〜57 行。行の数え方は前半と同じ）:
前半の 8 項の和から、`u` の 1 次の項の相殺、`(c_2^*)^2`・`(s_2^*)^2u^2` でのくくり出し、(i)(ii) の代入を経て `1` まで運ぶ。
(i) `c_1^2 - s_1^2 = 1`、(ii) `(c_2^*)^2 - (s_2^*)^2 = 1` は `ℂ` の式として仮定 `H1`・`H2` で受ける。
人手の `-1_ℂ` は Lean の `(-1 : ℂ)`（略記 `(-1)_ℂ`）、`1_ℂ`・`0_ℂ` は `(1 : ℂ)`・`(0 : ℂ)` である。積と和は人手の読みのとおり左から括る。
人手の「和の結合律・可換律」（32・36 行目）は `ac_rfl`、差の定義（30 行目）・`-1` 倍（31 行目）・「積の結合律」（38 行目）・
「和の結合律」（39 行目）・分配律（40 行目）は、その補題だけの `simp only`（同じ定理を複数箇所へ当てる）で受ける。 -/
theorem gamma1_sq_add_gamma2_mul_chain_second_half (c₁ s₁ c₂' s₂' u : ℂ)
    (H1 : c₁ ^ 2 - s₁ ^ 2 = 1) (H2 : c₂' ^ 2 - s₂' ^ 2 = 1) :
    c₁ ^ 2 * c₂' ^ 2 - 2 * c₁ * c₂' * s₁ * s₂' * u + s₁ ^ 2 * s₂' ^ 2 * u ^ 2
      - c₁ ^ 2 * s₂' ^ 2 * u ^ 2 + 2 * c₁ * c₂' * s₁ * s₂' * u
      - s₁ ^ 2 * c₂' ^ 2 - s₂' ^ 2 + s₂' ^ 2 * u ^ 2 = 1 :=
  calc c₁ ^ 2 * c₂' ^ 2 - 2 * c₁ * c₂' * s₁ * s₂' * u + s₁ ^ 2 * s₂' ^ 2 * u ^ 2
      - c₁ ^ 2 * s₂' ^ 2 * u ^ 2 + 2 * c₁ * c₂' * s₁ * s₂' * u
      - s₁ ^ 2 * c₂' ^ 2 - s₂' ^ 2 + s₂' ^ 2 * u ^ 2
    _ = c₁ ^ 2 * c₂' ^ 2 + -(2 * c₁ * c₂' * s₁ * s₂' * u) + s₁ ^ 2 * s₂' ^ 2 * u ^ 2 + -(c₁ ^ 2 * s₂' ^ 2 * u ^ 2) + (2 * c₁ * c₂' * s₁ * s₂' * u)
          + -(s₁ ^ 2 * c₂' ^ 2) + -s₂' ^ 2 + s₂' ^ 2 * u ^ 2 := by
        simp only [sub_eq_add_neg]
                          -- 30 行目: `def_complex_difference` を 4 箇所へ
    _ = c₁ ^ 2 * c₂' ^ 2 + (-1) * (2 * c₁ * c₂' * s₁ * s₂' * u) + s₁ ^ 2 * s₂' ^ 2 * u ^ 2 + (-1) * (c₁ ^ 2 * s₂' ^ 2 * u ^ 2) + (2 * c₁ * c₂' * s₁ * s₂' * u)
          + (-1) * (s₁ ^ 2 * c₂' ^ 2) + (-1) * s₂' ^ 2 + s₂' ^ 2 * u ^ 2 := by
        simp only [neg_one_mul]
                          -- 31 行目: `multiply_by_minus_one` を 4 箇所へ（右辺の 4 つの `(-1)z` を `-z` に戻して一致させる）
    _ = c₁ ^ 2 * c₂' ^ 2 + ((-1) * (2 * c₁ * c₂' * s₁ * s₂' * u) + (2 * c₁ * c₂' * s₁ * s₂' * u)) + s₁ ^ 2 * s₂' ^ 2 * u ^ 2 + (-1) * (c₁ ^ 2 * s₂' ^ 2 * u ^ 2)
          + (-1) * (s₁ ^ 2 * c₂' ^ 2) + (-1) * s₂' ^ 2 + s₂' ^ 2 * u ^ 2 := by
        ac_rfl
                          -- 32 行目: `complex_numbers_form_a_field` の和の結合律・可換律
    _ = c₁ ^ 2 * c₂' ^ 2 + (-(2 * c₁ * c₂' * s₁ * s₂' * u) + (2 * c₁ * c₂' * s₁ * s₂' * u)) + s₁ ^ 2 * s₂' ^ 2 * u ^ 2 + (-1) * (c₁ ^ 2 * s₂' ^ 2 * u ^ 2)
          + (-1) * (s₁ ^ 2 * c₂' ^ 2) + (-1) * s₂' ^ 2 + s₂' ^ 2 * u ^ 2 := by
        rw [neg_one_mul (2 * c₁ * c₂' * s₁ * s₂' * u)]
                          -- 33 行目: `multiply_by_minus_one` を右辺から左辺へ
    _ = c₁ ^ 2 * c₂' ^ 2 + 0 + s₁ ^ 2 * s₂' ^ 2 * u ^ 2 + (-1) * (c₁ ^ 2 * s₂' ^ 2 * u ^ 2)
          + (-1) * (s₁ ^ 2 * c₂' ^ 2) + (-1) * s₂' ^ 2 + s₂' ^ 2 * u ^ 2 := by
        rw [neg_add_cancel (2 * c₁ * c₂' * s₁ * s₂' * u)]
                          -- 34 行目: `complex_numbers_form_a_field` の加法逆元
    _ = c₁ ^ 2 * c₂' ^ 2 + s₁ ^ 2 * s₂' ^ 2 * u ^ 2 + (-1) * (c₁ ^ 2 * s₂' ^ 2 * u ^ 2)
          + (-1) * (s₁ ^ 2 * c₂' ^ 2) + (-1) * s₂' ^ 2 + s₂' ^ 2 * u ^ 2 := by
        rw [add_zero (c₁ ^ 2 * c₂' ^ 2)]
                          -- 35 行目: `complex_numbers_form_a_field` の零元
    _ = c₁ ^ 2 * c₂' ^ 2 + (-1) * (s₁ ^ 2 * c₂' ^ 2) + (-1) * s₂' ^ 2
          + s₁ ^ 2 * s₂' ^ 2 * u ^ 2 + (-1) * (c₁ ^ 2 * s₂' ^ 2 * u ^ 2) + s₂' ^ 2 * u ^ 2 := by
        ac_rfl
                          -- 36 行目: `complex_numbers_form_a_field` の和の結合律・可換律
    _ = c₁ ^ 2 * c₂' ^ 2 + (-1) * (s₁ ^ 2 * c₂' ^ 2) + (-1) * s₂' ^ 2
          + s₁ ^ 2 * s₂' ^ 2 * u ^ 2 + (-1) * (c₁ ^ 2 * s₂' ^ 2 * u ^ 2) + 1 * (s₂' ^ 2 * u ^ 2) := by
        rw [one_mul (s₂' ^ 2 * u ^ 2)]
                          -- 37 行目: `complex_numbers_form_a_field` の積の単位元を右辺から左辺へ
    _ = c₁ ^ 2 * c₂' ^ 2 + ((-1) * s₁ ^ 2) * c₂' ^ 2 + (-1) * s₂' ^ 2
          + s₁ ^ 2 * (s₂' ^ 2 * u ^ 2) + ((-1) * c₁ ^ 2) * (s₂' ^ 2 * u ^ 2) + 1 * (s₂' ^ 2 * u ^ 2) := by
        simp only [mul_assoc]
                          -- 38 行目: `complex_numbers_form_a_field` の積の結合律を 3 箇所へ（`c_1^2(s_2^*)^2u^2` の項には 2 回）
    _ = c₁ ^ 2 * c₂' ^ 2 + ((-1) * s₁ ^ 2) * c₂' ^ 2 + (-1) * s₂' ^ 2
          + (s₁ ^ 2 * (s₂' ^ 2 * u ^ 2) + ((-1) * c₁ ^ 2) * (s₂' ^ 2 * u ^ 2) + 1 * (s₂' ^ 2 * u ^ 2)) := by
        simp only [add_assoc]
                          -- 39 行目: `complex_numbers_form_a_field` の和の結合律
    _ = (c₁ ^ 2 + (-1) * s₁ ^ 2) * c₂' ^ 2 + (-1) * s₂' ^ 2
          + (s₁ ^ 2 + (-1) * c₁ ^ 2 + 1) * (s₂' ^ 2 * u ^ 2) := by
        simp only [add_mul]
                          -- 40 行目: `complex_numbers_form_a_field` の分配律を右辺から左辺へ（`(c_2^*)^2` の 2 項に 1 回、`(s_2^*)^2u^2` の 3 項に 2 回）
    _ = (c₁ ^ 2 + (-1) * s₁ ^ 2) * c₂' ^ 2 + (-1) * s₂' ^ 2
          + ((-1) * c₁ ^ 2 + s₁ ^ 2 + 1) * (s₂' ^ 2 * u ^ 2) := by
        rw [add_comm (s₁ ^ 2) ((-1) * c₁ ^ 2)]
                          -- 41 行目: `complex_numbers_form_a_field` の和の可換律
    _ = (c₁ ^ 2 + (-1) * s₁ ^ 2) * c₂' ^ 2 + (-1) * s₂' ^ 2
          + ((-1) * c₁ ^ 2 + 1 * s₁ ^ 2 + 1) * (s₂' ^ 2 * u ^ 2) := by
        rw [one_mul (s₁ ^ 2)]
                          -- 42 行目: `complex_numbers_form_a_field` の積の単位元を右辺から左辺へ
    _ = (c₁ ^ 2 + (-1) * s₁ ^ 2) * c₂' ^ 2 + (-1) * s₂' ^ 2
          + ((-1) * c₁ ^ 2 + (((-1) * (-1) : ℝ) : ℂ) * s₁ ^ 2 + 1) * (s₂' ^ 2 * u ^ 2) := by
        rw [show ((-1) * (-1) : ℝ) = 1 by norm_num, Complex.ofReal_one]
                          -- 43 行目: ℝ の四則 `1 = (-1)(-1)`（`1_ℂ` は略記 `(1)_ℂ`）
    _ = (c₁ ^ 2 + (-1) * s₁ ^ 2) * c₂' ^ 2 + (-1) * s₂' ^ 2
          + ((-1) * c₁ ^ 2 + ((-1) * (-1)) * s₁ ^ 2 + 1) * (s₂' ^ 2 * u ^ 2) := by
        rw [← real_inclusion_mul (-1) (-1), Complex.ofReal_neg, Complex.ofReal_one]
                          -- 44 行目: `real_inclusion_preserves_product` を右辺から左辺へ（`-1_ℂ` は略記 `(-1)_ℂ`）
    _ = (c₁ ^ 2 + (-1) * s₁ ^ 2) * c₂' ^ 2 + (-1) * s₂' ^ 2
          + ((-1) * c₁ ^ 2 + (-1) * ((-1) * s₁ ^ 2) + 1) * (s₂' ^ 2 * u ^ 2) := by
        rw [mul_assoc (-1 : ℂ) (-1) (s₁ ^ 2)]
                          -- 45 行目: `complex_numbers_form_a_field` の積の結合律
    _ = (c₁ ^ 2 + (-1) * s₁ ^ 2) * c₂' ^ 2 + (-1) * s₂' ^ 2
          + ((-1) * (c₁ ^ 2 + (-1) * s₁ ^ 2) + 1) * (s₂' ^ 2 * u ^ 2) := by
        rw [mul_add (-1 : ℂ) (c₁ ^ 2) ((-1) * s₁ ^ 2)]
                          -- 46 行目: `complex_numbers_form_a_field` の分配律を右辺から左辺へ
    _ = (c₁ ^ 2 + -s₁ ^ 2) * c₂' ^ 2 + (-1) * s₂' ^ 2
          + ((-1) * (c₁ ^ 2 + -s₁ ^ 2) + 1) * (s₂' ^ 2 * u ^ 2) := by
        rw [neg_one_mul (s₁ ^ 2)]
                          -- 47 行目: `multiply_by_minus_one` を 2 箇所へ右辺から左辺へ
    _ = (c₁ ^ 2 - s₁ ^ 2) * c₂' ^ 2 + (-1) * s₂' ^ 2
          + ((-1) * (c₁ ^ 2 - s₁ ^ 2) + 1) * (s₂' ^ 2 * u ^ 2) := by
        rw [← sub_eq_add_neg (c₁ ^ 2) (s₁ ^ 2)]
                          -- 48 行目: `def_complex_difference` を 2 箇所へ右辺から左辺へ
    _ = 1 * c₂' ^ 2 + (-1) * s₂' ^ 2 + ((-1) * 1 + 1) * (s₂' ^ 2 * u ^ 2) := by
        rw [H1]
                          -- 49 行目: 上の `c_1^2 - s_1^2 = 1` を 2 箇所へ（`IsingParam.c1_sq_sub_s1_sq_inclusion`）
    _ = c₂' ^ 2 + (-1) * s₂' ^ 2 + ((-1) + 1) * (s₂' ^ 2 * u ^ 2) := by
        rw [one_mul (c₂' ^ 2), mul_one (-1 : ℂ)]
                          -- 50 行目: `complex_numbers_form_a_field` の積の単位元を 2 箇所へ
    _ = c₂' ^ 2 + (-1) * s₂' ^ 2 + (((-1) + 1 : ℝ) : ℂ) * (s₂' ^ 2 * u ^ 2) := by
        rw [← real_inclusion_add (-1) 1, Complex.ofReal_neg, Complex.ofReal_one]
                          -- 51 行目: `real_inclusion_preserves_sum`（`a → -1, b → 1`）
    _ = c₂' ^ 2 + (-1) * s₂' ^ 2 + ((0 : ℝ) : ℂ) * (s₂' ^ 2 * u ^ 2) := by
        rw [show ((-1) + 1 : ℝ) = 0 by norm_num]
                          -- 52 行目: ℝ の四則 `(-1) + 1 = 0`
    _ = c₂' ^ 2 + (-1) * s₂' ^ 2 + 0 := by
        rw [Complex.ofReal_zero, zero_mul (s₂' ^ 2 * u ^ 2)]
                          -- 53 行目: `complex_zero_times_is_zero`（`0_ℂ` は略記 `(0)_ℂ`。具体版が無く `zero_mul`）
    _ = c₂' ^ 2 + (-1) * s₂' ^ 2 := by
        rw [add_zero]
                          -- 54 行目: `complex_numbers_form_a_field` の零元
    _ = c₂' ^ 2 + -s₂' ^ 2 := by
        rw [neg_one_mul (s₂' ^ 2)]
                          -- 55 行目: `multiply_by_minus_one` を右辺から左辺へ
    _ = c₂' ^ 2 - s₂' ^ 2 := by
        rw [← sub_eq_add_neg]
                          -- 56 行目: `def_complex_difference` を右辺から左辺へ
    _ = 1 := H2
                          -- 57 行目: 上の `(c_2^*)^2 - (s_2^*)^2 = 1`（`IsingParam.c2star_sq_sub_s2star_sq_inclusion`）

/-- **人手証明 `det_A_theta_tilde` の第 2 式**（第 2 の等式の鎖）: `γ_1^2 + γ_2(θ~)γ_2(-θ~) = 1`。
人手の 1〜29 行は `gamma1_sq_add_gamma2_mul_chain_first_half`、30〜57 行は `gamma1_sq_add_gamma2_mul_chain_second_half` である。 -/
theorem gamma1_sq_add_gamma2_mul_thetaTilde
    (hdual : P.const.c2 * P.const.s2star = P.const.c2star) (M : ℕ) (μ : ℤ) :
    gamma1 P.const (thetaTilde M μ) ^ 2
      + gamma2 P.const (thetaTilde M μ) * gamma2 P.const (-thetaTilde M μ) = 1 :=
  calc gamma1 P.const (thetaTilde M μ) ^ 2
        + gamma2 P.const (thetaTilde M μ) * gamma2 P.const (-thetaTilde M μ)
      = (P.const.c1 : ℂ) ^ 2 * (P.const.c2star : ℂ) ^ 2
          - 2 * (P.const.c1 : ℂ) * (P.const.c2star : ℂ) * (P.const.s1 : ℂ) * (P.const.s2star : ℂ)
              * (Real.cos (thetaTilde M μ) : ℂ)
          + (P.const.s1 : ℂ) ^ 2 * (P.const.s2star : ℂ) ^ 2 * (Real.cos (thetaTilde M μ) : ℂ) ^ 2
          - (P.const.c1 : ℂ) ^ 2 * (P.const.s2star : ℂ) ^ 2 * (Real.cos (thetaTilde M μ) : ℂ) ^ 2
          + 2 * (P.const.c1 : ℂ) * (P.const.c2star : ℂ) * (P.const.s1 : ℂ) * (P.const.s2star : ℂ)
              * (Real.cos (thetaTilde M μ) : ℂ)
          - (P.const.s1 : ℂ) ^ 2 * (P.const.c2star : ℂ) ^ 2 - (P.const.s2star : ℂ) ^ 2
          + (P.const.s2star : ℂ) ^ 2 * (Real.cos (thetaTilde M μ) : ℂ) ^ 2 :=
        gamma1_sq_add_gamma2_mul_chain_first_half P.const (thetaTilde M μ) hdual _ rfl   -- 人手の 1〜29 行
    _ = 1 :=
        gamma1_sq_add_gamma2_mul_chain_second_half _ _ _ _ _
          P.c1_sq_sub_s1_sq_inclusion P.c2star_sq_sub_s2star_sq_inclusion          -- 人手の 30〜57 行

/-- **人手証明 `det_A_theta_tilde` の第 1 式**: `det A(θ~_μ) = 1`（第 1 の等式の鎖の 1〜9 行 `det_AMat_eq_gamma1_sq_add` と、
10 行目「上の第 2 の等式の鎖」`gamma1_sq_add_gamma2_mul_thetaTilde`）。
仮定 `hdual` は人手の第三の準備の三つ目の双曲線の関係 `c_2 s_2^* = c_2^*`（`duality_c2_star_eq_s2_star_c2`）。 -/
theorem det_AMat_thetaTilde_eq_one (hdual : P.const.c2 * P.const.s2star = P.const.c2star)
    (M : ℕ) (μ : ℤ) : (AMat P.const (thetaTilde M μ)).det = 1 := by
  rw [det_AMat_eq_gamma1_sq_add, gamma1_sq_add_gamma2_mul_thetaTilde P hdual M μ]

/-- **必要十分版からの導出**（同じ主張の別証明）: `det A(θ~_μ) = 1` は
`NecSuf.gamma_det_identity`（任意の可換環の多項式恒等式）を ℂ に特殊化したものである。 -/
theorem det_AMat_thetaTilde_eq_one_of_necSuf
    (hdual : P.const.c2 * P.const.s2star = P.const.c2star) (M : ℕ) (μ : ℤ) :
    (AMat P.const (thetaTilde M μ)).det = 1 := by
  set θ := thetaTilde M μ with hθ
  have H1 : (P.const.c1 : ℂ) ^ 2 - (P.const.s1 : ℂ) ^ 2 = 1 := P.c1_sq_sub_s1_sq_inclusion
  have H2 : (P.const.c2star : ℂ) ^ 2 - (P.const.s2star : ℂ) ^ 2 = 1 :=
    P.c2star_sq_sub_s2star_sq_inclusion
  have H3 : (P.const.c2 : ℂ) * (P.const.s2star : ℂ) = (P.const.c2star : ℂ) :=
    c2_mul_s2star_inclusion P.const hdual
  have HPy : (Real.cos θ : ℂ) ^ 2 + (Real.sin θ : ℂ) ^ 2 = 1 := by
    rw [real_inclusion_sq_via_product, real_inclusion_sq_via_product, real_inclusion_add,
      Real.cos_sq_add_sin_sq, Complex.ofReal_one]
      -- 準備の像の読み方の和: `real_inclusion_preserves_sum`
  rw [det_AMat_eq_gamma1_sq_add, gamma2_mul_gamma2_neg_sin_form P.const θ _ rfl, gamma1_eq_inclusion_form]
  linear_combination
    NecSuf.gamma_det_identity (P.const.c1 : ℂ) (P.const.s1 : ℂ) (P.const.c2 : ℂ)
      (P.const.c2star : ℂ) (P.const.s2star : ℂ) (Real.cos θ : ℂ) (Real.sin θ : ℂ)
      HPy H1 H2 H3

/-- **人手証明 `det_A_theta_tilde` の第 3 式**: `λ_{+,μ} λ_{-,μ} = 1`。
人手の「まず ℂ の中で」の 23 行の鎖（左辺だけの行を 1 行目と数える）と 1 段ずつの `calc` で `((λ_+λ_- : ℝ) : ℂ) = ((1 : ℝ) : ℂ)` を示し、
`inclusion_rr_to_cc` の対の第 1 成分の比較（`Complex.ofReal_injective`）で ℝ の等式に戻す。
`A := |γ_2(θ)|`（人手の `r`）とし、人手が像の記号を省く `γ_1(θ)`（5 行目以降）・`r`（5〜15 行）は `gamma1 P.const θ`・`(A : ℂ)` である。
22 行目で引く (2) の Lean の形 `gamma2_mul_gamma2_neg_eq_neg_absSq` は右辺が `-((A^2 : ℝ) : ℂ)` で、人手の (2) の右辺
`(-A^2)_ℂ` と符号反転の置き場が違う。その差を `Complex.ofReal_neg` で埋めている（(2) の Lean の形を人手に揃える件として状態台帳に残す）。 -/
theorem lambda_mul_lambda_thetaTilde (hdual : P.const.c2 * P.const.s2star = P.const.c2star)
    (M : ℕ) (μ : ℤ) :
    lambdaPlusR P.const (thetaTilde M μ) * lambdaMinusR P.const (thetaTilde M μ) = 1 := by
  set θ := thetaTilde M μ
  set A : ℝ := absGamma2 P.const θ with hA
  set g : ℂ := gamma1 P.const θ with hg
  have hC : ((lambdaPlusR P.const θ * lambdaMinusR P.const θ : ℝ) : ℂ) = ((1 : ℝ) : ℂ) :=
    calc ((lambdaPlusR P.const θ * lambdaMinusR P.const θ : ℝ) : ℂ)
        = ((lambdaPlusR P.const θ : ℝ) : ℂ) * ((lambdaMinusR P.const θ : ℝ) : ℂ) :=
          (real_inclusion_mul _ _).symm
                          -- 2 行目: `real_inclusion_preserves_product` を右辺から左辺へ
      _ = ((gamma1R P.const θ + A : ℝ) : ℂ) * ((gamma1R P.const θ - A : ℝ) : ℂ) := rfl
                          -- 3 行目: `eigenvector_of_A_theta_tilde`
      _ = ((gamma1R P.const θ : ℂ) + (A : ℂ)) * ((gamma1R P.const θ - A : ℝ) : ℂ) := by
          rw [← real_inclusion_add]
                          -- 4 行目: `real_inclusion_preserves_sum`（`a → γ_1(θ)`、`b → r`）を右辺から左辺へ
      _ = (g + (A : ℂ)) * (g - (A : ℂ)) := by
          rw [← real_inclusion_sub, hg, ← gamma1_eq_ofReal]
                          -- 5 行目: `real_inclusion_preserves_difference`（`y → γ_1(θ)`、`z → r`）を右辺から左辺へ。
                          -- この行から `γ_1(θ)` の像 `(gamma1R : ℂ)` を `g`（`gamma1_eq_ofReal`）と書く
      _ = (g + (A : ℂ)) * (g + (-(A : ℂ))) := by rw [sub_eq_add_neg]
                          -- 6 行目: `def_complex_difference`
      _ = (g * g + (A : ℂ) * g) + (g * (-(A : ℂ)) + (A : ℂ) * (-(A : ℂ))) := by
          rw [mul_add, add_mul, add_mul]
                          -- 7 行目: `complex_numbers_form_a_field` の分配律（外側に 1 回、続けて内側の 2 箇所へ）
      _ = g * g + ((A : ℂ) * g + (g * (-(A : ℂ)) + (A : ℂ) * (-(A : ℂ)))) := add_assoc _ _ _
                          -- 8 行目: `complex_numbers_form_a_field` の和の結合律
      _ = g * g + (((A : ℂ) * g + g * (-(A : ℂ))) + (A : ℂ) * (-(A : ℂ))) := by
          rw [← add_assoc ((A : ℂ) * g)]
                          -- 9 行目: `complex_numbers_form_a_field` の和の結合律を右辺から左辺へ
      _ = g * g + (((A : ℂ) * g + g * ((-1) * (A : ℂ))) + (A : ℂ) * ((-1) * (A : ℂ))) := by
          rw [neg_one_mul]
                          -- 10 行目: `multiply_by_minus_one` を 2 箇所へ
      _ = g * g + (((A : ℂ) * g + (-1) * ((A : ℂ) * g)) + (-1) * ((A : ℂ) * (A : ℂ))) := by
          rw [mul_left_comm g (-1 : ℂ) (A : ℂ), mul_comm g (A : ℂ), mul_left_comm (A : ℂ) (-1 : ℂ) (A : ℂ)]
                          -- 11 行目: `complex_numbers_form_a_field` の積の結合律・可換律
      _ = g * g + (((A : ℂ) * g + (-((A : ℂ) * g))) + (-((A : ℂ) * (A : ℂ)))) := by
          rw [neg_one_mul, neg_one_mul]
                          -- 12 行目: `multiply_by_minus_one` を 2 箇所へ右辺から左辺へ
      _ = g * g + (0 + (-((A : ℂ) * (A : ℂ)))) := by rw [add_neg_cancel]
                          -- 13 行目: `complex_numbers_form_a_field` の加法逆元
      _ = (g * g + 0) + (-((A : ℂ) * (A : ℂ))) := (add_assoc _ _ _).symm
                          -- 14 行目: `complex_numbers_form_a_field` の和の結合律を右辺から左辺へ
      _ = g * g + (-((A : ℂ) * (A : ℂ))) := by rw [add_zero]
                          -- 15 行目: `complex_numbers_form_a_field` の零元
      _ = g * g + (-((A * A : ℝ) : ℂ)) := by rw [real_inclusion_mul]
                          -- 16 行目: `real_inclusion_preserves_product`
      _ = g * g + (-((A ^ 2 : ℝ) : ℂ)) := by rw [square_of_real_number_is_product A]
                          -- 17 行目: `square_of_real_number_is_product` を右辺から左辺へ
      _ = g * g + (-1) * ((A ^ 2 : ℝ) : ℂ) := by rw [neg_one_mul]
                          -- 18 行目: `multiply_by_minus_one`
      _ = g * g + (((-1) * A ^ 2 : ℝ) : ℂ) := by
          rw [← real_inclusion_mul, Complex.ofReal_neg, Complex.ofReal_one]
                          -- 19 行目: `real_inclusion_preserves_product`（`-1_ℂ` は略記 `(-1)_ℂ`）
      _ = g * g + ((-(A ^ 2) : ℝ) : ℂ) := by rw [neg_one_mul]
                          -- 20 行目: ℝ の四則 `(-1)x = -x`
      _ = g ^ 2 + ((-(A ^ 2) : ℝ) : ℂ) := by rw [sq g]
                          -- 21 行目: `def_power_of_complex_number` より `z^2 = zz` を右辺から左辺へ
      _ = g ^ 2 + gamma2 P.const θ * gamma2 P.const (-θ) := by
          rw [gamma2_mul_gamma2_neg_eq_neg_absSq, Complex.ofReal_neg]
                          -- 22 行目: `relation_of_gamma_2_theta_tilde` (2) を右辺から左辺へ（Lean の (2) の右辺 `-((A^2 : ℝ) : ℂ)` との
                          -- 差は `Complex.ofReal_neg`。上の docstring の件）
      _ = 1 := gamma1_sq_add_gamma2_mul_thetaTilde P hdual M μ
                          -- 23 行目: 上の第 2 の等式の鎖
      _ = ((1 : ℝ) : ℂ) := Complex.ofReal_one.symm
                          -- `1_ℂ` は `inclusion_rr_to_cc` の略記 `(1)_ℂ`（対の比較の 3・4 行目への橋渡し）
  exact Complex.ofReal_injective hC
                          -- `definition_of_cc` の台集合 `ℝ^2` の元の第 1 成分の比較

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
      _ = (g : ℂ) * (g : ℂ) := (real_inclusion_mul g g).symm
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
