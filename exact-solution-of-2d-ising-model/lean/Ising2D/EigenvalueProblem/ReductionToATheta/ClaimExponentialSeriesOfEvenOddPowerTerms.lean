/-
# 偶数番目と奇数番目が数の冪のスカラー倍である行列の列の指数級数（具体版）

正本: `structured-latex/content/eigenvalue_problem_reduction_to_A_theta.ts`
（`evensectorT_claim_exponential_series_of_even_odd_power_terms`、ラベル **`exponential_series_of_even_odd_power_terms`**）

## 人手証明との対応

人手の `Mat(d,ℂ)` は Lean の `Matrix (Fin d) (Fin d) ℂ`、`x ∈ ℝ` の像 `x_ℂ`（`inclusion_rr_to_cc`）は `(x : ℂ)`、
`(1/n!)_ℂ` は `((1 / (n ! : ℝ) : ℝ) : ℂ)` である。

| 人手 | Lean |
| --- | --- |
| 証明の冒頭の `a_n := (x^n + (-x)^n)/(2·n!)`・`b_n := (x^n - (-x)^n)/(2·n!)` | `evenOddCoeffA`・`evenOddCoeffB` |
| 準備（冪の像）`(x_ℂ)^n = (x^n)_ℂ` の帰納法（`n = 0` の 3 行、`n → n+1` の 4 行） | `real_inclusion_pow` の 2 つの calc |
| 準備（`a_n, b_n` の値）の `n` 偶数の 3 行 × 2、`n` 奇数の 3 行 × 2 | `evenOddCoeffA_of_even`・`evenOddCoeffB_of_even`・`evenOddCoeffA_of_odd`・`evenOddCoeffB_of_odd` |
| 準備（実数の差の像）の 6 行 `y_ℂ − z_ℂ = ⋯ = (y − z)_ℂ` | `real_inclusion_sub` の calc の 6 段 |
| 中間目標「各項」の `n` 偶数の 10 行 | `evenOddTerm_of_even` の calc の 10 段 |
| 中間目標「各項」の `n` 奇数の 12 行 | `evenOddTerm_of_odd` の calc の 12 段 |
| 中間目標「各項」の偶数と奇数の 2 つの場合をまとめたもの | `evenOddTerm` |
| 証明の冒頭の `S_N`・`E_N(y)`・`α_N`・`β_N`・`L`（人手の添字 `n ∈ {0, …, N}` は `Fin (N + 1)`） | `evenOddPartialSum`・`expPartialSumReal`・`evenOddAlpha`・`evenOddBeta`・`evenOddLimit` |
| 中間目標「部分和」の成分の鎖の 1〜9 行 | `evenOddPartialSum_apply` の calc の 9 段 |
| 中間目標「部分和」の成分の鎖の 10〜11 行 | `evenOddPartialSum_apply_eq` の calc の 2 段 |
| 中間目標「部分和」の「行列は成分で定まる」 | `evenOddPartialSum_eq`（`Matrix.ext`） |
| 中間目標「差」の成分の鎖の 9 行 | `evenOddPartialSum_sub_limit_apply` の calc の 9 段 |
| 中間目標「差」の「行列は成分で定まる」 | `evenOddPartialSum_sub_limit`（`Matrix.ext`） |

中間目標「実数の評価」「ノルムの評価」と、`S_N → L` から級数の和を出す最後の鎖は、まだ置いていない
（状態台帳の (t5b) の割り方）。

根拠の当て方:
- `scalar_exp_is_limit_of_partial_sums` の冪の約束 `y^0 := 1`・`y^{m+1} := y^m y` は `pow_zero`・`pow_succ`。
- `real_inclusion_preserves_product` は `real_inclusion_mul`。
- 人手が「実数の差の像」の 5 行目で 2 項へ当てる `real_inclusion_preserves_finite_sum` は、2 項の場合の
  `real_inclusion_preserves_sum`（`real_inclusion_add`）で当てる。
- `def_complex_difference`・`multiply_by_minus_one`・`complex_times_zero_is_zero` と `complex_numbers_form_a_field` の
  積の結合律・可換律は Lean の具体版が無いので、既存の慣行どおり mathlib の `sub_eq_add_neg`・`neg_one_mul`・`mul_zero`・
  `mul_assoc`・`mul_comm` である。`scalar_multiple_is_associative` も同じく `smul_smul`。
- `matrix_plus_zero_matrix`・`zero_matrix_plus_matrix` は `matrix_add_zero_matrix`・`zero_matrix_add_matrix`、
  `zero_scalar_multiple_is_zero_matrix` は `matrix_zero_smul`。
- 「実数の冪 `(-x)^n = (-1)^n x^n`」は `neg_pow`、「`n` 偶数より `(-1)^n = 1`」「`n` 奇数より `(-1)^n = -1`」は
  `Even.neg_one_pow`・`Odd.neg_one_pow`、「実数の四則」は ℝ の式の `ring`（`n! ≠ 0` を使う段は `field_simp` の後の `ring`、
  `b_n = 0` の最後の段は `sub_self`・`zero_div`）。
