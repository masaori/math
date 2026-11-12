/-
具体版 `taggedMatchingTerm_cycleWalk` を必要十分版の特殊化として得る。
寄与の読み分けは R = Qbar[x]、J は辞書式順序の向き付き辺、ℓ・𝔰 は長い標識・短い標識の寄与、
cs は実際の交互閉路の点列の列、P は共通対の列とし、前提は具体版の補題で満たす。
閉歩道の辺による読みは K = 向き付き辺、ι = 反転、c(r) = 交互閉路の r 番目の点とし、
奇数番目の点の次の点がその反転であることは 𝒟₀ の相手が反転であることから満たす。
-/
import Ising2DLambda.KacWard.TaggedCyclePairWalk
import Ising2DLambda.NecSuf.KacWard.TaggedCyclePairWalk

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
attribute [local instance] Classical.propDecidable

theorem taggedMatchingTerm_cycleWalk_from_necSuf {L : ℕ} (z : Qbar) (hz : z ^ (4 : ℕ) = -1)
    (s : SpinStructure) (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L)) (ht : t ⊆ matchingOrientedPairs D)
    (hterm : matchingSignPolynomial D *
      ((-1 : Polynomial Qbar) ^ t.card *
        (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
        (∏ p ∈ t, gaugedShortContribution z s p)) ≠ 0) :
    (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
        (∏ p ∈ t, gaugedShortContribution z s p) =
      qbarConst ((((taggedOrientationList D t).map pairOrientation).prod : ℤ) : Qbar) *
        ((((taggedCycleMinima D t).sort (· ≤ ·)).map (fun m =>
            ((List.range (taggedCycleLength D t m)).map (fun r =>
              gaugedShortContribution z s
                (reversal (taggedCycleWalk D t m r), taggedCycleWalk D t m (r + 1)))).prod)).prod *
          ((taggedCommonPairs D t).map (gaugedLongContribution z s)).prod) := by
  have hev : ∀ c ∈ taggedCycleWords D t, Even c.length := by
    intro c hc
    obtain ⟨m, _, rfl⟩ := List.mem_map.mp hc
    exact (taggedCyclePoints_even D t m).2
  have hD : ∀ c ∈ taggedCycleWords D t, ∀ p ∈ consecutivePairs c,
      ({p.1, p.2} : Set (OrientedEdge L)) ∈ D.val := by
    intro c hc p hp
    obtain ⟨_, hmate⟩ := taggedCycle_pair_mate D t c hc p hp
    rw [hmate]
    exact (perfectMatchingMate_spec D p.1).2
  rw [NecSuf.KacWard.tagged_cycle_term_split_necSuf (gaugedLongContribution z s)
    (gaugedShortContribution z s) (gaugedLongContribution_swap z hz s)
    (gaugedShortContribution_swap z hz s) D t ht (taggedCycleWords D t) (taggedCommonPairs D t)
    hev (taggedCycleWords_complete D t) hD (fun p hp => (taggedCommonPairs_spec D t p hp).2.1)
    (taggedCycle_pairs_short D t z s ht hterm)
    (fun p hp => (taggedCommonPairs_long D t z s ht hterm p hp).1)]
  refine congrArg₂ (· * ·) ?_ ?_
  · rw [qbarConst, Polynomial.C_eq_intCast, Int.cast_list_prod, List.map_map]
    refine congrArg List.prod ?_
    apply List.map_congr_left
    intro p _
    simp only [Function.comp, NecSuf.KacWard.pairOrientationIn, pairOrientation]
    split_ifs <;> simp
  · refine congrArg (· * _) ?_
    unfold taggedCycleWords
    rw [List.map_map]
    apply congrArg List.prod
    apply List.map_congr_left
    intro m hm
    obtain ⟨i, _, rfl⟩ := Finset.mem_image.mp ((Finset.mem_sort _).mp hm)
    set m := matchingPairComponentMinimum (concreteShortInvolution D t)
      (concreteLongInvolution D t) i
    obtain ⟨k, hk⟩ := (taggedCycle_period D t m).2.1
    have hk2 : finitePermutationMinimalPeriod (concreteAlternatingSuccessor D t) m = 2 * k := by
      omega
    have hlen : taggedCycleLength D t m = k := by
      unfold taggedCycleLength
      omega
    have hcolor := (cycleMinimum_self_and_color D t i).2
    have hstep : ∀ r < k,
        (finiteMapIterate (concreteAlternatingSuccessor D t) (2 * r + 2) m).1 =
          reversal (finiteMapIterate (concreteAlternatingSuccessor D t) (2 * r + 1) m).1 := by
      intro r _
      have hodd : ¬ finiteMapIterate (concreteAlternatingSuccessor D t) (2 * r + 1) m ∈
          matchingPairColor (concreteShortInvolution D t) (concreteLongInvolution D t) := by
        rw [iterate_color_parity D t m hcolor (2 * r + 1)]
        exact Nat.not_even_iff_odd.mpr (odd_two_mul_add_one r)
      rw [iterate_succ_val D t m (2 * r + 1), if_neg hodd]
      exact referenceLongMate_eq_reversal _
    simp only [Function.comp]
    unfold taggedCyclePoints
    rw [hk2, NecSuf.KacWard.cycle_pairs_walk_necSuf reversal reversal_involutive
      (fun r => (finiteMapIterate (concreteAlternatingSuccessor D t) r m).1) k hstep, hlen,
      List.map_map]
    rfl

end Ising2DLambda.KacWard
