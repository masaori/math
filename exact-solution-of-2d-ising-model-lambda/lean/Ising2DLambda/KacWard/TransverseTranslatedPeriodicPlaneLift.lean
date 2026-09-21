/-
章「Onsager 閉形式への接続」の
「横断幅を超えて離した周期持ち上げは交わらない」
（`claim_transverse_translates_of_periodic_plane_lift_disjoint`）の具体版。

人手証明と同じく、横断移動後の座標を整数の分配則で計算し、周期持ち上げの
横断座標の上下界と幅の不等式をつないで二つの像を分離する。住処は ℤ だけである。
-/
import Ising2DLambda.KacWard.PeriodicPlaneLiftTransverseBounded
import Ising2DLambda.NecSuf.KacWard.TransverseTranslatedFamily
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

/-- `def_transverse_translate_of_periodic_plane_lift`。 -/
def transverseTranslatedPeriodicPlaneLift
    (m L : ℕ) (base : ℤ → ℤ × ℤ) (wv wh u k : ℤ) : ℤ × ℤ :=
  periodicPlaneLift m base L wv wh k + u • (wh, -wv)

/-- 横断平行移動は横断座標を `u(wh²+wv²)` だけ変える。 -/
theorem transverseTranslatedPeriodicPlaneLift_coordinate
    (m L : ℕ) (base : ℤ → ℤ × ℤ) (wv wh u k : ℤ) :
    windingTransverseCoordinate wh wv
        (transverseTranslatedPeriodicPlaneLift m L base wv wh u k) =
      windingTransverseCoordinate wh wv (periodicPlaneLift m base L wv wh k) +
        u * (wh ^ 2 + wv ^ 2) := by
  rw [show transverseTranslatedPeriodicPlaneLift m L base wv wh u k =
      translatedFamily (periodicPlaneLift m base L wv wh) (wh, -wv) u k by
    rfl]
  rw [translatedFamily_coordinate_necSuf]
  have hshift : windingTransverseCoordinate wh wv (wh, -wv) =
      wh ^ 2 + wv ^ 2 := by
    simp [windingTransverseCoordinate]
    ring
  rw [hshift]

/-- `claim_transverse_translates_of_periodic_plane_lift_disjoint` の分離部分。 -/
theorem transverseTranslatedPeriodicPlaneLifts_disjoint
    (m L : ℕ) (base : ℤ → ℤ × ℤ) (wv wh : ℤ)
    (Kmin Kmax u v : ℤ)
    (hlower : ∀ k, Kmin ≤ windingTransverseCoordinate wh wv
      (periodicPlaneLift m base L wv wh k))
    (hupper : ∀ k, windingTransverseCoordinate wh wv
      (periodicPlaneLift m base L wv wh k) ≤ Kmax)
    (hgap : (v - u) * (wh ^ 2 + wv ^ 2) > Kmax - Kmin) :
    ∀ k k', transverseTranslatedPeriodicPlaneLift m L base wv wh u k ≠
      transverseTranslatedPeriodicPlaneLift m L base wv wh v k' := by
  have hcoordinate : windingTransverseCoordinate wh wv (wh, -wv) =
      wh ^ 2 + wv ^ 2 := by
    simp [windingTransverseCoordinate]
    ring
  apply translatedFamilies_disjoint_necSuf
    (periodicPlaneLift m base L wv wh) (wh, -wv)
    (windingTransverseCoordinate wh wv) Kmin Kmax u v hlower hupper
  rw [hcoordinate]
  exact hgap

end Ising2DLambda.KacWard