- 中間目標「各項」の偶数の 5 行目と奇数の 8 行目は、準備の `a_n = x^n/n!`（`b_n = x^n/n!`）を `(1/n!)x^n` の位置に当てる。
  `x^n/n! = (1/n!)x^n` は実数の四則で、人手はこの並べ替えを書いていない。Lean は同じ段の中で `ring` で埋める。
- `def_matrix_sum`・`def_matrix_scalar_multiple`・`def_matrix_difference` は `matrix_sum_apply`・`matrix_smul_apply`・`matrix_sub_apply`、
  `finite_sum_of_complex_sums` は `finite_sum_of_complex_sums`、人手 8 行目の「実数の有限和の分配則」のうち
  共通の因子 `1/2` を外へ出すことと差を分けることは `finite_sum_of_real_scalar_multiples`・`finite_sum_of_real_differences`（いずれも具体版）。
- `finite_sum_of_matrices_entrywise` と多項の `real_inclusion_preserves_finite_sum` は Lean の具体版が無いので、既存の慣行どおり
  mathlib の `Matrix.sum_apply`・`Complex.ofReal_sum`。名前だけの根拠「ℂ の有限和の分配則」は `Finset.sum_mul`・`Finset.mul_sum`、
  「実数の有限和の分配則」のうち ℝ の和の有限和を分けることは `Finset.sum_add_distrib`（人手のラベルが無い）。
  `def_cosh_sinh` は Lean で定義し直していないので mathlib の `Real.cosh`・`Real.sinh`。
- 中間目標「部分和」の 9 行目は、人手 8 行目の `(1/2)(…)` を定義の `(…)/2` へ並べ替える `1/2·y = y/2`（実数の四則）を含む。
  人手はこの並べ替えを書いていない。Lean は同じ段の中で `one_div_mul_eq_div` で埋める。

具体的な実数・複素数・行列の等式を並べるだけで、主張に固有の構造は無いので、この段の必要十分版は置かない。
-/
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesProduct
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesSum
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimAddAndSubtractZeroMatrix
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimZeroScalarMultipleAndMatrixSumCommutative
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimMatMultDistributesOverSum
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityScalarMultipleAndDifferenceOnVectors
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimFiniteSumsOfRealNumbers
import Mathlib.Analysis.Complex.Trigonometric
import Mathlib.Data.Matrix.Basic
import Mathlib.Algebra.Ring.Parity
import Mathlib.Data.Nat.Factorial.Basic
import Mathlib.Tactic.FieldSimp

namespace Ising2D

open Nat

/-! ## 証明の冒頭で置く実数 -/

/-- 人手の `a_n := (x^n + (-x)^n)/(2·n!) ∈ ℝ`。 -/
noncomputable def evenOddCoeffA (x : ℝ) (n : ℕ) : ℝ := (x ^ n + (-x) ^ n) / (2 * (n ! : ℝ))

/-- 人手の `b_n := (x^n - (-x)^n)/(2·n!) ∈ ℝ`。 -/
noncomputable def evenOddCoeffB (x : ℝ) (n : ℕ) : ℝ := (x ^ n - (-x) ^ n) / (2 * (n ! : ℝ))

/-! ## 準備（冪の像） -/

/-- **人手の準備（冪の像）**: `(x_ℂ)^n = (x^n)_ℂ`（`n` に関する帰納法）。 -/
theorem real_inclusion_pow (x : ℝ) (n : ℕ) : (x : ℂ) ^ n = ((x ^ n : ℝ) : ℂ) := by
  induction n with
  | zero =>
    calc (x : ℂ) ^ 0
        = 1 := pow_zero _                                     -- `scalar_exp_is_limit_of_partial_sums` の ℂ の冪の約束
      _ = ((1 : ℝ) : ℂ) := Complex.ofReal_one.symm            -- `inclusion_rr_to_cc` の略記 `1_ℂ = ι_{ℝ→ℂ}(1)`
      _ = ((x ^ 0 : ℝ) : ℂ) := by rw [pow_zero]               -- `scalar_exp_is_limit_of_partial_sums` の ℝ の冪の約束
  | succ n ih =>
    calc (x : ℂ) ^ (n + 1)
        = (x : ℂ) ^ n * (x : ℂ) := pow_succ _ n               -- ℂ の冪の約束
      _ = ((x ^ n : ℝ) : ℂ) * (x : ℂ) := by rw [ih]           -- 帰納法の仮定
      _ = ((x ^ n * x : ℝ) : ℂ) := real_inclusion_mul _ _     -- `real_inclusion_preserves_product`
      _ = ((x ^ (n + 1) : ℝ) : ℂ) := by rw [← pow_succ]       -- ℝ の冪の約束

/-! ## 準備（`a_n, b_n` の値） -/

