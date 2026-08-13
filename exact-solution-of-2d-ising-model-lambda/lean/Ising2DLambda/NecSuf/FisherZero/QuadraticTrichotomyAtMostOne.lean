/-
「二次体の三分律（高々一つ）」の必要十分版。
二次体と表示写像を外し、順序環上の係数対について三条件とその加法逆元側の三条件が
同時に成り立たないという、本文の九つの場合だけを残す。
-/
import Ising2DLambda.NecSuf.FisherZero.QuadraticTrichotomyAtLeastOne

namespace Ising2DLambda.NecSuf.FisherZero

/-- 正錐・零・加法逆元の正錐という三つの場合は、どの二つも同時には成り立たない。 -/
theorem quadratic_trichotomy_at_most_one_necSuf
    {A : Type} [Ring A] [LinearOrder A] [IsStrictOrderedRing A] (a b : A) :
    ¬ (quadraticCoefficientPositiveNecSuf (a, b) ∧ (a, b) = (0, 0)) ∧
      ¬ ((a, b) = (0, 0) ∧ quadraticCoefficientPositiveNecSuf (-a, -b)) ∧
      ¬ (quadraticCoefficientPositiveNecSuf (a, b) ∧
        quadraticCoefficientPositiveNecSuf (-a, -b)) := by
  constructor
  · rintro ⟨hpos, hzero⟩
    have ha : a = 0 := by simpa using congrArg Prod.fst hzero
    have hb : b = 0 := by simpa using congrArg Prod.snd hzero
    subst a
    subst b
    simp [quadraticCoefficientPositiveNecSuf] at hpos
  constructor
  · rintro ⟨hzero, hneg⟩
    have ha : a = 0 := by simpa using congrArg Prod.fst hzero
    have hb : b = 0 := by simpa using congrArg Prod.snd hzero
    subst a
    subst b
    simp [quadraticCoefficientPositiveNecSuf] at hneg
  · rintro ⟨hpos, hneg⟩
    rcases hpos with hpos | hpos | hpos <;>
      rcases hneg with hneg | hneg | hneg
    · rcases hpos with ⟨ha, hb, hab⟩
      rcases hneg with ⟨hna, hnb, -⟩
      apply hab
      apply Prod.ext
      · exact le_antisymm (by simpa using hna) ha
      · exact le_antisymm (by simpa using hnb) hb
    · rcases hpos with ⟨ha, -, -⟩
      rcases hneg with ⟨hna, -, -⟩
      exact (not_lt_of_ge ha) (by simpa using hna)
    · rcases hpos with ⟨-, hb, -⟩
      rcases hneg with ⟨-, hnb, -⟩
      exact (not_lt_of_ge hb) (by simpa using hnb)
    · rcases hpos with ⟨ha, -, -⟩
      rcases hneg with ⟨hna, -, -⟩
      exact (not_lt_of_ge (by simpa using hna)) ha
    · rcases hpos with ⟨ha, -, -⟩
      rcases hneg with ⟨hna, -, -⟩
      exact lt_asymm ha (by simpa using hna)
    · rcases hpos with ⟨-, -, hab⟩
      rcases hneg with ⟨-, -, hba⟩
      have hba' : a * a < 2 * b * b := by simpa using hba
      exact lt_asymm hab hba'
    · rcases hpos with ⟨-, hb, -⟩
      rcases hneg with ⟨-, hnb, -⟩
      exact (not_lt_of_ge (by simpa using hnb)) hb
    · rcases hpos with ⟨-, -, hab⟩
      rcases hneg with ⟨-, -, hba⟩
      have hba' : 2 * b * b < a * a := by simpa using hba
      exact lt_asymm hab hba'
    · rcases hpos with ⟨ha, -, -⟩
      rcases hneg with ⟨hna, -, -⟩
      exact lt_asymm ha (by simpa using hna)

end Ising2DLambda.NecSuf.FisherZero
