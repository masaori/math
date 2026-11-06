import Ising2DLambda.KacWard.CellBoundaryTwoEdgePropagation
import Ising2DLambda.KacWard.VertexSimpleBoundaryOtherEdgesZero

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

/-- Consecutive nonbacktracking edges on the same base edge can only be a loop. -/
theorem same_base_successor_is_loop {L : ℕ} (e f : OrientedEdge L)
    (hf : f ∈ nonbacktrackingSuccessors e) (hbase : e.1 = f.1) :
    orientedSource e = orientedTarget e := by
  have hnext : orientedTarget e = orientedSource f :=
    (Finset.mem_filter.mp hf).2.1
  have hne : f ≠ reversal e := (Finset.mem_filter.mp hf).2.2
  have heq : f = e := by
    rcases e with ⟨b, false | true⟩ <;>
      rcases f with ⟨c, false | true⟩ <;>
      simp_all [reversal]
  simpa [heq] using hnext.symm

/-- A nonloop incoming edge and its nonbacktracking successor have different base edges. -/
theorem nonloop_successor_distinct_base {L : ℕ} (e f : OrientedEdge L)
    (hf : f ∈ nonbacktrackingSuccessors e)
    (hnotloop : orientedSource e ≠ orientedTarget e) : e.1 ≠ f.1 := by
  intro hbase
  exact hnotloop (same_base_successor_is_loop e f hf hbase)

/-- For side length at least two, the two endpoints of every lattice edge differ. -/
theorem oriented_edge_nonloop_of_two_le {L : ℕ} (hL : 2 ≤ L)
    (e : OrientedEdge L) : orientedSource e ≠ orientedTarget e := by
  letI : Fact (1 < L) := ⟨hL⟩
  haveI : Nontrivial (ZMod L) := inferInstance
  have hneq (x : ZMod L) : x ≠ x + 1 := by
    intro h
    have hsum : x + (0 : ZMod L) = x + 1 := by simpa using h
    exact zero_ne_one (add_left_cancel hsum)
  have hbase (edge : Edge L) : boundary0 L edge ≠ boundary1 L edge := by
    intro h
    by_cases haxis : edge.val < L ^ 2
    · have hc : (edgeColumn L edge : ZMod L) = (edgeColumn L edge : ZMod L) + 1 := by
        simpa [boundary0, boundary1, haxis] using congrArg Prod.snd h
      exact hneq _ hc
    · have hc : (edgeRow L edge : ZMod L) = (edgeRow L edge : ZMod L) + 1 := by
        simpa [boundary0, boundary1, haxis] using congrArg Prod.fst h
      exact hneq _ hc
  rcases e with ⟨edge, false | true⟩
  · simpa [orientedSource, orientedTarget] using hbase edge
  · simpa [orientedSource, orientedTarget] using (hbase edge).symm

/-- The nonloop implication at an actual passage of a closed walk. -/
theorem closedWalk_nonloop_pass_distinct_base {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L) (hγ : closedNonbacktrackingWalk γ)
    (k : Fin (m + 1))
    (hnotloop : orientedSource (γ k) ≠ orientedTarget (γ k)) :
    (γ k).1 ≠ (γ (closedWalkSuccessor k)).1 := by
  exact nonloop_successor_distinct_base (γ k) (γ (closedWalkSuccessor k))
    (closedWalkPass_valid γ hγ k) hnotloop

/-- Every passage of a closed nonbacktracking walk has distinct base edges at L ≥ 2. -/
theorem closedWalk_nonloop_successor_distinct_base {L m : ℕ} (hL : 2 ≤ L)
    (γ : Fin (m + 1) → OrientedEdge L) (hγ : closedNonbacktrackingWalk γ)
    (k : Fin (m + 1)) : (γ k).1 ≠ (γ (closedWalkSuccessor k)).1 := by
  exact closedWalk_nonloop_pass_distinct_base γ hγ k
    (oriented_edge_nonloop_of_two_le hL (γ k))

/-- The vanishing contribution outside the two passage edges supplies the support
hypothesis of the two-edge balance argument at an actual simple walk. -/
theorem vertexSimple_boundary_distinct_pass_propagation (L m : ℕ) [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hcontact : contactPairCount γ hγ = 0)
    (hh : (∑ k : Fin (m + 1), horizontalSeamParity (γ k)) % 2 = 0)
    (hv : (∑ k : Fin (m + 1), verticalSeamParity (γ k)) % 2 = 0)
    (k : Fin (m + 1))
    (hdistinct : (γ k).1 ≠ (γ (closedWalkSuccessor k)).1)
    (hnotin : orientedSource (γ k) ≠ orientedTarget (γ k))
    (hnotout : orientedTarget (γ (closedWalkSuccessor k)) ≠
      orientedSource (γ (closedWalkSuccessor k))) :
    cellSetEdgeCoefficient L (heightOneCells L m γ) (γ k).1 *
        (1 - 2 * ((γ k).2.toNat : ℤ)) =
      cellSetEdgeCoefficient L (heightOneCells L m γ)
          (γ (closedWalkSuccessor k)).1 *
        (1 - 2 * ((γ (closedWalkSuccessor k)).2.toNat : ℤ)) := by
  let v := orientedTarget (γ k)
  have hnext : orientedSource (γ (closedWalkSuccessor k)) = v :=
    (Finset.mem_filter.mp (closedWalkPass_valid γ hγ k)).2.1.symm
  have hnotoutv : orientedTarget (γ (closedWalkSuccessor k)) ≠ v := by
    simpa only [hnext] using hnotout
  apply cellSetBoundary_two_edge_propagation L (heightOneCells L m γ) v
    (γ k) (γ (closedWalkSuccessor k)) hdistinct rfl hnotin hnext hnotoutv
  intro edge hfirst hsecond
  exact vertexSimple_boundary_other_edges_zero L m γ hγ hcontact hh hv
    k edge hfirst hsecond

end Ising2DLambda.KacWard