/-- 人手の準備: `n` 偶数のとき `a_n = x^n/n!`。 -/
theorem evenOddCoeffA_of_even (x : ℝ) {n : ℕ} (hn : Even n) :
    evenOddCoeffA x n = x ^ n / (n ! : ℝ) :=
  calc evenOddCoeffA x n
      = (x ^ n + (-1) ^ n * x ^ n) / (2 * (n ! : ℝ)) := by
        rw [evenOddCoeffA, neg_pow]                           -- 実数の冪 `(-x)^n = (-1)^n x^n`
    _ = (x ^ n + x ^ n) / (2 * (n ! : ℝ)) := by
        rw [hn.neg_one_pow, one_mul]                          -- `n` 偶数より `(-1)^n = 1`
    _ = x ^ n / (n ! : ℝ) := by
        have h : (n ! : ℝ) ≠ 0 := by exact_mod_cast n.factorial_ne_zero
        field_simp; ring                                      -- 実数の四則

/-- 人手の準備: `n` 偶数のとき `b_n = 0`。 -/
theorem evenOddCoeffB_of_even (x : ℝ) {n : ℕ} (hn : Even n) : evenOddCoeffB x n = 0 :=
  calc evenOddCoeffB x n
      = (x ^ n - (-1) ^ n * x ^ n) / (2 * (n ! : ℝ)) := by
        rw [evenOddCoeffB, neg_pow]                           -- 実数の冪 `(-x)^n = (-1)^n x^n`
    _ = (x ^ n - x ^ n) / (2 * (n ! : ℝ)) := by
        rw [hn.neg_one_pow, one_mul]                          -- `n` 偶数より `(-1)^n = 1`
    _ = 0 := by rw [sub_self, zero_div]                       -- 実数の四則

/-- 人手の準備: `n` 奇数のとき `a_n = 0`。 -/
theorem evenOddCoeffA_of_odd (x : ℝ) {n : ℕ} (hn : Odd n) : evenOddCoeffA x n = 0 :=
  calc evenOddCoeffA x n
      = (x ^ n + (-1) ^ n * x ^ n) / (2 * (n ! : ℝ)) := by
        rw [evenOddCoeffA, neg_pow]                           -- 実数の冪 `(-x)^n = (-1)^n x^n`
    _ = (x ^ n + (-1) * x ^ n) / (2 * (n ! : ℝ)) := by
        rw [hn.neg_one_pow]                                   -- `n` 奇数より `(-1)^n = -1`
    _ = 0 := by ring                                          -- 実数の四則

/-- 人手の準備: `n` 奇数のとき `b_n = x^n/n!`。 -/
theorem evenOddCoeffB_of_odd (x : ℝ) {n : ℕ} (hn : Odd n) :
    evenOddCoeffB x n = x ^ n / (n ! : ℝ) :=
  calc evenOddCoeffB x n
      = (x ^ n - (-1) ^ n * x ^ n) / (2 * (n ! : ℝ)) := by
        rw [evenOddCoeffB, neg_pow]                           -- 実数の冪 `(-x)^n = (-1)^n x^n`
    _ = (x ^ n - (-1) * x ^ n) / (2 * (n ! : ℝ)) := by
        rw [hn.neg_one_pow]                                   -- `n` 奇数より `(-1)^n = -1`
    _ = x ^ n / (n ! : ℝ) := by
        have h : (n ! : ℝ) ≠ 0 := by exact_mod_cast n.factorial_ne_zero
        field_simp; ring                                      -- 実数の四則

/-! ## 準備（実数の差の像） -/

/-- **人手の準備（実数の差の像）**: `y_ℂ − z_ℂ = (y − z)_ℂ`。人手の 6 行と calc の 6 段が 1 対 1 である。 -/
theorem real_inclusion_sub (y z : ℝ) : (y : ℂ) - (z : ℂ) = ((y - z : ℝ) : ℂ) :=
  calc (y : ℂ) - (z : ℂ)
      = (y : ℂ) + -(z : ℂ) := sub_eq_add_neg _ _              -- `def_complex_difference`
    _ = (y : ℂ) + (-1 : ℂ) * (z : ℂ) := by rw [neg_one_mul]   -- `multiply_by_minus_one`
    _ = (y : ℂ) + ((-1 : ℝ) : ℂ) * (z : ℂ) := by
        rw [Complex.ofReal_neg, Complex.ofReal_one]           -- `inclusion_rr_to_cc` の `-1_ℂ = ι_{ℝ→ℂ}(-1) = (-1)_ℂ`
    _ = (y : ℂ) + (((-1) * z : ℝ) : ℂ) := by
        rw [real_inclusion_mul]                               -- `real_inclusion_preserves_product`
    _ = ((y + (-1) * z : ℝ) : ℂ) := real_inclusion_add _ _    -- `real_inclusion_preserves_finite_sum` を 2 項へ（`real_inclusion_preserves_sum`）
    _ = ((y - z : ℝ) : ℂ) := by congr 1; ring                 -- 実数の四則（ℝ の式 `y + (-1)z = y - z`）

/-! ## 中間目標「各項」 -/

variable {d : ℕ}

