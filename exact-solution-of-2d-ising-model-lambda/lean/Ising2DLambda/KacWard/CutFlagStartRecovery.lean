import Mathlib

namespace Ising2DLambda.KacWard

def coordinateCutTarget
    (side : ℤ) {n : ℕ} (displacement : Fin n → ℤ) (j : Fin n × Bool) : ℤ :=
  if j.2 then (side - 1 - displacement j.1) % side else (-displacement j.1) % side

def coordinateCutPositive
    {n : ℕ} (flags : Fin n → Bool × Bool) (j : Fin n × Bool) : Prop :=
  if j.2 then (flags j.1).2 = true else (flags j.1).1 = true

def coordinateStartCompatible
    (side : ℤ) {n : ℕ} (displacement : Fin n → ℤ)
    (flags : Fin n → Bool × Bool) (r : ℤ) : Prop :=
  ∀ j, coordinateCutPositive flags j ↔ r = coordinateCutTarget side displacement j

def coordinateForcedResidue
    (side : ℤ) {n : ℕ} (displacement : Fin n → ℤ)
    (flags : Fin n → Bool × Bool) (x : ℤ) : Prop :=
  ∃ j, coordinateCutPositive flags j ∧ x = coordinateCutTarget side displacement j

def coordinateForbiddenResidue
    (side : ℤ) {n : ℕ} (displacement : Fin n → ℤ)
    (flags : Fin n → Bool × Bool) (x : ℤ) : Prop :=
  ∃ j, ¬coordinateCutPositive flags j ∧ x = coordinateCutTarget side displacement j

/-- `claim_cut_flag_congruence_start_recovery` の具体版。 -/
theorem coordinateStartCompatible_iff_forcedForbidden
    (side : ℤ) {n : ℕ} (displacement : Fin n → ℤ)
    (flags : Fin n → Bool × Bool) (r : ℤ) (_hside : 2 ≤ side) :
    (0 ≤ r ∧ r < side ∧ coordinateStartCompatible side displacement flags r) ↔
      0 ≤ r ∧ r < side ∧
        (∀ x, coordinateForcedResidue side displacement flags x → r = x) ∧
        ¬coordinateForbiddenResidue side displacement flags r := by
  constructor
  · rintro ⟨hr0, hrside, h⟩
    refine ⟨hr0, hrside, ?_, ?_⟩
    · intro x hx
      obtain ⟨j, hj, rfl⟩ := hx
      exact (h j).mp hj
    · intro hx
      obtain ⟨j, hj, hrj⟩ := hx
      exact hj ((h j).mpr hrj)
  · rintro ⟨hr0, hrside, hforced, hforbidden⟩
    refine ⟨hr0, hrside, ?_⟩
    intro j
    constructor
    · intro hj
      exact hforced (coordinateCutTarget side displacement j) ⟨j, hj, rfl⟩
    · intro hrj
      by_contra hj
      exact hforbidden ⟨j, hj, hrj⟩

end Ising2DLambda.KacWard
