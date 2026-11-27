import Ising2DLambda.KacWard.PeriodicPlaneLiftDistinctFromWalk
import Ising2DLambda.KacWard.PeriodicLiftStepRepetition
import Ising2DLambda.KacWard.IteratedTransverseStaircase
import Ising2DLambda.KacWard.StaircaseFromBandTopAvoidsPeriodicPlaneLift
import Ising2DLambda.KacWard.PeriodicPlaneLiftTransverseBounded
import Mathlib.Tactic

namespace Ising2DLambda.KacWard


/-- 一側閉包の二つの横断階段は、周期部分との接合点を除いて交わらない。 -/
theorem oneSidedStaircasesFromWalk_avoid_periodicLift {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hcontact : contactPairCount γ hγ = 0)
    (hwind : (horizontalDirectedWindingNumber γ,
      verticalDirectedWindingNumber γ) ≠ (0, 0))
    (k₀ : ℤ)
    (hmax : ∀ i : ℕ,
      windingTransverseCoordinateFromWalk γ (periodicPlaneLiftFromWalk γ (k₀ + i)) ≤
        windingTransverseCoordinateFromWalk γ (periodicPlaneLiftFromWalk γ k₀))
    (t c : ℕ) :
    let wh := horizontalDirectedWindingNumber γ
    let wv := verticalDirectedWindingNumber γ
    let S := periodicPlaneLiftFromWalk γ k₀
    let b := t * (wh.natAbs + wv.natAbs)
    (∀ i < c * (m + 1), ∀ j < b,
      periodicPlaneLiftFromWalk γ (k₀ + i) ≠
        iteratedTransverseStaircase wh wv (S + c • windingShift L wv wh) j) ∧
    (∀ i < c * (m + 1), ∀ j, 0 < j → j ≤ b →
      periodicPlaneLiftFromWalk γ (k₀ + i) ≠
        iteratedTransverseStaircase wh wv S j) := by
  dsimp only
  let wh := horizontalDirectedWindingNumber γ
  let wv := verticalDirectedWindingNumber γ
  let S := periodicPlaneLiftFromWalk γ k₀
  let κ := windingTransverseCoordinate wh wv
  have hκbase : κ (S + c • windingShift L wv wh) = κ S := by
    simp [κ, windingTransverseCoordinate, Prod.smul_mk, windingShift]
    ring
  -- 本文の `K_max(γ)`: 一周期の持ち上げ点の横断座標は `κ(S)` 以下である
  -- （`claim_periodic_plane_lift_transverse_bounded` の剰余への還元で `hmax` を一周期へ移す）。
  have hupper : ∀ r : ℤ, 0 ≤ r → r < ((m + 1 : ℕ) : ℤ) →
      κ (planeLiftIntegerBase γ r) ≤ κ S := by
    intro r hr0 hr1
    have hpos : (0 : ℤ) < ((m + 1 : ℕ) : ℤ) := by omega
    let i : ℕ := ((r - k₀) % ((m + 1 : ℕ) : ℤ)).toNat
    have hi : ((i : ℕ) : ℤ) = (r - k₀) % ((m + 1 : ℕ) : ℤ) :=
      Int.toNat_of_nonneg (Int.emod_nonneg _ (ne_of_gt hpos))
    have hmod : (k₀ + (i : ℤ)) % ((m + 1 : ℕ) : ℤ) = r := by
      rw [hi, Int.add_emod, Int.emod_emod_of_dvd _ (dvd_refl _), ← Int.add_emod]
      rw [show k₀ + (r - k₀) = r by ring]
      exact Int.emod_eq_of_lt hr0 hr1
    have h := hmax i
    change κ (periodicPlaneLift (m + 1) (planeLiftIntegerBase γ) L wv wh (k₀ + (i : ℤ))) ≤ κ S at h
    rw [periodicPlaneLift_transverseCoordinate_eq_base, hmod] at h
    exact h
  have htpos : ∀ j : ℕ, 0 < j → j ≤ t * (wh.natAbs + wv.natAbs) → 1 ≤ t := by
    intro j hj hjb
    rcases Nat.eq_zero_or_pos t with h0 | h0
    · subst h0
      simp at hjb
      omega
    · exact h0
  constructor
  · intro i hi j hj heq
    change periodicPlaneLiftFromWalk γ (k₀ + i) =
      iteratedTransverseStaircase wh wv (S + c • windingShift L wv wh) j at heq
    by_cases hj0 : j = 0
    · subst j
      have hbase : iteratedTransverseStaircase wh wv
          (S + c • windingShift L wv wh) 0 =
          periodicPlaneLiftFromWalk γ (k₀ + (c * (m + 1) : ℕ)) := by
        have hzero : iteratedTransverseStaircase wh wv
            (S + c • windingShift L wv wh) 0 = S + c • windingShift L wv wh := by
          simp [iteratedTransverseStaircase, iteratedStaircase,
            windingTransverseStaircase, twoPhaseStaircase]
        rw [hzero]
        simpa [periodicPlaneLiftFromWalk, S, Nat.cast_mul, mul_comm] using
          (periodicPlaneLift_translate (m + 1) L (by omega)
            (planeLiftIntegerBase γ) wv wh k₀ (c : ℤ)).symm
      rw [hbase] at heq
      have hinj := periodicPlaneLiftFromWalk_injective γ hγ hcontact hwind heq
      omega
    · -- 本文: 上り階段は基点 `Q_1` 以外で周期持ち上げと交わらない
      -- （`claim_staircase_from_band_top_meets_lift_only_at_base`、`κ(Q_1) = κ(S)`）。
      have hjpos : 0 < j := Nat.pos_of_ne_zero hj0
      exact iteratedTransverseStaircase_ne_periodicPlaneLift_of_band_top
        (m + 1) L (planeLiftIntegerBase γ) wv wh (S + c • windingShift L wv wh) (κ S)
        hwind (le_of_eq hκbase.symm) (by omega) hupper t j
        (htpos j hjpos (le_of_lt hj)) hjpos (le_of_lt hj) (k₀ + i) heq.symm
  · intro i hi j hj hjb heq
    change periodicPlaneLiftFromWalk γ (k₀ + i) =
      iteratedTransverseStaircase wh wv S j at heq
    -- 本文: 下り階段の頂点集合は `S` 以外で周期持ち上げと交わらない
    -- （`claim_staircase_from_band_top_meets_lift_only_at_base` を基点 `S` へ当てる）。
    exact iteratedTransverseStaircase_ne_periodicPlaneLift_of_band_top
      (m + 1) L (planeLiftIntegerBase γ) wv wh S (κ S)
      hwind le_rfl (by omega) hupper t j (htpos j hj hjb) hj hjb (k₀ + i) heq.symm

end Ising2DLambda.KacWard