/-- **人手の中間目標「各項」の `n` 偶数の場合**: `(1/n!)_ℂ T_n = (a_n)_ℂ A + (c(b_n)_ℂ)B`。
仮定 `hT` は人手の `T_n` の仮定の偶数の場合 `T_n = (x_ℂ)^n A`。人手の 10 行と calc の 10 段が 1 対 1 である。 -/
theorem evenOddTerm_of_even (A B : Matrix (Fin d) (Fin d) ℂ) (x : ℝ) (c : ℂ)
    {T : Matrix (Fin d) (Fin d) ℂ} {n : ℕ} (hn : Even n) (hT : T = (x : ℂ) ^ n • A) :
    ((1 / (n ! : ℝ) : ℝ) : ℂ) • T
      = ((evenOddCoeffA x n : ℝ) : ℂ) • A + (c * ((evenOddCoeffB x n : ℝ) : ℂ)) • B :=
  calc ((1 / (n ! : ℝ) : ℝ) : ℂ) • T
      = ((1 / (n ! : ℝ) : ℝ) : ℂ) • ((x : ℂ) ^ n • A) := by
        rw [hT]                                               -- 人手 1: `T_n` の仮定の偶数の場合
    _ = (((1 / (n ! : ℝ) : ℝ) : ℂ) * (x : ℂ) ^ n) • A :=
        smul_smul _ _ _                                       -- 人手 2: `scalar_multiple_is_associative`
    _ = (((1 / (n ! : ℝ) : ℝ) : ℂ) * ((x ^ n : ℝ) : ℂ)) • A := by
        rw [real_inclusion_pow]                               -- 人手 3: 準備の冪の像
    _ = ((1 / (n ! : ℝ) * x ^ n : ℝ) : ℂ) • A := by
        rw [real_inclusion_mul]                               -- 人手 4: `real_inclusion_preserves_product`
    _ = ((evenOddCoeffA x n : ℝ) : ℂ) • A := by
        rw [evenOddCoeffA_of_even x hn]; congr 2; ring        -- 人手 5: 準備の `n` 偶数の `a_n = x^n/n!`
    _ = ((evenOddCoeffA x n : ℝ) : ℂ) • A + 0 :=
        (matrix_add_zero_matrix _).symm                       -- 人手 6: `matrix_plus_zero_matrix`
    _ = ((evenOddCoeffA x n : ℝ) : ℂ) • A + (0 : ℂ) • B := by
        rw [matrix_zero_smul]                                 -- 人手 7: `zero_scalar_multiple_is_zero_matrix`
    _ = ((evenOddCoeffA x n : ℝ) : ℂ) • A + (c * 0) • B := by
        rw [mul_zero]                                         -- 人手 8: `complex_times_zero_is_zero`
    _ = ((evenOddCoeffA x n : ℝ) : ℂ) • A + (c * ((0 : ℝ) : ℂ)) • B := by
        rw [Complex.ofReal_zero]                              -- 人手 9: `inclusion_rr_to_cc` の略記 `0_ℂ = ι_{ℝ→ℂ}(0)`
    _ = ((evenOddCoeffA x n : ℝ) : ℂ) • A + (c * ((evenOddCoeffB x n : ℝ) : ℂ)) • B := by
        rw [evenOddCoeffB_of_even x hn]                       -- 人手 10: 準備の `n` 偶数の `b_n = 0`

