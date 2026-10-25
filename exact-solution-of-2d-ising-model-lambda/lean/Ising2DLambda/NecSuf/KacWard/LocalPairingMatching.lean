import Ising2DLambda.NecSuf.AlgebraicEigenvalue.PerfectMatching
import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

/-- A localMate pairing on selected points and a reversal pairing on their complement
    join to a fixed-point-free involution.  Preservation of the selected set is
    exactly what prevents a point from changing branch on the second step. -/
noncomputable def splicePairings {J : Type*}
    (selected : J → Prop)
    (localMate reverse : J → J)
    (hlocalSelected : ∀ j, selected j → selected (localMate j))
    (hlocalInvolutive : ∀ j, selected j → localMate (localMate j) = j)
    (hlocalNe : ∀ j, selected j → localMate j ≠ j)
    (hreverseOutside : ∀ j, ¬ selected j → ¬ selected (reverse j))
    (hreverseInvolutive : ∀ j, ¬ selected j → reverse (reverse j) = j)
    (hreverseNe : ∀ j, ¬ selected j → reverse j ≠ j) :
    {τ : J → J // (∀ j, τ j ≠ j) ∧ Function.Involutive τ} := by
  classical
  let τ : J → J := fun j => if selected j then localMate j else reverse j
  have hne : ∀ j, τ j ≠ j := by
    intro j
    by_cases hj : selected j
    · simpa [τ, hj] using hlocalNe j hj
    · simpa [τ, hj] using hreverseNe j hj
  have hinv : Function.Involutive τ := by
    intro j
    by_cases hj : selected j
    · have hnext := hlocalSelected j hj
      simp [τ, hj, hnext, hlocalInvolutive j hj]
    · have hnext := hreverseOutside j hj
      simp [τ, hj, hnext, hreverseInvolutive j hj]
  exact ⟨τ, hne, hinv⟩

/-- The two-point orbits of the spliced involution partition the index set. -/
noncomputable def splicePairingMatching {J : Type*}
    (selected : J → Prop) (localMate reverse : J → J)
    (hlocalSelected : ∀ j, selected j → selected (localMate j))
    (hlocalInvolutive : ∀ j, selected j → localMate (localMate j) = j)
    (hlocalNe : ∀ j, selected j → localMate j ≠ j)
    (hreverseOutside : ∀ j, ¬ selected j → ¬ selected (reverse j))
    (hreverseInvolutive : ∀ j, ¬ selected j → reverse (reverse j) = j)
    (hreverseNe : ∀ j, ¬ selected j → reverse j ≠ j) :
    Ising2DLambda.NecSuf.AlgebraicEigenvalue.PerfectMatching J :=
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.involutionToPerfectMatching
    (splicePairings selected localMate reverse hlocalSelected hlocalInvolutive
      hlocalNe hreverseOutside hreverseInvolutive hreverseNe)

/-- The matching made by splicing retains the chosen mate on selected points. -/
theorem splicePairingMatching_selected_mate {J : Type*}
    (selected : J → Prop) [DecidablePred selected]
    (localMate reverse : J → J)
    (hlocalSelected : ∀ j, selected j → selected (localMate j))
    (hlocalInvolutive : ∀ j, selected j → localMate (localMate j) = j)
    (hlocalNe : ∀ j, selected j → localMate j ≠ j)
    (hreverseOutside : ∀ j, ¬ selected j → ¬ selected (reverse j))
    (hreverseInvolutive : ∀ j, ¬ selected j → reverse (reverse j) = j)
    (hreverseNe : ∀ j, ¬ selected j → reverse j ≠ j)
    (j : J) (hj : selected j) :
    Ising2DLambda.NecSuf.AlgebraicEigenvalue.perfectMatchingMate
      (splicePairingMatching selected localMate reverse hlocalSelected
        hlocalInvolutive hlocalNe hreverseOutside hreverseInvolutive hreverseNe) j =
      localMate j := by
  classical
  let τ := splicePairings selected localMate reverse hlocalSelected
    hlocalInvolutive hlocalNe hreverseOutside hreverseInvolutive hreverseNe
  have hm : Ising2DLambda.NecSuf.AlgebraicEigenvalue.perfectMatchingMate
      (Ising2DLambda.NecSuf.AlgebraicEigenvalue.involutionToPerfectMatching τ) j =
      τ.val j :=
    congrArg (fun σ : Ising2DLambda.NecSuf.AlgebraicEigenvalue.FixedPointFreeInvolution J =>
      σ.val j)
      (Ising2DLambda.NecSuf.AlgebraicEigenvalue.matching_involution_right_inverse τ)
  simpa [splicePairingMatching, τ, splicePairings, hj] using hm

/-- Only branch preservation and a mate equation are needed for pair support. -/
theorem splice_pair_support {J : Type*} (selected : J → Prop)
    [DecidablePred selected]
    (localMate reverse : J → J) (source : J → J')
    (hlocalSelected : ∀ j, selected j → selected (localMate j))
    (hlocalSource : ∀ j, selected j → source (localMate j) = source j)
    (hreverseOutside : ∀ j, ¬ selected j → ¬ selected (reverse j))
    (p : J × J)
    (hmate : p.2 = if selected p.1 then localMate p.1 else reverse p.1) :
    (selected p.1 → p.2 = localMate p.1 ∧ selected p.2 ∧
      source p.2 = source p.1) ∧
    (¬ selected p.1 → p.2 = reverse p.1 ∧ ¬ selected p.2) := by
  classical
  constructor
  · intro hp
    have hpair : p.2 = localMate p.1 := by simpa [hp] using hmate
    exact ⟨hpair, hpair ▸ hlocalSelected p.1 hp,
      hpair ▸ hlocalSource p.1 hp⟩
  · intro hp
    have hpair : p.2 = reverse p.1 := by simpa [hp] using hmate
    exact ⟨hpair, hpair ▸ hreverseOutside p.1 hp⟩

/-- Filtering canonical pairs by the selected first endpoint gives the unique
    label determined by the two branches of the splice. -/
theorem splice_label_support {J V : Type*} [DecidableEq J]
    (pairs : Finset (J × J)) (selected : J → Prop) [DecidablePred selected]
    (localMate reverse : J → J) (source : J → V)
    (hlocalSelected : ∀ j, selected j → selected (localMate j))
    (hlocalSource : ∀ j, selected j → source (localMate j) = source j)
    (hreverseOutside : ∀ j, ¬ selected j → ¬ selected (reverse j))
    (hmate : ∀ p ∈ pairs,
      p.2 = if selected p.1 then localMate p.1 else reverse p.1) :
    let short := pairs.filter (fun p => selected p.1)
    short ⊆ pairs ∧
      (∀ p ∈ short,
        p.2 = localMate p.1 ∧ selected p.2 ∧ source p.2 = source p.1) ∧
      (∀ p ∈ pairs \ short, p.2 = reverse p.1 ∧ ¬ selected p.2) := by
  classical
  dsimp only
  constructor
  · intro p hp
    exact (Finset.mem_filter.mp hp).1
  constructor
  · intro p hp
    have hmem := (Finset.mem_filter.mp hp)
    exact (splice_pair_support selected localMate reverse source
      hlocalSelected hlocalSource hreverseOutside p (hmate p hmem.1)).1 hmem.2
  · intro p hp
    have hmem := Finset.mem_sdiff.mp hp
    have hnot : ¬ selected p.1 := by
      intro hselected
      exact hmem.2 (Finset.mem_filter.mpr ⟨hmem.1, hselected⟩)
    exact (splice_pair_support selected localMate reverse source
      hlocalSelected hlocalSource hreverseOutside p (hmate p hmem.1)).2 hnot

/-- Pair coverage, selected-state agreement and the long-pair base equation
    suffice to recover the selected base set from the long-pair complement. -/
theorem selected_eq_long_pair_complement {E J : Type*}
    [Fintype E] [DecidableEq E] [DecidableEq J]
    (base : J → E) (selected : Finset E) (pairs short : Finset (J × J))
    (hcover : ∀ e : E, ∃ p ∈ pairs, base p.1 = e ∨ base p.2 = e)
    (hagrees : ∀ p ∈ pairs, base p.1 ∈ selected ↔ base p.2 ∈ selected)
    (hshort : short = pairs.filter (fun p => base p.1 ∈ selected))
    (hlong : ∀ p ∈ pairs \ short, base p.1 = base p.2) :
    (Finset.univ.filter fun e =>
      ¬ ∃ p ∈ pairs \ short, base p.1 = e ∧ base p.2 = e) = selected := by
  classical
  apply Finset.ext
  intro e
  constructor
  · intro he
    by_contra hnot
    obtain ⟨p, hp, hpe | hpe⟩ := hcover e
    · have hpnot : p ∉ short := by
        rw [hshort]
        intro hs
        exact hnot (hpe ▸ (Finset.mem_filter.mp hs).2)
      have hpl : p ∈ pairs \ short := Finset.mem_sdiff.mpr ⟨hp, hpnot⟩
      exact (Finset.mem_filter.mp he).2
        ⟨p, hpl, hpe, (hlong p hpl).symm ▸ hpe⟩
    · have hpnot : p ∉ short := by
        rw [hshort]
        intro hs
        exact hnot (hpe ▸ (hagrees p hp).mp (Finset.mem_filter.mp hs).2)
      have hpl : p ∈ pairs \ short := Finset.mem_sdiff.mpr ⟨hp, hpnot⟩
      have hb : base p.1 = e := (hlong p hpl).trans hpe
      exact (Finset.mem_filter.mp he).2 ⟨p, hpl, hb, hpe⟩
  · intro he
    apply Finset.mem_filter.mpr
    refine ⟨Finset.mem_univ _, ?_⟩
    rintro ⟨p, hpl, hb, _⟩
    have hpnot : p ∉ short := (Finset.mem_sdiff.mp hpl).2
    have hfirst : base p.1 ∉ selected := by
      intro hs
      exact hpnot (hshort ▸ Finset.mem_filter.mpr ⟨(Finset.mem_sdiff.mp hpl).1, hs⟩)
    exact hfirst (hb ▸ he)

end Ising2DLambda.NecSuf.KacWard
