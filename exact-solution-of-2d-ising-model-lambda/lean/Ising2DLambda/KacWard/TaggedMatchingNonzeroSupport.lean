import Ising2DLambda.KacWard.TaggedMatchingExpansion

namespace Ising2DLambda.KacWard

open Finset Ising2DLambda.AlgebraicEigenvalue

theorem longContribution_nonzero_reversal {L : ℕ} (z : Qbar)
    (s : SpinStructure) (p : OrientedEdge L × OrientedEdge L)
    (h : gaugedLongContribution z s p ≠ 0) : p.2 = reversal p.1 := by
  by_contra hp
  apply h
  simp [gaugedLongContribution, hp, qbarConst]

theorem shortContribution_nonzero_local {L : ℕ} (z : Qbar)
    (s : SpinStructure) (p : OrientedEdge L × OrientedEdge L)
    (h : gaugedShortContribution z s p ≠ 0) :
    orientedSource p.2 = orientedSource p.1 ∧ p.2 ≠ p.1 := by
  by_contra hp
  apply h
  simp [gaugedShortContribution, hp, qbarConst]

/-- The two labels are checked independently, including when their underlying pair coincides. -/
theorem taggedMatching_nonzero_support {L : ℕ} (z : Qbar) (s : SpinStructure)
    (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L))
    (hterm :
      (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
        (∏ p ∈ t, gaugedShortContribution z s p) ≠ 0) :
    (∀ p ∈ matchingOrientedPairs D \ t, p.2 = reversal p.1) ∧
      (∀ p ∈ t, orientedSource p.2 = orientedSource p.1 ∧ p.2 ≠ p.1) := by
  rcases mul_ne_zero_iff.mp hterm with ⟨hlong, hshort⟩
  constructor
  · intro p hp
    exact longContribution_nonzero_reversal z s p
      ((Finset.prod_ne_zero_iff.mp hlong) p hp)
  · intro p hp
    exact shortContribution_nonzero_local z s p
      ((Finset.prod_ne_zero_iff.mp hshort) p hp)

theorem taggedMatching_nonzero_term_support {L : ℕ} (z : Qbar) (s : SpinStructure)
    (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L))
    (hterm : matchingSignPolynomial D *
      ((-1 : Polynomial Qbar) ^ t.card *
        (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
        (∏ p ∈ t, gaugedShortContribution z s p)) ≠ 0) :
    (∀ p ∈ matchingOrientedPairs D \ t, p.2 = reversal p.1) ∧
      (∀ p ∈ t, orientedSource p.2 = orientedSource p.1 ∧ p.2 ≠ p.1) := by
  have hproducts :
      (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
        (∏ p ∈ t, gaugedShortContribution z s p) ≠ 0 := by
    have hrest := (mul_ne_zero_iff.mp hterm).2
    have hleft := (mul_ne_zero_iff.mp hrest).1
    exact mul_ne_zero (mul_ne_zero_iff.mp hleft).2
      (mul_ne_zero_iff.mp hrest).2
  exact taggedMatching_nonzero_support z s D t hproducts

end Ising2DLambda.KacWard
