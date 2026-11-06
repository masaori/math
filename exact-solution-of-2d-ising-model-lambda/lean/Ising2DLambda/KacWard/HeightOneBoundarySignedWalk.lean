import Ising2DLambda.KacWard.VertexSimpleBaseInjective
import Ising2DLambda.KacWard.SingleCellVertexSimpleSeam
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial Ising2DLambda.TransferMatrix

theorem heightOneBoundary_coefficient_values (L m : ℕ) [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L) (edge : Edge L) :
    cellSetEdgeCoefficient L (heightOneCells L m γ) edge ∈
      ({-1, 0, 1} : Finset ℤ) := by
  obtain ⟨w, rfl⟩ := (edgeEquiv L).surjective edge
  cases w with
  | inl p => exact heightOneBoundary_horizontal_values L m γ p.1 p.2
  | inr p => exact heightOneBoundary_vertical_values L m γ p.1 p.2

/-- The height-one cell boundary is one of the two orientations of the actual
vertex-simple closed walk, as an equality of every signed edge coefficient. -/
theorem heightOneBoundary_signed_walk (L m : ℕ) [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hcontact : contactPairCount γ hγ = 0)
    (hh : (∑ k : Fin (m + 1), horizontalSeamParity (γ k)) % 2 = 0)
    (hv : (∑ k : Fin (m + 1), verticalSeamParity (γ k)) % 2 = 0) :
    ∃ ε : ℤ, ε ∈ ({-1, 1} : Finset ℤ) ∧
      ∀ edge : Edge L,
        cellSetEdgeCoefficient L (heightOneCells L m γ) edge =
          ε * walkEdgeCoefficient γ edge := by
  by_cases hsingle : L = 1
  · subst L
    exact False.elim (single_cell_vertex_simple_zero_seam_impossible γ hγ hcontact hh hv)
  have hL : 2 ≤ L := by
    have hpos := Nat.pos_of_ne_zero (NeZero.ne L)
    omega
  have hbase := vertexSimple_base_injective hL γ hγ hcontact
  let coeff : Edge L → ℤ := cellSetEdgeCoefficient L (heightOneCells L m γ)
  let sign : Fin (m + 1) → ℤ := fun k => 1 - 2 * ((γ k).2.toNat : ℤ)
  have hsign (k : Fin (m + 1)) : sign k ∈ ({-1, 1} : Finset ℤ) := by
    cases hd : (γ k).2 <;> simp [sign, hd]
  have hsignsq (k : Fin (m + 1)) : sign k * sign k = 1 := by
    cases hd : (γ k).2 <;> simp [sign, hd]
  have hparity (k : Fin (m + 1)) : walkBaseEdgeParity γ (γ k).1 = 1 := by
    unfold walkBaseEdgeParity
    have hs : (∑ j : Fin (m + 1), if (γ j).1 = (γ k).1 then 1 else 0) = 1 := by
      rw [Finset.sum_eq_single k]
      · simp
      · intro j _ hj
        have hne : (γ j).1 ≠ (γ k).1 := hbase.ne hj
        simp [hne]
      · simp
    simp [hs]
  have hnonzero : coeff (γ 0).1 ≠ 0 :=
    (heightOneBoundary_all_edges L m γ hγ hh hv (γ 0).1).mpr (hparity 0)
  have hvalue : coeff (γ 0).1 ∈ ({-1, 1} : Finset ℤ) := by
    have hv := heightOneBoundary_coefficient_values L m γ (γ 0).1
    simp only [Finset.mem_insert, Finset.mem_singleton] at hv ⊢
    rcases hv with hneg | hzero | hone
    · exact Or.inl hneg
    · exact False.elim (hnonzero hzero)
    · exact Or.inr hone
  let ε : ℤ := coeff (γ 0).1 * sign 0
  refine ⟨ε, ?_, ?_⟩
  · have hs := hsign 0
    simp only [Finset.mem_insert, Finset.mem_singleton] at hs hvalue ⊢
    rcases hvalue with hc | hc <;> rcases hs with hd | hd <;> simp [ε, hc, hd]
  intro edge
  by_cases hpass : ∃ k : Fin (m + 1), (γ k).1 = edge
  · obtain ⟨k, hk⟩ := hpass
    have hwalk : walkEdgeCoefficient γ edge = sign k := by
      unfold walkEdgeCoefficient
      rw [Finset.sum_eq_single k]
      · simp [orientedEdgeCoefficient, ← hk, sign]
      · intro j _ hj
        have hne : (γ j).1 ≠ edge := by
          rw [← hk]
          exact hbase.ne hj
        simp [orientedEdgeCoefficient, hne]
      · simp
    have hprop := vertexSimple_boundary_nonloop_propagation hL γ hγ hcontact hh hv k
    change coeff (γ k).1 * sign k = ε at hprop
    have hcoeff : coeff edge = ε * sign k := by
      rw [← hk]
      calc
        coeff (γ k).1 = (coeff (γ k).1 * sign k) * sign k := by
          rw [mul_assoc, hsignsq k, mul_one]
        _ = ε * sign k := by rw [hprop]
    simpa [coeff, hwalk] using hcoeff
  · have hpar : walkBaseEdgeParity γ edge = 0 := by
      unfold walkBaseEdgeParity
      simp [not_exists.mp hpass]
    have hzero : coeff edge = 0 := by
      by_contra hc
      have hp := (heightOneBoundary_all_edges L m γ hγ hh hv edge).mp hc
      omega
    have hwalk : walkEdgeCoefficient γ edge = 0 := by
      unfold walkEdgeCoefficient
      simp [orientedEdgeCoefficient, not_exists.mp hpass]
    simp [coeff, hzero, hwalk]

end Ising2DLambda.KacWard
