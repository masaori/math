/-
「非零項の位相は補辺の二次符号と短い対の横断数に等しい」（`claim_tagged_matching_quadratic_crossing_weight`）の
具体版のうち、証明の一つ目の式

  `t(D,T) = Σ_C c_C + Σ_{C<C'} c_mut(γ_C, γ_C')`

を示す段。実際の非零項 `(D, T)` の短い標識の対の横断対の個数 `t(D,T)`（`shortPairCrossingNumber`）を定め、
閉路ごとの辺列 `γ_C`（`taggedCycleFinWalk`。閉路は最小元 `m ∈ taggedCycleMinima` で表す）の横断数
`closedWalkCrossingNumber` と二閉路間の混合横断数 `closedWalkMutualCrossingNumber` の和に等しいことを示す。

  人手証明                                               このファイル
  短い対 p の通過（向きに依らない）                        `shortPairsTransverse`・
                                                         `shortPairsTransverse_ascendingPair_left/right`
  横断対の個数 t(D,T)（順序のない対）                      `shortPairCrossingNumber`
  短い標識の対は閉路の通過に一対一に対応する
  （claim_projected_edge_cycle_nonbacktracking）            `taggedCycleShortPair`・
                                                         `taggedCycleShortPair_mem`・
                                                         `taggedCycleShortPair_injOn`・
                                                         `taggedCycleShortPair_surj`
  横断する対は同じ閉路内のものと二閉路間のものに
  重複なく分かれる                                        `cycleIndexPairs_split`
  同じ閉路内の対の個数は c_C（def_closed_walk_crossing_number）
                                                         `cycleSelfCross_eq_crossingNumber`
  二閉路間の対の個数は c_mut                               `cycleMutualCross_eq_mutualCrossingNumber`
  本文の式                                               `shortPairCrossingNumber_cycleSplit`

順序のない対は、第一成分の小さい側を先に置いた対で数える。分割の等式は、どの順序のない対の数え上げも
相異なる順序付き対の個数の半分であること（`card_ne_pairs_eq_two_mul_key`）を通して、閉路の添字の順序へ
移して示す。住処は有限集合と `ℕ` で、ℝ / ℂ は現れない。必要十分版を呼ばない。
-/
import Ising2DLambda.KacWard.TaggedCycleQuadraticSign
import Ising2DLambda.KacWard.DisjointWalkMutualCrossing

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open scoped Classical

section Counting

/-- 対称な重みの、相異なる順序付き対にわたる和は、鍵の小さい側を先に置いた対にわたる和の二倍である。
    順序のない対を代表で数えるときの、代表の取り方によらないことの根拠。 -/
theorem sum_ne_pairs_eq_two_mul_key {ι β : Type*} [DecidableEq ι] [LinearOrder β]
    (s : Finset ι) (f : ι → β) (hf : Set.InjOn f s) (G : ι → ι → ℕ)
    (hG : ∀ a b, G a b = G b a) :
    ∑ p ∈ (s ×ˢ s).filter (fun p => p.1 ≠ p.2), G p.1 p.2 =
      2 * ∑ p ∈ (s ×ˢ s).filter (fun p => f p.1 < f p.2), G p.1 p.2 := by
  have hsplit : (s ×ˢ s).filter (fun p => p.1 ≠ p.2) =
      (s ×ˢ s).filter (fun p => f p.1 < f p.2) ∪ (s ×ˢ s).filter (fun p => f p.2 < f p.1) := by
    ext p
    simp only [Finset.mem_union, Finset.mem_filter, Finset.mem_product]
    constructor
    · rintro ⟨⟨h1, h2⟩, hne⟩
      rcases lt_or_gt_of_ne (fun h => hne (hf h1 h2 h)) with h | h
      · exact Or.inl ⟨⟨h1, h2⟩, h⟩
      · exact Or.inr ⟨⟨h1, h2⟩, h⟩
    · rintro (⟨hm, h⟩ | ⟨hm, h⟩)
      · exact ⟨hm, fun he => (ne_of_lt h) (by rw [he])⟩
      · exact ⟨hm, fun he => (ne_of_lt h) (by rw [he])⟩
  have hdisj : Disjoint ((s ×ˢ s).filter (fun p => f p.1 < f p.2))
      ((s ×ˢ s).filter (fun p => f p.2 < f p.1)) := by
    rw [Finset.disjoint_left]
    intro p hp hq
    exact lt_asymm (Finset.mem_filter.mp hp).2 (Finset.mem_filter.mp hq).2
  have hswap : ∑ p ∈ (s ×ˢ s).filter (fun p => f p.2 < f p.1), G p.1 p.2 =
      ∑ p ∈ (s ×ˢ s).filter (fun p => f p.1 < f p.2), G p.1 p.2 := by
    refine Finset.sum_nbij' Prod.swap Prod.swap ?_ ?_ ?_ ?_ ?_
    · intro p hp
      simp only [Finset.mem_filter, Finset.mem_product, Prod.fst_swap,
        Prod.snd_swap] at hp ⊢
      exact ⟨⟨hp.1.2, hp.1.1⟩, hp.2⟩
    · intro p hp
      simp only [Finset.mem_filter, Finset.mem_product, Prod.fst_swap,
        Prod.snd_swap] at hp ⊢
      exact ⟨⟨hp.1.2, hp.1.1⟩, hp.2⟩
    · intro p _
      exact Prod.swap_swap p
    · intro p _
      exact Prod.swap_swap p
    · intro p _
      exact hG p.1 p.2
  rw [hsplit, Finset.sum_union hdisj, hswap, two_mul]

