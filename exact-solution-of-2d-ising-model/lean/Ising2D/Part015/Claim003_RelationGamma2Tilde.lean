/-
# `γ_2(-θ~_μ) = -conj(γ_2(θ~_μ))` とその帰結（**具体版**）

対応する人手証明のラベル: `relation_of_gamma_2_theta_tilde`
（`structured-latex/content/015_A_theta_tilde_diagonalization.ts` の
`Athetatilde_003_claim_relation_of_gamma2`）

**必要十分版**: `Ising2D/NecSuf/NegConjPair.lean`
（`Ising2D.NecSuf.mul_of_eq_neg_conj` / `sq_absOf_eq_neg_mul` / `sq_I_mul_absOf_eq_mul`）。
具体版は必要十分版の系として導出する。

## 形式化の方針

* (1) は既存の `Ising2D.gamma2_neg_eq_neg_conj`（`Part008/Definition019_ThetaGamma.lean`）
  そのままである（人手証明も「008 章 `relation_of_gamma_2` と同じ計算で、
  `θ` が実数でありさえすれば成り立つ」と書いている）。
* 人手証明の `|γ_2(θ~_μ)|` は `Ising2D.absGamma2 K θ := √(normSq(γ_2(θ)))` として置く
  （`Complex.normSq` は既存ファイルで使われている API）。
* **(3)(4)(5) の複素平方根 `√` は形式化しない。** 人手証明は `arg^{[0,2π)}` 分岐の
  一価写像 `def_sqrt_cc` を導入して `√(-γ_2γ_2(-θ)) = |γ_2|`、`√(γ_2γ_2(-θ)) = i|γ_2|` と
  書くが、後段（固有値・固有ベクトル・対角化）が使うのはこの 2 つの値の**2 乗が何か**だけである。
  そこで `Part008/Claim027_EigenATheta.lean` と同じ方針で
  `(|γ_2|)^2 = -γ_2γ_2(-θ)`（`sq_absGamma2`）と `(i|γ_2|)^2 = γ_2γ_2(-θ)`（`sq_I_absGamma2`）
  として述べる。分岐の選択は「`|γ_2|` と `-|γ_2|` のどちらを取るか」に還元され、
  人手証明が `arg^{[0,2π)}` で固定しているのは非負の方である。
  (3)（偏角が `π`）は `def_sqrt_cc` を経由するための中間段階なので、
  この方針では対応物が不要になる。積が負の実数であることは (2) で述べている。
-/
import Ising2D.Part015.Claim002_Gamma2TildeNonzero
import Ising2D.NecSuf.NegConjPair

namespace Ising2D

variable (K : IsingConst) (θ : ℝ)

/-- 人手証明の `|γ_2(θ)|`。 -/
noncomputable def absGamma2 : ℝ := Real.sqrt (Complex.normSq (gamma2 K θ))

/-- `|γ_2(θ)| ≥ 0`。 -/
theorem absGamma2_nonneg : 0 ≤ absGamma2 K θ := Real.sqrt_nonneg _

/-- `|γ_2(θ)|^2 = normSq(γ_2(θ))`。 -/
theorem absGamma2_sq : absGamma2 K θ ^ 2 = Complex.normSq (gamma2 K θ) :=
  Real.sq_sqrt (Complex.normSq_nonneg _)

/-- **人手証明 (1)**: `γ_2(-θ~_μ) = -conj(γ_2(θ~_μ))`（既存の定理の特殊化）。 -/
theorem gamma2_neg_thetaTilde_eq (M : ℕ) (μ : ℤ) :
    gamma2 K (-thetaTilde M μ) = -(starRingEnd ℂ) (gamma2 K (thetaTilde M μ)) :=
  gamma2_neg_eq_neg_conj K (thetaTilde M μ)

/-- **人手証明 (2)**: `γ_2(θ)γ_2(-θ) = -|γ_2(θ)|^2`。必要十分版 `NecSuf.mul_of_eq_neg_conj` の系。 -/
theorem gamma2_mul_gamma2_neg_eq_neg_absSq :
    gamma2 K θ * gamma2 K (-θ) = -((absGamma2 K θ ^ 2 : ℝ) : ℂ) := by
  rw [absGamma2_sq]
  exact NecSuf.mul_of_eq_neg_conj (gamma2_neg_eq_neg_conj K θ)

/-- **人手証明 (4)**: `(|γ_2(θ)|)^2 = -γ_2(θ)γ_2(-θ)`（複素平方根を使わない形）。 -/
theorem sq_absGamma2 :
    ((absGamma2 K θ : ℝ) : ℂ) ^ 2 = -(gamma2 K θ * gamma2 K (-θ)) :=
  NecSuf.sq_absOf_eq_neg_mul (gamma2_neg_eq_neg_conj K θ)

/-- **人手証明 (5)**: `(i|γ_2(θ)|)^2 = γ_2(θ)γ_2(-θ)`（複素平方根を使わない形）。 -/
theorem sq_I_absGamma2 :
    (Complex.I * ((absGamma2 K θ : ℝ) : ℂ)) ^ 2 = gamma2 K θ * gamma2 K (-θ) :=
  NecSuf.sq_I_mul_absOf_eq_mul (gamma2_neg_eq_neg_conj K θ)

/-- **人手証明 (2) の狭義部分**: `γ_2(θ~_μ) ≠ 0` より `|γ_2(θ~_μ)| > 0`。 -/
theorem absGamma2_thetaTilde_pos (P : IsingParam) {M : ℕ} (hM : M ≠ 0) (μ : ℤ) :
    0 < absGamma2 P.const (thetaTilde M μ) :=
  NecSuf.absOf_pos (gamma2_thetaTilde_ne_zero P hM μ)

end Ising2D
