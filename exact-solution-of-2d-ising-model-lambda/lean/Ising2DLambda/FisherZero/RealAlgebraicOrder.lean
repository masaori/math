/-
人手証明の「有理数は実代数的数である」「零元でない実代数的数の平方は -1 に
ならない」「実代数的数の狭義順序・広義順序・三分法」の具体版。

住処: Q と Qbar。R / C は現れない。
-/
import Ising2DLambda.FisherZero.RealClosedSubfield

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `claim_rationals_are_real_algebraic` の具体版。 -/
theorem rational_mem_realClosedCarrier (data : RealClosedSubfieldData) (q : ℚ) :
    (q : Qbar) ∈ data.carrier := by
  have hNat : ∀ n : ℕ, (n : Qbar) ∈ data.carrier := by
    intro n
    induction n with
    | zero => simpa using data.carrier.zero_mem
    | succ n hn =>
        simpa [Nat.cast_succ] using data.carrier.add_mem hn data.carrier.one_mem
  have hInt : ∀ k : ℤ, (k : Qbar) ∈ data.carrier := by
    intro k
    cases k with
    | ofNat n => exact hNat n
    | negSucc n =>
        simpa using data.carrier.neg_mem (hNat (n + 1))
  simpa only [Rat.cast_def] using data.carrier.div_mem (hInt q.num) (hNat q.den)

/-- `claim_neg_one_not_square` の具体版。 -/
theorem negOne_not_square_realClosedCarrier
    (data : RealClosedSubfieldData) (w : data.carrier) (hw : w ≠ 0) :
    w * w ≠ -1 := by
  intro hsquare
  have htri := data.squareTrichotomy (1 : data.carrier)
  apply htri.2.2.2
  constructor
  · exact ⟨1, one_ne_zero, by simp⟩
  · exact ⟨w, hw, hsquare.symm⟩

/-- `def_real_algebraic_strict_order` の具体版。 -/
def realAlgebraicLt (data : RealClosedSubfieldData)
    (a b : data.carrier) : Prop :=
  ∃ w : data.carrier, w ≠ 0 ∧ b - a = w * w

/-- `def_real_algebraic_nonstrict_order` の具体版。 -/
def realAlgebraicLe (data : RealClosedSubfieldData)
    (a b : data.carrier) : Prop :=
  realAlgebraicLt data a b ∨ a = b

/-- `claim_real_algebraic_order_trichotomy` の具体版。 -/
theorem realAlgebraicLt_trichotomy (data : RealClosedSubfieldData)
    (a b : data.carrier) :
    ExactlyOneOfThree
      (realAlgebraicLt data a b)
      (a = b)
      (realAlgebraicLt data b a) := by
  have hzero : b - a = 0 ↔ a = b := by
    constructor
    · intro h
      exact (sub_eq_zero.mp h).symm
    · intro h
      exact sub_eq_zero.mpr h.symm
  have hpositive :
      (∃ w : data.carrier, w ≠ 0 ∧ b - a = w * w) ↔
        realAlgebraicLt data a b := Iff.rfl
  have hnegative :
      (∃ w : data.carrier, w ≠ 0 ∧ -(b - a) = w * w) ↔
        realAlgebraicLt data b a := by
    simp only [realAlgebraicLt, neg_sub]
  rcases data.squareTrichotomy (b - a) with ⟨hcases, hzeroPositive, hzeroNegative,
    hpositiveNegative⟩
  constructor
  · rcases hcases with h | h | h
    · exact Or.inr (Or.inl (hzero.mp h))
    · exact Or.inl (hpositive.mp h)
    · exact Or.inr (Or.inr (hnegative.mp h))
  constructor
  · rintro ⟨h, heq⟩
    exact hzeroPositive ⟨hzero.mpr heq, hpositive.mpr h⟩
  constructor
  · rintro ⟨h, h'⟩
    exact hpositiveNegative ⟨hpositive.mpr h, hnegative.mpr h'⟩
  · rintro ⟨heq, h⟩
    exact hzeroNegative ⟨hzero.mpr heq, hnegative.mpr h⟩

end Ising2DLambda.FisherZero
