/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.EvenEdgeChainIntersectionValue
import Ising2DLambda.NecSuf.KacWard.EvenEdgeChainIntersectionValue

namespace Ising2DLambda.KacWard

open Finset Ising2DLambda.PartitionPolynomial

/-- 具体版の主張が必要十分版の `R = 𝔽₂` への特殊化であること。 -/
theorem coefficientIntersection_eq_cutParity_from_necSuf {L : ℕ} [NeZero L]
    (HC VC HD VD : ZMod L → ZMod L → ZMod 2)
    (hevenC : ∀ i j, HC i j + HC i (j - 1) + VC i j + VC (i - 1) j = 0)
    (hevenD : ∀ i j, HD i j + HD i (j - 1) + VD i j + VD (i - 1) j = 0) :
    coefficientIntersection HC VC HD VD =
      (∑ i', HC i' (-1)) * (∑ j', VD (-1) j') + (∑ j', VC (-1) j') * (∑ i', HD i' (-1)) :=
  Ising2DLambda.NecSuf.KacWard.ringCoefficientIntersection_eq_cutParity zmodTwo_two_eq_zero
    HC VC HD VD hevenC hevenD

end Ising2DLambda.KacWard
