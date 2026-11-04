/-
「頂点単純な閉単位格子路のトーラス射影は閉じた非後退辺列である」の必要十分版。

本質は、射影辺の始点・終点が連続する頂点と一致すること、反転が現れれば
二歩先の頂点が元の頂点へ戻ること、そして二歩先が同じ添字ではないことだけである。
頂点・辺の型には構造も有限性も要らない。
-/
import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- 有限路の隣接二点を辺へ送るために必要なデータだけを残した射影。 -/
def finitePathEdgeProjection {P E : Type*} (n : ℕ)
    (step : P → P → E) (W : Fin (n + 1) → P) (j : Fin n) : E :=
  step (W ⟨j.val, by omega⟩) (W ⟨j.val + 1, by omega⟩)

/-- Endpoint compatibility of a step map is inherited by its finite path projection. -/
theorem finitePathEdgeProjection_endpoints {P V E : Type*} (n : ℕ)
    (step : P → P → E) (W : Fin (n + 1) → P)
    (projectVertex : P → V) (source target : E → V)
    (hsource : ∀ j : Fin n,
      source (step (W ⟨j.val, by omega⟩) (W ⟨j.val + 1, by omega⟩)) =
        projectVertex (W ⟨j.val, by omega⟩))
    (htarget : ∀ j : Fin n,
      target (step (W ⟨j.val, by omega⟩) (W ⟨j.val + 1, by omega⟩)) =
        projectVertex (W ⟨j.val + 1, by omega⟩))
    (j : Fin n) :
    source (finitePathEdgeProjection n step W j) =
        projectVertex (W ⟨j.val, by omega⟩) ∧
      target (finitePathEdgeProjection n step W j) =
        projectVertex (W ⟨j.val + 1, by omega⟩) := by
  exact ⟨hsource j, htarget j⟩

/-- 端点整合性と一歩の反転の復元性から、単純な巡回頂点列の射影は閉じた非後退辺列になる。 -/
theorem simple_cycle_projection_closed_nonbacktracking_necSuf
    {I P V E : Type*}
    (next : I → I) (point : I → P) (projectVertex : P → V) (edge : I → E)
    (source target : E → V) (reverse : E → E)
    (hsource : ∀ i, source (edge i) = projectVertex (point i))
    (htarget : ∀ i, target (edge i) = projectVertex (point (next i)))
    (hpoint : Function.Injective point)
    (hreverse : ∀ i, edge (next i) = reverse (edge i) →
      point (next (next i)) = point i)
    (hnextTwo : ∀ i, next (next i) ≠ i) :
    (∀ i, target (edge i) = source (edge (next i))) ∧
      (∀ i, edge (next i) ≠ reverse (edge i)) := by
  constructor
  · intro i
    calc
      target (edge i) = projectVertex (point (next i)) := htarget i
      _ = source (edge (next i)) := (hsource (next i)).symm
  · intro i hback
    have hpointEq : point (next (next i)) = point i := hreverse i hback
    have hindexEq : next (next i) = i := hpoint hpointEq
    exact hnextTwo i hindexEq

end Ising2DLambda.NecSuf.KacWard
