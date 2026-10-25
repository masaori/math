import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

open Finset

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

end Ising2DLambda.NecSuf.KacWard
