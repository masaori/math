/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.EvenEdgeChainTorusNormalForm
import Ising2DLambda.NecSuf.KacWard.EvenEdgeChainTorusNormalForm

namespace Ising2DLambda.KacWard

open Finset Ising2DLambda.PartitionPolynomial
open Finset

/-- 具体版の主張が必要十分版の `R = 𝔽₂` への特殊化であること。 -/
theorem evenEdgeChain_torusNormalForm_from_necSuf {L : ℕ} [NeZero L]
    (H V : ZMod L → ZMod L → ZMod 2)
    (heven : ∀ i j, H i j + H i (j - 1) + V i j + V (i - 1) j = 0) :
    ∃ p : ZMod L → ZMod L → ZMod 2,
      (∀ i j, H i j =
          (∑ i', H i' (-1)) * fundamentalRowHorizontal i j + (∑ j', V (-1) j') * 0 +
            ∑ a, ∑ b, p a b * squareBoundaryHorizontal a b i j) ∧
      (∀ i j, V i j =
          (∑ i', H i' (-1)) * 0 + (∑ j', V (-1) j') * fundamentalColumnVertical i j +
            ∑ a, ∑ b, p a b * squareBoundaryVertical a b i j) :=
  Ising2DLambda.NecSuf.KacWard.ringEvenEdgeChain_torusNormalForm zmodTwo_two_eq_zero H V heven

end Ising2DLambda.KacWard
