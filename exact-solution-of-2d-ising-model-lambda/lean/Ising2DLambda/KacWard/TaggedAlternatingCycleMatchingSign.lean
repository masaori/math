/-
「交互閉路ごとの向き直しが二つのマッチングの符号比を与える」（claim_alternating_cycle_matching_sign）の
具体版のうち、実際の交互閉路への接続の段。実際の標識付き完全マッチング (D, T) について、
claim_tagged_difference_cycle_cover の交互閉路を最小元から読んだ点列と、両マッチングに共通する対の
昇順の列が、端点列の符号の段（`alternatingCycleWords_matching_sign`）の前提を満たすことを示し、
本文の主張を実際の閉路の集合 𝒞 の形で得る。

  人手証明                                              このファイル
  第一色から始まる点列 c_C(r) = σ^[r](m_C)               `taggedCyclePoints`
  閉路の集合 𝒞（最小元ごとに一つ）                       `taggedCycleMinima`・`taggedCycleWords`
  両マッチングに共通する対を昇順に並べた列               `taggedCommonPairs`
  点集合は互いに素で全活動点を覆う                       `taggedCycleWords_flatten_nodup`・
                                                        `taggedCycleWords_complete`
  活動点以外の D の対は 𝒟₀ の対と一致する                `inactive_mate_eq_reference`
  (c(2r), c(2r+1)) は D の対、(c(2r+1), c(2r+2)) は 𝒟₀ の対
                                                        `taggedCycle_pairs_D`・`taggedCycle_pairs_reference`
  本文の主張                                             `taggedAlternatingCycles_matching_sign`

必要十分版は呼ばない。住処は有限集合と ℤ で、ℝ / ℂ は現れない。
-/
import Ising2DLambda.KacWard.AlternatingCycleMatchingSign
import Ising2DLambda.KacWard.TaggedDifferenceCycleCover

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
attribute [local instance] Classical.propDecidable

section Lists

/-- 偶数長の点列 (f 0, …, f (2k-1)) の二つずつの区切りは (f(2r), f(2r+1)) の列である。 -/
theorem consecutivePairs_map_range {K : Type*} :
    ∀ (k : ℕ) (f : ℕ → K),
      consecutivePairs ((List.range (2 * k)).map f) =
        (List.range k).map (fun r => (f (2 * r), f (2 * r + 1)))
  | 0, _ => rfl
  | k + 1, f => by
      have h2 : 2 * (k + 1) = 2 * k + 1 + 1 := by ring
      rw [h2, List.range_succ_eq_map, List.map_cons, List.map_map, List.range_succ_eq_map,
        List.map_cons, List.map_map]
      change (f 0, (f ∘ Nat.succ) 0) ::
          consecutivePairs ((List.range (2 * k)).map ((f ∘ Nat.succ) ∘ Nat.succ)) = _
      rw [consecutivePairs_map_range k, List.range_succ_eq_map, List.map_cons, List.map_map]
      congr 1

/-- 周期 n の点列を一つ左へ巡回移動すると、(f 1, …, f n) になる。 -/
theorem rotate_one_map_range {K : Type*} (n : ℕ) (f : ℕ → K) (hn : 0 < n) (hper : f n = f 0) :
    ((List.range n).map f).rotate 1 = (List.range n).map (fun r => f (r + 1)) := by
  obtain ⟨k, rfl⟩ := Nat.exists_eq_add_of_lt hn
  simp only [zero_add] at hper ⊢
  conv_lhs => rw [List.range_succ_eq_map, List.map_cons, List.map_map, List.rotate_cons_succ,
    List.rotate_zero]
  rw [List.range_succ, List.map_append, List.map_singleton, hper]
  rfl

end Lists

variable {L : ℕ}

/-- 実際の活動点の型。 -/
abbrev TaggedActive (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L)) :=
  {i : OrientedEdge L // i ∈ concreteTaggedActiveVertices D t}

/-- 第一色の最小元 m から読んだ交互閉路の点列 c(r) = σ^[r](m)（0 ≤ r < 周期）。 -/
noncomputable def taggedCyclePoints (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L)) (m : TaggedActive D t) :
    List (OrientedEdge L) :=
  (List.range (finitePermutationMinimalPeriod (concreteAlternatingSuccessor D t) m)).map
    (fun r => (finiteMapIterate (concreteAlternatingSuccessor D t) r m).1)

