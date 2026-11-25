/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.LocalPairingMatching
import Ising2DLambda.NecSuf.KacWard.MatchingRecovery
import Ising2DLambda.NecSuf.KacWard.TaggedMatchingLabelRecovery

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.PartitionPolynomial

/-- The concrete branch statement is an instance of the source-preserving
    splice argument. -/
theorem localPairingMatching_pair_support_from_necSuf {L : ℕ}
    (P : Finset (Edge L)) (κ : OrientedEdge L → OrientedEdge L)
    (hlocalSelected : ∀ h, h.1 ∈ P → (κ h).1 ∈ P)
    (hlocalInvolutive : ∀ h, h.1 ∈ P → κ (κ h) = h)
    (hlocalNe : ∀ h, h.1 ∈ P → κ h ≠ h)
    (hlocalSource : ∀ h, h.1 ∈ P → orientedSource (κ h) = orientedSource h)
    (p : OrientedEdge L × OrientedEdge L)
    (hp : p ∈ matchingOrientedPairs
      (localPairingMatching P κ hlocalSelected hlocalInvolutive hlocalNe)) :
    (p.1.1 ∈ P → p.2 = κ p.1 ∧ p.2.1 ∈ P ∧
      orientedSource p.2 = orientedSource p.1) ∧
    (p.1.1 ∉ P → p.2 = reversal p.1 ∧ p.2.1 ∉ P) := by
  classical
  have hp' := (Finset.mem_filter.mp hp).2
  have hmate : p.2 = if p.1.1 ∈ P then κ p.1 else reversal p.1 := by
    have h := perfectMatchingMate_eq_of_pair
      (localPairingMatching P κ hlocalSelected hlocalInvolutive hlocalNe)
      p.1 p.2 hp'.1.ne' hp'.2
    rw [localPairingMatching_mate] at h
    exact h.symm
  constructor
  · intro hP
    have hpair : p.2 = κ p.1 := by simpa [hP] using hmate
    exact ⟨hpair, hpair ▸ hlocalSelected p.1 hP,
      hpair ▸ hlocalSource p.1 hP⟩
  · intro hP
    have hpair : p.2 = reversal p.1 := by simpa [hP] using hmate
    refine ⟨hpair, ?_⟩
    simpa [hpair, reversal] using hP

end Ising2DLambda.KacWard
