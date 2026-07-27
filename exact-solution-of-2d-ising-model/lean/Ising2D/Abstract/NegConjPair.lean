/-
# `w = -conj z` である複素数の対（**抽象版**）

対応する人手証明のラベル: `relation_of_gamma_2_theta_tilde`
（`structured-latex/content/015_A_theta_tilde_diagonalization.ts` の
`Athetatilde_003_claim_relation_of_gamma2`）

具体版: `Ising2D/Part015/Claim003_RelationGamma2Tilde.lean`。

## この主張に本質的に効いている構造は何か（具体版が過剰な構造を要求していないかの検査）

人手証明は `γ_2(-θ~_μ) = -overline{γ_2(θ~_μ)}` を出発点に、(2) 積が負の実数、
(3) 偏角が `π`、(4) `√(-γ_2γ_2(-θ)) = |γ_2|`、(5) `√(γ_2γ_2(-θ)) = i|γ_2|` を導く。
これらに効いているのは

* **`w = -conj z` という関係ただ 1 つ**

だけである。`γ_2` の具体形（`i e^{iθ} s_2^*(c_1cos θ - i sin θ - s_1c_2)`）も、
`θ` が半整数運動量であることも、Ising 模型の定数も、`M` も効いていない。
**`z ≠ 0`（人手証明では `gamma_2_theta_tilde_nonzero`）が効くのは狭義の不等号だけ**で、
等式 (1)(2)(4)(5) は `z = 0` でも成り立つ。

なお人手証明が `arg^{[0,2π)}` 分岐つきの平方根 `def_sqrt_cc` を経由している (4)(5) は、
ここでは**平方根関数を使わず**「`(|z|)^2 = -(z w)`」「`(i|z|)^2 = z w`」という
2 乗の等式として述べる（`Part008/Claim027_EigenATheta.lean` と同じ方針）。
分岐の選択は「`|z|` と `-|z|` のどちらを取るか」に還元され、人手証明が
`arg^{[0,2π)}` で固定しているのは前者（非負の方）である。
-/
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic

namespace Ising2D.Abstract

variable {z w : ℂ}

/-- **抽象版 (2)**: `w = -conj z` なら `z w = -|z|^2`（非正の実数）。 -/
theorem mul_of_eq_neg_conj (h : w = -(starRingEnd ℂ) z) :
    z * w = -((Complex.normSq z : ℝ) : ℂ) := by
  rw [h, mul_neg, Complex.mul_conj]

/-- **抽象版**: `w = -conj z` なら `z ≠ 0 ⟹ w ≠ 0`。 -/
theorem ne_zero_of_eq_neg_conj (h : w = -(starRingEnd ℂ) z) (hz : z ≠ 0) : w ≠ 0 := by
  rw [h, neg_ne_zero]
  simpa using hz

/-- **抽象版 (4)**: `(|z|)^2 = -(z w)`（`|z| := √(normSq z) ≥ 0`）。
人手証明の `√(-γ_2γ_2(-θ)) = |γ_2|` を平方根関数抜きで述べたもの。 -/
theorem sq_absOf_eq_neg_mul (h : w = -(starRingEnd ℂ) z) :
    ((Real.sqrt (Complex.normSq z) : ℝ) : ℂ) ^ 2 = -(z * w) := by
  rw [mul_of_eq_neg_conj h, neg_neg, ← Complex.ofReal_pow,
    Real.sq_sqrt (Complex.normSq_nonneg z)]

/-- **抽象版 (5)**: `(i|z|)^2 = z w`。
人手証明の `√(γ_2γ_2(-θ)) = i|γ_2|` を平方根関数抜きで述べたもの。 -/
theorem sq_I_mul_absOf_eq_mul (h : w = -(starRingEnd ℂ) z) :
    (Complex.I * ((Real.sqrt (Complex.normSq z) : ℝ) : ℂ)) ^ 2 = z * w := by
  have hI : (Complex.I : ℂ) ^ 2 = -1 := Complex.I_sq
  have hr := sq_absOf_eq_neg_mul h
  calc (Complex.I * ((Real.sqrt (Complex.normSq z) : ℝ) : ℂ)) ^ 2
      = Complex.I ^ 2 * ((Real.sqrt (Complex.normSq z) : ℝ) : ℂ) ^ 2 := by ring
    _ = (-1) * (-(z * w)) := by rw [hI, hr]
    _ = z * w := by ring

/-- **抽象版**: `z ≠ 0` なら `|z| > 0`。狭義の不等号が要るのはここだけ。 -/
theorem absOf_pos (hz : z ≠ 0) : 0 < Real.sqrt (Complex.normSq z) :=
  Real.sqrt_pos.2 ((Complex.normSq_pos).2 hz)

end Ising2D.Abstract
