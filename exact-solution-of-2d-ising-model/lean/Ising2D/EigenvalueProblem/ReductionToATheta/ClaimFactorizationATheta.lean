/-
# 具体版: `A(θ) = B_1(θ) B_2 B_1(θ)`（`θ ∈ ℝ` 一般）

対応する人手証明のラベル: **`factorization_of_A_theta_general`**
（`structured-latex/content/eigenvalue_problem_reduction_to_A_theta.ts` の
`evensectorT_009_claim_factorization_A_theta`）

## Lean 側の既存の証明との関係

008 章の `factorization_of_A_theta` は `μ ∈ 𝓜` で量化されており、原文はそのままでは
`θ~_μ` に使えないので、本章で `θ ∈ ℝ` 一般の主張として立て直している。

**Lean 側の既存定理 `Ising2D.B1_mul_B2_mul_B1_eq_AMat`
（`Ising2D/MathematicalTools/InvertibleMatricesLinearMapCorrespondenceAndConjugation/DefinitionTgAndTV.lean`）は最初から `θ : ℝ` 一般で述べられている**ので、
本章の `factorization_of_A_theta_general` はそれそのものである。
本ファイルでは名前を原文のラベルに合わせて言い直し、`θ = θ~_μ` への特殊化を与える。

## 原文が明示していない前提（008 章と同じ）

`B_1(θ) B_2 B_1(θ)` を素朴に展開すると非対角成分に現れるのは `c_2^*` だが、
`def_A_theta` の `A(θ)` には `c_2` が現れる。一致には双対関係の帰結
`c_2^* = s_2^* c_2` が要る。**本章の原文 `factorization_of_A_theta_general` の proof は
Step 4 でこの等式を `duality_c2_star_eq_s2_star_c2` として明示的に引用しており、
008 章で欠けていた前提がここでは補われている。**
Lean 側では従来どおり仮定 `hdual` として持つ。

## 準備の実数の像の鎖

人手の証明の準備の 7 本の等式のうち、実数の像の演算を使う 3 本
（`a^2 + b^2 = (c_1)_ℂ`、`2ab = (s_1)_ℂ`、`a^2 - b^2 = 1_ℂ`。`a := (cosh K_1)_ℂ`、`b := (sinh K_1)_ℂ`、`K_1 ∈ ℝ`）を、
人手の行と 1 段ずつ対応する calc で置く。

| 人手の鎖 | Lean |
| --- | --- |
| `a^2 + b^2` の 6 行 | `factorization_prep_sq_add_sq`（最後の行 `(cosh 2K_1)_ℂ = (c_1)_ℂ` は `def_indexed_hyperbolic_abbreviations`（Lean の `indexedHyperbolicAbbreviations`）の定義の展開なので、`(cosh 2K_1)_ℂ` で止める） |
| `2ab` の 7 行 | `factorization_prep_two_mul_mul`（最後の行は同じく `(sinh 2K_1)_ℂ` で止める） |
| `a^2 - b^2` の 9 行 | `factorization_prep_sq_sub_sq` |

積の像は具体版 `real_inclusion_mul`（人手 `real_inclusion_preserves_product`）、二項の和の像は具体版 `real_inclusion_add`
（人手 `real_inclusion_preserves_finite_sum` の `m = 2`。二項の和は `real_inclusion_preserves_sum` と同じ式）で受ける。
`-1_ℂ = (-1)_ℂ`・`2 = (2)_ℂ` は人手どおり `inclusion_rr_to_cc` の略記として `Complex.ofReal_neg`・`Complex.ofReal_one`・`Complex.ofReal_ofNat` で読む（`-1_ℂ = (-1)_ℂ` は `real_inclusion_sub` の 3 段目と同じ）。

`cosh_addition_formula` は `cosh_add_formula`、`sinh_double_angle_formula` は `sinh_eq_two_sinh_half_mul_cosh_half`
（どちらも `ClaimCoshAdditionAndHalfAngle.lean`）で受ける。この 2 つは中身が mathlib の `Real.cosh_add`・`Real.sinh_two_mul` で、
人手の証明の鎖と 1 対 1 ではない。またファイルの冒頭は旧ラベル `cosh_addition_and_half_angle`（2026-11-02 に
`cosh_addition_formula`・`sinh_double_angle_formula` などへ分割された）を指したままである。
この 3 本で、具体版が Lean に無いので mathlib で受けた行は `cosh_sinh_basic_properties` (2)（`Real.cosh_sq_sub_sinh_sq`）だけである。

## 準備の `e_±` の鎖、補助的な等式 2 本と `C = S(c_2)_ℂ`

