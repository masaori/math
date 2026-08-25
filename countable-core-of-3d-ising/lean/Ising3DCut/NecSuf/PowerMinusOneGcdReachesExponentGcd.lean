import Mathlib

/-!
冪差・整数・最大公約数を落とし、自然数で添字づけた値に対する二項演算が
指数差への一段還元を保つことだけを残す。具体版と同じく、指数和についての
強い帰納法を `m<n`・`m=n`・`m>n` の三場合で進める。
-/

namespace Ising3DCut.NecSuf

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

theorem reduction_reaches_index_gcd_aux
    {α β : Type*} (value : ℕ → α) (combine : α → α → β)
    (combine_comm : ∀ a b, combine a b = combine b a)
    (reduction : ∀ d n, combine (value (d + n)) (value n) = combine (value d) (value n)) :
    ∀ N : ℕ, ∀ m n : ℕ, 0 < m → 0 < n → m + n = N →
      combine (value m) (value n) =
        combine (value (Nat.gcd m n)) (value (Nat.gcd m n)) := by
  intro N
  induction N using Nat.strong_induction_on with
  | _ N ih =>
    intro m n hm hn hN
    rcases lt_trichotomy m n with h | h | h
    · have hpos : 0 < n - m := by omega
      have hsum : n - m + m < N := by omega
      have hind := ih (n - m + m) hsum (n - m) m hpos hm rfl
      have hstep := reduction (n - m) m
      have hadd : n - m + m = n := Nat.sub_add_cancel (le_of_lt h)
      rw [hadd] at hstep
      have hgcd : Nat.gcd (n - m) m = Nat.gcd n m := gcd_sub_left_eq n m h
      rw [combine_comm (value m) (value n), hstep, hind, hgcd, Nat.gcd_comm n m]
    · subst h
      rw [Nat.gcd_self]
    · have hpos : 0 < m - n := by omega
      have hsum : m - n + n < N := by omega
      have hind := ih (m - n + n) hsum (m - n) n hpos hn rfl
      have hstep := reduction (m - n) n
      have hadd : m - n + n = m := Nat.sub_add_cancel (le_of_lt h)
      rw [hadd] at hstep
      have hgcd : Nat.gcd (m - n) n = Nat.gcd m n := gcd_sub_left_eq m n h
      rw [hstep, hind, hgcd]

theorem reduction_reaches_index_gcd
    {α β : Type*} (value : ℕ → α) (combine : α → α → β)
    (combine_comm : ∀ a b, combine a b = combine b a)
    (reduction : ∀ d n, combine (value (d + n)) (value n) = combine (value d) (value n))
    (m n : ℕ) (hm : 0 < m) (hn : 0 < n) :
    combine (value m) (value n) =
      combine (value (Nat.gcd m n)) (value (Nat.gcd m n)) :=
  reduction_reaches_index_gcd_aux value combine combine_comm reduction (m + n) m n hm hn rfl

end Ising3DCut.NecSuf
