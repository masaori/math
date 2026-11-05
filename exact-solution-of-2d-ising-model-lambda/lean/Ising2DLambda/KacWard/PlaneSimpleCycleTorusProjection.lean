/-
平面の単位格子歩をトーラス辺へ射影したときの端点等式と、
頂点単純な有限閉路の実際の射影の非後退性。
住処は ℤ と有限剰余類だけである。
-/
import Ising2DLambda.KacWard.ReversalFreeMovedSupportEven
import Ising2DLambda.KacWard.PlaneProjectionCyclicTurning
import Ising2DLambda.NecSuf.KacWard.PlaneSimpleCycleTorusProjection

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial Ising2DLambda.TransferMatrix
open Ising2DLambda.NecSuf.KacWard

/-- 平面格子点を成分ごとの自然な射影でトーラス頂点へ送る。 -/
def planeVertexProjection (L : ℕ) (w : ℤ × ℤ) : Vertex L :=
  ((w.1 : ZMod L), (w.2 : ZMod L))

/-- A unit step projects to an oriented edge with the projected endpoints. -/
theorem projectedUnitStep_endpoints (L : ℕ) [NeZero L] (p u : ℤ × ℤ)
    (hu : u = (0, 1) ∨ u = (1, 0) ∨ u = (0, -1) ∨ u = (-1, 0)) :
    orientedSource (projectedUnitStep L p u) = planeVertexProjection L p ∧
      orientedTarget (projectedUnitStep L p u) = planeVertexProjection L (p + u) := by
  rcases hu with rfl | rfl | rfl | rfl <;>
    simp [projectedUnitStep, orientedSource, orientedTarget,
      planeVertexProjection, edgeOfRow_boundary0,
      edgeOfRow_boundary1_horizontal, edgeOfRow_boundary1_vertical,
      Prod.ext_iff, Prod.fst_add, Prod.snd_add]

/-- The projected edges of an actual finite unit path inherit its endpoints. -/
theorem planeUnitPathTorusProjection_endpoints (L n : ℕ) [NeZero L]
    (W : Fin (n + 1) → ℤ × ℤ) (j : Fin n)
    (hunit : W ⟨j.val + 1, by omega⟩ - W ⟨j.val, by omega⟩ = (0, 1) ∨
      W ⟨j.val + 1, by omega⟩ - W ⟨j.val, by omega⟩ = (1, 0) ∨
      W ⟨j.val + 1, by omega⟩ - W ⟨j.val, by omega⟩ = (0, -1) ∨
      W ⟨j.val + 1, by omega⟩ - W ⟨j.val, by omega⟩ = (-1, 0)) :
    orientedSource (planeUnitPathTorusProjection L n W j) =
        planeVertexProjection L (W ⟨j.val, by omega⟩) ∧
      orientedTarget (planeUnitPathTorusProjection L n W j) =
        planeVertexProjection L (W ⟨j.val + 1, by omega⟩) := by
  let p : ℤ × ℤ := W ⟨j.val, by omega⟩
  let q : ℤ × ℤ := W ⟨j.val + 1, by omega⟩
  have h := projectedUnitStep_endpoints L p (q - p) hunit
  simpa [planeUnitPathTorusProjection, p, q, add_sub_cancel_left] using h

/-- 四方向の場合分けで、反転した射影辺の歩ベクトルを復元する。 -/
private theorem projectedUnitStep_reverse_vector (L : ℕ) [NeZero L]
    (p q u v : ℤ × ℤ)
    (hu : u = (0, 1) ∨ u = (1, 0) ∨ u = (0, -1) ∨ u = (-1, 0))
    (hv : v = (0, 1) ∨ v = (1, 0) ∨ v = (0, -1) ∨ v = (-1, 0))
    (h : projectedUnitStep L q v = reversal (projectedUnitStep L p u)) : v = -u := by
  have hd := congrArg directionNumber h
  rw [projectedUnitStep_direction, directionNumber_reversal,
    projectedUnitStep_direction] at hd
  rcases hu with rfl | rfl | rfl | rfl <;>
    rcases hv with rfl | rfl | rfl | rfl <;>
    norm_num [unitStepDirection] at hd ⊢ <;> (revert hd; decide)

