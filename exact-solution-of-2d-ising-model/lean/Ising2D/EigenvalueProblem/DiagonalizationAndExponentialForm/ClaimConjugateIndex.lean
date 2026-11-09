/-
# `𝓜̌` の内側で共役添字を取る（**具体版**）

対応する人手証明のラベル: `conjugate_index_of_check_Z_Y`
（`structured-latex/content/eigenvalue_problem_diagonalization_and_exponential_form.ts` の
`evensector_003b_claim_conjugate_index_of_check_Z_Y`）

**必要十分版は無い。** (1)(3) は `θ~` の定義と添字の周期性（既存の必要十分版
`Ising2D.NecSuf.transform_periodic` の特殊化）から出る書き換えで、
新たに取り払える構造が無い。(2) は (1)・指数法則・負の角の Euler の公式・`cos(2πj) = 1, sin(2πj) = 0`
と、包含の和・積の保存と ℂ の符号の計算の行で、使っているのは複素指数関数のこれらの性質と
ℝ・ℂ の体の等式だけであり、取り払える構造が無い。

## 原文の主張（`μ ∈ 𝓜̌`）

  (1) `θ~_{M+1-μ} = 2π - θ~_μ`
  (2) `e^{-ij θ~_{M+1-μ}} = e^{ij θ~_μ}`  (`j ∈ ℤ`)
  (3) `check(Z)_{M+1-μ} = check(Z)_{1-μ}`,  `check(Y)_{M+1-μ} = check(Y)_{1-μ}`

(1)(2) は `μ ∈ ℤ` 全体で成り立つので、Lean でも `μ : ℤ` のまま述べる
（`𝓜̌` への制限は必要ない）。
-/
import Ising2D.EigenvalueProblem.ReductionToATheta.DefinitionCheckIndexSet
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesProduct
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesSum

namespace Ising2D

variable {M : ℕ}

/-- **(1)**: `θ~_{M+1-μ} = 2π - θ~_μ`。 -/
theorem thetaTilde_conj (hM : M ≠ 0) (μ : ℤ) :
    thetaTilde M ((M : ℤ) + 1 - μ) = 2 * Real.pi - thetaTilde M μ := by
  have hMR : (M : ℝ) ≠ 0 := Nat.cast_ne_zero.mpr hM
  rw [thetaTilde, thetaTilde]
  push_cast
  field_simp
  ring

/-- **(2) の準備の第一の鎖**（実数の側）: `j_ℝ θ~_{M+1-μ} = 2π j_ℝ + (-(j_ℝ θ~_μ))`。
人手の 4 行（直前の (1)、ℝ の分配法則、ℝ の積の交換律、ℝ の差は加法の逆元の和）に 1 段ずつ対応する。 -/
theorem conj_index_exponent_real_chain (hM : M ≠ 0) (k μ : ℤ) :
    (k : ℝ) * thetaTilde M ((M : ℤ) + 1 - μ)
      = 2 * Real.pi * (k : ℝ) + (-((k : ℝ) * thetaTilde M μ)) :=
  calc (k : ℝ) * thetaTilde M ((M : ℤ) + 1 - μ)
      = (k : ℝ) * (2 * Real.pi - thetaTilde M μ) := by rw [thetaTilde_conj hM μ]  -- 直前の (1)
    _ = (k : ℝ) * (2 * Real.pi) - (k : ℝ) * thetaTilde M μ := mul_sub _ _ _      -- ℝ の分配法則
    _ = 2 * Real.pi * (k : ℝ) - (k : ℝ) * thetaTilde M μ := by
        rw [mul_comm (k : ℝ) (2 * Real.pi)]                                       -- ℝ の積の交換律
    _ = 2 * Real.pi * (k : ℝ) + (-((k : ℝ) * thetaTilde M μ)) := sub_eq_add_neg _ _ -- ℝ の差は加法の逆元の和

