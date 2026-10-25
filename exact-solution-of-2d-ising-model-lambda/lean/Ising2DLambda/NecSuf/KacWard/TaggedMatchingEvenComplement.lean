import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

open Finset

/-- Outside the selected endpoints, the mate is the prescribed involution.
    Only pair coverage, pair disjointness encoded by the mate, and the label
    support are used. -/
theorem mate_outside_selected_eq_reverse {J P : Type*} [DecidableEq P]
    (allPairs selectedPairs : Finset P) (first second : P → J)
    (mate reverse : J → J) (selected : J → Prop)
    (hcover : ∀ x, ∃ p ∈ allPairs, x = first p ∨ x = second p)
    (hfirst : ∀ p ∈ allPairs, mate (first p) = second p)
    (hmate : Function.Involutive mate)
    (hreverse : Function.Involutive reverse)
    (hshort : ∀ p ∈ selectedPairs, selected (first p) ∧ selected (second p))
    (hlong : ∀ p ∈ allPairs \ selectedPairs, second p = reverse (first p))
    (x : J) (hx : ¬ selected x) : mate x = reverse x := by
  classical
  obtain ⟨p, hp, hxp⟩ := hcover x
  have hnot : p ∉ selectedPairs := by
    intro hpt
    rcases hxp with rfl | rfl
    · exact hx (hshort p hpt).1
    · exact hx (hshort p hpt).2
  have hpl : p ∈ allPairs \ selectedPairs := Finset.mem_sdiff.mpr ⟨hp, hnot⟩
  have hpair := hfirst p hp
  have hrev := hlong p hpl
  rcases hxp with rfl | rfl
  · exact hpair.trans hrev
  · have hback : mate (second p) = first p := by
      rw [← hpair]
      exact hmate (first p)
    rw [hback, hrev, hreverse]

/-- A finite partition into pairs has even total weight when every pair has even weight. -/
theorem even_of_pair_contributions {J : Type*} [Fintype J]
    {P : Type*} (pairs : Finset P) (first second : P → J) (weight : J → ℕ)
    (hpartition : (∑ j : J, weight j) =
      ∑ p ∈ pairs, (weight (first p) + weight (second p)))
    (hpair : ∀ p ∈ pairs, Even (weight (first p) + weight (second p))) :
    Even (∑ j : J, weight j) := by
  rw [hpartition]
  exact Finset.even_sum _ hpair

/-- Count selected pairs by counting their two endpoints and the two orientations of selected edges. -/
theorem short_pair_count_of_double_count {J P E : Type*} [Fintype J] [DecidableEq P]
    (allPairs selectedPairs : Finset P) (selectedEdges : Finset E)
    (first second : P → J) (weight : J → ℕ)
    (hsubset : selectedPairs ⊆ allPairs)
    (hpartition : (∑ j : J, weight j) =
      ∑ p ∈ allPairs, (weight (first p) + weight (second p)))
    (hpair : ∀ p ∈ allPairs,
      weight (first p) + weight (second p) = if p ∈ selectedPairs then 2 else 0)
    (hedges : (∑ j : J, weight j) = 2 * selectedEdges.card) :
    selectedPairs.card = selectedEdges.card := by
  classical
  have hpairs : (∑ p ∈ allPairs, (weight (first p) + weight (second p))) =
      2 * selectedPairs.card := by
    calc
      _ = ∑ p ∈ allPairs, if p ∈ selectedPairs then 2 else 0 :=
        Finset.sum_congr rfl hpair
      _ = 2 * selectedPairs.card := by
        simp [Finset.inter_eq_right.mpr hsubset, mul_comm]
  rw [hpartition, hpairs] at hedges
  omega

/-- A disjoint pair partition restricts to a unique local pair at each source.
Coverage supplies existence, common sources give locality, and disjointness gives uniqueness. -/
theorem local_pair_unique_of_partition {J P V : Type*}
    (selectedPairs : Finset P) (first second : P → J) (source : J → V)
    (active : J → Prop)
    (hcover : ∀ j, active j ↔ ∃ p ∈ selectedPairs, j = first p ∨ j = second p)
    (hsame : ∀ p ∈ selectedPairs, source (first p) = source (second p))
    (hdisjoint : ∀ p ∈ selectedPairs, ∀ q ∈ selectedPairs,
      ∀ j, (j = first p ∨ j = second p) →
        (j = first q ∨ j = second q) → p = q)
    (v : V) (j : J) :
    (active j ∧ source j = v) ↔
      ∃! p : P, p ∈ selectedPairs ∧ source (first p) = v ∧
        (j = first p ∨ j = second p) := by
  classical
  constructor
  · rintro ⟨hj, hjv⟩
    obtain ⟨p, hp, hmember⟩ := (hcover j).mp hj
    have hsource : source (first p) = v := by
      rcases hmember with rfl | rfl
      · exact hjv
      · exact (hsame p hp).trans hjv
    refine ⟨p, ⟨hp, hsource, hmember⟩, ?_⟩
    intro q hq
    exact (hdisjoint p hp q hq.1 j hmember hq.2.2).symm
  · rintro ⟨p, ⟨hp, hpv, hmember⟩, _⟩
    refine ⟨(hcover j).mpr ⟨p, hp, hmember⟩, ?_⟩
    rcases hmember with rfl | rfl
    · exact hpv
    · exact (hsame p hp).symm.trans hpv

end Ising2DLambda.NecSuf.KacWard
