/-
# `θ_μ`, `γ_1(θ)`, `γ_2(θ)`, `A(θ)` の定義とその基本性質

対応する人手証明（正本は `structured-latex/content/`。整数運動量の経路の項目は本文から参照用ノートへ退避してある）:
- `structured-latex/content/eigenvalue_problem_reduction_to_A_theta.ts`
  - `TV1_hatZ_hatY_017_definition_A_theta`（ラベル `def_A_theta`）
- 参照用ノート `structured-latex/notes/integer_momentum_route_not_adopted.ts`（整数運動量の経路。本文から退避した。
  ノートの各項目の id の末尾が、本文にあったときのブロックの id である）
  - `TV1_hatZ_hatY_019_definition_theta_mu`（本文にあったときのラベル `def_theta_mu`）
  - `TV1_hatZ_hatY_020_definition_gamma1_gamma2`（本文にあったときもラベル無し）
  - `TV1_hatZ_hatY_022_claim_gamma2_theta_is_0`（本文にあったときのラベル `gamma_2_theta_is_0`）
  - `TV1_hatZ_hatY_023_claim_relation_of_gamma2`（本文にあったときのラベル `relation_of_gamma_2`）
  - `TV1_hatZ_hatY_027_claim_eigenvector_A_theta`（本文にあったときのラベル `eigenvector_of_A_theta`。`gamma2_neg_eq_zero_iff` の docstring が名指しする）
  - `TV1_hatZ_hatY_041_claim_gamma2_periodicity`（本文にあったときのラベル `gamma2_theta_M_periodicity`）
- `eigenvalue_problem_diagonalization_and_exponential_form.ts`
  - `def_gamma1_gamma2_of_theta` の主張と `(2,1)` 成分の 2 本の鎖（`AMat_eq`・`AMat_two_one_eq_neg_gamma2_neg`・`gamma2_neg`）
  - `relation_of_gamma_2_theta_tilde` の証明の「第一に」の `exp(iθ)` の鎖、「第二に」「第三に」「第四に」と (1) の鎖
    （`gamma2_neg`・`gamma2_neg_eq_neg_conj` とその準備の補題。各段に人手の行を書いた。準備の第一から移した
    `i(-θ)`・`-i(-θ)`・`cos(-θ)`・`sin(-θ)` の 4 主張の具体版は `MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimCosSinAndITimesAtNegatedReal.lean`）

人手の定義（`def_A_theta`・`def_gamma1_gamma2_of_theta` とも `θ ∈ ℝ`。成分の実数の読み、`(2,1)` 成分の先頭の `-i` が
`multiply_by_minus_one` の `-i` であること、四つの因子の積を左から括ることは `def_A_theta` に書いてある）:

  `γ_1(θ) := c_1 c_2^* - s_1 s_2^* cos θ  ∈ ℝ`
  `γ_2(θ) := i e^{iθ} s_2^* (c_1 cos θ - i sin θ - s_1 c_2)  ∈ ℂ`
  `A(θ) := ((c_1c_2^* - s_1s_2^* cos θ,               i e^{iθ} s_2^*(c_1cos θ - i sin θ - s_1c_2)),
            (-i e^{-iθ} s_2^*(c_1cos θ + i sin θ - s_1c_2), c_1c_2^* - s_1s_2^* cos θ))`
  `θ_μ := 2πμ/M`

## 形式化の方針

* `c_1, s_1, c_2, c_2^*, s_2^*` は原文では `c_1 = cosh(2K_1)`, `s_1 = sinh(2K_1)`,
  `c_2 = cosh(2K_2)`, `c_2^* = cosh(2K_2^*)`, `s_2^* = sinh(2K_2^*)` にあたるが、
  `A(θ)` の対角化に必要なのは「実数であること」と、`det A = 1` を出すときの
  代数関係だけである。したがって 5 個の実数パラメータを束ねた `IsingConst` を導入し、
  必要な関係（`c_1^2 - s_1^2 = 1` など）は**そのつど仮定として明示する**。
  これにより「どの結論がどの関係に依存するか」が形式化の側で可視化される。
* 添字 `μ` は整数運動量の経路（参照用ノート）の `ℳ := {-M, …, -1, 1, …, M}` に限らず `ℤ` 全体で扱う
  （`θ_μ` の定義式は全 `μ ∈ ℤ` で意味を持つ。`RoutesNotAdopted/IntegerMomentum/DefinitionHatZHatY.lean` の `hatZ`/`hatY` と同じ方針）。
* `A(θ)` は原文 `def_A_theta` の**明示行列そのまま**を定義とし、
  `AMat_eq` で `!![γ_1(θ), γ_2(θ); -γ_2(-θ), γ_1(θ)]` に等しいことを証明する
  （人手 `def_gamma1_gamma2_of_theta` の主張。`(2,1)` 成分は人手の鎖と 1 対 1 の `AMat_two_one_eq_neg_gamma2_neg`）。

## 形式化の過程で見つかった原文の問題（および解消状況）

1. **`gamma_2_theta_is_0`（`TV1_hatZ_hatY_022`）が `s_2^* ≠ 0` を暗黙に仮定していた。**
   `γ_2` は `s_2^*` を因子に持つので、`s_2^* = 0` のときは `sin θ`, `c_1cos θ - s_1c_2` と
   無関係に `γ_2 ≡ 0` である。定義だけから言える同値は
   `γ_2(θ) = 0 ⟺ s_2^* = 0 ∨ (sin θ = 0 ∧ c_1cos θ - s_1c_2 = 0)`（`gamma2_eq_zero_iff`）で、
   原文の形は `s_2^* ≠ 0` の下でのみ成り立つ（`gamma2_eq_zero_iff_of_s2star_ne_zero`）。
   → **本セッションと並行して原文側が修正済み**（当該ブロックは本文にあったときに
   `K_1, K_2 ∈ ℝ_{>0}` を前提に置き、そこから `s_2^* = sinh(2K_2^*) > 0` が従う。参照用ノートにもその形のまま在る）。
2. **`gamma_2_theta_is_0` の同値 `sin θ_μ = 0 ⟺ μ = ±M` が単独では偽だった。**
   `θ_μ = 2πμ/M` に対し `sin θ_μ = 0 ⟺ M ∣ 2μ` であり（`sin_thetaMu_eq_zero_iff`）、
   `ℳ = {-M,…,-1,1,…,M}` の範囲では `M` が偶数のとき `μ = ±M/2`（`θ_μ = ±π`）も該当する。
   → **これも並行して原文側が修正済み**（本文にあったときに「連立条件全体としての同値」であること、
   `μ = ±M/2` が `c_2s_1 = -c_1 < 0` と `c_1, s_1, c_2 > 0` の矛盾で排除されることが明記され、参照用ノートにもその形のまま在る）。
   Lean 側の `sin_thetaMu_eq_zero_iff` はその機械的な裏づけとして残す。
-/
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic
import Mathlib.RingTheory.RootsOfUnity.Complex
import Mathlib.LinearAlgebra.Matrix.Notation
import Mathlib.LinearAlgebra.Matrix.NonsingularInverse
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimEulerFormulaCosSin
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimCosSinAndITimesAtNegatedReal
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimComplexConjugateOfSumProductDifference
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimExpOfNegativeIRealAsCosMinusISin
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesProduct
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesSum
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimRealSymmetricMatrixIsHermitian

namespace Ising2D

/-- 原文 `def_A_theta` に現れるモデル定数の組。
原文の対応は `c1 = c_1 = cosh(2K_1)`, `s1 = s_1 = sinh(2K_1)`, `c2 = c_2 = cosh(2K_2)`,
`c2star = c_2^* = cosh(2K_2^*)`, `s2star = s_2^* = sinh(2K_2^*)`。

