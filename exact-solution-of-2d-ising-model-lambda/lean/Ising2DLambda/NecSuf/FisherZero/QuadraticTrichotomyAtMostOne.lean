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
  have hZeroCone : ¬ quadraticCoefficientPositiveNecSuf ((0 : A), 0) := by
    intro h
    rcases h with h | h | h
    · exact h.2.2 rfl
    · exact (lt_irrefl (0 : A)) h.1
    · exact (lt_irrefl (0 : A)) h.1
  constructor
  · rintro ⟨hpos, hzero⟩
    rw [hzero] at hpos
    exact hZeroCone hpos
  constructor
  · rintro ⟨hzero, hneg⟩
    have hNegZero : (-a, -b) = (0, 0) := by
      calc
        (-a, -b) = (-0, -0) := congrArg (fun p : A × A => (-p.1, -p.2)) hzero
        _ = (0, -0) := congrArg (fun u : A => (u, -0)) (neg_zero : -(0 : A) = 0)
        _ = (0, 0) := congrArg (fun v : A => (0, v)) (neg_zero : -(0 : A) = 0)
    rw [hNegZero] at hneg
    exact hZeroCone hneg
  · rintro ⟨hpos', hneg'⟩

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

end Ising2DLambda.NecSuf.FisherZero
