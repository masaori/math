import Ising2DLambda.KacWard.TaggedMatchingEvenComplement
import Ising2DLambda.NecSuf.KacWard.LocalPairingMatching
import Ising2DLambda.NecSuf.KacWard.MatchingRecovery
import Ising2DLambda.NecSuf.KacWard.TaggedMatchingLabelRecovery

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

/-- On each selected half-edge the constructed matching recovers the
    originally chosen local involution, including the two endpoints at L=1. -/
theorem localPairingMatching_recovers_local_mate {L : ℕ} (P : Finset (Edge L))
    (κ : OrientedEdge L → OrientedEdge L)
    (hlocalSelected : ∀ h, h.1 ∈ P → (κ h).1 ∈ P)
    (hlocalInvolutive : ∀ h, h.1 ∈ P → κ (κ h) = h)
    (hlocalNe : ∀ h, h.1 ∈ P → κ h ≠ h)
    (h : OrientedEdge L) (hh : h.1 ∈ P) :
    perfectMatchingMate
      (localPairingMatching P κ hlocalSelected hlocalInvolutive hlocalNe) h = κ h := by
  rw [localPairingMatching_mate]
  simp [hh]

/-- The selected local mate and the reversal outside the complement recover
    the entire matching underlying a nonzero tagged term. -/
