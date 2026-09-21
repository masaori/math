/-
章「Onsager 閉形式への接続」の
「接続階段は元の持ち上げと始点でのみ、移動後の持ち上げと終点でのみ交わる」
（`claim_first_hit_connecting_staircase_meets_lifts_only_at_ends`）の具体版。

人手証明と同じく、階段の単射性、元の持ち上げの帯上端、最初の当たり歩数の
最小性、移動後の持ち上げの横断座標の順に合成する。住処は ℤ だけである。
-/
import Ising2DLambda.KacWard.StaircaseFromBandTopAvoidsPeriodicPlaneLift
import Ising2DLambda.KacWard.TransverseTranslatedPeriodicPlaneLift
import Ising2DLambda.NecSuf.KacWard.FirstHitConnectingStaircase

namespace Ising2DLambda.KacWard

/-- `claim_first_hit_connecting_staircase_meets_lifts_only_at_ends`。 -/
theorem firstHitConnectingStaircase_meets_lifts_only_at_ends
    (m L : ℕ) (base : ℤ → ℤ × ℤ) (wv wh : ℤ) (Q : ℤ × ℤ)
    (Kmin Kmax u : ℤ) (hit : ℕ) (k0 : ℤ)
    (hwind : (wh, wv) ≠ (0, 0))
    (hbase : Q = periodicPlaneLift m base L wv wh k0)
    (hbaseCoordinate : windingTransverseCoordinate wh wv Q = Kmax)
    (hlower : ∀ k : ℤ, Kmin ≤ windingTransverseCoordinate wh wv
      (periodicPlaneLift m base L wv wh k))
    (hupper : ∀ k : ℤ, windingTransverseCoordinate wh wv
      (periodicPlaneLift m base L wv wh k) ≤ Kmax)
    (hgap : u * (wh ^ 2 + wv ^ 2) > Kmax - Kmin)
    (hu : 1 ≤ u.natAbs)
    (hhitPositive : 1 ≤ hit)
    (hhitBound : hit ≤ u.natAbs * (wh.natAbs + wv.natAbs))
    (hhit : ∃ k : ℤ, iteratedTransverseStaircase wh wv Q hit =
      transverseTranslatedPeriodicPlaneLift m L base wv wh u k)
    (hminimal : ∀ s : ℕ, 1 ≤ s → s < hit → ∀ k : ℤ,
      iteratedTransverseStaircase wh wv Q s ≠
        transverseTranslatedPeriodicPlaneLift m L base wv wh u k) :
    (∀ s s' : ℕ, s ≤ hit → s' ≤ hit →
      iteratedTransverseStaircase wh wv Q s =
        iteratedTransverseStaircase wh wv Q s' → s = s') ∧
      iteratedTransverseStaircase wh wv Q 0 = periodicPlaneLift m base L wv wh k0 ∧
      (∀ s : ℕ, 1 ≤ s → s ≤ hit → ∀ k : ℤ,
        iteratedTransverseStaircase wh wv Q s ≠ periodicPlaneLift m base L wv wh k) ∧
      (∃ k : ℤ, iteratedTransverseStaircase wh wv Q hit =
        transverseTranslatedPeriodicPlaneLift m L base wv wh u k) ∧
      (∀ s : ℕ, s < hit → ∀ k : ℤ,
        iteratedTransverseStaircase wh wv Q s ≠
          transverseTranslatedPeriodicPlaneLift m L base wv wh u k) := by
  apply Ising2DLambda.NecSuf.KacWard.first_hit_prefix_meets_families_only_at_ends_necSuf
    (iteratedTransverseStaircase wh wv Q)
    (periodicPlaneLift m base L wv wh)
    (transverseTranslatedPeriodicPlaneLift m L base wv wh u)
    (windingTransverseCoordinate wh wv) hit k0 Kmin Kmax
    (u * (wh ^ 2 + wv ^ 2))
  · exact (iteratedTransverseStaircase_lower_bound wh wv Q hwind).2.2.2
  · rw [show iteratedTransverseStaircase wh wv Q 0 = Q by
      simp [iteratedTransverseStaircase,
        Ising2DLambda.NecSuf.KacWard.iteratedStaircase,
        windingTransverseStaircase,
        Ising2DLambda.NecSuf.KacWard.twoPhaseStaircase]]
    exact hbase
  · rw [show iteratedTransverseStaircase wh wv Q 0 = Q by
      simp [iteratedTransverseStaircase,
        Ising2DLambda.NecSuf.KacWard.iteratedStaircase,
        windingTransverseStaircase,
        Ising2DLambda.NecSuf.KacWard.twoPhaseStaircase]]
    exact hbaseCoordinate
  · exact hlower
  · intro k
    exact transverseTranslatedPeriodicPlaneLift_coordinate m L base wv wh u k
  · exact hgap
  · exact hhitPositive
  · intro s hs hsle k
    exact iteratedTransverseStaircase_ne_periodicPlaneLift_of_band_top
      m L base wv wh Q Kmax hwind (le_of_eq hbaseCoordinate.symm) hupper
      u.natAbs s hu hs (le_trans hsle hhitBound) k
  · exact hhit
  · exact hminimal

end Ising2DLambda.KacWard