/-- 交互閉路ごとの最小元の集合。閉路の集合 𝒞 と一対一に対応する。 -/
noncomputable def taggedCycleMinima (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L)) : Finset (TaggedActive D t) :=
  Finset.univ.image
    (matchingPairComponentMinimum (concreteShortInvolution D t) (concreteLongInvolution D t))

/-- 閉路を最小元の昇順に並べた点列の列。 -/
noncomputable def taggedCycleWords (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L)) : List (List (OrientedEdge L)) :=
  ((taggedCycleMinima D t).sort (· ≤ ·)).map (taggedCyclePoints D t)

/-- 両マッチングに共通する対を、第一端点の昇順に昇順の向きで並べた列。 -/
noncomputable def taggedCommonPairs (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L)) : List (OrientedEdge L × OrientedEdge L) :=
  ((Finset.univ.filter (fun e : OrientedEdge L =>
      e ∉ concreteTaggedActiveVertices D t ∧ e < perfectMatchingMate D e)).sort (· ≤ ·)).map
    (fun e => (e, perfectMatchingMate D e))

section Facts

variable (D : PerfectMatching (OrientedEdge L)) (t : Finset (OrientedEdge L × OrientedEdge L))

/-- 本文の「活動点以外の D の対は 𝒟₀ の長い対と一致する」（claim_tagged_symmetric_difference_degree）。
    活動点でない e では、D の相手は 𝒟₀ の相手に等しく、その相手も活動点でない。 -/
theorem inactive_mate_eq_reference (e : OrientedEdge L)
    (he : e ∉ concreteTaggedActiveVertices D t) :
    perfectMatchingMate (referenceLongMatching L) e = perfectMatchingMate D e ∧
      perfectMatchingMate D e ∉ concreteTaggedActiveVertices D t := by
  have hdr : concreteTaggedPairAt D t e = concreteTaggedPairAt (referenceLongMatching L) ∅ e := by
    by_contra hne
    apply he
    exact ⟨_, ((taggedDifference_incident_iff D t e (concreteTaggedPairAt D t e)).mpr
      ⟨hne, Or.inl rfl⟩).1, by simp [concreteTaggedPairAt]⟩
  have hset : ({e, perfectMatchingMate D e} : Set (OrientedEdge L)) =
      {e, perfectMatchingMate (referenceLongMatching L) e} := by
    have := congrArg Prod.fst hdr
    simpa [concreteTaggedPairAt] using this
  have hmate : perfectMatchingMate (referenceLongMatching L) e = perfectMatchingMate D e := by
    apply perfectMatchingMate_eq_of_pair _ _ _ (perfectMatchingMate_ne D e)
    rw [hset]
    exact (perfectMatchingMate_spec _ e).2
  refine ⟨hmate, fun hm => he ?_⟩
  have h := (concreteTaggedActiveVertices_mates D t _ hm).1
  rwa [perfectMatchingMate_involutive D e] at h

/-- 最小元は自分の閉路の最小元であり、第一色に属する。 -/
theorem cycleMinimum_self_and_color (i : TaggedActive D t) :
    let τ := concreteShortInvolution D t
    let υ := concreteLongInvolution D t
    matchingPairComponentMinimum τ υ (matchingPairComponentMinimum τ υ i) =
        matchingPairComponentMinimum τ υ i ∧
      matchingPairComponentMinimum τ υ i ∈ matchingPairColor τ υ := by
  intro τ υ
  have hself := matchingPairComponentMinimum_basepoint τ υ i _
    (matchingPairComponentMinimum_mem τ υ i)
  refine ⟨hself, ?_⟩
  change _ ∈ finitePermutationOrbit (matchingPairStep τ υ) _
  rw [hself]
  exact finitePermutationOrbit_self_mem _ _

