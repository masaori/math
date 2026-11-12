/-
「交互閉路ごとの向き直しが二つのマッチングの符号比を与える」の、実際の交互閉路への接続の段の必要十分版。
具体版と同じ手順（最小元から読んだ閉路の点列、共通対の昇順の列、色の偶奇による対の帰属、
閉路の点の相異と被覆）を、次の一般の対象で行う。

* 点の集合: 有限線型順序 J。向き付き辺であること、辞書式順序であることは使わない。
* 二つのマッチング: 任意の完全マッチング D と D₀。D₀ が反転対の基準マッチングであることは使わない。
* 活動点: 任意の部分集合 A と、その上の二つの不動点のない対合 τ, υ で、値がそれぞれ D, D₀ の相手で
  あるもの（hτ, hυ）。これで A は両方の相手で閉じる。標識付き対称差から A を作ることは使わない。
* A の外では D₀ の相手が D の相手に等しいこと（hout）。外すと共通対が D₀ の対にならない。
* 端点列の値は端点列の符号の段の必要十分版と同じ一般の F で、隣接交換で負になること（hswap）と
  sgn_F(D) の平方が一であること（hsD）だけを使う。
-/
import Ising2DLambda.KacWard.TaggedAlternatingCycleMatchingSign
import Ising2DLambda.NecSuf.KacWard.AlternatingCycleMatchingSign

namespace Ising2DLambda.NecSuf.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.KacWard (consecutivePairs consecutivePairs_map_range rotate_one_map_range)
attribute [local instance] Classical.propDecidable

variable {J : Type*} [Fintype J] [LinearOrder J]

