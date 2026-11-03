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
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

/-- 実際の閉歩道の持ち上げから、移動後の持ち上げに当たる歩数を集める。 -/
noncomputable def firstHitStepSetFromWalk {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L) (k0 : ℤ) (u : ℕ) : Finset ℕ :=
  firstHitStepSet
    (iteratedTransverseStaircase (horizontalDirectedWindingNumber γ)
      (verticalDirectedWindingNumber γ) (periodicPlaneLiftFromWalk γ k0))
    (transverseTranslatedPeriodicPlaneLiftFromWalk γ (u : ℤ))
    (u * (horizontalDirectedWindingNumber γ).natAbs +
      u * (verticalDirectedWindingNumber γ).natAbs)

/-- 正の移動回数では、階段の終端が移動後の持ち上げの基点に当たる。 -/
theorem firstHitStepSetFromWalk_nonempty {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L) (k0 : ℤ) (u : ℕ)
    (hwind : (horizontalDirectedWindingNumber γ,
      verticalDirectedWindingNumber γ) ≠ (0, 0)) (hu : 0 < u) :
    (firstHitStepSetFromWalk γ k0 u).Nonempty := by
  let wh := horizontalDirectedWindingNumber γ
  let wv := verticalDirectedWindingNumber γ
  let n := wh.natAbs + wv.natAbs
  have hn : 0 < n := by
    by_contra h
    have hwh : wh = 0 := Int.natAbs_eq_zero.mp (by omega : wh.natAbs = 0)
    have hwv : wv = 0 := Int.natAbs_eq_zero.mp (by omega : wv.natAbs = 0)
    exact hwind (Prod.ext hwh hwv)
  have hend : iteratedTransverseStaircase wh wv
      (periodicPlaneLiftFromWalk γ k0) (u * n) =
      transverseTranslatedPeriodicPlaneLiftFromWalk γ (u : ℤ) k0 := by
    have hdiv : u * (wh.natAbs + wv.natAbs) /
        (wh.natAbs + wv.natAbs) = u := Nat.mul_div_cancel u hn
    have hmod : u * (wh.natAbs + wv.natAbs) %
        (wh.natAbs + wv.natAbs) = 0 := Nat.mul_mod_left _ _
    simp [iteratedTransverseStaircase, iteratedStaircase, n, wh, wv, hdiv, hmod,
      windingTransverseStaircase, twoPhaseStaircase,
      transverseTranslatedPeriodicPlaneLiftFromWalk]
  refine ⟨u * n, ?_⟩
  simp only [firstHitStepSetFromWalk, firstHitStepSet, Finset.mem_filter,
    Finset.mem_Icc]
  refine ⟨⟨by exact Nat.mul_pos hu hn, by simp [n, wh, wv, Nat.mul_add]⟩, ⟨k0, ?_⟩⟩
  simpa [n, Nat.mul_add, wh, wv] using hend

/-- 実際の閉歩道に対する最初の当たり歩数。 -/
noncomputable def firstHitStepFromWalk {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L) (k0 : ℤ) (u : ℕ)
    (hnonempty : (firstHitStepSetFromWalk γ k0 u).Nonempty) : ℕ :=
  (firstHitStepSetFromWalk γ k0 u).min' hnonempty

/-- 実際の閉歩道の反復階段を最初の当たりで打ち切る。 -/
noncomputable def firstHitConnectingStaircaseFromWalk {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L) (k0 : ℤ) (u : ℕ)
    (hnonempty : (firstHitStepSetFromWalk γ k0 u).Nonempty) :
    Fin (firstHitStepFromWalk γ k0 u hnonempty + 1) → ℤ × ℤ :=
  fun s => iteratedTransverseStaircase (horizontalDirectedWindingNumber γ)
    (verticalDirectedWindingNumber γ) (periodicPlaneLiftFromWalk γ k0) s.val

theorem firstHitConnectingStaircaseFromWalk_eq_necSuf {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L) (k0 : ℤ) (u : ℕ)
    (hnonempty : (firstHitStepSetFromWalk γ k0 u).Nonempty) :
    firstHitConnectingStaircaseFromWalk γ k0 u hnonempty =
      firstHitPrefix
        (iteratedTransverseStaircase (horizontalDirectedWindingNumber γ)
          (verticalDirectedWindingNumber γ) (periodicPlaneLiftFromWalk γ k0))
        (transverseTranslatedPeriodicPlaneLiftFromWalk γ (u : ℤ))
        (u * (horizontalDirectedWindingNumber γ).natAbs +
          u * (verticalDirectedWindingNumber γ).natAbs) hnonempty := rfl

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
    (_hhitPositive : 1 ≤ hit)
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
  have hzero : iteratedTransverseStaircase wh wv Q 0 = Q := by
    simp [iteratedTransverseStaircase, iteratedStaircase,
      windingTransverseStaircase, twoPhaseStaircase]
  have hinjective := (iteratedTransverseStaircase_lower_bound wh wv Q hwind).2.2.2
  have horiginal : ∀ s : ℕ, 1 ≤ s → s ≤ hit → ∀ k : ℤ,
      iteratedTransverseStaircase wh wv Q s ≠ periodicPlaneLift m base L wv wh k := by
    intro s hs hsle k
    exact iteratedTransverseStaircase_ne_periodicPlaneLift_of_band_top
      m L base wv wh Q Kmax hwind (le_of_eq hbaseCoordinate.symm) hupper
      u.natAbs s hu hs (le_trans hsle hhitBound) k
  constructor
  · intro s s' _ _ heq
    exact hinjective heq
  constructor
  · rw [hzero]
    exact hbase
  constructor
  · exact horiginal
  constructor
  · exact hhit
  · intro s hs k
    by_cases hs0 : s = 0
    · subst s
      intro heq
      have htranslated := transverseTranslatedPeriodicPlaneLift_coordinate
        m L base wv wh u k
      have horiginalLower := hlower k
      rw [hzero] at heq
      rw [← heq] at htranslated
      rw [hbaseCoordinate] at htranslated
      omega
    · exact hminimal s (Nat.one_le_iff_ne_zero.mpr hs0) hs k

end Ising2DLambda.KacWard
