import Ising2DLambda.KacWard.TaggedMatchingNonzeroSupport
import Ising2DLambda.KacWard.ReversalFreeMovedSupportEven
import Ising2DLambda.AlgebraicEigenvalue.PerfectMatchingSign
import Ising2DLambda.NecSuf.KacWard.TaggedMatchingEvenComplement

namespace Ising2DLambda.KacWard

open Finset Ising2DLambda.AlgebraicEigenvalue Ising2DLambda.FisherZero
  Ising2DLambda.PartitionPolynomial

/-- A base edge is selected precisely when no long labelled pair uses its two orientations. -/
noncomputable def taggedComplementEdges {L : ℕ}
    (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L)) : Finset (Edge L) := by
  classical
  exact Finset.univ.filter fun e =>
    ¬ ∃ p ∈ matchingOrientedPairs D \ t, p.1.1 = e ∧ p.2.1 = e

theorem matching_pair_cover {J : Type*} [Fintype J] [LinearOrder J]
    (D : PerfectMatching J) (x : J) :
    ∃ p ∈ matchingOrientedPairs D, x = p.1 ∨ x = p.2 := by
  classical
  obtain ⟨q, hq, _⟩ := D.property.2 x
  obtain ⟨a, b, hab, hqab⟩ := D.property.1 q hq.1
  have hx : x = a ∨ x = b := by
    simpa [hqab] using hq.2
  rcases lt_or_gt_of_ne hab with hlt | hgt
  · refine ⟨(a, b), Finset.mem_filter.mpr ⟨Finset.mem_univ _, hlt, ?_⟩, ?_⟩
    · simpa [hqab] using hq.1
    · exact hx
  · refine ⟨(b, a), Finset.mem_filter.mpr ⟨Finset.mem_univ _, hgt, ?_⟩, ?_⟩
    · simpa [hqab, Set.pair_comm] using hq.1
    · exact hx.elim Or.inr Or.inl

private theorem same_base_or_reverse {L : ℕ} {h k : OrientedEdge L}
    (he : h.1 = k.1) : h = k ∨ h = reversal k := by
  rcases h with ⟨e, false | true⟩ <;>
    rcases k with ⟨e', false | true⟩ <;>
    change e = e' at he <;> subst e' <;>
    simp [reversal, Ising2DLambda.NecSuf.KacWard.reverseBool]

