/-
章「Onsager 閉形式への接続」の
「横断幅を超えて離した周期持ち上げは交わらない」
（`claim_transverse_translates_of_periodic_plane_lift_disjoint`）の具体版。

人手証明と同じく、横断移動後の座標を整数の分配則で計算し、周期持ち上げの
横断座標の上下界と幅の不等式をつないで二つの像を分離する。住処は ℤ だけである。
-/
import Ising2DLambda.KacWard.PeriodicPlaneLiftTransverseBounded
import Ising2DLambda.KacWard.PlaneLift
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

/-- `def_transverse_translate_of_periodic_plane_lift`。 -/
def transverseTranslatedPeriodicPlaneLift
    (m L : ℕ) (base : ℤ → ℤ × ℤ) (wv wh u k : ℤ) : ℤ × ℤ :=
  periodicPlaneLift m base L wv wh k + u • (wh, -wv)

/-- 実際の閉じた辺列から定める周期持ち上げの整数横断平行移動。 -/
def transverseTranslatedPeriodicPlaneLiftFromWalk {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L) (u k : ℤ) : ℤ × ℤ :=
  periodicPlaneLiftFromWalk γ k +
    u • (horizontalDirectedWindingNumber γ, -verticalDirectedWindingNumber γ)

theorem transverseTranslatedPeriodicPlaneLiftFromWalk_eq {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L) (u k : ℤ) :
    transverseTranslatedPeriodicPlaneLiftFromWalk γ u k =
      transverseTranslatedPeriodicPlaneLift (m + 1) L
        (planeLiftIntegerBase γ) (verticalDirectedWindingNumber γ)
        (horizontalDirectedWindingNumber γ) u k := rfl

/-- 横断平行移動は横断座標を `u(wh²+wv²)` だけ変える。 -/
theorem transverseTranslatedPeriodicPlaneLift_coordinate
    (m L : ℕ) (base : ℤ → ℤ × ℤ) (wv wh u k : ℤ) :
    windingTransverseCoordinate wh wv
        (transverseTranslatedPeriodicPlaneLift m L base wv wh u k) =
      windingTransverseCoordinate wh wv (periodicPlaneLift m base L wv wh k) +
        u * (wh ^ 2 + wv ^ 2) := by
  calc
    _ = windingTransverseCoordinate wh wv
        (periodicPlaneLift m base L wv wh k + u • (wh, -wv)) := rfl
    _ = windingTransverseCoordinate wh wv (periodicPlaneLift m base L wv wh k) +
          windingTransverseCoordinate wh wv (u • (wh, -wv)) := by rw [map_add]
    _ = windingTransverseCoordinate wh wv (periodicPlaneLift m base L wv wh k) +
          u * windingTransverseCoordinate wh wv (wh, -wv) := by
      rw [map_zsmul]
      simp
    _ = _ := by
      have hshift : windingTransverseCoordinate wh wv (wh, -wv) =
          wh ^ 2 + wv ^ 2 := by
        simp [windingTransverseCoordinate]
        ring
      rw [hshift]

/-- `claim_transverse_translates_of_periodic_plane_lift_disjoint` の分離部分。 -/
theorem transverseTranslatedPeriodicPlaneLifts_disjoint
    (m L : ℕ) (base : ℤ → ℤ × ℤ) (wv wh : ℤ)
    (Kmin Kmax u v : ℤ) (hm : 0 < m)
    (hlower : ∀ r : ℤ, 0 ≤ r → r < (m : ℤ) →
      Kmin ≤ windingTransverseCoordinate wh wv (base r))
    (hupper : ∀ r : ℤ, 0 ≤ r → r < (m : ℤ) →
      windingTransverseCoordinate wh wv (base r) ≤ Kmax)
    (hgap : (v - u) * (wh ^ 2 + wv ^ 2) > Kmax - Kmin) :
    ∀ k k', transverseTranslatedPeriodicPlaneLift m L base wv wh u k ≠
      transverseTranslatedPeriodicPlaneLift m L base wv wh v k' := by
  intro k k' heq
  have hleft := transverseTranslatedPeriodicPlaneLift_coordinate
    m L base wv wh u k
  have hright := transverseTranslatedPeriodicPlaneLift_coordinate
    m L base wv wh v k'
  have hstrict : windingTransverseCoordinate wh wv
      (transverseTranslatedPeriodicPlaneLift m L base wv wh u k) <
      windingTransverseCoordinate wh wv
        (transverseTranslatedPeriodicPlaneLift m L base wv wh v k') := by
    rw [hleft, hright]
    -- 本文の不等式の一行目と三行目: 周期持ち上げの有限幅と `K_max`・`K_min` の定義。
    have hk := periodicPlaneLift_transverseCoordinate_le_of_period_le
      m L hm base wv wh Kmax hupper k
    have hk' := periodicPlaneLift_transverseCoordinate_ge_of_period_ge
      m L hm base wv wh Kmin hlower k'
    have hmul : (v - u) * (wh ^ 2 + wv ^ 2) =
        v * (wh ^ 2 + wv ^ 2) - u * (wh ^ 2 + wv ^ 2) := by ring
    rw [hmul] at hgap
    omega
  exact (ne_of_lt hstrict) (congrArg (windingTransverseCoordinate wh wv) heq)

end Ising2DLambda.KacWard