/-- **人手の中間目標「各項」の `n` 奇数の場合**: `(1/n!)_ℂ T_n = (a_n)_ℂ A + (c(b_n)_ℂ)B`。
仮定 `hT` は人手の `T_n` の仮定の奇数の場合 `T_n = (c(x_ℂ)^n)B`。人手の 12 行と calc の 12 段が 1 対 1 である。 -/
theorem evenOddTerm_of_odd (A B : Matrix (Fin d) (Fin d) ℂ) (x : ℝ) (c : ℂ)
    {T : Matrix (Fin d) (Fin d) ℂ} {n : ℕ} (hn : Odd n) (hT : T = (c * (x : ℂ) ^ n) • B) :
    ((1 / (n ! : ℝ) : ℝ) : ℂ) • T
      = ((evenOddCoeffA x n : ℝ) : ℂ) • A + (c * ((evenOddCoeffB x n : ℝ) : ℂ)) • B :=
  calc ((1 / (n ! : ℝ) : ℝ) : ℂ) • T
      = ((1 / (n ! : ℝ) : ℝ) : ℂ) • ((c * (x : ℂ) ^ n) • B) := by
        rw [hT]                                               -- 人手 1: `T_n` の仮定の奇数の場合
    _ = (((1 / (n ! : ℝ) : ℝ) : ℂ) * (c * (x : ℂ) ^ n)) • B :=
        smul_smul _ _ _                                       -- 人手 2: `scalar_multiple_is_associative`
    _ = ((((1 / (n ! : ℝ) : ℝ) : ℂ) * c) * (x : ℂ) ^ n) • B := by
        rw [mul_assoc]                                        -- 人手 3: `complex_numbers_form_a_field` の積の結合律
    _ = ((c * ((1 / (n ! : ℝ) : ℝ) : ℂ)) * (x : ℂ) ^ n) • B := by
        rw [mul_comm c]                                       -- 人手 4: `complex_numbers_form_a_field` の積の可換律
    _ = (c * (((1 / (n ! : ℝ) : ℝ) : ℂ) * (x : ℂ) ^ n)) • B := by
        rw [mul_assoc]                                        -- 人手 5: `complex_numbers_form_a_field` の積の結合律
    _ = (c * (((1 / (n ! : ℝ) : ℝ) : ℂ) * ((x ^ n : ℝ) : ℂ))) • B := by
        rw [real_inclusion_pow]                               -- 人手 6: 準備の冪の像
    _ = (c * ((1 / (n ! : ℝ) * x ^ n : ℝ) : ℂ)) • B := by
        rw [real_inclusion_mul]                               -- 人手 7: `real_inclusion_preserves_product`
    _ = (c * ((evenOddCoeffB x n : ℝ) : ℂ)) • B := by
        rw [evenOddCoeffB_of_odd x hn]; congr 3; ring         -- 人手 8: 準備の `n` 奇数の `b_n = x^n/n!`
    _ = 0 + (c * ((evenOddCoeffB x n : ℝ) : ℂ)) • B :=
        (zero_matrix_add_matrix _).symm                       -- 人手 9: `zero_matrix_plus_matrix`
    _ = (0 : ℂ) • A + (c * ((evenOddCoeffB x n : ℝ) : ℂ)) • B := by
        rw [matrix_zero_smul]                                 -- 人手 10: `zero_scalar_multiple_is_zero_matrix`
    _ = ((0 : ℝ) : ℂ) • A + (c * ((evenOddCoeffB x n : ℝ) : ℂ)) • B := by
        rw [Complex.ofReal_zero]                              -- 人手 11: `inclusion_rr_to_cc` の略記 `0_ℂ = ι_{ℝ→ℂ}(0)`
    _ = ((evenOddCoeffA x n : ℝ) : ℂ) • A + (c * ((evenOddCoeffB x n : ℝ) : ℂ)) • B := by
        rw [evenOddCoeffA_of_odd x hn]                        -- 人手 12: 準備の `n` 奇数の `a_n = 0`

/-- **人手の中間目標「各項」**（`n` の偶奇で場合を分けた 2 つをまとめたもの）。
仮定 `hTe`・`hTo` は人手の `T_n` の仮定の偶数の場合と奇数の場合。 -/
theorem evenOddTerm (A B : Matrix (Fin d) (Fin d) ℂ) (x : ℝ) (c : ℂ) (T : ℕ → Matrix (Fin d) (Fin d) ℂ)
    (hTe : ∀ n, Even n → T n = (x : ℂ) ^ n • A) (hTo : ∀ n, Odd n → T n = (c * (x : ℂ) ^ n) • B) (n : ℕ) :
    ((1 / (n ! : ℝ) : ℝ) : ℂ) • T n
      = ((evenOddCoeffA x n : ℝ) : ℂ) • A + (c * ((evenOddCoeffB x n : ℝ) : ℂ)) • B := by
  rcases Nat.even_or_odd n with hn | hn
  · exact evenOddTerm_of_even A B x c hn (hTe n hn)
  · exact evenOddTerm_of_odd A B x c hn (hTo n hn)

/-! ## 証明の冒頭で置く部分和と極限の候補 -/

/-- 人手の `S_N := Σ_{n=0}^{N} (1/n!)_ℂ T_n`（`def_finite_sum_of_matrices`）。人手の添字 `n ∈ {0, …, N}` は Lean の `Fin (N + 1)` の `n`。 -/
noncomputable def evenOddPartialSum (T : ℕ → Matrix (Fin d) (Fin d) ℂ) (N : ℕ) : Matrix (Fin d) (Fin d) ℂ :=
  ∑ n : Fin (N + 1), ((1 / ((n : ℕ) ! : ℝ) : ℝ) : ℂ) • T n

/-- 人手の `E_N(y) := Σ_{n=0}^{N} y^n/n!`（`scalar_exp_is_limit_of_partial_sums` の部分和）。 -/
noncomputable def expPartialSumReal (y : ℝ) (N : ℕ) : ℝ :=
  ∑ n : Fin (N + 1), y ^ (n : ℕ) / ((n : ℕ) ! : ℝ)

/-- 人手の `α_N := (E_N(x) + E_N(-x))/2`。 -/
noncomputable def evenOddAlpha (x : ℝ) (N : ℕ) : ℝ := (expPartialSumReal x N + expPartialSumReal (-x) N) / 2

/-- 人手の `β_N := (E_N(x) - E_N(-x))/2`。 -/
noncomputable def evenOddBeta (x : ℝ) (N : ℕ) : ℝ := (expPartialSumReal x N - expPartialSumReal (-x) N) / 2