準備の残りの 4 本（`e_+ := exp(i(θ)_ℂ)`、`e_- := exp((-i)(θ)_ℂ)`）と、それらから置く補助的な等式 2 本、
双対関係から置く `C = S(c_2)_ℂ` を、人手の行と 1 段ずつ対応する calc で置く。

| 人手の鎖 | Lean |
| --- | --- |
| `e_+e_-` の 3 行 | `factorization_prep_exp_mul_exp_neg` |
| `e_+ + e_-` の 2 行 | `factorization_prep_exp_add_exp_neg` |
| `e_+` の 2 行 | `factorization_prep_exp_eq_cos_add_sin` |
| `e_-` の 2 行 | `factorization_prep_exp_neg_eq_cos_sub_sin` |
| `a^2 + b^2e_+e_+` の 7 行 | `factorization_aux_plus`（`(c_1)_ℂ` は準備の 1 本目と同じく `(cosh 2K_1)_ℂ` のまま置く） |
| `a^2 + b^2e_-e_-` の 7 行 | `factorization_aux_minus`（同上） |
| `C` の 3 行 | `factorization_prep_C_eq_S_mul_c2`（1 行目 `C = (c_2^*)_ℂ` は定義の展開なので、`c_2^*` を `cosh 2K_2^*` のまま置く） |

`scalar_exp_product`・`scalar_exp_zero`（`K = ℂ`）は、`def_scalar_exp` の具体版が Lean に無いので mathlib の
`Complex.exp_add`・`Complex.exp_zero` で表す（`ClaimAnticommutatorCheckZY.lean` と同じ扱い）。
`euler_formula_cos_sin` の第 1・2 式は具体版が Lean に無いので、`θ ∈ ℝ` の `cos θ`・`sin θ` を包含の像として読んだ形
`euler_cos_as_exp`・`euler_sin_as_exp` を mathlib の `Complex.ofReal_cos`・`Complex.ofReal_sin` と `Complex.cos`・`Complex.sin` の定義で置いて受ける。
「`(2)_ℂ ≠ 0_ℂ`・`(2)_ℂ i ≠ 0_ℂ` と ℂ の四則」「ℂ の分配則と積の交換律・結合律」の行は `field_simp`・`ring` で閉じる。

準備の 7 本・補助的な等式 2 本・`C = S(c_2)_ℂ` はまだ `B1_mul_B2_mul_B1_eq_explicit` の証明から使われていない（あちらは `simp`・`field_simp`・`ring` で成分を一度に計算する）。
人手の Step 1〜6 の calc に組み直すのは状態台帳の別の項目である。組み直すときは、`B1mat` が `K1 : ℂ` と `Complex.cosh K1` で
定義されていて準備の鎖の `a = (cosh K_1)_ℂ`（`K_1 ∈ ℝ`）と式の形が違うので、主張の `K1` を人手どおり実数にするか、橋の補題が要る。
また `B1mat` の指数は `θ * Complex.I`・`-θ * Complex.I` で、準備の `e_±` の `Complex.I * θ`・`(-Complex.I) * θ` と積の順が違うので、ここにも橋の補題が要る。

具体的な数の計算で、主張に固有の構造は実数の像の演算・双曲線関数の公式・複素数の指数法則と Euler の表示だけなので、必要十分版は置かない。
-/
import Ising2D.EigenvalueProblem.ReductionToATheta.ClaimAntiperiodicExpSum
import Ising2D.EigenvalueProblem.ReductionToATheta.ClaimDualityC2StarEqS2StarC2
import Ising2D.EigenvalueProblem.ReductionToATheta.DefinitionB1B2
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesProduct
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesSum
import Ising2D.MathematicalTools.RealSquareRootExponentialAndHyperbolicFunctions.ClaimCoshAdditionAndHalfAngle

namespace Ising2D

variable {M : ℕ}

/-! ## 準備の実数の像の鎖 -/

