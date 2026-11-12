/-
章「有限 Fourier 分解と分散関係」の「分散因子は零と一の間の有理点で正である」
（`claim_dispersion_positive_at_rational_point`）の具体版。

  人手証明                                                          このファイル
  ϖ, ς ∈ μ_{2L}                                                     `twistedModes_subset_doubleRoots`
  ϖ = α+βω、α²+β² = 1、ϖ^{-1} = α−βω（共役の主張を指数 2L で）       `rootOfUnity_inverse_realClosedConj`
  2−ϖ−ϖ^{-1} の五行（= c_ϖ·c_ϖ）                                     `two_sub_rootOfUnity_sub_inv_eq_square`
  r := q(1−q)(1+q) > 0、0 <_R r、r = s·s                             `positiveRational_realAlgebraic_positive`
  q(1−q²) = q(1−q)(1+q) = r = s·s                                    本定理の `hqs`
  c_ϖ·c_ϖ + c_ς·c_ς = e·e                                            `realClosed_sum_of_two_squares_is_square`
  Δ(q) − p² の四行（= (se)·(se)）                                    本定理の `hmain`
  Δ(q) = p² + (se)·(se) ∈ R、p² ≤_R Δ(q)（se ≠ 0 / se = 0）          本定理の結論の第三成分
  p = 0 なら (q+1)(q+1) = q²+2q+1 = p+2 = 2 で矛盾                   `rational_selfDual_ne_zero`
  0 <_R p² （p²−0 = p·p、p ≠ 0）                                     本定理の結論の第二成分

p² は `p·p` と書く。順序の事実は本文の定義・主張（狭義順序・広義順序の定義、正の有理数は正、
二つの平方の和は平方）の具体版を引く。必要十分版の定理・定義は使わない。
住処: Q と Qbar（実閉部分体 R ⊂ Qbar）。実数体・複素数体は現れない。
-/
import Ising2DLambda.KacWard.DispersionPositiveDecomposition
import Ising2DLambda.KacWard.RootOfUnityInverseRealClosedConjugate
import Ising2DLambda.KacWard.TwistedModeSets
import Ising2DLambda.CriticalExponent.RealAlgebraicRationalBounds
import Ising2DLambda.FisherZero.NoRationalSquareTwo

namespace Ising2DLambda.KacWard

open Polynomial
open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.FisherZero
open Ising2DLambda.CriticalExponent

/-- `2 − ζ − ζ^{-1} = c·c` の五行。
`2 − (α+βω) − (α−βω) = 2 − 2α = 1 − 2α + (α²+β²) = (1−α)² + β² = c·c`。 -/
theorem two_sub_rootOfUnity_sub_inv_eq_square (data : RealClosedSubfieldData) (n : ℕ)
    (hn : 0 < n) (z : Qbar) (hz : z ∈ RootOfUnity n) :
    ∃ c : data.carrier, 2 - z - z⁻¹ = ((c * c : data.carrier) : Qbar) := by
  obtain ⟨⟨a, b⟩, h, _⟩ := data.unique_decomposition z
  obtain ⟨hN, hinv, hconj⟩ := rootOfUnity_inverse_realClosedConj data n hn z hz a b h
  obtain ⟨c, hc⟩ := realClosed_sum_of_two_squares_is_square data (1 - a) b
  have hNq : (a : Qbar) * (a : Qbar) + (b : Qbar) * (b : Qbar) = 1 := by
    have hcast := congrArg (fun t : data.carrier => (t : Qbar)) hN
    push_cast at hcast
    exact hcast
  refine ⟨c, ?_⟩
  calc 2 - z - z⁻¹
      = 2 - ((a : Qbar) + (b : Qbar) * data.omega) - ((a : Qbar) - (b : Qbar) * data.omega) := by
        rw [hinv, hconj]; nth_rewrite 1 [h]; rfl
    _ = 2 - 2 * (a : Qbar) := by ring
    _ = 1 - 2 * (a : Qbar) + ((a : Qbar) * (a : Qbar) + (b : Qbar) * (b : Qbar)) := by
        rw [hNq]; ring
    _ = (((1 - a) * (1 - a) + b * b : data.carrier) : Qbar) := by push_cast; ring
    _ = ((c * c : data.carrier) : Qbar) := by rw [hc]

/-- `p := q² + 2q − 1 ≠ 0`。`p = 0` なら `(q+1)(q+1) = q²+2q+1 = p+2 = 2` となり
`claim_no_rational_square_two` に反する。 -/
theorem rational_selfDual_ne_zero (q : ℚ) : q ^ 2 + 2 * q - 1 ≠ 0 := by
  intro hp
  apply noRationalSquareTwo (q + 1)
  calc (q + 1) * (q + 1) = q ^ 2 + 2 * q + 1 := by ring
    _ = (q ^ 2 + 2 * q - 1) + 2 := by ring
    _ = 2 := by rw [hp]; ring

