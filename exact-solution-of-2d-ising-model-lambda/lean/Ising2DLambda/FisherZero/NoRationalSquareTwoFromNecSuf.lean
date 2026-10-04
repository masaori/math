/- 本文の各計算を供給し、既存の必要十分版の仮定を満たす導出版。 -/
import Ising2DLambda.FisherZero.NoRationalSquareTwo
import Ising2DLambda.NecSuf.FisherZero.NoRationalSquareTwo

namespace Ising2DLambda.FisherZero

open Ising2DLambda.FreeEntropy

private noncomputable def primeTwoForDerivation : Nat.Primes := ⟨2, Nat.prime_two⟩

/-- `claim_no_rational_square_two` の具体版を必要十分版から導く。 -/
theorem noRationalSquareTwo_from_necSuf (q : ℚ) : q * q ≠ 2 := by
  apply Ising2DLambda.NecSuf.FisherZero.no_rational_square_two_necSuf
      (square := fun r : ℚ => r * r = 2)
      (positive := fun r : ℚ => 0 < r)
      (negative := fun r : ℚ => r < 0)
      (isZero := fun r : ℚ => r = 0)
      (neg := fun r : ℚ => -r)
      (exponent := fun r : ℚ => rationalExponent primeTwoForDerivation r.num.natAbs r.den)
  · intro r
    rcases lt_trichotomy r 0 with hNeg | hZero | hPos
    · exact Or.inl hNeg
    · exact Or.inr (Or.inl hZero)
    · exact Or.inr (Or.inr hPos)
  · intro q hZero hSquare
    have hZeroProduct : q * q = 0 := by
      calc
        q * q = 0 * 0 := by rw [hZero]
        _ = 0 := zero_mul 0
    exact (by norm_num : (2 : ℚ) ≠ 0) (hSquare.symm.trans hZeroProduct)
  · intro r hNeg
    exact neg_pos.mpr hNeg
  · intro q _ hSquare
    let r : ℚ := -q
    calc
      r * r = (-q) * (-q) := rfl
      _ = -(q * (-q)) := neg_mul q (-q)
      _ = -(-(q * q)) := congrArg Neg.neg (mul_neg q q)
      _ = q * q := neg_neg _
      _ = 2 := hSquare
  · intro q hPos hqSquare
    let r : ℚ := q
    have hr : 0 < r := hPos
    have hSquare : r * r = 2 := by
      calc
        r * r = q * q := rfl
        _ = 2 := hqSquare
    let w : ℚ → ℤ := fun x => rationalExponent primeTwoForDerivation x.num.natAbs x.den
    let m : ℤ := w r
    have hPrimeTwo : primeExponent primeTwoForDerivation 2 = 1 := by
      norm_num [primeExponent, primeTwoForDerivation, Nat.Prime.factorization_self Nat.prime_two]
    have hRepresentation : w (2 : ℚ) =
        (primeExponent primeTwoForDerivation 2 : ℤ) - (primeExponent primeTwoForDerivation 1 : ℤ) := by
      rfl
    -- 本文の指数の十等号。仮定を使うのは w(2) = w(r*r) の一行だけ。
    have hDouble : (1 : ℤ) = m + m := by
      calc
        (1 : ℤ) = 1 - 0 := (sub_zero 1).symm
        _ = (primeExponent primeTwoForDerivation 2 : ℤ) - 0 := by rw [hPrimeTwo, Nat.cast_one]
        _ = (primeExponent primeTwoForDerivation 2 : ℤ) - (primeExponent primeTwoForDerivation 1 : ℤ) := by
          rw [primeExponent_one, Nat.cast_zero]
        _ = w (2 : ℚ) := hRepresentation.symm
        _ = w (r * r) := by rw [hSquare]
        _ = logRat (r * r) primeTwoForDerivation := (logRat_apply _ _).symm
        _ = (logRat r + logRat r) primeTwoForDerivation :=
          congrArg (fun value : LogOrderGroup => value primeTwoForDerivation) (logRat_mul hr hr)
        _ = logRat r primeTwoForDerivation + logRat r primeTwoForDerivation := rfl
        _ = w r + w r := by rw [logRat_apply]
        _ = m + m := rfl
    exact hDouble
  · intro m hDouble
    -- 整数の離散順序による二場合。各加数の比較を一行ずつ行う。
    by_cases hHigh : 1 ≤ m
    · have hGreater : m + m > 1 := by
        calc
          m + m ≥ 1 + m := Int.add_le_add_right hHigh m
          _ ≥ 1 + 1 := Int.add_le_add_left hHigh 1
          _ = 2 := rfl
          _ > 1 := by decide
      exact (ne_of_gt hGreater) hDouble.symm
    · have hLow : m ≤ 0 := by omega
      have hLess : m + m < 1 := by
        calc
          m + m ≤ 0 + m := Int.add_le_add_right hLow m
          _ ≤ 0 + 0 := Int.add_le_add_left hLow 0
          _ = 0 := zero_add 0
          _ < 1 := by decide
      exact (ne_of_lt hLess) hDouble.symm

end Ising2DLambda.FisherZero