/-- **(2) の準備の第二の鎖**（複素数の側）: `(-i)(-x)_ℂ = i x_ℂ`（`x ∈ ℝ`。人手では `x = j_ℝ θ~_μ`）。
人手の 7 行に 1 段ずつ対応する。2 段目の積の像は具体版 `real_inclusion_mul`（人手 `real_inclusion_preserves_product`）を
右辺から左辺へ当てる。3 段目の `(-1_ℝ)_ℂ = -1_ℂ` は人手どおり、`inclusion_rr_to_cc` の `(-1_ℝ, 0_ℝ)` に
`1_ℂ = (1_ℝ, 0_ℝ)` を `definition_of_cc` の和で足すと `(-1_ℝ + 1_ℝ, 0_ℝ + 0_ℝ) = (0_ℝ, 0_ℝ) = 0_ℂ` になるので、
`complex_numbers_form_a_field` の加法の逆元の一意性から `1_ℂ` の加法の逆元 `-1_ℂ` である、として示す。 -/
theorem neg_I_mul_real_inclusion_neg (x : ℝ) :
    (-Complex.I) * ((-x : ℝ) : ℂ) = Complex.I * (x : ℂ) :=
  calc (-Complex.I) * ((-x : ℝ) : ℂ)
      = (-Complex.I) * (((-1) * x : ℝ) : ℂ) := by rw [neg_one_mul]         -- ℝ で `-x = (-1_ℝ)x`
    _ = (-Complex.I) * (((-1 : ℝ) : ℂ) * (x : ℂ)) := by
        rw [real_inclusion_mul]                                             -- `real_inclusion_preserves_product`
    _ = (-Complex.I) * ((-1 : ℂ) * (x : ℂ)) := by
        rw [show ((-1 : ℝ) : ℂ) = (-1 : ℂ) from
          eq_neg_of_add_eq_zero_left
            (Complex.ext (show (-1 : ℝ) + 1 = 0 from neg_add_cancel 1) (show (0 : ℝ) + 0 = 0 from add_zero 0))]
                                                                            -- `(-1_ℝ)_ℂ = -1_ℂ`
    _ = ((-1 : ℂ) * Complex.I) * ((-1 : ℂ) * (x : ℂ)) := by
        rw [neg_one_mul Complex.I]                                          -- `multiply_by_minus_one`
    _ = ((-1 : ℂ) * (-1 : ℂ)) * (Complex.I * (x : ℂ)) := mul_mul_mul_comm _ _ _ _ -- ℂ の積の結合律と交換律
    _ = 1 * (Complex.I * (x : ℂ)) := by
        rw [neg_one_mul, neg_neg]          -- `(-1_ℂ)(-1_ℂ) = 1_ℂ`（`(-1)(-1) = -(-1) = 1`）
    _ = Complex.I * (x : ℂ) := one_mul _                                    -- `1_ℂ` は積の単位元

/-- **(2)**: `e^{-ij θ~_{M+1-μ}} = e^{ij θ~_μ}`（`j ∈ ℤ`）。

人手の整数 `j` は Lean の `k` である。右辺の `e^{ij θ~_μ}` は `e^{-i(-j) θ~_μ} = checkPhase M (-j) μ` である。
本体の `calc` の 2 段目から 16 段目が人手の主張の左辺から始まる鎖の 15 行に 1 段ずつ対応する。
1 段目と最後の段は、`checkPhase` を人手の `exp(-i(j_ℝ θ~)_ℂ)` の形で読む書き換えで、人手の行ではない
（`checkPhase_eq_exp` は `-(i · k_ℂ · θ~_ℂ)` の形で、人手の `(-i)(j_ℝ θ~)_ℂ` に `real_inclusion_mul` で直す）。

- 人手の `real_inclusion_preserves_finite_sum` を `m = 2` で当てる行（二項の和の像）は、
  2 項の場合の具体版 `real_inclusion_add`（人手 `real_inclusion_preserves_sum`）を右辺から左辺へ当てる。
- 負の角の Euler の公式 `exp_of_negative_i_real_as_cos_minus_i_sin` の行は、この人手のブロックの具体版が Lean に無いので、
  `exp(φ i) = cos φ + i sin φ`（`Complex.exp_mul_I`）を `φ = -(2πj)_ℂ` に当て、`cos(-x) = cos x`・`sin(-x) = -sin x` と
  実数の `cos`・`sin` の像（`Complex.ofReal_cos`・`Complex.ofReal_sin`）で書き直す。
- `cos(2πn_ℝ) = 1_ℝ` は実数の `Real.cos_int_mul_two_pi` である。`sin(2πn_ℝ) = 0_ℝ` は `2πj_ℝ = (2j)_ℝ π` と読み、
  `sin(nπ) = 0`（`Real.sin_int_mul_pi`）を `2j` に当てる。
- 指数法則 `scalar_exp_product` の行は、`def_scalar_exp` の具体版が Lean に無いので mathlib の `Complex.exp_add` で表す
  （`ClaimRealExpPositive.lean` などと同じ扱い）。
