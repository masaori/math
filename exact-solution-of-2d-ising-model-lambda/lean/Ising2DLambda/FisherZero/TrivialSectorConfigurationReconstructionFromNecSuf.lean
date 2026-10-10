/-
配位復元のスピン値域・全周期和零・横辺差・個数部分を必要十分版から導く。具体版が必要十分版の仮定をどう埋めるかを
独立に確認するための導出である。
-/
import Ising2DLambda.FisherZero.TrivialSectorConfigurationReconstruction
import Ising2DLambda.NecSuf.FisherZero.TrivialSectorConfigurationReconstruction

namespace Ising2DLambda.FisherZero

open Finset Ising2DLambda.PartitionPolynomial Ising2DLambda.TransferMatrix

/-- 周期境界の横辺差へ、実際の道和・代表・有限和・周期和零を供給する。 -/
theorem reconstructionPathParity_horizontal_boundary_difference_from_necSuf
    (L : ℕ) [NeZero L] (A : Finset (Edge L))
    (hSector : IsInTorusHomologySector L A (0, 0))
    (i j : ZMod L) (hj : j.val + 1 = L) :
    reconstructionPathParity L A i (j + 1) + reconstructionPathParity L A i j =
      (if edgeOfRow L false i j ∈ reconstructedEdgeSet L A then 1 else 0) := by
  classical
  let P : ZMod 2 := ∑ r ∈ Finset.range i.val,
    if edgeOfRow L true (r : ZMod L) 0 ∈ reconstructedEdgeSet L A then 1 else 0
  let f : ℕ → ZMod 2 := fun c =>
    if edgeOfRow L false i (c : ZMod L) ∈ reconstructedEdgeSet L A then 1 else 0
  let H : ℕ → ZMod 2 := fun m => ∑ c ∈ Finset.range m, f c
  have htwo : (2 : ZMod 2) = 0 := rfl
  have hbase : P + P = 0 := by linear_combination P * htwo
  have hterm : f j.val + f j.val = 0 := by linear_combination f j.val * htwo
  calc
    reconstructionPathParity L A i (j + 1) + reconstructionPathParity L A i j = f j.val :=
      Ising2DLambda.NecSuf.FisherZero.periodic_path_prefix_difference_necSuf
        (reconstructionPathParity L A i) ZMod.val H f P j (j + 1) L
        rfl rfl (reconstruction_horizontal_boundary_successor_val L j hj) hj
        (Finset.sum_range_zero f) (Finset.sum_range_succ f j.val)
        (reconstructedEdgeSet_horizontal_prefix_sum_zero L A hSector i) hbase hterm
    _ = (if edgeOfRow L false i j ∈ reconstructedEdgeSet L A then 1 else 0) := by
      dsimp [f]
      rw [ZMod.natCast_zmod_val]

/-- 非境界の横辺差へ、実際の道和、座標の代表、辺指示関数、標数二を供給する。 -/
theorem reconstructionPathParity_horizontal_interior_difference_from_necSuf
    (L : ℕ) [NeZero L] (A : Finset (Edge L)) (i j : ZMod L)
    (hjlt : j.val + 1 < L) :
    reconstructionPathParity L A i (j + 1) + reconstructionPathParity L A i j =
      (if edgeOfRow L false i j ∈ reconstructedEdgeSet L A then 1 else 0) := by
  classical
  let P : ZMod 2 := ∑ r ∈ Finset.range i.val,
    if edgeOfRow L true (r : ZMod L) 0 ∈ reconstructedEdgeSet L A then 1 else 0
  let f : ℕ → ZMod 2 := fun c =>
    if edgeOfRow L false i (c : ZMod L) ∈ reconstructedEdgeSet L A then 1 else 0
  have hdouble : (P + ∑ c ∈ range j.val, f c) + (P + ∑ c ∈ range j.val, f c) = 0 := by
    have htwo : (2 : ZMod 2) = 0 := rfl
    linear_combination (P + ∑ c ∈ range j.val, f c) * htwo
  calc
    reconstructionPathParity L A i (j + 1) + reconstructionPathParity L A i j = f j.val :=
      Ising2DLambda.NecSuf.FisherZero.path_prefix_difference_necSuf
        (reconstructionPathParity L A i) ZMod.val f P j (j + 1)
        rfl rfl (reconstruction_horizontal_successor_val L j hjlt) hdouble
    _ = (if edgeOfRow L false i j ∈ reconstructedEdgeSet L A then 1 else 0) := by
      dsimp [f]
      rw [ZMod.natCast_zmod_val]

/-- 道和からスピン値を定める二場合へ、実際の代表と整数冪を供給する。 -/
theorem reconstructionParityPower_eq_one_or_neg_one_from_necSuf (q : ZMod 2) :
    (-1 : ℤ) ^ q.val = 1 ∨ (-1 : ℤ) ^ q.val = -1 := by
  have hcases : q.val = 0 ∨ q.val = 1 := by
    have hlt := q.val_lt
    omega
  exact Ising2DLambda.NecSuf.FisherZero.two_exponent_values_necSuf
    (fun n : ℕ => (-1 : ℤ) ^ n) 1 (-1) q.val
    hcases (pow_zero _) (pow_one _)

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
