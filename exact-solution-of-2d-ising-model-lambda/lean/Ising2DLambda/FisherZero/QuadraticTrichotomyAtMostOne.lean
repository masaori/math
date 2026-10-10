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
  have hZeroCone : ¬ quadraticCoefficientPositive ((0 : ℚ), 0) := by
    intro h
    rcases h with h | h | h
    · exact h.2.2 rfl
    · exact (lt_irrefl (0 : ℚ)) h.1
    · exact (lt_irrefl (0 : ℚ)) h.1
  constructor
  · rintro ⟨hpos, hzero⟩
    change quadraticCoefficientPositive (quadraticRepresentation s xi) at hpos
    have hRepresentation := (quadraticRepresentation_eq_zero_iff s hs xi).1 hzero
    rw [hRepresentation] at hpos
    exact hZeroCone hpos
  constructor
  · rintro ⟨hzero, hneg⟩
    change quadraticCoefficientPositive
      (quadraticRepresentation s (quadraticNegElement s xi)) at hneg
    have hPairZero : (a, b) = (0, 0) :=
      (quadraticRepresentation_eq_zero_iff s hs xi).1 hzero
    have hNegZero :
        quadraticRepresentation s (quadraticNegElement s xi) = (0, 0) := by
      calc
        quadraticRepresentation s (quadraticNegElement s xi) = (-a, -b) :=
          quadraticRepresentation_neg s hs xi
        _ = (-0, -0) := congrArg (fun p : ℚ × ℚ => (-p.1, -p.2)) hPairZero
        _ = (0, -0) := congrArg (fun u : ℚ => (u, -0)) (neg_zero : -(0 : ℚ) = 0)
        _ = (0, 0) := congrArg (fun v : ℚ => (0, v)) (neg_zero : -(0 : ℚ) = 0)
    rw [hNegZero] at hneg
    exact hZeroCone hneg
  · rintro ⟨hpos, hneg⟩
    change quadraticCoefficientPositive (quadraticRepresentation s xi) at hpos
    change quadraticCoefficientPositive
      (quadraticRepresentation s (quadraticNegElement s xi)) at hneg
    rw [quadraticRepresentation_neg s hs xi] at hneg
    have hpos' : quadraticCoefficientPositive (a, b) := by simpa [a, b] using hpos
    have hneg' : quadraticCoefficientPositive (-a, -b) := by simpa [a, b] using hneg

    -- 逆元側の符号を、本文の六同値と同じ順に移す。
    have hNonnegA : 0 ≤ -a ↔ a ≤ 0 := neg_nonneg
    have hNonnegB : 0 ≤ -b ↔ b ≤ 0 := neg_nonneg
    have hPosA : 0 < -a ↔ a < 0 := neg_pos
    have hNegB : -b < 0 ↔ 0 < b := neg_neg_iff_pos
    have hNegA : -a < 0 ↔ 0 < a := neg_neg_iff_pos
    have hPosB : 0 < -b ↔ b < 0 := neg_pos
    have hPair : (-a, -b) ≠ (0, 0) ↔ (a, b) ≠ (0, 0) := by
      calc
        (-a, -b) ≠ (0, 0) ↔ ¬ (-a = 0 ∧ -b = 0) :=
          not_congr (Prod.mk.injEq (-a) (-b) 0 0).to_iff
        _ ↔ ¬ (a = 0 ∧ -b = 0) :=
          not_congr (and_congr_left (fun _ => neg_eq_zero))
        _ ↔ ¬ (a = 0 ∧ b = 0) :=
          not_congr (and_congr_right (fun _ => neg_eq_zero))
        _ ↔ (a, b) ≠ (0, 0) := (not_congr (Prod.mk.injEq a b 0 0).to_iff).symm
    have hSecond :
        2 * (-b) * (-b) < (-a) * (-a) ↔ 2 * (b * b) < a * a := by
      calc
        2 * (-b) * (-b) < (-a) * (-a) ↔ 2 * ((-b) * (-b)) < (-a) * (-a) := by
          rw [mul_assoc 2 (-b) (-b)]
        _ ↔ 2 * (b * b) < (-a) * (-a) := by rw [neg_mul_neg b b]
        _ ↔ 2 * (b * b) < a * a := by rw [neg_mul_neg a a]
    have hThird :
        (-a) * (-a) < 2 * (-b) * (-b) ↔ a * a < 2 * (b * b) := by
      calc
        (-a) * (-a) < 2 * (-b) * (-b) ↔ a * a < 2 * (-b) * (-b) := by
          rw [neg_mul_neg a a]
        _ ↔ a * a < 2 * ((-b) * (-b)) := by rw [mul_assoc 2 (-b) (-b)]
        _ ↔ a * a < 2 * (b * b) := by rw [neg_mul_neg b b]
    have hNegativeCases :
        (a ≤ 0 ∧ b ≤ 0 ∧ (a, b) ≠ (0, 0)) ∨
        (a < 0 ∧ 0 < b ∧ 2 * (b * b) < a * a) ∨
        (0 < a ∧ b < 0 ∧ a * a < 2 * (b * b)) := by
      rcases hneg' with h | h | h
      · exact Or.inl ⟨hNonnegA.mp h.1, hNonnegB.mp h.2.1, hPair.mp h.2.2⟩
      · exact Or.inr (Or.inl ⟨hPosA.mp h.1, hNegB.mp h.2.1, hSecond.mp h.2.2⟩)
      · exact Or.inr (Or.inr ⟨hNegA.mp h.1, hPosB.mp h.2.1, hThird.mp h.2.2⟩)
    rcases hpos' with hpos' | hpos' | hpos' <;>
      rcases hNegativeCases with hneg' | hneg' | hneg'
    · rcases hpos' with ⟨ha, hb, hab⟩
      rcases hneg' with ⟨hna, hnb, -⟩
      have haZero : a = 0 := le_antisymm hna ha
      have hbZero : b = 0 := le_antisymm hnb hb
      apply hab
      calc
        (a, b) = (0, b) := congrArg (fun u => (u, b)) haZero
        _ = (0, 0) := congrArg (fun v => (0, v)) hbZero
    · rcases hpos' with ⟨ha, -, -⟩
      rcases hneg' with ⟨hna, -, -⟩
      have hNot : ¬ a < 0 := not_lt_of_ge ha
      exact hNot hna
    · rcases hpos' with ⟨-, hb, -⟩
      rcases hneg' with ⟨-, hnb, -⟩
      have hNot : ¬ b < 0 := not_lt_of_ge hb
      exact hNot hnb
    · rcases hpos' with ⟨ha, -, -⟩
      rcases hneg' with ⟨hna, -, -⟩
      have hNot : ¬ 0 < a := not_lt_of_ge hna
      exact hNot ha
    · rcases hpos' with ⟨ha, -, -⟩
      rcases hneg' with ⟨hna, -, -⟩
      have hNot : ¬ a < 0 := lt_asymm ha
      exact hNot hna
    · rcases hpos' with ⟨-, -, hab⟩
      rcases hneg' with ⟨-, -, hba⟩
      have hForward : 2 * (b * b) < a * a := by
        calc
          2 * (b * b) = (2 * b) * b := (mul_assoc 2 b b).symm
          _ < a * a := hab
      have hBackward : a * a < 2 * (b * b) := hba
      have hCycle : 2 * (b * b) < 2 * (b * b) := lt_trans hForward hBackward
      exact (lt_irrefl _) hCycle
    · rcases hpos' with ⟨-, hb, -⟩
      rcases hneg' with ⟨-, hnb, -⟩
      have hNot : ¬ 0 < b := not_lt_of_ge hnb
      exact hNot hb
    · rcases hpos' with ⟨-, -, hab⟩
      rcases hneg' with ⟨-, -, hba⟩
      have hForward : a * a < 2 * (b * b) := by
        calc
          a * a < (2 * b) * b := hab
          _ = 2 * (b * b) := mul_assoc 2 b b
      have hBackward : 2 * (b * b) < a * a := hba
      have hCycle : a * a < a * a := lt_trans hForward hBackward
      exact (lt_irrefl _) hCycle
    · rcases hpos' with ⟨ha, -, -⟩
      rcases hneg' with ⟨hna, -, -⟩
      have hNot : ¬ 0 < a := lt_asymm ha
      exact hNot hna

end Ising2DLambda.FisherZero
