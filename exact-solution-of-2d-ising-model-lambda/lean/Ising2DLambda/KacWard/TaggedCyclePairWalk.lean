/-
「非零項は閉歩道ごとのねじれ・回転位相の積に分かれる」（claim_tagged_matching_cycle_weight）の
具体版のうち、実際の交互閉路の対を閉歩道の辺で読む段（本文の証明の冒頭「各閉路の短い標識の対を
(ι(e_{C,r-1}), e_{C,r})、基準の長い標識の対を (e_{C,r}, ι(e_{C,r})) の向きで取る」）。
実際の非零項 (D, T) について、交互閉路の点列 c(r)（`taggedCyclePoints`）の D の対 (c(2r), c(2r+1)) は
T の短い対で、射影した閉歩道 w_r = ι(c(2r)) について (ι(w_r), w_{r+1}) に等しい。両マッチングに共通する
対（`taggedCommonPairs`）は T の外の長い対で、反転対である。向き直しの列 l を閉路の対の列と共通対の
列の連結に取り、向き直しの段 `taggedMatchingTerm_oriented` へ渡す。

  人手証明                                              このファイル
  閉路の長さ k_C と射影した閉歩道 w_r = ι(c(2r))         `taggedCycleLength`・`taggedCycleWalk`
  (c(2r), c(2r+1)) = (ι(w_r), w_{r+1})、w_{k_C} = w_0     `taggedCycle_pairs_walk`
  活動点の D の対は短い標識、活動点でない対は長い標識  `ascendingMatePair_mem_iff_active`
  閉路の対は T の短い対                                 `taggedCycle_pairs_short`
  共通対は T の外の反転対                               `taggedCommonPairs_long`
  向き直しの列 l（閉路の対の列と共通対の列の連結）     `taggedOrientationList`・
                                                        `taggedOrientationList_complete`・
                                                        `taggedOrientationList_pairs_D`
  l の η の積は閉路ごとの α_D(C) の積                   `taggedOrientationList_orientation`
  項を閉歩道の辺と共通対で読む                          `taggedMatchingTerm_cycleWalk`

必要十分版は呼ばない。住処は有限集合・ℤ・Qbar・Qbar[x] で、ℝ / ℂ は現れない。
-/
import Ising2DLambda.KacWard.TaggedMatchingTermOrientation
import Ising2DLambda.KacWard.TaggedAlternatingCycleMatchingSign
import Ising2DLambda.KacWard.TaggedSymmetricDifferenceActiveVertices
import Ising2DLambda.KacWard.ReferenceLongMate

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open scoped Classical

variable {L : ℕ}

/-- D の相手との対を昇順へ直したものは D の昇順対で、二元集合としては {e, D の相手} に等しい。 -/
theorem ascendingMatePair_spec (D : PerfectMatching (OrientedEdge L)) (e : OrientedEdge L) :
    ascendingPair (e, perfectMatchingMate D e) ∈ matchingOrientedPairs D ∧
      ({(ascendingPair (e, perfectMatchingMate D e)).1,
        (ascendingPair (e, perfectMatchingMate D e)).2} : Set (OrientedEdge L)) =
        {e, perfectMatchingMate D e} := by
  have hne : e ≠ perfectMatchingMate D e := (perfectMatchingMate_ne D e).symm
  have hpair := (perfectMatchingMate_spec D e).2
  have hset : ({(ascendingPair (e, perfectMatchingMate D e)).1,
      (ascendingPair (e, perfectMatchingMate D e)).2} : Set (OrientedEdge L)) =
      {e, perfectMatchingMate D e} := by
    unfold ascendingPair
    split_ifs
    · rfl
    · exact Set.pair_comm _ _
  refine ⟨Finset.mem_filter.mpr ⟨Finset.mem_univ _, ?_, by rw [hset]; exact hpair⟩, hset⟩
  unfold ascendingPair
  split_ifs with hlt
  · exact hlt
  · exact lt_of_le_of_ne (not_lt.mp hlt) hne.symm

section ActualCycles

attribute [local instance] Classical.propDecidable

/-- 閉路の長さ k_C（点列の長さの半分）。 -/
noncomputable def taggedCycleLength (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L)) (m : TaggedActive D t) : ℕ :=
  finitePermutationMinimalPeriod (concreteAlternatingSuccessor D t) m / 2

/-- 射影した閉歩道の第 r 辺 w_r = ι(c(2r))。 -/
noncomputable def taggedCycleWalk (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L)) (m : TaggedActive D t) (r : ℕ) :
    OrientedEdge L :=
  reversal (finiteMapIterate (concreteAlternatingSuccessor D t) (2 * r) m).1

