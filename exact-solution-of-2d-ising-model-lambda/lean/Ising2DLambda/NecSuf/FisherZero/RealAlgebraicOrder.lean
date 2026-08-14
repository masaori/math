/-
「実代数的数の順序」の必要十分版。

有理数の所属に要るのは、零元・単位元の所属と加法・加法逆元・乗法・非零元の
逆元についての閉性だけである。三分法に要るのは三つの場合の排他性と、差の零性・
符号反転を各場合へ読み替える規則だけである。代数閉性や順序は要求しない。
-/
import Mathlib.Algebra.Field.Defs
import Mathlib.Data.Rat.Cast.CharZero

namespace Ising2DLambda.NecSuf.FisherZero

/-- 三つの命題のちょうど一つが成り立つこと。 -/
def ExactlyOneOfThree (p q r : Prop) : Prop :=
  (p ∨ q ∨ r) ∧ ¬(p ∧ q) ∧ ¬(p ∧ r) ∧ ¬(q ∧ r)

/-- 部分集合が体の有理数生成に使う演算で閉じていれば、すべての有理数像を含む。 -/
theorem rational_mem_of_closure_necSuf
    {K : Type} [DivisionRing K] [CharZero K]
    (carrier : K → Prop)
    (hzero : carrier 0) (hone : carrier 1)
    (hadd : ∀ {a b}, carrier a → carrier b → carrier (a + b))
    (hneg : ∀ {a}, carrier a → carrier (-a))
    (hmul : ∀ {a b}, carrier a → carrier b → carrier (a * b))
    (hinv : ∀ {a}, carrier a → a ≠ 0 → carrier a⁻¹)
    (q : ℚ) : carrier (q : K) := by
  have hNat : ∀ n : ℕ, carrier (n : K) := by
    intro n
    induction n with
    | zero => simpa using hzero
    | succ n hn => simpa [Nat.cast_succ] using hadd hn hone
  have hInt : ∀ k : ℤ, carrier (k : K) := by
    intro k
    cases k with
    | ofNat n => simpa using hNat n
    | negSucc n => simpa using hneg (hNat (n + 1))
  have hden : (q.den : K) ≠ 0 := by
    exact_mod_cast q.den_nz
  simpa only [Rat.cast_def, div_eq_mul_inv] using
    hmul (hInt q.num) (hinv (hNat q.den) hden)

/-- 三分法の第二・第三の場合が同時には成立しない、という論理的な核。 -/
theorem positive_negative_exclusive_necSuf
    {p q r : Prop} (h : ExactlyOneOfThree p q r) (hq : q) (hr : r) : False := by
  exact h.2.2.2 ⟨hq, hr⟩

/-- 正の差で定める狭義順序。 -/
def strictOrderOfDifference {K : Type}
    (difference : K → K → K) (positive : K → Prop) (a b : K) : Prop :=
  positive (difference b a)

/-- 狭義順序と等号で定める広義順序。 -/
def nonstrictOrderOfDifference {K : Type}
    (difference : K → K → K) (positive : K → Prop) (a b : K) : Prop :=
  strictOrderOfDifference difference positive a b ∨ a = b

/-- 差の三分法を、差で定めた狭義順序の三分法へ読み替える。 -/
theorem strictOrderOfDifference_trichotomy_necSuf
    {K : Type} (difference : K → K → K) (negative : K → K)
    (positive : K → Prop) (zero a b : K)
    (htri : ExactlyOneOfThree
      (difference b a = zero)
      (positive (difference b a))
      (positive (negative (difference b a))))
    (hzero : difference b a = zero ↔ a = b)
    (hnegative : negative (difference b a) = difference a b) :
    ExactlyOneOfThree
      (strictOrderOfDifference difference positive a b)
      (a = b)
      (strictOrderOfDifference difference positive b a) := by
  have hnegativeIff :
      positive (negative (difference b a)) ↔
        strictOrderOfDifference difference positive b a := by
    simp only [strictOrderOfDifference, hnegative]
  rcases htri with ⟨hcases, hzeroPositive, hzeroNegative, hpositiveNegative⟩
  constructor
  · rcases hcases with h | h | h
    · exact Or.inr (Or.inl (hzero.mp h))
    · exact Or.inl h
    · exact Or.inr (Or.inr (hnegativeIff.mp h))
  constructor
  · rintro ⟨h, heq⟩
    exact hzeroPositive ⟨hzero.mpr heq, h⟩
  constructor
  · rintro ⟨h, h'⟩
    exact hpositiveNegative ⟨h, hnegativeIff.mpr h'⟩
  · rintro ⟨heq, h⟩
    exact hzeroNegative ⟨hzero.mpr heq, hnegativeIff.mpr h⟩

end Ising2DLambda.NecSuf.FisherZero
