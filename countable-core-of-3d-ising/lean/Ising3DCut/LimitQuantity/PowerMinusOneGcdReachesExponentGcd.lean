import Mathlib
import Ising3DCut.LimitQuantity.PowerMinusOneGcdExponentDifferenceStep

/-!
人手証明 `claim_power_minus_one_gcd_reaches_exponent_gcd`（本文
`structured-latex/content/partition-values.ts`）の Lean 具体版。

人手証明は、準備の一段（指数の差を取っても指数の最大公約数が変わらないこと）と、
指数の和についての強い帰納法の本体（`m=n`・`m>n`・`m<n` の三場合）からなる。
ここでは同じ並びで、準備を両方向の整除から示し、本体を強い帰納法の三場合として書く。
一段の還元は `PowerMinusOneGcdExponentDifferenceStep.lean` の定理をそのまま引く。
差を素直に取るため冪は整数の上で書き、最大公約数は `Int.gcd` の値（自然数）で扱う。
-/

namespace Ising3DCut.LimitQuantity

/-- 準備。`n < m` のとき、指数の差を取っても指数の最大公約数は変わらない。
人手証明の「`t ∣ m-n` と `u ∣ (m-n)+n=m` の両方向の整除」にあたる段。 -/
theorem gcd_sub_left_eq (m n : ℕ) (h : n < m) :
    Nat.gcd (m - n) n = Nat.gcd m n := by
  have hle : n ≤ m := le_of_lt h
  have h₁ : Nat.gcd m n ∣ Nat.gcd (m - n) n :=
    Nat.dvd_gcd (Nat.dvd_sub (Nat.gcd_dvd_left m n) (Nat.gcd_dvd_right m n))
      (Nat.gcd_dvd_right m n)
  have h₂ : Nat.gcd (m - n) n ∣ Nat.gcd m n := by
    refine Nat.dvd_gcd ?_ (Nat.gcd_dvd_right _ _)
    have hsub : m - n + n = m := Nat.sub_add_cancel hle
    have hd : Nat.gcd (m - n) n ∣ m - n + n :=
      Nat.dvd_add (Nat.gcd_dvd_left _ _) (Nat.gcd_dvd_right _ _)
    rwa [hsub] at hd
  exact Nat.dvd_antisymm h₂ h₁

/-- 本体。指数の和についての強い帰納法。人手証明の三場合をそのまま並べる。 -/
theorem powerMinusOne_gcd_reaches_exponent_gcd_aux (c : ℤ) :
    ∀ N : ℕ, ∀ m n : ℕ, 0 < m → 0 < n → m + n = N →
      Int.gcd (c ^ m - 1) (c ^ n - 1)
        = Int.gcd (c ^ Nat.gcd m n - 1) (c ^ Nat.gcd m n - 1) := by
  intro N
  induction N using Nat.strong_induction_on with
  | _ N ih =>
    intro m n hm hn hN
    rcases lt_trichotomy m n with h | h | h
    · -- `m < n` のとき。順序を入れ替えてから一段還元する。
      have hpos : 0 < n - m := by omega
      have hsum : n - m + m < N := by omega
      have hind := ih (n - m + m) hsum (n - m) m hpos hm rfl
      have hstep := powerMinusOne_gcd_exponent_difference_step_of_lt c n m h
      have hgcd : Nat.gcd (n - m) m = Nat.gcd n m := gcd_sub_left_eq n m h
      rw [Int.gcd_comm, hstep, hind, hgcd, Nat.gcd_comm n m]
    · -- `m = n` のとき。`gcd(m,m)=m` なので左辺と右辺は同じ式である。
      subst h
      rw [Nat.gcd_self]
    · -- `m > n` のとき。一段還元して帰納法の仮定を使う。
      have hpos : 0 < m - n := by omega
      have hsum : m - n + n < N := by omega
      have hind := ih (m - n + n) hsum (m - n) n hpos hn rfl
      have hstep := powerMinusOne_gcd_exponent_difference_step_of_lt c m n h
      have hgcd : Nat.gcd (m - n) n = Nat.gcd m n := gcd_sub_left_eq m n h
      rw [hstep, hind, hgcd]

/-- 人手証明と 1 対 1 に対応する主張。還元を繰り返すと指数はどちらも
指数の最大公約数に到達する。 -/
theorem powerMinusOne_gcd_reaches_exponent_gcd (c : ℤ) (m n : ℕ) (hm : 0 < m) (hn : 0 < n) :
    Int.gcd (c ^ m - 1) (c ^ n - 1)
      = Int.gcd (c ^ Nat.gcd m n - 1) (c ^ Nat.gcd m n - 1) :=
  powerMinusOne_gcd_reaches_exponent_gcd_aux c (m + n) m n hm hn rfl

end Ising3DCut.LimitQuantity
