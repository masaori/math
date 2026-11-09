/-
# 具体版: `A(θ) = B_1(θ) B_2 B_1(θ)`（`θ ∈ ℝ` 一般）

対応する人手証明のラベル: **`factorization_of_A_theta_general`**
（`structured-latex/content/eigenvalue_problem_reduction_to_A_theta.ts` の
`evensectorT_009_claim_factorization_A_theta`）

## Lean 側の既存の証明との関係

008 章の `factorization_of_A_theta` は `μ ∈ 𝓜` で量化されており、原文はそのままでは
`θ~_μ` に使えないので、本章で `θ ∈ ℝ` 一般の主張として立て直している。

本ファイルの `factorization_of_A_theta_general` は、人手の準備・Step 1〜5 の calc を Step 6 で組み立てて示す。
Lean 側の既存定理 `Ising2D.B1_mul_B2_mul_B1_eq_AMat`
（`Ising2D/MathematicalTools/InvertibleMatricesLinearMapCorrespondenceAndConjugation/DefinitionTgAndTV.lean`。
`simp`・`field_simp`・`ring` で成分を一度に計算する）は使わない。

## 原文が明示していない前提（008 章と同じ）

`B_1(θ) B_2 B_1(θ)` を素朴に展開すると非対角成分に現れるのは `c_2^*` だが、
`def_A_theta` の `A(θ)` には `c_2` が現れる。一致には双対関係の帰結
`c_2^* = s_2^* c_2` が要る。**本章の原文 `factorization_of_A_theta_general` の proof は
準備の `C = S(c_2)_ℂ` でこの等式を `duality_c2_star_eq_s2_star_c2` として明示的に引用しており（Step 4・5 がそれを使う）、
008 章で欠けていた前提がここでは補われている。**
Lean 側の `factorization_of_A_theta_general` は `K_2^*` を任意の実数とし、双対関係を仮定 `hdual` として持つ
（利用箇所 `TVPlus_checkZ_checkY` などが `K_2^*` を任意の実数として受けるため）。
人手の記号 `K_2^* := Kstar K_2` のまま述べた形 `factorization_of_A_theta_general_of_coupling` では、
`hdual` を `duality_c2_star_eq_s2_star_c2` で埋める。

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
| `C` の 3 行 | `factorization_prep_C_eq_S_mul_c2`（1 行目 `C = (c_2^*)_ℂ` は定義の展開なので、`c_2^*` を `cosh 2K_2^*` のまま置く）。2 行目の `duality_c2_star_eq_s2_star_c2` を仮定 `hdual` に替えた形が `factorization_prep_C_eq_S_mul_c2_of_dual` で、主張の組み立てはこちらを使う（人手 2 行目の双対関係の引用は、`factorization_of_A_theta_general_of_coupling` が `hdual` を `duality_c2_star_eq_s2_star_c2` で埋めるところで起きる） |

`scalar_exp_product`・`scalar_exp_zero`（`K = ℂ`）は、`def_scalar_exp` の具体版が Lean に無いので mathlib の
`Complex.exp_add`・`Complex.exp_zero` で表す（`ClaimAnticommutatorCheckZY.lean` と同じ扱い）。
`euler_formula_cos_sin` の第 1・2 式は具体版が Lean に無いので、`θ ∈ ℝ` の `cos θ`・`sin θ` を包含の像として読んだ形
`euler_cos_as_exp`・`euler_sin_as_exp` を mathlib の `Complex.ofReal_cos`・`Complex.ofReal_sin` と `Complex.cos`・`Complex.sin` の定義で置いて受ける。
「`(2)_ℂ ≠ 0_ℂ`・`(2)_ℂ i ≠ 0_ℂ` と ℂ の四則」「ℂ の分配則と積の交換律・結合律」の行は `field_simp`・`ring` で閉じる。

## 人手の記号による `B_1(θ)`・`B_2` の表示と Step 1

人手の証明は「この記号で `def_B1_theta_B2` は `B_1(θ) = !![a, ((-i)e_+)b; (ie_-)b, a]`、`B_2 = !![C, iS; (-i)S, C]` である」と書き、
Step 1〜6 をこの形の行列の上で計算する。Lean ではこの形の行列を `factorizationB1Symbols`・`factorizationB2Symbols` と置き、
Step 1 の `N := B_2B_1(θ)` の 4 成分を、記号 `a, b, C, S, e_±` を ℂ の元として、人手の 2 行ずつと 1 段ずつの calc で置く。

| 人手 | Lean |
| --- | --- |
| 「この記号で `B_1(θ) = …`」 | `factorization_B1mat_eq_symbols` |
| 「この記号で `B_2 = …`」 | `factorization_B2mat_eq_symbols` |
| Step 1 の `N_{11}`・`N_{12}`・`N_{21}`・`N_{22}`（2 行ずつ） | `factorization_step1_N11`・`factorization_step1_N12`・`factorization_step1_N21`・`factorization_step1_N22` |
| Step 2 の `P_{11}`・Step 3 の `P_{22}`（12 行ずつ） | `factorization_step2_P11`・`factorization_step3_P22`（記号を ℂ の元とし、準備の `e_+e_- = 1_ℂ`・`a^2 + b^2 = (c_1)_ℂ`・`e_+ + e_- = (2)_ℂ(cos θ)_ℂ`・`2ab = (s_1)_ℂ` を仮定に取る）、`factorization_step2_P11_real`・`factorization_step3_P22_real`（仮定を準備の 4 本で埋めた実数の `K_1, K_2^*, θ` の形） |
| Step 4 の `P_{12}`・Step 5 の `P_{21}`（9 行ずつ） | `factorization_step4_P12`・`factorization_step5_P21`（記号を ℂ の元とし、準備の補助的な等式の 1 本目・2 本目、`2ab = (s_1)_ℂ`、`C = S(c_2)_ℂ` の 3 本を仮定に取る）、`factorization_step4_P12_real`・`factorization_step5_P21_real`（仮定を準備で埋めた実数の `K_1, K_2^*, θ, c_2` の形。双対関係は仮定 `hdual`） |
| Step 6 | `factorization_of_A_theta_general`（`mat_mult_associative`、上の 2 本の橋、Step 2〜5 の `_real` 版、成分の読み `factorization_A_diag_as_inclusion`、`def_A_theta` を使う 5 段の calc） |

`B1mat` は `K1 : ℂ` と `Complex.cosh K1` で定義され、指数を `θ * i`・`-θ * i` の順で書くので、人手の `def_B1_theta_B2`
（`K_1 ∈ ℝ` の `(cosh K_1)_ℂ`、指数 `i(θ)_ℂ`・`-i(θ)_ℂ`）と式の形が違う。実数の `K_1, K_2^*, θ` の像を入れた `B1mat`・`B2mat` については
`factorization_B1mat_eq_symbols`・`factorization_B2mat_eq_symbols` がその橋で、
`Complex.cosh (x)_ℂ = (cosh x)_ℂ` は mathlib の `Complex.ofReal_cosh`・`Complex.ofReal_sinh` で受ける。
`mat_mult` は Lean の `Matrix.mul_apply` と `Fin.sum_univ_two`、「`i i = -1_ℂ`」は mathlib の `Complex.I_mul_I`（`factorization_I_mul_I`）で受ける。

