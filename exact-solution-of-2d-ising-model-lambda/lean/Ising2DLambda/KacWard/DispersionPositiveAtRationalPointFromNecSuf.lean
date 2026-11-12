/-
`claim_dispersion_positive_at_rational_point` の具体版が、必要十分版
`dispersion_positive_at_rationalPoint_necSuf` の R := 実閉部分体、K := Q̄、ι := 包含、
j := 有理数の所属（`realClosedRat`）、ω := 固定した虚数単位への特殊化として得られること。
共役の表示、正の有理数は正、二つの平方の和は平方、有理数の平方は 2 にならないことは本文の主張の具体版から与える。
住処: Q と Qbar。実数体・複素数体は現れない。
-/
import Ising2DLambda.KacWard.DispersionPositiveAtRationalPoint
import Ising2DLambda.NecSuf.KacWard.DispersionPositiveAtRationalPoint

namespace Ising2DLambda.KacWard

open Polynomial
open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.FisherZero
open Ising2DLambda.CriticalExponent

/-- 有理数の所属 `realClosedRat` は環準同型である。 -/
noncomputable def realClosedRatHom (data : RealClosedSubfieldData) : ℚ →+* data.carrier where
  toFun := realClosedRat data
  map_one' := Subtype.ext (by show ((1 : ℚ) : Qbar) = 1; push_cast; rfl)
  map_mul' a b := Subtype.ext (by show ((a * b : ℚ) : Qbar) = (a : Qbar) * (b : Qbar); push_cast; rfl)
  map_zero' := Subtype.ext (by show ((0 : ℚ) : Qbar) = 0; push_cast; rfl)
  map_add' a b := Subtype.ext (by show ((a + b : ℚ) : Qbar) = (a : Qbar) + (b : Qbar); push_cast; rfl)

theorem dispersion_positive_at_rationalPoint_from_necSuf (data : RealClosedSubfieldData) (L : ℕ)
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
  have hn : 0 < 2 * L := by omega
  have hvarpiRoot : varpi ∈ RootOfUnity (2 * L) :=
    twistedModes_subset_doubleRoots L spin (Or.inl hvarpi)
  have hvarsigmaRoot : varsigma ∈ RootOfUnity (2 * L) :=
    twistedModes_subset_doubleRoots L spin (Or.inr hvarsigma)
  obtain ⟨⟨a, b⟩, hab, _⟩ := data.unique_decomposition varpi
  obtain ⟨⟨c, d⟩, hcd, _⟩ := data.unique_decomposition varsigma
  obtain ⟨hNab, hinvab, hconjab⟩ := rootOfUnity_inverse_realClosedConj data _ hn varpi hvarpiRoot a b hab
  obtain ⟨hNcd, hinvcd, hconjcd⟩ :=
    rootOfUnity_inverse_realClosedConj data _ hn varsigma hvarsigmaRoot c d hcd
  obtain ⟨D, hD, hlt, hle⟩ :=
    Ising2DLambda.NecSuf.KacWard.dispersion_positive_at_rationalPoint_necSuf
      data.carrier.subtype (realClosedRatHom data) data.omega
      (fun u v => realClosed_sum_of_two_squares_is_square data u v)
      (fun r hr => positiveRational_realAlgebraic_positive data r hr)
      noRationalSquareTwo
      varpi varpi⁻¹ varsigma varsigma⁻¹ a b c d hab (hinvab.trans hconjab) hNab
      hcd (hinvcd.trans hconjcd) hNcd q hq0 hq1
  refine ⟨D, ?_, hlt, hle⟩
  have hjq : (data.carrier.subtype (realClosedRatHom data q) : Qbar) = (q : Qbar) := rfl
  rw [show (D : Qbar) = data.carrier.subtype D from rfl, hD, hjq]
  simp only [dispersionPolynomial, eval_sub, eval_mul, eval_add, eval_pow, eval_X, eval_C,
    eval_one]

end Ising2DLambda.KacWard