/-- **人手 `factorization_of_A_theta_general` の準備の 1 本目**:
`a^2 + b^2 = (cosh 2K_1)_ℂ`（`a := (cosh K_1)_ℂ`、`b := (sinh K_1)_ℂ`、`K_1 ∈ ℝ`）。人手の 6 行のうち最初の 5 行と calc の 5 段が 1 対 1 である
（6 行目の `(cosh 2K_1)_ℂ = (c_1)_ℂ` は `def_indexed_hyperbolic_abbreviations` の定義そのもの）。 -/
theorem factorization_prep_sq_add_sq (K1 : ℝ) :
    (Real.cosh K1 : ℂ) ^ 2 + (Real.sinh K1 : ℂ) ^ 2 = ((Real.cosh (2 * K1) : ℝ) : ℂ) :=
  calc (Real.cosh K1 : ℂ) ^ 2 + (Real.sinh K1 : ℂ) ^ 2
      = (Real.cosh K1 : ℂ) * (Real.cosh K1 : ℂ) + (Real.sinh K1 : ℂ) * (Real.sinh K1 : ℂ) := by
        rw [sq, sq]                                                -- `a, b` の定義と二乗の記法
    _ = ((Real.cosh K1 * Real.cosh K1 : ℝ) : ℂ) + ((Real.sinh K1 * Real.sinh K1 : ℝ) : ℂ) := by
        rw [real_inclusion_mul, real_inclusion_mul]                -- `real_inclusion_preserves_product` を 2 箇所へ
    _ = ((Real.cosh K1 * Real.cosh K1 + Real.sinh K1 * Real.sinh K1 : ℝ) : ℂ) :=
        real_inclusion_add _ _                                     -- `real_inclusion_preserves_finite_sum`（`m = 2`）
    _ = ((Real.cosh (K1 + K1) : ℝ) : ℂ) := by
        rw [cosh_add_formula K1 K1]                                -- `cosh_addition_formula` の複号 `+` を `x = y = K_1` で
    _ = ((Real.cosh (2 * K1) : ℝ) : ℂ) := by
        rw [two_mul]                                               -- `K_1 + K_1 = 2K_1`

/-- **人手 `factorization_of_A_theta_general` の準備の 2 本目**:
`2ab = (sinh 2K_1)_ℂ`。人手の 7 行のうち最初の 6 行と calc の 6 段が 1 対 1 である
（7 行目の `(sinh 2K_1)_ℂ = (s_1)_ℂ` は `def_indexed_hyperbolic_abbreviations` の定義そのもの）。 -/
theorem factorization_prep_two_mul_mul (K1 : ℝ) :
    2 * (Real.cosh K1 : ℂ) * (Real.sinh K1 : ℂ) = ((Real.sinh (2 * K1) : ℝ) : ℂ) :=
  calc 2 * (Real.cosh K1 : ℂ) * (Real.sinh K1 : ℂ)
      = ((2 : ℝ) : ℂ) * (Real.cosh K1 : ℂ) * (Real.sinh K1 : ℂ) := by
        rw [Complex.ofReal_ofNat]                                  -- `a, b` の定義と `2 = (2)_ℂ`（`inclusion_rr_to_cc`）
    _ = ((2 * Real.cosh K1 : ℝ) : ℂ) * (Real.sinh K1 : ℂ) := by
        rw [real_inclusion_mul]                                    -- `real_inclusion_preserves_product`
    _ = ((2 * Real.cosh K1 * Real.sinh K1 : ℝ) : ℂ) :=
        real_inclusion_mul _ _                                     -- `real_inclusion_preserves_product`
    _ = ((2 * Real.sinh K1 * Real.cosh K1 : ℝ) : ℂ) := by
        rw [mul_right_comm]                                        -- ℝ の積の交換律
    _ = ((2 * Real.sinh (2 * K1 / 2) * Real.cosh (2 * K1 / 2) : ℝ) : ℂ) := by
        rw [mul_div_cancel_left₀ K1 (two_ne_zero : (2 : ℝ) ≠ 0)]   -- `K_1 = 2K_1/2`
    _ = ((Real.sinh (2 * K1) : ℝ) : ℂ) := by
        rw [← sinh_eq_two_sinh_half_mul_cosh_half (2 * K1)]
                                                                   -- `sinh_double_angle_formula` を `x = 2K_1` で