ここでは `K_1, K_2` からの構成は行わず、5 個の実数として扱う。
`cosh^2 - sinh^2 = 1` などの関係は使う定理ごとに仮定として明示する。 -/
structure IsingConst where
  c1 : ℝ
  s1 : ℝ
  c2 : ℝ
  c2star : ℝ
  s2star : ℝ

variable (K : IsingConst) (θ : ℝ)

/-- `θ_μ := 2πμ/M`。人手は本文に無く、参照用ノート `integer_momentum_route_not_adopted.ts` の id の末尾が `TV1_hatZ_hatY_019_definition_theta_mu` の項目（本文にあったときのラベル `def_theta_mu`）に退避してある。
整数運動量の経路（`RoutesNotAdopted/IntegerMomentum/`）だけが使う。 -/
noncomputable def thetaMu (M : ℕ) (μ : ℤ) : ℝ := 2 * Real.pi * μ / M

/-- 人手 `def_gamma1_gamma2_of_theta` の `γ_1(θ) := c_1 c_2^* - s_1 s_2^* cos θ ∈ ℝ` の `ℝ → ℂ` の包含による像 `(γ_1(θ))_ℂ`。
人手 `def_gamma1_gamma2_of_theta` の主張の行列の `(1,1)`・`(2,2)` 成分は、`def_A_theta` の読みと同じくこの像である。
人手の実数 `γ_1(θ) ∈ ℝ` そのものは `gamma1R`（`ClaimGamma1LowerBound.lean`）で、`gamma1_eq_ofReal` が `gamma1 = ↑gamma1R` を述べる。 -/
noncomputable def gamma1 : ℂ := ((K.c1 * K.c2star - K.s1 * K.s2star * Real.cos θ : ℝ) : ℂ)

/-- 人手 `def_gamma1_gamma2_of_theta` の `γ_2(θ) := i e^{iθ} s_2^* (c_1 cos θ - i sin θ - s_1 c_2)`。 -/
noncomputable def gamma2 : ℂ :=
  Complex.I * Complex.exp (Complex.I * (θ : ℂ)) * (K.s2star : ℂ) *
    ((K.c1 : ℂ) * (Real.cos θ : ℂ) - Complex.I * (Real.sin θ : ℂ) - (K.s1 : ℂ) * (K.c2 : ℂ))

/-- 原文 `def_A_theta` の明示行列そのまま。人手の定義に書いた読みのとおり、`(1,1)`・`(2,2)` 成分は実数
`c_1c_2^* - s_1s_2^* cos θ` の像、`(1,2)`・`(2,1)` 成分は実数を `ℝ → ℂ` の包含で送った ℂ の式で、
`(2,1)` 成分の先頭の `-i` は `-Complex.I`、四つの因子の積は左から括る（Lean の `a * b * c * d` は `((a * b) * c) * d`）。
`(1,1)`・`(2,2)` 成分の実数は `(c_1c_2^*) - ((s_1s_2^*) cos θ)`（ℝ の積は左から括り、差は ℝ の差）、
`(1,2)`・`(2,1)` 成分の第四の因子は `((c_1 cos θ) ∓ (i sin θ)) - (s_1c_2)`（差は人手 `def_complex_difference`、
和と積は `definition_of_cc`）で、Lean の `a - b - c`・`a + b - c` も左から括る（Lean の ℂ の差は mathlib の定義で、
人手の `z + (-w)` とは `sub_eq_add_neg` で等しい）。`exp` は人手 `def_scalar_exp` の `K = ℂ` の
`exp`（Lean では `Complex.exp`）である。 -/
noncomputable def AMat : Matrix (Fin 2) (Fin 2) ℂ :=
  !![((K.c1 * K.c2star - K.s1 * K.s2star * Real.cos θ : ℝ) : ℂ),
      Complex.I * Complex.exp (Complex.I * (θ : ℂ)) * (K.s2star : ℂ) *
        ((K.c1 : ℂ) * (Real.cos θ : ℂ) - Complex.I * (Real.sin θ : ℂ) - (K.s1 : ℂ) * (K.c2 : ℂ));
    -Complex.I * Complex.exp (-(Complex.I * (θ : ℂ))) * (K.s2star : ℂ) *
        ((K.c1 : ℂ) * (Real.cos θ : ℂ) + Complex.I * (Real.sin θ : ℂ) - (K.s1 : ℂ) * (K.c2 : ℂ)),
      ((K.c1 * K.c2star - K.s1 * K.s2star * Real.cos θ : ℝ) : ℂ)]

/-! ## `γ_2(-θ)` を `θ` の量で書く

人手 `def_gamma1_gamma2_of_theta` の `(2,1)` 成分の `γ_2(-θ)` の鎖と、人手 `relation_of_gamma_2_theta_tilde` の「第三に」の鎖は同じ 6 行で、
どちらも主張 `i_times_negated_real_is_negation_of_i_times`・`cos_of_negated_real`・`sin_of_negated_real` を引く。
その具体版 `I_mul_real_neg_eq_neg_I_mul`・`real_inclusion_cos_neg`・`real_inclusion_sin_neg` は
`MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimCosSinAndITimesAtNegatedReal.lean` にある。 -/

/-- `γ_2(-θ)` の明示形。人手 `def_gamma1_gamma2_of_theta` の `(2,1)` 成分の `γ_2(-θ)` の 6 行の鎖、
および人手 `relation_of_gamma_2_theta_tilde` の証明の「第三に」の 6 行の鎖（同じ鎖）と 1 段ずつ対応する。 -/
theorem gamma2_neg :
    gamma2 K (-θ) = Complex.I * Complex.exp (-(Complex.I * (θ : ℂ))) * (K.s2star : ℂ) *
      ((K.c1 : ℂ) * (Real.cos θ : ℂ) + Complex.I * (Real.sin θ : ℂ) -
        (K.s1 : ℂ) * (K.c2 : ℂ)) :=
  calc gamma2 K (-θ)
      = Complex.I * Complex.exp (Complex.I * ((-θ : ℝ) : ℂ)) * (K.s2star : ℂ) *
          ((K.c1 : ℂ) * (Real.cos (-θ) : ℂ) - Complex.I * (Real.sin (-θ) : ℂ) - (K.s1 : ℂ) * (K.c2 : ℂ)) :=
        rfl                                       -- 1 行目: `def_gamma1_gamma2_of_theta` を `-θ ∈ ℝ` に適用
    _ = Complex.I * Complex.exp (-(Complex.I * (θ : ℂ))) * (K.s2star : ℂ) *
          ((K.c1 : ℂ) * (Real.cos (-θ) : ℂ) - Complex.I * (Real.sin (-θ) : ℂ) - (K.s1 : ℂ) * (K.c2 : ℂ)) := by
        rw [I_mul_real_neg_eq_neg_I_mul]          -- 2 行目: `i_times_negated_real_is_negation_of_i_times`
    _ = Complex.I * Complex.exp (-(Complex.I * (θ : ℂ))) * (K.s2star : ℂ) *
          ((K.c1 : ℂ) * (Real.cos θ : ℂ) - Complex.I * (Real.sin (-θ) : ℂ) - (K.s1 : ℂ) * (K.c2 : ℂ)) := by
        rw [real_inclusion_cos_neg]               -- 3 行目: `cos_of_negated_real`
    _ = Complex.I * Complex.exp (-(Complex.I * (θ : ℂ))) * (K.s2star : ℂ) *
          ((K.c1 : ℂ) * (Real.cos θ : ℂ) - Complex.I * (-(Real.sin θ : ℂ)) - (K.s1 : ℂ) * (K.c2 : ℂ)) := by
        rw [real_inclusion_sin_neg]               -- 4 行目: `sin_of_negated_real`
    _ = Complex.I * Complex.exp (-(Complex.I * (θ : ℂ))) * (K.s2star : ℂ) *
          ((K.c1 : ℂ) * (Real.cos θ : ℂ) - (-(Complex.I * (Real.sin θ : ℂ))) - (K.s1 : ℂ) * (K.c2 : ℂ)) := by
        rw [mul_neg]                              -- 5 行目: ℂ で `x(-y) = -(xy)`（`x → i`, `y → sin θ`）
    _ = Complex.I * Complex.exp (-(Complex.I * (θ : ℂ))) * (K.s2star : ℂ) *
          ((K.c1 : ℂ) * (Real.cos θ : ℂ) + Complex.I * (Real.sin θ : ℂ) - (K.s1 : ℂ) * (K.c2 : ℂ)) := by
        rw [sub_neg_eq_add]                       -- 6 行目: ℂ で `a - (-b) = a + b`（`a → c_1cos θ`, `b → i sin θ`）

