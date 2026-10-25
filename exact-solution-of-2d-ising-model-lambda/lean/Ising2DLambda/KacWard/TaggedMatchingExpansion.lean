import Ising2DLambda.KacWard.GaugedTerminalSkew
import Ising2DLambda.KacWard.ReversalMatrixDeterminant
import Ising2DLambda.AlgebraicEigenvalue.QbarPolynomialPfaffian
import Ising2DLambda.NecSuf.KacWard.TaggedMatchingExpansion

namespace Ising2DLambda.KacWard

open Finset Ising2DLambda.AlgebraicEigenvalue

noncomputable def gaugedLongContribution {L : ℕ} (z : Qbar) (s : SpinStructure)
    (p : OrientedEdge L × OrientedEdge L) : Polynomial Qbar :=
  qbarConst (if p.2 = reversal p.1 then gaugePairWeight z s p.1 p.2 else 0)

noncomputable def gaugedShortContribution {L : ℕ} (z : Qbar) (s : SpinStructure)
    (p : OrientedEdge L × OrientedEdge L) : Polynomial Qbar :=
  Polynomial.X * qbarConst (if orientedSource p.2 = orientedSource p.1 ∧ p.2 ≠ p.1 then
    gaugePairWeight z s p.1 p.2 *
      ((twistSign s p.2 : Qbar) * rotationPhase z (reversal p.1) p.2) else 0)

/-- The subset records which pairs have the short label. Both labels remain distinct at L = 1. -/
theorem gaugedPfaffian_taggedMatchingExpansion (L : ℕ) [NeZero L]
    (z : Qbar) (s : SpinStructure) :
    qbarPolynomialPfaffian (gaugedTerminalMatrix L z s) =
      ∑ D : PerfectMatching (OrientedEdge L),
        ∑ t ∈ (matchingOrientedPairs D).powerset,
          matchingSignPolynomial D *
            ((-1 : Polynomial Qbar) ^ t.card *
              (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
              (∏ p ∈ t, gaugedShortContribution z s p)) := by
  classical
  have hentry (p : OrientedEdge L × OrientedEdge L) :
      gaugedTerminalMatrix L z s p.1 p.2 =
        gaugedLongContribution z s p - gaugedShortContribution z s p := by
    exact gaugedTerminalMatrix_entry_separated L z s p.1 p.2
  unfold qbarPolynomialPfaffian
  apply Finset.sum_congr rfl
  intro D _
  have hprod : matchingMatrixMonomial (gaugedTerminalMatrix L z s) D =
      ∑ t ∈ (matchingOrientedPairs D).powerset,
        (-1 : Polynomial Qbar) ^ t.card *
          (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
          (∏ p ∈ t, gaugedShortContribution z s p) := by
    unfold matchingMatrixMonomial
    simp_rw [hentry]
    exact Ising2DLambda.NecSuf.KacWard.taggedProductExpansion
      (matchingOrientedPairs D) (gaugedLongContribution z s) (gaugedShortContribution z s)
  rw [hprod, Finset.mul_sum]

end Ising2DLambda.KacWard