/-- **人手 `factorization_of_A_theta_general` の準備の 3 本目**:
`a^2 - b^2 = 1_ℂ`。人手の 9 行と calc の 9 段が 1 対 1 である。 -/
theorem factorization_prep_sq_sub_sq (K1 : ℝ) :
    (Real.cosh K1 : ℂ) ^ 2 - (Real.sinh K1 : ℂ) ^ 2 = 1 :=
  calc (Real.cosh K1 : ℂ) ^ 2 - (Real.sinh K1 : ℂ) ^ 2
      = (Real.cosh K1 : ℂ) * (Real.cosh K1 : ℂ) - (Real.sinh K1 : ℂ) * (Real.sinh K1 : ℂ) := by
        rw [sq, sq]                                                -- `a, b` の定義と二乗の記法
    _ = ((Real.cosh K1 * Real.cosh K1 : ℝ) : ℂ) - ((Real.sinh K1 * Real.sinh K1 : ℝ) : ℂ) := by
        rw [real_inclusion_mul, real_inclusion_mul]                -- `real_inclusion_preserves_product` を 2 箇所へ
    _ = ((Real.cosh K1 * Real.cosh K1 : ℝ) : ℂ) + (-1 : ℂ) * ((Real.sinh K1 * Real.sinh K1 : ℝ) : ℂ) := by
        rw [sub_eq_add_neg, neg_one_mul]                           -- `def_complex_difference`・`multiply_by_minus_one`
    _ = ((Real.cosh K1 * Real.cosh K1 : ℝ) : ℂ) + ((-1 : ℝ) : ℂ) * ((Real.sinh K1 * Real.sinh K1 : ℝ) : ℂ) := by
        rw [Complex.ofReal_neg, Complex.ofReal_one]                -- `-1_ℂ = (-1)_ℂ`（`inclusion_rr_to_cc` の略記）
    _ = ((Real.cosh K1 * Real.cosh K1 : ℝ) : ℂ) + (((-1) * (Real.sinh K1 * Real.sinh K1) : ℝ) : ℂ) := by
        rw [real_inclusion_mul]                                    -- `real_inclusion_preserves_product`
    _ = ((Real.cosh K1 * Real.cosh K1 + (-1) * (Real.sinh K1 * Real.sinh K1) : ℝ) : ℂ) :=
        real_inclusion_add _ _                                     -- `real_inclusion_preserves_finite_sum`（`m = 2`）
    _ = ((Real.cosh K1 ^ 2 - Real.sinh K1 ^ 2 : ℝ) : ℂ) := by
        rw [neg_one_mul, ← sub_eq_add_neg, ← sq, ← sq]             -- ℝ の差と二乗の記法
    _ = ((1 : ℝ) : ℂ) := by
        rw [Real.cosh_sq_sub_sinh_sq]                              -- `cosh_sinh_basic_properties` (2)
    _ = 1 := Complex.ofReal_one                                    -- `inclusion_rr_to_cc` の略記

/-! ## 準備の `e_±` の鎖 -/

/-- 人手 `euler_formula_cos_sin` の第 1 式を、`θ ∈ ℝ` の `cos θ` を `inclusion_rr_to_cc` の像として読んだ形
（`(cos θ)_ℂ = (e_+ + e_-)/(2)_ℂ`）。人手のブロックの具体版が Lean に無いので、mathlib の
`Complex.ofReal_cos` と `Complex.cos` の定義で受ける。 -/
theorem euler_cos_as_exp (θ : ℝ) :
    ((Real.cos θ : ℝ) : ℂ)
      = (Complex.exp (Complex.I * (θ : ℂ)) + Complex.exp ((-Complex.I) * (θ : ℂ))) / ((2 : ℝ) : ℂ) := by
  rw [Complex.ofReal_cos, Complex.cos, Complex.ofReal_ofNat]; ring_nf

/-- 人手 `euler_formula_cos_sin` の第 2 式を同じく読んだ形（`(sin θ)_ℂ = (e_+ - e_-)/((2)_ℂ i)`）。
具体版が Lean に無いので、mathlib の `Complex.ofReal_sin` と `Complex.sin` の定義で受ける。 -/
theorem euler_sin_as_exp (θ : ℝ) :
    ((Real.sin θ : ℝ) : ℂ)
      = (Complex.exp (Complex.I * (θ : ℂ)) - Complex.exp ((-Complex.I) * (θ : ℂ)))
          / (((2 : ℝ) : ℂ) * Complex.I) := by
  rw [Complex.ofReal_sin, Complex.sin, Complex.ofReal_ofNat]; field_simp; ring_nf; rw [Complex.I_sq]; ring

/-- **人手 `factorization_of_A_theta_general` の準備の 4 本目**:
`e_+ e_- = 1_ℂ`（`e_+ := exp(i(θ)_ℂ)`、`e_- := exp((-i)(θ)_ℂ)`）。人手の 3 行と calc の 3 段が 1 対 1 である。
`scalar_exp_product`・`scalar_exp_zero`（`K = ℂ`）は、`def_scalar_exp` の具体版が Lean に無いので mathlib の
`Complex.exp_add`・`Complex.exp_zero` で表す。 -/
theorem factorization_prep_exp_mul_exp_neg (θ : ℝ) :
    Complex.exp (Complex.I * (θ : ℂ)) * Complex.exp ((-Complex.I) * (θ : ℂ)) = 1 :=
  calc Complex.exp (Complex.I * (θ : ℂ)) * Complex.exp ((-Complex.I) * (θ : ℂ))
      = Complex.exp (Complex.I * (θ : ℂ) + (-Complex.I) * (θ : ℂ)) :=
        (Complex.exp_add _ _).symm                                 -- `e_±` の定義と `scalar_exp_product`（`K = ℂ`）
    _ = Complex.exp 0 := by
        rw [← add_mul, add_neg_cancel, zero_mul]                   -- ℂ の分配則と `i + (-i) = 0_ℂ`（と `0_ℂ(θ)_ℂ = 0_ℂ`）
    _ = 1 := Complex.exp_zero                                      -- `scalar_exp_zero`（`K = ℂ`）