/-- 人手の `L := (cosh x)_ℂ A + (c(sinh x)_ℂ)B`。`def_cosh_sinh` は Lean で定義し直していないので mathlib の `Real.cosh`・`Real.sinh`。 -/
noncomputable def evenOddLimit (A B : Matrix (Fin d) (Fin d) ℂ) (x : ℝ) (c : ℂ) : Matrix (Fin d) (Fin d) ℂ :=
  ((Real.cosh x : ℝ) : ℂ) • A + (c * ((Real.sinh x : ℝ) : ℂ)) • B

/-! ## 中間目標「部分和」 -/

/-- **人手の中間目標「部分和」の成分の鎖**: `(S_N)_{pq} = (α_N)_ℂ A_{pq} + (c(β_N)_ℂ)B_{pq}`。人手の 11 行のうち最後の 2 行を除く
9 行と calc の 9 段が 1 対 1 である（最後の 2 行は `evenOddPartialSum_apply_eq` の 2 段）。 -/
theorem evenOddPartialSum_apply (A B : Matrix (Fin d) (Fin d) ℂ) (x : ℝ) (c : ℂ) (T : ℕ → Matrix (Fin d) (Fin d) ℂ)
    (hTe : ∀ n, Even n → T n = (x : ℂ) ^ n • A) (hTo : ∀ n, Odd n → T n = (c * (x : ℂ) ^ n) • B)
    (N : ℕ) (p q : Fin d) :
    evenOddPartialSum T N p q
      = ((evenOddAlpha x N : ℝ) : ℂ) * A p q + (c * ((evenOddBeta x N : ℝ) : ℂ)) * B p q :=
  calc evenOddPartialSum T N p q
      = ∑ n : Fin (N + 1), (((1 / ((n : ℕ) ! : ℝ) : ℝ) : ℂ) • T n) p q :=
        Matrix.sum_apply _ _ _ _                              -- 人手 1: `finite_sum_of_matrices_entrywise`（mathlib の `Matrix.sum_apply`）
    _ = ∑ n : Fin (N + 1), (((evenOddCoeffA x n : ℝ) : ℂ) • A
          + (c * ((evenOddCoeffB x n : ℝ) : ℂ)) • B) p q := by
        simp only [evenOddTerm A B x c T hTe hTo]             -- 人手 2: 各項の中間目標
    _ = ∑ n : Fin (N + 1), ((((evenOddCoeffA x n : ℝ) : ℂ) • A) p q
          + ((c * ((evenOddCoeffB x n : ℝ) : ℂ)) • B) p q) := by
        simp only [matrix_sum_apply]                          -- 人手 3: `def_matrix_sum`
    _ = ∑ n : Fin (N + 1), (((evenOddCoeffA x n : ℝ) : ℂ) * A p q
          + (c * ((evenOddCoeffB x n : ℝ) : ℂ)) * B p q) := by
        simp only [matrix_smul_apply]                         -- 人手 4: `def_matrix_scalar_multiple`
    _ = (∑ n : Fin (N + 1), ((evenOddCoeffA x n : ℝ) : ℂ) * A p q)
          + ∑ n : Fin (N + 1), (c * ((evenOddCoeffB x n : ℝ) : ℂ)) * B p q :=
        finite_sum_of_complex_sums _ _ _                      -- 人手 5: `finite_sum_of_complex_sums`
    _ = (∑ n : Fin (N + 1), ((evenOddCoeffA x n : ℝ) : ℂ)) * A p q
          + (c * ∑ n : Fin (N + 1), ((evenOddCoeffB x n : ℝ) : ℂ)) * B p q := by
        rw [← Finset.sum_mul, ← Finset.sum_mul, ← Finset.mul_sum]
                                                              -- 人手 6: ℂ の有限和の分配則（mathlib の `Finset.sum_mul`・`Finset.mul_sum`）
    _ = ((∑ n : Fin (N + 1), evenOddCoeffA x n : ℝ) : ℂ) * A p q
          + (c * ((∑ n : Fin (N + 1), evenOddCoeffB x n : ℝ) : ℂ)) * B p q := by
        rw [Complex.ofReal_sum, Complex.ofReal_sum]           -- 人手 7: `real_inclusion_preserves_finite_sum` を 2 箇所へ同時適用
                                                              -- （Lean の具体版は無く、既存の慣行どおり mathlib の `Complex.ofReal_sum`）
    _ = ((1 / 2 * (∑ n : Fin (N + 1), x ^ (n : ℕ) / ((n : ℕ) ! : ℝ)
            + ∑ n : Fin (N + 1), (-x) ^ (n : ℕ) / ((n : ℕ) ! : ℝ)) : ℝ) : ℂ) * A p q
          + (c * ((1 / 2 * (∑ n : Fin (N + 1), x ^ (n : ℕ) / ((n : ℕ) ! : ℝ)
            - ∑ n : Fin (N + 1), (-x) ^ (n : ℕ) / ((n : ℕ) ! : ℝ)) : ℝ) : ℂ)) * B p q := by
        -- 人手 8: 実数の有限和の分配則。各項を `a_n = (1/2)(x^n/n! + (-x)^n/n!)`・`b_n = (1/2)(x^n/n! - (-x)^n/n!)` と
        -- 書き直し（ℝ の四則）、`finite_sum_of_real_scalar_multiples` で `1/2` を外へ、`Finset.sum_add_distrib`（ℝ の和の有限和。
        -- Lean の具体版は無い）と `finite_sum_of_real_differences` で和を分ける
        have ha : ∀ n : Fin (N + 1), evenOddCoeffA x n
            = 1 / 2 * (x ^ (n : ℕ) / ((n : ℕ) ! : ℝ) + (-x) ^ (n : ℕ) / ((n : ℕ) ! : ℝ)) := fun n => by
          rw [evenOddCoeffA]; ring
        have hb : ∀ n : Fin (N + 1), evenOddCoeffB x n
            = 1 / 2 * (x ^ (n : ℕ) / ((n : ℕ) ! : ℝ) - (-x) ^ (n : ℕ) / ((n : ℕ) ! : ℝ)) := fun n => by
          rw [evenOddCoeffB]; ring
        simp only [ha, hb]
        rw [finite_sum_of_real_scalar_multiples, finite_sum_of_real_scalar_multiples, Finset.sum_add_distrib,
          finite_sum_of_real_differences]
    _ = ((evenOddAlpha x N : ℝ) : ℂ) * A p q + (c * ((evenOddBeta x N : ℝ) : ℂ)) * B p q := by
        -- 人手 9: `E_N, α_N, β_N` の定義（人手 8 行目の `(1/2)(…)` と定義の `(…)/2` の並べ替え `1/2·y = y/2` は ℝ の四則）
        rw [evenOddAlpha, evenOddBeta, expPartialSumReal, expPartialSumReal, one_div_mul_eq_div, one_div_mul_eq_div]

