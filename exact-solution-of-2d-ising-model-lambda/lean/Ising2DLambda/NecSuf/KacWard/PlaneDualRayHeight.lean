import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- Parity of the active elements whose integer coordinate lies to the right. -/
def finiteRayHeight {α : Type*} [DecidableEq α] (edges : Finset α)
    (active : α → Prop) [DecidablePred active] (column : α → ℤ) (c : ℤ) : ZMod 2 :=
  ∑ e ∈ edges, if active e ∧ c < column e then 1 else 0

/-- A one-step shift of a finite ray adds exactly the elements on its new cut. -/
theorem finiteRayHeight_horizontal {α : Type*} [DecidableEq α]
    (edges : Finset α) (active : α → Prop) [DecidablePred active]
    (column : α → ℤ) (c : ℤ) :
    finiteRayHeight edges active column (c - 1) =
      finiteRayHeight edges active column c +
        ∑ e ∈ edges, if active e ∧ column e = c then (1 : ZMod 2) else 0 := by
  have hlocal (e : α) :
      (if active e ∧ c - 1 < column e then (1 : ZMod 2) else 0) =
        (if active e ∧ c < column e then 1 else 0) +
          (if active e ∧ column e = c then 1 else 0) := by
    by_cases ha : active e
    · by_cases heq : column e = c
      · simp [ha, heq]
      · by_cases hgt : c < column e
        · have hleft : c - 1 < column e := by omega
          simp [ha, heq, hgt, hleft]
        · have hleft : ¬ c - 1 < column e := by omega
          simp [ha, heq, hgt, hleft]
    · simp [ha]
  simp only [finiteRayHeight]
  calc
    (∑ e ∈ edges, if active e ∧ c - 1 < column e then (1 : ZMod 2) else 0) =
        ∑ e ∈ edges,
          ((if active e ∧ c < column e then (1 : ZMod 2) else 0) +
            if active e ∧ column e = c then 1 else 0) := by
              apply Finset.sum_congr rfl
              intro e _
              exact hlocal e
    _ = (∑ e ∈ edges, if active e ∧ c < column e then (1 : ZMod 2) else 0) +
          (∑ e ∈ edges, if active e ∧ column e = c then (1 : ZMod 2) else 0) := by
            rw [Finset.sum_add_distrib]