/-- 人手 `def_gamma1_gamma2_of_theta` の `A(θ)_{2,1}` の 5 行の鎖。`def_A_theta` の定義に書いた読みのとおり、先頭の `-i` は
`multiply_by_minus_one` の `-i`、積は左から括る（Lean の `-Complex.I * e * s * P` は `(((-I) * e) * s) * P` と読まれる）。
人手の `(-x)y = -(xy)`（ℂ は体）は具体版が Lean に無く、mathlib の `neg_mul` で 1 回ずつ受ける。 -/
theorem AMat_two_one_eq_neg_gamma2_neg : AMat K θ 1 0 = -gamma2 K (-θ) :=
  calc AMat K θ 1 0
      = (-Complex.I) * Complex.exp (-(Complex.I * (θ : ℂ))) * (K.s2star : ℂ) *
          ((K.c1 : ℂ) * (Real.cos θ : ℂ) + Complex.I * (Real.sin θ : ℂ) - (K.s1 : ℂ) * (K.c2 : ℂ)) :=
        rfl                                       -- 1 行目: `def_A_theta`
    _ = (-(Complex.I * Complex.exp (-(Complex.I * (θ : ℂ))))) * (K.s2star : ℂ) *
          ((K.c1 : ℂ) * (Real.cos θ : ℂ) + Complex.I * (Real.sin θ : ℂ) - (K.s1 : ℂ) * (K.c2 : ℂ)) := by
        rw [neg_I_mul_eq_neg_of_I_mul]            -- 2 行目: `negative_i_times_complex_is_negation_of_i_times`（`z → exp(-iθ)`）
    _ = (-(Complex.I * Complex.exp (-(Complex.I * (θ : ℂ))) * (K.s2star : ℂ))) *
          ((K.c1 : ℂ) * (Real.cos θ : ℂ) + Complex.I * (Real.sin θ : ℂ) - (K.s1 : ℂ) * (K.c2 : ℂ)) := by
        rw [neg_mul]                              -- 3 行目: ℂ で `(-x)y = -(xy)`（`x → i exp(-iθ)`, `y → s_2^*`）
    _ = -(Complex.I * Complex.exp (-(Complex.I * (θ : ℂ))) * (K.s2star : ℂ) *
          ((K.c1 : ℂ) * (Real.cos θ : ℂ) + Complex.I * (Real.sin θ : ℂ) - (K.s1 : ℂ) * (K.c2 : ℂ))) := by
        rw [neg_mul]                              -- 4 行目: ℂ で `(-x)y = -(xy)`（`x → (i exp(-iθ))s_2^*`, `y → P`）
    _ = -gamma2 K (-θ) := by
        rw [gamma2_neg]                           -- 5 行目: 上の `γ_2(-θ)` の鎖を右辺から左辺へ

/-- 人手 `def_gamma1_gamma2_of_theta` の主張 `A(θ) = !![γ_1(θ), γ_2(θ); -γ_2(-θ), γ_1(θ)]`。
`(1,1)`・`(2,2)` 成分（実数 `γ_1(θ)` の像）と `(1,2)` 成分は人手どおり定義そのもの（`rfl`）、`(2,1)` 成分は `AMat_two_one_eq_neg_gamma2_neg`。 -/
theorem AMat_eq : AMat K θ = !![gamma1 K θ, gamma2 K θ; -gamma2 K (-θ), gamma1 K θ] := by
  ext i j
  fin_cases i <;> fin_cases j
  · rfl                                           -- `(1,1)` 成分: 実数 `γ_1(θ)` の像（`def_A_theta` の読み）。定義そのもの
  · rfl                                           -- `(1,2)` 成分: `γ_2(θ)` の定義そのもの
  · exact AMat_two_one_eq_neg_gamma2_neg K θ      -- `(2,1)` 成分
  · rfl                                           -- `(2,2)` 成分: 実数 `γ_1(θ)` の像（`def_A_theta` の読み）。定義そのもの

/-! ## `γ_2` の対称性

本文の対応は `relation_of_gamma_2_theta_tilde`。本文にあったときのラベル `relation_of_gamma_2` の項目（`θ_μ` について述べた形）は
参照用ノート `integer_momentum_route_not_adopted.ts` の id の末尾が `TV1_hatZ_hatY_023_claim_relation_of_gamma2` の項目に退避してある。 -/

/-! ### 人手 `relation_of_gamma_2_theta_tilde` の「第一に」の `exp(iθ)` の表示と「第二に」「第四に」「(1)」

人手の複素共役 `def_complex_conjugate` は Lean の `starRingEnd ℂ`（`star` と定義で一致する）である。
人手 `complex_conjugate_of_sum`（`m = 2`）・`complex_conjugate_of_product`・`complex_conjugate_of_difference` は具体版
`complex_conjugate_of_sum_two`・`complex_conjugate_of_product_eq`・`complex_conjugate_of_difference_eq`
（`MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimComplexConjugateOfSumProductDifference.lean`）で受ける。各段は 1 回だけ当てる。
人手 `exp_of_negative_i_real_as_cos_minus_i_sin` の具体版は同じフォルダの `ClaimExpOfNegativeIRealAsCosMinusISin.lean` の
`exp_neg_I_mul_real_eq_cos_sub_I_mul_sin` である。
人手 `multiply_by_minus_one`（`-z := (-1)z`）も具体版が Lean に無く、mathlib の `neg_one_mul` で受ける（このファイルのほかの段と同じ）。 -/

