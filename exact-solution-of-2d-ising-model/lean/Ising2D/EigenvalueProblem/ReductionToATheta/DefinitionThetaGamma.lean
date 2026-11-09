/-
# `θ_μ`, `γ_1(θ)`, `γ_2(θ)`, `A(θ)` の定義とその基本性質

対応する人手証明（正本は `structured-latex/content/`）:
- `008_TV1_hatZ_hatY_part1.mjs`
  - `TV1_hatZ_hatY_017_definition_A_theta`（ラベル `def_A_theta`。章立ての組み直しで
    `eigenvalue_problem_reduction_to_A_theta.ts` へ移った）
  - `TV1_hatZ_hatY_019_definition_theta_mu`（ラベル `def_theta_mu`）
  - `TV1_hatZ_hatY_020_definition_gamma1_gamma2`（ラベル無し）
- `008_TV1_hatZ_hatY_part2.mjs`
  - `TV1_hatZ_hatY_022_claim_gamma2_theta_is_0`（ラベル `gamma_2_theta_is_0`）
  - `TV1_hatZ_hatY_023_claim_relation_of_gamma2`（ラベル `relation_of_gamma_2`）
  - `TV1_hatZ_hatY_041_claim_gamma2_periodicity`（ラベル `gamma_2_periodicity`）
- `eigenvalue_problem_diagonalization_and_exponential_form.ts`
  - `def_gamma1_gamma2_of_theta` の `(2,1)` 成分の鎖と、`relation_of_gamma_2_theta_tilde` の証明の
    「第一に」「第三に」の鎖（`gamma2_neg` とその準備の補題。各段に人手の行を書いた）

原文の定義（`θ ∈ ℝ`、原文は `θ ∈ ℂ` だが `cos θ`, `sin θ` の実部虚部分解を使うので実数に限る）:

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
* 添字 `μ` は原文の `ℳ := {-M, …, -1, 1, …, M}` に限らず `ℤ` 全体で扱う
  （`θ_μ` の定義式は全 `μ ∈ ℤ` で意味を持つ。`RoutesNotAdopted/IntegerMomentum/DefinitionHatZHatY.lean` の `hatZ`/`hatY` と同じ方針）。
* `A(θ)` は原文 `def_A_theta` の**明示行列そのまま**を定義とし、
  `AMat_eq` で `!![γ_1(θ), γ_2(θ); -γ_2(-θ), γ_1(θ)]` に等しいことを証明する
  （原文 `TV1_hatZ_hatY_020` および `eigenvector_of_A_theta` の proof 冒頭の書き換えの検算）。

## 形式化の過程で見つかった原文の問題（および解消状況）

1. **`gamma_2_theta_is_0`（`TV1_hatZ_hatY_022`）が `s_2^* ≠ 0` を暗黙に仮定していた。**
   `γ_2` は `s_2^*` を因子に持つので、`s_2^* = 0` のときは `sin θ`, `c_1cos θ - s_1c_2` と
   無関係に `γ_2 ≡ 0` である。定義だけから言える同値は
   `γ_2(θ) = 0 ⟺ s_2^* = 0 ∨ (sin θ = 0 ∧ c_1cos θ - s_1c_2 = 0)`（`gamma2_eq_zero_iff`）で、
   原文の形は `s_2^* ≠ 0` の下でのみ成り立つ（`gamma2_eq_zero_iff_of_s2star_ne_zero`）。
   → **本セッションと並行して原文側が修正済み**（現在の当該ブロックは
   `K_1, K_2 ∈ ℝ_{>0}` を前提に置いており、そこから `s_2^* = sinh(2K_2^*) > 0` が従う）。
2. **`gamma_2_theta_is_0` の同値 `sin θ_μ = 0 ⟺ μ = ±M` が単独では偽だった。**
   `θ_μ = 2πμ/M` に対し `sin θ_μ = 0 ⟺ M ∣ 2μ` であり（`sin_thetaMu_eq_zero_iff`）、
   `ℳ = {-M,…,-1,1,…,M}` の範囲では `M` が偶数のとき `μ = ±M/2`（`θ_μ = ±π`）も該当する。
   → **これも並行して原文側が修正済み**（現在は「連立条件全体としての同値」であること、
   `μ = ±M/2` が `c_2s_1 = -c_1 < 0` と `c_1, s_1, c_2 > 0` の矛盾で排除されることが明記された）。
   Lean 側の `sin_thetaMu_eq_zero_iff` はその機械的な裏づけとして残す。
