import Ising2DLambda.NecSuf.KacWard.AdmissibleDirectionPermutations

namespace Ising2DLambda.NecSuf.KacWard

/-- Only the order of four directions is used. -/
noncomputable def directionInversionCount (σ : Equiv.Perm (ZMod 4)) : ℕ :=
  (Finset.univ.filter (fun p : ZMod 4 × ZMod 4 =>
    p.1.val < p.2.val ∧ (σ p.2).val < (σ p.1).val)).card

noncomputable def directionPermSign (σ : Equiv.Perm (ZMod 4)) : ℤ :=
  (-1) ^ directionInversionCount σ

/-- The chosen inversion count is the usual permutation sign. -/
theorem directionPermSign_eq_sign :
    ∀ σ : Equiv.Perm (ZMod 4), directionPermSign σ = σ.sign := by
  decide

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

/-- The integer sign is defined from the inversion count, without a permutation-sign theorem. -/
theorem admissibleDirectionPermutationSigns :
    ∀ σ : Equiv.Perm (ZMod 4),
      (∀ i : ZMod 4, σ i ≠ i + 2) →
        directionPermSign σ = (if (σ 0 = 0 ∧ σ 1 = 1 ∧ σ 2 = 2 ∧ σ 3 = 3) ∨
          (σ 0 = 1 ∧ σ 1 = 0 ∧ σ 2 = 3 ∧ σ 3 = 2) ∨
          (σ 0 = 3 ∧ σ 1 = 2 ∧ σ 2 = 1 ∧ σ 3 = 0) then 1 else -1) := by
  decide

end Ising2DLambda.NecSuf.KacWard