/-- 人手 `relation_of_gamma_2_theta_tilde` の「第一に」の最後の鎖: `cos θ + i sin θ = exp(iθ)`（人手の 22 行）。
人手 `periodicity_of_check_fermi` の準備の第一の鎖（`θ` を `x` と書いた同じ 22 行）もこの補題で受ける。
分母の `2`・`2i` は `2_ℂ`・`2_ℂi`（Lean の `(2 : ℂ)`・`(2 : ℂ) * Complex.I`）、`1_ℂ` は `inclusion_rr_to_cc` の像 `(1)_ℂ` の略記で、
行き来は略記の読み替えの段で行う。人手 `def_complex_quotient`（`z/w := zw^{-1}`）は mathlib の `div_eq_mul_inv`、
`multiplicative_group_of_cc` の逆元（`ww^{-1} = 1_ℂ`）は `mul_inv_cancel₀` で受け、
`euler_formula_cos_sin` の主張の `2_ℂ ∈ ℂ^×`（成分の比較）は `complex_two_ne_zero_by_re` である。
6 行目の人手 `i_times_inverse_of_two_i_is_inverse_of_two_in_cc`（`i(2_ℂi)^{-1} = 2_ℂ^{-1}`）は `complex_I_mul_inv_two_mul_I`
（`MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimITimesInverseOfTwoIIsInverseOfTwoInCC.lean`）である。 -/
theorem real_inclusion_cos_add_I_mul_sin (θ : ℝ) :
    ((Real.cos θ : ℝ) : ℂ) + Complex.I * ((Real.sin θ : ℝ) : ℂ) = Complex.exp (Complex.I * (θ : ℂ)) := by
  set eP : ℂ := Complex.exp (Complex.I * (θ : ℂ)) with heP
  set eM : ℂ := Complex.exp (-(Complex.I * (θ : ℂ))) with heM
  have h2 : (2 : ℂ) ≠ 0 := complex_two_ne_zero_by_re
  calc ((Real.cos θ : ℝ) : ℂ) + Complex.I * ((Real.sin θ : ℝ) : ℂ)
      = (eP + eM) / 2 + Complex.I * ((eP - eM) / (2 * Complex.I)) := by
        rw [euler_cos_real_inclusion θ, euler_sin_real_inclusion θ]  -- 1 行目: `euler_formula_cos_sin`
    _ = (eP + eM) * (2 : ℂ)⁻¹ + Complex.I * ((eP - eM) * ((2 : ℂ) * Complex.I)⁻¹) := by
        rw [div_eq_mul_inv, div_eq_mul_inv]       -- 2 行目: `def_complex_quotient` を 2 箇所へ（`w → 2_ℂ`・`w → 2_ℂi`）
    _ = (eP + eM) * (2 : ℂ)⁻¹ + (Complex.I * (eP - eM)) * ((2 : ℂ) * Complex.I)⁻¹ := by
        rw [← mul_assoc Complex.I (eP - eM)]      -- 3 行目: `complex_numbers_form_a_field` の積の結合律を右辺から左辺へ
    _ = (eP + eM) * (2 : ℂ)⁻¹ + ((eP - eM) * Complex.I) * ((2 : ℂ) * Complex.I)⁻¹ := by
        rw [mul_comm Complex.I (eP - eM)]         -- 4 行目: `complex_numbers_form_a_field` の積の可換律
    _ = (eP + eM) * (2 : ℂ)⁻¹ + (eP - eM) * (Complex.I * ((2 : ℂ) * Complex.I)⁻¹) := by
        rw [mul_assoc (eP - eM) Complex.I]        -- 5 行目: `complex_numbers_form_a_field` の積の結合律
    _ = (eP + eM) * (2 : ℂ)⁻¹ + (eP - eM) * (2 : ℂ)⁻¹ := by
        rw [complex_I_mul_inv_two_mul_I]          -- 6 行目: `i_times_inverse_of_two_i_is_inverse_of_two_in_cc`
    _ = ((eP + eM) + (eP - eM)) * (2 : ℂ)⁻¹ := by
        rw [← add_mul]                            -- 7 行目: `complex_numbers_form_a_field` の右からの分配律を右辺から左辺へ
    _ = ((eP + eM) + (eP + -eM)) * (2 : ℂ)⁻¹ := by
        rw [sub_eq_add_neg]                       -- 8 行目: `def_complex_difference`
    _ = (eP + (eM + (eP + -eM))) * (2 : ℂ)⁻¹ := by
        rw [add_assoc eP eM]                      -- 9 行目: `complex_numbers_form_a_field` の和の結合律
    _ = (eP + ((eM + eP) + -eM)) * (2 : ℂ)⁻¹ := by
        rw [← add_assoc eM eP]                    -- 10 行目: `complex_numbers_form_a_field` の和の結合律を右辺から左辺へ
    _ = (eP + ((eP + eM) + -eM)) * (2 : ℂ)⁻¹ := by
        rw [add_comm eM eP]                       -- 11 行目: `complex_numbers_form_a_field` の和の可換律
    _ = (eP + (eP + (eM + -eM))) * (2 : ℂ)⁻¹ := by
        rw [add_assoc eP eM]                      -- 12 行目: `complex_numbers_form_a_field` の和の結合律
    _ = (eP + (eP + 0)) * (2 : ℂ)⁻¹ := by
        rw [add_neg_cancel]                       -- 13 行目: `complex_numbers_form_a_field` の加法逆元
    _ = (eP + eP) * (2 : ℂ)⁻¹ := by
        rw [add_zero]                             -- 14 行目: `complex_numbers_form_a_field` の零元
    _ = (1 * eP + 1 * eP) * (2 : ℂ)⁻¹ := by
        rw [one_mul]                              -- 15 行目: `complex_numbers_form_a_field` の積の単位元を 2 箇所へ右辺から左辺へ
    _ = ((1 + 1) * eP) * (2 : ℂ)⁻¹ := by
        rw [add_mul (1 : ℂ) 1 eP]                 -- 16 行目: `complex_numbers_form_a_field` の右からの分配律を右辺から左辺へ
    _ = ((((1 : ℝ) : ℂ) + ((1 : ℝ) : ℂ)) * eP) * (2 : ℂ)⁻¹ := by
        rw [Complex.ofReal_one]                   -- `1_ℂ` を `(1)_ℂ` と読む（`inclusion_rr_to_cc` の略記）
    _ = ((((1 + 1 : ℝ)) : ℂ) * eP) * (2 : ℂ)⁻¹ := by
        rw [real_inclusion_add]                   -- 17 行目: `real_inclusion_preserves_sum`（`a → 1`, `b → 1`）
    _ = ((((2 : ℝ)) : ℂ) * eP) * (2 : ℂ)⁻¹ := by
        rw [one_add_one_eq_two]                   -- 18 行目: ℝ で `1 + 1 = 2`
    _ = ((2 : ℂ) * eP) * (2 : ℂ)⁻¹ := by
        rw [Complex.ofReal_ofNat]                 -- `(2)_ℂ` を `2_ℂ` と書く（`inclusion_rr_to_cc` の略記）
    _ = (eP * (2 : ℂ)) * (2 : ℂ)⁻¹ := by
        rw [mul_comm (2 : ℂ) eP]                  -- 19 行目: `complex_numbers_form_a_field` の積の可換律
    _ = eP * ((2 : ℂ) * (2 : ℂ)⁻¹) := by
        rw [mul_assoc eP]                         -- 20 行目: `complex_numbers_form_a_field` の積の結合律
    _ = eP * 1 := by
        rw [mul_inv_cancel₀ h2]                   -- 21 行目: `multiplicative_group_of_cc` の逆元（`2_ℂ ∈ ℂ^×`）
    _ = eP := by
        rw [mul_one]                              -- 22 行目: `complex_numbers_form_a_field` の積の単位元

/-- 人手 `complex_conjugate_of_real_inclusion` を `starRingEnd ℂ` の形で読んだもの（`starRingEnd ℂ z` は `star z` と定義で一致する）。 -/
theorem conj_real_inclusion (r : ℝ) : (starRingEnd ℂ) (r : ℂ) = (r : ℂ) :=
  complex_conjugate_of_real_inclusion r

/-- 準備の「`c_1cos θ`・`s_1c_2` も実数の像である」を通した `complex_conjugate_of_real_inclusion`:
`\overline{a_ℂ b_ℂ} = a_ℂ b_ℂ`。1・3 段目は `real_inclusion_preserves_product` による読み替えで、人手は像の記号を省くので行を持たない。 -/
theorem conj_real_inclusion_mul (a b : ℝ) :
    (starRingEnd ℂ) ((a : ℂ) * (b : ℂ)) = (a : ℂ) * (b : ℂ) :=
  calc (starRingEnd ℂ) ((a : ℂ) * (b : ℂ))
      = (starRingEnd ℂ) ((a * b : ℝ) : ℂ) := by
        rw [real_inclusion_mul]                   -- 準備の読み: `real_inclusion_preserves_product`
    _ = ((a * b : ℝ) : ℂ) := conj_real_inclusion (a * b)
                                                  -- `complex_conjugate_of_real_inclusion`
    _ = (a : ℂ) * (b : ℂ) := (real_inclusion_mul a b).symm
                                                  -- 準備の読み: `real_inclusion_preserves_product`