Step 2・3 の ℂ の元とした版は `C, S` のまま述べる。人手の 11 行目「`C, S` の定義を 2 箇所へ」の置き換えは、`_real` 版で `C, S` に `(cosh 2K_2^*)_ℂ, (sinh 2K_2^*)_ℂ` を入れるところで起き、`c_2^*` を `cosh 2K_2^*` のまま置くので式を変えない。このため calc の段を置かない。
Step 4・5 の ℂ の元とした版も `S` のまま述べ、人手の 9 行目「`S` の定義」の段を同じ理由で置かない（`_real` 版で `S` に `(sinh 2K_2^*)_ℂ` を入れる）。
利用箇所（`TVPlus_checkZ_checkY` など）は仮定を ℂ の等式の形 `(c_1)_ℂ = cosh(2(K_1)_ℂ)` で持つので、
`factorization_real_cosh_of_complex`・`factorization_real_sinh_of_complex` で実数の等式へ移した形
`factorization_of_A_theta_general_of_complex_hyps` を置き、「とくに」の `factorization_of_A_thetaTilde` はそれを当てる。

具体的な数の計算で、主張に固有の構造は実数の像の演算・双曲線関数の公式・複素数の指数法則と Euler の表示だけなので、必要十分版は置かない。
-/
import Ising2D.EigenvalueProblem.ReductionToATheta.ClaimAntiperiodicExpSum
import Ising2D.EigenvalueProblem.ReductionToATheta.ClaimDualityC2StarEqS2StarC2
import Ising2D.EigenvalueProblem.ReductionToATheta.ClaimExponentialSeriesOfEvenOddPowerTerms
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

/-! ## 人手の記号による `B_1(θ)`・`B_2` の表示 -/

/-- 人手の証明の冒頭の記号 `a, b, e_±` で書いた `B_1(θ)`（`!![a, ((-i)e_+)b; (ie_-)b, a]`）。
人手の証明が「この記号で `def_B1_theta_B2` は」と書く形の行列で、Step 1〜6 はこの形の上で計算する。 -/
noncomputable def factorizationB1Symbols (a b ep em : ℂ) : Matrix (Fin 2) (Fin 2) ℂ :=
  !![a, ((-Complex.I) * ep) * b; (Complex.I * em) * b, a]

/-- 人手の証明の冒頭の記号 `C, S` で書いた `B_2`（`!![C, iS; (-i)S, C]`）。 -/
noncomputable def factorizationB2Symbols (C S : ℂ) : Matrix (Fin 2) (Fin 2) ℂ :=
  !![C, Complex.I * S; (-Complex.I) * S, C]

/-- **人手の「この記号で `def_B1_theta_B2` は `B_1(θ) = !![a, ((-i)e_+)b; (ie_-)b, a]` である」**
（`a := (cosh K_1)_ℂ`、`b := (sinh K_1)_ℂ`、`e_+ := exp(i(θ)_ℂ)`、`e_- := exp((-i)(θ)_ℂ)`、`K_1, θ ∈ ℝ`）。

Lean の `B1mat` は `K1 : ℂ` と `Complex.cosh K1` で定義され、指数を `θ * i`・`-θ * i` の順で書くので、
人手の `def_B1_theta_B2`（`K_1 ∈ ℝ` の `(cosh K_1)_ℂ`、指数 `i(θ)_ℂ`・`-i(θ)_ℂ`）と式の形が違う。
この補題がその橋である: `Complex.cosh (K_1)_ℂ = (cosh K_1)_ℂ`（mathlib `Complex.ofReal_cosh`。`sinh` も同じ）と、
ℂ の積の交換律で指数を `i(θ)_ℂ` の順にし、人手の括弧書きの `-i(θ)_ℂ = (-i)(θ)_ℂ`（`multiply_by_minus_one`）を当てる。 -/
theorem factorization_B1mat_eq_symbols (K1 θ : ℝ) :
    B1mat (K1 : ℂ) (θ : ℂ)
      = factorizationB1Symbols ((Real.cosh K1 : ℝ) : ℂ) ((Real.sinh K1 : ℝ) : ℂ)
          (Complex.exp (Complex.I * (θ : ℂ))) (Complex.exp ((-Complex.I) * (θ : ℂ))) := by
  have hplus : (θ : ℂ) * Complex.I = Complex.I * (θ : ℂ) := mul_comm _ _      -- ℂ の積の交換律
  have hminus : -(θ : ℂ) * Complex.I = (-Complex.I) * (θ : ℂ) :=
    calc -(θ : ℂ) * Complex.I
        = -((θ : ℂ) * Complex.I) := neg_mul _ _                             -- Lean の `B1mat` の書き方の読み
      _ = -(Complex.I * (θ : ℂ)) := by rw [mul_comm]                         -- ℂ の積の交換律（人手の `-i(θ)_ℂ`）
      _ = (-Complex.I) * (θ : ℂ) := (neg_mul _ _).symm                      -- `multiply_by_minus_one` の `-i(θ)_ℂ = (-i)(θ)_ℂ`
  rw [B1mat, factorizationB1Symbols, Complex.ofReal_cosh, Complex.ofReal_sinh, hplus, hminus]

/-- **人手の「この記号で `def_B1_theta_B2` は `B_2 = !![C, iS; (-i)S, C]` である」**
（`C := (cosh 2K_2^*)_ℂ`、`S := (sinh 2K_2^*)_ℂ`、`K_2^* ∈ ℝ`）。

Lean の `B2mat` は `K2star : ℂ` と `Complex.cosh (2 * K2star)` で定義されるので、`2(K_2^*)_ℂ = (2K_2^*)_ℂ`
（`2 = (2)_ℂ` と `real_inclusion_preserves_product`。人手の `def_B1_theta_B2` は「実数の積 `2K_2^* ∈ ℝ`」の像を取る）と
`Complex.cosh (x)_ℂ = (cosh x)_ℂ`（mathlib `Complex.ofReal_cosh`。`sinh` も同じ）で人手の形へ移す。 -/
theorem factorization_B2mat_eq_symbols (K2star : ℝ) :
    B2mat (K2star : ℂ)
      = factorizationB2Symbols ((Real.cosh (2 * K2star) : ℝ) : ℂ) ((Real.sinh (2 * K2star) : ℝ) : ℂ) := by
  have h2 : (2 : ℂ) * (K2star : ℂ) = ((2 * K2star : ℝ) : ℂ) := by
    rw [← Complex.ofReal_ofNat 2, real_inclusion_mul]                        -- `2 = (2)_ℂ`、`real_inclusion_preserves_product`
  rw [B2mat, factorizationB2Symbols, h2, Complex.ofReal_cosh, Complex.ofReal_sinh]

/-! ## Step 1: `N := B_2 B_1(θ)` の成分 -/

/-- 人手 Step 1 の `N_{11}` の根拠「`i i = -1_ℂ`」（mathlib `Complex.I_mul_I`）。 -/
theorem factorization_I_mul_I : Complex.I * Complex.I = -1 := Complex.I_mul_I

/-- 人手 Step 1 の `N_{22}` の根拠「`(-i)(-i) = -1_ℂ`」。 -/
theorem factorization_neg_I_mul_neg_I : (-Complex.I) * (-Complex.I) = -1 := by
  rw [neg_mul_neg, Complex.I_mul_I]

/-- **人手 Step 1 の `N_{11}`**: `N_{11} = Ca - Sbe_-`。人手の 2 行と calc の 2 段が 1 対 1 である。 -/
theorem factorization_step1_N11 (a b C S ep em : ℂ) :
    (factorizationB2Symbols C S * factorizationB1Symbols a b ep em) 0 0 = C * a - S * b * em :=
  calc (factorizationB2Symbols C S * factorizationB1Symbols a b ep em) 0 0
      = C * a + (Complex.I * S) * ((Complex.I * em) * b) := by
        rw [Matrix.mul_apply, Fin.sum_univ_two]; rfl                  -- `mat_mult`
    _ = C * a - S * b * em := by
        linear_combination (S * em * b) * factorization_I_mul_I        -- `i i = -1_ℂ` と ℂ の積の交換律・結合律
                                                                     -- （人手が書かない分配則と差の定義も使う）

