/-
配位復元の全周期和零と個数部分を必要十分版から導く。具体版が必要十分版の仮定をどう埋めるかを
独立に確認するための導出である。
-/
import Ising2DLambda.FisherZero.TrivialSectorConfigurationReconstruction
import Ising2DLambda.NecSuf.FisherZero.TrivialSectorConfigurationReconstruction

namespace Ising2DLambda.FisherZero

open Finset Ising2DLambda.PartitionPolynomial Ising2DLambda.TransferMatrix

theorem reconstructedEdgeSet_all_row_column_sums_zero_from_necSuf
    (L : ℕ) [NeZero L] (A : Finset (Edge L))
    (hSector : IsInTorusHomologySector L A (0, 0)) :
    (∀ i : ZMod L,
      (∑ j : ZMod L,
        (if edgeOfRow L false i j ∈ reconstructedEdgeSet L A then 1 else 0) : ZMod 2) = 0) ∧
    (∀ j : ZMod L,
      (∑ i : ZMod L,
        (if edgeOfRow L true i j ∈ reconstructedEdgeSet L A then 1 else 0) : ZMod 2) = 0) := by
  classical
  obtain ⟨hwv, hwh⟩ := reconstructedEdgeSet_winding_equations L A hSector
  obtain ⟨hrow, hcol⟩ := reconstructedEdgeSet_row_column_sum_invariant L A hSector.1
  let walk : ℕ → ZMod L := fun n => -1 + (n : ZMod L)
  let step : ZMod L → ZMod L := fun x => x + 1
  let index : ZMod L → ℕ := fun x => (x + 1).val
  have hstart : walk 0 = (-1 : ZMod L) := by
    calc
      walk 0 = -1 + (0 : ZMod L) := congrArg (-1 + ·) (Nat.cast_zero)
      _ = -1 := add_zero _
  have hstep : ∀ n : ℕ, walk (n + 1) = step (walk n) := by
    intro n
    calc
      walk (n + 1) = -1 + ((n : ZMod L) + ((1 : ℕ) : ZMod L)) :=
        congrArg (-1 + ·) (Nat.cast_add n 1)
      _ = -1 + ((n : ZMod L) + 1) := by rw [Nat.cast_one]
      _ = step (walk n) := (add_assoc (-1 : ZMod L) (n : ZMod L) 1).symm
  have hcover : ∀ x : ZMod L, walk (index x) = x := by
    intro x
    calc
      walk (index x) = -1 + (x + 1) :=
        congrArg (-1 + ·) (ZMod.natCast_rightInverse (x + 1))
      _ = -1 + (1 + x) := congrArg (-1 + ·) (add_comm x 1)
      _ = (-1 + 1) + x := (add_assoc (-1 : ZMod L) 1 x).symm
      _ = 0 + x := congrArg (· + x) (neg_add_cancel (1 : ZMod L))
      _ = x := zero_add x
  constructor
  · exact Ising2DLambda.NecSuf.FisherZero.constant_on_walk_necSuf
      (X := ZMod L) (Y := ZMod 2)
      walk step (-1) index hstart hstep hcover
      (fun i : ZMod L => ∑ j : ZMod L,
        if edgeOfRow L false i j ∈ reconstructedEdgeSet L A then (1 : ZMod 2) else 0)
      0 hwh (fun x => hrow x)
  · exact Ising2DLambda.NecSuf.FisherZero.constant_on_walk_necSuf
      (X := ZMod L) (Y := ZMod 2)
      walk step (-1) index hstart hstep hcover
      (fun j : ZMod L => ∑ i : ZMod L,
        if edgeOfRow L true i j ∈ reconstructedEdgeSet L A then (1 : ZMod 2) else 0)
      0 hwv (fun x => hcol x)

theorem trivialSectorConfiguration_fiber_card_two_from_necSuf
    (L : ℕ) [NeZero L] (A : Finset (Edge L))
    (hexists : ∃ σ : Config L, dualBrokenEdgeSet L σ = A) :
    (univ.filter fun σ : Config L => dualBrokenEdgeSet L σ = A).card = 2 := by
  obtain ⟨σ, hσ⟩ := hexists
  have h := Ising2DLambda.NecSuf.FisherZero.paired_fiber_card_two_necSuf
    (dualBrokenEdgeSet L) (globalSpinReversal L) σ
    (globalSpinReversal_ne_self L σ)
    (globalSpinReversal_dualBrokenEdgeSet L σ)
    (sameDualBrokenEdges_eq_or_globalSpinReversal L σ)
  simpa [hσ] using h

end Ising2DLambda.FisherZero
