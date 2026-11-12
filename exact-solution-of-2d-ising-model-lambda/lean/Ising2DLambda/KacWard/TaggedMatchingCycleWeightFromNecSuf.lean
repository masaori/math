/-
具体版 `taggedMatchingTerm_cycleWeight` を必要十分版の特殊化として得る。
閉路ごとの比は K = 向き付き辺、R = Qbar[x]、ι = 反転、g = 対角変換の重みの定数多項式、
η = 長い対の向きの符号、S = 短い標識の寄与、h = ねじれ符号と回転位相の積の定数多項式とし、
比の仮定は対角変換因子の比（`alternating_cycle_gauge_ratio`）、長い対の仮定は
`gaugePairWeight_reversal_orientation` で満たす。符号の整理と組み立ては R = Qbar[x]、
l = 交互閉路の最小元の列とし、前提は具体版の補題で満たす。
-/
import Ising2DLambda.KacWard.TaggedMatchingCycleWeight
import Ising2DLambda.NecSuf.KacWard.TaggedMatchingCycleWeight

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
attribute [local instance] Classical.propDecidable

theorem taggedMatchingTerm_cycleWeight_from_necSuf {L : ℕ} (z : Qbar) (hz : z ^ (4 : ℕ) = -1)
    (s : SpinStructure) (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L)) (ht : t ⊆ matchingOrientedPairs D)
    (hterm : matchingSignPolynomial D *
      ((-1 : Polynomial Qbar) ^ t.card *
        (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
        (∏ p ∈ t, gaugedShortContribution z s p)) ≠ 0) :
    matchingSignPolynomial D *
        ((-1 : Polynomial Qbar) ^ t.card *
          (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
          (∏ p ∈ t, gaugedShortContribution z s p)) =
      (((taggedCycleMinima D t).sort (· ≤ ·)).map (fun m =>
        -(Polynomial.X ^ taggedCycleLength D t m) *
          qbarConst (∏ r ∈ Finset.range (taggedCycleLength D t m),
            (twistSign s (taggedCycleWalk D t m (r + 1)) : Qbar) *
              rotationPhase z (taggedCycleWalk D t m r) (taggedCycleWalk D t m (r + 1))))).prod := by
  have hcast : ∀ a : ℤ, qbarConst ((a : ℤ) : Qbar) = ((a : ℤ) : Polynomial Qbar) := fun a =>
    Polynomial.C_eq_intCast a
  have hmin : ∀ m ∈ (taggedCycleMinima D t).sort (· ≤ ·), ∃ i,
      matchingPairComponentMinimum (concreteShortInvolution D t) (concreteLongInvolution D t) i = m := by
    intro m hm
    obtain ⟨i, _, hi⟩ := Finset.mem_image.mp ((Finset.mem_sort _).mp hm)
    exact ⟨i, hi⟩
  let Y : TaggedActive D t → Polynomial Qbar := fun m =>
    Polynomial.X ^ taggedCycleLength D t m * qbarConst (taggedCyclePhase z s D t m)
  let P : TaggedActive D t → Polynomial Qbar := fun m =>
    ((List.range (taggedCycleLength D t m)).map (fun r =>
      gaugedShortContribution z s
        (reversal (taggedCycleWalk D t m r), taggedCycleWalk D t m (r + 1)))).prod
  have hP : ∀ m ∈ (taggedCycleMinima D t).sort (· ≤ ·),
      P m = ((-1) ^ taggedCycleLength D t m *
        ((cycleReferenceOrientation (taggedCyclePoints D t m) : ℤ) : Polynomial Qbar)) * Y m := by
    intro m hm
    have hmw : taggedCyclePoints D t m ∈ taggedCycleWords D t :=
      List.mem_map.mpr ⟨m, (Finset.mem_sort _).mpr ((Finset.mem_sort _).mp hm), rfl⟩
    obtain ⟨i, rfl⟩ := hmin m hm
    have hwalk := taggedCycle_pairs_walk D t i
    have ha0 := cycleReferenceOrientation_walk D t i
    simp only at hwalk ha0
    set m0 := matchingPairComponentMinimum (concreteShortInvolution D t)
      (concreteLongInvolution D t) i with hm0
    obtain ⟨n, hn⟩ := Nat.exists_eq_add_of_lt (taggedCycleLength_pos D t m0)
    rw [zero_add] at hn
    have hper := hwalk.2
    rw [hn] at hper
    let w := taggedCycleWalk D t m0
    have hS : ∀ r < n + 1, gaugedShortContribution z s (reversal (w r), w (r + 1)) =
        Polynomial.X * (qbarConst (gaugePairWeight z s (reversal (w r)) (w (r + 1))) *
          qbarConst ((twistSign s (w (r + 1)) : Qbar) * rotationPhase z (w r) (w (r + 1)))) := by
      intro r hr
      have hp : (reversal (w r), w (r + 1)) ∈ consecutivePairs (taggedCyclePoints D t m0) := by
        rw [hwalk.1]
        exact List.mem_map.mpr ⟨r, List.mem_range.mpr (lt_of_lt_of_eq hr hn.symm), rfl⟩
      have hB : (∏ p ∈ t, gaugedShortContribution z s p) ≠ 0 :=
        right_ne_zero_of_mul (right_ne_zero_of_mul hterm)
      have hne := gaugedShortContribution_ne_zero_of_ascending z hz s _
        (Finset.prod_ne_zero_iff.mp hB _ (taggedCycle_pairs_short D t z s ht hterm _ hmw _ hp))
      have hc := gaugedShortContribution_cond_of_ne_zero z s _ hne
      rw [gaugedShortContribution, if_pos hc, reversal_involutive, qbarConst, qbarConst, qbarConst,
        Polynomial.C_mul]
    have hratio : ∏ r : Fin (n + 1), qbarConst (gaugePairWeight z s (reversal (w (r - 1).val))
          (w r.val)) =
        (-1) ^ (n + 1) * ∏ r : Fin (n + 1),
          qbarConst (gaugePairWeight z s (w r.val) (reversal (w r.val))) := by
      have h := congrArg qbarConst (alternating_cycle_gauge_ratio z hz s (fun r : Fin (n + 1) => w r.val))
      simp only [qbarConst, map_prod, map_mul, map_pow, map_neg, map_one] at h ⊢
      exact h
    have hlong : ∀ e : OrientedEdge L, qbarConst (gaugePairWeight z s e (reversal e)) =
        ((pairOrientation (e, reversal e) : ℤ) : Polynomial Qbar) := by
      intro e
      rw [gaugePairWeight_reversal_orientation z hz s e, hcast]
    have hcyc := NecSuf.KacWard.cycle_short_product_necSuf reversal
      (fun e f => qbarConst (gaugePairWeight z s e f))
      (fun e => ((pairOrientation (e, reversal e) : ℤ) : Polynomial Qbar))
      (gaugedShortContribution z s) Polynomial.X
      (fun r => qbarConst ((twistSign s (w (r + 1)) : Qbar) * rotationPhase z (w r) (w (r + 1))))
      n w hper hS hratio hlong
    simp only [P, Y]
    rw [ha0, hn]
    simp only [w] at hcyc
    rw [hcyc, taggedCyclePhase, hn]
    simp only [qbarConst, map_prod]
    push_cast
    ring
  have hsplit := taggedMatchingTerm_cycleWalk z hz s D t ht hterm
  have hsignD := (taggedAlternatingCycles_matching_sign D t).2
  rw [referenceLongMatching_sign, mul_one, ← Finset.length_sort (· ≤ ·)] at hsignD
  have hsign' : perfectMatchingSign D = (-1) ^ ((taggedCycleMinima D t).sort (· ≤ ·)).length *
      (((taggedCycleMinima D t).sort (· ≤ ·)).map (fun m =>
        cycleShortOrientation (taggedCyclePoints D t m) *
          cycleReferenceOrientation (taggedCyclePoints D t m))).prod := by
    rw [hsignD]
    unfold taggedCycleWords
    rw [List.map_map]
    rfl
  have hAD : ((taggedOrientationList D t).map pairOrientation).prod =
      (((taggedCycleMinima D t).sort (· ≤ ·)).map (fun m =>
        cycleShortOrientation (taggedCyclePoints D t m))).prod := by
    rw [taggedOrientationList_orientation]
    unfold taggedCycleWords
    rw [List.map_map]
    rfl
  have hres := NecSuf.KacWard.cycle_term_compose_necSuf ((taggedCycleMinima D t).sort (· ≤ ·))
    ((perfectMatchingSign D : ℤ) : Polynomial Qbar) ((-1 : Polynomial Qbar) ^ t.card)
    (qbarConst ((((taggedOrientationList D t).map pairOrientation).prod : ℤ) : Qbar))
    ((taggedCommonPairs D t).map (gaugedLongContribution z s)).prod
    (matchingSignPolynomial D *
        ((-1 : Polynomial Qbar) ^ t.card *
          (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
          (∏ p ∈ t, gaugedShortContribution z s p)))
    (taggedCycleLength D t)
    (fun m => ((cycleShortOrientation (taggedCyclePoints D t m) : ℤ) : Polynomial Qbar))
    (fun m => ((cycleReferenceOrientation (taggedCyclePoints D t m) : ℤ) : Polynomial Qbar))
    P Y
    (by
      rw [hsign']
      simp only [Int.cast_mul, Int.cast_pow, Int.cast_neg, Int.cast_one, Int.cast_list_prod,
        List.map_map, Function.comp_def])
    (fun m _ => by rw [← Int.cast_mul]; exact congrArg Int.cast (pairOrientation_list_prod_sq _) |>.trans Int.cast_one)
    (fun m _ => by rw [← Int.cast_mul]; exact congrArg Int.cast (pairOrientation_list_prod_sq _) |>.trans Int.cast_one)
    (neg_one_pow_card_cycles z s ht hterm)
    (by
      rw [hAD, hcast]
      simp only [Int.cast_list_prod, List.map_map, Function.comp_def])
    hP
    (taggedCommonPairs_longContribution D t z hz s ht hterm)
    (by
      rw [mul_assoc ((-1 : Polynomial Qbar) ^ t.card), hsplit, matchingSignPolynomial,
        Polynomial.C_eq_intCast])
  rw [hres]
  apply congrArg List.prod
  apply List.map_congr_left
  intro m _
  simp only [Y, taggedCyclePhase]
  ring

end Ising2DLambda.KacWard
