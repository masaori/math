/-
「非零項は閉歩道ごとのねじれ・回転位相の積に分かれる」（claim_tagged_matching_cycle_weight）の
具体版のうち、閉路ごとの合成（本文の主鎖の四等号）。向き直し（`taggedMatchingTerm_oriented`）と
閉歩道の辺による読み（`taggedMatchingTerm_cycleWalk`）で項を
C(∏η) · ∏_C ∏_r 𝖲(ι(w_r), w_{r+1}) · ∏_{共通対} 𝖫 と書いたものに、交互閉路による符号比較
（`taggedAlternatingCycles_matching_sign`）、対角変換因子の比（`alternating_cycle_gauge_ratio`）、
基準マッチングの長い対の重み（`referenceLong_gaugePairWeight`）を合わせる。

  人手証明                                              このファイル
  長い対 (e, ι(e)) の重みは昇順へ直す符号 η(e, ι(e))     `gaugePairWeight_reversal_orientation`
  （基準項が一であることの各対の形）
  共通対の長い寄与は一                                  `taggedCommonPairs_longContribution`
  非零項の短い寄与の条件（同じ始点の相異なる二辺）      `gaugedShortContribution_cond_of_ne_zero`
  (-1)^{|T|} = ∏_C (-1)^{k_C}（|T| = Σ_C k_C）           `neg_one_pow_card_cycles`
  α₀(C) を閉歩道の長い対の η で読む                     `cycleReferenceOrientation_walk`
  閉路ごとの比: 短い対の重みの積 = (-1)^{k_C} α₀(C)      `cycle_shortContribution_product`
  （主鎖の三行目）
  符号の整理 sgn(D)·∏α_D·∏(-1)^{k}·∏(-1)^{k}α₀ = (-1)^{|𝒞|}  `cycle_sign_bookkeeping`
  （主鎖の一・二・四行目。α² = 1、(-1)^{2k} = 1）
  本文の主張                                            `taggedMatchingTerm_cycleWeight`

本文の積 ∏_{r∈ℤ/k_C} ε(e_{C,r}) ρ(e_{C,r-1}, e_{C,r}) は、e_{C,r} = w_r、w_{k_C} = w_0 として
∏_{r<k_C} ε(w_{r+1}) ρ(w_r, w_{r+1}) と書く（添字を一つずらした同じ積）。
必要十分版は呼ばない。住処は有限集合・ℤ・Qbar・Qbar[x] で、ℝ / ℂ は現れない。
-/
import Ising2DLambda.KacWard.TaggedCyclePairWalk
import Ising2DLambda.KacWard.AlternatingCycleGaugeRatio

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
attribute [local instance] Classical.propDecidable

variable {L : ℕ}

/-- 列 range n の上の積は Finset.range n の上の積である。 -/
theorem list_range_map_prod {M : Type*} [CommMonoid M] (f : ℕ → M) :
    ∀ n : ℕ, ((List.range n).map f).prod = ∏ r ∈ Finset.range n, f r
  | 0 => rfl
  | n + 1 => by
      rw [List.range_succ, List.map_append, List.prod_append, list_range_map_prod f n,
        Finset.prod_range_succ]
      simp

/-- 長い対 (e, ι(e)) の重みは、その対を昇順へ直す符号 η(e, ι(e)) である。
    (e, 0) では基準の長い対の重み一（`referenceLong_gaugePairWeight`）、(e, 1) では係数の反対称性
    （`gaugeLongCoefficient_skew`）で負の一。 -/