/-- 向き直しの列 l。閉路の対を閉路の順に、続いて共通対を並べる。 -/
noncomputable def taggedOrientationList (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L)) : List (OrientedEdge L × OrientedEdge L) :=
  ((taggedCycleWords D t).map consecutivePairs).flatten ++ taggedCommonPairs D t

section Facts

variable (D : PerfectMatching (OrientedEdge L)) (t : Finset (OrientedEdge L × OrientedEdge L))

/-- 最小元から読んだ閉路の対は、射影した閉歩道の辺で (ι(w_r), w_{r+1}) と読め、閉歩道は閉じる。
    第二成分は c(2r+2) = ι(c(2r+1))（奇数回目の一歩は 𝒟₀ の相手、すなわち反転）による。 -/
theorem taggedCycle_pairs_walk (i : TaggedActive D t) :
    let m := matchingPairComponentMinimum (concreteShortInvolution D t)
      (concreteLongInvolution D t) i
    consecutivePairs (taggedCyclePoints D t m) =
        (List.range (taggedCycleLength D t m)).map
          (fun r => (reversal (taggedCycleWalk D t m r), taggedCycleWalk D t m (r + 1))) ∧
      taggedCycleWalk D t m (taggedCycleLength D t m) = taggedCycleWalk D t m 0 := by
  intro m
  obtain ⟨_, ⟨k, hk⟩, hper⟩ := taggedCycle_period D t m
  have hk2 : finitePermutationMinimalPeriod (concreteAlternatingSuccessor D t) m = 2 * k := by
    omega
  have hlen : taggedCycleLength D t m = k := by
    unfold taggedCycleLength
    omega
  have hcolor := (cycleMinimum_self_and_color D t i).2
  refine ⟨?_, ?_⟩
  · unfold taggedCyclePoints
    rw [hk2, consecutivePairs_map_range, hlen]
    apply List.map_congr_left
    intro r _
    have hodd : ¬ finiteMapIterate (concreteAlternatingSuccessor D t) (2 * r + 1) m ∈
        matchingPairColor (concreteShortInvolution D t) (concreteLongInvolution D t) := by
      rw [iterate_color_parity D t m hcolor (2 * r + 1)]
      exact Nat.not_even_iff_odd.mpr (odd_two_mul_add_one r)
    have hnext : (finiteMapIterate (concreteAlternatingSuccessor D t) (2 * (r + 1)) m).1 =
        reversal (finiteMapIterate (concreteAlternatingSuccessor D t) (2 * r + 1) m).1 := by
      rw [show 2 * (r + 1) = 2 * r + 1 + 1 by ring, iterate_succ_val D t m (2 * r + 1),
        if_neg hodd]
      exact referenceLongMate_eq_reversal _
    simp only [taggedCycleWalk]
    rw [reversal_involutive, hnext, reversal_involutive]
  · simp only [taggedCycleWalk]
    rw [hlen, ← hk2, hper]
    rfl

/-- 非零項では、点 e の D の対が短い標識を持つことと e が活動点であることは同値である
    （claim_tagged_symmetric_difference_degree の局所の形）。 -/