/-- 人手 `relation_of_gamma_2_theta_tilde` の「第二に」の `\bar i = -i`（人手の 6 行と、略記の読み替えの 1 段）。 -/
theorem conj_I_eq_neg_I : (starRingEnd ℂ) Complex.I = -Complex.I :=
  calc (starRingEnd ℂ) Complex.I
      = (starRingEnd ℂ) (⟨0, 1⟩ : ℂ) := rfl       -- 1 行目: `def_imaginary_unit` の `i := (0,1)`
    _ = (⟨0, -1⟩ : ℂ) := Complex.ext (Complex.conj_re _) (Complex.conj_im _)
                                                  -- 2 行目: `def_complex_conjugate`
    _ = (⟨-1, 0⟩ : ℂ) * (⟨0, 1⟩ : ℂ) :=
        Complex.ext (by simp [Complex.mul_re]) (by simp [Complex.mul_im])
                                                  -- 3 行目: `definition_of_cc` の積 `((-1)·0 - 0·1, (-1)·1 + 0·0)`
                                                  -- （成分の ℝ の四則は `simp` で閉じる）
    _ = ((-1 : ℝ) : ℂ) * (⟨0, 1⟩ : ℂ) := rfl     -- 4 行目: `inclusion_rr_to_cc` の `(-1)_ℂ = (-1,0)`
    _ = (-1 : ℂ) * (⟨0, 1⟩ : ℂ) := by
        rw [Complex.ofReal_neg, Complex.ofReal_one] -- `(-1)_ℂ` を `-1_ℂ` と書く（`inclusion_rr_to_cc` の略記）
    _ = (-1 : ℂ) * Complex.I := rfl               -- 5 行目: `def_imaginary_unit` の `i := (0,1)`
    _ = -Complex.I := by
        rw [neg_one_mul]                          -- 6 行目: `multiply_by_minus_one`

/-- 人手 `relation_of_gamma_2_theta_tilde` の「第二に」の `\overline{exp(iθ)} = exp(-iθ)`（人手の 8 行）。 -/
theorem conj_exp_I_mul_real (θ : ℝ) :
    (starRingEnd ℂ) (Complex.exp (Complex.I * (θ : ℂ))) = Complex.exp (-(Complex.I * (θ : ℂ))) :=
  calc (starRingEnd ℂ) (Complex.exp (Complex.I * (θ : ℂ)))
      = (starRingEnd ℂ) (((Real.cos θ : ℝ) : ℂ) + Complex.I * ((Real.sin θ : ℝ) : ℂ)) := by
        rw [real_inclusion_cos_add_I_mul_sin]     -- 1 行目: 上の `exp(iθ)` の表示
    _ = (starRingEnd ℂ) ((Real.cos θ : ℝ) : ℂ) + (starRingEnd ℂ) (Complex.I * ((Real.sin θ : ℝ) : ℂ)) := by
        rw [complex_conjugate_of_sum_two]         -- 2 行目: `complex_conjugate_of_sum` を `m = 2` で
    _ = (starRingEnd ℂ) ((Real.cos θ : ℝ) : ℂ)
          + (starRingEnd ℂ) Complex.I * (starRingEnd ℂ) ((Real.sin θ : ℝ) : ℂ) := by
        rw [complex_conjugate_of_product_eq]      -- 3 行目: `complex_conjugate_of_product`
    _ = ((Real.cos θ : ℝ) : ℂ) + (starRingEnd ℂ) Complex.I * ((Real.sin θ : ℝ) : ℂ) := by
        rw [conj_real_inclusion (Real.cos θ), conj_real_inclusion (Real.sin θ)]
                                                  -- 4 行目: `complex_conjugate_of_real_inclusion` を 2 箇所へ
    _ = ((Real.cos θ : ℝ) : ℂ) + (-Complex.I) * ((Real.sin θ : ℝ) : ℂ) := by
        rw [conj_I_eq_neg_I]                      -- 5 行目: 上の `\bar i = -i`
    _ = ((Real.cos θ : ℝ) : ℂ) + -(Complex.I * ((Real.sin θ : ℝ) : ℂ)) := by
        rw [neg_mul]                              -- 6 行目: ℂ で `(-x)y = -(xy)`（`x → i`, `y → sin θ`）
    _ = ((Real.cos θ : ℝ) : ℂ) - Complex.I * ((Real.sin θ : ℝ) : ℂ) := by
        rw [← sub_eq_add_neg]                     -- 7 行目: `def_complex_difference` を右辺から左辺へ
    _ = Complex.exp (-(Complex.I * (θ : ℂ))) :=
        (exp_neg_I_mul_real_eq_cos_sub_I_mul_sin θ).symm
                                                  -- 8 行目: `exp_of_negative_i_real_as_cos_minus_i_sin`

