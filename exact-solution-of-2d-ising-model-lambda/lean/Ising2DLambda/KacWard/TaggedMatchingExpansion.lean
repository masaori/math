import Ising2DLambda.KacWard.GaugedTerminalSkew
import Ising2DLambda.KacWard.ReversalMatrixDeterminant
import Ising2DLambda.AlgebraicEigenvalue.QbarPolynomialPfaffian

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
    generalize matchingOrientedPairs D = pairs
    induction pairs using Finset.induction_on with
    | empty => simp
    | @insert a pairs ha ih =>
      rw [Finset.prod_insert ha, Finset.sum_powerset_insert ha]
      have hnot (t : Finset (OrientedEdge L × OrientedEdge L))
          (ht : t ∈ pairs.powerset) : a ∉ t :=
        Finset.notMem_of_mem_powerset_of_notMem ht ha
      have hlong (t : Finset (OrientedEdge L × OrientedEdge L))
          (ht : t ∈ pairs.powerset) :
          (-1 : Polynomial Qbar) ^ t.card *
              (∏ p ∈ insert a pairs \ t, gaugedLongContribution z s p) *
              (∏ p ∈ t, gaugedShortContribution z s p) =
            gaugedLongContribution z s a *
              ((-1 : Polynomial Qbar) ^ t.card *
                (∏ p ∈ pairs \ t, gaugedLongContribution z s p) *
                (∏ p ∈ t, gaugedShortContribution z s p)) := by
        have hd : insert a pairs \ t = insert a (pairs \ t) := by
          ext x
          by_cases hx : x = a
          · simp [hx, hnot t ht]
          · simp [hx]
        rw [hd, Finset.prod_insert (by simp [ha])]
        ring
      have hshort (t : Finset (OrientedEdge L × OrientedEdge L))
          (ht : t ∈ pairs.powerset) :
          (-1 : Polynomial Qbar) ^ (insert a t).card *
              (∏ p ∈ insert a pairs \ insert a t, gaugedLongContribution z s p) *
              (∏ p ∈ insert a t, gaugedShortContribution z s p) =
            -gaugedShortContribution z s a *
              ((-1 : Polynomial Qbar) ^ t.card *
                (∏ p ∈ pairs \ t, gaugedLongContribution z s p) *
                (∏ p ∈ t, gaugedShortContribution z s p)) := by
        have hd : insert a pairs \ insert a t = pairs \ t := by
          ext x
          by_cases hx : x = a
          · simp [hx, ha]
          · simp [hx]
        rw [hd, Finset.card_insert_of_notMem (hnot t ht),
          Finset.prod_insert (hnot t ht)]
        simp [pow_succ]
        ring
      rw [Finset.sum_congr rfl hlong, Finset.sum_congr rfl hshort]
      rw [← Finset.mul_sum, ← Finset.mul_sum, ← ih]
      ring
  rw [hprod, Finset.mul_sum]

end Ising2DLambda.KacWard