/-- 人手の中間目標「部分和」の成分の鎖の最後の 2 行: `(α_N)_ℂ A_{pq} + (c(β_N)_ℂ)B_{pq} = ((α_N)_ℂ A + (c(β_N)_ℂ)B)_{pq}`。 -/
theorem evenOddPartialSum_apply_eq (A B : Matrix (Fin d) (Fin d) ℂ) (x : ℝ) (c : ℂ) (T : ℕ → Matrix (Fin d) (Fin d) ℂ)
    (hTe : ∀ n, Even n → T n = (x : ℂ) ^ n • A) (hTo : ∀ n, Odd n → T n = (c * (x : ℂ) ^ n) • B)
    (N : ℕ) (p q : Fin d) :
    evenOddPartialSum T N p q
      = (((evenOddAlpha x N : ℝ) : ℂ) • A + (c * ((evenOddBeta x N : ℝ) : ℂ)) • B) p q :=
  calc evenOddPartialSum T N p q
      = ((evenOddAlpha x N : ℝ) : ℂ) * A p q + (c * ((evenOddBeta x N : ℝ) : ℂ)) * B p q :=
        evenOddPartialSum_apply A B x c T hTe hTo N p q      -- 人手 1〜9
    _ = (((evenOddAlpha x N : ℝ) : ℂ) • A) p q + ((c * ((evenOddBeta x N : ℝ) : ℂ)) • B) p q := by
        rw [matrix_smul_apply, matrix_smul_apply]             -- 人手 10: `def_matrix_scalar_multiple`
    _ = (((evenOddAlpha x N : ℝ) : ℂ) • A + (c * ((evenOddBeta x N : ℝ) : ℂ)) • B) p q :=
        (matrix_sum_apply _ _ _ _).symm                       -- 人手 11: `def_matrix_sum`

/-- **人手の中間目標「部分和」**: `S_N = (α_N)_ℂ A + (c(β_N)_ℂ)B`（行列は成分で定まる）。 -/
theorem evenOddPartialSum_eq (A B : Matrix (Fin d) (Fin d) ℂ) (x : ℝ) (c : ℂ) (T : ℕ → Matrix (Fin d) (Fin d) ℂ)
    (hTe : ∀ n, Even n → T n = (x : ℂ) ^ n • A) (hTo : ∀ n, Odd n → T n = (c * (x : ℂ) ^ n) • B) (N : ℕ) :
    evenOddPartialSum T N = ((evenOddAlpha x N : ℝ) : ℂ) • A + (c * ((evenOddBeta x N : ℝ) : ℂ)) • B :=
  Matrix.ext (evenOddPartialSum_apply_eq A B x c T hTe hTo N)   -- 行列は成分で定まる

/-! ## 中間目標「差」 -/