/-- 人手 `relation_of_gamma_2_theta_tilde` の「第四に」: `\overline{γ_2(θ)} = -γ_2(-θ)`（人手の 18 行）。
人手の `i exp(iθ) s_2^* (…)` は左から積を取る読みで、Lean の `gamma2` の `((i * e) * s) * X` と同じ括弧である。 -/
theorem conj_gamma2_eq_neg_gamma2_neg :
    (starRingEnd ℂ) (gamma2 K θ) = -gamma2 K (-θ) :=
  calc (starRingEnd ℂ) (gamma2 K θ)
      = (starRingEnd ℂ) (Complex.I * Complex.exp (Complex.I * (θ : ℂ)) * (K.s2star : ℂ) *
          ((K.c1 : ℂ) * (Real.cos θ : ℂ) - Complex.I * (Real.sin θ : ℂ) - (K.s1 : ℂ) * (K.c2 : ℂ))) :=
        rfl                                       -- 1 行目: `def_gamma1_gamma2_of_theta`
    _ = (starRingEnd ℂ) (Complex.I * Complex.exp (Complex.I * (θ : ℂ)) * (K.s2star : ℂ)) *
          (starRingEnd ℂ)
            ((K.c1 : ℂ) * (Real.cos θ : ℂ) - Complex.I * (Real.sin θ : ℂ) - (K.s1 : ℂ) * (K.c2 : ℂ)) := by
        rw [complex_conjugate_of_product_eq]      -- 2 行目: `complex_conjugate_of_product`
    _ = (starRingEnd ℂ) (Complex.I * Complex.exp (Complex.I * (θ : ℂ))) * (starRingEnd ℂ) (K.s2star : ℂ) *
          (starRingEnd ℂ)
            ((K.c1 : ℂ) * (Real.cos θ : ℂ) - Complex.I * (Real.sin θ : ℂ) - (K.s1 : ℂ) * (K.c2 : ℂ)) := by
        rw [complex_conjugate_of_product_eq (Complex.I * Complex.exp (Complex.I * (θ : ℂ)))]
                                                  -- 3 行目: `complex_conjugate_of_product`
    _ = (starRingEnd ℂ) Complex.I * (starRingEnd ℂ) (Complex.exp (Complex.I * (θ : ℂ))) *
          (starRingEnd ℂ) (K.s2star : ℂ) *
          (starRingEnd ℂ)
            ((K.c1 : ℂ) * (Real.cos θ : ℂ) - Complex.I * (Real.sin θ : ℂ) - (K.s1 : ℂ) * (K.c2 : ℂ)) := by
        rw [complex_conjugate_of_product_eq Complex.I (Complex.exp (Complex.I * (θ : ℂ)))]
                                                  -- 4 行目: `complex_conjugate_of_product`
    _ = (-Complex.I) * (starRingEnd ℂ) (Complex.exp (Complex.I * (θ : ℂ))) *
          (starRingEnd ℂ) (K.s2star : ℂ) *
          (starRingEnd ℂ)
            ((K.c1 : ℂ) * (Real.cos θ : ℂ) - Complex.I * (Real.sin θ : ℂ) - (K.s1 : ℂ) * (K.c2 : ℂ)) := by
        rw [conj_I_eq_neg_I]                      -- 5 行目: 上の `\bar i = -i`
    _ = (-Complex.I) * Complex.exp (-(Complex.I * (θ : ℂ))) * (starRingEnd ℂ) (K.s2star : ℂ) *
          (starRingEnd ℂ)
            ((K.c1 : ℂ) * (Real.cos θ : ℂ) - Complex.I * (Real.sin θ : ℂ) - (K.s1 : ℂ) * (K.c2 : ℂ)) := by
        rw [conj_exp_I_mul_real]                  -- 6 行目: 上の `\overline{exp(iθ)} = exp(-iθ)`
    _ = (-Complex.I) * Complex.exp (-(Complex.I * (θ : ℂ))) * (K.s2star : ℂ) *
          (starRingEnd ℂ)
            ((K.c1 : ℂ) * (Real.cos θ : ℂ) - Complex.I * (Real.sin θ : ℂ) - (K.s1 : ℂ) * (K.c2 : ℂ)) := by
        rw [conj_real_inclusion K.s2star]         -- 7 行目: `complex_conjugate_of_real_inclusion`
    _ = (-Complex.I) * Complex.exp (-(Complex.I * (θ : ℂ))) * (K.s2star : ℂ) *
          ((starRingEnd ℂ) ((K.c1 : ℂ) * (Real.cos θ : ℂ) - Complex.I * (Real.sin θ : ℂ))
            - (starRingEnd ℂ) ((K.s1 : ℂ) * (K.c2 : ℂ))) := by
        rw [complex_conjugate_of_difference_eq]   -- 8 行目: `complex_conjugate_of_difference`
    _ = (-Complex.I) * Complex.exp (-(Complex.I * (θ : ℂ))) * (K.s2star : ℂ) *
          ((starRingEnd ℂ) ((K.c1 : ℂ) * (Real.cos θ : ℂ)) - (starRingEnd ℂ) (Complex.I * (Real.sin θ : ℂ))
            - (starRingEnd ℂ) ((K.s1 : ℂ) * (K.c2 : ℂ))) := by
        rw [complex_conjugate_of_difference_eq ((K.c1 : ℂ) * (Real.cos θ : ℂ))]
                                                  -- 9 行目: `complex_conjugate_of_difference`
    _ = (-Complex.I) * Complex.exp (-(Complex.I * (θ : ℂ))) * (K.s2star : ℂ) *
          ((starRingEnd ℂ) ((K.c1 : ℂ) * (Real.cos θ : ℂ))
            - (starRingEnd ℂ) Complex.I * (starRingEnd ℂ) (Real.sin θ : ℂ)
            - (starRingEnd ℂ) ((K.s1 : ℂ) * (K.c2 : ℂ))) := by
        rw [complex_conjugate_of_product_eq Complex.I] -- 10 行目: `complex_conjugate_of_product`
    _ = (-Complex.I) * Complex.exp (-(Complex.I * (θ : ℂ))) * (K.s2star : ℂ) *
          ((K.c1 : ℂ) * (Real.cos θ : ℂ) - (starRingEnd ℂ) Complex.I * (Real.sin θ : ℂ)
            - (K.s1 : ℂ) * (K.c2 : ℂ)) := by
        rw [conj_real_inclusion_mul K.c1 (Real.cos θ), conj_real_inclusion (Real.sin θ),
          conj_real_inclusion_mul K.s1 K.c2]      -- 11 行目: `complex_conjugate_of_real_inclusion` を 3 箇所へ
    _ = (-Complex.I) * Complex.exp (-(Complex.I * (θ : ℂ))) * (K.s2star : ℂ) *
          ((K.c1 : ℂ) * (Real.cos θ : ℂ) - (-Complex.I) * (Real.sin θ : ℂ) - (K.s1 : ℂ) * (K.c2 : ℂ)) := by
        rw [conj_I_eq_neg_I]                      -- 12 行目: 上の `\bar i = -i`
    _ = (-Complex.I) * Complex.exp (-(Complex.I * (θ : ℂ))) * (K.s2star : ℂ) *
          ((K.c1 : ℂ) * (Real.cos θ : ℂ) - (-(Complex.I * (Real.sin θ : ℂ))) - (K.s1 : ℂ) * (K.c2 : ℂ)) := by
        rw [neg_mul Complex.I (Real.sin θ : ℂ)]   -- 13 行目: ℂ で `(-x)y = -(xy)`（`x → i`, `y → sin θ`）
    _ = (-Complex.I) * Complex.exp (-(Complex.I * (θ : ℂ))) * (K.s2star : ℂ) *
          ((K.c1 : ℂ) * (Real.cos θ : ℂ) + Complex.I * (Real.sin θ : ℂ) - (K.s1 : ℂ) * (K.c2 : ℂ)) := by
        rw [sub_neg_eq_add]                       -- 14 行目: ℂ で `a - (-b) = a + b`（`a → c_1cos θ`, `b → i sin θ`）
    _ = (-(Complex.I * Complex.exp (-(Complex.I * (θ : ℂ))))) * (K.s2star : ℂ) *
          ((K.c1 : ℂ) * (Real.cos θ : ℂ) + Complex.I * (Real.sin θ : ℂ) - (K.s1 : ℂ) * (K.c2 : ℂ)) := by
        rw [neg_mul Complex.I (Complex.exp (-(Complex.I * (θ : ℂ))))]
                                                  -- 15 行目: ℂ で `(-x)y = -(xy)`（`x → i`, `y → exp(-iθ)`）
    _ = (-(Complex.I * Complex.exp (-(Complex.I * (θ : ℂ))) * (K.s2star : ℂ))) *
          ((K.c1 : ℂ) * (Real.cos θ : ℂ) + Complex.I * (Real.sin θ : ℂ) - (K.s1 : ℂ) * (K.c2 : ℂ)) := by
        rw [neg_mul (Complex.I * Complex.exp (-(Complex.I * (θ : ℂ)))) (K.s2star : ℂ)]
                                                  -- 16 行目: ℂ で `(-x)y = -(xy)`（`x → i exp(-iθ)`, `y → s_2^*`）
    _ = -(Complex.I * Complex.exp (-(Complex.I * (θ : ℂ))) * (K.s2star : ℂ) *
          ((K.c1 : ℂ) * (Real.cos θ : ℂ) + Complex.I * (Real.sin θ : ℂ) - (K.s1 : ℂ) * (K.c2 : ℂ))) := by
        rw [neg_mul]                              -- 17 行目: ℂ で `(-x)y = -(xy)`（`x → i exp(-iθ) s_2^*`）
    _ = -gamma2 K (-θ) := by
        rw [gamma2_neg]                           -- 18 行目: 上の `γ_2(-θ)` の表示（「第三に」）