- `(1_ℝ)_ℂ = (1_ℝ, 0_ℝ) = 1_ℂ`・`(0_ℝ)_ℂ = (0_ℝ, 0_ℝ) = 0_ℂ` は `inclusion_rr_to_cc` の `(r, 0)` そのもの（`rfl`）。 -/
theorem checkPhase_conj' (hM : M ≠ 0) (k μ : ℤ) :
    checkPhase M k ((M : ℤ) + 1 - μ) = checkPhase M (-k) μ := by
  calc checkPhase M k ((M : ℤ) + 1 - μ)
      -- （読み）checkPhase は e^{-ik θ~_{M+1-μ}} そのもの。人手の形 `(-i)(j_ℝ θ~)_ℂ` に直す
      = Complex.exp ((-Complex.I) * (((k : ℝ) * thetaTilde M ((M : ℤ) + 1 - μ) : ℝ) : ℂ)) := by
        rw [checkPhase_eq_exp hM k _, ← real_inclusion_mul, Complex.ofReal_intCast, neg_mul,
          mul_assoc]
      -- (∵ 準備の第一の鎖)
    _ = Complex.exp ((-Complex.I)
          * ((2 * Real.pi * (k : ℝ) + (-((k : ℝ) * thetaTilde M μ)) : ℝ) : ℂ)) := by
        rw [conj_index_exponent_real_chain hM k μ]
      -- (∵ real_inclusion_preserves_finite_sum を m = 2 で。2 項の場合の real_inclusion_add を右辺から左辺へ)
    _ = Complex.exp ((-Complex.I)
          * (((2 * Real.pi * (k : ℝ) : ℝ) : ℂ) + ((-((k : ℝ) * thetaTilde M μ) : ℝ) : ℂ))) := by
        rw [real_inclusion_add]
      -- (∵ ℂ の分配法則)
    _ = Complex.exp ((-Complex.I) * ((2 * Real.pi * (k : ℝ) : ℝ) : ℂ)
          + (-Complex.I) * ((-((k : ℝ) * thetaTilde M μ) : ℝ) : ℂ)) := by
        rw [mul_add]
      -- (∵ 準備の第二の鎖)
    _ = Complex.exp ((-Complex.I) * ((2 * Real.pi * (k : ℝ) : ℝ) : ℂ)
          + Complex.I * (((k : ℝ) * thetaTilde M μ : ℝ) : ℂ)) := by
        rw [neg_I_mul_real_inclusion_neg]
      -- (∵ scalar_exp_product を K = ℂ で。Lean は mathlib の Complex.exp_add)
    _ = Complex.exp ((-Complex.I) * ((2 * Real.pi * (k : ℝ) : ℝ) : ℂ))
          * Complex.exp (Complex.I * (((k : ℝ) * thetaTilde M μ : ℝ) : ℂ)) :=
        Complex.exp_add _ _
      -- (∵ exp_of_negative_i_real_as_cos_minus_i_sin を θ = 2πj_ℝ で)
    _ = (((Real.cos (2 * Real.pi * (k : ℝ)) : ℝ) : ℂ)
            - Complex.I * ((Real.sin (2 * Real.pi * (k : ℝ)) : ℝ) : ℂ))
          * Complex.exp (Complex.I * (((k : ℝ) * thetaTilde M μ : ℝ) : ℂ)) := by
        rw [show (-Complex.I) * ((2 * Real.pi * (k : ℝ) : ℝ) : ℂ)
              = (-((2 * Real.pi * (k : ℝ) : ℝ) : ℂ)) * Complex.I by ring,
          Complex.exp_mul_I, Complex.cos_neg, Complex.sin_neg, Complex.ofReal_cos, Complex.ofReal_sin]
        ring
      -- (∵ j ∈ ℤ と全実数上の cos(2πn_ℝ) = 1_ℝ)
    _ = (((1 : ℝ) : ℂ) - Complex.I * ((Real.sin (2 * Real.pi * (k : ℝ)) : ℝ) : ℂ))
          * Complex.exp (Complex.I * (((k : ℝ) * thetaTilde M μ : ℝ) : ℂ)) := by
        rw [mul_comm (2 * Real.pi) (k : ℝ), Real.cos_int_mul_two_pi]
      -- (∵ j ∈ ℤ と全実数上の sin(2πn_ℝ) = 0_ℝ)
    _ = (((1 : ℝ) : ℂ) - Complex.I * ((0 : ℝ) : ℂ))
          * Complex.exp (Complex.I * (((k : ℝ) * thetaTilde M μ : ℝ) : ℂ)) := by
        rw [show 2 * Real.pi * (k : ℝ) = ((2 * k : ℤ) : ℝ) * Real.pi by push_cast; ring,
          Real.sin_int_mul_pi]
      -- (∵ (1_ℝ)_ℂ = (1_ℝ, 0_ℝ) = 1_ℂ、(0_ℝ)_ℂ = (0_ℝ, 0_ℝ) = 0_ℂ。inclusion_rr_to_cc)
    _ = (1 - Complex.I * 0) * Complex.exp (Complex.I * (((k : ℝ) * thetaTilde M μ : ℝ) : ℂ)) := rfl
      -- (∵ complex_times_zero_is_zero)
    _ = (1 - 0) * Complex.exp (Complex.I * (((k : ℝ) * thetaTilde M μ : ℝ) : ℂ)) := by
        rw [mul_zero]
      -- (∵ def_complex_difference)
    _ = (1 + (-0)) * Complex.exp (Complex.I * (((k : ℝ) * thetaTilde M μ : ℝ) : ℂ)) := by
        rw [sub_eq_add_neg]
      -- (∵ multiply_by_minus_one)
    _ = (1 + (-1) * 0) * Complex.exp (Complex.I * (((k : ℝ) * thetaTilde M μ : ℝ) : ℂ)) := by
        rw [neg_one_mul]
      -- (∵ complex_times_zero_is_zero)
    _ = (1 + 0) * Complex.exp (Complex.I * (((k : ℝ) * thetaTilde M μ : ℝ) : ℂ)) := by
        rw [mul_zero]
      -- (∵ 0_ℂ は和の単位元)
    _ = 1 * Complex.exp (Complex.I * (((k : ℝ) * thetaTilde M μ : ℝ) : ℂ)) := by
        rw [add_zero]
      -- (∵ 1_ℂ は積の単位元)
    _ = Complex.exp (Complex.I * (((k : ℝ) * thetaTilde M μ : ℝ) : ℂ)) := one_mul _
      -- （読み）checkPhase は e^{-i(-k) θ~_μ} そのもの
    _ = checkPhase M (-k) μ := by
        rw [checkPhase_eq_exp hM, ← real_inclusion_mul, Complex.ofReal_intCast]
        congr 1
        push_cast
        ring

