/-
「底の冪から 1 を引いた数は指数を自然数倍した冪から 1 を引いた数を割る」の Lean 必要十分版。

整数を落とすと、減法・積・自然数冪を持つ環だけが残る。証明は具体版と同じく、
基底の証人、指数の加法、帰納段の分解、証人の更新、帰納法、整除への着地の順に進む。
-/
import Mathlib

namespace Ising3DCut.NecSuf

theorem powerMinusOne_witness_zero {R : Type*} [CommRing R] (c : R) (n : ℕ) :
    c ^ (n * 0) - 1 = (c ^ n - 1) * 0 := by
  simp

theorem powerMinusOne_exponent_succ {R : Type*} [CommRing R] (c : R) (n k : ℕ) :
    c ^ (n * (k + 1)) = c ^ (n * k) * c ^ n := by
  rw [Nat.mul_succ, pow_add]

theorem powerMinusOne_succ_decompose {R : Type*} [CommRing R] (c : R) (n k : ℕ) :
    c ^ (n * (k + 1)) - 1 = c ^ (n * k) * (c ^ n - 1) + (c ^ (n * k) - 1) := by
  rw [powerMinusOne_exponent_succ c n k]
  ring

theorem powerMinusOne_witness_succ {R : Type*} [CommRing R] (c : R) (n k : ℕ) (t : R)
    (h : c ^ (n * k) - 1 = (c ^ n - 1) * t) :
    c ^ (n * (k + 1)) - 1 = (c ^ n - 1) * (c ^ (n * k) + t) := by
  rw [powerMinusOne_succ_decompose c n k, h]
  ring

theorem exists_witness_powerMinusOne_dvd_multiple_exponent
    {R : Type*} [CommRing R] (c : R) (n k : ℕ) :
    ∃ t : R, c ^ (n * k) - 1 = (c ^ n - 1) * t := by
  induction k with
  | zero => exact ⟨0, powerMinusOne_witness_zero c n⟩
  | succ k ih =>
      obtain ⟨t, ht⟩ := ih
      exact ⟨c ^ (n * k) + t, powerMinusOne_witness_succ c n k t ht⟩

theorem powerMinusOne_dvd_multiple_exponent {R : Type*} [CommRing R] (c : R) (n k : ℕ) :
    (c ^ n - 1) ∣ (c ^ (n * k) - 1) :=
  (exists_witness_powerMinusOne_dvd_multiple_exponent c n k).imp fun _ h => h

end Ising3DCut.NecSuf