/-- **人手 `factorization_of_A_theta_general` の準備の 5 本目**:
`e_+ + e_- = (2)_ℂ (cos θ)_ℂ`。人手の 2 行と calc の 2 段が 1 対 1 である。 -/
theorem factorization_prep_exp_add_exp_neg (θ : ℝ) :
    Complex.exp (Complex.I * (θ : ℂ)) + Complex.exp ((-Complex.I) * (θ : ℂ))
      = ((2 : ℝ) : ℂ) * ((Real.cos θ : ℝ) : ℂ) :=
  calc Complex.exp (Complex.I * (θ : ℂ)) + Complex.exp ((-Complex.I) * (θ : ℂ))
      = ((2 : ℝ) : ℂ)
          * ((Complex.exp (Complex.I * (θ : ℂ)) + Complex.exp ((-Complex.I) * (θ : ℂ))) / ((2 : ℝ) : ℂ)) :=
        (mul_div_cancel₀ _ (by norm_num)).symm                     -- `(2)_ℂ ≠ 0_ℂ` と ℂ の四則
    _ = ((2 : ℝ) : ℂ) * ((Real.cos θ : ℝ) : ℂ) := by
        rw [← euler_cos_as_exp]                                    -- `euler_formula_cos_sin` の第 1 式

/-- **人手 `factorization_of_A_theta_general` の準備の 6 本目**:
`e_+ = (cos θ)_ℂ + i(sin θ)_ℂ`。人手の 2 行と calc の 2 段が 1 対 1 である。 -/
theorem factorization_prep_exp_eq_cos_add_sin (θ : ℝ) :
    Complex.exp (Complex.I * (θ : ℂ)) = ((Real.cos θ : ℝ) : ℂ) + Complex.I * ((Real.sin θ : ℝ) : ℂ) :=
  calc Complex.exp (Complex.I * (θ : ℂ))
      = (Complex.exp (Complex.I * (θ : ℂ)) + Complex.exp ((-Complex.I) * (θ : ℂ))) / ((2 : ℝ) : ℂ)
          + Complex.I * ((Complex.exp (Complex.I * (θ : ℂ)) - Complex.exp ((-Complex.I) * (θ : ℂ)))
              / (((2 : ℝ) : ℂ) * Complex.I)) := by
        have h2 : ((2 : ℝ) : ℂ) ≠ 0 := by norm_num
        field_simp; rw [Complex.ofReal_ofNat]; ring                -- `(2)_ℂ ≠ 0_ℂ`・`(2)_ℂ i ≠ 0_ℂ` と ℂ の四則
    _ = ((Real.cos θ : ℝ) : ℂ) + Complex.I * ((Real.sin θ : ℝ) : ℂ) := by
        rw [← euler_cos_as_exp, ← euler_sin_as_exp]                -- `euler_formula_cos_sin` の第 1 式と第 2 式

/-- **人手 `factorization_of_A_theta_general` の準備の 7 本目**:
`e_- = (cos θ)_ℂ - i(sin θ)_ℂ`。人手の 2 行と calc の 2 段が 1 対 1 である。 -/
theorem factorization_prep_exp_neg_eq_cos_sub_sin (θ : ℝ) :
    Complex.exp ((-Complex.I) * (θ : ℂ)) = ((Real.cos θ : ℝ) : ℂ) - Complex.I * ((Real.sin θ : ℝ) : ℂ) :=
  calc Complex.exp ((-Complex.I) * (θ : ℂ))
      = (Complex.exp (Complex.I * (θ : ℂ)) + Complex.exp ((-Complex.I) * (θ : ℂ))) / ((2 : ℝ) : ℂ)
          - Complex.I * ((Complex.exp (Complex.I * (θ : ℂ)) - Complex.exp ((-Complex.I) * (θ : ℂ)))
              / (((2 : ℝ) : ℂ) * Complex.I)) := by
        have h2 : ((2 : ℝ) : ℂ) ≠ 0 := by norm_num
        field_simp; rw [Complex.ofReal_ofNat]; ring                -- `(2)_ℂ ≠ 0_ℂ`・`(2)_ℂ i ≠ 0_ℂ` と ℂ の四則
    _ = ((Real.cos θ : ℝ) : ℂ) - Complex.I * ((Real.sin θ : ℝ) : ℂ) := by
        rw [← euler_cos_as_exp, ← euler_sin_as_exp]                -- `euler_formula_cos_sin` の第 1 式と第 2 式