/-- 最小元 m から読んだ閉路の点列。 -/
noncomputable def cyclePointsOf {A : Set J} (τ υ : FixedPointFreeInvolution {x // x ∈ A})
    (m : {x // x ∈ A}) : List J :=
  (List.range (finitePermutationMinimalPeriod (matchingPairPermutation τ υ) m)).map
    (fun r => (finiteMapIterate (matchingPairPermutation τ υ) r m).1)

/-- 閉路ごとの最小元の集合。 -/
noncomputable def cycleMinimaOf {A : Set J} (τ υ : FixedPointFreeInvolution {x // x ∈ A}) :
    Finset {x // x ∈ A} :=
  Finset.univ.image (matchingPairComponentMinimum τ υ)

/-- 閉路を最小元の昇順に並べた点列の列。 -/
noncomputable def cycleWordsOf {A : Set J} (τ υ : FixedPointFreeInvolution {x // x ∈ A}) :
    List (List J) :=
  ((cycleMinimaOf τ υ).sort (· ≤ ·)).map (cyclePointsOf τ υ)

/-- A の外の D の対を昇順に並べた列。 -/
noncomputable def commonPairsOf (D : PerfectMatching J) (A : Set J) : List (J × J) :=
  ((Finset.univ.filter (fun e : J => e ∉ A ∧ e < perfectMatchingMate D e)).sort (· ≤ ·)).map
    (fun e => (e, perfectMatchingMate D e))

section Facts

variable (D D₀ : PerfectMatching J) (A : Set J) (τ υ : FixedPointFreeInvolution {x // x ∈ A})
  (hτ : ∀ i, (τ.val i).1 = perfectMatchingMate D i.1)
  (hυ : ∀ i, (υ.val i).1 = perfectMatchingMate D₀ i.1)
  (hout : ∀ e, e ∉ A → perfectMatchingMate D₀ e = perfectMatchingMate D e)

omit [LinearOrder J] in
include hτ in
/-- A の外の点の D の相手も A の外にある。τ が A を D の相手で閉じるから。 -/
theorem outside_mate_outside (e : J) (he : e ∉ A) : perfectMatchingMate D e ∉ A := by
  intro hm
  apply he
  have h := (τ.val ⟨_, hm⟩).2
  rwa [hτ, perfectMatchingMate_involutive D e] at h

/-- 最小元は自分の成分の最小元であり、第一色に属する。 -/
theorem minimum_self_and_color (i : {x // x ∈ A}) :
    matchingPairComponentMinimum τ υ (matchingPairComponentMinimum τ υ i) =
        matchingPairComponentMinimum τ υ i ∧
      matchingPairComponentMinimum τ υ i ∈ matchingPairColor τ υ := by
  have hself := matchingPairComponentMinimum_basepoint τ υ i _
    (matchingPairComponentMinimum_mem τ υ i)
  refine ⟨hself, ?_⟩
  change _ ∈ finitePermutationOrbit (matchingPairStep τ υ) _
  rw [hself]
  exact finitePermutationOrbit_self_mem _ _

/-- 第一色の点からの反復は、偶数回なら第一色にある。 -/
theorem iterate_color_parity_necSuf (m : {x // x ∈ A}) (hm : m ∈ matchingPairColor τ υ) :
    ∀ r : ℕ, finiteMapIterate (matchingPairPermutation τ υ) r m ∈ matchingPairColor τ υ ↔
      Even r
  | 0 => by simpa [finiteMapIterate] using hm
  | r + 1 => by
      have ih := iterate_color_parity_necSuf m hm r
      have hstep : finiteMapIterate (matchingPairPermutation τ υ) (r + 1) m =
          matchingPairSuccessor τ υ (finiteMapIterate (matchingPairPermutation τ υ) r m) := by
        simp only [finiteMapIterate, Function.iterate_succ_apply']
        rfl
      rw [hstep, matchingPairSuccessor_color, ih, Nat.even_add_one]

include hτ hυ in
/-- 一歩の値。第一色では D の相手、第二色では D₀ の相手へ進む。 -/
theorem iterate_succ_val_necSuf (m : {x // x ∈ A}) (r : ℕ) :
    (finiteMapIterate (matchingPairPermutation τ υ) (r + 1) m).1 =
      if finiteMapIterate (matchingPairPermutation τ υ) r m ∈ matchingPairColor τ υ then
        perfectMatchingMate D (finiteMapIterate (matchingPairPermutation τ υ) r m).1
      else perfectMatchingMate D₀ (finiteMapIterate (matchingPairPermutation τ υ) r m).1 := by
  have hstep : finiteMapIterate (matchingPairPermutation τ υ) (r + 1) m =
      matchingPairSuccessor τ υ (finiteMapIterate (matchingPairPermutation τ υ) r m) := by
    simp only [finiteMapIterate, Function.iterate_succ_apply']
    rfl
  rw [hstep, matchingPairSuccessor]
  split_ifs
  · exact hτ _
  · exact hυ _

/-- 周期は正で偶数で、周期で戻る。 -/
theorem cycle_period_necSuf (m : {x // x ∈ A}) :
    0 < finitePermutationMinimalPeriod (matchingPairPermutation τ υ) m ∧
      Even (finitePermutationMinimalPeriod (matchingPairPermutation τ υ) m) ∧
      finiteMapIterate (matchingPairPermutation τ υ)
        (finitePermutationMinimalPeriod (matchingPairPermutation τ υ) m) m = m := by
  have hs := finitePermutationMinimalPeriod_spec (matchingPairPermutation τ υ) m
  refine ⟨hs.1, ?_, hs.2.1⟩
  rw [finitePermutationMinimalPeriod_eq_orbitLength]
  exact matchingPairPermutation_even_orbit _ _ m

theorem cyclePoints_even_necSuf (m : {x // x ∈ A}) :
    cyclePointsOf τ υ m ≠ [] ∧ Even (cyclePointsOf τ υ m).length := by
  obtain ⟨hpos, hev, _⟩ := cycle_period_necSuf A τ υ m
  unfold cyclePointsOf
  refine ⟨?_, by simpa using hev⟩
  intro h
  have := congrArg List.length h
  simp at this
  omega

include hτ hυ in
theorem cycle_pairs_D_necSuf (i : {x // x ∈ A}) :
    ∀ p ∈ consecutivePairs (cyclePointsOf τ υ (matchingPairComponentMinimum τ υ i)),
      ({p.1, p.2} : Set J) ∈ D.val := by
  intro p hp
  set m := matchingPairComponentMinimum τ υ i
  obtain ⟨k, hk⟩ := (cycle_period_necSuf A τ υ m).2.1
  have hk2 : finitePermutationMinimalPeriod (matchingPairPermutation τ υ) m = 2 * k := by omega
  unfold cyclePointsOf at hp
  rw [hk2, consecutivePairs_map_range] at hp
  obtain ⟨r, _, rfl⟩ := List.mem_map.mp hp
  have hcol := (iterate_color_parity_necSuf A τ υ m (minimum_self_and_color A τ υ i).2
    (2 * r)).mpr (even_two_mul r)
  simp only
  rw [iterate_succ_val_necSuf D D₀ A τ υ hτ hυ m (2 * r), if_pos hcol]
  exact (perfectMatchingMate_spec D _).2

include hτ hυ in
theorem cycle_pairs_reference_necSuf (i : {x // x ∈ A}) :
    ∀ p ∈ consecutivePairs ((cyclePointsOf τ υ (matchingPairComponentMinimum τ υ i)).rotate 1),
      ({p.1, p.2} : Set J) ∈ D₀.val := by
  intro p hp
  set m := matchingPairComponentMinimum τ υ i
  obtain ⟨hpos, ⟨k, hk⟩, hper⟩ := cycle_period_necSuf A τ υ m
  have hk2 : finitePermutationMinimalPeriod (matchingPairPermutation τ υ) m = 2 * k := by omega
  unfold cyclePointsOf at hp
  rw [rotate_one_map_range _ _ hpos (by rw [hper]; rfl), hk2, consecutivePairs_map_range] at hp
  obtain ⟨r, _, rfl⟩ := List.mem_map.mp hp
  have hcol : ¬ finiteMapIterate (matchingPairPermutation τ υ) (2 * r + 1) m ∈
      matchingPairColor τ υ := by
    rw [iterate_color_parity_necSuf A τ υ m (minimum_self_and_color A τ υ i).2 (2 * r + 1)]
    exact Nat.not_even_iff_odd.mpr (odd_two_mul_add_one r)
  simp only
  rw [iterate_succ_val_necSuf D D₀ A τ υ hτ hυ m (2 * r + 1), if_neg hcol]
  exact (perfectMatchingMate_spec _ _).2

theorem cyclePoints_mem_component_necSuf (m : {x // x ∈ A}) (x : J)
    (hx : x ∈ cyclePointsOf τ υ m) :
    ∃ h : x ∈ A, (⟨x, h⟩ : {x // x ∈ A}) ∈ matchingPairComponent τ υ m := by
  unfold cyclePointsOf at hx
  obtain ⟨r, _, rfl⟩ := List.mem_map.mp hx
  refine ⟨(finiteMapIterate (matchingPairPermutation τ υ) r m).2, ?_⟩
  rw [← matchingPairPermutation_orbit_eq_component]
  exact ⟨r, Or.inl rfl⟩

theorem cyclePoints_nodup_necSuf (m : {x // x ∈ A}) : (cyclePointsOf τ υ m).Nodup := by
  unfold cyclePointsOf
  apply List.Nodup.map_on _ List.nodup_range
  intro r hr s hs hrs
  have hinj := (finitePermutationOrbitEnumeration_bijective (matchingPairPermutation τ υ) m).1
  have := @hinj ⟨r, List.mem_range.mp hr⟩ ⟨s, List.mem_range.mp hs⟩
    (Subtype.ext (Subtype.ext hrs))
  exact congrArg Fin.val this

theorem cyclePoints_disjoint_necSuf (m₁ m₂ : {x // x ∈ A})
    (h₁ : m₁ ∈ cycleMinimaOf τ υ) (h₂ : m₂ ∈ cycleMinimaOf τ υ) (hne : m₁ ≠ m₂) :
    List.Disjoint (cyclePointsOf τ υ m₁) (cyclePointsOf τ υ m₂) := by
  intro x hx₁ hx₂
  obtain ⟨i₁, _, rfl⟩ := Finset.mem_image.mp h₁
  obtain ⟨i₂, _, rfl⟩ := Finset.mem_image.mp h₂
  obtain ⟨ha, hc₁⟩ := cyclePoints_mem_component_necSuf A τ υ _ x hx₁
  obtain ⟨_, hc₂⟩ := cyclePoints_mem_component_necSuf A τ υ _ x hx₂
  apply hne
  calc
    matchingPairComponentMinimum τ υ i₁ =
        matchingPairComponentMinimum τ υ (matchingPairComponentMinimum τ υ i₁) :=
      ((minimum_self_and_color A τ υ i₁).1).symm
    _ = matchingPairComponentMinimum τ υ ⟨x, ha⟩ :=
      (matchingPairComponentMinimum_basepoint τ υ _ _ hc₁).symm
    _ = matchingPairComponentMinimum τ υ (matchingPairComponentMinimum τ υ i₂) :=
      matchingPairComponentMinimum_basepoint τ υ _ _ hc₂
    _ = matchingPairComponentMinimum τ υ i₂ := (minimum_self_and_color A τ υ i₂).1

theorem cycleWords_flatten_nodup_necSuf : (cycleWordsOf τ υ).flatten.Nodup := by
  unfold cycleWordsOf
  rw [List.nodup_flatten]
  refine ⟨fun l hl => ?_, ?_⟩
  · obtain ⟨m, _, rfl⟩ := List.mem_map.mp hl
    exact cyclePoints_nodup_necSuf A τ υ m
  · rw [List.pairwise_map]
    apply List.Nodup.pairwise_of_forall_ne (Finset.sort_nodup _ _)
    intro a ha b hb hab
    exact cyclePoints_disjoint_necSuf A τ υ a b ((Finset.mem_sort _).mp ha)
      ((Finset.mem_sort _).mp hb) hab

include hτ in
theorem commonPairs_outside_necSuf (x : J) (hx : x ∈ matchingPairWord (commonPairsOf D A)) :
    x ∉ A := by
  obtain ⟨p, hp, hxp⟩ := List.mem_flatMap.mp hx
  obtain ⟨e, he, rfl⟩ := List.mem_map.mp hp
  have he' := (Finset.mem_filter.mp ((Finset.mem_sort _).mp he)).2
  simp only [List.mem_cons, List.not_mem_nil, or_false] at hxp
  rcases hxp with rfl | rfl
  · exact he'.1
  · exact outside_mate_outside D A τ hτ e he'.1

theorem commonPairs_nodup_necSuf : (matchingPairWord (commonPairsOf D A)).Nodup := by
  unfold commonPairsOf matchingPairWord
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

include hτ in
theorem cycleWords_complete_necSuf :
    IsCompleteWord ((cycleWordsOf τ υ).flatten ++ matchingPairWord (commonPairsOf D A)) := by
  constructor
  · rw [List.nodup_append]
    refine ⟨cycleWords_flatten_nodup_necSuf A τ υ, commonPairs_nodup_necSuf D A, ?_⟩
    intro x hx y hy hxy
    subst hxy
    apply commonPairs_outside_necSuf D A τ hτ x hy
    obtain ⟨l, hl, hxl⟩ := List.mem_flatten.mp hx
    obtain ⟨m, _, rfl⟩ := List.mem_map.mp hl
    exact (cyclePoints_mem_component_necSuf A τ υ m x hxl).1
  · intro x
    by_cases hx : x ∈ A
    · apply List.mem_append_left
      let xx : {x // x ∈ A} := ⟨x, hx⟩
      let m := matchingPairComponentMinimum τ υ xx
      have hm : m ∈ cycleMinimaOf τ υ := Finset.mem_image_of_mem _ (Finset.mem_univ _)
      have horbit : xx ∈ finitePermutationOrbit (matchingPairPermutation τ υ) m := by
        rw [matchingPairPermutation_orbit_eq_component,
          matchingPairComponent_basepoint τ υ xx m (matchingPairComponentMinimum_mem τ υ xx)]
        exact Or.inl (finitePermutationOrbit_self_mem _ _)
      obtain ⟨r, hr⟩ := (finitePermutationOrbitEnumeration_bijective
        (matchingPairPermutation τ υ) m).2 ⟨xx, horbit⟩
      refine List.mem_flatten.mpr ⟨cyclePointsOf τ υ m,
        List.mem_map.mpr ⟨m, (Finset.mem_sort _).mpr hm, rfl⟩, ?_⟩
      refine List.mem_map.mpr ⟨r.val, List.mem_range.mpr r.isLt, ?_⟩
      exact congrArg (fun y => y.1.1) hr
    · apply List.mem_append_right
      have hout' := outside_mate_outside D A τ hτ x hx
      rcases lt_or_gt_of_ne (perfectMatchingMate_ne D x).symm with hlt | hgt
      · refine List.mem_flatMap.mpr ⟨(x, perfectMatchingMate D x), ?_, by simp⟩
        exact List.mem_map.mpr ⟨x, (Finset.mem_sort _).mpr
          (Finset.mem_filter.mpr ⟨Finset.mem_univ _, hx, hlt⟩), rfl⟩
      · let y := perfectMatchingMate D x
        have hyx : perfectMatchingMate D y = x := perfectMatchingMate_involutive D x
        refine List.mem_flatMap.mpr ⟨(y, perfectMatchingMate D y), ?_, by simp [hyx]⟩
        exact List.mem_map.mpr ⟨y, (Finset.mem_sort _).mpr
          (Finset.mem_filter.mpr ⟨Finset.mem_univ _, hout', by rw [hyx]; exact hgt⟩), rfl⟩

include hout in
theorem commonPairs_spec_necSuf :
    ∀ p ∈ commonPairsOf D A, p.1 < p.2 ∧ ({p.1, p.2} : Set J) ∈ D.val ∧
      ({p.1, p.2} : Set J) ∈ D₀.val := by
  intro p hp
  obtain ⟨e, he, rfl⟩ := List.mem_map.mp hp
  have he' := (Finset.mem_filter.mp ((Finset.mem_sort _).mp he)).2
  refine ⟨he'.2, (perfectMatchingMate_spec D e).2, ?_⟩
  rw [← hout e he'.1]
  exact (perfectMatchingMate_spec _ e).2

end Facts

/-- 必要十分版の主張。sgn_F(D) sgn_F(D₀) = (-1)^{閉路の数} ∏ α_D(C) α₀(C)。 -/
theorem tagged_alternating_cycles_matching_sign_necSuf {R : Type*} [CommRing R]
    (F : List J → R)
    (hswap : ∀ (u : List J) (a b : J) (v : List J),
      IsCompleteWord (u ++ a :: b :: v) → F (u ++ b :: a :: v) = -F (u ++ a :: b :: v))
    (D D₀ : PerfectMatching J) (A : Set J) (τ υ : FixedPointFreeInvolution {x // x ∈ A})
    (hτ : ∀ i, (τ.val i).1 = perfectMatchingMate D i.1)
    (hυ : ∀ i, (υ.val i).1 = perfectMatchingMate D₀ i.1)
    (hout : ∀ e, e ∉ A → perfectMatchingMate D₀ e = perfectMatchingMate D e)
    (hsD : matchingSignOf F D * matchingSignOf F D = 1) :
    matchingSignOf F D * matchingSignOf F D₀ =
      (-1) ^ (cycleMinimaOf τ υ).card * ((cycleWordsOf τ υ).map (fun c =>
        ((consecutivePairs c).map (pairOrientationIn R)).prod *
          ((consecutivePairs (c.rotate 1)).map (pairOrientationIn R)).prod)).prod := by
  have hlen : (cycleWordsOf τ υ).length = (cycleMinimaOf τ υ).card := by
    simp [cycleWordsOf]
  rw [← hlen]
  apply alternating_cycle_matching_sign_necSuf F hswap D D₀ (cycleWordsOf τ υ) (commonPairsOf D A)
  · intro c hc
    obtain ⟨m, _, rfl⟩ := List.mem_map.mp hc
    exact cyclePoints_even_necSuf A τ υ m
  · exact cycleWords_complete_necSuf D A τ υ hτ
  · intro c hc
    obtain ⟨m, hm, rfl⟩ := List.mem_map.mp hc
    obtain ⟨i, _, rfl⟩ := Finset.mem_image.mp ((Finset.mem_sort _).mp hm)
    exact cycle_pairs_D_necSuf D D₀ A τ υ hτ hυ i
  · intro c hc
    obtain ⟨m, hm, rfl⟩ := List.mem_map.mp hc
    obtain ⟨i, _, rfl⟩ := Finset.mem_image.mp ((Finset.mem_sort _).mp hm)
    exact cycle_pairs_reference_necSuf D D₀ A τ υ hτ hυ i
  · exact commonPairs_spec_necSuf D D₀ A hout
  · exact hsD

end Ising2DLambda.NecSuf.KacWard
