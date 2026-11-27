/-
「射影の平面持ち上げは元の平面閉路の平行移動で巻き付きは零である」
（`claim_projected_plane_cycle_lift_translation`）の、実際の射影辺列についての具体版。

人手証明と同じく、各歩の変位を射影の定義と平面変位の定義の四つの場合で読み、
帰納法で持ち上げの等式を足し上げ、閉路の終点一致と巻き付き終点公式
（`claim_plane_lift_endpoint_winding` の具体版 `planeLift_endpoint_winding`）から
二つの整数巻き付き数を零へ戻す。住処は ℤ × ℤ だけである。
-/
import Ising2DLambda.KacWard.OneSidedClosureProjectedLiftFromWalk
import Ising2DLambda.KacWard.PlaneLiftEndpointWinding

namespace Ising2DLambda.KacWard

open Ising2DLambda.TransferMatrix

/-- 射影辺の平面変位は、射影した単位格子歩そのものである（人手証明の四つの場合）。 -/
theorem projectedUnitStep_latticeStep_of_unit (L : ℕ) [NeZero L] (p u : ℤ × ℤ)
    (hu : u = (0, 1) ∨ u = (1, 0) ∨ u = (0, -1) ∨ u = (-1, 0)) :
    orientedEdgeLatticeStep (projectedUnitStep L p u) = u := by
  have horizontal (i j : ZMod L) : (edgeOfRow L false i j).val < L ^ 2 := by
    simpa [edgeOfRow] using rowColumnIndex_lt L i j
  have vertical (i j : ZMod L) : ¬(edgeOfRow L true i j).val < L ^ 2 := by
    simp [edgeOfRow]
  rcases hu with rfl | rfl | rfl | rfl <;>
    simp [projectedUnitStep, orientedEdgeLatticeStep, horizontal, vertical]

/-- `claim_projected_plane_cycle_lift_translation` の、実際の射影辺列についての具体版。 -/
theorem projectedPlaneCycleLift_translation_and_winding_zero_ofWalk
    (L m : ℕ) [NeZero L] (W : ℕ → ℤ × ℤ)
    (hclosed : W (m + 1) = W 0)
    (hunit : ∀ j < m + 1, W (j + 1) - W j = (0, 1) ∨
      W (j + 1) - W j = (1, 0) ∨ W (j + 1) - W j = (0, -1) ∨
      W (j + 1) - W j = (-1, 0))
    (hwalk : closedNonbacktrackingWalk
      (fun j : Fin (m + 1) =>
        projectedUnitStep L (W j.val) (W (j.val + 1) - W j.val))) :
    let Γ : Fin (m + 1) → OrientedEdge L := fun j =>
      projectedUnitStep L (W j.val) (W (j.val + 1) - W j.val)
    (∀ k : Fin (m + 2), planeLift Γ k = planeLift Γ 0 + W k.val - W 0) ∧
      planeLift Γ (Fin.last (m + 1)) = planeLift Γ 0 ∧
      verticalDirectedWindingNumber Γ = 0 ∧
      horizontalDirectedWindingNumber Γ = 0 := by
  dsimp only
  let Γ : Fin (m + 1) → OrientedEdge L := fun j =>
    projectedUnitStep L (W j.val) (W (j.val + 1) - W j.val)
  -- 各歩の変位（射影の定義と平面変位の定義の四つの場合）
  have hdisplacement (j : Fin (m + 1)) :
      orientedEdgeLatticeStep (Γ j) = W (j.val + 1) - W j.val :=
    projectedUnitStep_latticeStep_of_unit L (W j.val) (W (j.val + 1) - W j.val)
      (hunit j.val j.isLt)
  -- 持ち上げの等式（k についての帰納法）
  have htranslation : ∀ k : Fin (m + 2), planeLift Γ k = planeLift Γ 0 + W k.val - W 0 := by
    intro k
    induction k using Fin.induction with
    | zero => simp
    | succ i ih =>
        rw [planeLift_succ Γ i, hdisplacement i, ih]
        simp only [Fin.val_castSucc, Fin.val_succ]
        abel
  -- 終点の一致
  have hliftClosed : planeLift Γ (Fin.last (m + 1)) = planeLift Γ 0 := by
    rw [htranslation (Fin.last (m + 1)), Fin.val_last, hclosed]
    abel
  -- 巻き付き終点公式から二つの巻き付き数を零へ戻す
  have hendpoint := planeLift_endpoint_winding Γ hwalk
  rw [hliftClosed] at hendpoint
  have hpair : ((L : ℤ) * verticalDirectedWindingNumber Γ,
      (L : ℤ) * horizontalDirectedWindingNumber Γ) = 0 := by
    have h := congrArg (fun p => p - planeLift Γ 0) hendpoint
    simpa using h.symm
  have hL : (L : ℤ) ≠ 0 := by exact_mod_cast (NeZero.ne L)
  have hv : verticalDirectedWindingNumber Γ = 0 :=
    (mul_eq_zero.mp (congrArg Prod.fst hpair)).resolve_left hL
  have hh : horizontalDirectedWindingNumber Γ = 0 :=
    (mul_eq_zero.mp (congrArg Prod.snd hpair)).resolve_left hL
  exact ⟨htranslation, hliftClosed, hv, hh⟩

end Ising2DLambda.KacWard