private theorem complement_iff_short_endpoint {L : ℕ}
    (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L))
    (ht : t ⊆ matchingOrientedPairs D)
    (hLong : ∀ p ∈ matchingOrientedPairs D \ t, p.2 = reversal p.1)
    (h : OrientedEdge L) :
    h.1 ∈ taggedComplementEdges D t ↔
      ∃ p ∈ t, h = p.1 ∨ h = p.2 := by
  classical
  constructor
  · intro hP
    obtain ⟨p, hp, hhp⟩ := matching_pair_cover D h
    by_cases hpt : p ∈ t
    · exact ⟨p, hpt, hhp⟩
    · have hpl : p ∈ matchingOrientedPairs D \ t := Finset.mem_sdiff.mpr ⟨hp, hpt⟩
      have heq := hLong p hpl
      have hbase : p.1.1 = h.1 := by
        rcases hhp with rfl | rfl
        · rfl
        · simp [heq, reversal]
      have hP' := (Finset.mem_filter.mp hP).2
      exact False.elim (hP' ⟨p, hpl, hbase, by simpa [heq, reversal] using hbase⟩)
  · rintro ⟨p, hpt, hhp⟩
    apply Finset.mem_filter.mpr
    refine ⟨Finset.mem_univ _, ?_⟩
    rintro ⟨q, hq, hqbase₁, hqbase₂⟩
    have hqs : q ∈ matchingOrientedPairs D := (Finset.mem_sdiff.mp hq).1
    have hqn : q ∉ t := (Finset.mem_sdiff.mp hq).2
    have hrev := hLong q hq
    have hhbase : h.1 = q.1.1 := by
      rcases hhp with rfl | rfl <;> simp [hqbase₁, hqbase₂]
    have hhq : h = q.1 ∨ h = q.2 := by
      rcases same_base_or_reverse hhbase with hfirst | hsecond
      · exact Or.inl hfirst
      · exact Or.inr (by simpa [hrev] using hsecond)
    have hxp : h ∈ [p.1, p.2] := by rcases hhp with rfl | rfl <;> simp
    have hxq : h ∈ [q.1, q.2] := by rcases hhq with rfl | rfl <;> simp
    have hpq := matchingOrientedPairs_disjoint D (ht hpt) hqs hxp hxq
    exact hqn (hpq ▸ hpt)

private theorem matching_sum_by_pairs {J : Type*} [Fintype J] [LinearOrder J]
    (D : PerfectMatching J) (f : J → ℕ) :
    (∑ x : J, f x) =
      ∑ p ∈ matchingOrientedPairs D, (f p.1 + f p.2) := by
  classical
  let pairSet : J × J → Finset J := fun p => {p.1, p.2}
  have hdisj : (↑(matchingOrientedPairs D) : Set (J × J)).PairwiseDisjoint pairSet := by
    intro p hp q hq hpq
    apply Finset.disjoint_left.mpr
    intro x hxp hxq
    have hpq' := matchingOrientedPairs_disjoint D hp hq
      (by simpa [pairSet] using hxp) (by simpa [pairSet] using hxq)
    exact hpq hpq'
  have hcover : (matchingOrientedPairs D).biUnion pairSet = Finset.univ := by
    ext x
    simp only [Finset.mem_biUnion, Finset.mem_univ, iff_true]
    obtain ⟨p, hp, hx⟩ := matching_pair_cover D x
    refine ⟨p, hp, ?_⟩
    rcases hx with rfl | rfl <;> simp [pairSet]
  calc
    (∑ x : J, f x) = ∑ x ∈ (matchingOrientedPairs D).biUnion pairSet, f x := by
      rw [hcover]
    _ = ∑ p ∈ matchingOrientedPairs D, ∑ x ∈ pairSet p, f x :=
      Finset.sum_biUnion hdisj
    _ = ∑ p ∈ matchingOrientedPairs D, (f p.1 + f p.2) := by
      apply Finset.sum_congr rfl
      intro p hp
      have hlt := (Finset.mem_filter.mp hp).2.1
      simp [pairSet, hlt.ne]

private theorem incidence_as_oriented_sum {L : ℕ} (P : Finset (Edge L))
    (v : Vertex L) :
    edgeSubsetIncidenceCount L P v =
      ∑ h : OrientedEdge L,
        if h.1 ∈ P ∧ orientedSource h = v then 1 else 0 := by
  classical
  change edgeSubsetIncidenceCount L P v =
    ∑ h : Edge L × Bool,
      if h.1 ∈ P ∧ orientedSource h = v then 1 else 0
  rw [Fintype.sum_prod_type]
  simp only [Fintype.sum_bool]
  simp [edgeSubsetIncidenceCount, orientedSource, Finset.sum_add_distrib]
  have h₀ : (P.filter fun x => boundary0 L x = v) =
      (Finset.univ.filter fun x => x ∈ P ∧ boundary0 L x = v) := by
    ext x
    simp
  have h₁ : (P.filter fun x => boundary1 L x = v) =
      (Finset.univ.filter fun x => x ∈ P ∧ boundary1 L x = v) := by
    ext x
    simp
  rw [h₀, h₁]
  exact add_comm _ _

/-- Every surviving labelled pair contributes either zero or two incidences. -/
theorem taggedMatching_even_complement {L : ℕ} (z : Qbar) (s : SpinStructure)
    (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L))
    (ht : t ⊆ matchingOrientedPairs D)
    (hterm : matchingSignPolynomial D *
      ((-1 : Polynomial Qbar) ^ t.card *
        (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
        (∏ p ∈ t, gaugedShortContribution z s p)) ≠ 0) :
    IsEvenEdgeSubset L (taggedComplementEdges D t) := by
  classical
  obtain ⟨hLong, hShort⟩ := taggedMatching_nonzero_term_support z s D t hterm
  intro v
  rw [incidence_as_oriented_sum]
  apply Ising2DLambda.NecSuf.KacWard.even_of_pair_contributions
    (matchingOrientedPairs D) Prod.fst Prod.snd
    (fun h => if h.1 ∈ taggedComplementEdges D t ∧ orientedSource h = v then 1 else 0)
    (matching_sum_by_pairs D _)
  intro p hp
  by_cases hpt : p ∈ t
  · have hp₁ : p.1.1 ∈ taggedComplementEdges D t :=
      (complement_iff_short_endpoint D t ht hLong p.1).2 ⟨p, hpt, Or.inl rfl⟩
    have hp₂ : p.2.1 ∈ taggedComplementEdges D t :=
      (complement_iff_short_endpoint D t ht hLong p.2).2 ⟨p, hpt, Or.inr rfl⟩
    have hs := (hShort p hpt).1
    by_cases hv : orientedSource p.1 = v
    · simp [hp₁, hp₂, hs, hv]
    · simp [hp₁, hp₂, hs, hv]
  · have hpl : p ∈ matchingOrientedPairs D \ t :=
      Finset.mem_sdiff.mpr ⟨hp, hpt⟩
    have hrev := hLong p hpl
    have hp₁ : p.1.1 ∉ taggedComplementEdges D t := by
      intro hP
      exact (Finset.mem_filter.mp hP).2 ⟨p, hpl, rfl, by simp [hrev, reversal]⟩
    have hp₂ : p.2.1 ∉ taggedComplementEdges D t := by
      simpa [hrev, reversal] using hp₁
    simp [hp₁, hp₂]

/-- Counting both orientations of each unused edge counts every short pair twice. -/
theorem taggedMatching_short_pairs_card {L : ℕ} (z : Qbar) (s : SpinStructure)
    (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L))
    (ht : t ⊆ matchingOrientedPairs D)
    (hterm : matchingSignPolynomial D *
      ((-1 : Polynomial Qbar) ^ t.card *
        (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
        (∏ p ∈ t, gaugedShortContribution z s p)) ≠ 0) :
    t.card = (taggedComplementEdges D t).card := by
  classical
  obtain ⟨hLong, hShort⟩ := taggedMatching_nonzero_term_support z s D t hterm
  let P := taggedComplementEdges D t
  have hcount : (∑ h : OrientedEdge L, if h.1 ∈ P then 1 else 0) =
      ∑ p ∈ matchingOrientedPairs D,
        ((if p.1.1 ∈ P then 1 else 0) + (if p.2.1 ∈ P then 1 else 0)) :=
    matching_sum_by_pairs D _
  have hleft : (∑ h : OrientedEdge L, if h.1 ∈ P then 1 else 0) =
      2 * P.card := by
    change (∑ h : Edge L × Bool, if h.1 ∈ P then 1 else 0) = 2 * P.card
    rw [Fintype.sum_prod_type]
    simp only [Fintype.sum_bool]
    calc
      (∑ e : Edge L, ((if e ∈ P then 1 else 0) + if e ∈ P then 1 else 0)) =
          2 * (∑ e : Edge L, if e ∈ P then 1 else 0) := by
        rw [Finset.mul_sum]
        apply Finset.sum_congr rfl
        intro e he
        split_ifs <;> omega
      _ = 2 * P.card := by simp
  have hpair : ∀ p ∈ matchingOrientedPairs D,
      ((if p.1.1 ∈ P then 1 else 0) + (if p.2.1 ∈ P then 1 else 0)) =
        if p ∈ t then 2 else 0 := by
    intro p hp
    by_cases hpt : p ∈ t
    · have hp₁ : p.1.1 ∈ P :=
        (complement_iff_short_endpoint D t ht hLong p.1).2 ⟨p, hpt, Or.inl rfl⟩
      have hp₂ : p.2.1 ∈ P :=
        (complement_iff_short_endpoint D t ht hLong p.2).2 ⟨p, hpt, Or.inr rfl⟩
      simp [hpt, hp₁, hp₂]
    · have hpl : p ∈ matchingOrientedPairs D \ t := Finset.mem_sdiff.mpr ⟨hp, hpt⟩
      have hrev := hLong p hpl
      have hp₁ : p.1.1 ∉ P := by
        intro hP
        exact (Finset.mem_filter.mp hP).2 ⟨p, hpl, rfl, by simp [hrev, reversal]⟩
      have hp₂ : p.2.1 ∉ P := by simpa [hrev, reversal] using hp₁
      simp [hpt, hp₁, hp₂]
  exact Ising2DLambda.NecSuf.KacWard.short_pair_count_of_double_count
    (matchingOrientedPairs D) t P Prod.fst Prod.snd
    (fun h => if h.1 ∈ P then 1 else 0) ht hcount hpair hleft

/-- At a fixed vertex, every selected half-edge belongs to exactly one short pair. -/
theorem taggedMatching_local_pair_unique {L : ℕ} (z : Qbar) (s : SpinStructure)
    (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L))
    (ht : t ⊆ matchingOrientedPairs D)
    (hterm : matchingSignPolynomial D *
      ((-1 : Polynomial Qbar) ^ t.card *
        (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
        (∏ p ∈ t, gaugedShortContribution z s p)) ≠ 0)
    (v : Vertex L) (h : OrientedEdge L) :
    (h.1 ∈ taggedComplementEdges D t ∧ orientedSource h = v) ↔
      ∃! p : OrientedEdge L × OrientedEdge L,
        p ∈ t ∧ orientedSource p.1 = v ∧ (h = p.1 ∨ h = p.2) := by
  classical
  obtain ⟨hLong, hShort⟩ := taggedMatching_nonzero_term_support z s D t hterm
  constructor
  · rintro ⟨hP, hv⟩
    obtain ⟨p, hp, hhp⟩ :=
      (complement_iff_short_endpoint D t ht hLong h).mp hP
    have hsrc : orientedSource p.1 = v := by
      rcases hhp with rfl | rfl
      · exact hv
      · exact (hShort p hp).1.symm.trans hv
    refine ⟨p, ⟨hp, hsrc, hhp⟩, ?_⟩
    intro q hq
    obtain ⟨hqt, _, hhq⟩ := hq
    have hxp : h ∈ [p.1, p.2] := by rcases hhp with rfl | rfl <;> simp
    have hxq : h ∈ [q.1, q.2] := by rcases hhq with rfl | rfl <;> simp
    exact (matchingOrientedPairs_disjoint D (ht hqt) (ht hp) hxq hxp)
  · rintro ⟨p, ⟨hp, hsrc, hhp⟩, _⟩
    refine ⟨(complement_iff_short_endpoint D t ht hLong h).mpr ⟨p, hp, hhp⟩, ?_⟩
    rcases hhp with rfl | rfl
    · exact hsrc
    · exact (hShort p hp).1.trans hsrc

/-- The generic partition statement specializes to oriented edges and their sources. -/
theorem taggedMatching_local_pair_unique_from_necSuf {L : ℕ} (z : Qbar)
    (s : SpinStructure) (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L))
    (ht : t ⊆ matchingOrientedPairs D)
    (hterm : matchingSignPolynomial D *
      ((-1 : Polynomial Qbar) ^ t.card *
        (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
        (∏ p ∈ t, gaugedShortContribution z s p)) ≠ 0)
    (v : Vertex L) (h : OrientedEdge L) :
    (h.1 ∈ taggedComplementEdges D t ∧ orientedSource h = v) ↔
      ∃! p : OrientedEdge L × OrientedEdge L,
        p ∈ t ∧ orientedSource p.1 = v ∧ (h = p.1 ∨ h = p.2) := by
  classical
  obtain ⟨hLong, hShort⟩ := taggedMatching_nonzero_term_support z s D t hterm
  exact Ising2DLambda.NecSuf.KacWard.local_pair_unique_of_partition
    t Prod.fst Prod.snd orientedSource
    (fun h => h.1 ∈ taggedComplementEdges D t)
    (fun h => complement_iff_short_endpoint D t ht hLong h)
    (fun p hp => (hShort p hp).1.symm)
    (by
      intro p hp q hq x hxp hxq
      have hxp' : x ∈ [p.1, p.2] := by rcases hxp with rfl | rfl <;> simp
      have hxq' : x ∈ [q.1, q.2] := by rcases hxq with rfl | rfl <;> simp
      exact matchingOrientedPairs_disjoint D (ht hp) (ht hq) hxp' hxq')
    v h

end Ising2DLambda.KacWard
