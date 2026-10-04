/- `claim_one_sided_parallel_return_repetition` の必要十分版。
座標・単位歩・巻き付きは不要で、加法可換群、正の周期長、階段の終点と始点の差だけを使う。
周期数と商の差は整数で取り、自然数の切り捨て減法を使わない。 -/
import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

def translatedNegativeRepeat {G : Type*} [AddCommGroup G]
    (n : ℕ) (path : ℕ → G) (period base : G) (c : ℕ) (s : ℕ) : G :=
  base + ((c : ℤ) - (s / n : ℕ)) • period - path (s % n)

theorem translatedNegativeRepeat_step_necSuf {G : Type*} [AddCommGroup G]
    (n : ℕ) (path : ℕ → G) (period base : G) (c : ℕ)
    (hn : 0 < n) (hspan : path n - path 0 = period) (s : ℕ) :
    translatedNegativeRepeat n path period base c (s + 1) -
        translatedNegativeRepeat n path period base c s =
      -(path (s % n + 1) - path (s % n)) := by
  unfold translatedNegativeRepeat
  have hrlt : s % n < n := Nat.mod_lt s hn
  have hsrepr := Nat.mod_add_div s n
  have hsucc : s + 1 = (s % n + 1) + n * (s / n) := by omega
  have hdivbase : (s + 1) / n = (s % n + 1) / n + s / n := by
    rw [hsucc, Nat.add_mul_div_left _ _ hn]
  have hmodbase : (s + 1) % n = (s % n + 1) % n := by
    rw [hsucc, Nat.add_mul_mod_self_left]
  by_cases hbefore : s % n + 1 < n
  · have hdiv : (s + 1) / n = s / n := by
      rw [hdivbase, Nat.div_eq_of_lt hbefore, zero_add]
    have hmod : (s + 1) % n = s % n + 1 := by
      rw [hmodbase, Nat.mod_eq_of_lt hbefore]
    rw [hdiv, hmod]
    abel
  · have hrequiv : s % n + 1 = n := by omega
    have hdiv : (s + 1) / n = s / n + 1 := by
      rw [hdivbase, hrequiv, Nat.div_self hn]
      omega
    have hmod : (s + 1) % n = 0 := by
      rw [hmodbase, hrequiv, Nat.mod_self]
    rw [hdiv, hmod, hrequiv, ← hspan]
    simp only [Nat.cast_add, Nat.cast_one, sub_smul, add_smul, one_smul]
    abel

end Ising2DLambda.NecSuf.KacWard
