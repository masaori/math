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
具体版が Lean に無いので mathlib で受けた行は `cosh_sinh_basic_properties` (2)（`Real.cosh_sq_sub_sinh_sq`）だけである。

この 3 本はまだ `B1_mul_B2_mul_B1_eq_explicit` の証明から使われていない（あちらは `simp`・`field_simp`・`ring` で成分を一度に計算する）。
人手の Step 1〜6 の calc に組み直すのは状態台帳の別の項目である。組み直すときは、`B1mat` が `K1 : ℂ` と `Complex.cosh K1` で
定義されていて準備の鎖の `a = (cosh K_1)_ℂ`（`K_1 ∈ ℝ`）と式の形が違うので、主張の `K1` を人手どおり実数にするか、橋の補題が要る。

具体的な実数の計算で、主張に固有の構造は実数の像の演算と双曲線関数の公式だけなので、必要十分版は置かない。
-/
import Ising2D.EigenvalueProblem.ReductionToATheta.ClaimAntiperiodicExpSum
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
