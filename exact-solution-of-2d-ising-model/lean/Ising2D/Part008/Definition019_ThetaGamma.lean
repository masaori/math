/-
# `θ_μ`, `γ_1(θ)`, `γ_2(θ)`, `A(θ)` の定義とその基本性質

対応する人手証明（正本は `structured-latex/content/`）:
- `008_TV1_hatZ_hatY_part1.mjs`
  - `TV1_hatZ_hatY_017_definition_A_theta`（ラベル `def_A_theta`）
  - `TV1_hatZ_hatY_019_definition_theta_mu`（ラベル `def_theta_mu`）
  - `TV1_hatZ_hatY_020_definition_gamma1_gamma2`（ラベル無し）
- `008_TV1_hatZ_hatY_part2.mjs`
  - `TV1_hatZ_hatY_022_claim_gamma2_theta_is_0`（ラベル `gamma_2_theta_is_0`）
  - `TV1_hatZ_hatY_023_claim_relation_of_gamma2`（ラベル `relation_of_gamma_2`）
  - `TV1_hatZ_hatY_041_claim_gamma2_periodicity`（ラベル `gamma_2_periodicity`）

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
  （`θ_μ` の定義式は全 `μ ∈ ℤ` で意味を持つ。`Part004` の `hatZ`/`hatY` と同じ方針）。
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

/-- `γ_2(-θ)` の明示形。原文 `relation_of_gamma_2` の proof 第 1 行。 -/
theorem gamma2_neg :
    gamma2 K (-θ) = Complex.I * Complex.exp (-(Complex.I * (θ : ℂ))) * (K.s2star : ℂ) *
      ((K.c1 : ℂ) * (Real.cos θ : ℂ) + Complex.I * (Real.sin θ : ℂ) -
        (K.s1 : ℂ) * (K.c2 : ℂ)) := by
  have h : Complex.I * ((-θ : ℝ) : ℂ) = -(Complex.I * (θ : ℂ)) := by push_cast; ring
  rw [gamma2, h]
  push_cast [Real.cos_neg, Real.sin_neg]
  ring

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