/-- 対称な関係について、相異なる順序付き対の個数は、鍵の小さい側を先に置いた対の個数の二倍である。 -/
theorem card_ne_pairs_eq_two_mul_key {ι β : Type*} [DecidableEq ι] [LinearOrder β]
    (s : Finset ι) (f : ι → β) (hf : Set.InjOn f s) (r : ι → ι → Prop)
    (hr : ∀ a b, r a b → r b a) :
    ((s ×ˢ s).filter (fun p => p.1 ≠ p.2 ∧ r p.1 p.2)).card =
      2 * ((s ×ˢ s).filter (fun p => f p.1 < f p.2 ∧ r p.1 p.2)).card := by
  have h := sum_ne_pairs_eq_two_mul_key s f hf (fun a b => if r a b then 1 else 0)
    (fun a b => by
      by_cases hab : r a b
      · rw [if_pos hab, if_pos (hr a b hab)]
      · have hba : ¬ r b a := fun h => hab (hr b a h)
        rw [if_neg hab, if_neg hba])
  simp only [Finset.sum_boole, Nat.cast_id, Finset.filter_filter] at h
  exact h

end Counting

variable {L : ℕ}

/-- 一つの通過を逆に通っても、横断の条件は変わらない: 短い対 `{x, y}` の通過を `(ι(x), y)` と
    `(ι(y), x)` のどちらに取っても横断するかは同じ（第一の通過の側）。 -/