/-- 第一色の点からの反復は、偶数回なら第一色、奇数回なら第二色にある。 -/
theorem iterate_color_parity (m : TaggedActive D t)
    (hm : m ∈ matchingPairColor (concreteShortInvolution D t) (concreteLongInvolution D t)) :
    ∀ r : ℕ, finiteMapIterate (concreteAlternatingSuccessor D t) r m ∈
        matchingPairColor (concreteShortInvolution D t) (concreteLongInvolution D t) ↔ Even r
  | 0 => by simpa [finiteMapIterate] using hm
  | r + 1 => by
      have ih := iterate_color_parity m hm r
      have hstep : finiteMapIterate (concreteAlternatingSuccessor D t) (r + 1) m =
          matchingPairSuccessor (concreteShortInvolution D t) (concreteLongInvolution D t)
            (finiteMapIterate (concreteAlternatingSuccessor D t) r m) := by
        simp only [finiteMapIterate, Function.iterate_succ_apply']
        rfl
      rw [hstep, matchingPairSuccessor_color, ih, Nat.even_add_one]

/-- 一歩の値。第一色では D の相手、第二色では 𝒟₀ の相手へ進む（def_matching_pair_successor）。 -/
theorem iterate_succ_val (m : TaggedActive D t) (r : ℕ) :
    (finiteMapIterate (concreteAlternatingSuccessor D t) (r + 1) m).1 =
      if finiteMapIterate (concreteAlternatingSuccessor D t) r m ∈
          matchingPairColor (concreteShortInvolution D t) (concreteLongInvolution D t) then
        perfectMatchingMate D (finiteMapIterate (concreteAlternatingSuccessor D t) r m).1
      else perfectMatchingMate (referenceLongMatching L)
        (finiteMapIterate (concreteAlternatingSuccessor D t) r m).1 := by
  have hstep : finiteMapIterate (concreteAlternatingSuccessor D t) (r + 1) m =
      matchingPairSuccessor (concreteShortInvolution D t) (concreteLongInvolution D t)
        (finiteMapIterate (concreteAlternatingSuccessor D t) r m) := by
    simp only [finiteMapIterate, Function.iterate_succ_apply']
    rfl
  rw [hstep, matchingPairSuccessor]
  split_ifs <;> rfl

/-- 閉路の周期は正で偶数である（claim_tagged_difference_alternating_cycle）。 -/
theorem taggedCycle_period (m : TaggedActive D t) :
    0 < finitePermutationMinimalPeriod (concreteAlternatingSuccessor D t) m ∧
      Even (finitePermutationMinimalPeriod (concreteAlternatingSuccessor D t) m) ∧
      finiteMapIterate (concreteAlternatingSuccessor D t)
        (finitePermutationMinimalPeriod (concreteAlternatingSuccessor D t) m) m = m := by
  have hs := finitePermutationMinimalPeriod_spec (concreteAlternatingSuccessor D t) m
  refine ⟨hs.1, ?_, hs.2.1⟩
  change Even (finitePermutationMinimalPeriod
    (matchingPairPermutation (concreteShortInvolution D t) (concreteLongInvolution D t)) m)
  rw [finitePermutationMinimalPeriod_eq_orbitLength]
  exact matchingPairPermutation_even_orbit _ _ m

/-- 閉路の点列は空でなく偶数長である。 -/
theorem taggedCyclePoints_even (m : TaggedActive D t) :
    taggedCyclePoints D t m ≠ [] ∧ Even (taggedCyclePoints D t m).length := by
  obtain ⟨hpos, hev, _⟩ := taggedCycle_period D t m
  unfold taggedCyclePoints
  refine ⟨?_, by simpa using hev⟩
  intro h
  have := congrArg List.length h
  simp at this
  omega

/-- 最小元から読んだ閉路の二つずつの区切りは D の対である。 -/
theorem taggedCycle_pairs_D (i : TaggedActive D t) :
    ∀ p ∈ consecutivePairs (taggedCyclePoints D t
        (matchingPairComponentMinimum (concreteShortInvolution D t) (concreteLongInvolution D t) i)),
      ({p.1, p.2} : Set (OrientedEdge L)) ∈ D.val := by
  intro p hp
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
  simp only
  rw [iterate_succ_val D t m (2 * r), if_pos hcol]
  exact (perfectMatchingMate_spec D _).2

/-- 一つ左へ巡回移動した閉路の二つずつの区切りは 𝒟₀ の対である。 -/
theorem taggedCycle_pairs_reference (i : TaggedActive D t) :
    ∀ p ∈ consecutivePairs ((taggedCyclePoints D t
        (matchingPairComponentMinimum (concreteShortInvolution D t)
          (concreteLongInvolution D t) i)).rotate 1),
      ({p.1, p.2} : Set (OrientedEdge L)) ∈ (referenceLongMatching L).val := by
  intro p hp
  set m := matchingPairComponentMinimum (concreteShortInvolution D t)
    (concreteLongInvolution D t) i
  obtain ⟨hpos, ⟨k, hk⟩, hper⟩ := taggedCycle_period D t m
  have hk2 : finitePermutationMinimalPeriod (concreteAlternatingSuccessor D t) m = 2 * k := by
    omega
  unfold taggedCyclePoints at hp
  rw [rotate_one_map_range _ _ hpos (by rw [hper]; rfl), hk2,
    consecutivePairs_map_range] at hp
  obtain ⟨r, _, rfl⟩ := List.mem_map.mp hp
  have hcol : ¬ finiteMapIterate (concreteAlternatingSuccessor D t) (2 * r + 1) m ∈
      matchingPairColor (concreteShortInvolution D t) (concreteLongInvolution D t) := by
    rw [iterate_color_parity D t m (cycleMinimum_self_and_color D t i).2 (2 * r + 1)]
    exact Nat.not_even_iff_odd.mpr (odd_two_mul_add_one r)
  simp only
  rw [iterate_succ_val D t m (2 * r + 1), if_neg hcol]
  exact (perfectMatchingMate_spec _ _).2

/-- 閉路の点は、その最小元の交互成分に属する。 -/
theorem taggedCyclePoints_mem_component (m : TaggedActive D t) (x : OrientedEdge L)
    (hx : x ∈ taggedCyclePoints D t m) :
    ∃ h : x ∈ concreteTaggedActiveVertices D t,
      (⟨x, h⟩ : TaggedActive D t) ∈ concreteAlternatingComponent D t m := by
  unfold taggedCyclePoints at hx
  obtain ⟨r, _, rfl⟩ := List.mem_map.mp hx
  refine ⟨(finiteMapIterate (concreteAlternatingSuccessor D t) r m).2, ?_⟩
  change _ ∈ matchingPairComponent _ _ m
  rw [← matchingPairPermutation_orbit_eq_component]
  exact ⟨r, Or.inl rfl⟩

/-- 一つの閉路の点は相異なる（軌道の列挙の単射性）。 -/
theorem taggedCyclePoints_nodup (m : TaggedActive D t) : (taggedCyclePoints D t m).Nodup := by
  unfold taggedCyclePoints
  apply List.Nodup.map_on _ List.nodup_range
  intro r hr s hs hrs
  have hinj := (finitePermutationOrbitEnumeration_bijective
    (concreteAlternatingSuccessor D t) m).1
  have := @hinj ⟨r, List.mem_range.mp hr⟩ ⟨s, List.mem_range.mp hs⟩
    (Subtype.ext (Subtype.ext hrs))
  exact congrArg Fin.val this

/-- 相異なる最小元の閉路は点を共有しない。 -/
theorem taggedCyclePoints_disjoint (m₁ m₂ : TaggedActive D t)
    (h₁ : m₁ ∈ taggedCycleMinima D t) (h₂ : m₂ ∈ taggedCycleMinima D t) (hne : m₁ ≠ m₂) :
    List.Disjoint (taggedCyclePoints D t m₁) (taggedCyclePoints D t m₂) := by
  intro x hx₁ hx₂
  obtain ⟨i₁, _, rfl⟩ := Finset.mem_image.mp h₁
  obtain ⟨i₂, _, rfl⟩ := Finset.mem_image.mp h₂
  obtain ⟨ha, hc₁⟩ := taggedCyclePoints_mem_component D t _ x hx₁
  obtain ⟨_, hc₂⟩ := taggedCyclePoints_mem_component D t _ x hx₂
  apply hne
  let τ := concreteShortInvolution D t
  let υ := concreteLongInvolution D t
  calc
    matchingPairComponentMinimum τ υ i₁ =
        matchingPairComponentMinimum τ υ (matchingPairComponentMinimum τ υ i₁) :=
      ((cycleMinimum_self_and_color D t i₁).1).symm
    _ = matchingPairComponentMinimum τ υ ⟨x, ha⟩ :=
      (matchingPairComponentMinimum_basepoint τ υ _ _ hc₁).symm
    _ = matchingPairComponentMinimum τ υ (matchingPairComponentMinimum τ υ i₂) :=
      matchingPairComponentMinimum_basepoint τ υ _ _ hc₂
    _ = matchingPairComponentMinimum τ υ i₂ := (cycleMinimum_self_and_color D t i₂).1

/-- 閉路の点を連結した列は重複がない。 -/
theorem taggedCycleWords_flatten_nodup : (taggedCycleWords D t).flatten.Nodup := by
  unfold taggedCycleWords
  rw [List.nodup_flatten]
  refine ⟨fun l hl => ?_, ?_⟩
  · obtain ⟨m, _, rfl⟩ := List.mem_map.mp hl
    exact taggedCyclePoints_nodup D t m
  · rw [List.pairwise_map]
    apply List.Nodup.pairwise_of_forall_ne (Finset.sort_nodup _ _)
    intro a ha b hb hab
    exact taggedCyclePoints_disjoint D t a b ((Finset.mem_sort _).mp ha)
      ((Finset.mem_sort _).mp hb) hab

/-- 共通対の各点は活動点でない。 -/
theorem taggedCommonPairs_inactive (x : OrientedEdge L)
    (hx : x ∈ matchingPairWord (taggedCommonPairs D t)) :
    x ∉ concreteTaggedActiveVertices D t := by
  obtain ⟨p, hp, hxp⟩ := List.mem_flatMap.mp hx
  obtain ⟨e, he, rfl⟩ := List.mem_map.mp hp
  have he' := (Finset.mem_filter.mp ((Finset.mem_sort _).mp he)).2
  simp only [List.mem_cons, List.not_mem_nil, or_false] at hxp
  rcases hxp with rfl | rfl
  · exact he'.1
  · exact (inactive_mate_eq_reference D t e he'.1).2

/-- 共通対の端点列は重複がない。 -/
theorem taggedCommonPairs_nodup : (matchingPairWord (taggedCommonPairs D t)).Nodup := by
  unfold taggedCommonPairs matchingPairWord
  rw [List.flatMap_map]
  apply List.nodup_flatMap.mpr
  refine ⟨fun e _ => ?_, ?_⟩
  · simpa using (perfectMatchingMate_ne D e).symm
  · apply List.Nodup.pairwise_of_forall_ne (Finset.sort_nodup _ _)
    intro a ha b hb hab
    have ha' := (Finset.mem_filter.mp ((Finset.mem_sort _).mp ha)).2.2
    have hb' := (Finset.mem_filter.mp ((Finset.mem_sort _).mp hb)).2.2
    have hinv := perfectMatchingMate_involutive D
    intro x hxa hxb
    simp only [List.mem_cons, List.not_mem_nil, or_false] at hxa hxb
    -- 二つの対 {a, mate a} と {b, mate b} が点を共有すると、a = b か、一方が他方の相手になる。
    -- 後者では a < mate a = b < mate b = a となり矛盾する。
    have key : a = b ∨ a = perfectMatchingMate D b ∨ perfectMatchingMate D a = b ∨
        perfectMatchingMate D a = perfectMatchingMate D b := by
      rcases hxa with h1 | h1 <;> rcases hxb with h2 | h2 <;> rw [h1] at h2 <;> simp [h2]
    rcases key with h | h | h | h
    · exact hab h
    · have hb2 : perfectMatchingMate D a = b := by rw [h, hinv]
      rw [hb2] at ha'
      rw [← h] at hb'
      exact absurd (ha'.trans hb') (lt_irrefl _)
    · have hb2 : perfectMatchingMate D b = a := by rw [← h, hinv]
      rw [h] at ha'
      rw [hb2] at hb'
      exact absurd (ha'.trans hb') (lt_irrefl _)
    · exact hab (by rw [← hinv a, h, hinv])

/-- 閉路の点列と共通対の端点列を連結した列は完全列挙である（点集合は互いに素で全体を覆う）。 -/
theorem taggedCycleWords_complete :
    IsCompleteWord ((taggedCycleWords D t).flatten ++ matchingPairWord (taggedCommonPairs D t)) := by
  constructor
  · rw [List.nodup_append]
    refine ⟨taggedCycleWords_flatten_nodup D t, taggedCommonPairs_nodup D t, ?_⟩
    intro x hx y hy hxy
    subst hxy
    apply taggedCommonPairs_inactive D t x hy
    obtain ⟨l, hl, hxl⟩ := List.mem_flatten.mp hx
    obtain ⟨m, _, rfl⟩ := List.mem_map.mp hl
    exact (taggedCyclePoints_mem_component D t m x hxl).1
  · intro x
    by_cases hx : x ∈ concreteTaggedActiveVertices D t
    · apply List.mem_append_left
      let τ := concreteShortInvolution D t
      let υ := concreteLongInvolution D t
      let xx : TaggedActive D t := ⟨x, hx⟩
      let m := matchingPairComponentMinimum τ υ xx
      have hm : m ∈ taggedCycleMinima D t := Finset.mem_image_of_mem _ (Finset.mem_univ _)
      have horbit : xx ∈ finitePermutationOrbit (concreteAlternatingSuccessor D t) m := by
        change xx ∈ finitePermutationOrbit (matchingPairPermutation τ υ) m
        rw [matchingPairPermutation_orbit_eq_component,
          matchingPairComponent_basepoint τ υ xx m (matchingPairComponentMinimum_mem τ υ xx)]
        exact Or.inl (finitePermutationOrbit_self_mem _ _)
      obtain ⟨r, hr⟩ := (finitePermutationOrbitEnumeration_bijective
        (concreteAlternatingSuccessor D t) m).2 ⟨xx, horbit⟩
      refine List.mem_flatten.mpr ⟨taggedCyclePoints D t m,
        List.mem_map.mpr ⟨m, (Finset.mem_sort _).mpr hm, rfl⟩, ?_⟩
      refine List.mem_map.mpr ⟨r.val, List.mem_range.mpr r.isLt, ?_⟩
      exact congrArg (fun y => y.1.1) hr
    · apply List.mem_append_right
      have hinact := inactive_mate_eq_reference D t x hx
      rcases lt_or_gt_of_ne (perfectMatchingMate_ne D x).symm with hlt | hgt
      · refine List.mem_flatMap.mpr ⟨(x, perfectMatchingMate D x), ?_, by simp⟩
        exact List.mem_map.mpr ⟨x, (Finset.mem_sort _).mpr
          (Finset.mem_filter.mpr ⟨Finset.mem_univ _, hx, hlt⟩), rfl⟩
      · let y := perfectMatchingMate D x
        have hyx : perfectMatchingMate D y = x := perfectMatchingMate_involutive D x
        refine List.mem_flatMap.mpr ⟨(y, perfectMatchingMate D y), ?_, by simp [hyx]⟩
        exact List.mem_map.mpr ⟨y, (Finset.mem_sort _).mpr
          (Finset.mem_filter.mpr ⟨Finset.mem_univ _, hinact.2, by rw [hyx]; exact hgt⟩), rfl⟩

/-- 共通対は昇順で、D の対であり 𝒟₀ の対でもある。 -/
theorem taggedCommonPairs_spec :
    ∀ p ∈ taggedCommonPairs D t, p.1 < p.2 ∧ ({p.1, p.2} : Set (OrientedEdge L)) ∈ D.val ∧
      ({p.1, p.2} : Set (OrientedEdge L)) ∈ (referenceLongMatching L).val := by
  intro p hp
  obtain ⟨e, he, rfl⟩ := List.mem_map.mp hp
  have he' := (Finset.mem_filter.mp ((Finset.mem_sort _).mp he)).2
  refine ⟨he'.2, (perfectMatchingMate_spec D e).2, ?_⟩
  rw [← (inactive_mate_eq_reference D t e he'.1).1]
  exact (perfectMatchingMate_spec _ e).2

end Facts

/-- 本文の主張を実際の交互閉路の集合 𝒞 の形で述べる。閉路の個数は最小元の個数で、
    sgn(D) sgn(𝒟₀) = (-1)^{|𝒞|} ∏_{C∈𝒞} α_D(C) α₀(C)。端点列の符号の段
    `alternatingCycleWords_matching_sign` の前提を、上の補題で実際の閉路から満たす。 -/
theorem taggedAlternatingCycles_matching_sign (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L)) :
    (taggedCycleWords D t).length = (taggedCycleMinima D t).card ∧
    perfectMatchingSign D * perfectMatchingSign (referenceLongMatching L) =
      (-1) ^ (taggedCycleMinima D t).card *
        ((taggedCycleWords D t).map
          (fun c => cycleShortOrientation c * cycleReferenceOrientation c)).prod := by
  have hlen : (taggedCycleWords D t).length = (taggedCycleMinima D t).card := by
    simp [taggedCycleWords]
  refine ⟨hlen, ?_⟩
  rw [← hlen]
  apply alternatingCycleWords_matching_sign D (taggedCycleWords D t) (taggedCommonPairs D t)
  · intro c hc
    obtain ⟨m, _, rfl⟩ := List.mem_map.mp hc
    exact taggedCyclePoints_even D t m
  · exact taggedCycleWords_complete D t
  · intro c hc
    obtain ⟨m, hm, rfl⟩ := List.mem_map.mp hc
    obtain ⟨i, _, rfl⟩ := Finset.mem_image.mp ((Finset.mem_sort _).mp hm)
    exact taggedCycle_pairs_D D t i
  · intro c hc
    obtain ⟨m, hm, rfl⟩ := List.mem_map.mp hc
    obtain ⟨i, _, rfl⟩ := Finset.mem_image.mp ((Finset.mem_sort _).mp hm)
    exact taggedCycle_pairs_reference D t i
  · exact taggedCommonPairs_spec D t

end Ising2DLambda.KacWard
