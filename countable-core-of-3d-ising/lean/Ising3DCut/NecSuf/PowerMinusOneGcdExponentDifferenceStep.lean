import Mathlib

/-!
`c ^ (d+n) - 1` という形を落とし、整数 `a, b, r, q` が
`a = q*b+r` を満たす場合の最大公約数の一段還元だけを残す。
証明は具体版と同じく、二つの最大公約数の相互整除を別々に示してから等号へ束ねる。
-/

namespace Ising3DCut.NecSuf

theorem gcd_dvd_remainder_of_decomposition (a b r q : ℤ) (h : a = q * b + r) :
    ((Int.gcd a b : ℕ) : ℤ) ∣ r := by
  have ha : ((Int.gcd a b : ℕ) : ℤ) ∣ a := Int.gcd_dvd_left _ _
  have hb : ((Int.gcd a b : ℕ) : ℤ) ∣ b := Int.gcd_dvd_right _ _
  have hqb : ((Int.gcd a b : ℕ) : ℤ) ∣ q * b := Dvd.dvd.mul_left hb _
  have hr : r = a - q * b := by rw [h]; ring
  rw [hr]
  exact dvd_sub ha hqb

theorem gcd_dvd_reduced_of_decomposition (a b r q : ℤ) (h : a = q * b + r) :
    Int.gcd a b ∣ Int.gcd r b :=
  Int.dvd_gcd (gcd_dvd_remainder_of_decomposition a b r q h) (Int.gcd_dvd_right _ _)

theorem reduced_gcd_dvd_of_decomposition (a b r q : ℤ) (h : a = q * b + r) :
    Int.gcd r b ∣ Int.gcd a b := by
  have hr : ((Int.gcd r b : ℕ) : ℤ) ∣ r := Int.gcd_dvd_left _ _
  have hb : ((Int.gcd r b : ℕ) : ℤ) ∣ b := Int.gcd_dvd_right _ _
  have hqb : ((Int.gcd r b : ℕ) : ℤ) ∣ q * b := Dvd.dvd.mul_left hb _
  have ha : ((Int.gcd r b : ℕ) : ℤ) ∣ a := by
    rw [h]
    exact dvd_add hqb hr
  exact Int.dvd_gcd ha hb

theorem gcd_eq_of_decomposition (a b r q : ℤ) (h : a = q * b + r) :
    Int.gcd a b = Int.gcd r b :=
  Nat.dvd_antisymm (gcd_dvd_reduced_of_decomposition a b r q h)
    (reduced_gcd_dvd_of_decomposition a b r q h)

end Ising3DCut.NecSuf
