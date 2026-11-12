/-
`claim_dispersion_angle_realization`
（複素根の角表示は分散因子の実現値を余弦で表す）の具体版。

`Bool.false` と `Bool.true` は本文の 0 と 1 に対応し、a/2 は `(if a then 1 else 0) / 2` と書く
（`KacWard/TwistedModeSets.lean` の規約）。複素指数関数・実余弦・実正弦について使うのは、
本文の冒頭に挙げた加法法則・exp(0) = 1・Euler の公式・偶奇の四つだけである。

人手証明との対応:
  - θ := 2π(k + a/2)/L: `modeAngle`。exp(2πi(k + a/2)/L) = exp(iθ): `complexRootCandidate_eq_exp_modeAngle`。
  - 準備: ϖ ∈ μ_{2L}（`claim_twisted_modes_are_double_roots`）、ϖ = α + βω、ϖ⁻¹ = α − βω
    （`claim_root_of_unity_inverse_is_real_closed_conjugate`）、ϖ = 0 なら 1 = ϖ^{2L} = 0^{2L} = 0 の三行、
    ϖ + ϖ⁻¹ = (α + βω) + (α − βω) = 2α = 2α + 0·ω の三行: `twistedMode_add_inv_decomposition`。
  - ρ_C(ϖ) = pr₁(Θ(ϖ, ς)) = exp(2πi(k + a/2)/L) = exp(iθ₁) の三行: 本定理の `hvarpiExp`。
  - ρ_C(ϖ⁻¹) = 1·ρ_C(ϖ⁻¹) = exp(0)ρ_C(ϖ⁻¹) = exp(−iθ + iθ)ρ_C(ϖ⁻¹) = exp(−iθ)exp(iθ)ρ_C(ϖ⁻¹)
    = exp(−iθ)ρ_C(ϖ)ρ_C(ϖ⁻¹) = exp(−iθ)ρ_C(ϖϖ⁻¹) = exp(−iθ)ρ_C(1) = exp(−iθ) の八行:
    `complexAlgebraicRealization_inv_eq_exp_neg`。
  - ρ_R(2α) = Re(ρ_R(2α) + iρ_R(0)) = Re(ρ_C(2α + 0·ω)) = Re(ρ_C(ϖ + ϖ⁻¹)) = Re(ρ_C(ϖ) + ρ_C(ϖ⁻¹))
    = Re(exp(iθ) + exp(−iθ)) = Re((cos θ + i sin θ) + (cos(−θ) + i sin(−θ)))
    = Re((cos θ + i sin θ) + (cos θ − i sin θ)) = Re(2cos θ + i·0) = 2cos θ の九行:
    `cutRealization_two_mul_eq_two_cos`。
  - Δ(q; ϖ, ς) = (1+q²)² − q(1−q²)(ϖ + ϖ⁻¹ + ς + ς⁻¹) = m − n(⋯) = m − n(2α + 2γ) の三行と、
    ρ_R(Δ) = ρ_R(m − w) = ρ_R(m − w) + ρ_R(w) − ρ_R(w) = ρ_R((m − w) + w) − ρ_R(w) = ρ_R(m) − ρ_R(w)
    = ρ_R(m) − ρ_R(n)ρ_R(2α + 2γ) = ρ_R(m) − ρ_R(n)(ρ_R(2α) + ρ_R(2γ))
    = ι(m) − ι(n)(ρ_R(2α) + ρ_R(2γ)) = ι(m) − ι(n)(2cos θ₁ + 2cos θ₂)
    = (1+r²)² − r(1−r²)(2cos θ₁ + 2cos θ₂) = (1+r²)² − 2r(1−r²)(cos θ₁ + cos θ₂) の十行:
    `dispersion_angle_realization`。

分散因子の値が R に属すること（`claim_dispersion_positive_at_rational_point`）は、主張の前提として
R の元 `D` とその値の等式 `hD` で受ける。必要十分版の定理・定義は使わない。
住処: 実数体と複素数体（指数評価への脱出）。
-/
import Ising2DLambda.RealEscape.TwistedModeProductBijection
import Ising2DLambda.RealEscape.ComplexRealizationPreservesAddition
import Ising2DLambda.RealEscape.ComplexRealizationPreservesMultiplication
import Ising2DLambda.RealEscape.CutRealizationPreservesAddition
import Ising2DLambda.RealEscape.CutRealizationPreservesMultiplication
import Ising2DLambda.RealEscape.CutRealizationAgreesOnRationals
import Ising2DLambda.KacWard.DispersionPolynomial
import Ising2DLambda.KacWard.RootOfUnityInverseRealClosedConjugate
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic

namespace Ising2DLambda.RealEscape

open Polynomial
open Ising2DLambda.FisherZero
open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.CriticalExponent
open Ising2DLambda.KacWard

/-- 本文の角 θ := 2π(k + c/2)/L。 -/
noncomputable def modeAngle (L : ℕ) (c : Bool) (k : ℕ) : ℝ :=
  2 * Real.pi * ((k : ℝ) + (if c then 1 else 0) / 2) / L

/-- 角の定義: exp(2πi(k + c/2)/L) = exp(iθ)。 -/
theorem complexRootCandidate_eq_exp_modeAngle (L : ℕ) (c : Bool) (k : ℕ) :
    complexRootCandidate L c k = Complex.exp ((modeAngle L c k : ℂ) * Complex.I) := by
  rw [complexRootCandidate, modeAngle]
  congr 1
  split_ifs <;> push_cast <;> ring

/-- 準備の段: ϖ ≠ 0（三行の矛盾）と ϖ + ϖ⁻¹ = 2α + 0·ω（三行）。 -/
theorem twistedMode_add_inv_decomposition (data : RealClosedSubfieldData) (n : ℕ) (hn : 0 < n)
    (z : Qbar) (hz : z ∈ RootOfUnity n) (a b : data.carrier)
    (h : z = (a : Qbar) + (b : Qbar) * data.omega) :
    z ≠ 0 ∧ z + z⁻¹ = ((2 * a : data.carrier) : Qbar) + ((0 : data.carrier) : Qbar) * data.omega := by
  -- `claim_root_of_unity_inverse_is_real_closed_conjugate`: ϖ⁻¹ = α − βω
  obtain ⟨_, hinv, hconj⟩ := rootOfUnity_inverse_realClosedConj data n hn z hz a b h
  have hz0 : z ≠ 0 := by
    intro h0
    have hzn : z ^ n = 1 := hz
    apply one_ne_zero (α := Qbar)
    calc (1 : Qbar) = z ^ n := hzn.symm
      -- ϖ = 0
      _ = 0 ^ n := by rw [h0]
      -- n ≥ 1
      _ = 0 := zero_pow hn.ne'
  refine ⟨hz0, ?_⟩
  calc z + z⁻¹
      -- ϖ と ϖ⁻¹ の表示
      = ((a : Qbar) + (b : Qbar) * data.omega) + ((a : Qbar) - (b : Qbar) * data.omega) := by
        rw [hinv, hconj]; nth_rewrite 1 [h]; rfl
    -- Qbar の加法
    _ = 2 * (a : Qbar) := by ring
    -- 0·ω = 0
    _ = ((2 * a : data.carrier) : Qbar) + ((0 : data.carrier) : Qbar) * data.omega := by
        push_cast; rw [zero_mul, add_zero]; norm_cast

/-- 本文の八行: ρ_C(ϖ) = exp(iθ) かつ ϖ ≠ 0 なら ρ_C(ϖ⁻¹) = exp(−iθ)。 -/
theorem complexAlgebraicRealization_inv_eq_exp_neg (data : RealClosedSubfieldData)
    (z : Qbar) (hz0 : z ≠ 0) (θ : ℝ)
    (hexp : complexAlgebraicRealization data z = Complex.exp ((θ : ℂ) * Complex.I)) :
    complexAlgebraicRealization data z⁻¹ = Complex.exp (-(θ : ℂ) * Complex.I) := by
  calc complexAlgebraicRealization data z⁻¹
      -- ℂ の単位元
      = 1 * complexAlgebraicRealization data z⁻¹ := (one_mul _).symm
    -- exp(0) = 1
    _ = Complex.exp 0 * complexAlgebraicRealization data z⁻¹ := by rw [Complex.exp_zero]
    -- ℂ の加法
    _ = Complex.exp (-(θ : ℂ) * Complex.I + (θ : ℂ) * Complex.I) *
          complexAlgebraicRealization data z⁻¹ := by
        rw [neg_mul, neg_add_cancel]
    -- 加法法則
    _ = Complex.exp (-(θ : ℂ) * Complex.I) * Complex.exp ((θ : ℂ) * Complex.I) *
          complexAlgebraicRealization data z⁻¹ := by
        rw [Complex.exp_add]
    -- ρ_C(ϖ) = exp(iθ)
    _ = Complex.exp (-(θ : ℂ) * Complex.I) *
          (complexAlgebraicRealization data z * complexAlgebraicRealization data z⁻¹) := by
        rw [hexp, mul_assoc]
    -- `claim_complex_realization_preserves_multiplication`
    _ = Complex.exp (-(θ : ℂ) * Complex.I) * complexAlgebraicRealization data (z * z⁻¹) := by
        rw [complexAlgebraicRealization_preserves_multiplication]
    -- ϖϖ⁻¹ = 1
    _ = Complex.exp (-(θ : ℂ) * Complex.I) * complexAlgebraicRealization data 1 := by
        rw [mul_inv_cancel₀ hz0]
    -- 単位元保存
    _ = Complex.exp (-(θ : ℂ) * Complex.I) := by
        rw [complexAlgebraicRealization_one, mul_one]