/-- **人手 Step 1 の `N_{12}`**: `N_{12} = i(Sa - Cbe_+)`。人手の 2 行と calc の 2 段が 1 対 1 である。 -/
theorem factorization_step1_N12 (a b C S ep em : ℂ) :
    (factorizationB2Symbols C S * factorizationB1Symbols a b ep em) 0 1
      = Complex.I * (S * a - C * b * ep) :=
  calc (factorizationB2Symbols C S * factorizationB1Symbols a b ep em) 0 1
      = C * (((-Complex.I) * ep) * b) + (Complex.I * S) * a := by
        rw [Matrix.mul_apply, Fin.sum_univ_two]; rfl                  -- `mat_mult`
    _ = Complex.I * (S * a - C * b * ep) := by
        ring                                                         -- ℂ の分配則と積の交換律・結合律
                                                                     -- （人手が書かない `(-i)x = -(ix)` と差の定義も使う）

/-- **人手 Step 1 の `N_{21}`**: `N_{21} = i(Cbe_- - Sa)`。人手の 2 行と calc の 2 段が 1 対 1 である。 -/
theorem factorization_step1_N21 (a b C S ep em : ℂ) :
    (factorizationB2Symbols C S * factorizationB1Symbols a b ep em) 1 0
      = Complex.I * (C * b * em - S * a) :=
  calc (factorizationB2Symbols C S * factorizationB1Symbols a b ep em) 1 0
      = ((-Complex.I) * S) * a + C * ((Complex.I * em) * b) := by
        rw [Matrix.mul_apply, Fin.sum_univ_two]; rfl                  -- `mat_mult`
    _ = Complex.I * (C * b * em - S * a) := by
        ring                                                         -- ℂ の分配則と積の交換律・結合律
                                                                     -- （人手が書かない `(-i)x = -(ix)` と差の定義も使う）

/-- **人手 Step 1 の `N_{22}`**: `N_{22} = Ca - Sbe_+`。人手の 2 行と calc の 2 段が 1 対 1 である。 -/
theorem factorization_step1_N22 (a b C S ep em : ℂ) :
    (factorizationB2Symbols C S * factorizationB1Symbols a b ep em) 1 1 = C * a - S * b * ep :=
  calc (factorizationB2Symbols C S * factorizationB1Symbols a b ep em) 1 1
      = ((-Complex.I) * S) * (((-Complex.I) * ep) * b) + C * a := by
        rw [Matrix.mul_apply, Fin.sum_univ_two]; rfl                  -- `mat_mult`
    _ = C * a - S * b * ep := by
        linear_combination (S * ep * b) * factorization_neg_I_mul_neg_I -- `(-i)(-i) = -1_ℂ` と ℂ の積の交換律・結合律
                                                                     -- （人手が書かない分配則と差の定義も使う）

/-! ## Step 2・3: `P := B_1(θ) N` の対角成分 -/

/-- 人手 Step 2 の 3 行目の根拠「`(-i) i = 1_ℂ`」。 -/
theorem factorization_neg_I_mul_I : (-Complex.I) * Complex.I = 1 := by
  rw [neg_mul, Complex.I_mul_I, neg_neg]

/-- **人手 Step 2 の `P_{11}`**（人手の結論 `P_{11} = (c_1)_ℂ(c_2^*)_ℂ - (s_1)_ℂ(s_2^*)_ℂ(cos θ)_ℂ`）。
この版の右辺は `c1 C - s1 S cθ` である。

記号 `a, b, C, S, e_±` を ℂ の元とし、人手が準備で示した 4 本（`e_+e_- = 1_ℂ`、`a^2 + b^2 = (c_1)_ℂ`、
`e_+ + e_- = (2)_ℂ(cos θ)_ℂ`、`2ab = (s_1)_ℂ`）を仮定に取る（`(c_1)_ℂ, (s_1)_ℂ, (cos θ)_ℂ` を `c1, s1, cθ` と置く）。
実数の `K_1, K_2^*, θ` での形は `factorization_step2_P11_real`。
人手の 12 行のうち、11 行目「`C, S` の定義を 2 箇所へ」を除く 11 行と calc の 11 段が 1 対 1 である
（この版は `C, S` のまま述べる。11 行目の置き換えは `factorization_step2_P11_real` で `C, S` に `(cosh 2K_2^*)_ℂ, (sinh 2K_2^*)_ℂ` を入れるところで起き、`c_2^*` を `cosh 2K_2^*` のまま置くので式を変えない）。 -/
theorem factorization_step2_P11 (a b C S ep em c1 s1 cθ : ℂ)
    (hpm : ep * em = 1) (hsq : a ^ 2 + b ^ 2 = c1)
    (hsum : ep + em = ((2 : ℝ) : ℂ) * cθ) (h2ab : 2 * a * b = s1) :
    (factorizationB1Symbols a b ep em * (factorizationB2Symbols C S * factorizationB1Symbols a b ep em)) 0 0
      = c1 * C - s1 * S * cθ :=
  calc (factorizationB1Symbols a b ep em * (factorizationB2Symbols C S * factorizationB1Symbols a b ep em)) 0 0
      = a * (factorizationB2Symbols C S * factorizationB1Symbols a b ep em) 0 0
        + (((-Complex.I) * ep) * b) * (factorizationB2Symbols C S * factorizationB1Symbols a b ep em) 1 0 := by
        rw [Matrix.mul_apply, Fin.sum_univ_two]; rfl                  -- `mat_mult`
    _ = a * (C * a - S * b * em) + (((-Complex.I) * ep) * b) * (Complex.I * (C * b * em - S * a)) := by
        rw [factorization_step1_N11, factorization_step1_N21]        -- Step 1 の `N_{11}, N_{21}`
    _ = a * (C * a - S * b * em) + ep * b * (C * b * em - S * a) := by
        linear_combination (ep * b * (C * b * em - S * a)) * factorization_neg_I_mul_I
                                                                     -- `(-i) i = 1_ℂ` と ℂ の積の交換律・結合律
    _ = C * a ^ 2 - S * a * b * em + C * b ^ 2 * ep * em - S * a * b * ep := by
        ring                                                         -- ℂ の分配則と積の交換律・結合律
    _ = C * a ^ 2 - S * a * b * em + C * b ^ 2 - S * a * b * ep := by
        rw [mul_assoc (C * b ^ 2), hpm, mul_one]                     -- `e_+ e_- = 1_ℂ`
    _ = C * (a ^ 2 + b ^ 2) - S * a * b * (ep + em) := by
        ring                                                         -- ℂ の分配則
    _ = C * c1 - S * a * b * (ep + em) := by
        rw [hsq]                                                     -- `a^2 + b^2 = (c_1)_ℂ`
    _ = C * c1 - S * a * b * (((2 : ℝ) : ℂ) * cθ) := by
        rw [hsum]                                                    -- `e_+ + e_- = (2)_ℂ(cos θ)_ℂ`
    _ = C * c1 - S * (2 * a * b) * cθ := by
        rw [Complex.ofReal_ofNat]; ring                              -- ℂ の積の交換律・結合律（と `(2)_ℂ = 2`。準備の `2ab` が `2 ∈ ℂ` で述べられているため）
    _ = C * c1 - S * s1 * cθ := by
        rw [h2ab]                                                    -- `2ab = (s_1)_ℂ`
    _ = c1 * C - s1 * S * cθ := by
        ring                                                         -- ℂ の積の交換律

