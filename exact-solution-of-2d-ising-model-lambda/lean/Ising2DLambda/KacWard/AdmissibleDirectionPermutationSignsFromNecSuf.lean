import Ising2DLambda.KacWard.AdmissibleDirectionPermutationSigns
import Ising2DLambda.NecSuf.KacWard.AdmissibleDirectionPermutationSigns

namespace Ising2DLambda.KacWard

/-- The concrete inversion table is the ordered-four-direction instance of
the necessary-and-sufficient calculation. -/
theorem admissibleDirectionPermutationInversionCounts_from_necSuf :
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
  exact Ising2DLambda.NecSuf.KacWard.admissibleDirectionPermutationInversionCounts

/-- The integer sign table follows from the same ordered-four calculation. -/
theorem admissibleDirectionPermutationSigns_from_necSuf :
    ∀ σ : Equiv.Perm (ZMod 4),
      (∀ i : ZMod 4, σ i ≠ i + 2) →
        directionPermSign σ = (if (σ 0 = 0 ∧ σ 1 = 1 ∧ σ 2 = 2 ∧ σ 3 = 3) ∨
          (σ 0 = 1 ∧ σ 1 = 0 ∧ σ 2 = 3 ∧ σ 3 = 2) ∨
          (σ 0 = 3 ∧ σ 1 = 2 ∧ σ 2 = 1 ∧ σ 3 = 0) then 1 else -1) := by
  exact Ising2DLambda.NecSuf.KacWard.admissibleDirectionPermutationSigns

end Ising2DLambda.KacWard