/-- 頂点単純な閉単位格子路の実際の射影は、巡回接続し反転しない。 -/
theorem planeSimpleCycleProjection_actual_nonbacktracking
    (L n : ℕ) [NeZero L] [NeZero n] (hn : 3 ≤ n) (W : Fin n → ℤ × ℤ)
    (hunit : ∀ i : Fin n,
      W (i + 1) - W i = (0, 1) ∨ W (i + 1) - W i = (1, 0) ∨
      W (i + 1) - W i = (0, -1) ∨ W (i + 1) - W i = (-1, 0))
    (hsimple : Function.Injective W) :
    let edge : Fin n → OrientedEdge L :=
      fun i => projectedUnitStep L (W i) (W (i + 1) - W i)
    (∀ i, orientedSource (edge i) = planeVertexProjection L (W i) ∧
      orientedTarget (edge i) = planeVertexProjection L (W (i + 1))) ∧
    (∀ i, orientedTarget (edge i) = orientedSource (edge (i + 1))) ∧
    (∀ i, edge (i + 1) ≠ reversal (edge i)) := by
  dsimp
  have htwo (i : Fin n) : i + 1 + 1 ≠ i := by
    intro heq
    have h' : (1 : Fin n) + 1 = 0 := by
      apply add_left_cancel (a := i)
      simpa [add_assoc] using heq
    have hv := congrArg Fin.val h'
    have h1 : (1 : Fin n).val = 1 := by
      simp [Nat.mod_eq_of_lt (by omega : 1 < n)]
    simp only [Fin.val_add, h1, Fin.val_zero] at hv
    rw [Nat.mod_eq_of_lt (by omega : 1 + 1 < n)] at hv
    omega
  have hend (i : Fin n) :
      orientedSource (projectedUnitStep L (W i) (W (i + 1) - W i)) =
        planeVertexProjection L (W i) ∧
      orientedTarget (projectedUnitStep L (W i) (W (i + 1) - W i)) =
        planeVertexProjection L (W (i + 1)) := by
    have h := projectedUnitStep_endpoints L (W i) (W (i + 1) - W i) (hunit i)
    simpa [add_sub_cancel_left] using h
  constructor
  · exact hend
  constructor
  · intro i
    exact (hend i).2.trans (hend (i + 1)).1.symm
  · intro i hback
    have hvec := projectedUnitStep_reverse_vector L (W i) (W (i + 1))
      (W (i + 1) - W i) (W (i + 1 + 1) - W (i + 1))
      (hunit i) (hunit (i + 1)) hback
    have hpoint : W (i + 1 + 1) = W i := by
      calc
        W (i + 1 + 1) = (W (i + 1 + 1) - W (i + 1)) + W (i + 1) := by abel
        _ = -(W (i + 1) - W i) + W (i + 1) := by rw [hvec]
        _ = W i := by abel
    exact htwo i (hsimple hpoint)

