import Ising2DLambda.KacWard.TaggedMatchingEvenComplement
import Ising2DLambda.NecSuf.KacWard.LocalPairingMatching

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.PartitionPolynomial

/-- Pair the two orientations of each edge outside P, and use the chosen local
    pairing of oriented half-edges on P.  Endpoint numbers remain distinct at L=1. -/
noncomputable def localPairingMatching {L : ℕ} (P : Finset (Edge L))
    (κ : OrientedEdge L → OrientedEdge L)
    (hlocalSelected : ∀ h, h.1 ∈ P → (κ h).1 ∈ P)
    (hlocalInvolutive : ∀ h, h.1 ∈ P → κ (κ h) = h)
    (hlocalNe : ∀ h, h.1 ∈ P → κ h ≠ h) :
    PerfectMatching (OrientedEdge L) := by
  classical
  let τ : FixedPointFreeInvolution (OrientedEdge L) :=
    Ising2DLambda.NecSuf.KacWard.splicePairings
      (fun h => h.1 ∈ P) κ reversal
      hlocalSelected hlocalInvolutive hlocalNe
      (by intro h hh; simpa [reversal] using hh)
      (by intro h _; exact reversal_involutive h)
      (by intro h _; exact reversal_ne h)
  exact involutionToPerfectMatching τ

/-- The matching mate follows the selected local pair or the edge reversal. -/
theorem localPairingMatching_mate {L : ℕ} (P : Finset (Edge L))
    (κ : OrientedEdge L → OrientedEdge L)
    (hlocalSelected : ∀ h, h.1 ∈ P → (κ h).1 ∈ P)
    (hlocalInvolutive : ∀ h, h.1 ∈ P → κ (κ h) = h)
    (hlocalNe : ∀ h, h.1 ∈ P → κ h ≠ h)
    (h : OrientedEdge L) :
    perfectMatchingMate (localPairingMatching P κ hlocalSelected hlocalInvolutive hlocalNe) h =
      if h.1 ∈ P then κ h else reversal h := by
  classical
  unfold localPairingMatching
  rw [show perfectMatchingMate
      (involutionToPerfectMatching
        (Ising2DLambda.NecSuf.KacWard.splicePairings
          (fun h => h.1 ∈ P) κ reversal hlocalSelected hlocalInvolutive hlocalNe
          (by intro h hh; simpa [reversal] using hh)
          (by intro h _; exact reversal_involutive h)
          (by intro h _; exact reversal_ne h))) h =
      (Ising2DLambda.NecSuf.KacWard.splicePairings
        (fun h => h.1 ∈ P) κ reversal hlocalSelected hlocalInvolutive hlocalNe
        (by intro h hh; simpa [reversal] using hh)
        (by intro h _; exact reversal_involutive h)
        (by intro h _; exact reversal_ne h)).val h from
    congrArg (fun τ : FixedPointFreeInvolution (OrientedEdge L) => τ.val h)
      (matching_involution_right_inverse _)]
  simp only [Ising2DLambda.NecSuf.KacWard.splicePairings]
  split_ifs <;> rfl

end Ising2DLambda.KacWard
