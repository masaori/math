import Ising2DLambda.KacWard.TaggedMatchingEvenComplement

namespace Ising2DLambda.KacWard

open Finset Polynomial Ising2DLambda.AlgebraicEigenvalue

private noncomputable def longWeight {L : ℕ} (z : Qbar) (s : SpinStructure)
    (p : OrientedEdge L × OrientedEdge L) : Qbar :=
  if p.2 = reversal p.1 then gaugePairWeight z s p.1 p.2 else 0

private noncomputable def shortWeight {L : ℕ} (z : Qbar) (s : SpinStructure)
    (p : OrientedEdge L × OrientedEdge L) : Qbar :=
  if orientedSource p.2 = orientedSource p.1 ∧ p.2 ≠ p.1 then
    gaugePairWeight z s p.1 p.2 *
      ((twistSign s p.2 : Qbar) * rotationPhase z (reversal p.1) p.2) else 0

noncomputable def taggedMatchingTermCoefficient {L : ℕ} (z : Qbar)
    (s : SpinStructure) (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L)) : Qbar :=
  ((perfectMatchingSign D : ℤ) : Qbar) * (-1) ^ t.card *
    (∏ p ∈ matchingOrientedPairs D \ t, longWeight z s p) *
    (∏ p ∈ t, shortWeight z s p)

/-- Each short labelled pair supplies precisely one factor of X. -/
theorem taggedMatching_term_monomial {L : ℕ} (z : Qbar) (s : SpinStructure)
    (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L)) :
    matchingSignPolynomial D *
      ((-1 : Polynomial Qbar) ^ t.card *
        (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
        (∏ p ∈ t, gaugedShortContribution z s p)) =
      X ^ t.card * C (taggedMatchingTermCoefficient z s D t) := by
  classical
  have hshort (u : Finset (OrientedEdge L × OrientedEdge L)) :
      (∏ p ∈ u, gaugedShortContribution z s p) =
        X ^ u.card * C (∏ p ∈ u, shortWeight z s p) := by
    induction u using Finset.induction_on with
    | empty => simp
    | @insert p u hp ih =>
      rw [Finset.prod_insert hp, ih, Finset.card_insert_of_notMem hp,
        Finset.prod_insert hp, map_mul]
      simp only [gaugedShortContribution, qbarConst, shortWeight]
      ring
  rw [hshort]
  simp only [gaugedLongContribution, qbarConst, matchingSignPolynomial]
  unfold taggedMatchingTermCoefficient longWeight shortWeight
  simp only [← map_prod, map_mul, map_pow, map_neg, map_one]
  ring

/-- The nonzero labelled term has degree equal to its complementary edge count. -/
theorem taggedMatching_term_natDegree {L : ℕ} (z : Qbar) (s : SpinStructure)
    (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L))
    (ht : t ⊆ matchingOrientedPairs D)
    (hterm : matchingSignPolynomial D *
      ((-1 : Polynomial Qbar) ^ t.card *
        (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
        (∏ p ∈ t, gaugedShortContribution z s p)) ≠ 0) :
    (matchingSignPolynomial D *
      ((-1 : Polynomial Qbar) ^ t.card *
        (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
        (∏ p ∈ t, gaugedShortContribution z s p))).natDegree =
      (taggedComplementEdges D t).card := by
  rw [taggedMatching_term_monomial] at hterm ⊢
  have hc : taggedMatchingTermCoefficient z s D t ≠ 0 := by
    intro h
    exact hterm (by simp [h])
  rw [natDegree_mul_C hc, natDegree_X_pow]
  exact taggedMatching_short_pairs_card z s D t ht
    (by simpa only [← taggedMatching_term_monomial] using hterm)

end Ising2DLambda.KacWard
