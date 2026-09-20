/-
章「Onsager 閉形式への接続」の
「整数帯の上端以上の基点からの反復横断階段は基点以外で周期持ち上げと交わらない」
（`claim_staircase_from_band_top_meets_lift_only_at_base`）の具体版。

人手証明と同じく、反復横断階段の歩数下界と周期持ち上げの上端を整数の順序でつなぐ。
住処は ℤ だけである。
-/
import Ising2DLambda.KacWard.IteratedTransverseStaircase
import Ising2DLambda.KacWard.PeriodicPlaneLiftTransverseBounded
import Ising2DLambda.NecSuf.KacWard.StaircaseAboveUpperAvoidsFamily

namespace Ising2DLambda.KacWard

/-- `claim_staircase_from_band_top_meets_lift_only_at_base`。 -/
theorem iteratedTransverseStaircase_ne_periodicPlaneLift_of_band_top
    (m L : ℕ) (base : ℤ → ℤ × ℤ) (wv wh : ℤ) (Q : ℤ × ℤ) (Kmax : ℤ)
    (hwind : (wh, wv) ≠ (0, 0))
    (hbase : Kmax ≤ windingTransverseCoordinate wh wv Q)
    (hupper : ∀ k : ℤ, windingTransverseCoordinate wh wv
      (periodicPlaneLift m base L wv wh k) ≤ Kmax)
    (t s : ℕ) (_ht : 1 ≤ t) (hs : 1 ≤ s)
    (_hsle : s ≤ t * (wh.natAbs + wv.natAbs)) (k : ℤ) :
    iteratedTransverseStaircase wh wv Q s ≠ periodicPlaneLift m base L wv wh k := by
  exact Ising2DLambda.NecSuf.KacWard.staircase_above_upper_avoids_family_necSuf
    (iteratedTransverseStaircase wh wv Q) (periodicPlaneLift m base L wv wh)
    (windingTransverseCoordinate wh wv) Q Kmax hbase
    (iteratedTransverseStaircase_lower_bound wh wv Q hwind).2.2.1 hupper s hs k

end Ising2DLambda.KacWard
