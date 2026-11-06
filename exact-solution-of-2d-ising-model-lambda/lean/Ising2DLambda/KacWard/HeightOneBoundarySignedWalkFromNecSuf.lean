import Ising2DLambda.KacWard.HeightOneBoundarySignedWalk
import Ising2DLambda.KacWard.VertexSimpleBoundaryNonloopPropagationFromNecSuf
import Ising2DLambda.NecSuf.KacWard.SignedBoundaryOfInjectiveSupport

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

/-- The abstract support-and-propagation argument specializes to the actual
height-one boundary and the actual walk coefficient. -/
theorem heightOneBoundary_signed_walk_from_necSuf (L m : ℕ) [NeZero L]
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
  have hsupport (edge : Edge L) : coeff edge ≠ 0 ↔
      ∃ k : Fin (m + 1), (γ k).1 = edge := by
    rw [heightOneBoundary_all_edges L m γ hγ hh hv edge]
    constructor
    · intro hp
      by_contra hn
      push_neg at hn
      have hs : (∑ k : Fin (m + 1), if (γ k).1 = edge then 1 else 0) = 0 := by
        simp [hn]
      simp [walkBaseEdgeParity, hs] at hp
    · rintro ⟨k, hk⟩
      rw [← hk]
      unfold walkBaseEdgeParity
      have hs : (∑ j : Fin (m + 1), if (γ j).1 = (γ k).1 then 1 else 0) = 1 := by
        rw [Finset.sum_eq_single k]
        · simp
        · intro j _ hj
          simp [hbase.ne hj]
        · simp
      simp [hs]
  have hsign (k : Fin (m + 1)) : sign k ∈ ({-1, 1} : Finset ℤ) := by
    cases hd : (γ k).2 <;> simp [sign, hd]
  have hconstant (k : Fin (m + 1)) :
      coeff (γ k).1 * sign k = coeff (γ 0).1 * sign 0 :=
    vertexSimple_boundary_nonloop_propagation_from_necSuf hL γ hγ hcontact hh hv k
  obtain ⟨ε, hε, hcoeff⟩ :=
    Ising2DLambda.NecSuf.KacWard.signed_boundary_of_injective_support
      (fun k : Fin (m + 1) => (γ k).1) sign coeff 0 hbase
      (heightOneBoundary_coefficient_values L m γ) hsupport hsign hconstant
  refine ⟨ε, hε, ?_⟩
  intro edge
  simpa [coeff, sign, walkEdgeCoefficient, orientedEdgeCoefficient] using hcoeff edge

end Ising2DLambda.KacWard