/-- 人手 `relation_of_gamma_2_theta_tilde` (1) の証明の鎖（人手の略記 `θ := θ~_μ` のもと）: `γ_2(-θ) = -conj(γ_2(θ))`（人手の 2 行）。
主張 (1) の具体版は `EigenvalueProblem/DiagonalizationAndExponentialForm/ClaimRelationGamma2Tilde.lean` の `gamma2_neg_thetaTilde_eq`（この定理の特殊化）。
参照用ノート `integer_momentum_route_not_adopted.ts` の id の末尾が `TV1_hatZ_hatY_023_claim_relation_of_gamma2` の項目（本文にあったときのラベル `relation_of_gamma_2`）の前半も同じ形である。 -/
theorem gamma2_neg_eq_neg_conj :
    gamma2 K (-θ) = -(starRingEnd ℂ) (gamma2 K θ) :=
  calc gamma2 K (-θ)
      = -(-gamma2 K (-θ)) := (neg_neg _).symm     -- 1 行目: ℂ で `-(-z) = z`（`z → γ_2(-θ)`）を右辺から左辺へ
    _ = -(starRingEnd ℂ) (gamma2 K θ) := by
        rw [conj_gamma2_eq_neg_gamma2_neg]        -- 2 行目: 上の `\overline{γ_2(θ)} = -γ_2(-θ)`

/-- `γ_2(θ) γ_2(-θ) = -|γ_2(θ)|^2`（`|γ_2(θ)|^2` は `Complex.normSq`）。人手は本文に無く、参照用ノート `integer_momentum_route_not_adopted.ts` の id の末尾が `TV1_hatZ_hatY_023_claim_relation_of_gamma2` の項目
（本文にあったときのラベル `relation_of_gamma_2`）の「ゆえに」の行である。本文の対応する主張 `relation_of_gamma_2_theta_tilde` (2) の具体版は
`EigenvalueProblem/DiagonalizationAndExponentialForm/ClaimRelationGamma2Tilde.lean` の `gamma2_mul_gamma2_neg_eq_neg_absSq`。 -/
theorem gamma2_mul_gamma2_neg_eq_neg_normSq :
    gamma2 K θ * gamma2 K (-θ) = -((Complex.normSq (gamma2 K θ) : ℝ) : ℂ) := by
  rw [gamma2_neg_eq_neg_conj]
  rw [mul_neg, Complex.mul_conj]

/-- `γ_2(θ) = 0 ⟺ γ_2(-θ) = 0`。人手に対応するラベルは無い補助の系。参照用ノート `integer_momentum_route_not_adopted.ts` の id の末尾が `TV1_hatZ_hatY_027_claim_eigenvector_A_theta` の項目
（本文にあったときのラベル `eigenvector_of_A_theta`）の場合分け 1) で使われていた。
本文の経路では、`EigenvalueProblem/DiagonalizationAndExponentialForm/ClaimGamma2TildeNonzero.lean` の `gamma2_neg_thetaTilde_ne_zero`
（人手 `gamma_2_theta_tilde_nonzero` の主張の末尾が「後で共役関係から導く」とした `γ_2(-θ~_μ) ≠ 0`。人手はそれを `relation_of_gamma_2_theta_tilde` の主張の末尾で示す）と `ClaimAnticommutatorCheckPsi.lean`・`DefinitionCheckFermi.lean` が使う。 -/
theorem gamma2_neg_eq_zero_iff : gamma2 K (-θ) = 0 ↔ gamma2 K θ = 0 := by
  rw [gamma2_neg_eq_neg_conj, neg_eq_zero, map_eq_zero]

/-! ## `γ_2` の周期性

人手 `periodicity_of_check_fermi` の (1) の `γ_2` 側。後段（`DefinitionCheckFermi.lean` の (2)・(3)、
整数運動量の経路の `δ^M_{μ+ν,0}` の場面）で使う。 -/

/-- 人手 `periodicity_of_check_fermi` が前提とする全実数上の `cos` の `2π` 周期性
（`x ∈ ℝ`、`n ∈ ℤ` について `cos(x + 2π n_ℝ) = cos x`）。人手は全実数上の `cos` を未整備の前提として置くので、
mathlib の `Real.cos_add_int_mul_two_pi`（角度は `n_ℝ (2π)` の順）で受け、積の順を `2π n_ℝ` に揃える。 -/
theorem real_cos_add_two_pi_mul_int (x : ℝ) (n : ℤ) :
    Real.cos (x + 2 * Real.pi * (n : ℝ)) = Real.cos x := by
  rw [mul_comm (2 * Real.pi) (n : ℝ)]
  exact Real.cos_add_int_mul_two_pi x n

/-- 同じく前提の `sin` の `2π` 周期性（`sin(x + 2π n_ℝ) = sin x`）。 -/
theorem real_sin_add_two_pi_mul_int (x : ℝ) (n : ℤ) :
    Real.sin (x + 2 * Real.pi * (n : ℝ)) = Real.sin x := by
  rw [mul_comm (2 * Real.pi) (n : ℝ)]
  exact Real.sin_add_int_mul_two_pi x n

/-- 人手 `periodicity_of_check_fermi` (1) の `γ_2` 側: `γ_2(θ + 2π k_ℝ) = γ_2(θ)`（人手の 6 行）。
2・5 行目の「準備の `exp(ix)` の表示」は、人手の準備の「第一に」の最後の鎖 `cos x + i sin x = exp(ix)`
（`relation_of_gamma_2_theta_tilde` の「第一に」の最後の鎖と同じ 22 行）の具体版 `real_inclusion_cos_add_I_mul_sin` である。 -/
theorem gamma2_add_two_pi_mul_int (k : ℤ) :
    gamma2 K (θ + 2 * Real.pi * (k : ℝ)) = gamma2 K θ :=
  calc gamma2 K (θ + 2 * Real.pi * (k : ℝ))
      = Complex.I * Complex.exp (Complex.I * ((θ + 2 * Real.pi * (k : ℝ) : ℝ) : ℂ)) * (K.s2star : ℂ) *
          ((K.c1 : ℂ) * (Real.cos (θ + 2 * Real.pi * (k : ℝ)) : ℂ)
            - Complex.I * (Real.sin (θ + 2 * Real.pi * (k : ℝ)) : ℂ) - (K.s1 : ℂ) * (K.c2 : ℂ)) := by
        rw [gamma2]                               -- 1 行目: `def_gamma1_gamma2_of_theta` を `θ + 2π k_ℝ` に適用
    _ = Complex.I * (((Real.cos (θ + 2 * Real.pi * (k : ℝ)) : ℝ) : ℂ)
            + Complex.I * ((Real.sin (θ + 2 * Real.pi * (k : ℝ)) : ℝ) : ℂ)) * (K.s2star : ℂ) *
          ((K.c1 : ℂ) * (Real.cos (θ + 2 * Real.pi * (k : ℝ)) : ℂ)
            - Complex.I * (Real.sin (θ + 2 * Real.pi * (k : ℝ)) : ℂ) - (K.s1 : ℂ) * (K.c2 : ℂ)) := by
        rw [real_inclusion_cos_add_I_mul_sin (θ + 2 * Real.pi * (k : ℝ))]
                                                  -- 2 行目: 準備の `exp(ix)` の表示を `x = θ + 2π k_ℝ` で
    _ = Complex.I * (((Real.cos θ : ℝ) : ℂ)
            + Complex.I * ((Real.sin (θ + 2 * Real.pi * (k : ℝ)) : ℝ) : ℂ)) * (K.s2star : ℂ) *
          ((K.c1 : ℂ) * (Real.cos θ : ℂ)
            - Complex.I * (Real.sin (θ + 2 * Real.pi * (k : ℝ)) : ℂ) - (K.s1 : ℂ) * (K.c2 : ℂ)) := by
        rw [real_cos_add_two_pi_mul_int θ k]      -- 3 行目: `cos` の `2π` 周期性を `n = k` で 2 箇所へ同時適用
    _ = Complex.I * (((Real.cos θ : ℝ) : ℂ) + Complex.I * ((Real.sin θ : ℝ) : ℂ)) * (K.s2star : ℂ) *
          ((K.c1 : ℂ) * (Real.cos θ : ℂ) - Complex.I * (Real.sin θ : ℂ) - (K.s1 : ℂ) * (K.c2 : ℂ)) := by
        rw [real_sin_add_two_pi_mul_int θ k]      -- 4 行目: `sin` の `2π` 周期性を `n = k` で 2 箇所へ同時適用
    _ = Complex.I * Complex.exp (Complex.I * (θ : ℂ)) * (K.s2star : ℂ) *
          ((K.c1 : ℂ) * (Real.cos θ : ℂ) - Complex.I * (Real.sin θ : ℂ) - (K.s1 : ℂ) * (K.c2 : ℂ)) := by
        rw [real_inclusion_cos_add_I_mul_sin θ]   -- 5 行目: 準備の `exp(ix)` の表示を `x = θ` で
    _ = gamma2 K θ := by
        rw [gamma2]                               -- 6 行目: `def_gamma1_gamma2_of_theta`