/-- **人手 Step 3 の `P_{22}`**（人手の結論 `P_{22} = (c_1)_ℂ(c_2^*)_ℂ - (s_1)_ℂ(s_2^*)_ℂ(cos θ)_ℂ`）。
この版の右辺は `c1 C - s1 S cθ` である。
記号と仮定 4 本（`e_+e_- = 1_ℂ`、`a^2 + b^2 = (c_1)_ℂ`、`e_+ + e_- = (2)_ℂ(cos θ)_ℂ`、`2ab = (s_1)_ℂ`）は `factorization_step2_P11` と同じ。実数の `K_1, K_2^*, θ` での形は `factorization_step3_P22_real`。
人手の 12 行のうち、11 行目「`C, S` の定義を 2 箇所へ」を除く 11 行と calc の 11 段が 1 対 1 である。 -/
theorem factorization_step3_P22 (a b C S ep em c1 s1 cθ : ℂ)
    (hpm : ep * em = 1) (hsq : a ^ 2 + b ^ 2 = c1)
    (hsum : ep + em = ((2 : ℝ) : ℂ) * cθ) (h2ab : 2 * a * b = s1) :
    (factorizationB1Symbols a b ep em * (factorizationB2Symbols C S * factorizationB1Symbols a b ep em)) 1 1
      = c1 * C - s1 * S * cθ :=
  calc (factorizationB1Symbols a b ep em * (factorizationB2Symbols C S * factorizationB1Symbols a b ep em)) 1 1
      = ((Complex.I * em) * b) * (factorizationB2Symbols C S * factorizationB1Symbols a b ep em) 0 1
        + a * (factorizationB2Symbols C S * factorizationB1Symbols a b ep em) 1 1 := by
        rw [Matrix.mul_apply, Fin.sum_univ_two]; rfl                  -- `mat_mult`
    _ = ((Complex.I * em) * b) * (Complex.I * (S * a - C * b * ep)) + a * (C * a - S * b * ep) := by
        rw [factorization_step1_N12, factorization_step1_N22]        -- Step 1 の `N_{12}, N_{22}`
    _ = (-1 : ℂ) * em * b * (S * a - C * b * ep) + a * (C * a - S * b * ep) := by
        linear_combination (em * b * (S * a - C * b * ep)) * factorization_I_mul_I
                                                                     -- `i i = -1_ℂ` と ℂ の積の交換律・結合律
    _ = -(S * a * b * em) + C * b ^ 2 * ep * em + C * a ^ 2 - S * a * b * ep := by
        ring                                                         -- ℂ の分配則と積の交換律・結合律
    _ = -(S * a * b * em) + C * b ^ 2 + C * a ^ 2 - S * a * b * ep := by
        rw [mul_assoc (C * b ^ 2), hpm, mul_one]                     -- `e_+ e_- = 1_ℂ`
    _ = C * (a ^ 2 + b ^ 2) - S * a * b * (ep + em) := by
        ring                                                         -- ℂ の分配則と和の交換律
    _ = C * c1 - S * a * b * (ep + em) := by
        rw [hsq]                                                     -- `a^2 + b^2 = (c_1)_ℂ`
    _ = C * c1 - S * a * b * (((2 : ℝ) : ℂ) * cθ) := by
        rw [hsum]                                                    -- `e_+ + e_- = (2)_ℂ(cos θ)_ℂ`
    _ = C * c1 - S * (2 * a * b) * cθ := by
        rw [Complex.ofReal_ofNat]; ring                              -- ℂ の積の交換律・結合律（と `(2)_ℂ = 2`。準備の `2ab` が `2 ∈ ℂ` で述べられているため）
    _ = C * c1 - S * s1 * cθ := by
        rw [h2ab]                                                    -- `2ab = (s_1)_ℂ`
    _ = c1 * C - s1 * S * cθ := by
        ring                                                         -- ℂ の積の交換律

/-- 人手 Step 2 を、人手の記号の中身（`a := (cosh K_1)_ℂ`、`b := (sinh K_1)_ℂ`、`C := (cosh 2K_2^*)_ℂ`、
`S := (sinh 2K_2^*)_ℂ`、`e_+ := exp(i(θ)_ℂ)`、`e_- := exp((-i)(θ)_ℂ)`、`K_1, K_2^*, θ ∈ ℝ`）で述べたもの。
`factorization_step2_P11` の 4 つの仮定を準備の 4 本で埋める（`(c_1)_ℂ, (s_1)_ℂ` は準備と同じく
`(cosh 2K_1)_ℂ, (sinh 2K_1)_ℂ` のまま、`(c_2^*)_ℂ, (s_2^*)_ℂ` も `(cosh 2K_2^*)_ℂ, (sinh 2K_2^*)_ℂ` のまま置く）。 -/
theorem factorization_step2_P11_real (K1 K2star θ : ℝ) :
    (factorizationB1Symbols (Real.cosh K1 : ℂ) (Real.sinh K1 : ℂ)
        (Complex.exp (Complex.I * (θ : ℂ))) (Complex.exp ((-Complex.I) * (θ : ℂ)))
      * (factorizationB2Symbols (Real.cosh (2 * K2star) : ℂ) (Real.sinh (2 * K2star) : ℂ)
        * factorizationB1Symbols (Real.cosh K1 : ℂ) (Real.sinh K1 : ℂ)
            (Complex.exp (Complex.I * (θ : ℂ))) (Complex.exp ((-Complex.I) * (θ : ℂ))))) 0 0
      = ((Real.cosh (2 * K1) : ℝ) : ℂ) * ((Real.cosh (2 * K2star) : ℝ) : ℂ)
        - ((Real.sinh (2 * K1) : ℝ) : ℂ) * ((Real.sinh (2 * K2star) : ℝ) : ℂ) * ((Real.cos θ : ℝ) : ℂ) :=
  factorization_step2_P11 _ _ _ _ _ _ _ _ _ (factorization_prep_exp_mul_exp_neg θ)
    (factorization_prep_sq_add_sq K1) (factorization_prep_exp_add_exp_neg θ) (factorization_prep_two_mul_mul K1)

/-- 人手 Step 3 を、`factorization_step2_P11_real` と同じ記号の中身で述べたもの。
`factorization_step3_P22` の仮定 4 本を、同じく準備の 4 本で埋める。 -/
theorem factorization_step3_P22_real (K1 K2star θ : ℝ) :
    (factorizationB1Symbols (Real.cosh K1 : ℂ) (Real.sinh K1 : ℂ)
        (Complex.exp (Complex.I * (θ : ℂ))) (Complex.exp ((-Complex.I) * (θ : ℂ)))
      * (factorizationB2Symbols (Real.cosh (2 * K2star) : ℂ) (Real.sinh (2 * K2star) : ℂ)
        * factorizationB1Symbols (Real.cosh K1 : ℂ) (Real.sinh K1 : ℂ)
            (Complex.exp (Complex.I * (θ : ℂ))) (Complex.exp ((-Complex.I) * (θ : ℂ))))) 1 1
      = ((Real.cosh (2 * K1) : ℝ) : ℂ) * ((Real.cosh (2 * K2star) : ℝ) : ℂ)
        - ((Real.sinh (2 * K1) : ℝ) : ℂ) * ((Real.sinh (2 * K2star) : ℝ) : ℂ) * ((Real.cos θ : ℝ) : ℂ) :=
  factorization_step3_P22 _ _ _ _ _ _ _ _ _ (factorization_prep_exp_mul_exp_neg θ)
    (factorization_prep_sq_add_sq K1) (factorization_prep_exp_add_exp_neg θ) (factorization_prep_two_mul_mul K1)

/-! ## Step 4・5: `P := B_1(θ) N` の非対角成分 -/

