/-
「有理数の平方は二にならない」の具体版。
符号で正の有理数へ帰着し、素数二での指数を数えて整数の順序で矛盾させる。
本文の零・正・負の枝、指数の十等号、左右を分けた順序不等式に対応する。
住処は Q / Z / Λ である。
-/
import Ising2DLambda.FreeEntropy.Additivity

namespace Ising2DLambda.FisherZero

open Ising2DLambda.FreeEntropy

private noncomputable def primeTwo : Nat.Primes := ⟨2, Nat.prime_two⟩

private lemma noSquareTwo_of_pos {r : ℚ} (hr : 0 < r) : r * r ≠ 2 := by
  intro hSquare
  let w : ℚ → ℤ := fun x => rationalExponent primeTwo x.num.natAbs x.den
  let m : ℤ := w r
  have hPrimeTwo : primeExponent primeTwo 2 = 1 := by
    norm_num [primeExponent, primeTwo, Nat.Prime.factorization_self Nat.prime_two]
  have hRepresentation : w (2 : ℚ) =
      (primeExponent primeTwo 2 : ℤ) - (primeExponent primeTwo 1 : ℤ) := by
    rfl
  -- 本文の指数の十等号。仮定を使うのは w(2) = w(r*r) の一行だけ。
  have hDouble : (1 : ℤ) = m + m := by
    calc
      (1 : ℤ) = 1 - 0 := (sub_zero 1).symm
      _ = (primeExponent primeTwo 2 : ℤ) - 0 := by rw [hPrimeTwo, Nat.cast_one]
      _ = (primeExponent primeTwo 2 : ℤ) - (primeExponent primeTwo 1 : ℤ) := by
        rw [primeExponent_one, Nat.cast_zero]
      _ = w (2 : ℚ) := hRepresentation.symm
      _ = w (r * r) := by rw [hSquare]
      _ = logRat (r * r) primeTwo := (logRat_apply _ _).symm
      _ = (logRat r + logRat r) primeTwo :=
        congrArg (fun value : LogOrderGroup => value primeTwo) (logRat_mul hr hr)
      _ = logRat r primeTwo + logRat r primeTwo := rfl
      _ = w r + w r := by rw [logRat_apply]
      _ = m + m := rfl
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

/-- `claim_no_rational_square_two` の具体版。 -/
theorem noRationalSquareTwo (q : ℚ) : q * q ≠ 2 := by
  intro hSquare
  rcases lt_trichotomy q 0 with hNeg | hZero | hPos
  · let r : ℚ := -q
    apply noSquareTwo_of_pos (show 0 < r from neg_pos.mpr hNeg)
    calc
      r * r = (-q) * (-q) := rfl
      _ = -(q * (-q)) := neg_mul q (-q)
      _ = -(-(q * q)) := congrArg Neg.neg (mul_neg q q)
      _ = q * q := neg_neg _
      _ = 2 := hSquare
  · have hZeroProduct : q * q = 0 := by
      calc
        q * q = 0 * 0 := by rw [hZero]
        _ = 0 := zero_mul 0
    exact (by norm_num : (2 : ℚ) ≠ 0) (hSquare.symm.trans hZeroProduct)
  · let r : ℚ := q
    apply noSquareTwo_of_pos (show 0 < r from hPos)
    calc
      r * r = q * q := rfl
      _ = 2 := hSquare

end Ising2DLambda.FisherZero
