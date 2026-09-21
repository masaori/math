/- 具体版が必要十分版の整数格子上の接続階段への特殊化であることの導出。 -/
import Ising2DLambda.KacWard.FirstHitConnectingStaircase

namespace Ising2DLambda.KacWard

/-- `claim_first_hit_connecting_staircase_meets_lifts_only_at_ends` を必要十分版から導いたもの。 -/
theorem firstHitConnectingStaircase_meets_lifts_only_at_ends_from_necSuf
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
          transverseTranslatedPeriodicPlaneLift m L base wv wh u k) :=
  firstHitConnectingStaircase_meets_lifts_only_at_ends
    m L base wv wh Q Kmin Kmax u hit k0 hwind hbase hbaseCoordinate
    hlower hupper hgap hu hhitPositive hhitBound hhit hminimal

end Ising2DLambda.KacWard