/-- `claim_dispersion_positive_at_rational_point` の具体版。
`D ∈ R` で `D = Δ(q;ϖ,ς)`、`0 <_R p·p`、`p·p ≤_R D`（`p := q²+2q−1`）。 -/
theorem dispersion_positive_at_rationalPoint (data : RealClosedSubfieldData) (L : ℕ)
    (hL : 1 ≤ L) (spin : SpinStructure) (varpi varsigma : Qbar)
    (hvarpi : varpi ∈ horizontalTwistedModes L spin)
    (hvarsigma : varsigma ∈ verticalTwistedModes L spin)
    (q : ℚ) (hq0 : 0 < q) (hq1 : q < 1) :
    ∃ D : data.carrier,
      (D : Qbar) = (dispersionPolynomial varpi varsigma).eval (q : Qbar) ∧
      realAlgebraicLt data 0
        (realClosedRat data (q ^ 2 + 2 * q - 1) * realClosedRat data (q ^ 2 + 2 * q - 1)) ∧
      realAlgebraicLe data
        (realClosedRat data (q ^ 2 + 2 * q - 1) * realClosedRat data (q ^ 2 + 2 * q - 1)) D := by
  -- ϖ, ς ∈ μ_{2L}（`claim_twisted_modes_are_double_roots`）
  have hn : 0 < 2 * L := by omega
  have hvarpiRoot : varpi ∈ RootOfUnity (2 * L) :=
    twistedModes_subset_doubleRoots L spin (Or.inl hvarpi)
  have hvarsigmaRoot : varsigma ∈ RootOfUnity (2 * L) :=
    twistedModes_subset_doubleRoots L spin (Or.inr hvarsigma)
  -- 2 − ϖ − ϖ^{-1} = c_ϖ·c_ϖ、2 − ς − ς^{-1} = c_ς·c_ς
  obtain ⟨cvarpi, hcvarpi⟩ := two_sub_rootOfUnity_sub_inv_eq_square data (2 * L) hn varpi hvarpiRoot
  obtain ⟨cvarsigma, hcvarsigma⟩ :=
    two_sub_rootOfUnity_sub_inv_eq_square data (2 * L) hn varsigma hvarsigmaRoot
  -- c_ϖ·c_ϖ + c_ς·c_ς = e·e
  obtain ⟨e, he⟩ := realClosed_sum_of_two_squares_is_square data cvarpi cvarsigma
  -- r := q(1−q)(1+q) は正の有理数なので 0 <_R r、r = s·s
  have hr : 0 < q * (1 - q) * (1 + q) := by
    have h1 : 0 < 1 - q := by linarith
    have h2 : 0 < 1 + q := by linarith
    positivity
  obtain ⟨s, hs0, hs⟩ := positiveRational_realAlgebraic_positive data _ hr
  have hsQ : ((q * (1 - q) * (1 + q) : ℚ) : Qbar) = (s : Qbar) * (s : Qbar) := by
    have hcast := congrArg (fun t : data.carrier => (t : Qbar)) hs
    push_cast at hcast ⊢
    rw [← hcast]; ring
  -- q(1−q²) = q(1−q)(1+q) = r = s·s
  have hqs : (q : Qbar) * (1 - (q : Qbar) ^ 2) = (s : Qbar) * (s : Qbar) := by
    calc (q : Qbar) * (1 - (q : Qbar) ^ 2)
        = ((q * (1 - q) * (1 + q) : ℚ) : Qbar) := by push_cast; ring
      _ = (s : Qbar) * (s : Qbar) := hsQ
  -- 分散因子の正値分解を x := q で評価する
  have hdec := congrArg (Polynomial.eval (q : Qbar)) (dispersion_positive_decomposition varpi varsigma)
  simp only [eval_sub, eval_mul, eval_add, eval_pow, eval_X, eval_C, eval_ofNat, eval_one] at hdec
  set p : ℚ := q ^ 2 + 2 * q - 1 with hpdef
  have hpQ : ((p : ℚ) : Qbar) = (q : Qbar) ^ 2 + 2 * (q : Qbar) - 1 := by
    rw [hpdef]; push_cast; ring
  -- Δ(q) − p² の四行
  have hmain : (dispersionPolynomial varpi varsigma).eval (q : Qbar) - (p : Qbar) * (p : Qbar)
      = (((s * e) * (s * e) : data.carrier) : Qbar) := by
    calc (dispersionPolynomial varpi varsigma).eval (q : Qbar) - (p : Qbar) * (p : Qbar)
        = (q : Qbar) * (1 - (q : Qbar) ^ 2) *
            ((2 - varpi - varpi⁻¹) + (2 - varsigma - varsigma⁻¹)) := by
          rw [hpQ, ← hdec]; ring
      _ = ((s : Qbar) * (s : Qbar)) *
            (((cvarpi * cvarpi : data.carrier) : Qbar) + ((cvarsigma * cvarsigma : data.carrier) : Qbar)) := by
          rw [hqs, hcvarpi, hcvarsigma]
      _ = ((s : Qbar) * (s : Qbar)) * ((e * e : data.carrier) : Qbar) := by
          rw [← he]; push_cast; ring
      _ = (((s * e) * (s * e) : data.carrier) : Qbar) := by push_cast; ring
  -- p ≠ 0
  have hp0 : p ≠ 0 := rational_selfDual_ne_zero q
  have hPQ : ((realClosedRat data p : data.carrier) : Qbar) = (p : Qbar) := rfl
  have hP0 : realClosedRat data p ≠ 0 := by
    intro h
    have hcast : ((realClosedRat data p : data.carrier) : Qbar) = 0 := by rw [h]; rfl
    rw [hPQ] at hcast
    exact hp0 (Rat.cast_eq_zero.mp hcast)
  -- D := p·p + (se)·(se)
  refine ⟨realClosedRat data p * realClosedRat data p + (s * e) * (s * e), ?_, ?_, ?_⟩
  · have hcoe : ((realClosedRat data p * realClosedRat data p + (s * e) * (s * e) : data.carrier) : Qbar)
        = (p : Qbar) * (p : Qbar) + (((s * e) * (s * e) : data.carrier) : Qbar) := by
      push_cast [hPQ]; ring
    rw [hcoe, ← hmain]; ring
  · exact ⟨realClosedRat data p, hP0, by ring⟩
  · by_cases hse : s * e = 0
    · right
      rw [hse]; ring
    · left
      exact ⟨s * e, hse, by ring⟩

end Ising2DLambda.KacWard
