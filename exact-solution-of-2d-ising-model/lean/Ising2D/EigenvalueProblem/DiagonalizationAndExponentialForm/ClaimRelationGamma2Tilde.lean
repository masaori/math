/-
# `γ_2(-θ~_μ) = -conj(γ_2(θ~_μ))` とその帰結（**具体版**）

対応する人手証明のラベル: `relation_of_gamma_2_theta_tilde`
（`structured-latex/content/eigenvalue_problem_diagonalization_and_exponential_form.ts` の
`Athetatilde_003_claim_relation_of_gamma2`）

**必要十分版**: `Ising2D/NecSuf/NegConjPair.lean`
（`Ising2D.NecSuf.mul_of_eq_neg_conj` / `sq_absOf_eq_neg_mul` / `sq_I_mul_absOf_eq_mul`）。
具体版は必要十分版の系として導出する。

## 形式化の方針

* (1) は既存の `Ising2D.gamma2_neg_eq_neg_conj`（`EigenvalueProblem/ReductionToATheta/DefinitionThetaGamma.lean`）
  そのままである（人手証明も「008 章 `relation_of_gamma_2` と同じ計算で、
  `θ` が実数でありさえすれば成り立つ」と書いている）。
* 人手証明の `|γ_2(θ~_μ)|` は `Ising2D.absGamma2 K θ := √(normSq(γ_2(θ)))` として置く
  （`Complex.normSq` は既存ファイルで使われている API）。
* **(3)(4)(5) の複素平方根 `√` は形式化しない。** 人手証明は `arg^{[0,2π)}` 分岐の
  一価写像 `def_sqrt_cc` を導入して `√(-γ_2γ_2(-θ)) = |γ_2|`、`√(γ_2γ_2(-θ)) = i|γ_2|` と
  書くが、後段（固有値・固有ベクトル・対角化）が使うのはこの 2 つの値の**2 乗が何か**だけである。
  そこで `RoutesNotAdopted/IntegerMomentum/ClaimEigenvectorsAndDiagonalizationOfATheta.lean` と同じ方針で
  `(|γ_2|)^2 = -γ_2γ_2(-θ)`（`sq_absGamma2`）と `(i|γ_2|)^2 = γ_2γ_2(-θ)`（`sq_I_absGamma2`）
  として述べる。分岐の選択は「`|γ_2|` と `-|γ_2|` のどちらを取るか」に還元され、
  人手証明が `arg^{[0,2π)}` で固定しているのは非負の方である。
  (3)（偏角が `π`）は `def_sqrt_cc` を経由するための中間段階なので、
  この方針では対応物が不要になる。積が負の実数であることは (2) で述べている。
* (2) の狭義の負は、人手の `0 < |γ_2(θ)|^2` の 3 行の鎖と `-|γ_2(θ)|^2 < 0` の 2 行の鎖を
  `absGamma2_thetaTilde_sq_pos`・`neg_absGamma2_thetaTilde_sq_neg` の `calc` と 1 対 1 に置く。
  人手の二乗は `def_power_of_real_number` の冪（`m = 2`）で、Lean の `r ^ 2`（`Monoid.npow`）である。
  積 `|γ_2||γ_2|` との行き来は `square_of_real_number_is_product` を右辺から左辺へ引く。
  必要十分版は `NecSuf.sq_pos_of_pos_chain`・`NecSuf.neg_neg_of_pos_chain`（`NecSuf/NegConjPair.lean`）、
  具体版をその系として導くのは `ClaimRelationGamma2TildeFromNecSuf.lean`。
-/
import Ising2D.EigenvalueProblem.DiagonalizationAndExponentialForm.ClaimGamma2TildeNonzero
import Ising2D.NecSuf.NegConjPair
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimSquareOfRealNumberIsProduct

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

/-- **人手証明 (2)**: `γ_2(θ)γ_2(-θ) = (-|γ_2(θ)|^2)_ℂ`（右辺は実数 `-|γ_2(θ)|^2` の像。人手の (2) と同じ形）。
必要十分版 `NecSuf.mul_of_eq_neg_conj` の系。必要十分版の右辺 `-((normSq : ℝ) : ℂ)` の符号反転を
像の中へ入れるのは `Complex.ofReal_neg`（人手の (2) の鎖の 8・9 行目が `real_inclusion_preserves_product` と
ℝ の `(-1)a = -a` で行う、ℂ の符号反転から実数の符号反転の像への書き換え）。人手の 9 行の鎖と 1 対 1 の形にする件は状態台帳の (cl14)。 -/
theorem gamma2_mul_gamma2_neg_eq_neg_absSq :
    gamma2 K θ * gamma2 K (-θ) = ((-(absGamma2 K θ ^ 2) : ℝ) : ℂ) := by
  rw [Complex.ofReal_neg, absGamma2_sq]
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

/-- **人手証明 (2) の狭義部分の第一の鎖**: `0 < |γ_2(θ~_μ)|^2`（人手の 3 行の鎖と 1 対 1 の `calc`）。 -/
theorem absGamma2_thetaTilde_sq_pos (P : IsingParam) {M : ℕ} (hM : M ≠ 0) (μ : ℤ) :
    0 < absGamma2 P.const (thetaTilde M μ) ^ 2 := by
  have h := absGamma2_thetaTilde_pos P hM μ
  calc (0 : ℝ)
      = 0 * absGamma2 P.const (thetaTilde M μ) := (zero_mul _).symm
                          -- ℝ の四則
    _ < absGamma2 P.const (thetaTilde M μ) * absGamma2 P.const (thetaTilde M μ) :=
        mul_lt_mul_of_pos_right h h
                          -- `0 < |γ_2(θ)|` の両辺に正の実数 `|γ_2(θ)|` を掛ける
    _ = absGamma2 P.const (thetaTilde M μ) ^ 2 :=
        (square_of_real_number_is_product _).symm
                          -- `square_of_real_number_is_product`（`r → |γ_2(θ)|`）を右辺から左辺へ

/-- **人手証明 (2) の狭義部分の第二の鎖**: `-|γ_2(θ~_μ)|^2 < 0`（人手の 2 行の鎖と 1 対 1 の `calc`）。 -/
theorem neg_absGamma2_thetaTilde_sq_neg (P : IsingParam) {M : ℕ} (hM : M ≠ 0) (μ : ℤ) :
    -(absGamma2 P.const (thetaTilde M μ) ^ 2) < 0 :=
  calc -(absGamma2 P.const (thetaTilde M μ) ^ 2)
      < -0 := neg_lt_neg (absGamma2_thetaTilde_sq_pos P hM μ)
                          -- 直前の鎖の `0 < |γ_2(θ)|^2` の両辺の符号を反転すると向きが変わる
    _ = 0 := neg_zero
                          -- ℝ の四則

end Ising2D