/-- **人手 Step 4 の `P_{12}`**（人手の結論 `P_{12} = ie_+(s_2^*)_ℂ((c_1)_ℂ(cos θ)_ℂ - i(sin θ)_ℂ - (s_1)_ℂ(c_2)_ℂ)`）。
この版の右辺は `ie_+S(c1 cθ - i sθ - s1 c2)` である。

記号 `a, b, C, S, e_±` を ℂ の元とし、人手が準備で示した 3 本（補助的な等式の 1 本目
`a^2 + b^2e_+e_+ = e_+((c_1)_ℂ(cos θ)_ℂ - i(sin θ)_ℂ)`、`2ab = (s_1)_ℂ`、`C = S(c_2)_ℂ`）を仮定に取る
（`(c_1)_ℂ, (s_1)_ℂ, (c_2)_ℂ, (cos θ)_ℂ, (sin θ)_ℂ` を `c1, s1, c2, cθ, sθ` と置く）。
実数の `K_1, K_2^*, θ, c_2` での形（双対関係は仮定 `hdual`）は `factorization_step4_P12_real`。
人手の 9 行のうち、9 行目「`S` の定義」を除く 8 行と calc の 8 段が 1 対 1 である
（この版は `S` のまま述べる。9 行目の置き換えは `factorization_step4_P12_real` で `S` に `(sinh 2K_2^*)_ℂ` を入れるところで起き、
`s_2^*` を `sinh 2K_2^*` のまま置くので式を変えない）。
5 段目の右辺は人手の `Se_+(…)` を、補助的な等式の右辺 `e_+(…)` を `S` に掛けた形 `S(e_+(…))` で書き、
7 段目の右辺は人手の `(s_1)_ℂS(c_2)_ℂe_+` を、`C` を `S(c_2)_ℂ` に書き換えた形 `(s_1)_ℂ(S(c_2)_ℂ)e_+` で書く。 -/
theorem factorization_step4_P12 (a b C S ep em c1 s1 c2 cθ sθ : ℂ)
    (haux : a ^ 2 + b ^ 2 * ep * ep = ep * (c1 * cθ - Complex.I * sθ))
    (h2ab : 2 * a * b = s1) (hC : C = S * c2) :
    (factorizationB1Symbols a b ep em * (factorizationB2Symbols C S * factorizationB1Symbols a b ep em)) 0 1
      = Complex.I * ep * S * (c1 * cθ - Complex.I * sθ - s1 * c2) :=
  calc (factorizationB1Symbols a b ep em * (factorizationB2Symbols C S * factorizationB1Symbols a b ep em)) 0 1
      = a * (factorizationB2Symbols C S * factorizationB1Symbols a b ep em) 0 1
        + (((-Complex.I) * ep) * b) * (factorizationB2Symbols C S * factorizationB1Symbols a b ep em) 1 1 := by
        rw [Matrix.mul_apply, Fin.sum_univ_two]; rfl                  -- `mat_mult`
    _ = a * (Complex.I * (S * a - C * b * ep)) + (((-Complex.I) * ep) * b) * (C * a - S * b * ep) := by
        rw [factorization_step1_N12, factorization_step1_N22]        -- Step 1 の `N_{12}, N_{22}`
    _ = Complex.I * (S * a ^ 2 - C * a * b * ep) + Complex.I * (-(C * a * b * ep) + S * b ^ 2 * ep * ep) := by
        ring                                                         -- ℂ の分配則と積の交換律・結合律
    _ = Complex.I * (S * (a ^ 2 + b ^ 2 * ep * ep) - 2 * a * b * C * ep) := by
        ring                                                         -- ℂ の分配則と積の交換律・結合律
    _ = Complex.I * (S * (ep * (c1 * cθ - Complex.I * sθ)) - 2 * a * b * C * ep) := by
        rw [haux]                                                    -- 準備の補助的な等式の 1 本目
    _ = Complex.I * (S * (ep * (c1 * cθ - Complex.I * sθ)) - s1 * C * ep) := by
        rw [h2ab]                                                    -- `2ab = (s_1)_ℂ`
    _ = Complex.I * (S * (ep * (c1 * cθ - Complex.I * sθ)) - s1 * (S * c2) * ep) := by
        rw [hC]                                                      -- `C = S(c_2)_ℂ`
    _ = Complex.I * ep * S * (c1 * cθ - Complex.I * sθ - s1 * c2) := by
        ring                                                         -- ℂ の分配則と積の交換律・結合律

/-- **人手 Step 5 の `P_{21}`**（人手の結論 `P_{21} = (-i)e_-(s_2^*)_ℂ((c_1)_ℂ(cos θ)_ℂ + i(sin θ)_ℂ - (s_1)_ℂ(c_2)_ℂ)`）。
この版の右辺は `(-i)e_-S(c1 cθ + i sθ - s1 c2)` である。
記号は `factorization_step4_P12` と同じで、仮定は補助的な等式の 2 本目
`a^2 + b^2e_-e_- = e_-((c_1)_ℂ(cos θ)_ℂ + i(sin θ)_ℂ)`、`2ab = (s_1)_ℂ`、`C = S(c_2)_ℂ` の 3 本である。
実数の `K_1, K_2^*, θ, c_2` での形（双対関係は仮定 `hdual`）は `factorization_step5_P21_real`。
人手の 9 行のうち、9 行目「`S` の定義」を除く 8 行と calc の 8 段が 1 対 1 である。
5 段目・7 段目の括弧の付け方と 9 行目の扱いは `factorization_step4_P12` と同じである（`e_+` を `e_-` に読み替える）。 -/
theorem factorization_step5_P21 (a b C S ep em c1 s1 c2 cθ sθ : ℂ)
    (haux : a ^ 2 + b ^ 2 * em * em = em * (c1 * cθ + Complex.I * sθ))
    (h2ab : 2 * a * b = s1) (hC : C = S * c2) :
    (factorizationB1Symbols a b ep em * (factorizationB2Symbols C S * factorizationB1Symbols a b ep em)) 1 0
      = (-Complex.I) * em * S * (c1 * cθ + Complex.I * sθ - s1 * c2) :=
  calc (factorizationB1Symbols a b ep em * (factorizationB2Symbols C S * factorizationB1Symbols a b ep em)) 1 0
      = ((Complex.I * em) * b) * (factorizationB2Symbols C S * factorizationB1Symbols a b ep em) 0 0
        + a * (factorizationB2Symbols C S * factorizationB1Symbols a b ep em) 1 0 := by
        rw [Matrix.mul_apply, Fin.sum_univ_two]; rfl                  -- `mat_mult`
    _ = ((Complex.I * em) * b) * (C * a - S * b * em) + a * (Complex.I * (C * b * em - S * a)) := by
        rw [factorization_step1_N11, factorization_step1_N21]        -- Step 1 の `N_{11}, N_{21}`
    _ = Complex.I * (C * a * b * em - S * b ^ 2 * em * em) + Complex.I * (C * a * b * em - S * a ^ 2) := by
        ring                                                         -- ℂ の分配則と積の交換律・結合律
    _ = (-Complex.I) * (S * (a ^ 2 + b ^ 2 * em * em) - 2 * a * b * C * em) := by
        ring                                                         -- ℂ の分配則と積の交換律・結合律
    _ = (-Complex.I) * (S * (em * (c1 * cθ + Complex.I * sθ)) - 2 * a * b * C * em) := by
        rw [haux]                                                    -- 準備の補助的な等式の 2 本目
    _ = (-Complex.I) * (S * (em * (c1 * cθ + Complex.I * sθ)) - s1 * C * em) := by
        rw [h2ab]                                                    -- `2ab = (s_1)_ℂ`
    _ = (-Complex.I) * (S * (em * (c1 * cθ + Complex.I * sθ)) - s1 * (S * c2) * em) := by
        rw [hC]                                                      -- `C = S(c_2)_ℂ`
    _ = (-Complex.I) * em * S * (c1 * cθ + Complex.I * sθ - s1 * c2) := by
        ring                                                         -- ℂ の分配則と積の交換律・結合律

