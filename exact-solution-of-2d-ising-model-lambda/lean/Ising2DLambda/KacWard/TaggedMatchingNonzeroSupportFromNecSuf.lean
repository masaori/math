/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.TaggedMatchingNonzeroSupport
import Ising2DLambda.NecSuf.KacWard.TaggedMatchingNonzeroSupport

namespace Ising2DLambda.KacWard

open Finset Ising2DLambda.AlgebraicEigenvalue

/-- The concrete labelled product specializes the domain argument. -/
theorem taggedMatching_nonzero_support_from_necSuf {L : ℕ} (z : Qbar)
    (s : SpinStructure) (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L))
    (hterm :
      (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
        (∏ p ∈ t, gaugedShortContribution z s p) ≠ 0) :
    (∀ p ∈ matchingOrientedPairs D \ t, p.2 = reversal p.1) ∧
      (∀ p ∈ t, orientedSource p.2 = orientedSource p.1 ∧ p.2 ≠ p.1) := by
  exact Ising2DLambda.NecSuf.KacWard.taggedProduct_nonzero_support
    (matchingOrientedPairs D) t (gaugedLongContribution z s)
    (gaugedShortContribution z s)
    (fun p => p.2 = reversal p.1)
    (fun p => orientedSource p.2 = orientedSource p.1 ∧ p.2 ≠ p.1)
    (longContribution_nonzero_reversal z s)
    (shortContribution_nonzero_local z s) hterm

end Ising2DLambda.KacWard
