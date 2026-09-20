/-
章「Onsager 閉形式への接続」の「頂点単純な閉単位格子路のトーラス射影は
閉じた非後退辺列である」（`claim_plane_simple_cycle_projection_closed_nonbacktracking`）の具体版。

人手証明の構成どおり、平面格子点列、実際のトーラス頂点・向き付き辺・反転写像について、
四方向の場合分けが与える端点等式、反転から二歩戻ること、頂点単純性を合成する。
住処は ℤ と有限剰余類だけであり、ℝ / ℂ は現れない。
-/
import Ising2DLambda.KacWard.ReversalFreeMovedSupportEven
import Ising2DLambda.NecSuf.KacWard.PlaneSimpleCycleTorusProjection

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial
open Ising2DLambda.NecSuf.KacWard

/-- 平面格子点を成分ごとの自然な射影でトーラス頂点へ送る。 -/
def planeVertexProjection (L : ℕ) (w : ℤ × ℤ) : Vertex L :=
  ((w.1 : ZMod L), (w.2 : ZMod L))

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