/-- 人手の準備の `C = S(c_2)_ℂ` を、双対関係を仮定 `hdual : s_2^* c_2 = c_2^*`（`s_2^* := sinh 2K_2^*`、
`c_2^* := cosh 2K_2^*`、`K_2^*, c_2 ∈ ℝ`）として受けた形。人手の 3 行のうち 2・3 行目と calc の 2 段が 1 対 1 である
（2 行目の根拠 `duality_c2_star_eq_s2_star_c2` を仮定 `hdual` で置き換えた。`K_2^* = Kstar K_2` の場合が
`factorization_prep_C_eq_S_mul_c2`）。主張 `factorization_of_A_theta_general` の `K_2^*` は任意の実数で、
双対関係を仮定に取るので、Step 4・5 はこの形で受ける。 -/
theorem factorization_prep_C_eq_S_mul_c2_of_dual {K2star c2 : ℝ}
    (hdual : Real.sinh (2 * K2star) * c2 = Real.cosh (2 * K2star)) :
    ((Real.cosh (2 * K2star) : ℝ) : ℂ) = ((Real.sinh (2 * K2star) : ℝ) : ℂ) * ((c2 : ℝ) : ℂ) :=
  calc ((Real.cosh (2 * K2star) : ℝ) : ℂ)
      = ((Real.sinh (2 * K2star) * c2 : ℝ) : ℂ) := by
        rw [hdual]                                                 -- 双対関係（仮定 `hdual`）
    _ = ((Real.sinh (2 * K2star) : ℝ) : ℂ) * ((c2 : ℝ) : ℂ) :=
        (real_inclusion_mul _ _).symm                              -- `real_inclusion_preserves_product`、`S` の定義

/-- 人手 Step 4 を、人手の記号の中身（`a := (cosh K_1)_ℂ`、`b := (sinh K_1)_ℂ`、`C := (cosh 2K_2^*)_ℂ`、
`S := (sinh 2K_2^*)_ℂ`、`e_+ := exp(i(θ)_ℂ)`、`e_- := exp((-i)(θ)_ℂ)`、`K_1, K_2^*, θ, c_2 ∈ ℝ`）で述べたもの。
`factorization_step4_P12` の 3 つの仮定を準備の `factorization_aux_plus`・`factorization_prep_two_mul_mul`・
`factorization_prep_C_eq_S_mul_c2_of_dual` で埋める（`(c_1)_ℂ, (s_1)_ℂ, (s_2^*)_ℂ` は準備と同じく
`(cosh 2K_1)_ℂ, (sinh 2K_1)_ℂ, (sinh 2K_2^*)_ℂ` のまま置く）。双対関係は仮定 `hdual : s_2^* c_2 = c_2^*` で受ける
（`K_2^* = Kstar K_2`、`c_2 = cosh 2K_2`、`K_2 ∈ ℝ_{>0}` なら `duality_c2_star_eq_s2_star_c2` がこれを与える）。 -/
theorem factorization_step4_P12_real (K1 θ K2star c2 : ℝ)
    (hdual : Real.sinh (2 * K2star) * c2 = Real.cosh (2 * K2star)) :
    (factorizationB1Symbols (Real.cosh K1 : ℂ) (Real.sinh K1 : ℂ)
        (Complex.exp (Complex.I * (θ : ℂ))) (Complex.exp ((-Complex.I) * (θ : ℂ)))
      * (factorizationB2Symbols (Real.cosh (2 * K2star) : ℂ) (Real.sinh (2 * K2star) : ℂ)
        * factorizationB1Symbols (Real.cosh K1 : ℂ) (Real.sinh K1 : ℂ)
            (Complex.exp (Complex.I * (θ : ℂ))) (Complex.exp ((-Complex.I) * (θ : ℂ))))) 0 1
      = Complex.I * Complex.exp (Complex.I * (θ : ℂ)) * ((Real.sinh (2 * K2star) : ℝ) : ℂ)
        * (((Real.cosh (2 * K1) : ℝ) : ℂ) * ((Real.cos θ : ℝ) : ℂ) - Complex.I * ((Real.sin θ : ℝ) : ℂ)
          - ((Real.sinh (2 * K1) : ℝ) : ℂ) * ((c2 : ℝ) : ℂ)) :=
  factorization_step4_P12 _ _ _ _ _ _ _ _ _ _ _ (factorization_aux_plus K1 θ)
    (factorization_prep_two_mul_mul K1) (factorization_prep_C_eq_S_mul_c2_of_dual hdual)

/-- 人手 Step 5 を、`factorization_step4_P12_real` と同じ記号の中身で述べたもの。
`factorization_step5_P21` の仮定 3 本を、準備の `factorization_aux_minus`・`factorization_prep_two_mul_mul`・
`factorization_prep_C_eq_S_mul_c2_of_dual` で埋める。 -/
theorem factorization_step5_P21_real (K1 θ K2star c2 : ℝ)
    (hdual : Real.sinh (2 * K2star) * c2 = Real.cosh (2 * K2star)) :
    (factorizationB1Symbols (Real.cosh K1 : ℂ) (Real.sinh K1 : ℂ)
        (Complex.exp (Complex.I * (θ : ℂ))) (Complex.exp ((-Complex.I) * (θ : ℂ)))
      * (factorizationB2Symbols (Real.cosh (2 * K2star) : ℂ) (Real.sinh (2 * K2star) : ℂ)
        * factorizationB1Symbols (Real.cosh K1 : ℂ) (Real.sinh K1 : ℂ)
            (Complex.exp (Complex.I * (θ : ℂ))) (Complex.exp ((-Complex.I) * (θ : ℂ))))) 1 0
      = (-Complex.I) * Complex.exp ((-Complex.I) * (θ : ℂ)) * ((Real.sinh (2 * K2star) : ℝ) : ℂ)
        * (((Real.cosh (2 * K1) : ℝ) : ℂ) * ((Real.cos θ : ℝ) : ℂ) + Complex.I * ((Real.sin θ : ℝ) : ℂ)
          - ((Real.sinh (2 * K1) : ℝ) : ℂ) * ((c2 : ℝ) : ℂ)) :=
  factorization_step5_P21 _ _ _ _ _ _ _ _ _ _ _ (factorization_aux_minus K1 θ)
    (factorization_prep_two_mul_mul K1) (factorization_prep_C_eq_S_mul_c2_of_dual hdual)

/-! ## Step 6: 主張の組み立て -/

/-- 人手 Step 2〜5 の結論が `def_A_theta` の `A(θ)` の成分である、という読みのうち、(1,1)・(2,2) 成分の
`(c_1)_ℂ(c_2^*)_ℂ - (s_1)_ℂ(s_2^*)_ℂ(cos θ)_ℂ = (c_1c_2^* - s_1s_2^* cos θ)_ℂ`。人手の前置き
「`A(θ)` の成分に現れる実数は `inclusion_rr_to_cc` による像として ℂ の演算にかける」を、積の像 3 箇所と差の像 1 箇所で書く。 -/
theorem factorization_A_diag_as_inclusion (c1 c2star s1 s2star cθ : ℝ) :
    (c1 : ℂ) * (c2star : ℂ) - (s1 : ℂ) * (s2star : ℂ) * (cθ : ℂ)
      = ((c1 * c2star - s1 * s2star * cθ : ℝ) : ℂ) :=
  calc (c1 : ℂ) * (c2star : ℂ) - (s1 : ℂ) * (s2star : ℂ) * (cθ : ℂ)
      = ((c1 * c2star : ℝ) : ℂ) - ((s1 * s2star * cθ : ℝ) : ℂ) := by
        rw [real_inclusion_mul c1, real_inclusion_mul s1, real_inclusion_mul (s1 * s2star)]
                                                                   -- `real_inclusion_preserves_product` を 3 箇所へ
    _ = ((c1 * c2star - s1 * s2star * cθ : ℝ) : ℂ) :=
        real_inclusion_sub _ _                                     -- `real_inclusion_sub`（指数級数の偶奇の項の主張の準備「実数の差の像」）