/-- 本文の九行: ρ_R(2α) = 2cos θ。 -/
theorem cutRealization_two_mul_eq_two_cos (data : RealClosedSubfieldData)
    (z : Qbar) (a : data.carrier)
    (hsum : z + z⁻¹ = ((2 * a : data.carrier) : Qbar) + ((0 : data.carrier) : Qbar) * data.omega)
    (θ : ℝ) (hexp : complexAlgebraicRealization data z = Complex.exp ((θ : ℂ) * Complex.I))
    (hexpInv : complexAlgebraicRealization data z⁻¹ = Complex.exp (-(θ : ℂ) * Complex.I)) :
    realAlgebraicCutRealization data (2 * a) = 2 * Real.cos θ := by
  calc realAlgebraicCutRealization data (2 * a)
      -- Re の定義
      = ((realAlgebraicCutRealization data (2 * a) : ℂ) +
          Complex.I * (realAlgebraicCutRealization data 0 : ℂ)).re := by
        simp
    -- `def_complex_algebraic_realization`
    _ = (complexAlgebraicRealization data
          (((2 * a : data.carrier) : Qbar) + ((0 : data.carrier) : Qbar) * data.omega)).re := by
        rw [complexAlgebraicRealization_eq data _ (2 * a) 0 rfl]
    -- ϖ + ϖ⁻¹ の係数表示
    _ = (complexAlgebraicRealization data (z + z⁻¹)).re := by rw [hsum]
    -- `claim_complex_realization_preserves_addition`
    _ = (complexAlgebraicRealization data z + complexAlgebraicRealization data z⁻¹).re := by
        rw [complexAlgebraicRealization_preserves_addition]
    -- 上の二つの複素実現
    _ = (Complex.exp ((θ : ℂ) * Complex.I) + Complex.exp (-(θ : ℂ) * Complex.I)).re := by
        rw [hexp, hexpInv]
    -- Euler の公式
    _ = ((Real.cos θ + Complex.I * Real.sin θ) +
          (Real.cos (-θ) + Complex.I * Real.sin (-θ)) : ℂ).re := by
        rw [Complex.exp_mul_I, ← Complex.ofReal_neg, Complex.exp_mul_I,
          ← Complex.ofReal_cos, ← Complex.ofReal_sin, ← Complex.ofReal_cos, ← Complex.ofReal_sin,
          mul_comm (Real.sin θ : ℂ), mul_comm (Real.sin (-θ) : ℂ)]
    -- 余弦・正弦の偶奇
    _ = ((Real.cos θ + Complex.I * Real.sin θ) +
          (Real.cos θ - Complex.I * Real.sin θ) : ℂ).re := by
        rw [Real.cos_neg, Real.sin_neg, Complex.ofReal_neg, mul_neg, ← sub_eq_add_neg]
    -- ℂ の四則
    _ = ((2 * Real.cos θ : ℝ) + Complex.I * (0 : ℝ) : ℂ).re := by
        congr 1; push_cast; ring
    -- Re の定義
    _ = 2 * Real.cos θ := by
        simp only [Complex.add_re, Complex.ofReal_re, Complex.mul_re, Complex.I_re, Complex.I_im,
          Complex.ofReal_im]
        ring