/-- (2) を `2M` 乗根の位相因子で書いた形: `e^{-ij θ~_{M+1-μ}} = exp(2π√-1 · j(2μ-1)/(2M))`。
`(2)` の右辺 `checkPhase M (-j) μ` を `checkPhase` の定義で開いたものである。 -/
theorem checkPhase_conj (hM : M ≠ 0) (k μ : ℤ) :
    checkPhase M k ((M : ℤ) + 1 - μ) = expPhase (2 * M) (-(k * (2 * μ - 1))) := by
  rw [checkPhase_conj' hM, checkPhase]
  congr 1
  ring

/-- **(3)**: `check(Z)_{M+1-μ} = check(Z)_{1-μ}`。

人手の式変形どおり、添字を `(1-μ)+M` と書き直し、`half_integer_checkZ_periodicity`
（`checkZ_period`）を添字 `1-μ` に当てる。 -/
theorem checkZ_conj (hM : M ≠ 0) (μ : ℤ) : checkZ M ((M : ℤ) + 1 - μ) = checkZ M (1 - μ) := by
  calc
    checkZ M ((M : ℤ) + 1 - μ) = checkZ M ((1 - μ) + (M : ℤ)) := by
      rw [show (M : ℤ) + 1 - μ = (1 - μ) + (M : ℤ) by ring]
    _ = checkZ M (1 - μ) := checkZ_period hM (1 - μ)

/-- **(3)**: `check(Y)_{M+1-μ} = check(Y)_{1-μ}`。

人手の式変形どおり、添字を `(1-μ)+M` と書き直し、`half_integer_checkY_periodicity`
（`checkY_period`）を添字 `1-μ` に当てる。 -/
theorem checkY_conj (hM : M ≠ 0) (μ : ℤ) : checkY M ((M : ℤ) + 1 - μ) = checkY M (1 - μ) := by
  calc
    checkY M ((M : ℤ) + 1 - μ) = checkY M ((1 - μ) + (M : ℤ)) := by
      rw [show (M : ℤ) + 1 - μ = (1 - μ) + (M : ℤ) by ring]
    _ = checkY M (1 - μ) := checkY_period hM (1 - μ)

/-- 共役添字での `check(Z)` の展開（`H1_H2_via_check_Z_Y` の証明の 1 行目）:
`check(Z)_{M+1-μ} = ∑_{k=1}^{M} Z_k e^{ik θ~_μ}`。 -/
theorem checkZ_conj_eq (hM : M ≠ 0) (μ : ℤ) :
    checkZ M ((M : ℤ) + 1 - μ)
      = ∑ k : Fin M, expPhase (2 * M) (-((((k : ℕ) : ℤ) + 1) * (2 * μ - 1))) • Z k :=
  Finset.sum_congr rfl fun k _ => by rw [checkPhase_conj hM]

/-- 共役添字での `check(Y)` の展開。 -/
theorem checkY_conj_eq (hM : M ≠ 0) (μ : ℤ) :
    checkY M ((M : ℤ) + 1 - μ)
      = ∑ k : Fin M, expPhase (2 * M) (-((((k : ℕ) : ℤ) + 1) * (2 * μ - 1))) • Y k :=
  Finset.sum_congr rfl fun k _ => by rw [checkPhase_conj hM]

end Ising2D