/-! ## 準備の補助的な等式 2 本と `C = S(c_2)_ℂ` -/

/-- **人手 `factorization_of_A_theta_general` の補助的な等式の 1 本目**:
`a^2 + b^2 e_+ e_+ = e_+((c_1)_ℂ(cos θ)_ℂ - i(sin θ)_ℂ)`。人手の 7 行と calc の 7 段が 1 対 1 である
（`(c_1)_ℂ` は準備の 1 本目と同じく `(cosh 2K_1)_ℂ` のまま置く）。 -/
theorem factorization_aux_plus (K1 θ : ℝ) :
    (Real.cosh K1 : ℂ) ^ 2
        + (Real.sinh K1 : ℂ) ^ 2 * Complex.exp (Complex.I * (θ : ℂ)) * Complex.exp (Complex.I * (θ : ℂ))
      = Complex.exp (Complex.I * (θ : ℂ))
          * (((Real.cosh (2 * K1) : ℝ) : ℂ) * ((Real.cos θ : ℝ) : ℂ) - Complex.I * ((Real.sin θ : ℝ) : ℂ)) :=
  calc (Real.cosh K1 : ℂ) ^ 2
        + (Real.sinh K1 : ℂ) ^ 2 * Complex.exp (Complex.I * (θ : ℂ)) * Complex.exp (Complex.I * (θ : ℂ))
      = (Real.cosh K1 : ℂ) ^ 2
          * (Complex.exp (Complex.I * (θ : ℂ)) * Complex.exp ((-Complex.I) * (θ : ℂ)))
        + (Real.sinh K1 : ℂ) ^ 2 * Complex.exp (Complex.I * (θ : ℂ)) * Complex.exp (Complex.I * (θ : ℂ)) := by
        rw [factorization_prep_exp_mul_exp_neg, mul_one]           -- `e_+ e_- = 1_ℂ`
    _ = Complex.exp (Complex.I * (θ : ℂ))
          * ((Real.cosh K1 : ℂ) ^ 2 * Complex.exp ((-Complex.I) * (θ : ℂ))
            + (Real.sinh K1 : ℂ) ^ 2 * Complex.exp (Complex.I * (θ : ℂ))) := by
        ring                                                       -- ℂ の分配則と積の交換律・結合律
    _ = Complex.exp (Complex.I * (θ : ℂ))
          * ((Real.cosh K1 : ℂ) ^ 2 * (((Real.cos θ : ℝ) : ℂ) - Complex.I * ((Real.sin θ : ℝ) : ℂ))
            + (Real.sinh K1 : ℂ) ^ 2 * Complex.exp (Complex.I * (θ : ℂ))) := by
        rw [factorization_prep_exp_neg_eq_cos_sub_sin]             -- `e_-` の上の表示
    _ = Complex.exp (Complex.I * (θ : ℂ))
          * ((Real.cosh K1 : ℂ) ^ 2 * (((Real.cos θ : ℝ) : ℂ) - Complex.I * ((Real.sin θ : ℝ) : ℂ))
            + (Real.sinh K1 : ℂ) ^ 2 * (((Real.cos θ : ℝ) : ℂ) + Complex.I * ((Real.sin θ : ℝ) : ℂ))) := by
        nth_rw 2 [factorization_prep_exp_eq_cos_add_sin]           -- `e_+` の上の表示（括弧の中の 1 箇所）
    _ = Complex.exp (Complex.I * (θ : ℂ))
          * (((Real.cosh K1 : ℂ) ^ 2 + (Real.sinh K1 : ℂ) ^ 2) * ((Real.cos θ : ℝ) : ℂ)
            - Complex.I * (((Real.cosh K1 : ℂ) ^ 2 - (Real.sinh K1 : ℂ) ^ 2) * ((Real.sin θ : ℝ) : ℂ))) := by
        ring                                                       -- ℂ の分配則
    _ = Complex.exp (Complex.I * (θ : ℂ))
          * (((Real.cosh (2 * K1) : ℝ) : ℂ) * ((Real.cos θ : ℝ) : ℂ)
            - Complex.I * (((Real.cosh K1 : ℂ) ^ 2 - (Real.sinh K1 : ℂ) ^ 2) * ((Real.sin θ : ℝ) : ℂ))) := by
        rw [factorization_prep_sq_add_sq]                          -- `a^2 + b^2 = (c_1)_ℂ`
    _ = Complex.exp (Complex.I * (θ : ℂ))
          * (((Real.cosh (2 * K1) : ℝ) : ℂ) * ((Real.cos θ : ℝ) : ℂ) - Complex.I * ((Real.sin θ : ℝ) : ℂ)) := by
        rw [factorization_prep_sq_sub_sq, one_mul]                 -- `a^2 - b^2 = 1_ℂ`