theorem ascendingMatePair_mem_iff_active (z : Qbar) (s : SpinStructure)
    (ht : t ⊆ matchingOrientedPairs D)
    (hterm : matchingSignPolynomial D *
      ((-1 : Polynomial Qbar) ^ t.card *
        (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
        (∏ p ∈ t, gaugedShortContribution z s p)) ≠ 0)
    (e : OrientedEdge L) :
    ascendingPair (e, perfectMatchingMate D e) ∈ t ↔ e ∈ concreteTaggedActiveVertices D t := by
  obtain ⟨hmem, hset⟩ := ascendingMatePair_spec D e
  calc
    ascendingPair (e, perfectMatchingMate D e) ∈ t ↔
        ({(ascendingPair (e, perfectMatchingMate D e)).1,
          (ascendingPair (e, perfectMatchingMate D e)).2} : Set (OrientedEdge L)) ∈
          shortUnderlyingPairs t :=
      (shortUnderlyingPairs_iff D t ht _ hmem).symm
    _ ↔ ({e, perfectMatchingMate D e} : Set (OrientedEdge L)) ∈ shortUnderlyingPairs t := by
      rw [hset]
    _ ↔ e ∈ concreteTaggedActiveVertices D t :=
      (taggedDifference_active_iff_short z s D t hterm e).symm

/-- 閉路の対の第二成分は第一成分の D の相手である。 -/
theorem taggedCycle_pair_mate (c : List (OrientedEdge L)) (hc : c ∈ taggedCycleWords D t)
    (p : OrientedEdge L × OrientedEdge L) (hp : p ∈ consecutivePairs c) :
    p.1 ∈ concreteTaggedActiveVertices D t ∧ p.2 = perfectMatchingMate D p.1 := by
  obtain ⟨m, hm, rfl⟩ := List.mem_map.mp hc
  obtain ⟨i, _, rfl⟩ := Finset.mem_image.mp ((Finset.mem_sort _).mp hm)
  set m := matchingPairComponentMinimum (concreteShortInvolution D t)
    (concreteLongInvolution D t) i
  obtain ⟨k, hk⟩ := (taggedCycle_period D t m).2.1
  have hk2 : finitePermutationMinimalPeriod (concreteAlternatingSuccessor D t) m = 2 * k := by
    omega
  unfold taggedCyclePoints at hp
  rw [hk2, consecutivePairs_map_range] at hp
  obtain ⟨r, _, rfl⟩ := List.mem_map.mp hp
  have hcol := (iterate_color_parity D t m (cycleMinimum_self_and_color D t i).2 (2 * r)).mpr
    (even_two_mul r)
  refine ⟨(finiteMapIterate (concreteAlternatingSuccessor D t) (2 * r) m).2, ?_⟩
  simp only
  rw [iterate_succ_val D t m (2 * r), if_pos hcol]

/-- 非零項では、閉路の対は T の短い対である。 -/
theorem taggedCycle_pairs_short (z : Qbar) (s : SpinStructure)
    (ht : t ⊆ matchingOrientedPairs D)
    (hterm : matchingSignPolynomial D *
      ((-1 : Polynomial Qbar) ^ t.card *
        (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
        (∏ p ∈ t, gaugedShortContribution z s p)) ≠ 0)
    (c : List (OrientedEdge L)) (hc : c ∈ taggedCycleWords D t)
    (p : OrientedEdge L × OrientedEdge L) (hp : p ∈ consecutivePairs c) :
    ascendingPair p ∈ t := by
  obtain ⟨hact, hmate⟩ := taggedCycle_pair_mate D t c hc p hp
  have hp' : p = (p.1, perfectMatchingMate D p.1) := Prod.ext rfl hmate
  rw [hp']
  exact (ascendingMatePair_mem_iff_active D t z s ht hterm p.1).mpr hact

/-- 非零項では、共通対は T の外の対で、反転対 (e, ι(e)) である。 -/
theorem taggedCommonPairs_long (z : Qbar) (s : SpinStructure)
    (ht : t ⊆ matchingOrientedPairs D)
    (hterm : matchingSignPolynomial D *
      ((-1 : Polynomial Qbar) ^ t.card *
        (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
        (∏ p ∈ t, gaugedShortContribution z s p)) ≠ 0)
    (p : OrientedEdge L × OrientedEdge L) (hp : p ∈ taggedCommonPairs D t) :
    ascendingPair p ∉ t ∧ p.2 = reversal p.1 := by
  obtain ⟨e, he, rfl⟩ := List.mem_map.mp hp
  have hinact := (Finset.mem_filter.mp ((Finset.mem_sort _).mp he)).2.1
  refine ⟨fun h => hinact ((ascendingMatePair_mem_iff_active D t z s ht hterm e).mp h), ?_⟩
  calc
    perfectMatchingMate D e = perfectMatchingMate (referenceLongMatching L) e :=
      (inactive_mate_eq_reference D t e hinact).1.symm
    _ = reversal e := referenceLongMate_eq_reversal e

/-- l の端点列は完全列挙である。閉路の対の端点列は閉路の点列に戻る（偶数長）。 -/
theorem taggedOrientationList_complete :
    IsCompleteWord (matchingPairWord (taggedOrientationList D t)) := by
  have hcycles : ((taggedCycleWords D t).map consecutivePairs).map matchingPairWord =
      taggedCycleWords D t := by
    rw [List.map_map]
    conv_rhs => rw [← List.map_id (taggedCycleWords D t)]
    apply List.map_congr_left
    intro c hc
    obtain ⟨m, _, rfl⟩ := List.mem_map.mp hc
    exact pairWord_consecutivePairs _ (taggedCyclePoints_even D t m).2
  unfold taggedOrientationList
  rw [matchingPairWord_append, matchingPairWord_flatten, hcycles]
  exact taggedCycleWords_complete D t

/-- l の各対は D の対である。 -/
theorem taggedOrientationList_pairs_D :
    ∀ p ∈ taggedOrientationList D t, ({p.1, p.2} : Set (OrientedEdge L)) ∈ D.val := by
  intro p hp
  rcases List.mem_append.mp hp with hcyc | hcom
  · obtain ⟨l, hl, hpl⟩ := List.mem_flatten.mp hcyc
    obtain ⟨c, hc, rfl⟩ := List.mem_map.mp hl
    obtain ⟨_, hmate⟩ := taggedCycle_pair_mate D t c hc p hpl
    rw [hmate]
    exact (perfectMatchingMate_spec D p.1).2
  · exact (taggedCommonPairs_spec D t p hcom).2.1

/-- l の η の積は閉路ごとの α_D(C) の積である。共通対は昇順なので η は一。 -/
theorem taggedOrientationList_orientation :
    ((taggedOrientationList D t).map pairOrientation).prod =
      ((taggedCycleWords D t).map cycleShortOrientation).prod := by
  have hcommon : ((taggedCommonPairs D t).map pairOrientation).prod = 1 := by
    apply List.prod_eq_one
    intro x hx
    obtain ⟨p, hp, rfl⟩ := List.mem_map.mp hx
    simp only [pairOrientation, if_pos (taggedCommonPairs_spec D t p hp).1]
  unfold taggedOrientationList
  rw [List.map_append, List.prod_append, hcommon, mul_one, List.map_flatten, List.prod_flatten,
    List.map_map, List.map_map]
  rfl

end Facts

/-- 本文の証明の冒頭の読み替え。非零項の寄与の積は、l の η の積と、閉路ごとの短い対
    (ι(w_r), w_{r+1}) の寄与の積と、共通対の長い寄与の積の積である。 -/
theorem taggedMatchingTerm_cycleWalk (z : Qbar) (hz : z ^ (4 : ℕ) = -1) (s : SpinStructure)
    (D : PerfectMatching (OrientedEdge L)) (t : Finset (OrientedEdge L × OrientedEdge L))
    (ht : t ⊆ matchingOrientedPairs D)
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
  rw [taggedMatchingTerm_oriented z hz s D t ht (taggedOrientationList D t)
    (taggedOrientationList_complete D t) (taggedOrientationList_pairs_D D t)]
  refine congrArg (HMul.hMul _) ?_
  have hcyc : ∀ c ∈ taggedCycleWords D t,
      ((consecutivePairs c).map (orientedTaggedContribution z s t)).prod =
        ((consecutivePairs c).map (gaugedShortContribution z s)).prod := by
    intro c hc
    congr 1
    apply List.map_congr_left
    intro p hp
    exact if_pos (taggedCycle_pairs_short D t z s ht hterm c hc p hp)
  have hcom : (taggedCommonPairs D t).map (orientedTaggedContribution z s t) =
      (taggedCommonPairs D t).map (gaugedLongContribution z s) := by
    apply List.map_congr_left
    intro p hp
    exact if_neg (taggedCommonPairs_long D t z s ht hterm p hp).1
  have hwalk : ∀ m ∈ (taggedCycleMinima D t).sort (· ≤ ·),
      ((consecutivePairs (taggedCyclePoints D t m)).map (gaugedShortContribution z s)).prod =
        ((List.range (taggedCycleLength D t m)).map (fun r =>
          gaugedShortContribution z s
            (reversal (taggedCycleWalk D t m r), taggedCycleWalk D t m (r + 1)))).prod := by
    intro m hm
    obtain ⟨i, _, rfl⟩ := Finset.mem_image.mp ((Finset.mem_sort _).mp hm)
    rw [(taggedCycle_pairs_walk D t i).1, List.map_map]
    rfl
  calc
    ((taggedOrientationList D t).map (orientedTaggedContribution z s t)).prod =
        (((taggedCycleWords D t).map (fun c =>
            ((consecutivePairs c).map (orientedTaggedContribution z s t)).prod)).prod) *
          ((taggedCommonPairs D t).map (orientedTaggedContribution z s t)).prod := by
      unfold taggedOrientationList
      rw [List.map_append, List.prod_append, List.map_flatten, List.prod_flatten, List.map_map,
        List.map_map]
      rfl
    _ = (((taggedCycleWords D t).map (fun c =>
            ((consecutivePairs c).map (gaugedShortContribution z s)).prod)).prod) *
          ((taggedCommonPairs D t).map (gaugedLongContribution z s)).prod := by
      rw [List.map_congr_left hcyc, hcom]
    _ = (((taggedCycleMinima D t).sort (· ≤ ·)).map (fun m =>
            ((List.range (taggedCycleLength D t m)).map (fun r =>
              gaugedShortContribution z s
                (reversal (taggedCycleWalk D t m r), taggedCycleWalk D t m (r + 1)))).prod)).prod *
          ((taggedCommonPairs D t).map (gaugedLongContribution z s)).prod := by
      unfold taggedCycleWords
      rw [List.map_map]
      exact congrArg (· * _) (congrArg List.prod (List.map_congr_left hwalk))

end ActualCycles

end Ising2DLambda.KacWard