/-- `γ_2` は `2π` 周期（`gamma2_add_two_pi_mul_int` を `k = 1` で）。人手に対応するラベルは無い補助の系。 -/
theorem gamma2_add_two_pi : gamma2 K (θ + 2 * Real.pi) = gamma2 K θ := by
  have := gamma2_add_two_pi_mul_int K θ 1
  simpa using this

@[simp]
theorem thetaMu_neg (M : ℕ) (μ : ℤ) : thetaMu M (-μ) = -thetaMu M μ := by
  simp [thetaMu]
  ring

/-- 整数運動量の経路だけが使う（本文に対応するブロックは無く、人手は参照用ノート
`integer_momentum_route_not_adopted.ts` に退避している）。 -/
theorem thetaMu_add_int_mul (M : ℕ) (hM : M ≠ 0) (μ k : ℤ) :
    thetaMu M (μ + k * M) = thetaMu M μ + 2 * Real.pi * (k : ℝ) := by
  have hM' : (M : ℝ) ≠ 0 := Nat.cast_ne_zero.2 hM
  rw [thetaMu, thetaMu]
  push_cast
  field_simp

/-- `γ_2(θ_{μ+M}) = γ_2(θ_μ)`（`θ_μ` の `M` 周期性）。 -/
theorem gamma2_thetaMu_add_M (M : ℕ) (hM : M ≠ 0) (μ : ℤ) :
    gamma2 K (thetaMu M (μ + M)) = gamma2 K (thetaMu M μ) := by
  have h : thetaMu M (μ + M) = thetaMu M μ + 2 * Real.pi * ((1 : ℤ) : ℝ) := by
    have := thetaMu_add_int_mul M hM μ 1
    simpa using this
  rw [h, gamma2_add_two_pi_mul_int]

/-- **後段で使う形**: `μ + ν ≡ 0 (mod M)` のとき `γ_2(θ_ν) = γ_2(-θ_μ)`。 -/
theorem gamma2_thetaMu_of_dvd (M : ℕ) (hM : M ≠ 0) (μ ν : ℤ) (h : (M : ℤ) ∣ (μ + ν)) :
    gamma2 K (thetaMu M ν) = gamma2 K (-thetaMu M μ) := by
  obtain ⟨k, hk⟩ := h
  have hν : ν = -μ + k * M := by linear_combination hk
  rw [hν, thetaMu_add_int_mul M hM (-μ) k, gamma2_add_two_pi_mul_int, thetaMu_neg]

/-! ## `γ_2(θ) = 0` となる条件

人手は本文に無く、参照用ノート `integer_momentum_route_not_adopted.ts` の id の末尾が `TV1_hatZ_hatY_022_claim_gamma2_theta_is_0` の項目（本文にあったときのラベル `gamma_2_theta_is_0`）に退避してある。
以下の「修正前の原文」は、このブロックが本文にあったときに直す前の版を指す。ノートの項目は直した後の形で、
冒頭の「形式化の過程で見つかった原文の問題」の二件はどちらも解消している。 -/

/-- **修正前の原文 `gamma_2_theta_is_0` の修正版**。修正前の原文は `s_2^* = 0` の場合を落としていた
（冒頭の「原文の問題」の「`s_2^* ≠ 0` を暗黙に仮定していた」件）。 -/
theorem gamma2_eq_zero_iff :
    gamma2 K θ = 0 ↔
      K.s2star = 0 ∨ (Real.sin θ = 0 ∧ K.c1 * Real.cos θ - K.s1 * K.c2 = 0) := by
  have hIe : Complex.I * Complex.exp (Complex.I * (θ : ℂ)) ≠ 0 :=
    mul_ne_zero Complex.I_ne_zero (Complex.exp_ne_zero _)
  have hX : ((K.c1 : ℂ) * (Real.cos θ : ℂ) - Complex.I * (Real.sin θ : ℂ) -
        (K.s1 : ℂ) * (K.c2 : ℂ) = 0) ↔
      (Real.sin θ = 0 ∧ K.c1 * Real.cos θ - K.s1 * K.c2 = 0) := by
    rw [Complex.ext_iff]
    simp only [Complex.sub_re, Complex.sub_im, Complex.mul_re, Complex.mul_im, Complex.I_re,
      Complex.I_im, Complex.ofReal_re, Complex.ofReal_im, Complex.zero_re, Complex.zero_im]
    constructor
    · rintro ⟨h1, h2⟩
      constructor <;> linarith
    · rintro ⟨h1, h2⟩
      constructor <;> linarith
  rw [gamma2, mul_eq_zero, mul_eq_zero]
  simp only [hIe, false_or, Complex.ofReal_eq_zero, hX]

/-- `s_2^* ≠ 0` の下では修正前の原文の書き方どおりになる。 -/
theorem gamma2_eq_zero_iff_of_s2star_ne_zero (hs : K.s2star ≠ 0) :
    gamma2 K θ = 0 ↔ (Real.sin θ = 0 ∧ K.c1 * Real.cos θ - K.s1 * K.c2 = 0) := by
  rw [gamma2_eq_zero_iff]
  simp [hs]

/-- **修正前の原文 `gamma_2_theta_is_0` の最後の同値の修正版**:
`sin θ_μ = 0 ⟺ M ∣ 2μ`。修正前の原文の「`⟺ μ = ±M`」は `M` が偶数のときの `μ = ±M/2` を落としていた
（ノートの項目は連立条件全体の同値として `μ = ±M/2` を除いている）。 -/
theorem sin_thetaMu_eq_zero_iff (M : ℕ) (hM : M ≠ 0) (μ : ℤ) :
    Real.sin (thetaMu M μ) = 0 ↔ (M : ℤ) ∣ 2 * μ := by
  have hM' : (M : ℝ) ≠ 0 := Nat.cast_ne_zero.2 hM
  rw [Real.sin_eq_zero_iff]
  constructor
  · rintro ⟨n, hn⟩
    refine ⟨n, ?_⟩
    have : (n : ℝ) * Real.pi = 2 * Real.pi * μ / M := hn.trans rfl
    have hpi : (0 : ℝ) < Real.pi := Real.pi_pos
    have h2 : (2 : ℝ) * μ = M * n := by
      field_simp at this
      nlinarith [this]
    exact_mod_cast h2
  · rintro ⟨n, hn⟩
    refine ⟨n, ?_⟩
    have h2 : (2 : ℝ) * μ = M * n := by exact_mod_cast hn
    rw [thetaMu]
    field_simp
    nlinarith [h2]

end Ising2D