-/
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic
import Mathlib.RingTheory.RootsOfUnity.Complex
import Mathlib.LinearAlgebra.Matrix.Notation
import Mathlib.LinearAlgebra.Matrix.NonsingularInverse
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesProduct

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

/-- 原文 `θ_μ := 2πμ/M`（`def_theta_mu`）。 -/
noncomputable def thetaMu (M : ℕ) (μ : ℤ) : ℝ := 2 * Real.pi * μ / M

/-- 原文 `γ_1(θ) := c_1 c_2^* - s_1 s_2^* cos θ`。実数だが `A(θ)` の成分として使うので `ℂ` へ埋める。 -/
noncomputable def gamma1 : ℂ := ((K.c1 * K.c2star - K.s1 * K.s2star * Real.cos θ : ℝ) : ℂ)

/-- 原文 `γ_2(θ) := i e^{iθ} s_2^* (c_1 cos θ - i sin θ - s_1 c_2)`。 -/
noncomputable def gamma2 : ℂ :=
  Complex.I * Complex.exp (Complex.I * (θ : ℂ)) * (K.s2star : ℂ) *
    ((K.c1 : ℂ) * (Real.cos θ : ℂ) - Complex.I * (Real.sin θ : ℂ) - (K.s1 : ℂ) * (K.c2 : ℂ))

/-- 原文 `def_A_theta` の明示行列そのまま。 -/
noncomputable def AMat : Matrix (Fin 2) (Fin 2) ℂ :=
  !![((K.c1 * K.c2star - K.s1 * K.s2star * Real.cos θ : ℝ) : ℂ),
      Complex.I * Complex.exp (Complex.I * (θ : ℂ)) * (K.s2star : ℂ) *
        ((K.c1 : ℂ) * (Real.cos θ : ℂ) - Complex.I * (Real.sin θ : ℂ) - (K.s1 : ℂ) * (K.c2 : ℂ));
    -Complex.I * Complex.exp (-(Complex.I * (θ : ℂ))) * (K.s2star : ℂ) *
        ((K.c1 : ℂ) * (Real.cos θ : ℂ) + Complex.I * (Real.sin θ : ℂ) - (K.s1 : ℂ) * (K.c2 : ℂ)),
      ((K.c1 * K.c2star - K.s1 * K.s2star * Real.cos θ : ℝ) : ℂ)]

/-! ## `γ_2(-θ)` を `θ` の量で書くための準備

人手 `relation_of_gamma_2_theta_tilde` の証明の「第一に」の鎖（`i(-θ) = -iθ`・`-i(-θ) = iθ`・
`cos(-θ) = cos θ`・`sin(-θ) = -sin θ`）を、行ごとに 1 段の `calc` で置く。
人手 `def_gamma1_gamma2_of_theta` の `(2,1)` 成分の鎖は、同じ等式を名前だけで根拠にしている。

- 人手の `-iθ` は `multiply_by_minus_one` の `-(iθ)` で、Lean の `-(Complex.I * (θ : ℂ))` である。
- 人手の `-1_ℂ` は `inclusion_rr_to_cc` の略記 `r_ℂ` の `r = -1` で、Lean では `((-1 : ℝ) : ℂ)` と `-1 : ℂ` の
  2 つの書き方がある。行き来は略記の読み替えの段（`Complex.ofReal_neg`・`Complex.ofReal_one`）で行う。
- 分母の `2` は人手どおり `2_ℂ`（Lean の `(2 : ℂ)`）である。 -/

