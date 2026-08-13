/-
「有理数の平方は二にならない」の具体版。
人手証明と同じく、符号で正の有理数へ帰着し、素数 2 における対数の成分から
`1 = m + m` を得て整数の順序で矛盾させる。住処は Q / Z / Λ である。
-/
import Ising2DLambda.FreeEntropy.Additivity

namespace Ising2DLambda.FisherZero

open Ising2DLambda.FreeEntropy

private noncomputable def primeTwo : Nat.Primes := ⟨2, Nat.prime_two⟩

private lemma logRat_two_at_two : logRat (2 : ℚ) primeTwo = 1 := by
  rw [logRat_apply]
  norm_num [rationalExponent, primeExponent_one, primeExponent, primeTwo,
    Nat.Prime.factorization_self Nat.prime_two]

private lemma noSquareTwo_of_pos {r : ℚ} (hr : 0 < r) : r * r ≠ 2 := by
  intro hSquare
  let m : ℤ := logRat r primeTwo
  have hDouble : (1 : ℤ) = m + m := by
    calc
      (1 : ℤ) = logRat (2 : ℚ) primeTwo := logRat_two_at_two.symm
      _ = logRat (r * r) primeTwo := by rw [hSquare]
      _ = (logRat r + logRat r) primeTwo :=
        congrArg (fun value : LogOrderGroup => value primeTwo) (logRat_mul hr hr)
      _ = logRat r primeTwo + logRat r primeTwo := rfl
      _ = m + m := rfl
  omega

/-- `claim_no_rational_square_two` の具体版。 -/
theorem noRationalSquareTwo (q : ℚ) : q * q ≠ 2 := by
  intro hSquare
  rcases lt_trichotomy q 0 with hNeg | hZero | hPos
  · apply noSquareTwo_of_pos (neg_pos.mpr hNeg)
    calc
      (-q) * (-q) = q * q := by ring
      _ = 2 := hSquare
  · subst q
    norm_num at hSquare
  · exact noSquareTwo_of_pos hPos hSquare

end Ising2DLambda.FisherZero