theorem taggedMatching_recovers_matching {L : ℕ} (z : Qbar)
    (s : SpinStructure) (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L))
    (ht : t ⊆ matchingOrientedPairs D)
    (hterm : matchingSignPolynomial D *
      ((-1 : Polynomial Qbar) ^ t.card *
        (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
        (∏ p ∈ t, gaugedShortContribution z s p)) ≠ 0)
    (κ : OrientedEdge L → OrientedEdge L)
    (hlocalSelected : ∀ h, h.1 ∈ taggedComplementEdges D t →
      (κ h).1 ∈ taggedComplementEdges D t)
    (hlocalInvolutive : ∀ h, h.1 ∈ taggedComplementEdges D t → κ (κ h) = h)
    (hlocalNe : ∀ h, h.1 ∈ taggedComplementEdges D t → κ h ≠ h)
    (hκ : ∀ h, h.1 ∈ taggedComplementEdges D t →
      κ h = perfectMatchingMate D h) :
    localPairingMatching (taggedComplementEdges D t) κ
      hlocalSelected hlocalInvolutive hlocalNe = D := by
  classical
  apply (perfectMatchingToInvolution_bijective (J := OrientedEdge L)).1
  apply Subtype.ext
  funext h
  change perfectMatchingMate
      (localPairingMatching (taggedComplementEdges D t) κ
        hlocalSelected hlocalInvolutive hlocalNe) h = perfectMatchingMate D h
  by_cases hh : h.1 ∈ taggedComplementEdges D t
  · calc
      perfectMatchingMate
          (localPairingMatching (taggedComplementEdges D t) κ
            hlocalSelected hlocalInvolutive hlocalNe) h = κ h :=
        localPairingMatching_recovers_local_mate _ _ _ _ _ h hh
      _ = perfectMatchingMate D h := hκ h hh
  · calc
      perfectMatchingMate
          (localPairingMatching (taggedComplementEdges D t) κ
            hlocalSelected hlocalInvolutive hlocalNe) h = reversal h := by
        rw [localPairingMatching_mate]
        simp [hh]
      _ = perfectMatchingMate D h :=
        (taggedMatching_mate_outside_complement z s D t ht hterm h hh).symm

/-- Each canonical pair of the constructed matching stays in the selected
    half-edges or is exactly one reversal pair outside them. -/
theorem localPairingMatching_pair_support {L : ℕ} (P : Finset (Edge L))
    (κ : OrientedEdge L → OrientedEdge L)
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
  have hmate : perfectMatchingMate
      (localPairingMatching P κ hlocalSelected hlocalInvolutive hlocalNe) p.1 = p.2 :=
    perfectMatchingMate_eq_of_pair _ p.1 p.2 hp'.1.ne' hp'.2
  rw [localPairingMatching_mate] at hmate
  constructor
  · intro hP
    have hpair : p.2 = κ p.1 := by simpa [hP] using hmate.symm
    exact ⟨hpair, hpair ▸ hlocalSelected p.1 hP,
      hpair ▸ hlocalSource p.1 hP⟩
  · intro hP
    have hpair : p.2 = reversal p.1 := by simpa [hP] using hmate.symm
    refine ⟨hpair, ?_⟩
    simpa [hpair, reversal] using hP

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
  exact Ising2DLambda.NecSuf.KacWard.splice_pair_support
    (fun h => h.1 ∈ P) κ reversal orientedSource
    hlocalSelected hlocalSource
    (by intro h hh; simpa [reversal] using hh) p hmate

/-- A pair receives the short label exactly when its first oriented edge lies over P. -/
noncomputable def localPairingMatchingShortPairs {L : ℕ} (P : Finset (Edge L))
    (D : PerfectMatching (OrientedEdge L)) :
    Finset (OrientedEdge L × OrientedEdge L) := by
  classical
  exact (matchingOrientedPairs D).filter (fun p => p.1.1 ∈ P)

/-- The complement identifies the short label independently of the underlying
    two-element pair, including when the long and short entries coincide. -/
theorem taggedMatching_recovers_labels {L : ℕ} (z : Qbar)
    (s : SpinStructure) (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L))
    (ht : t ⊆ matchingOrientedPairs D)
    (hterm : matchingSignPolynomial D *
      ((-1 : Polynomial Qbar) ^ t.card *
        (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
        (∏ p ∈ t, gaugedShortContribution z s p)) ≠ 0) :
    t = localPairingMatchingShortPairs (taggedComplementEdges D t) D := by
  classical
  obtain ⟨hLong, _⟩ := taggedMatching_nonzero_term_support z s D t hterm
  ext p
  constructor
  · intro hp
    exact Finset.mem_filter.mpr ⟨ht hp,
      (complement_iff_short_endpoint D t ht hLong p.1).mpr
        ⟨p, hp, Or.inl rfl⟩⟩
  · intro hp
    obtain ⟨hpD, hpP⟩ := Finset.mem_filter.mp hp
    obtain ⟨q, hq, hendpoint⟩ :=
      (complement_iff_short_endpoint D t ht hLong p.1).mp hpP
    have hpq : p = q := matchingOrientedPairs_disjoint D hpD (ht hq)
      (x := p.1) (by simp) (by simpa using hendpoint)
    exact hpq ▸ hq

theorem localPairingMatching_label_support {L : ℕ} (P : Finset (Edge L))
    (κ : OrientedEdge L → OrientedEdge L)
    (hlocalSelected : ∀ h, h.1 ∈ P → (κ h).1 ∈ P)
    (hlocalInvolutive : ∀ h, h.1 ∈ P → κ (κ h) = h)
    (hlocalNe : ∀ h, h.1 ∈ P → κ h ≠ h)
    (hlocalSource : ∀ h, h.1 ∈ P → orientedSource (κ h) = orientedSource h) :
    let D := localPairingMatching P κ hlocalSelected hlocalInvolutive hlocalNe
    let t := localPairingMatchingShortPairs P D
    t ⊆ matchingOrientedPairs D ∧
      (∀ p ∈ t, p.2 = κ p.1 ∧ p.2.1 ∈ P ∧
        orientedSource p.2 = orientedSource p.1 ∧ p.2 ≠ p.1) ∧
      (∀ p ∈ matchingOrientedPairs D \ t,
        p.2 = reversal p.1 ∧ p.2.1 ∉ P) := by
  classical
  dsimp only
  constructor
  · intro p hp
    exact (Finset.mem_filter.mp hp).1
  constructor
  · intro p hp
    have hP := (Finset.mem_filter.mp hp).2
    have hpair := (localPairingMatching_pair_support P κ hlocalSelected
      hlocalInvolutive hlocalNe hlocalSource p (Finset.mem_filter.mp hp).1).1 hP
    refine ⟨hpair.1, hpair.2.1, hpair.2.2, ?_⟩
    have hlt := (Finset.mem_filter.mp (Finset.mem_filter.mp hp).1).2.1
    exact hlt.ne'
  · intro p hp
    have hp' := Finset.mem_sdiff.mp hp
    have hnot : p.1.1 ∉ P := by
      intro hP
      exact hp'.2 (Finset.mem_filter.mpr ⟨hp'.1, hP⟩)
    exact (localPairingMatching_pair_support P κ hlocalSelected
      hlocalInvolutive hlocalNe hlocalSource p hp'.1).2 hnot

/-- The edges unused by long labelled pairs are exactly the selected edges. -/
theorem localPairingMatching_complement_edges {L : ℕ} (P : Finset (Edge L))
    (κ : OrientedEdge L → OrientedEdge L)
    (hlocalSelected : ∀ h, h.1 ∈ P → (κ h).1 ∈ P)
    (hlocalInvolutive : ∀ h, h.1 ∈ P → κ (κ h) = h)
    (hlocalNe : ∀ h, h.1 ∈ P → κ h ≠ h)
    (hlocalSource : ∀ h, h.1 ∈ P → orientedSource (κ h) = orientedSource h) :
    let D := localPairingMatching P κ hlocalSelected hlocalInvolutive hlocalNe
    taggedComplementEdges D (localPairingMatchingShortPairs P D) = P := by
  classical
  dsimp only
  let D := localPairingMatching P κ hlocalSelected hlocalInvolutive hlocalNe
  let t := localPairingMatchingShortPairs P D
  have hlabels := localPairingMatching_label_support P κ hlocalSelected
    hlocalInvolutive hlocalNe hlocalSource
  dsimp only at hlabels
  apply Finset.ext
  intro e
  constructor
  · intro he
    by_contra hnot
    obtain ⟨p, hp, hh⟩ := matching_pair_cover D (e, false)
    have hbranch := localPairingMatching_pair_support P κ hlocalSelected
      hlocalInvolutive hlocalNe hlocalSource p hp
    have hpnot : p.1.1 ∉ P := by
      intro hpP
      rcases hh with hh | hh
      · have hb : e = p.1.1 := by simpa only using congrArg Prod.fst hh
        exact hnot (hb.symm ▸ hpP)
      · have hb : e = p.2.1 := by simpa only using congrArg Prod.fst hh
        exact hnot (hb.symm ▸ (hbranch.1 hpP).2.1)
    have hpt : p ∉ t := by
      intro hpt
      exact hpnot (Finset.mem_filter.mp hpt).2
    have hpl : p ∈ matchingOrientedPairs D \ t :=
      Finset.mem_sdiff.mpr ⟨hp, hpt⟩
    have hrev : p.2 = reversal p.1 := (hlabels.2.2 p hpl).1
    have hbase : p.1.1 = e := by
      rcases hh with hh | hh
      · exact (congrArg Prod.fst hh).symm
      · have hb : e = p.2.1 := congrArg Prod.fst hh
        simpa [hrev, reversal] using hb.symm
    exact (Finset.mem_filter.mp he).2
      ⟨p, hpl, hbase, by simpa [hrev, reversal] using hbase⟩
  · intro he
    apply Finset.mem_filter.mpr
    refine ⟨Finset.mem_univ _, ?_⟩
    rintro ⟨p, hpl, hbase, _⟩
    have hpnot : p.2.1 ∉ P := (hlabels.2.2 p hpl).2
    exact hpnot (by simpa [hbase, (hlabels.2.2 p hpl).1, reversal] using he)

end Ising2DLambda.KacWard