/-- 人手 `relation_of_gamma_2_theta_tilde` の準備の `i(-θ) = -iθ`（人手の 6 行と、略記の読み替えの 1 段）。 -/
theorem I_mul_real_neg_eq_neg_I_mul (θ : ℝ) :
    Complex.I * ((-θ : ℝ) : ℂ) = -(Complex.I * (θ : ℂ)) :=
  calc Complex.I * ((-θ : ℝ) : ℂ)
      = Complex.I * (((-1) * θ : ℝ) : ℂ) := by
        rw [neg_one_mul]                          -- 1 行目: ℝ で `-a = (-1)a`（ℝ は体 `set_and_algebra_notation`、`a → θ`）
    _ = Complex.I * (((-1 : ℝ) : ℂ) * (θ : ℂ)) := by
        rw [real_inclusion_mul]                   -- 2 行目: `real_inclusion_preserves_product`（`a → -1`, `b → θ`）を右辺から左辺へ
    _ = Complex.I * ((-1 : ℂ) * (θ : ℂ)) := by
        rw [Complex.ofReal_neg, Complex.ofReal_one] -- `(-1)_ℂ` を `-1_ℂ` と書く（`inclusion_rr_to_cc` の略記）
    _ = (Complex.I * (-1 : ℂ)) * (θ : ℂ) := by
        rw [mul_assoc]                            -- 3 行目: `complex_numbers_form_a_field` の積の結合律
    _ = ((-1 : ℂ) * Complex.I) * (θ : ℂ) := by
        rw [mul_comm Complex.I (-1 : ℂ)]          -- 4 行目: `complex_numbers_form_a_field` の積の可換律
    _ = (-1 : ℂ) * (Complex.I * (θ : ℂ)) := by
        rw [mul_assoc]                            -- 5 行目: `complex_numbers_form_a_field` の積の結合律
    _ = -(Complex.I * (θ : ℂ)) := by
        rw [neg_one_mul]                          -- 6 行目: `multiply_by_minus_one`（`z → iθ`）を右辺から左辺へ

/-- 人手 `relation_of_gamma_2_theta_tilde` の準備の `-i(-θ) = iθ`（人手の 2 行）。 -/
theorem neg_I_mul_real_neg_eq_I_mul (θ : ℝ) :
    -(Complex.I * ((-θ : ℝ) : ℂ)) = Complex.I * (θ : ℂ) :=
  calc -(Complex.I * ((-θ : ℝ) : ℂ))
      = -(-(Complex.I * (θ : ℂ))) := by
        rw [I_mul_real_neg_eq_neg_I_mul]          -- 1 行目: 上の `i(-θ) = -iθ`
    _ = Complex.I * (θ : ℂ) := by
        rw [neg_neg]                              -- 2 行目: ℂ で `-(-z) = z`（`complex_numbers_form_a_field`、`z → iθ`）

/-- 人手 `euler_formula_cos_sin` の第 1 式を、`x ∈ ℝ` の `cos x` を `inclusion_rr_to_cc` の像として読んだ形
（`cos x = (exp(ix) + exp(-ix))/2`、`-ix` は `-(ix)`）。人手のブロックの具体版が Lean に無いので、mathlib の
`Complex.ofReal_cos` と `Complex.cos` の定義で受ける（`ClaimFactorizationATheta.lean` の `euler_cos_as_exp` は
同じ式を `exp((-i)x)`・`2 = (2)_ℂ` で読んだ形）。 -/
theorem euler_cos_real_inclusion (x : ℝ) :
    ((Real.cos x : ℝ) : ℂ)
      = (Complex.exp (Complex.I * (x : ℂ)) + Complex.exp (-(Complex.I * (x : ℂ)))) / 2 := by
  rw [Complex.ofReal_cos, Complex.cos, neg_mul, mul_comm (x : ℂ) Complex.I]

/-- 人手 `euler_formula_cos_sin` の第 2 式を同じく読んだ形（`sin x = (exp(ix) - exp(-ix))/(2i)`）。
具体版が Lean に無いので、mathlib の `Complex.ofReal_sin` と `Complex.sin` の定義で受ける。 -/
theorem euler_sin_real_inclusion (x : ℝ) :
    ((Real.sin x : ℝ) : ℂ)
      = (Complex.exp (Complex.I * (x : ℂ)) - Complex.exp (-(Complex.I * (x : ℂ)))) / (2 * Complex.I) := by
  rw [Complex.ofReal_sin, Complex.sin, neg_mul, mul_comm (x : ℂ) Complex.I]
  field_simp
  ring_nf
  rw [Complex.I_sq]
  ring