/-- `claim_dispersion_angle_realization` の具体版。
`ρ_R(Δ(q; ϖ, ς)) = (1+r²)² − 2r(1−r²)(cos θ₁ + cos θ₂)`（`r := ι(q)`）。 -/
theorem dispersion_angle_realization (data : RealClosedSubfieldData) (L : ℕ) (hL : 1 ≤ L)
    (s : SpinStructure) (varpi varsigma : Qbar)
    (hvarpi : varpi ∈ horizontalTwistedModes L s)
    (hvarsigma : varsigma ∈ verticalTwistedModes L s) (k l : ℕ)
    (hΘ : twistedModeProductRealization data (varpi, varsigma) =
      (complexRootCandidate L s.1 k, complexRootCandidate L s.2 l))
    (q : ℚ) (D : data.carrier)
    (hD : (D : Qbar) = (dispersionPolynomial varpi varsigma).eval (q : Qbar)) :
    realAlgebraicCutRealization data D =
      (1 + (q : ℝ) ^ 2) ^ 2 - 2 * (q : ℝ) * (1 - (q : ℝ) ^ 2) *
        (Real.cos (modeAngle L s.1 k) + Real.cos (modeAngle L s.2 l)) := by
  -- 準備: ϖ, ς ∈ μ_{2L}（`claim_twisted_modes_are_double_roots`）と一意表示
  have hn : 0 < 2 * L := by omega
  have hvarpiRoot : varpi ∈ RootOfUnity (2 * L) :=
    twistedModes_subset_doubleRoots L s (Or.inl hvarpi)
  have hvarsigmaRoot : varsigma ∈ RootOfUnity (2 * L) :=
    twistedModes_subset_doubleRoots L s (Or.inr hvarsigma)
  obtain ⟨⟨α, β⟩, hαβ, _⟩ := data.unique_decomposition varpi
  obtain ⟨⟨γ, δ⟩, hγδ, _⟩ := data.unique_decomposition varsigma
  obtain ⟨hvarpi0, hvarpiSum⟩ :=
    twistedMode_add_inv_decomposition data (2 * L) hn varpi hvarpiRoot α β hαβ
  obtain ⟨hvarsigma0, hvarsigmaSum⟩ :=
    twistedMode_add_inv_decomposition data (2 * L) hn varsigma hvarsigmaRoot γ δ hγδ
  -- ρ_C(ϖ) = pr₁(Θ(ϖ, ς)) = exp(2πi(k + a/2)/L) = exp(iθ₁)
  have hvarpiExp : complexAlgebraicRealization data varpi =
      Complex.exp ((modeAngle L s.1 k : ℂ) * Complex.I) := by
    calc complexAlgebraicRealization data varpi
        = (twistedModeProductRealization data (varpi, varsigma)).1 := rfl
      _ = complexRootCandidate L s.1 k := by rw [hΘ]
      _ = Complex.exp ((modeAngle L s.1 k : ℂ) * Complex.I) :=
        complexRootCandidate_eq_exp_modeAngle L s.1 k
  -- 縦方向は第二成分 pr₂ で同じ三行
  have hvarsigmaExp : complexAlgebraicRealization data varsigma =
      Complex.exp ((modeAngle L s.2 l : ℂ) * Complex.I) := by
    calc complexAlgebraicRealization data varsigma
        = (twistedModeProductRealization data (varpi, varsigma)).2 := rfl
      _ = complexRootCandidate L s.2 l := by rw [hΘ]
      _ = Complex.exp ((modeAngle L s.2 l : ℂ) * Complex.I) :=
        complexRootCandidate_eq_exp_modeAngle L s.2 l
  -- 二つの余弦表示
  have hcos₁ : realAlgebraicCutRealization data (2 * α) = 2 * Real.cos (modeAngle L s.1 k) :=
    cutRealization_two_mul_eq_two_cos data varpi α hvarpiSum _ hvarpiExp
      (complexAlgebraicRealization_inv_eq_exp_neg data varpi hvarpi0 _ hvarpiExp)
  have hcos₂ : realAlgebraicCutRealization data (2 * γ) = 2 * Real.cos (modeAngle L s.2 l) :=
    cutRealization_two_mul_eq_two_cos data varsigma γ hvarsigmaSum _ hvarsigmaExp
      (complexAlgebraicRealization_inv_eq_exp_neg data varsigma hvarsigma0 _ hvarsigmaExp)
  -- m := (1+q²)²、n := q(1−q²)、w := n(2α + 2γ)
  set m : data.carrier := realClosedRat data ((1 + q ^ 2) ^ 2) with hm
  set n : data.carrier := realClosedRat data (q * (1 - q ^ 2)) with hnDef
  set w : data.carrier := n * (2 * α + 2 * γ) with hw
  -- 分散因子の値の書き直し（三行）
  have hDR : D = m - w := by
    apply Subtype.ext
    calc (D : Qbar)
        -- `def_dispersion_polynomial` を x := q で評価
        = (1 + (q : Qbar) ^ 2) ^ 2 - (q : Qbar) * (1 - (q : Qbar) ^ 2) *
            (varpi + varpi⁻¹ + varsigma + varsigma⁻¹) := by
          rw [hD, dispersionPolynomial]
          simp only [eval_sub, eval_mul, eval_add, eval_pow, eval_X, eval_C, eval_one]
      -- m, n の定義
      _ = (m : Qbar) - (n : Qbar) * ((varpi + varpi⁻¹) + (varsigma + varsigma⁻¹)) := by
          simp only [hm, hnDef, realClosedRat]; push_cast; ring
      -- ϖ + ϖ⁻¹ と ς + ς⁻¹ の係数表示
      _ = ((m - w : data.carrier) : Qbar) := by
          rw [hvarpiSum, hvarsigmaSum, hw]; push_cast; ring
  calc realAlgebraicCutRealization data D
      -- 上の書き直し
      = realAlgebraicCutRealization data (m - w) := by rw [hDR]
    -- ℝ の加法
    _ = realAlgebraicCutRealization data (m - w) + realAlgebraicCutRealization data w -
          realAlgebraicCutRealization data w := by ring
    -- `claim_cut_realization_preserves_addition`
    _ = realAlgebraicCutRealization data ((m - w) + w) - realAlgebraicCutRealization data w := by
        rw [cutRealization_preserves_addition]
    -- R の加法
    _ = realAlgebraicCutRealization data m - realAlgebraicCutRealization data w := by
        rw [sub_add_cancel]
    -- `claim_cut_realization_preserves_multiplication`
    _ = realAlgebraicCutRealization data m -
          realAlgebraicCutRealization data n * realAlgebraicCutRealization data (2 * α + 2 * γ) := by
        rw [hw, cutRealization_preserves_multiplication]
    -- `claim_cut_realization_preserves_addition`
    _ = realAlgebraicCutRealization data m - realAlgebraicCutRealization data n *
          (realAlgebraicCutRealization data (2 * α) + realAlgebraicCutRealization data (2 * γ)) := by
        rw [cutRealization_preserves_addition]
    -- `claim_cut_realization_agrees_on_rationals` を m, n に適用
    _ = (((1 + q ^ 2) ^ 2 : ℚ) : ℝ) - ((q * (1 - q ^ 2) : ℚ) : ℝ) *
          (realAlgebraicCutRealization data (2 * α) + realAlgebraicCutRealization data (2 * γ)) := by
        rw [hm, hnDef, cutRealization_agrees_on_rationals, cutRealization_agrees_on_rationals]
    -- 二つの余弦表示
    _ = (((1 + q ^ 2) ^ 2 : ℚ) : ℝ) - ((q * (1 - q ^ 2) : ℚ) : ℝ) *
          (2 * Real.cos (modeAngle L s.1 k) + 2 * Real.cos (modeAngle L s.2 l)) := by
        rw [hcos₁, hcos₂]
    -- `def_real_logarithm` の包含写像は加法・乗法を保つ
    _ = (1 + (q : ℝ) ^ 2) ^ 2 - (q : ℝ) * (1 - (q : ℝ) ^ 2) *
          (2 * Real.cos (modeAngle L s.1 k) + 2 * Real.cos (modeAngle L s.2 l)) := by
        push_cast; ring
    -- ℝ の分配法則
    _ = (1 + (q : ℝ) ^ 2) ^ 2 - 2 * (q : ℝ) * (1 - (q : ℝ) ^ 2) *
          (Real.cos (modeAngle L s.1 k) + Real.cos (modeAngle L s.2 l)) := by
        ring

end Ising2DLambda.RealEscape