/-- **人手 `factorization_of_A_theta_general` の補助的な等式の 2 本目**:
`a^2 + b^2 e_- e_- = e_-((c_1)_ℂ(cos θ)_ℂ + i(sin θ)_ℂ)`。人手の 7 行と calc の 7 段が 1 対 1 である。 -/
theorem factorization_aux_minus (K1 θ : ℝ) :
    (Real.cosh K1 : ℂ) ^ 2
        + (Real.sinh K1 : ℂ) ^ 2 * Complex.exp ((-Complex.I) * (θ : ℂ)) * Complex.exp ((-Complex.I) * (θ : ℂ))
      = Complex.exp ((-Complex.I) * (θ : ℂ))
          * (((Real.cosh (2 * K1) : ℝ) : ℂ) * ((Real.cos θ : ℝ) : ℂ) + Complex.I * ((Real.sin θ : ℝ) : ℂ)) :=
  calc (Real.cosh K1 : ℂ) ^ 2
        + (Real.sinh K1 : ℂ) ^ 2 * Complex.exp ((-Complex.I) * (θ : ℂ)) * Complex.exp ((-Complex.I) * (θ : ℂ))
      = (Real.cosh K1 : ℂ) ^ 2
          * (Complex.exp (Complex.I * (θ : ℂ)) * Complex.exp ((-Complex.I) * (θ : ℂ)))
        + (Real.sinh K1 : ℂ) ^ 2 * Complex.exp ((-Complex.I) * (θ : ℂ))
            * Complex.exp ((-Complex.I) * (θ : ℂ)) := by
        rw [factorization_prep_exp_mul_exp_neg, mul_one]           -- `e_+ e_- = 1_ℂ`
    _ = Complex.exp ((-Complex.I) * (θ : ℂ))
          * ((Real.cosh K1 : ℂ) ^ 2 * Complex.exp (Complex.I * (θ : ℂ))
            + (Real.sinh K1 : ℂ) ^ 2 * Complex.exp ((-Complex.I) * (θ : ℂ))) := by
        ring                                                       -- ℂ の分配則と積の交換律・結合律
    _ = Complex.exp ((-Complex.I) * (θ : ℂ))
          * ((Real.cosh K1 : ℂ) ^ 2 * (((Real.cos θ : ℝ) : ℂ) + Complex.I * ((Real.sin θ : ℝ) : ℂ))
            + (Real.sinh K1 : ℂ) ^ 2 * Complex.exp ((-Complex.I) * (θ : ℂ))) := by
        rw [factorization_prep_exp_eq_cos_add_sin]                 -- `e_+` の上の表示
    _ = Complex.exp ((-Complex.I) * (θ : ℂ))
          * ((Real.cosh K1 : ℂ) ^ 2 * (((Real.cos θ : ℝ) : ℂ) + Complex.I * ((Real.sin θ : ℝ) : ℂ))
            + (Real.sinh K1 : ℂ) ^ 2 * (((Real.cos θ : ℝ) : ℂ) - Complex.I * ((Real.sin θ : ℝ) : ℂ))) := by
        nth_rw 2 [factorization_prep_exp_neg_eq_cos_sub_sin]       -- `e_-` の上の表示（括弧の中の 1 箇所）
    _ = Complex.exp ((-Complex.I) * (θ : ℂ))
          * (((Real.cosh K1 : ℂ) ^ 2 + (Real.sinh K1 : ℂ) ^ 2) * ((Real.cos θ : ℝ) : ℂ)
            + Complex.I * (((Real.cosh K1 : ℂ) ^ 2 - (Real.sinh K1 : ℂ) ^ 2) * ((Real.sin θ : ℝ) : ℂ))) := by
        ring                                                       -- ℂ の分配則
    _ = Complex.exp ((-Complex.I) * (θ : ℂ))
          * (((Real.cosh (2 * K1) : ℝ) : ℂ) * ((Real.cos θ : ℝ) : ℂ)
            + Complex.I * (((Real.cosh K1 : ℂ) ^ 2 - (Real.sinh K1 : ℂ) ^ 2) * ((Real.sin θ : ℝ) : ℂ))) := by
        rw [factorization_prep_sq_add_sq]                          -- `a^2 + b^2 = (c_1)_ℂ`
    _ = Complex.exp ((-Complex.I) * (θ : ℂ))
          * (((Real.cosh (2 * K1) : ℝ) : ℂ) * ((Real.cos θ : ℝ) : ℂ) + Complex.I * ((Real.sin θ : ℝ) : ℂ)) := by
        rw [factorization_prep_sq_sub_sq, one_mul]                 -- `a^2 - b^2 = 1_ℂ`