theorem gaugePairWeight_reversal_orientation (z : Qbar) (hz : z ^ (4 : ℕ) = -1)
    (s : SpinStructure) (e : OrientedEdge L) :
    gaugePairWeight z s e (reversal e) = ((pairOrientation (e, reversal e) : ℤ) : Qbar) := by
  have hlt : ∀ d : PartitionPolynomial.Edge L, (referenceLongPair d).1 < (referenceLongPair d).2 :=
    fun d => referenceLongPair_lt d
  have hfalse : ∀ d : PartitionPolynomial.Edge L,
      gaugePairWeight z s (referenceLongPair d).1 (reversal (referenceLongPair d).1) =
        ((pairOrientation ((referenceLongPair d).1,
          reversal (referenceLongPair d).1) : ℤ) : Qbar) := by
    intro d
    calc
      gaugePairWeight z s (referenceLongPair d).1 (reversal (referenceLongPair d).1) =
          1 := referenceLong_gaugePairWeight z hz s d
      _ = _ := by
        have ho : pairOrientation ((referenceLongPair d).1, reversal (referenceLongPair d).1) = 1 :=
          if_pos (hlt d)
        rw [ho, Int.cast_one]
  have htrue : ∀ d : PartitionPolynomial.Edge L,
      gaugePairWeight z s (referenceLongPair d).2 (reversal (referenceLongPair d).2) =
        ((pairOrientation ((referenceLongPair d).2,
          reversal (referenceLongPair d).2) : ℤ) : Qbar) := by
    intro d
    have hskew := gaugeLongCoefficient_skew z hz s (referenceLongPair d).2
      (referenceLongPair d).1
    rw [if_pos (show (referenceLongPair d).1 = reversal (referenceLongPair d).2 from rfl),
      if_pos (show (referenceLongPair d).2 = reversal (referenceLongPair d).1 from rfl)] at hskew
    have h1 : gaugePairWeight z s (referenceLongPair d).1 (referenceLongPair d).2 = 1 :=
      referenceLong_gaugePairWeight z hz s d
    rw [h1] at hskew
    calc
      gaugePairWeight z s (referenceLongPair d).2 (reversal (referenceLongPair d).2) =
          -1 := hskew
      _ = _ := by
        have ho : pairOrientation ((referenceLongPair d).2, reversal (referenceLongPair d).2) = -1 :=
          if_neg (not_lt.mpr (hlt d).le)
        rw [ho, Int.cast_neg, Int.cast_one]
  obtain ⟨d, b⟩ := e
  cases b
  · exact hfalse d
  · exact htrue d

section ActualCycles

variable (D : PerfectMatching (OrientedEdge L)) (t : Finset (OrientedEdge L × OrientedEdge L))

