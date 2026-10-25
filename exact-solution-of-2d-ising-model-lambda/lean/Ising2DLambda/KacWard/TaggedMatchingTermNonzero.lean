import Ising2DLambda.KacWard.LocalPairingMatching
import Ising2DLambda.KacWard.GaugePairWeightNonzero
import Ising2DLambda.KacWard.ShortPairCoefficientNonzero
import Ising2DLambda.KacWard.TaggedMatchingTermDegree
import Ising2DLambda.NecSuf.KacWard.TaggedMatchingTermNonzero

namespace Ising2DLambda.KacWard

open Finset Polynomial Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.PartitionPolynomial

/-- Every labelled factor in the matching constructed from a local pairing is nonzero. -/
theorem localPairingMatching_term_nonzero {L : ℕ} [NeZero L]
    (z : Qbar) (hz : z ^ (4 : ℕ) = -1) (s : SpinStructure)
    (P : Finset (Edge L)) (κ : OrientedEdge L → OrientedEdge L)
    (hlocalSelected : ∀ h, h.1 ∈ P → (κ h).1 ∈ P)
    (hlocalInvolutive : ∀ h, h.1 ∈ P → κ (κ h) = h)
    (hlocalNe : ∀ h, h.1 ∈ P → κ h ≠ h)
    (hlocalSource : ∀ h, h.1 ∈ P → orientedSource (κ h) = orientedSource h) :
    let D := localPairingMatching P κ hlocalSelected hlocalInvolutive hlocalNe
    let t := localPairingMatchingShortPairs P D
    matchingSignPolynomial D *
      ((-1 : Polynomial Qbar) ^ t.card *
        (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
        (∏ p ∈ t, gaugedShortContribution z s p)) ≠ 0 := by
  classical
  dsimp only
  let D := localPairingMatching P κ hlocalSelected hlocalInvolutive hlocalNe
  let t := localPairingMatchingShortPairs P D
  obtain ⟨_, hshort, hlong⟩ :=
    localPairingMatching_label_support P κ hlocalSelected hlocalInvolutive
      hlocalNe hlocalSource
  have hsign : matchingSignPolynomial D ≠ 0 := by
    rcases perfectMatchingSign_eq_one_or_neg_one D with h | h
    · simp [matchingSignPolynomial, h]
    · simp [matchingSignPolynomial, h]
  have hlongFactor : ∀ p ∈ matchingOrientedPairs D \ t,
      gaugedLongContribution z s p ≠ 0 := by
    intro p hp
    have hp' := (hlong p hp).1
    unfold gaugedLongContribution
    rw [if_pos hp']
    exact Polynomial.C_ne_zero.mpr (gaugePairWeight_ne_zero z hz s p.1 p.2)
  have hshortFactor : ∀ p ∈ t, gaugedShortContribution z s p ≠ 0 := by
    intro p hp
    obtain ⟨_, _, hsource, hne⟩ := hshort p hp
    unfold gaugedShortContribution
    rw [if_pos ⟨hsource, hne⟩]
    apply mul_ne_zero X_ne_zero
    apply Polynomial.C_ne_zero.mpr
    simpa only [mul_assoc] using
      shortPairCoefficient_ne_zero z hz s p.1 p.2 hsource.symm hne.symm
  have h := Ising2DLambda.NecSuf.KacWard.labelled_term_ne_zero
    (matchingOrientedPairs D) t (matchingSignPolynomial D)
    (gaugedLongContribution z s) (gaugedShortContribution z s)
    hsign hlongFactor hshortFactor
  simpa only [mul_assoc] using h

end Ising2DLambda.KacWard
