/- 有理数の演算・対数の成分・整数の離散順序へ必要十分版を特殊化する。 -/
import Ising2DLambda.FreeEntropy.Additivity
import Ising2DLambda.NecSuf.FisherZero.NoRationalSquareTwo

namespace Ising2DLambda.FisherZero

open Ising2DLambda.FreeEntropy

private noncomputable def primeTwoForDerivation : Nat.Primes := ⟨2, Nat.prime_two⟩

/-- `claim_no_rational_square_two` の具体版を必要十分版から導く。 -/
theorem noRationalSquareTwo_from_necSuf (q : ℚ) : q * q ≠ 2 := by
  apply Ising2DLambda.NecSuf.FisherZero.no_rational_square_two_necSuf
      (target := (2 : ℚ))
      (positive := fun r : ℚ => 0 < r)
      (negative := fun r : ℚ => r < 0)
      (exponent := fun r : ℚ => rationalExponent primeTwoForDerivation r.num.natAbs r.den)
      (log := logRat) (component := fun value : LogOrderGroup => value primeTwoForDerivation)
      (primeExpTwo := (primeExponent primeTwoForDerivation 2 : ℤ))
      (primeExpOne := (primeExponent primeTwoForDerivation 1 : ℤ))
  · intro r
    exact lt_trichotomy r 0
  · norm_num
  · exact zero_mul 0
  · intro r hNeg
    exact neg_pos.mpr hNeg
  · exact neg_mul
  · exact mul_neg
  · exact neg_neg
  · norm_num [primeExponent, primeTwoForDerivation,
      Nat.Prime.factorization_self Nat.prime_two]
  · rw [primeExponent_one, Nat.cast_zero]
  · rfl
  · intro r
    exact logRat_apply r primeTwoForDerivation
  · intro r s hr hs
    exact logRat_mul hr hs
  · intro a b
    rfl
  · exact sub_zero
  · exact zero_add
  · intro m
    by_cases hHigh : 1 ≤ m
    · exact Or.inl hHigh
    · exact Or.inr (by omega)
  · intro a b h c
    exact Int.add_le_add_right h c
  · intro a b h c
    exact Int.add_le_add_left h c
  · decide
  · decide

end Ising2DLambda.FisherZero