/-- **人手 `factorization_of_A_theta_general` の準備の `C = S(c_2)_ℂ`**
（`C := (cosh 2K_2^*)_ℂ`、`S := (sinh 2K_2^*)_ℂ`、`K_2 ∈ ℝ_{>0}`、`K_2^* := Kstar K_2`）。
人手の 3 行のうち 2・3 行目と calc の 2 段が 1 対 1 である（1 行目の `C = (c_2^*)_ℂ` は
`def_indexed_hyperbolic_abbreviations` の定義そのものなので、`c_2^*` を `cosh 2K_2^*` のまま置く）。 -/
theorem factorization_prep_C_eq_S_mul_c2 {K2 : ℝ} (hK2 : 0 < K2) :
    ((Real.cosh (2 * Kstar K2) : ℝ) : ℂ) = ((Real.sinh (2 * Kstar K2) : ℝ) : ℂ) * ((Real.cosh (2 * K2) : ℝ) : ℂ) :=
  calc ((Real.cosh (2 * Kstar K2) : ℝ) : ℂ)
      = ((Real.sinh (2 * Kstar K2) * Real.cosh (2 * K2) : ℝ) : ℂ) := by
        rw [duality_c2_star_eq_s2_star_c2 hK2]                     -- `duality_c2_star_eq_s2_star_c2`
    _ = ((Real.sinh (2 * Kstar K2) : ℝ) : ℂ) * ((Real.cosh (2 * K2) : ℝ) : ℂ) :=
        (real_inclusion_mul _ _).symm                              -- `real_inclusion_preserves_product`、`S` の定義

/-- **原文 `factorization_of_A_theta_general`**: `θ ∈ ℝ` について
`B_1(θ) B_2 B_1(θ) = A(θ)`。

仮定は `IsingConst` の 5 成分が `K_1, K_2^*` の双曲線関数であることと、
双対関係の帰結 `hdual : s_2^* c_2 = c_2^*`（原文の
`duality_c2_star_eq_s2_star_c2`）だけである。 -/
theorem factorization_of_A_theta_general (K : IsingConst) (K1 K2star : ℂ) (θ : ℝ)
    (hc1 : (K.c1 : ℂ) = Complex.cosh (2 * K1))
    (hs1 : (K.s1 : ℂ) = Complex.sinh (2 * K1))
    (hc2star : (K.c2star : ℂ) = Complex.cosh (2 * K2star))
    (hs2star : (K.s2star : ℂ) = Complex.sinh (2 * K2star))
    (hdual : (K.s2star : ℂ) * (K.c2 : ℂ) = (K.c2star : ℂ)) :
    B1mat K1 (θ : ℂ) * B2mat K2star * B1mat K1 (θ : ℂ) = AMat K θ :=
  B1_mul_B2_mul_B1_eq_AMat K K1 K2star θ hc1 hs1 hc2star hs2star hdual

/-- **原文の「とくに」の部分**: `θ = θ~_μ` としたもの。 -/
theorem factorization_of_A_thetaTilde (K : IsingConst) (K1 K2star : ℂ) (μ : ℤ)
    (hc1 : (K.c1 : ℂ) = Complex.cosh (2 * K1))
    (hs1 : (K.s1 : ℂ) = Complex.sinh (2 * K1))
    (hc2star : (K.c2star : ℂ) = Complex.cosh (2 * K2star))
    (hs2star : (K.s2star : ℂ) = Complex.sinh (2 * K2star))
    (hdual : (K.s2star : ℂ) * (K.c2 : ℂ) = (K.c2star : ℂ)) :
    B1mat K1 ((thetaTilde M μ : ℝ) : ℂ) * B2mat K2star * B1mat K1 ((thetaTilde M μ : ℝ) : ℂ)
      = AMat K (thetaTilde M μ) :=
  factorization_of_A_theta_general K K1 K2star (thetaTilde M μ) hc1 hs1 hc2star hs2star hdual

end Ising2D