/-- **人手の中間目標「差」の成分の鎖**: `(S_N - L)_{pq} = ((α_N - cosh x)_ℂ A + (c(β_N - sinh x)_ℂ)B)_{pq}`。人手の 9 行と calc の 9 段が 1 対 1 である。 -/
theorem evenOddPartialSum_sub_limit_apply (A B : Matrix (Fin d) (Fin d) ℂ) (x : ℝ) (c : ℂ)
    (T : ℕ → Matrix (Fin d) (Fin d) ℂ)
    (hTe : ∀ n, Even n → T n = (x : ℂ) ^ n • A) (hTo : ∀ n, Odd n → T n = (c * (x : ℂ) ^ n) • B)
    (N : ℕ) (p q : Fin d) :
    (evenOddPartialSum T N - evenOddLimit A B x c) p q
      = (((evenOddAlpha x N - Real.cosh x : ℝ) : ℂ) • A
          + (c * ((evenOddBeta x N - Real.sinh x : ℝ) : ℂ)) • B) p q :=
  calc (evenOddPartialSum T N - evenOddLimit A B x c) p q
      = evenOddPartialSum T N p q - evenOddLimit A B x c p q :=
        matrix_sub_apply _ _ _ _                              -- 人手 1: `def_matrix_difference`
    _ = (((evenOddAlpha x N : ℝ) : ℂ) * A p q + (c * ((evenOddBeta x N : ℝ) : ℂ)) * B p q)
          - evenOddLimit A B x c p q := by
        rw [evenOddPartialSum_apply A B x c T hTe hTo N p q] -- 人手 2: 部分和の中間目標の成分の鎖
    _ = (((evenOddAlpha x N : ℝ) : ℂ) * A p q + (c * ((evenOddBeta x N : ℝ) : ℂ)) * B p q)
          - (((Real.cosh x : ℝ) : ℂ) • A + (c * ((Real.sinh x : ℝ) : ℂ)) • B) p q := by
        rw [evenOddLimit]                                     -- 人手 3: `L` の定義
    _ = (((evenOddAlpha x N : ℝ) : ℂ) * A p q + (c * ((evenOddBeta x N : ℝ) : ℂ)) * B p q)
          - ((((Real.cosh x : ℝ) : ℂ) • A) p q + ((c * ((Real.sinh x : ℝ) : ℂ)) • B) p q) := by
        rw [matrix_sum_apply]                                 -- 人手 4: `def_matrix_sum`
    _ = (((evenOddAlpha x N : ℝ) : ℂ) * A p q + (c * ((evenOddBeta x N : ℝ) : ℂ)) * B p q)
          - (((Real.cosh x : ℝ) : ℂ) * A p q + (c * ((Real.sinh x : ℝ) : ℂ)) * B p q) := by
        rw [matrix_smul_apply, matrix_smul_apply]             -- 人手 5: `def_matrix_scalar_multiple`
    _ = (((evenOddAlpha x N : ℝ) : ℂ) - ((Real.cosh x : ℝ) : ℂ)) * A p q
          + (c * (((evenOddBeta x N : ℝ) : ℂ) - ((Real.sinh x : ℝ) : ℂ))) * B p q := by
        ring                                                  -- 人手 6: ℂ の四則
    _ = ((evenOddAlpha x N - Real.cosh x : ℝ) : ℂ) * A p q
          + (c * ((evenOddBeta x N - Real.sinh x : ℝ) : ℂ)) * B p q := by
        rw [real_inclusion_sub, real_inclusion_sub]           -- 人手 7: 準備の実数の差の像を 2 箇所へ同時適用
    _ = (((evenOddAlpha x N - Real.cosh x : ℝ) : ℂ) • A) p q
          + ((c * ((evenOddBeta x N - Real.sinh x : ℝ) : ℂ)) • B) p q := by
        rw [matrix_smul_apply, matrix_smul_apply]             -- 人手 8: `def_matrix_scalar_multiple`
    _ = (((evenOddAlpha x N - Real.cosh x : ℝ) : ℂ) • A
          + (c * ((evenOddBeta x N - Real.sinh x : ℝ) : ℂ)) • B) p q :=
        (matrix_sum_apply _ _ _ _).symm                       -- 人手 9: `def_matrix_sum`

/-- **人手の中間目標「差」**: `S_N - L = (α_N - cosh x)_ℂ A + (c(β_N - sinh x)_ℂ)B`（行列は成分で定まる）。 -/
theorem evenOddPartialSum_sub_limit (A B : Matrix (Fin d) (Fin d) ℂ) (x : ℝ) (c : ℂ)
    (T : ℕ → Matrix (Fin d) (Fin d) ℂ)
    (hTe : ∀ n, Even n → T n = (x : ℂ) ^ n • A) (hTo : ∀ n, Odd n → T n = (c * (x : ℂ) ^ n) • B) (N : ℕ) :
    evenOddPartialSum T N - evenOddLimit A B x c
      = ((evenOddAlpha x N - Real.cosh x : ℝ) : ℂ) • A
          + (c * ((evenOddBeta x N - Real.sinh x : ℝ) : ℂ)) • B :=
  Matrix.ext (evenOddPartialSum_sub_limit_apply A B x c T hTe hTo N)   -- 行列は成分で定まる

end Ising2D
