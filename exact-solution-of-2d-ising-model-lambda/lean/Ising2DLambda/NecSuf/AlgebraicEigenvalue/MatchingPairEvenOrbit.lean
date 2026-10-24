import Mathlib.Logic.Function.Iterate
import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

theorem even_of_color_flip {J : Type*} (f : J → J) (C : J → Prop)
    (hflip : ∀ j, C (f j) ↔ ¬ C j) (n : ℕ) (i : J)
    (hreturn : f^[n] i = i) : Even n := by
  have hpar : ∀ k : ℕ, C (f^[k] i) ↔ (k % 2 = 0 ↔ C i) := by
    intro k
    induction k with
    | zero => simp
    | succ k ih =>
      rw [Function.iterate_succ_apply', hflip, ih]
      by_cases hk : k % 2 = 0 <;> by_cases hi : C i <;> simp [hk, hi] <;> omega
  have hsame : C (f^[n] i) ↔ C i := by rw [hreturn]
  have heven : n % 2 = 0 := by
    by_cases hi : C i
    · have hn := (hpar n).mp (hsame.mpr hi)
      exact hn.mpr hi
    · by_contra hn
      have hn' := (hpar n).mpr (by simp [hn, hi])
      exact hi (hsame.mp hn')
  exact Nat.even_iff.mpr heven

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
