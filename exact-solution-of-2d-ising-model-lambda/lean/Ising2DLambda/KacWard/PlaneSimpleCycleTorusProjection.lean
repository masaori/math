/-
平面の単位格子歩をトーラス辺へ射影したときの端点等式と、
端点・反転条件を受け取る単純閉路の条件付き補題。
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
