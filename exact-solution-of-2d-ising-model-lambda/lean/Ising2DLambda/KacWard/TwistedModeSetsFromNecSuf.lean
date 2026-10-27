import Ising2DLambda.KacWard.TwistedModeSets
import Ising2DLambda.NecSuf.KacWard.TwistedModeSets

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

theorem twistedModes_subset_doubleRoots_from_necSuf (L : ℕ) (s : SpinStructure) :
    horizontalTwistedModes L s ∪ verticalTwistedModes L s ⊆ RootOfUnity (2 * L) := by
  intro z hz
  have hpow : z ^ L = 1 ∨ z ^ L = -1 := by
    rcases hz with hz | hz
    · unfold horizontalTwistedModes at hz
      cases h : s.1 <;> simp [h] at hz
      · exact Or.inl hz
      · exact Or.inr hz
    · unfold verticalTwistedModes at hz
      cases h : s.2 <;> simp [h] at hz
      · exact Or.inl hz
      · exact Or.inr hz
  change z ^ (2 * L) = 1
  apply Ising2DLambda.NecSuf.KacWard.twistedPow_mem_doubleRoots_necSuf z L
  rcases hpow with h | h <;> rw [h] <;> norm_num

end Ising2DLambda.KacWard