/-- 共通対の長い寄与は一である。共通対は昇順の反転対 (e, ι(e)) だから。 -/
theorem taggedCommonPairs_longContribution (z : Qbar) (hz : z ^ (4 : ℕ) = -1)
    (s : SpinStructure) (ht : t ⊆ matchingOrientedPairs D)
    (hterm : matchingSignPolynomial D *
      ((-1 : Polynomial Qbar) ^ t.card *
        (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
        (∏ p ∈ t, gaugedShortContribution z s p)) ≠ 0) :
    ((taggedCommonPairs D t).map (gaugedLongContribution z s)).prod = 1 := by
  apply List.prod_eq_one
  intro x hx
  obtain ⟨p, hp, rfl⟩ := List.mem_map.mp hx
  have hrev := (taggedCommonPairs_long D t z s ht hterm p hp).2
  have hlt := (taggedCommonPairs_spec D t p hp).1
  have hp' : p = (p.1, reversal p.1) := Prod.ext rfl hrev
  calc
    gaugedLongContribution z s p = qbarConst (gaugePairWeight z s p.1 (reversal p.1)) := by
      rw [gaugedLongContribution, if_pos hrev, hrev]
    _ = qbarConst ((pairOrientation (p.1, reversal p.1) : ℤ) : Qbar) := by
      rw [gaugePairWeight_reversal_orientation z hz s p.1]
    _ = 1 := by
      rw [← hp', pairOrientation, if_pos hlt, Int.cast_one, qbarConst, Polynomial.C_1]

end ActualCycles

/-- 短い寄与が零でなければ、対の二辺は同じ始点の相異なる辺である。 -/
theorem gaugedShortContribution_cond_of_ne_zero (z : Qbar) (s : SpinStructure)
    (p : OrientedEdge L × OrientedEdge L) (h : gaugedShortContribution z s p ≠ 0) :
    orientedSource p.2 = orientedSource p.1 ∧ p.2 ≠ p.1 := by
  by_contra hc
  apply h
  rw [gaugedShortContribution, if_neg hc, qbarConst, Polynomial.C_0, mul_zero]

/-- 昇順へ直した対の短い寄与が零でなければ、元の向きの短い寄与も零でない。 -/
theorem gaugedShortContribution_ne_zero_of_ascending (z : Qbar) (hz : z ^ (4 : ℕ) = -1)
    (s : SpinStructure) (p : OrientedEdge L × OrientedEdge L)
    (h : gaugedShortContribution z s (ascendingPair p) ≠ 0) :
    gaugedShortContribution z s p ≠ 0 := by
  unfold ascendingPair at h
  split_ifs at h
  · exact h
  · intro h0
    apply h
    rw [gaugedShortContribution_swap z hz s p, h0, neg_zero]

/-- 閉路ごとの比（本文の主鎖の三行目）。閉じた辺列 w（w_{n+1} = w_0）の短い対 (ι(w_r), w_{r+1}) の
    寄与の積は、(-1)^{n+1} と長い対の η の積と、X^{n+1} とねじれ・回転位相の積の積である。
    短い対の重みの積を対角変換因子の比（`alternating_cycle_gauge_ratio`）で長い対の重みの積へ移し、
    長い対の重みを η で読む（`gaugePairWeight_reversal_orientation`）。 -/
theorem cycle_shortContribution_product (z : Qbar) (hz : z ^ (4 : ℕ) = -1) (s : SpinStructure)
    (n : ℕ) (w : ℕ → OrientedEdge L) (hper : w (n + 1) = w 0)
    (hne : ∀ r < n + 1, gaugedShortContribution z s (reversal (w r), w (r + 1)) ≠ 0) :
    ((List.range (n + 1)).map
        (fun r => gaugedShortContribution z s (reversal (w r), w (r + 1)))).prod =
      qbarConst ((((-1 : ℤ) ^ (n + 1) *
          ∏ r ∈ Finset.range (n + 1), pairOrientation (w r, reversal (w r)) : ℤ) : Qbar)) *
        (Polynomial.X ^ (n + 1) *
          qbarConst (∏ r ∈ Finset.range (n + 1),
            (twistSign s (w (r + 1)) : Qbar) * rotationPhase z (w r) (w (r + 1)))) := by
  let γ : Fin (n + 1) → OrientedEdge L := fun r => w r.val
  have hγ : ∀ r : Fin (n + 1), w (r.val + 1) = γ (r + 1) := by
    intro r
    simp only [γ, Fin.val_add_one]
    split_ifs with h
    · rw [h, Fin.val_last, hper]
    · rfl
  -- 短い対の重みの積を γ の巡回の添字で読み、比の主張へ渡す
  have hweight : ∏ r ∈ Finset.range (n + 1), gaugePairWeight z s (reversal (w r)) (w (r + 1)) =
      ((((-1 : ℤ) ^ (n + 1) *
          ∏ r ∈ Finset.range (n + 1), pairOrientation (w r, reversal (w r)) : ℤ) : Qbar)) := by
    calc
      ∏ r ∈ Finset.range (n + 1), gaugePairWeight z s (reversal (w r)) (w (r + 1)) =
          ∏ r : Fin (n + 1), gaugePairWeight z s (reversal (γ r)) (γ (r + 1)) := by
        rw [← Fin.prod_univ_eq_prod_range]
        exact Finset.prod_congr rfl fun r _ => by rw [hγ r]
      _ = ∏ r : Fin (n + 1), gaugePairWeight z s (reversal (γ (r - 1))) (γ r) := by
        rw [← prod_fin_cyclic_pred (fun r => gaugePairWeight z s (reversal (γ r)) (γ (r + 1)))]
        simp only [sub_add_cancel]
      _ = (-1) ^ (n + 1) * ∏ r : Fin (n + 1), gaugePairWeight z s (γ r) (reversal (γ r)) :=
        alternating_cycle_gauge_ratio z hz s γ
      _ = (-1) ^ (n + 1) * ∏ r : Fin (n + 1),
            ((pairOrientation (γ r, reversal (γ r)) : ℤ) : Qbar) := by
        rw [Finset.prod_congr rfl fun r _ => gaugePairWeight_reversal_orientation z hz s (γ r)]
      _ = (-1) ^ (n + 1) * ∏ r ∈ Finset.range (n + 1),
            ((pairOrientation (w r, reversal (w r)) : ℤ) : Qbar) := by
        rw [Fin.prod_univ_eq_prod_range (fun r => ((pairOrientation (w r, reversal (w r)) : ℤ) : Qbar))]
      _ = ((((-1 : ℤ) ^ (n + 1) *
            ∏ r ∈ Finset.range (n + 1), pairOrientation (w r, reversal (w r)) : ℤ) : Qbar)) := by
        push_cast
        rfl
  calc
    ((List.range (n + 1)).map
        (fun r => gaugedShortContribution z s (reversal (w r), w (r + 1)))).prod =
        ∏ r ∈ Finset.range (n + 1), (Polynomial.X *
          (qbarConst (gaugePairWeight z s (reversal (w r)) (w (r + 1))) *
            qbarConst ((twistSign s (w (r + 1)) : Qbar) * rotationPhase z (w r) (w (r + 1))))) := by
      rw [list_range_map_prod]
      refine Finset.prod_congr rfl fun r hr => ?_
      have hc := gaugedShortContribution_cond_of_ne_zero z s _
        (hne r (Finset.mem_range.mp hr))
      rw [gaugedShortContribution, if_pos hc, reversal_involutive, qbarConst, qbarConst, qbarConst,
        Polynomial.C_mul]
    _ = Polynomial.X ^ (n + 1) *
          (qbarConst (∏ r ∈ Finset.range (n + 1),
              gaugePairWeight z s (reversal (w r)) (w (r + 1))) *
            qbarConst (∏ r ∈ Finset.range (n + 1),
              (twistSign s (w (r + 1)) : Qbar) * rotationPhase z (w r) (w (r + 1)))) := by
      rw [Finset.prod_mul_distrib, Finset.prod_mul_distrib, Finset.prod_const, Finset.card_range,
        qbarConst, qbarConst, map_prod, map_prod]
      rfl
    _ = _ := by
      rw [hweight]
      ring

section ActualTerm

variable (D : PerfectMatching (OrientedEdge L)) (t : Finset (OrientedEdge L × OrientedEdge L))

/-- 閉路の点列の偶数番目の次の点はその反転である（奇数回目の一歩は 𝒟₀ の相手）。 -/
theorem taggedCycle_odd_step (i : TaggedActive D t) (r : ℕ) :
    let m := matchingPairComponentMinimum (concreteShortInvolution D t)
      (concreteLongInvolution D t) i
    (finiteMapIterate (concreteAlternatingSuccessor D t) (2 * r + 2) m).1 =
      reversal (finiteMapIterate (concreteAlternatingSuccessor D t) (2 * r + 1) m).1 := by
  intro m
  have hcolor := (cycleMinimum_self_and_color D t i).2
  have hodd : ¬ finiteMapIterate (concreteAlternatingSuccessor D t) (2 * r + 1) m ∈
      matchingPairColor (concreteShortInvolution D t) (concreteLongInvolution D t) := by
    rw [iterate_color_parity D t m hcolor (2 * r + 1)]
    exact Nat.not_even_iff_odd.mpr (odd_two_mul_add_one r)
  rw [iterate_succ_val D t m (2 * r + 1), if_neg hodd]
  exact referenceLongMate_eq_reversal _

/-- 閉路の長さは正である。 -/
theorem taggedCycleLength_pos (m : TaggedActive D t) : 0 < taggedCycleLength D t m := by
  obtain ⟨hpos, ⟨k, hk⟩, _⟩ := taggedCycle_period D t m
  unfold taggedCycleLength
  omega

/-- α₀(C) を射影した閉歩道の長い対 (w_r, ι(w_r)) の η で読む。𝒟₀ の対 (c(2r+1), c(2r+2)) は
    (w_{r+1}, ι(w_{r+1})) で、w_{k_C} = w_0 により添字を一つ戻せる。 -/
theorem cycleReferenceOrientation_walk (i : TaggedActive D t) :
    let m := matchingPairComponentMinimum (concreteShortInvolution D t)
      (concreteLongInvolution D t) i
    cycleReferenceOrientation (taggedCyclePoints D t m) =
      ∏ r ∈ Finset.range (taggedCycleLength D t m),
        pairOrientation (taggedCycleWalk D t m r, reversal (taggedCycleWalk D t m r)) := by
  intro m
  obtain ⟨hpos, ⟨k, hk⟩, hper⟩ := taggedCycle_period D t m
  have hk2 : finitePermutationMinimalPeriod (concreteAlternatingSuccessor D t) m = 2 * k := by
    omega
  have hlen : taggedCycleLength D t m = k := by
    unfold taggedCycleLength
    omega
  let f : ℕ → OrientedEdge L := fun r => (finiteMapIterate (concreteAlternatingSuccessor D t) r m).1
  let G : ℕ → ℤ := fun r =>
    pairOrientation (taggedCycleWalk D t m r, reversal (taggedCycleWalk D t m r))
  have hfper : f (2 * k) = f 0 := by
    simp only [f]
    rw [← hk2, hper]
    rfl
  have hodd : ∀ r, f (2 * r + 1) = taggedCycleWalk D t m (r + 1) := by
    intro r
    simp only [f, taggedCycleWalk]
    rw [show 2 * (r + 1) = 2 * r + 2 by ring, taggedCycle_odd_step D t i r, reversal_involutive]
  have heven : ∀ r, f (2 * r + 1 + 1) = reversal (taggedCycleWalk D t m (r + 1)) := by
    intro r
    simp only [f, taggedCycleWalk]
    rw [reversal_involutive, show 2 * r + 1 + 1 = 2 * (r + 1) by ring]
  have hwalk := (taggedCycle_pairs_walk D t i).2
  rw [hlen] at hwalk
  have hG : G k = G 0 := congrArg (fun x => pairOrientation (x, reversal x)) hwalk
  have hG0 : G 0 ≠ 0 := by
    simp only [G, pairOrientation]
    split_ifs <;> decide
  have hshift : ∏ r ∈ Finset.range k, G (r + 1) = ∏ r ∈ Finset.range k, G r := by
    have h := (Finset.prod_range_succ' G k).symm.trans (Finset.prod_range_succ G k)
    rw [hG] at h
    exact mul_right_cancel₀ hG0 h
  calc
    cycleReferenceOrientation (taggedCyclePoints D t m) =
        ((consecutivePairs (((List.range (2 * k)).map f).rotate 1)).map pairOrientation).prod := by
      unfold cycleReferenceOrientation taggedCyclePoints
      rw [hk2]
    _ = ((consecutivePairs ((List.range (2 * k)).map (fun r => f (r + 1)))).map
          pairOrientation).prod := by
      rw [rotate_one_map_range (2 * k) f (by omega) hfper]
    _ = ((List.range k).map (fun r => pairOrientation (f (2 * r + 1), f (2 * r + 1 + 1)))).prod := by
      rw [consecutivePairs_map_range, List.map_map]
      rfl
    _ = ∏ r ∈ Finset.range k, G (r + 1) := by
      rw [list_range_map_prod]
      exact Finset.prod_congr rfl fun r _ => by simp only [G, hodd, heven]
    _ = ∏ r ∈ Finset.range (taggedCycleLength D t m), G r := by rw [hshift, hlen]

variable {D t}

/-- (-1)^{|T|} は閉路ごとの (-1)^{k_C} の積である（本文の |T| = Σ_C k_C）。t の各元を向き直しの列で
    一度ずつ数え、閉路の対は短い標識、共通対は長い標識であることを使う。 -/
theorem neg_one_pow_card_cycles (z : Qbar) (s : SpinStructure)
    (ht : t ⊆ matchingOrientedPairs D)
    (hterm : matchingSignPolynomial D *
      ((-1 : Polynomial Qbar) ^ t.card *
        (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
        (∏ p ∈ t, gaugedShortContribution z s p)) ≠ 0) :
    (-1 : Polynomial Qbar) ^ t.card =
      (((taggedCycleMinima D t).sort (· ≤ ·)).map
        (fun m => (-1 : Polynomial Qbar) ^ taggedCycleLength D t m)).prod := by
  let F : OrientedEdge L × OrientedEdge L → Polynomial Qbar := fun q => if q ∈ t then -1 else 1
  have hen := ascendingPairs_enumeration D (taggedOrientationList D t)
    (taggedOrientationList_complete D t) (taggedOrientationList_pairs_D D t)
  have hfin : matchingOrientedPairs D = ((taggedOrientationList D t).map ascendingPair).toFinset := by
    ext q
    rw [List.mem_toFinset]
    exact (hen.2 q).symm
  have hcyc : ∀ m ∈ (taggedCycleMinima D t).sort (· ≤ ·),
      ((consecutivePairs (taggedCyclePoints D t m)).map (fun p => F (ascendingPair p))).prod =
        (-1 : Polynomial Qbar) ^ taggedCycleLength D t m := by
    intro m hm
    have hmw : taggedCyclePoints D t m ∈ taggedCycleWords D t :=
      List.mem_map.mpr ⟨m, (Finset.mem_sort _).mpr ((Finset.mem_sort _).mp hm), rfl⟩
    obtain ⟨i, _, rfl⟩ := Finset.mem_image.mp ((Finset.mem_sort _).mp hm)
    rw [List.map_congr_left (fun p hp =>
        (if_pos (taggedCycle_pairs_short D t z s ht hterm _ hmw p hp) :
          F (ascendingPair p) = -1)),
      List.map_const', List.prod_replicate, (taggedCycle_pairs_walk D t i).1, List.length_map,
      List.length_range]
  have hcom : ((taggedCommonPairs D t).map (fun p => F (ascendingPair p))).prod = 1 := by
    apply List.prod_eq_one
    intro x hx
    obtain ⟨p, hp, rfl⟩ := List.mem_map.mp hx
    exact if_neg (taggedCommonPairs_long D t z s ht hterm p hp).1
  calc
    (-1 : Polynomial Qbar) ^ t.card = ∏ q ∈ t, (-1 : Polynomial Qbar) := (Finset.prod_const _).symm
    _ = ∏ q ∈ matchingOrientedPairs D, F q := by
      rw [Finset.prod_ite_mem, Finset.inter_eq_right.mpr ht]
    _ = (((taggedOrientationList D t).map ascendingPair).map F).prod := by
      rw [hfin, List.prod_toFinset _ hen.1]
    _ = (((taggedCycleMinima D t).sort (· ≤ ·)).map (fun m =>
          ((consecutivePairs (taggedCyclePoints D t m)).map (fun p => F (ascendingPair p))).prod)).prod *
          ((taggedCommonPairs D t).map (fun p => F (ascendingPair p))).prod := by
      unfold taggedOrientationList taggedCycleWords
      simp only [List.map_map, List.map_append, List.prod_append, List.map_flatten,
        List.prod_flatten, Function.comp_def]
    _ = _ := by rw [List.map_congr_left hcyc, hcom, mul_one]

end ActualTerm

/-- 符号の整理（本文の主鎖の一・二・四行目）。sgn(D)·sgn(𝒟₀) = (-1)^{|𝒞|}∏α_D α₀、sgn(𝒟₀) = 1、
    α_D² = α₀² = 1、((-1)^k)² = 1 から、sgn(D)·∏(-1)^{k}·∏α_D·∏((-1)^{k}α₀) = (-1)^{|𝒞|}。 -/
theorem cycle_sign_bookkeeping {ι : Type*} (l : List ι) (sD : ℤ) (k : ι → ℕ) (aD a0 : ι → ℤ)
    (hsign : sD = (-1) ^ l.length * (l.map (fun m => aD m * a0 m)).prod)
    (hD : ∀ m ∈ l, aD m * aD m = 1) (h0 : ∀ m ∈ l, a0 m * a0 m = 1) :
    sD * (l.map (fun m => (-1 : ℤ) ^ k m)).prod * (l.map aD).prod *
        (l.map (fun m => (-1 : ℤ) ^ k m * a0 m)).prod = (-1) ^ l.length := by
  have hone : (l.map (fun m => aD m * a0 m * (-1 : ℤ) ^ k m * aD m * ((-1 : ℤ) ^ k m * a0 m))).prod
      = 1 := by
    apply List.prod_eq_one
    intro x hx
    obtain ⟨m, hm, rfl⟩ := List.mem_map.mp hx
    calc
      aD m * a0 m * (-1 : ℤ) ^ k m * aD m * ((-1 : ℤ) ^ k m * a0 m) =
          (aD m * aD m) * (a0 m * a0 m) * ((-1 : ℤ) ^ k m * (-1) ^ k m) := by ring
      _ = 1 := by rw [hD m hm, h0 m hm, ← mul_pow]; norm_num
  rw [hsign]
  simp only [List.prod_map_mul] at hone
  calc
    (-1) ^ l.length * (l.map (fun m => aD m * a0 m)).prod *
          (l.map (fun m => (-1 : ℤ) ^ k m)).prod * (l.map aD).prod *
          (l.map (fun m => (-1 : ℤ) ^ k m * a0 m)).prod =
        (-1) ^ l.length * ((l.map aD).prod * (l.map a0).prod * (l.map (fun m => (-1 : ℤ) ^ k m)).prod *
          (l.map aD).prod * ((l.map (fun m => (-1 : ℤ) ^ k m)).prod * (l.map a0).prod)) := by
      simp only [List.prod_map_mul]
      ring
    _ = (-1) ^ l.length := by rw [hone, mul_one]

/-- 昇順へ直す符号の列の積は ±1 である。 -/
theorem pairOrientation_list_prod_sq {J : Type*} [LinearOrder J] (l : List (J × J)) :
    (l.map pairOrientation).prod * (l.map pairOrientation).prod = 1 := by
  apply Int.isUnit_mul_self
  apply List.prod_isUnit
  intro x hx
  obtain ⟨p, _, rfl⟩ := List.mem_map.mp hx
  unfold pairOrientation
  split_ifs
  · exact isUnit_one
  · exact isUnit_one.neg

/-- 閉路のねじれ符号・回転位相の積 ∏_{r<k_C} ε(w_{r+1}) ρ(w_r, w_{r+1})。 -/
noncomputable def taggedCyclePhase (z : Qbar) (s : SpinStructure) (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L)) (m : TaggedActive D t) : Qbar :=
  ∏ r ∈ Finset.range (taggedCycleLength D t m),
    (twistSign s (taggedCycleWalk D t m (r + 1)) : Qbar) *
      rotationPhase z (taggedCycleWalk D t m r) (taggedCycleWalk D t m (r + 1))

/-- 閉歩道の長い対 (w_r, ι(w_r)) の η の積（`cycleReferenceOrientation_walk` により α₀(C)）。 -/
noncomputable def taggedCycleWalkOrientation (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L)) (m : TaggedActive D t) : ℤ :=
  ∏ r ∈ Finset.range (taggedCycleLength D t m),
    pairOrientation (taggedCycleWalk D t m r, reversal (taggedCycleWalk D t m r))

/-- 本文の主張。非零項 (D, T) の項は、交互閉路ごとの -X^{k_C} と、射影した閉歩道の
    ねじれ符号・回転位相の積 ∏_r ε(w_{r+1}) ρ(w_r, w_{r+1}) の積に等しい。 -/
theorem taggedMatchingTerm_cycleWeight (z : Qbar) (hz : z ^ (4 : ℕ) = -1) (s : SpinStructure)
    (D : PerfectMatching (OrientedEdge L)) (t : Finset (OrientedEdge L × OrientedEdge L))
    (ht : t ⊆ matchingOrientedPairs D)
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
  have hmin : ∀ m ∈ (taggedCycleMinima D t).sort (· ≤ ·), ∃ i,
      matchingPairComponentMinimum (concreteShortInvolution D t) (concreteLongInvolution D t) i = m := by
    intro m hm
    obtain ⟨i, _, hi⟩ := Finset.mem_image.mp ((Finset.mem_sort _).mp hm)
    exact ⟨i, hi⟩
  -- 閉路ごとの比
  have hP : ∀ m ∈ (taggedCycleMinima D t).sort (· ≤ ·),
      ((List.range (taggedCycleLength D t m)).map (fun r =>
          gaugedShortContribution z s
            (reversal (taggedCycleWalk D t m r), taggedCycleWalk D t m (r + 1)))).prod =
        ((((-1 : ℤ) ^ taggedCycleLength D t m * taggedCycleWalkOrientation D t m : ℤ) :
            Polynomial Qbar)) *
          (Polynomial.X ^ taggedCycleLength D t m * qbarConst (taggedCyclePhase z s D t m)) := by
    intro m hm
    have hmw : taggedCyclePoints D t m ∈ taggedCycleWords D t :=
      List.mem_map.mpr ⟨m, (Finset.mem_sort _).mpr ((Finset.mem_sort _).mp hm), rfl⟩
    obtain ⟨i, rfl⟩ := hmin m hm
    set m0 := matchingPairComponentMinimum (concreteShortInvolution D t)
      (concreteLongInvolution D t) i with hm0
    obtain ⟨n, hn⟩ := Nat.exists_eq_add_of_lt (taggedCycleLength_pos D t m0)
    rw [zero_add] at hn
    have hwalk := taggedCycle_pairs_walk D t i
    have hper := hwalk.2
    rw [hn] at hper
    have hne : ∀ r < n + 1, gaugedShortContribution z s
        (reversal (taggedCycleWalk D t m0 r), taggedCycleWalk D t m0 (r + 1)) ≠ 0 := by
      intro r hr
      have hp : (reversal (taggedCycleWalk D t m0 r), taggedCycleWalk D t m0 (r + 1)) ∈
          consecutivePairs (taggedCyclePoints D t m0) := by
        rw [hwalk.1]
        exact List.mem_map.mpr ⟨r, List.mem_range.mpr (lt_of_lt_of_eq hr hn.symm), rfl⟩
      apply gaugedShortContribution_ne_zero_of_ascending z hz s
      have hshort := taggedCycle_pairs_short D t z s ht hterm _ hmw _ hp
      have hB : (∏ p ∈ t, gaugedShortContribution z s p) ≠ 0 :=
        right_ne_zero_of_mul (right_ne_zero_of_mul hterm)
      exact Finset.prod_ne_zero_iff.mp hB _ hshort
    unfold taggedCycleWalkOrientation taggedCyclePhase
    rw [hn, cycle_shortContribution_product z hz s n _ hper hne, qbarConst,
      Polynomial.C_eq_intCast]
  -- 項を閉路の比と共通対で読む
  have hsplit := taggedMatchingTerm_cycleWalk z hz s D t ht hterm
  rw [taggedOrientationList_orientation D t, List.map_congr_left hP,
    taggedCommonPairs_longContribution D t z hz s ht hterm, mul_one, List.prod_map_mul] at hsplit
  have hcard := neg_one_pow_card_cycles z s ht hterm
  -- 符号の整理
  have hsignD := (taggedAlternatingCycles_matching_sign D t).2
  rw [referenceLongMatching_sign, mul_one] at hsignD
  set Sm := (taggedCycleMinima D t).sort (· ≤ ·) with hSm
  have hlenSm : (taggedCycleMinima D t).card = Sm.length := (Finset.length_sort _).symm
  rw [hlenSm] at hsignD
  have hwords : ((taggedCycleWords D t).map cycleShortOrientation).prod =
      (Sm.map (fun m => cycleShortOrientation (taggedCyclePoints D t m))).prod := by
    unfold taggedCycleWords
    rw [List.map_map]
    rfl
  have hZ : (perfectMatchingSign D : ℤ) * (Sm.map (fun m => (-1 : ℤ) ^ taggedCycleLength D t m)).prod *
      (Sm.map (fun m => cycleShortOrientation (taggedCyclePoints D t m))).prod *
      (Sm.map (fun m => (-1 : ℤ) ^ taggedCycleLength D t m * taggedCycleWalkOrientation D t m)).prod =
        (-1) ^ Sm.length := by
    have ha0 : Sm.map (fun m => (-1 : ℤ) ^ taggedCycleLength D t m * taggedCycleWalkOrientation D t m) =
        Sm.map (fun m => (-1 : ℤ) ^ taggedCycleLength D t m *
          cycleReferenceOrientation (taggedCyclePoints D t m)) := by
      apply List.map_congr_left
      intro m hm
      obtain ⟨i, rfl⟩ := hmin m hm
      rw [taggedCycleWalkOrientation, cycleReferenceOrientation_walk D t i]
    rw [ha0]
    apply cycle_sign_bookkeeping Sm _ (taggedCycleLength D t)
      (fun m => cycleShortOrientation (taggedCyclePoints D t m))
      (fun m => cycleReferenceOrientation (taggedCyclePoints D t m))
    · rw [hsignD]
      unfold taggedCycleWords
      rw [List.map_map]
      rfl
    · intro m _
      exact pairOrientation_list_prod_sq _
    · intro m _
      exact pairOrientation_list_prod_sq _
  let Y : TaggedActive D t → Polynomial Qbar := fun m =>
    Polynomial.X ^ taggedCycleLength D t m * qbarConst (taggedCyclePhase z s D t m)
  have hcast : ∀ a : ℤ, qbarConst ((a : ℤ) : Qbar) = ((a : ℤ) : Polynomial Qbar) := fun a =>
    Polynomial.C_eq_intCast a
  calc
    matchingSignPolynomial D *
        ((-1 : Polynomial Qbar) ^ t.card *
          (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
          (∏ p ∈ t, gaugedShortContribution z s p)) =
        ((perfectMatchingSign D : ℤ) : Polynomial Qbar) *
          ((Sm.map (fun m => (-1 : Polynomial Qbar) ^ taggedCycleLength D t m)).prod *
          (((Sm.map (fun m => cycleShortOrientation (taggedCyclePoints D t m))).prod : ℤ) :
            Polynomial Qbar) *
          ((Sm.map (fun m => ((((-1 : ℤ) ^ taggedCycleLength D t m *
            taggedCycleWalkOrientation D t m : ℤ) : Polynomial Qbar)))).prod *
          (Sm.map Y).prod)) := by
      rw [mul_assoc ((-1 : Polynomial Qbar) ^ t.card), hsplit, hcard, hwords, matchingSignPolynomial,
        Polynomial.C_eq_intCast, hcast]
      ring
    _ = ((((perfectMatchingSign D : ℤ) * (Sm.map (fun m => (-1 : ℤ) ^ taggedCycleLength D t m)).prod *
          (Sm.map (fun m => cycleShortOrientation (taggedCyclePoints D t m))).prod *
          (Sm.map (fun m => (-1 : ℤ) ^ taggedCycleLength D t m *
            taggedCycleWalkOrientation D t m)).prod : ℤ)) : Polynomial Qbar) *
          (Sm.map Y).prod := by
      simp only [Int.cast_mul, Int.cast_list_prod, List.map_map, Function.comp_def, Int.cast_pow,
        Int.cast_neg, Int.cast_one]
      ring
    _ = (((-1 : ℤ) ^ Sm.length : ℤ) : Polynomial Qbar) * (Sm.map Y).prod := by rw [hZ]
    _ = (Sm.map (fun m => (-1 : Polynomial Qbar) * Y m)).prod := by
      rw [show (Sm.map (fun m => (-1 : Polynomial Qbar) * Y m)).prod =
          (Sm.map (fun _ => (-1 : Polynomial Qbar))).prod * (Sm.map Y).prod from List.prod_map_mul,
        List.map_const', List.prod_replicate]
      push_cast
      rfl
    _ = _ := by
      apply congrArg List.prod
      apply List.map_congr_left
      intro m _
      simp only [Y, taggedCyclePhase]
      ring

end Ising2DLambda.KacWard