theorem edgeTransverseCrossing_reverse_left [NeZero L] (x y e f : OrientedEdge L)
    (h : edgeTransverseCrossing (reversal x) y e f) :
    edgeTransverseCrossing (reversal y) x e f := by
  obtain ⟨hy, hf, htgt, hst, hst', hax⟩ := h
  have hsrc : ∀ a : OrientedEdge L, orientedTarget (reversal a) = orientedSource a := by
    intro a
    rcases a with ⟨_, _ | _⟩ <;> rfl
  have hy' := Finset.mem_filter.mp hy
  -- y は ι(x) の後続辺: 終点と始点の一致、y ≠ x
  have hyx : y ≠ x := by
    intro h
    exact hy'.2.2 (by rw [h, reversal_involutive])
  have hdir : directionNumber y = directionNumber x + 2 := by
    rw [(stepTurning_eq_zero_iff _ _ hy).mp hst, directionNumber_reversal]
  have hx : x ∈ nonbacktrackingSuccessors (reversal y) := by
    refine Finset.mem_filter.mpr ⟨Finset.mem_univ _, ?_, ?_⟩
    · rw [hsrc, ← hy'.2.1, hsrc]
    · rw [reversal_involutive]
      exact hyx.symm
  have hfour : (2 : ZMod 4) + 2 = 0 := by decide
  have hdx : directionNumber x = directionNumber (reversal y) := by
    rw [directionNumber_reversal, hdir, add_assoc, hfour, add_zero]
  have haxis : ∀ d : ZMod 4, directionAxis (d + 2) = directionAxis d := by decide
  refine ⟨hx, hf, ?_, ?_, hst', ?_⟩
  · rw [hsrc, ← hy'.2.1, htgt]
  · exact (stepTurning_eq_zero_iff _ _ hx).mpr hdx
  · rw [← hdx, ← haxis, ← directionNumber_reversal]
    exact hax

/-- 横断の関係は二つの通過について対称である（def_transverse_crossing、claim_transverse_crossing_symmetric）。 -/
theorem edgeTransverseCrossing_symm {e f e' f' : OrientedEdge L}
    (h : edgeTransverseCrossing e f e' f') : edgeTransverseCrossing e' f' e f :=
  ⟨h.2.1, h.1, h.2.2.1.symm, h.2.2.2.2.1, h.2.2.2.1, Ne.symm h.2.2.2.2.2⟩

/-- 短い標識の対 `p` の通過を `(ι(p.1), p.2)` に取ったとき、二つの短い対が横断すること
    （def_transverse_crossing: 通過の終点が等しく、ともに直進し、方向軸が異なる）。 -/
def shortPairsTransverse (p q : OrientedEdge L × OrientedEdge L) : Prop :=
  edgeTransverseCrossing (reversal p.1) p.2 (reversal q.1) q.2

/-- 第一の対の向きを入れ替えても横断は変わらない。 -/
theorem shortPairsTransverse_swap_left [NeZero L] (p q : OrientedEdge L × OrientedEdge L) :
    shortPairsTransverse p.swap q ↔ shortPairsTransverse p q :=
  ⟨edgeTransverseCrossing_reverse_left _ _ _ _, edgeTransverseCrossing_reverse_left _ _ _ _⟩

/-- 第二の対の向きを入れ替えても横断は変わらない。 -/
theorem shortPairsTransverse_swap_right [NeZero L] (p q : OrientedEdge L × OrientedEdge L) :
    shortPairsTransverse p q.swap ↔ shortPairsTransverse p q :=
  ⟨fun h => edgeTransverseCrossing_symm (edgeTransverseCrossing_reverse_left _ _ _ _
      (edgeTransverseCrossing_symm h)),
    fun h => edgeTransverseCrossing_symm (edgeTransverseCrossing_reverse_left _ _ _ _
      (edgeTransverseCrossing_symm h))⟩

theorem ascendingPair_eq_or_swap {J : Type*} [LinearOrder J] (p : J × J) :
    ascendingPair p = p ∨ ascendingPair p = p.swap := by
  unfold ascendingPair
  split_ifs
  · exact Or.inl rfl
  · exact Or.inr rfl

theorem shortPairsTransverse_ascendingPair_left [NeZero L] (p q : OrientedEdge L × OrientedEdge L) :
    shortPairsTransverse (ascendingPair p) q ↔ shortPairsTransverse p q := by
  rcases ascendingPair_eq_or_swap p with h | h <;> rw [h]
  exact shortPairsTransverse_swap_left p q

theorem shortPairsTransverse_ascendingPair_right [NeZero L] (p q : OrientedEdge L × OrientedEdge L) :
    shortPairsTransverse p (ascendingPair q) ↔ shortPairsTransverse p q := by
  rcases ascendingPair_eq_or_swap q with h | h <;> rw [h]
  exact shortPairsTransverse_swap_right p q

/-- 相異なる二点の昇順対は、二点の並べ方によらない。 -/
theorem ascendingPair_swap_of_ne {J : Type*} [LinearOrder J] {x y : J} (hxy : x ≠ y) :
    ascendingPair (y, x) = ascendingPair (x, y) := by
  unfold ascendingPair
  simp only
  split_ifs with h1 h2 h2
  · exact absurd (lt_asymm h1) (not_not.mpr h2)
  · rfl
  · rfl
  · exact absurd (lt_or_gt_of_ne hxy) (by
      rintro (h | h)
      · exact h2 h
      · exact h1 h)

/-- `t(D,T)`: 横断する短い標識の対の、順序のない対の個数。マッチングの対は第一成分で決まるので、
    順序のない対 `{p, q}` を第一成分の小さい側を先に置いた `(p, q)` で数える。 -/
noncomputable def shortPairCrossingNumber (t : Finset (OrientedEdge L × OrientedEdge L)) : ℕ :=
  ((t ×ˢ t).filter fun pq => pq.1.1 < pq.2.1 ∧ shortPairsTransverse pq.1 pq.2).card

section Cycles

variable (D : PerfectMatching (OrientedEdge L)) (t : Finset (OrientedEdge L × OrientedEdge L))

/-- 閉路の第 `j` 点 `c_m(j)`。 -/
noncomputable def taggedCyclePoint (m : TaggedActive D t) (j : ℕ) : OrientedEdge L :=
  (finiteMapIterate (concreteAlternatingSuccessor D t) j m).1

/-- 閉路の添字の集合 `{(C, r) : r < k_C}`。閉路は最小元で表す。 -/
noncomputable def taggedCycleIndices : Finset ((_ : TaggedActive D t) × ℕ) :=
  (taggedCycleMinima D t).sigma fun m => Finset.range (taggedCycleLength D t m)

/-- 閉路 `C` の第 `r` 通過 `(w_r, w_{r+1})` に対応する短い標識の対 `{ι(w_r), w_{r+1}}`（昇順）。 -/
noncomputable def taggedCycleShortPair (a : (_ : TaggedActive D t) × ℕ) :
    OrientedEdge L × OrientedEdge L :=
  ascendingPair (reversal (taggedCycleWalk D t a.1 a.2), taggedCycleWalk D t a.1 (a.2 + 1))

/-- 閉路 `C` の第 `r` 通過と閉路 `C'` の第 `r'` 通過が横断すること。 -/
def cyclePassesCross (m : TaggedActive D t) (r : ℕ) (m' : TaggedActive D t) (r' : ℕ) : Prop :=
  edgeTransverseCrossing (taggedCycleWalk D t m r) (taggedCycleWalk D t m (r + 1))
    (taggedCycleWalk D t m' r') (taggedCycleWalk D t m' (r' + 1))

theorem cyclePassesCross_symm {m : TaggedActive D t} {r : ℕ} {m' : TaggedActive D t} {r' : ℕ}
    (h : cyclePassesCross D t m r m' r') : cyclePassesCross D t m' r' m r :=
  edgeTransverseCrossing_symm h

/-- 短い対の横断は、対応する通過の横断である。 -/
theorem taggedCycleShortPair_transverse_iff [NeZero L] (a b : (_ : TaggedActive D t) × ℕ) :
    shortPairsTransverse (taggedCycleShortPair D t a) (taggedCycleShortPair D t b) ↔
      cyclePassesCross D t a.1 a.2 b.1 b.2 := by
  unfold taggedCycleShortPair
  rw [shortPairsTransverse_ascendingPair_left, shortPairsTransverse_ascendingPair_right]
  unfold shortPairsTransverse cyclePassesCross
  simp only [reversal_involutive]

/-- 最小元から読んだ閉路では、`ι(w_r) = c(2r)`、`w_{r+1} = c(2r+1)` は `c(2r)` の D の相手である。 -/
theorem taggedCycleWalk_pair_points (m : TaggedActive D t) (hm : m ∈ taggedCycleMinima D t) (r : ℕ) :
    reversal (taggedCycleWalk D t m r) = taggedCyclePoint D t m (2 * r) ∧
      taggedCycleWalk D t m (r + 1) = taggedCyclePoint D t m (2 * r + 1) ∧
      taggedCyclePoint D t m (2 * r + 1) = perfectMatchingMate D (taggedCyclePoint D t m (2 * r)) := by
  obtain ⟨i, _, rfl⟩ := Finset.mem_image.mp hm
  set m := matchingPairComponentMinimum (concreteShortInvolution D t) (concreteLongInvolution D t) i
  have hcolor := (cycleMinimum_self_and_color D t i).2
  have heven := (iterate_color_parity D t m hcolor (2 * r)).mpr (even_two_mul r)
  have hodd : ¬ finiteMapIterate (concreteAlternatingSuccessor D t) (2 * r + 1) m ∈
      matchingPairColor (concreteShortInvolution D t) (concreteLongInvolution D t) := by
    rw [iterate_color_parity D t m hcolor (2 * r + 1)]
    exact Nat.not_even_iff_odd.mpr (odd_two_mul_add_one r)
  have hnext : (finiteMapIterate (concreteAlternatingSuccessor D t) (2 * (r + 1)) m).1 =
      reversal (finiteMapIterate (concreteAlternatingSuccessor D t) (2 * r + 1) m).1 := by
    rw [show 2 * (r + 1) = 2 * r + 1 + 1 by ring, iterate_succ_val D t m (2 * r + 1), if_neg hodd]
    exact referenceLongMate_eq_reversal _
  refine ⟨?_, ?_, ?_⟩
  · simp only [taggedCycleWalk, taggedCyclePoint, reversal_involutive]
  · simp only [taggedCycleWalk, taggedCyclePoint]
    rw [hnext, reversal_involutive]
  · simp only [taggedCyclePoint]
    rw [iterate_succ_val D t m (2 * r), if_pos heven]

/-- 閉路の点は、周期より小さい添字で相異なり、相異なる閉路の点とも異なる。 -/
theorem taggedCyclePoint_inj (m m' : TaggedActive D t) (hm : m ∈ taggedCycleMinima D t)
    (hm' : m' ∈ taggedCycleMinima D t) (j j' : ℕ)
    (hj : j < finitePermutationMinimalPeriod (concreteAlternatingSuccessor D t) m)
    (hj' : j' < finitePermutationMinimalPeriod (concreteAlternatingSuccessor D t) m')
    (h : taggedCyclePoint D t m j = taggedCyclePoint D t m' j') : m = m' ∧ j = j' := by
  have hmem : ∀ (n : TaggedActive D t) (i : ℕ),
      i < finitePermutationMinimalPeriod (concreteAlternatingSuccessor D t) n →
        taggedCyclePoint D t n i ∈ taggedCyclePoints D t n := by
    intro n i hi
    exact List.mem_map.mpr ⟨i, List.mem_range.mpr hi, rfl⟩
  have hmm : m = m' := by
    by_contra hne
    exact taggedCyclePoints_disjoint D t m m' hm hm' hne (hmem m j hj) (h ▸ hmem m' j' hj')
  subst hmm
  refine ⟨rfl, ?_⟩
  have hnd := taggedCyclePoints_nodup D t m
  unfold taggedCyclePoints at hnd
  exact List.inj_on_of_nodup_map hnd (List.mem_range.mpr hj) (List.mem_range.mpr hj') h

theorem taggedCycle_period_eq (m : TaggedActive D t) :
    finitePermutationMinimalPeriod (concreteAlternatingSuccessor D t) m =
      2 * taggedCycleLength D t m := by
  obtain ⟨_, ⟨k, hk⟩, _⟩ := taggedCycle_period D t m
  unfold taggedCycleLength
  omega

/-- 閉路の通過に対応する対は T の短い対である（`taggedCycle_pairs_short` の添字の形）。 -/
theorem taggedCycleShortPair_mem (z : Qbar) (s : SpinStructure)
    (ht : t ⊆ matchingOrientedPairs D)
    (hterm : matchingSignPolynomial D *
      ((-1 : Polynomial Qbar) ^ t.card *
        (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
        (∏ p ∈ t, gaugedShortContribution z s p)) ≠ 0)
    (a : (_ : TaggedActive D t) × ℕ) (ha : a ∈ taggedCycleIndices D t) :
    taggedCycleShortPair D t a ∈ t := by
  obtain ⟨hm, -⟩ := Finset.mem_sigma.mp ha
  obtain ⟨h1, h2, h3⟩ := taggedCycleWalk_pair_points D t a.1 hm a.2
  unfold taggedCycleShortPair
  rw [h1, h2, h3]
  exact (ascendingMatePair_mem_iff_active D t z s ht hterm _).mpr
    (finiteMapIterate (concreteAlternatingSuccessor D t) (2 * a.2) a.1).2

/-- マッチングの昇順対の第二成分は第一成分の相手である。 -/
theorem matchingOrientedPairs_snd (p : OrientedEdge L × OrientedEdge L)
    (hp : p ∈ matchingOrientedPairs D) : p.2 = perfectMatchingMate D p.1 := by
  have hp' := (Finset.mem_filter.mp hp).2
  exact (perfectMatchingMate_eq_of_pair D p.1 p.2 (ne_of_lt hp'.1).symm hp'.2).symm

/-- 閉路の通過から短い対への対応は単射である。 -/
theorem taggedCycleShortPair_injOn :
    Set.InjOn (taggedCycleShortPair D t) (taggedCycleIndices D t) := by
  intro a ha b hb hab
  obtain ⟨hma, hra⟩ := Finset.mem_sigma.mp ha
  obtain ⟨hmb, hrb⟩ := Finset.mem_sigma.mp hb
  have hra' := Finset.mem_range.mp hra
  have hrb' := Finset.mem_range.mp hrb
  obtain ⟨a1, a2, a3⟩ := taggedCycleWalk_pair_points D t a.1 hma a.2
  obtain ⟨b1, b2, b3⟩ := taggedCycleWalk_pair_points D t b.1 hmb b.2
  unfold taggedCycleShortPair at hab
  rw [a1, a2, b1, b2] at hab
  have hset := congrArg (fun p : OrientedEdge L × OrientedEdge L =>
    ({p.1, p.2} : Set (OrientedEdge L))) hab
  rw [a3, b3, (ascendingMatePair_spec D _).2, (ascendingMatePair_spec D _).2, ← a3, ← b3] at hset
  -- c_a(2r) は c_b(2r') か c_b(2r'+1) に等しい
  have hx : taggedCyclePoint D t a.1 (2 * a.2) ∈
      ({taggedCyclePoint D t b.1 (2 * b.2), taggedCyclePoint D t b.1 (2 * b.2 + 1)} :
        Set (OrientedEdge L)) := by
    rw [← hset]
    exact Or.inl rfl
  have hpa := taggedCycle_period_eq D t a.1
  have hpb := taggedCycle_period_eq D t b.1
  rcases hx with h | h
  · obtain ⟨hm, hr⟩ := taggedCyclePoint_inj D t a.1 b.1 hma hmb _ _ (by omega) (by omega) h
    rcases a with ⟨ma, ra⟩
    rcases b with ⟨mb, rb⟩
    simp only at hm hr
    subst hm
    have : ra = rb := by omega
    subst this
    rfl
  · obtain ⟨_, hr⟩ := taggedCyclePoint_inj D t a.1 b.1 hma hmb _ _ (by omega) (by omega) h
    omega

/-- T の各短い対は、ある閉路の通過に対応する。 -/
theorem taggedCycleShortPair_surj (z : Qbar) (s : SpinStructure)
    (ht : t ⊆ matchingOrientedPairs D)
    (hterm : matchingSignPolynomial D *
      ((-1 : Polynomial Qbar) ^ t.card *
        (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
        (∏ p ∈ t, gaugedShortContribution z s p)) ≠ 0)
    (p : OrientedEdge L × OrientedEdge L) (hp : p ∈ t) :
    ∃ a ∈ taggedCycleIndices D t, taggedCycleShortPair D t a = p := by
  have hpm := ht hp
  have hlt := (Finset.mem_filter.mp hpm).2.1
  have hsnd := matchingOrientedPairs_snd D p hpm
  have hpeq : ascendingPair (p.1, perfectMatchingMate D p.1) = p := by
    rw [← hsnd]
    unfold ascendingPair
    simp [hlt]
  have hact : p.1 ∈ concreteTaggedActiveVertices D t :=
    (ascendingMatePair_mem_iff_active D t z s ht hterm p.1).mp (by rw [hpeq]; exact hp)
  let τ := concreteShortInvolution D t
  let υ := concreteLongInvolution D t
  let xx : TaggedActive D t := ⟨p.1, hact⟩
  let m := matchingPairComponentMinimum τ υ xx
  have hm : m ∈ taggedCycleMinima D t := Finset.mem_image_of_mem _ (Finset.mem_univ _)
  have horbit : xx ∈ finitePermutationOrbit (concreteAlternatingSuccessor D t) m := by
    change xx ∈ finitePermutationOrbit (matchingPairPermutation τ υ) m
    rw [matchingPairPermutation_orbit_eq_component,
      matchingPairComponent_basepoint τ υ xx m (matchingPairComponentMinimum_mem τ υ xx)]
    exact Or.inl (finitePermutationOrbit_self_mem _ _)
  obtain ⟨j, hj⟩ := (finitePermutationOrbitEnumeration_bijective
    (concreteAlternatingSuccessor D t) m).2 ⟨xx, horbit⟩
  have hjval : taggedCyclePoint D t m j.val = p.1 := congrArg (fun y => y.1.1) hj
  have hjlt : j.val < 2 * taggedCycleLength D t m := by
    rw [← taggedCycle_period_eq D t m]
    exact j.isLt
  rcases Nat.even_or_odd j.val with ⟨q, hq⟩ | ⟨q, hq⟩
  · refine ⟨⟨m, q⟩, Finset.mem_sigma.mpr ⟨hm, Finset.mem_range.mpr
      (show q < taggedCycleLength D t m by omega)⟩, ?_⟩
    obtain ⟨h1, h2, h3⟩ := taggedCycleWalk_pair_points D t m hm q
    unfold taggedCycleShortPair
    simp only
    rw [h1, h2, h3, show 2 * q = j.val by omega, hjval, hpeq]
  · refine ⟨⟨m, q⟩, Finset.mem_sigma.mpr ⟨hm, Finset.mem_range.mpr
      (show q < taggedCycleLength D t m by omega)⟩, ?_⟩
    obtain ⟨h1, h2, h3⟩ := taggedCycleWalk_pair_points D t m hm q
    have hmate : perfectMatchingMate D (taggedCyclePoint D t m (2 * q)) = p.1 := by
      rw [← h3, show 2 * q + 1 = j.val by omega, hjval]
    have hpt : taggedCyclePoint D t m (2 * q) = perfectMatchingMate D p.1 := by
      rw [← hmate, perfectMatchingMate_involutive]
    unfold taggedCycleShortPair
    simp only
    rw [h1, h2, h3, hpt, perfectMatchingMate_involutive,
      ascendingPair_swap_of_ne (perfectMatchingMate_ne D p.1).symm, hpeq]

/-- 同じ閉路内の横断対の個数（添字の小さい側を先に置く）。 -/
noncomputable def cycleSelfCross (m : TaggedActive D t) : ℕ :=
  ((Finset.range (taggedCycleLength D t m) ×ˢ Finset.range (taggedCycleLength D t m)).filter
    fun p => p.1 < p.2 ∧ cyclePassesCross D t m p.1 m p.2).card

/-- 二閉路間の横断対の個数。 -/
noncomputable def cycleMutualCross (m m' : TaggedActive D t) : ℕ :=
  ((Finset.range (taggedCycleLength D t m) ×ˢ Finset.range (taggedCycleLength D t m')).filter
    fun p => cyclePassesCross D t m p.1 m' p.2).card

theorem cycleMutualCross_symm (m m' : TaggedActive D t) :
    cycleMutualCross D t m m' = cycleMutualCross D t m' m := by
  unfold cycleMutualCross
  refine Finset.card_nbij' Prod.swap Prod.swap ?_ ?_ ?_ ?_
  · intro p hp
    simp only [Finset.mem_coe, Finset.mem_filter, Finset.mem_product, Prod.fst_swap,
      Prod.snd_swap] at hp ⊢
    exact ⟨⟨hp.1.2, hp.1.1⟩, cyclePassesCross_symm D t hp.2⟩
  · intro p hp
    simp only [Finset.mem_coe, Finset.mem_filter, Finset.mem_product, Prod.fst_swap,
      Prod.snd_swap] at hp ⊢
    exact ⟨⟨hp.1.2, hp.1.1⟩, cyclePassesCross_symm D t hp.2⟩
  · intro p _
    exact Prod.swap_swap p
  · intro p _
    exact Prod.swap_swap p

/-- 横断する短い対の順序付き対は、同じ閉路内のものと、相異なる二閉路間のものに重複なく分かれる。 -/
theorem cycleIndexPairs_split :
    ((taggedCycleIndices D t ×ˢ taggedCycleIndices D t).filter
        fun p => p.1 ≠ p.2 ∧ cyclePassesCross D t p.1.1 p.1.2 p.2.1 p.2.2).card =
      ∑ m ∈ taggedCycleMinima D t,
          ((Finset.range (taggedCycleLength D t m) ×ˢ Finset.range (taggedCycleLength D t m)).filter
            fun p => p.1 ≠ p.2 ∧ cyclePassesCross D t m p.1 m p.2).card +
        ∑ q ∈ (taggedCycleMinima D t ×ˢ taggedCycleMinima D t).filter (fun q => q.1 ≠ q.2),
          cycleMutualCross D t q.1 q.2 := by
  set M := taggedCycleMinima D t
  set R := fun m => Finset.range (taggedCycleLength D t m)
  -- 重み: 添字 (m, r), (m', r') の対が相異なり横断するなら 1
  set H : TaggedActive D t → TaggedActive D t → ℕ := fun m m' =>
    ∑ r ∈ R m, ∑ r' ∈ R m',
      if (⟨m, r⟩ : (_ : TaggedActive D t) × ℕ) ≠ ⟨m', r'⟩ ∧ cyclePassesCross D t m r m' r'
      then 1 else 0 with hH
  have hcard : ((taggedCycleIndices D t ×ˢ taggedCycleIndices D t).filter
        fun p => p.1 ≠ p.2 ∧ cyclePassesCross D t p.1.1 p.1.2 p.2.1 p.2.2).card =
      ∑ m ∈ M, ∑ m' ∈ M, H m m' := by
    rw [Finset.card_filter, Finset.sum_product]
    unfold taggedCycleIndices
    rw [Finset.sum_sigma]
    refine Finset.sum_congr rfl fun m _ => ?_
    simp only [Finset.sum_sigma]
    exact Finset.sum_comm
  have hdiag : ∀ m, H m m = ((R m ×ˢ R m).filter
      fun p => p.1 ≠ p.2 ∧ cyclePassesCross D t m p.1 m p.2).card := by
    intro m
    rw [Finset.card_filter, Finset.sum_product]
    refine Finset.sum_congr rfl fun r _ => Finset.sum_congr rfl fun r' _ => ?_
    have : ((⟨m, r⟩ : (_ : TaggedActive D t) × ℕ) ≠ ⟨m, r'⟩) ↔ r ≠ r' := by
      simp
    simp only [this]
  have hoff : ∀ m m', m ≠ m' → H m m' = cycleMutualCross D t m m' := by
    intro m m' hne
    unfold cycleMutualCross
    rw [Finset.card_filter, Finset.sum_product]
    refine Finset.sum_congr rfl fun r _ => Finset.sum_congr rfl fun r' _ => ?_
    have : (⟨m, r⟩ : (_ : TaggedActive D t) × ℕ) ≠ ⟨m', r'⟩ := by
      intro h
      exact hne (Sigma.mk.inj_iff.mp h).1
    simp only [this, ne_eq, not_false_eq_true, true_and]
  have hsplit : ∑ m ∈ M, ∑ m' ∈ M, H m m' =
      ∑ m ∈ M, H m m + ∑ q ∈ (M ×ˢ M).filter (fun q => q.1 ≠ q.2), H q.1 q.2 := by
    rw [← Finset.sum_product' (f := H), ← Finset.sum_filter_add_sum_filter_not (M ×ˢ M)
      (fun q => q.1 = q.2)]
    congr 1
    · refine (Finset.sum_nbij' (fun m => (m, m)) Prod.fst ?_ ?_ ?_ ?_ ?_).symm
      · intro m hm
        simp only [Finset.mem_filter, Finset.mem_product] at hm ⊢
        exact ⟨⟨hm, hm⟩, by simp⟩
      · intro q hq
        simp only [Finset.mem_filter, Finset.mem_product] at hq ⊢
        exact hq.1.1
      · intro m _
        rfl
      · intro q hq
        simp only [Finset.mem_filter] at hq
        exact Prod.ext rfl hq.2
      · intro m _
        rfl
  rw [hcard, hsplit]
  congr 1
  · exact Finset.sum_congr rfl fun m _ => hdiag m
  · exact Finset.sum_congr rfl fun q hq => hoff q.1 q.2 (Finset.mem_filter.mp hq).2

/-- `γ_C` の巡回後続の辺は `w_{r+1}`。 -/
theorem taggedCycleFinWalk_successor (m : TaggedActive D t) (n : ℕ)
    (hn : taggedCycleLength D t m = n + 1) (j : Fin (n + 1)) :
    taggedCycleFinWalk D t m n (closedWalkSuccessor j) = taggedCycleWalk D t m (j.val + 1) := by
  unfold closedWalkSuccessor
  split_ifs with h
  · rfl
  · have hj : j.val = n := by omega
    have := taggedCycleWalk_periodic D t m 0
    rw [Nat.zero_add, hn] at this
    simp only [taggedCycleFinWalk, Fin.val_zero, hj]
    exact this.symm

/-- 同じ閉路内の横断対の個数は、`γ_C` の横断数 `c_C` である（def_closed_walk_crossing_number）。 -/
theorem cycleSelfCross_eq_crossingNumber (m : TaggedActive D t) (n : ℕ)
    (hn : taggedCycleLength D t m = n + 1)
    (hγ : closedNonbacktrackingWalk (taggedCycleFinWalk D t m n)) :
    closedWalkCrossingNumber (taggedCycleFinWalk D t m n) hγ = cycleSelfCross D t m := by
  unfold closedWalkCrossingNumber cycleSelfCross
  refine Finset.card_bij (fun p _ => (p.1.val, p.2.val)) ?_ ?_ ?_
  · intro p hp
    obtain ⟨-, hlt, hne, hx⟩ := Finset.mem_filter.mp hp
    refine Finset.mem_filter.mpr ⟨Finset.mem_product.mpr
      ⟨Finset.mem_range.mpr (by omega), Finset.mem_range.mpr (by omega)⟩, hlt, ?_⟩
    unfold cyclePassesCross
    rw [← taggedCycleFinWalk_successor D t m n hn p.1,
      ← taggedCycleFinWalk_successor D t m n hn p.2]
    exact hx
  · intro p _ q _ h
    simp only [Prod.mk.injEq] at h
    exact Prod.ext (Fin.ext h.1) (Fin.ext h.2)
  · intro q hq
    obtain ⟨hmem, hlt, hx⟩ := Finset.mem_filter.mp hq
    obtain ⟨h1, h2⟩ := Finset.mem_product.mp hmem
    have h1' := Finset.mem_range.mp h1
    have h2' := Finset.mem_range.mp h2
    refine ⟨(⟨q.1, by omega⟩, ⟨q.2, by omega⟩), Finset.mem_filter.mpr
      ⟨Finset.mem_product.mpr ⟨Finset.mem_univ _, Finset.mem_univ _⟩, ?_, ?_, ?_⟩, rfl⟩
    · exact Fin.mk_lt_mk.mpr hlt
    · exact fun h => (ne_of_lt hlt) (congrArg Fin.val h)
    · rw [taggedCycleFinWalk_successor D t m n hn, taggedCycleFinWalk_successor D t m n hn]
      exact hx

/-- 二閉路間の横断対の個数は、`γ_C` と `γ_C'` の混合横断数である。 -/
theorem cycleMutualCross_eq_mutualCrossingNumber (m m' : TaggedActive D t) (n n' : ℕ)
    (hn : taggedCycleLength D t m = n + 1) (hn' : taggedCycleLength D t m' = n' + 1)
    (hγ : closedNonbacktrackingWalk (taggedCycleFinWalk D t m n))
    (hη : closedNonbacktrackingWalk (taggedCycleFinWalk D t m' n')) :
    closedWalkMutualCrossingNumber (taggedCycleFinWalk D t m n) hγ
      (taggedCycleFinWalk D t m' n') hη = cycleMutualCross D t m m' := by
  unfold closedWalkMutualCrossingNumber cycleMutualCross
  refine Finset.card_bij (fun p _ => (p.1.val, p.2.val)) ?_ ?_ ?_
  · intro p hp
    obtain ⟨-, hx⟩ := Finset.mem_filter.mp hp
    refine Finset.mem_filter.mpr ⟨Finset.mem_product.mpr
      ⟨Finset.mem_range.mpr (by omega), Finset.mem_range.mpr (by omega)⟩, ?_⟩
    unfold cyclePassesCross
    rw [← taggedCycleFinWalk_successor D t m n hn p.1,
      ← taggedCycleFinWalk_successor D t m' n' hn' p.2]
    exact hx
  · intro p _ q _ h
    simp only [Prod.mk.injEq] at h
    exact Prod.ext (Fin.ext h.1) (Fin.ext h.2)
  · intro q hq
    obtain ⟨hmem, hx⟩ := Finset.mem_filter.mp hq
    obtain ⟨h1, h2⟩ := Finset.mem_product.mp hmem
    have h1' := Finset.mem_range.mp h1
    have h2' := Finset.mem_range.mp h2
    refine ⟨(⟨q.1, by omega⟩, ⟨q.2, by omega⟩), Finset.mem_filter.mpr
      ⟨Finset.mem_product.mpr ⟨Finset.mem_univ _, Finset.mem_univ _⟩, ?_⟩, rfl⟩
    rw [taggedCycleFinWalk_successor D t m n hn, taggedCycleFinWalk_successor D t m' n' hn']
    exact hx

/-- 最小元で表した閉路の辺列 `γ_C` は閉じた非後退辺列である。 -/
theorem taggedCycleMinWalk_closed [NeZero L] (z : Qbar) (s : SpinStructure)
    (ht : t ⊆ matchingOrientedPairs D)
    (hterm : matchingSignPolynomial D *
      ((-1 : Polynomial Qbar) ^ t.card *
        (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
        (∏ p ∈ t, gaugedShortContribution z s p)) ≠ 0)
    (m : TaggedActive D t) (hm : m ∈ taggedCycleMinima D t) :
    closedNonbacktrackingWalk (taggedCycleFinWalk D t m (taggedCycleLength D t m - 1)) := by
  obtain ⟨i, _, rfl⟩ := Finset.mem_image.mp hm
  exact taggedCycleFinWalk_closed D t z s ht hterm i _
    (by have := taggedCycleLength_pos D t
          (matchingPairComponentMinimum (concreteShortInvolution D t)
            (concreteLongInvolution D t) i); omega)

/-- 本文の証明の一つ目の式: `t(D,T) = Σ_C c_C + Σ_{C<C'} c_mut(γ_C, γ_C')`。
    閉路は最小元で表し、`C < C'` は最小元の順序で読む。 -/
theorem shortPairCrossingNumber_cycleSplit [NeZero L] (z : Qbar) (s : SpinStructure)
    (ht : t ⊆ matchingOrientedPairs D)
    (hterm : matchingSignPolynomial D *
      ((-1 : Polynomial Qbar) ^ t.card *
        (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
        (∏ p ∈ t, gaugedShortContribution z s p)) ≠ 0) :
    shortPairCrossingNumber t =
      ∑ m ∈ (taggedCycleMinima D t).attach,
          closedWalkCrossingNumber (taggedCycleFinWalk D t m.1 (taggedCycleLength D t m.1 - 1))
            (taggedCycleMinWalk_closed D t z s ht hterm m.1 m.2) +
        ∑ q ∈ ((taggedCycleMinima D t).attach ×ˢ (taggedCycleMinima D t).attach).filter
            (fun q => q.1 < q.2),
          closedWalkMutualCrossingNumber
            (taggedCycleFinWalk D t q.1.1 (taggedCycleLength D t q.1.1 - 1))
            (taggedCycleMinWalk_closed D t z s ht hterm q.1.1 q.1.2)
            (taggedCycleFinWalk D t q.2.1 (taggedCycleLength D t q.2.1 - 1))
            (taggedCycleMinWalk_closed D t z s ht hterm q.2.1 q.2.2) := by
  set M := taggedCycleMinima D t
  set I := taggedCycleIndices D t
  set ψ := taggedCycleShortPair D t
  have hlen : ∀ m : TaggedActive D t,
      taggedCycleLength D t m = (taggedCycleLength D t m - 1) + 1 := by
    intro m
    have := taggedCycleLength_pos D t m
    omega
  -- 短い対の横断対を、閉路の添字の対へ移す（短い対と通過の一対一対応）
  have htransport : shortPairCrossingNumber t =
      ((I ×ˢ I).filter fun ab => (ψ ab.1).1 < (ψ ab.2).1 ∧
        cyclePassesCross D t ab.1.1 ab.1.2 ab.2.1 ab.2.2).card := by
    unfold shortPairCrossingNumber
    symm
    refine Finset.card_bij (fun ab _ => (ψ ab.1, ψ ab.2)) ?_ ?_ ?_
    · intro ab hab
      obtain ⟨hmem, hlt, hx⟩ := Finset.mem_filter.mp hab
      obtain ⟨h1, h2⟩ := Finset.mem_product.mp hmem
      exact Finset.mem_filter.mpr ⟨Finset.mem_product.mpr
        ⟨taggedCycleShortPair_mem D t z s ht hterm _ h1,
          taggedCycleShortPair_mem D t z s ht hterm _ h2⟩, hlt,
        (taggedCycleShortPair_transverse_iff D t ab.1 ab.2).mpr hx⟩
    · intro ab hab cd hcd h
      obtain ⟨hmem, -⟩ := Finset.mem_filter.mp hab
      obtain ⟨hmem', -⟩ := Finset.mem_filter.mp hcd
      simp only [Prod.mk.injEq] at h
      exact Prod.ext
        (taggedCycleShortPair_injOn D t (Finset.mem_product.mp hmem).1
          (Finset.mem_product.mp hmem').1 h.1)
        (taggedCycleShortPair_injOn D t (Finset.mem_product.mp hmem).2
          (Finset.mem_product.mp hmem').2 h.2)
    · intro pq hpq
      obtain ⟨hmem, hlt, hx⟩ := Finset.mem_filter.mp hpq
      obtain ⟨h1, h2⟩ := Finset.mem_product.mp hmem
      obtain ⟨a, ha, hae⟩ := taggedCycleShortPair_surj D t z s ht hterm _ h1
      obtain ⟨b, hb, hbe⟩ := taggedCycleShortPair_surj D t z s ht hterm _ h2
      rw [← hae, ← hbe] at hlt hx
      exact ⟨(a, b), Finset.mem_filter.mpr ⟨Finset.mem_product.mpr ⟨ha, hb⟩, hlt,
        (taggedCycleShortPair_transverse_iff D t a b).mp hx⟩, Prod.ext hae hbe⟩
  -- 短い対は第一成分で決まるので、鍵 (ψ a).1 は添字の集合上で単射
  have hkey : Set.InjOn (fun a => (ψ a).1) I := by
    intro a ha b hb h
    apply taggedCycleShortPair_injOn D t ha hb
    have hpa := ht (taggedCycleShortPair_mem D t z s ht hterm a ha)
    have hpb := ht (taggedCycleShortPair_mem D t z s ht hterm b hb)
    exact Prod.ext h (by
      rw [matchingOrientedPairs_snd D _ hpa, matchingOrientedPairs_snd D _ hpb]
      exact congrArg _ h)
  have hdouble := card_ne_pairs_eq_two_mul_key I (fun a => (ψ a).1) hkey
    (fun a b => cyclePassesCross D t a.1 a.2 b.1 b.2) (fun _ _ h => cyclePassesCross_symm D t h)
  -- 同じ閉路内の対: 相異なる順序付き対は c_C の二倍
  have hself : ∀ m, ((Finset.range (taggedCycleLength D t m) ×ˢ
      Finset.range (taggedCycleLength D t m)).filter
        fun p => p.1 ≠ p.2 ∧ cyclePassesCross D t m p.1 m p.2).card =
      2 * cycleSelfCross D t m := by
    intro m
    exact card_ne_pairs_eq_two_mul_key _ id (Set.injOn_id _)
      (fun r r' => cyclePassesCross D t m r m r') (fun _ _ h => cyclePassesCross_symm D t h)
  -- 二閉路間の対: 相異なる閉路の順序付き対は C < C' の二倍
  have hmut := sum_ne_pairs_eq_two_mul_key M id (Set.injOn_id _)
    (cycleMutualCross D t) (cycleMutualCross_symm D t)
  have htotal : 2 * shortPairCrossingNumber t =
      2 * (∑ m ∈ M, cycleSelfCross D t m +
        ∑ q ∈ (M ×ˢ M).filter (fun q => q.1 < q.2), cycleMutualCross D t q.1 q.2) := by
    rw [htransport, ← hdouble, cycleIndexPairs_split D t, Finset.sum_congr rfl fun m _ => hself m,
      ← Finset.mul_sum, hmut, mul_add]
    rfl
  have hcyc : ∑ m ∈ M, cycleSelfCross D t m =
      ∑ m ∈ M.attach,
          closedWalkCrossingNumber (taggedCycleFinWalk D t m.1 (taggedCycleLength D t m.1 - 1))
            (taggedCycleMinWalk_closed D t z s ht hterm m.1 m.2) := by
    rw [← Finset.sum_attach M]
    refine Finset.sum_congr rfl fun m _ => ?_
    exact (cycleSelfCross_eq_crossingNumber D t m.1 _ (hlen m.1) _).symm
  have hpairs : ∑ q ∈ (M ×ˢ M).filter (fun q => q.1 < q.2), cycleMutualCross D t q.1 q.2 =
      ∑ q ∈ (M.attach ×ˢ M.attach).filter (fun q => q.1 < q.2),
          closedWalkMutualCrossingNumber
            (taggedCycleFinWalk D t q.1.1 (taggedCycleLength D t q.1.1 - 1))
            (taggedCycleMinWalk_closed D t z s ht hterm q.1.1 q.1.2)
            (taggedCycleFinWalk D t q.2.1 (taggedCycleLength D t q.2.1 - 1))
            (taggedCycleMinWalk_closed D t z s ht hterm q.2.1 q.2.2) := by
    symm
    refine Finset.sum_bij (fun q _ => (q.1.1, q.2.1)) ?_ ?_ ?_ ?_
    · intro q hq
      obtain ⟨-, hlt⟩ := Finset.mem_filter.mp hq
      exact Finset.mem_filter.mpr ⟨Finset.mem_product.mpr ⟨q.1.2, q.2.2⟩, hlt⟩
    · intro q _ q' _ h
      simp only [Prod.mk.injEq] at h
      exact Prod.ext (Subtype.ext h.1) (Subtype.ext h.2)
    · intro q hq
      obtain ⟨hmem, hlt⟩ := Finset.mem_filter.mp hq
      obtain ⟨h1, h2⟩ := Finset.mem_product.mp hmem
      exact ⟨(⟨q.1, h1⟩, ⟨q.2, h2⟩), Finset.mem_filter.mpr
        ⟨Finset.mem_product.mpr ⟨Finset.mem_attach _ _, Finset.mem_attach _ _⟩, hlt⟩, rfl⟩
    · intro q _
      exact cycleMutualCross_eq_mutualCrossingNumber D t q.1.1 q.2.1 _ _
        (hlen q.1.1) (hlen q.2.1) _ _
  rw [← hcyc, ← hpairs]
  omega

end Cycles

end Ising2DLambda.KacWard
