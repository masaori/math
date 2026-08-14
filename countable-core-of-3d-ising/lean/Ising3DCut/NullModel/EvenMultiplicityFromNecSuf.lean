/- 具体版が、有限型上の不動点のない対合についての必要十分版の特殊化であることを示す。 -/
import Ising3DCut.NullModel.EvenMultiplicity
import Ising3DCut.NecSuf.NullModel.EvenMultiplicity

namespace Ising3DCut.NullModel

/-- `claim_even_multiplicity` を必要十分版から導く。 -/
theorem multiplicity_even_from_necSuf {L m : ℕ} (hL : 2 ≤ L) :
    ∃ k : ℕ, multiplicity L m = 2 * k := by
  simpa [multiplicity] using
    NecSuf.NullModel.card_eq_two_mul_of_fixedPointFree_involution
      (levelSetGlobalFlip (L := L) (m := m))
      (fun σ => (levelSetGlobalFlip (L := L) (m := m)).left_inv σ)
      (fun σ h => globalFlip_ne_self hL σ.1 (congrArg Subtype.val h))

end Ising3DCut.NullModel