/-- 人手 `relation_of_gamma_2_theta_tilde` の準備の `cos(-θ) = cos θ`（人手の 5 行）。 -/
theorem real_inclusion_cos_neg (θ : ℝ) :
    ((Real.cos (-θ) : ℝ) : ℂ) = ((Real.cos θ : ℝ) : ℂ) :=
  calc ((Real.cos (-θ) : ℝ) : ℂ)
      = (Complex.exp (Complex.I * ((-θ : ℝ) : ℂ)) + Complex.exp (-(Complex.I * ((-θ : ℝ) : ℂ)))) / 2 :=
        euler_cos_real_inclusion (-θ)             -- 1 行目: `euler_formula_cos_sin` を `-θ` に適用
    _ = (Complex.exp (-(Complex.I * (θ : ℂ))) + Complex.exp (-(Complex.I * ((-θ : ℝ) : ℂ)))) / 2 := by
        rw [I_mul_real_neg_eq_neg_I_mul θ]        -- 2 行目: 上の `i(-θ) = -iθ`
    _ = (Complex.exp (-(Complex.I * (θ : ℂ))) + Complex.exp (Complex.I * (θ : ℂ))) / 2 := by
        rw [neg_I_mul_real_neg_eq_I_mul]          -- 3 行目: 上の `-i(-θ) = iθ`
    _ = (Complex.exp (Complex.I * (θ : ℂ)) + Complex.exp (-(Complex.I * (θ : ℂ)))) / 2 := by
        rw [add_comm]                             -- 4 行目: `complex_numbers_form_a_field` の和の可換律
    _ = ((Real.cos θ : ℝ) : ℂ) :=
        (euler_cos_real_inclusion θ).symm         -- 5 行目: `euler_formula_cos_sin`

/-- 人手 `relation_of_gamma_2_theta_tilde` の準備の `sin(-θ) = -sin θ`（人手の 6 行）。 -/
theorem real_inclusion_sin_neg (θ : ℝ) :
    ((Real.sin (-θ) : ℝ) : ℂ) = -((Real.sin θ : ℝ) : ℂ) :=
  calc ((Real.sin (-θ) : ℝ) : ℂ)
      = (Complex.exp (Complex.I * ((-θ : ℝ) : ℂ)) - Complex.exp (-(Complex.I * ((-θ : ℝ) : ℂ))))
          / (2 * Complex.I) :=
        euler_sin_real_inclusion (-θ)             -- 1 行目: `euler_formula_cos_sin` を `-θ` に適用
    _ = (Complex.exp (-(Complex.I * (θ : ℂ))) - Complex.exp (-(Complex.I * ((-θ : ℝ) : ℂ))))
          / (2 * Complex.I) := by
        rw [I_mul_real_neg_eq_neg_I_mul θ]        -- 2 行目: 上の `i(-θ) = -iθ`
    _ = (Complex.exp (-(Complex.I * (θ : ℂ))) - Complex.exp (Complex.I * (θ : ℂ))) / (2 * Complex.I) := by
        rw [neg_I_mul_real_neg_eq_I_mul]          -- 3 行目: 上の `-i(-θ) = iθ`
    _ = (-(Complex.exp (Complex.I * (θ : ℂ)) - Complex.exp (-(Complex.I * (θ : ℂ))))) / (2 * Complex.I) := by
        rw [neg_sub]                              -- 4 行目: ℂ で `b - a = -(a - b)`（`complex_numbers_form_a_field`）
    _ = -((Complex.exp (Complex.I * (θ : ℂ)) - Complex.exp (-(Complex.I * (θ : ℂ)))) / (2 * Complex.I)) := by
        rw [neg_div]                              -- 5 行目: ℂ で `(-x)/y = -(x/y)`（`complex_numbers_form_a_field`）
    _ = -((Real.sin θ : ℝ) : ℂ) := by
        rw [euler_sin_real_inclusion θ]           -- 6 行目: `euler_formula_cos_sin`