/-- **原文 `factorization_of_A_theta_general`**: `θ ∈ ℝ` について `B_1(θ) B_2 B_1(θ) = A(θ)`。

`K_1, K_2^*, θ ∈ ℝ` とし、`IsingConst` の 5 成分が `def_indexed_hyperbolic_abbreviations` の
`c_1 = cosh 2K_1`、`s_1 = sinh 2K_1`、`c_2^* = cosh 2K_2^*`、`s_2^* = sinh 2K_2^*` であること（`hc1`・`hs1`・`hc2star`・`hs2star`）と、
双対関係 `hdual : s_2^* c_2 = c_2^*` を仮定に取る（人手の準備の `C = S(c_2)_ℂ` が `duality_c2_star_eq_s2_star_c2` を引く箇所。
`K_2^* = Kstar K_2`・`K_2 ∈ ℝ_{>0}` の場合は `factorization_of_A_theta_general_of_coupling` がこの仮定を埋める）。

人手の Step 6 と calc の対応:

| 人手 | calc |
| --- | --- |
| 「主張の左辺は `mat_mult_associative` により `B_1(θ)(B_2B_1(θ))` に等しい」 | 1 段目（mathlib `Matrix.mul_assoc`） |
| 証明冒頭の「この記号で `B_1(θ) = …`、`B_2 = …`」 | 2 段目（`factorization_B1mat_eq_symbols`・`factorization_B2mat_eq_symbols`） |
| 「`= P`、Step 2〜5 で `P` の 4 成分が…」 | 3 段目（`2×2` 行列を 4 成分で書き、Step 2〜5 の `_real` 版を当てる） |
| Step 2〜5 の末尾「これは `A(θ)` の (i,j) 成分である」 | 4 段目（(1,1)・(2,2) は `factorization_A_diag_as_inclusion`、(2,1) は指数 `(-i)(θ)_ℂ = -(i(θ)_ℂ)`）と 5 段目（`def_A_theta` の定義と仮定 `hc1`〜`hs2star`） | -/
theorem factorization_of_A_theta_general (K : IsingConst) (K1 K2star θ : ℝ)
    (hc1 : K.c1 = Real.cosh (2 * K1)) (hs1 : K.s1 = Real.sinh (2 * K1))
    (hc2star : K.c2star = Real.cosh (2 * K2star)) (hs2star : K.s2star = Real.sinh (2 * K2star))
    (hdual : K.s2star * K.c2 = K.c2star) :
    B1mat (K1 : ℂ) (θ : ℂ) * B2mat (K2star : ℂ) * B1mat (K1 : ℂ) (θ : ℂ) = AMat K θ := by
  have hdual' : Real.sinh (2 * K2star) * K.c2 = Real.cosh (2 * K2star) := by
    rw [← hs2star, ← hc2star, hdual]                               -- `c_2^*`・`s_2^*` の定義（仮定 `hc2star`・`hs2star`）で `hdual` を読み替える
  have hexp : Complex.exp ((-Complex.I) * (θ : ℂ)) = Complex.exp (-(Complex.I * (θ : ℂ))) := by
    rw [neg_mul]                                                   -- `multiply_by_minus_one` の `(-i)(θ)_ℂ = -(i(θ)_ℂ)`
  calc B1mat (K1 : ℂ) (θ : ℂ) * B2mat (K2star : ℂ) * B1mat (K1 : ℂ) (θ : ℂ)
      = B1mat (K1 : ℂ) (θ : ℂ) * (B2mat (K2star : ℂ) * B1mat (K1 : ℂ) (θ : ℂ)) :=
        Matrix.mul_assoc _ _ _                                     -- `mat_mult_associative`
    _ = factorizationB1Symbols ((Real.cosh K1 : ℝ) : ℂ) ((Real.sinh K1 : ℝ) : ℂ)
          (Complex.exp (Complex.I * (θ : ℂ))) (Complex.exp ((-Complex.I) * (θ : ℂ)))
        * (factorizationB2Symbols ((Real.cosh (2 * K2star) : ℝ) : ℂ) ((Real.sinh (2 * K2star) : ℝ) : ℂ)
          * factorizationB1Symbols ((Real.cosh K1 : ℝ) : ℂ) ((Real.sinh K1 : ℝ) : ℂ)
              (Complex.exp (Complex.I * (θ : ℂ))) (Complex.exp ((-Complex.I) * (θ : ℂ)))) := by
        rw [factorization_B1mat_eq_symbols, factorization_B2mat_eq_symbols]
                                                                   -- 「この記号で `B_1(θ) = …`、`B_2 = …`」
    _ = !![((Real.cosh (2 * K1) : ℝ) : ℂ) * ((Real.cosh (2 * K2star) : ℝ) : ℂ)
              - ((Real.sinh (2 * K1) : ℝ) : ℂ) * ((Real.sinh (2 * K2star) : ℝ) : ℂ) * ((Real.cos θ : ℝ) : ℂ),
            Complex.I * Complex.exp (Complex.I * (θ : ℂ)) * ((Real.sinh (2 * K2star) : ℝ) : ℂ)
              * (((Real.cosh (2 * K1) : ℝ) : ℂ) * ((Real.cos θ : ℝ) : ℂ) - Complex.I * ((Real.sin θ : ℝ) : ℂ)
                - ((Real.sinh (2 * K1) : ℝ) : ℂ) * ((K.c2 : ℝ) : ℂ));
          (-Complex.I) * Complex.exp ((-Complex.I) * (θ : ℂ)) * ((Real.sinh (2 * K2star) : ℝ) : ℂ)
              * (((Real.cosh (2 * K1) : ℝ) : ℂ) * ((Real.cos θ : ℝ) : ℂ) + Complex.I * ((Real.sin θ : ℝ) : ℂ)
                - ((Real.sinh (2 * K1) : ℝ) : ℂ) * ((K.c2 : ℝ) : ℂ)),
            ((Real.cosh (2 * K1) : ℝ) : ℂ) * ((Real.cosh (2 * K2star) : ℝ) : ℂ)
              - ((Real.sinh (2 * K1) : ℝ) : ℂ) * ((Real.sinh (2 * K2star) : ℝ) : ℂ) * ((Real.cos θ : ℝ) : ℂ)] := by
        rw [Matrix.eta_fin_two (factorizationB1Symbols _ _ _ _ * (factorizationB2Symbols _ _ * factorizationB1Symbols _ _ _ _)),
          factorization_step2_P11_real, factorization_step4_P12_real K1 θ K2star K.c2 hdual',
          factorization_step5_P21_real K1 θ K2star K.c2 hdual', factorization_step3_P22_real]
                                                                   -- `P` の 4 成分と Step 2〜5
    _ = !![((Real.cosh (2 * K1) * Real.cosh (2 * K2star)
              - Real.sinh (2 * K1) * Real.sinh (2 * K2star) * Real.cos θ : ℝ) : ℂ),
            Complex.I * Complex.exp (Complex.I * (θ : ℂ)) * ((Real.sinh (2 * K2star) : ℝ) : ℂ)
              * (((Real.cosh (2 * K1) : ℝ) : ℂ) * ((Real.cos θ : ℝ) : ℂ) - Complex.I * ((Real.sin θ : ℝ) : ℂ)
                - ((Real.sinh (2 * K1) : ℝ) : ℂ) * ((K.c2 : ℝ) : ℂ));
          -Complex.I * Complex.exp (-(Complex.I * (θ : ℂ))) * ((Real.sinh (2 * K2star) : ℝ) : ℂ)
              * (((Real.cosh (2 * K1) : ℝ) : ℂ) * ((Real.cos θ : ℝ) : ℂ) + Complex.I * ((Real.sin θ : ℝ) : ℂ)
                - ((Real.sinh (2 * K1) : ℝ) : ℂ) * ((K.c2 : ℝ) : ℂ)),
            ((Real.cosh (2 * K1) * Real.cosh (2 * K2star)
              - Real.sinh (2 * K1) * Real.sinh (2 * K2star) * Real.cos θ : ℝ) : ℂ)] := by
        rw [factorization_A_diag_as_inclusion, hexp]               -- 成分の実数を包含の像として読む（(1,1)・(2,2)）、
                                                                   -- (2,1) の指数 `(-i)(θ)_ℂ = -(i(θ)_ℂ)`
    _ = AMat K θ := by
        rw [AMat, hc1, hs1, hc2star, hs2star]                      -- `def_A_theta` と `c_1, s_1, c_2^*, s_2^*` の定義

/-- `factorization_of_A_theta_general` の仮定 `hc1`〜`hs2star` を、利用箇所（`TVPlus_checkZ_checkY` など）が持つ
ℂ の等式の形 `(c_1)_ℂ = cosh(2(K_1)_ℂ)` から実数の等式 `c_1 = cosh 2K_1` へ移す橋。
`Complex.cosh (x)_ℂ = (cosh x)_ℂ`（mathlib `Complex.ofReal_cosh`）と `2(K)_ℂ = (2K)_ℂ`（`2 = (2)_ℂ` と `real_inclusion_preserves_product`）、`inclusion_rr_to_cc` の単射性で受ける。 -/
theorem factorization_real_cosh_of_complex {c K : ℝ} (h : (c : ℂ) = Complex.cosh (2 * (K : ℂ))) :
    c = Real.cosh (2 * K) :=
  Complex.ofReal_injective (by rw [h, Complex.ofReal_cosh, ← real_inclusion_mul, Complex.ofReal_ofNat])

/-- `factorization_real_cosh_of_complex` の `sinh` 版。 -/
theorem factorization_real_sinh_of_complex {s K : ℝ} (h : (s : ℂ) = Complex.sinh (2 * (K : ℂ))) :
    s = Real.sinh (2 * K) :=
  Complex.ofReal_injective (by rw [h, Complex.ofReal_sinh, ← real_inclusion_mul, Complex.ofReal_ofNat])

/-- `factorization_of_A_theta_general` を、利用箇所の持つ ℂ の等式の形の仮定で述べたもの
（仮定の形を `factorization_real_cosh_of_complex`・`factorization_real_sinh_of_complex` と
`real_inclusion_mul`・`inclusion_rr_to_cc` の単射性で実数の等式へ移すだけで、主張の計算は `factorization_of_A_theta_general`）。 -/
theorem factorization_of_A_theta_general_of_complex_hyps (K : IsingConst) (K1 K2star θ : ℝ)
    (hc1 : (K.c1 : ℂ) = Complex.cosh (2 * (K1 : ℂ)))
    (hs1 : (K.s1 : ℂ) = Complex.sinh (2 * (K1 : ℂ)))
    (hc2star : (K.c2star : ℂ) = Complex.cosh (2 * (K2star : ℂ)))
    (hs2star : (K.s2star : ℂ) = Complex.sinh (2 * (K2star : ℂ)))
    (hdual : (K.s2star : ℂ) * (K.c2 : ℂ) = (K.c2star : ℂ)) :
    B1mat (K1 : ℂ) (θ : ℂ) * B2mat (K2star : ℂ) * B1mat (K1 : ℂ) (θ : ℂ) = AMat K θ :=
  factorization_of_A_theta_general K K1 K2star θ (factorization_real_cosh_of_complex hc1)
    (factorization_real_sinh_of_complex hs1) (factorization_real_cosh_of_complex hc2star)
    (factorization_real_sinh_of_complex hs2star)
    (Complex.ofReal_injective (by rw [← real_inclusion_mul, hdual]))

/-- 人手の記号 `K_2^* := Kstar K_2`（`def_second_dual_coupling_constant`、`K_2 ∈ ℝ_{>0}`）と
`def_indexed_hyperbolic_abbreviations` の `c_1, s_1, c_2, c_2^*, s_2^*` を 5 成分に持つ `IsingConst`。 -/
noncomputable def factorizationConst (K1 K2 : ℝ) : IsingConst where
  c1 := Real.cosh (2 * K1)
  s1 := Real.sinh (2 * K1)
  c2 := Real.cosh (2 * K2)
  c2star := Real.cosh (2 * Kstar K2)
  s2star := Real.sinh (2 * Kstar K2)

/-- **原文 `factorization_of_A_theta_general` を人手の記号のまま述べたもの**:
`K_1, θ ∈ ℝ`、`K_2 ∈ ℝ_{>0}`、`K_2^* := Kstar K_2` について `B_1(θ) B_2 B_1(θ) = A(θ)`。
双対関係 `s_2^* c_2 = c_2^*` は、人手の準備の `C = S(c_2)_ℂ` と同じく `duality_c2_star_eq_s2_star_c2` で埋める。 -/
theorem factorization_of_A_theta_general_of_coupling (K1 θ : ℝ) {K2 : ℝ} (hK2 : 0 < K2) :
    B1mat (K1 : ℂ) (θ : ℂ) * B2mat ((Kstar K2 : ℝ) : ℂ) * B1mat (K1 : ℂ) (θ : ℂ)
      = AMat (factorizationConst K1 K2) θ :=
  factorization_of_A_theta_general (factorizationConst K1 K2) K1 (Kstar K2) θ rfl rfl rfl rfl
    (duality_c2_star_eq_s2_star_c2 hK2).symm

/-- **原文の「とくに」の部分**: `θ = θ~_μ` としたもの（`antiperiodic_exp_sum` の `θ~_μ ∈ ℝ`）。
仮定は利用箇所の持つ ℂ の等式の形で取り、`factorization_of_A_theta_general_of_complex_hyps` を当てる。 -/
theorem factorization_of_A_thetaTilde (K : IsingConst) (K1 K2star : ℝ) (μ : ℤ)
    (hc1 : (K.c1 : ℂ) = Complex.cosh (2 * (K1 : ℂ)))
    (hs1 : (K.s1 : ℂ) = Complex.sinh (2 * (K1 : ℂ)))
    (hc2star : (K.c2star : ℂ) = Complex.cosh (2 * (K2star : ℂ)))
    (hs2star : (K.s2star : ℂ) = Complex.sinh (2 * (K2star : ℂ)))
    (hdual : (K.s2star : ℂ) * (K.c2 : ℂ) = (K.c2star : ℂ)) :
    B1mat (K1 : ℂ) ((thetaTilde M μ : ℝ) : ℂ) * B2mat (K2star : ℂ) * B1mat (K1 : ℂ) ((thetaTilde M μ : ℝ) : ℂ)
      = AMat K (thetaTilde M μ) :=
  factorization_of_A_theta_general_of_complex_hyps K K1 K2star (thetaTilde M μ) hc1 hs1 hc2star hs2star hdual

end Ising2D
