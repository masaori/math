/-
「二次体の三分律（高々一つ）」の具体版。
本文と同じく零表示を先に排除し、正錐の三条件と加法逆元側の三条件の九つの場合を調べる。
-/
import Ising2DLambda.FisherZero.QuadraticTrichotomyAtLeastOne

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `claim_quadratic_trichotomy_at_most_one` の具体版。 -/
theorem quadraticTrichotomyAtMostOne
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2)
    (xi : QuadraticFieldElement s) :
    ¬ (xi ∈ quadraticPositiveCone s ∧ (xi : Qbar) = 0) ∧
      ¬ ((xi : Qbar) = 0 ∧ quadraticNegElement s xi ∈ quadraticPositiveCone s) ∧
      ¬ (xi ∈ quadraticPositiveCone s ∧
        quadraticNegElement s xi ∈ quadraticPositiveCone s) := by
  let a := (quadraticRepresentation s xi).1
  let b := (quadraticRepresentation s xi).2
  constructor
  · rintro ⟨hpos, hzero⟩
    change quadraticCoefficientPositive (quadraticRepresentation s xi) at hpos
    rw [(quadraticRepresentation_eq_zero_iff s hs xi).1 hzero] at hpos
    simp [quadraticCoefficientPositive] at hpos
  constructor
  · rintro ⟨hzero, hneg⟩
    change quadraticCoefficientPositive
      (quadraticRepresentation s (quadraticNegElement s xi)) at hneg
    rw [quadraticRepresentation_neg s hs xi,
      (quadraticRepresentation_eq_zero_iff s hs xi).1 hzero] at hneg
    simp [quadraticCoefficientPositive] at hneg
  · rintro ⟨hpos, hneg⟩
    change quadraticCoefficientPositive (quadraticRepresentation s xi) at hpos
    change quadraticCoefficientPositive
      (quadraticRepresentation s (quadraticNegElement s xi)) at hneg
    rw [quadraticRepresentation_neg s hs xi] at hneg
    have hpos' : quadraticCoefficientPositive (a, b) := by simpa [a, b] using hpos
    have hneg' : quadraticCoefficientPositive (-a, -b) := by simpa [a, b] using hneg
    rcases hpos' with hpos' | hpos' | hpos' <;>
      rcases hneg' with hneg' | hneg' | hneg'
    · rcases hpos' with ⟨ha, hb, hab⟩
      rcases hneg' with ⟨hna, hnb, -⟩
      apply hab
      apply Prod.ext
      · exact le_antisymm (by simpa using hna) ha
      · exact le_antisymm (by simpa using hnb) hb
    · rcases hpos' with ⟨ha, -, -⟩
      rcases hneg' with ⟨hna, -, -⟩
      exact (not_lt_of_ge ha) (by simpa using hna)
    · rcases hpos' with ⟨-, hb, -⟩
      rcases hneg' with ⟨-, hnb, -⟩
      exact (not_lt_of_ge hb) (by simpa using hnb)
    · rcases hpos' with ⟨ha, -, -⟩
      rcases hneg' with ⟨hna, -, -⟩
      exact (not_lt_of_ge (by simpa using hna)) ha
    · rcases hpos' with ⟨ha, -, -⟩
      rcases hneg' with ⟨hna, -, -⟩
      exact lt_asymm ha (by simpa using hna)
    · rcases hpos' with ⟨-, -, hab⟩
      rcases hneg' with ⟨-, -, hba⟩
      have hba' : a * a < 2 * b * b := by simpa using hba
      exact lt_asymm hab hba'
    · rcases hpos' with ⟨-, hb, -⟩
      rcases hneg' with ⟨-, hnb, -⟩
      exact (not_lt_of_ge (by simpa using hnb)) hb
    · rcases hpos' with ⟨-, -, hab⟩
      rcases hneg' with ⟨-, -, hba⟩
      have hba' : 2 * b * b < a * a := by simpa using hba
      exact lt_asymm hab hba'
    · rcases hpos' with ⟨ha, -, -⟩
      rcases hneg' with ⟨hna, -, -⟩
      exact lt_asymm ha (by simpa using hna)

end Ising2DLambda.FisherZero