/-- `γ_2(-θ)` の明示形。人手 `relation_of_gamma_2_theta_tilde` の証明の「第三に」の 6 行の鎖と 1 段ずつ対応する。
人手 `def_gamma1_gamma2_of_theta` の `(2,1)` 成分の 4 行の鎖は、同じ計算の 4〜6 行目を 1 行（`sin(-θ) = -sin θ`）に
まとめている。 -/
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
        rw [I_mul_real_neg_eq_neg_I_mul]          -- 2 行目: 上の `i(-θ) = -iθ`
    _ = Complex.I * Complex.exp (-(Complex.I * (θ : ℂ))) * (K.s2star : ℂ) *
          ((K.c1 : ℂ) * (Real.cos θ : ℂ) - Complex.I * (Real.sin (-θ) : ℂ) - (K.s1 : ℂ) * (K.c2 : ℂ)) := by
        rw [real_inclusion_cos_neg]               -- 3 行目: 上の `cos(-θ) = cos θ`
    _ = Complex.I * Complex.exp (-(Complex.I * (θ : ℂ))) * (K.s2star : ℂ) *
          ((K.c1 : ℂ) * (Real.cos θ : ℂ) - Complex.I * (-(Real.sin θ : ℂ)) - (K.s1 : ℂ) * (K.c2 : ℂ)) := by
        rw [real_inclusion_sin_neg]               -- 4 行目: 上の `sin(-θ) = -sin θ`
    _ = Complex.I * Complex.exp (-(Complex.I * (θ : ℂ))) * (K.s2star : ℂ) *
          ((K.c1 : ℂ) * (Real.cos θ : ℂ) - (-(Complex.I * (Real.sin θ : ℂ))) - (K.s1 : ℂ) * (K.c2 : ℂ)) := by
        rw [mul_neg]                              -- 5 行目: ℂ で `x(-y) = -(xy)`（`x → i`, `y → sin θ`）
    _ = Complex.I * Complex.exp (-(Complex.I * (θ : ℂ))) * (K.s2star : ℂ) *
          ((K.c1 : ℂ) * (Real.cos θ : ℂ) + Complex.I * (Real.sin θ : ℂ) - (K.s1 : ℂ) * (K.c2 : ℂ)) := by
        rw [sub_neg_eq_add]                       -- 6 行目: ℂ で `a - (-b) = a + b`（`a → c_1cos θ`, `b → i sin θ`）

/-- `γ_1` は偶関数（`cos` が偶関数であることによる）。 -/
@[simp]
theorem gamma1_neg : gamma1 K (-θ) = gamma1 K θ := by
  simp [gamma1, Real.cos_neg]

/-- **原文 `TV1_hatZ_hatY_020` の書き換えの検算**:
`A(θ) = !![γ_1(θ), γ_2(θ); -γ_2(-θ), γ_1(θ)]`。 -/
theorem AMat_eq : AMat K θ = !![gamma1 K θ, gamma2 K θ; -gamma2 K (-θ), gamma1 K θ] := by
  rw [gamma2_neg]
  ext i j
  fin_cases i <;> fin_cases j <;> simp [AMat, gamma1, gamma2]

/-! ## `γ_2` の対称性（原文 `relation_of_gamma_2`） -/

/-- 原文 `relation_of_gamma_2`: `γ_2(-θ) = -conj(γ_2(θ))`。 -/
theorem gamma2_neg_eq_neg_conj :
    gamma2 K (-θ) = -(starRingEnd ℂ) (gamma2 K θ) := by
  rw [gamma2_neg, gamma2]
  simp only [map_mul, map_sub, Complex.conj_I, ← Complex.exp_conj, Complex.conj_ofReal]
  push_cast
  ring_nf

/-- 原文 `relation_of_gamma_2` の系: `γ_2(θ) γ_2(-θ) = -|γ_2(θ)|^2`（特に非正の実数）。 -/
theorem gamma2_mul_gamma2_neg_eq_neg_normSq :
    gamma2 K θ * gamma2 K (-θ) = -((Complex.normSq (gamma2 K θ) : ℝ) : ℂ) := by
  rw [gamma2_neg_eq_neg_conj]
  rw [mul_neg, Complex.mul_conj]

/-- `γ_2(θ) = 0 ⟺ γ_2(-θ) = 0`（原文 `eigenvector_of_A_theta` の場合分け 1) で使われている）。 -/
theorem gamma2_neg_eq_zero_iff : gamma2 K (-θ) = 0 ↔ gamma2 K θ = 0 := by
  rw [gamma2_neg_eq_neg_conj, neg_eq_zero, map_eq_zero]

/-! ## `γ_2` の周期性

後段（`δ^M_{μ+ν,0}` の場面で `γ_2(θ_ν) = γ_2(-θ_μ)` を使うところ）で必要になる。
原文 `TV1_hatZ_hatY_041_claim_gamma2_periodicity` に対応する。 -/