/-- `Fin (n + 1)` で終点を重ねた本文の閉路を、実際の射影辺へ接続する。 -/
theorem planeUnitPathTorusProjection_closedNonbacktracking
    (L n : ℕ) [NeZero L] [NeZero n] (hn : 3 ≤ n) (W : Fin (n + 1) → ℤ × ℤ)
    (hunit : ∀ j : Fin n,
      W ⟨j.val + 1, by omega⟩ - W ⟨j.val, by omega⟩ = (0, 1) ∨
      W ⟨j.val + 1, by omega⟩ - W ⟨j.val, by omega⟩ = (1, 0) ∨
      W ⟨j.val + 1, by omega⟩ - W ⟨j.val, by omega⟩ = (0, -1) ∨
      W ⟨j.val + 1, by omega⟩ - W ⟨j.val, by omega⟩ = (-1, 0))
    (hclosed : W ⟨n, by omega⟩ = W ⟨0, by omega⟩)
    (hsimple : ∀ i j : Fin n, i ≠ j →
      W ⟨i.val, by omega⟩ ≠ W ⟨j.val, by omega⟩) :
    let edge := planeUnitPathTorusProjection L n W
    (∀ j : Fin n,
      orientedSource (edge j) = planeVertexProjection L (W ⟨j.val, by omega⟩) ∧
      orientedTarget (edge j) = planeVertexProjection L
        (W ⟨j.val + 1, by omega⟩)) ∧
    (∀ j : Fin n, orientedTarget (edge j) = orientedSource (edge (j + 1))) ∧
    (∀ j : Fin n, edge (j + 1) ≠ reversal (edge j)) := by
  letI : NeZero n := ⟨by omega⟩
  let C : Fin n → ℤ × ℤ := fun j => W ⟨j.val, by omega⟩
  have hsimpleC : Function.Injective C := by
    intro i j hij
    by_contra hne
    exact hsimple i j hne hij
  have hnext (j : Fin n) : C (j + 1) = W ⟨j.val + 1, by omega⟩ := by
    by_cases hj : j.val + 1 < n
    · have hv : (j + 1).val = j.val + 1 := by
        simp [Fin.val_add, Nat.mod_eq_of_lt hj]
      simp [C, hv]
    · have hjlast : j.val + 1 = n := by omega
      have hv : (j + 1).val = 0 := by
        simp [Fin.val_add, hjlast]
      simpa [C, hv, hjlast] using hclosed.symm
  have hunitC (j : Fin n) :
      C (j + 1) - C j = (0, 1) ∨ C (j + 1) - C j = (1, 0) ∨
      C (j + 1) - C j = (0, -1) ∨ C (j + 1) - C j = (-1, 0) := by
    simpa only [C, hnext] using hunit j
  have hcyc := planeSimpleCycleProjection_actual_nonbacktracking L n hn C hunitC hsimpleC
  dsimp at hcyc ⊢
  have hedge (j : Fin n) :
      planeUnitPathTorusProjection L n W j =
        projectedUnitStep L (C j) (C (j + 1) - C j) := by
    simp [planeUnitPathTorusProjection, C, hnext]
  constructor
  · intro j
    rw [hedge]
    simpa only [C, hnext] using hcyc.1 j
  constructor
  · intro j
    simpa only [hedge] using hcyc.2.1 j
  · intro j
    simpa only [hedge] using hcyc.2.2 j

/-- `claim_plane_simple_cycle_projection_closed_nonbacktracking` の具体版。 -/
theorem planeSimpleCycleProjection_closedNonbacktracking
    (L : ℕ) [NeZero L] {I : Type*}
    (next : I → I) (W : I → ℤ × ℤ) (projectedEdge : I → OrientedEdge L)
    (hsource : ∀ i, orientedSource (projectedEdge i) = planeVertexProjection L (W i))
    (htarget : ∀ i, orientedTarget (projectedEdge i) = planeVertexProjection L (W (next i)))
    (hvertex : Function.Injective W)
    (hreverse : ∀ i, projectedEdge (next i) = reversal (projectedEdge i) →
      W (next (next i)) = W i)
    (hnextTwo : ∀ i, next (next i) ≠ i) :
    (∀ i, orientedTarget (projectedEdge i) = orientedSource (projectedEdge (next i))) ∧
      (∀ i, projectedEdge (next i) ≠ reversal (projectedEdge i)) := by
  apply simple_cycle_projection_closed_nonbacktracking_necSuf
    next W (planeVertexProjection L) projectedEdge
    orientedSource orientedTarget reversal hsource htarget
  · exact hvertex
  · exact hreverse
  · exact hnextTwo

end Ising2DLambda.KacWard
