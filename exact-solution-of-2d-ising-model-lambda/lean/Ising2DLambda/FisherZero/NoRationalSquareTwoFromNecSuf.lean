import Ising2DLambda.FisherZero.NoRationalSquareTwo
import Ising2DLambda.NecSuf.FisherZero.NoRationalSquareTwo

namespace Ising2DLambda.FisherZero

open Ising2DLambda.FreeEntropy

private noncomputable def primeTwoForDerivation : Nat.Primes := ⟨2, Nat.prime_two⟩

private lemma logRat_two_at_two_for_derivation :
    logRat (2 : ℚ) primeTwoForDerivation = 1 := by
  rw [logRat_apply]
  norm_num [rationalExponent, primeExponent_one, primeExponent, primeTwoForDerivation,
    Nat.Prime.factorization_self Nat.prime_two]

/-- `claim_no_rational_square_two` の具体版を必要十分版から導く。 -/
theorem noRationalSquareTwo_from_necSuf (q : ℚ) : q * q ≠ 2 := by
  apply Ising2DLambda.NecSuf.FisherZero.no_rational_square_two_necSuf
      (square := fun r : ℚ => r * r = 2)
      (positive := fun r : ℚ => 0 < r)
      (negative := fun r : ℚ => r < 0)
      (isZero := fun r : ℚ => r = 0)
      (neg := fun r : ℚ => -r)
      (exponent := fun r : ℚ => logRat r primeTwoForDerivation)
  · intro r
    rcases lt_trichotomy r 0 with hNeg | hZero | hPos
    · exact Or.inl hNeg
    · exact Or.inr (Or.inl hZero)
    · exact Or.inr (Or.inr hPos)
  · intro r hZero hSquare
    subst r
    norm_num at hSquare
  · intro r hNeg
    exact neg_pos.mpr hNeg
  · intro r _ hSquare
    calc
      (-r) * (-r) = r * r := by ring
      _ = 2 := hSquare
  · intro r hPos hSquare
    calc
      (1 : ℤ) = logRat (2 : ℚ) primeTwoForDerivation :=
        logRat_two_at_two_for_derivation.symm
      _ = logRat (r * r) primeTwoForDerivation := by rw [hSquare]
      _ = (logRat r + logRat r) primeTwoForDerivation :=
        congrArg (fun value : LogOrderGroup => value primeTwoForDerivation)
          (logRat_mul hPos hPos)
      _ = logRat r primeTwoForDerivation + logRat r primeTwoForDerivation := rfl
  · intro m h
    omega

end Ising2DLambda.FisherZero