/-- `γ_2` は `2π` 周期（整数倍のずらしで不変）。 -/
theorem gamma2_add_int_mul_two_pi (k : ℤ) :
    gamma2 K (θ + k * (2 * Real.pi)) = gamma2 K θ := by
  have hc : Real.cos (θ + k * (2 * Real.pi)) = Real.cos θ := Real.cos_add_int_mul_two_pi θ k
  have hs : Real.sin (θ + k * (2 * Real.pi)) = Real.sin θ := Real.sin_add_int_mul_two_pi θ k
  have he : Complex.exp (Complex.I * ((θ + k * (2 * Real.pi) : ℝ) : ℂ))
      = Complex.exp (Complex.I * (θ : ℂ)) := by
    have hsplit : Complex.I * ((θ + k * (2 * Real.pi) : ℝ) : ℂ)
        = Complex.I * (θ : ℂ) + (k : ℂ) * (2 * (Real.pi : ℂ) * Complex.I) := by
      push_cast; ring
    rw [hsplit, Complex.exp_add, Complex.exp_int_mul_two_pi_mul_I, mul_one]
  rw [gamma2, gamma2, hc, hs, he]

/-- `γ_2` は `2π` 周期。 -/
theorem gamma2_add_two_pi : gamma2 K (θ + 2 * Real.pi) = gamma2 K θ := by
  have := gamma2_add_int_mul_two_pi K θ 1
  simpa using this

@[simp]
theorem thetaMu_neg (M : ℕ) (μ : ℤ) : thetaMu M (-μ) = -thetaMu M μ := by
  simp [thetaMu]
  ring

theorem thetaMu_add_int_mul (M : ℕ) (hM : M ≠ 0) (μ k : ℤ) :
    thetaMu M (μ + k * M) = thetaMu M μ + k * (2 * Real.pi) := by
  have hM' : (M : ℝ) ≠ 0 := Nat.cast_ne_zero.2 hM
  rw [thetaMu, thetaMu]
  push_cast
  field_simp

/-- `γ_2(θ_{μ+M}) = γ_2(θ_μ)`（`θ_μ` の `M` 周期性）。 -/
theorem gamma2_thetaMu_add_M (M : ℕ) (hM : M ≠ 0) (μ : ℤ) :
    gamma2 K (thetaMu M (μ + M)) = gamma2 K (thetaMu M μ) := by
  have h : thetaMu M (μ + M) = thetaMu M μ + (1 : ℤ) * (2 * Real.pi) := by
    have := thetaMu_add_int_mul M hM μ 1
    simpa using this
  rw [h, gamma2_add_int_mul_two_pi]

/-- **後段で使う形**: `μ + ν ≡ 0 (mod M)` のとき `γ_2(θ_ν) = γ_2(-θ_μ)`。 -/
theorem gamma2_thetaMu_of_dvd (M : ℕ) (hM : M ≠ 0) (μ ν : ℤ) (h : (M : ℤ) ∣ (μ + ν)) :
    gamma2 K (thetaMu M ν) = gamma2 K (-thetaMu M μ) := by
  obtain ⟨k, hk⟩ := h
  have hν : ν = -μ + k * M := by linear_combination hk
  rw [hν, thetaMu_add_int_mul M hM (-μ) k, gamma2_add_int_mul_two_pi, thetaMu_neg]

/-! ## `γ_2(θ) = 0` となる条件（原文 `gamma_2_theta_is_0`） -/

/-- **原文 `gamma_2_theta_is_0` の修正版**。原文は `s_2^* = 0` の場合を落としている。 -/
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

/-- `s_2^* ≠ 0` の下では原文の書き方どおりになる。 -/
theorem gamma2_eq_zero_iff_of_s2star_ne_zero (hs : K.s2star ≠ 0) :
    gamma2 K θ = 0 ↔ (Real.sin θ = 0 ∧ K.c1 * Real.cos θ - K.s1 * K.c2 = 0) := by
  rw [gamma2_eq_zero_iff]
  simp [hs]

/-- **原文 `gamma_2_theta_is_0` の最後の同値の修正版**:
`sin θ_μ = 0 ⟺ M ∣ 2μ`。原文の「`⟺ μ = ±M`」は `M` が偶数のときの `μ = ±M/2` を落としている。 -/
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
