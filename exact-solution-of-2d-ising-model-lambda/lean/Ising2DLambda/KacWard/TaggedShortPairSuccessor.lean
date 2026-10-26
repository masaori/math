import Ising2DLambda.KacWard.TaggedDifferenceCycleCover
import Ising2DLambda.NecSuf.KacWard.TaggedShortPairSuccessor

namespace Ising2DLambda.KacWard

open Finset Ising2DLambda.AlgebraicEigenvalue

/-- The short label of an actual nonzero Pfaffian term gives a legal step. -/
theorem taggedShortPair_successor {L : ℕ} (z : Qbar) (s : SpinStructure)
    (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L))
    (hterm : matchingSignPolynomial D *
      ((-1 : Polynomial Qbar) ^ t.card *
        (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
        (∏ p ∈ t, gaugedShortContribution z s p)) ≠ 0)
    (p : OrientedEdge L × OrientedEdge L) (hp : p ∈ t) :
    p.2 ∈ nonbacktrackingSuccessors (reversal p.1) := by
  have hshort := (taggedMatching_nonzero_term_support z s D t hterm).2 p hp
  apply (mem_nonbacktrackingSuccessors_reversal p.1 p.2).2
  exact hshort

/-- The domain proof specializes to oriented edges and their endpoint maps. -/
theorem taggedShortPair_successor_from_necSuf {L : ℕ} (z : Qbar)
    (s : SpinStructure) (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L))
    (hterm : matchingSignPolynomial D *
      ((-1 : Polynomial Qbar) ^ t.card *
        (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
        (∏ p ∈ t, gaugedShortContribution z s p)) ≠ 0)
    (p : OrientedEdge L × OrientedEdge L) (hp : p ∈ t) :
    p.2 ∈ nonbacktrackingSuccessors (reversal p.1) := by
  have hshort := (taggedMatching_nonzero_term_support z s D t hterm).2 p hp
  exact Ising2DLambda.NecSuf.KacWard.shortPair_successor
    reversal orientedSource orientedTarget
    (fun e f => f ∈ nonbacktrackingSuccessors e)
    reversal_involutive orientedTarget_reversal
    (fun e f => by simp [nonbacktrackingSuccessors])
    p.1 p.2 hshort.1 hshort.2

end Ising2DLambda.KacWard
