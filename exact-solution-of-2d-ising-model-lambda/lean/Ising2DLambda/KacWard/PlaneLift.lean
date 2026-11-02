import Ising2DLambda.KacWard.ClosedNonbacktrackingWalk
import Ising2DLambda.KacWard.DirectedWindingNumbers
import Ising2DLambda.KacWard.PeriodicPlaneLiftPeriodTurning

namespace Ising2DLambda.KacWard

/-- `def_plane_lift`。実際の向き付き辺列の始点から、各辺の整数変位を順に足す。 -/
def planeLift {L m : ℕ} (γ : Fin (m + 1) → OrientedEdge L) :
    Fin (m + 2) → ℤ × ℤ :=
  Fin.induction
    (((orientedSource (γ 0)).1.val : ℤ), ((orientedSource (γ 0)).2.val : ℤ))
    (fun k p => p + orientedEdgeLatticeStep (γ k))

theorem planeLift_zero {L m : ℕ} (γ : Fin (m + 1) → OrientedEdge L) :
    planeLift γ 0 =
      (((orientedSource (γ 0)).1.val : ℤ), ((orientedSource (γ 0)).2.val : ℤ)) := rfl

theorem planeLift_succ {L m : ℕ} (γ : Fin (m + 1) → OrientedEdge L)
    (k : Fin (m + 1)) :
    planeLift γ k.succ = planeLift γ k.castSucc + orientedEdgeLatticeStep (γ k) := rfl

/-- 一周期の平面持ち上げを整数添字で参照する。周期内の添字だけを後で使う。 -/
def planeLiftIntegerBase {L m : ℕ} (γ : Fin (m + 1) → OrientedEdge L)
    (r : ℤ) : ℤ × ℤ :=
  planeLift γ (Fin.ofNat (m + 2) r.toNat)

/-- `def_periodic_plane_lift`。実際の辺列から得た持ち上げと巻き付き数を周期延長する。 -/
def periodicPlaneLiftFromWalk {L m : ℕ} (γ : Fin (m + 1) → OrientedEdge L)
    (k : ℤ) : ℤ × ℤ :=
  periodicPlaneLift (m + 1) (planeLiftIntegerBase γ) L
    (verticalDirectedWindingNumber γ) (horizontalDirectedWindingNumber γ) k

theorem periodicPlaneLiftFromWalk_eq {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L) (k : ℤ) :
    periodicPlaneLiftFromWalk γ k =
      planeLiftIntegerBase γ (k % ((m + 1 : ℕ) : ℤ)) +
        (k / ((m + 1 : ℕ) : ℤ)) •
          windingShift L (verticalDirectedWindingNumber γ)
            (horizontalDirectedWindingNumber γ) := rfl

end Ising2DLambda.KacWard
