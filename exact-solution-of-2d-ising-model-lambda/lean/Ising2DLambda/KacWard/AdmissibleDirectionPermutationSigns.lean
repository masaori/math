import Ising2DLambda.KacWard.AdmissibleDirectionPermutations

namespace Ising2DLambda.KacWard

/-- Inversions of the displayed four directions, in the order 0, 1, 2, 3. -/
noncomputable def directionInversionCount (σ : Equiv.Perm (ZMod 4)) : ℕ :=
  (Finset.univ.filter (fun p : ZMod 4 × ZMod 4 =>
    p.1.val < p.2.val ∧ (σ p.2).val < (σ p.1).val)).card

noncomputable def directionPermSign (σ : Equiv.Perm (ZMod 4)) : ℤ :=
  (-1) ^ directionInversionCount σ

/-- The determinant's permutation sign agrees with the inversion definition. -/
theorem directionPermSign_eq_sign :
    ∀ σ : Equiv.Perm (ZMod 4), directionPermSign σ = σ.sign := by
  decide

/-- `claim_admissible_direction_permutation_signs`: compare the six ordered
position pairs for every admissible permutation. -/
theorem admissibleDirectionPermutationInversionCounts :
    ∀ σ : Equiv.Perm (ZMod 4),
      (∀ i : ZMod 4, σ i ≠ i + 2) →
        directionInversionCount σ =
          (if σ 0 = 0 ∧ σ 1 = 1 ∧ σ 2 = 2 ∧ σ 3 = 3 then 0
          else if (σ 0 = 0 ∧ σ 1 = 1 ∧ σ 2 = 3 ∧ σ 3 = 2) ∨
                  (σ 0 = 0 ∧ σ 1 = 2 ∧ σ 2 = 1 ∧ σ 3 = 3) ∨
                  (σ 0 = 1 ∧ σ 1 = 0 ∧ σ 2 = 2 ∧ σ 3 = 3) then 1
          else if σ 0 = 1 ∧ σ 1 = 0 ∧ σ 2 = 3 ∧ σ 3 = 2 then 2
          else if (σ 0 = 1 ∧ σ 1 = 2 ∧ σ 2 = 3 ∧ σ 3 = 0) ∨
                  (σ 0 = 3 ∧ σ 1 = 0 ∧ σ 2 = 1 ∧ σ 3 = 2) then 3
          else if σ 0 = 3 ∧ σ 1 = 1 ∧ σ 2 = 2 ∧ σ 3 = 0 then 5
          else 6) := by
  decide

/-- The same inversion counts give three positive signs and six negative signs. -/
theorem admissibleDirectionPermutationSigns :
    ∀ σ : Equiv.Perm (ZMod 4),
      (∀ i : ZMod 4, σ i ≠ i + 2) →
        directionPermSign σ = (if (σ 0 = 0 ∧ σ 1 = 1 ∧ σ 2 = 2 ∧ σ 3 = 3) ∨
          (σ 0 = 1 ∧ σ 1 = 0 ∧ σ 2 = 3 ∧ σ 3 = 2) ∨
          (σ 0 = 3 ∧ σ 1 = 2 ∧ σ 2 = 1 ∧ σ 3 = 0) then 1 else -1) := by
  decide

end Ising2DLambda.KacWard
