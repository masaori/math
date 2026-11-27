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
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairColoring
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairEvenOrbit
import Ising2DLambda.NecSuf.KacWard.MatchingPairOutsideEnumeration

namespace Ising2DLambda.NecSuf.KacWard

open Ising2DLambda.AlgebraicEigenvalue
attribute [local instance] Classical.propDecidable

variable {J : Type*} [Fintype J] [LinearOrder J]

/-- 周期の終点が始点に戻る点列を一つ左へ巡回移動する。 -/
private theorem rotate_range_of_period {K : Type*} (n : ℕ) (f : ℕ → K)
    (hn : 0 < n) (hper : f n = f 0) :
    ((List.range n).map f).rotate 1 =
      (List.range n).map (fun r => f (r + 1)) := by
  obtain ⟨k, rfl⟩ := Nat.exists_eq_add_of_lt hn
  simp only [zero_add] at hper ⊢
  conv_lhs => rw [List.range_succ_eq_map, List.map_cons, List.map_map, List.rotate_cons_succ,
    List.rotate_zero]
  rw [List.range_succ, List.map_append, List.map_singleton, hper]
  rfl

/-- 周期と反復を指定した軌道を、始点から一周期だけ読む点列。 -/
def cyclePointsOf {K : Type*} (period : K → ℕ) (iterate : ℕ → K → K)
    (point : K → J) (m : K) : List J :=
  (List.range (period m)).map (fun r => point (iterate r m))

/-- 各点から選んだ代表点の集合。成分の最小元を選ぶ場合に閉路の最小元集合となる。 -/
noncomputable def cycleMinimaOf {K : Type*} [Fintype K] (minimum : K → K) : Finset K := by
  classical
  exact Finset.univ.image minimum

theorem mem_cycleMinimaOf {K : Type*} [Fintype K] (minimum : K → K) (x : K) :
    x ∈ cycleMinimaOf minimum ↔ ∃ i, minimum i = x := by
  classical
  simp [cycleMinimaOf]

/-- 代表点を昇順に並べ、各代表点から一周期の点列を読む。 -/
noncomputable def cycleWordsOf {K : Type*} [Fintype K] [LinearOrder K]
    (minimum : K → K) (period : K → ℕ) (iterate : ℕ → K → K)
    (point : K → J) : List (List J) :=
  ((cycleMinimaOf minimum).sort (· ≤ ·)).map (cyclePointsOf period iterate point)

section Facts

variable (D D₀ : PerfectMatching J) (A : Set J) (τ υ : FixedPointFreeInvolution {x // x ∈ A})
  (hτ : ∀ i, (τ.val i).1 = perfectMatchingMate D i.1)
  (hυ : ∀ i, (υ.val i).1 = perfectMatchingMate D₀ i.1)
  (hout : ∀ e, e ∉ A → perfectMatchingMate D₀ e = perfectMatchingMate D e)

omit [Fintype J] [LinearOrder J] in
/-- 対合が A を保てば、A の外も保つ。 -/
theorem outside_mate_outside (mate : J → J) (A : Set J)
    (hinv : ∀ e, mate (mate e) = e)
    (hclosed : ∀ e, e ∈ A → mate e ∈ A)
    (e : J) (he : e ∉ A) : mate e ∉ A := by
  intro hm
  apply he
  have h := hclosed (mate e) hm
  rwa [hinv] at h

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

/-- 周期は正で偶数で、周期で戻る。 -/
theorem cycle_period_necSuf (m : {x // x ∈ A}) :
    0 < finitePermutationMinimalPeriod (matchingPairPermutation τ υ) m ∧
      Even (finitePermutationMinimalPeriod (matchingPairPermutation τ υ) m) ∧
      finiteMapIterate (matchingPairPermutation τ υ)
        (finitePermutationMinimalPeriod (matchingPairPermutation τ υ) m) m = m := by
  have hs := finitePermutationMinimalPeriod_spec (matchingPairPermutation τ υ) m
  refine ⟨hs.1, ?_, hs.2.1⟩
  exact Ising2DLambda.NecSuf.AlgebraicEigenvalue.even_of_color_flip
    (matchingPairPermutation τ υ) (fun j => j ∈ matchingPairColor τ υ)
    (matchingPairSuccessor_color τ υ)
    _ m hs.2.1

theorem cyclePoints_even_necSuf (m : {x // x ∈ A}) :
    cyclePointsOf (finitePermutationMinimalPeriod (matchingPairPermutation τ υ))
      (finiteMapIterate (matchingPairPermutation τ υ)) Subtype.val m ≠ [] ∧ Even (cyclePointsOf (finitePermutationMinimalPeriod (matchingPairPermutation τ υ))
      (finiteMapIterate (matchingPairPermutation τ υ)) Subtype.val m).length := by
  obtain ⟨hpos, hev, _⟩ := cycle_period_necSuf A τ υ m
  unfold cyclePointsOf
  refine ⟨?_, by simpa using hev⟩
  intro h
  have := congrArg List.length h
  simp at this
  omega

theorem cycle_pairs_D_necSuf (D' : Set (Set J)) (mate : J → J)
    (hτ' : ∀ i, (τ.val i).1 = mate i.1)
    (hD' : ∀ e, ({e, mate e} : Set J) ∈ D')
    (i : {x // x ∈ A}) :
    ∀ p ∈ pairChunks (cyclePointsOf (finitePermutationMinimalPeriod (matchingPairPermutation τ υ))
      (finiteMapIterate (matchingPairPermutation τ υ)) Subtype.val (Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum τ υ i)),
      ({p.1, p.2} : Set J) ∈ D' := by
  intro p hp
  set m := Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum τ υ i
  obtain ⟨k, hk⟩ := (cycle_period_necSuf A τ υ m).2.1
  have hk2 : finitePermutationMinimalPeriod (matchingPairPermutation τ υ) m = 2 * k := by omega
  unfold cyclePointsOf at hp
  rw [hk2, pairChunks_map_range] at hp
  obtain ⟨r, _, rfl⟩ := List.mem_map.mp hp
  have hmin := Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairMinimum_self_and_color
    τ υ (· ≤ ·) (fun _ _ => le_antisymm) (Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum τ υ)
    (Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum_mem τ υ) (Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum_le τ υ) i
  have hcol := (iterate_color_parity_necSuf A τ υ m hmin.2
    (2 * r)).mpr (even_two_mul r)
  simp only
  rw [show (finiteMapIterate (matchingPairPermutation τ υ) (2 * r + 1) m).1 =
      mate (finiteMapIterate (matchingPairPermutation τ υ) (2 * r) m).1 from by
        have hstep : finiteMapIterate (matchingPairPermutation τ υ) (2 * r + 1) m =
            matchingPairSuccessor τ υ (finiteMapIterate (matchingPairPermutation τ υ) (2 * r) m) := by
          simp only [finiteMapIterate, Function.iterate_succ_apply']
          rfl
        rw [hstep, matchingPairSuccessor, if_pos hcol]
        exact hτ' _]
  exact hD' _

theorem cycle_pairs_reference_necSuf (D₀' : Set (Set J)) (mate : J → J)
    (hυ' : ∀ i, (υ.val i).1 = mate i.1)
    (hD₀' : ∀ e, ({e, mate e} : Set J) ∈ D₀')
    (i : {x // x ∈ A}) :
    ∀ p ∈ pairChunks ((cyclePointsOf (finitePermutationMinimalPeriod (matchingPairPermutation τ υ))
      (finiteMapIterate (matchingPairPermutation τ υ)) Subtype.val (Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum τ υ i)).rotate 1),
      ({p.1, p.2} : Set J) ∈ D₀' := by
  intro p hp
  set m := Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum τ υ i
  obtain ⟨hpos, ⟨k, hk⟩, hper⟩ := cycle_period_necSuf A τ υ m
  have hk2 : finitePermutationMinimalPeriod (matchingPairPermutation τ υ) m = 2 * k := by omega
  unfold cyclePointsOf at hp
  rw [rotate_range_of_period _ _ hpos (by rw [hper]; rfl), hk2, pairChunks_map_range] at hp
  obtain ⟨r, _, rfl⟩ := List.mem_map.mp hp
  have hmin := Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairMinimum_self_and_color
    τ υ (· ≤ ·) (fun _ _ => le_antisymm) (Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum τ υ)
    (Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum_mem τ υ) (Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum_le τ υ) i
  have hcol : ¬ finiteMapIterate (matchingPairPermutation τ υ) (2 * r + 1) m ∈
      matchingPairColor τ υ := by
    rw [iterate_color_parity_necSuf A τ υ m hmin.2 (2 * r + 1)]
    exact Nat.not_even_iff_odd.mpr (odd_two_mul_add_one r)
  simp only
  rw [show (finiteMapIterate (matchingPairPermutation τ υ) (2 * r + 1 + 1) m).1 =
      mate (finiteMapIterate (matchingPairPermutation τ υ) (2 * r + 1) m).1 from by
        have hstep : finiteMapIterate (matchingPairPermutation τ υ) (2 * r + 1 + 1) m =
            matchingPairSuccessor τ υ
              (finiteMapIterate (matchingPairPermutation τ υ) (2 * r + 1) m) := by
          simp only [finiteMapIterate, Function.iterate_succ_apply']
          rfl
        rw [hstep, matchingPairSuccessor, if_neg hcol]
        exact hυ' _]
  exact hD₀' _

theorem cyclePoints_mem_component_necSuf (m : {x // x ∈ A}) (x : J)
    (hx : x ∈ cyclePointsOf (finitePermutationMinimalPeriod (matchingPairPermutation τ υ))
      (finiteMapIterate (matchingPairPermutation τ υ)) Subtype.val m) :
    ∃ h : x ∈ A, (⟨x, h⟩ : {x // x ∈ A}) ∈ matchingPairComponent τ υ m := by
  unfold cyclePointsOf at hx
  obtain ⟨r, _, rfl⟩ := List.mem_map.mp hx
  refine ⟨(finiteMapIterate (matchingPairPermutation τ υ) r m).2, ?_⟩
  rw [← matchingPairPermutation_orbit_eq_component]
  exact ⟨r, Or.inl rfl⟩

theorem cyclePoints_nodup_necSuf (m : {x // x ∈ A}) : (cyclePointsOf (finitePermutationMinimalPeriod (matchingPairPermutation τ υ))
      (finiteMapIterate (matchingPairPermutation τ υ)) Subtype.val m).Nodup := by
  unfold cyclePointsOf
  apply List.Nodup.map_on _ List.nodup_range
  intro r hr s hs hrs
  have hinj := (finitePermutationOrbitEnumeration_bijective (matchingPairPermutation τ υ) m).1
  have := @hinj ⟨r, List.mem_range.mp hr⟩ ⟨s, List.mem_range.mp hs⟩
    (Subtype.ext (Subtype.ext hrs))
  exact congrArg Fin.val this

theorem cyclePoints_disjoint_necSuf (m₁ m₂ : {x // x ∈ A})
    (h₁ : m₁ ∈ cycleMinimaOf (Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum τ υ)) (h₂ : m₂ ∈ cycleMinimaOf (Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum τ υ)) (hne : m₁ ≠ m₂) :
    List.Disjoint (cyclePointsOf (finitePermutationMinimalPeriod (matchingPairPermutation τ υ))
      (finiteMapIterate (matchingPairPermutation τ υ)) Subtype.val m₁) (cyclePointsOf (finitePermutationMinimalPeriod (matchingPairPermutation τ υ))
      (finiteMapIterate (matchingPairPermutation τ υ)) Subtype.val m₂) := by
  intro x hx₁ hx₂
  obtain ⟨i₁, rfl⟩ := (mem_cycleMinimaOf _ _).mp h₁
  obtain ⟨i₂, rfl⟩ := (mem_cycleMinimaOf _ _).mp h₂
  obtain ⟨ha, hc₁⟩ := cyclePoints_mem_component_necSuf A τ υ _ x hx₁
  obtain ⟨_, hc₂⟩ := cyclePoints_mem_component_necSuf A τ υ _ x hx₂
  have hbase (j : {x // x ∈ A})
      (hj : ⟨x, ha⟩ ∈ matchingPairComponent τ υ j) :
      Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum τ υ ⟨x, ha⟩ = Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum τ υ j := by
    apply Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairMinimum_basepoint
      τ υ (· ≤ ·) (fun _ _ => le_antisymm) (Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum τ υ)
      (Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum_mem τ υ) (Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum_le τ υ)
    exact hj
  have hmin (j : {x // x ∈ A}) :=
    Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairMinimum_self_and_color
      τ υ (· ≤ ·) (fun _ _ => le_antisymm) (Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum τ υ)
      (Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum_mem τ υ) (Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum_le τ υ) j
  apply hne
  calc
    Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum τ υ i₁ =
        Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum τ υ (Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum τ υ i₁) :=
      (hmin i₁).1.symm
    _ = Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum τ υ ⟨x, ha⟩ :=
      (hbase _ hc₁).symm
    _ = Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum τ υ (Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum τ υ i₂) :=
      hbase _ hc₂
    _ = Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum τ υ i₂ := (hmin i₂).1

theorem cycleWords_flatten_nodup_necSuf : (cycleWordsOf (Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum τ υ)
    (finitePermutationMinimalPeriod (matchingPairPermutation τ υ))
    (finiteMapIterate (matchingPairPermutation τ υ)) Subtype.val).flatten.Nodup := by
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
theorem cycleWords_complete_necSuf :
    IsCompleteWord ((cycleWordsOf (Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum τ υ)
    (finitePermutationMinimalPeriod (matchingPairPermutation τ υ))
    (finiteMapIterate (matchingPairPermutation τ υ)) Subtype.val).flatten ++
      matchingPairWord (matchingPairOutsideEnumeration (perfectMatchingMate D) A)) := by
  constructor
  · rw [List.nodup_append]
    refine ⟨cycleWords_flatten_nodup_necSuf A τ υ,
      matchingPairOutsideEnumeration_nodup (perfectMatchingMate D) A
        (perfectMatchingMate_ne D) (perfectMatchingMate_involutive D), ?_⟩
    intro x hx y hy hxy
    subst hxy
    apply matchingPairOutsideEnumeration_outside (perfectMatchingMate D) A
      (perfectMatchingMate_involutive D) (fun e he => by
        have h := (τ.val ⟨e, he⟩).2
        rwa [hτ] at h) x hy
    obtain ⟨l, hl, hxl⟩ := List.mem_flatten.mp hx
    obtain ⟨m, _, rfl⟩ := List.mem_map.mp hl
    exact (cyclePoints_mem_component_necSuf A τ υ m x hxl).1
  · intro x
    by_cases hx : x ∈ A
    · apply List.mem_append_left
      let xx : {x // x ∈ A} := ⟨x, hx⟩
      let m := Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum τ υ xx
      have hm : m ∈ cycleMinimaOf (Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum τ υ) :=
        (mem_cycleMinimaOf _ _).mpr ⟨xx, rfl⟩
      have horbit : xx ∈ finitePermutationOrbit (matchingPairPermutation τ υ) m := by
        rw [matchingPairPermutation_orbit_eq_component,
          matchingPairComponent_basepoint τ υ xx m (Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum_mem τ υ xx)]
        exact Or.inl (finitePermutationOrbit_self_mem _ _)
      obtain ⟨r, hr⟩ := (finitePermutationOrbitEnumeration_bijective
        (matchingPairPermutation τ υ) m).2 ⟨xx, horbit⟩
      refine List.mem_flatten.mpr ⟨cyclePointsOf (finitePermutationMinimalPeriod (matchingPairPermutation τ υ))
      (finiteMapIterate (matchingPairPermutation τ υ)) Subtype.val m,
        List.mem_map.mpr ⟨m, (Finset.mem_sort _).mpr hm, rfl⟩, ?_⟩
      refine List.mem_map.mpr ⟨r.val, List.mem_range.mpr r.isLt, ?_⟩
      exact congrArg (fun y => y.1.1) hr
    · apply List.mem_append_right
      have hout' := outside_mate_outside (perfectMatchingMate D) A
        (perfectMatchingMate_involutive D)
        (fun e he => by
          have h := (τ.val ⟨e, he⟩).2
          rwa [hτ] at h) x hx
      rcases lt_or_gt_of_ne (perfectMatchingMate_ne D x).symm with hlt | hgt
      · refine List.mem_flatMap.mpr ⟨(x, perfectMatchingMate D x), ?_, by simp⟩
        exact List.mem_map.mpr ⟨x, (Finset.mem_sort _).mpr
          (Finset.mem_filter.mpr ⟨Finset.mem_univ _, hx, hlt⟩), rfl⟩
      · let y := perfectMatchingMate D x
        have hyx : perfectMatchingMate D y = x := perfectMatchingMate_involutive D x
        refine List.mem_flatMap.mpr ⟨(y, perfectMatchingMate D y), ?_, by simp [hyx]⟩
        exact List.mem_map.mpr ⟨y, (Finset.mem_sort _).mpr
          (Finset.mem_filter.mpr ⟨Finset.mem_univ _, hout', by rw [hyx]; exact hgt⟩), rfl⟩

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
      (-1) ^ (cycleMinimaOf (Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum τ υ)).card * ((cycleWordsOf (Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum τ υ)
    (finitePermutationMinimalPeriod (matchingPairPermutation τ υ))
    (finiteMapIterate (matchingPairPermutation τ υ)) Subtype.val).map (fun c =>
        ((pairChunks c).map (pairOrientationIn R)).prod *
          ((pairChunks (c.rotate 1)).map (pairOrientationIn R)).prod)).prod := by
  have hlen : (cycleWordsOf (Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum τ υ)
    (finitePermutationMinimalPeriod (matchingPairPermutation τ υ))
    (finiteMapIterate (matchingPairPermutation τ υ)) Subtype.val).length = (cycleMinimaOf (Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum τ υ)).card := by
    simp [cycleWordsOf]
  rw [← hlen]
  apply alternating_cycle_matching_sign_necSuf F hswap D D₀ (cycleWordsOf (Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum τ υ)
    (finitePermutationMinimalPeriod (matchingPairPermutation τ υ))
    (finiteMapIterate (matchingPairPermutation τ υ)) Subtype.val)
    (matchingPairOutsideEnumeration (perfectMatchingMate D) A)
  · intro c hc
    obtain ⟨m, _, rfl⟩ := List.mem_map.mp hc
    exact cyclePoints_even_necSuf A τ υ m
  · exact cycleWords_complete_necSuf D A τ υ hτ
  · intro c hc
    obtain ⟨m, hm, rfl⟩ := List.mem_map.mp hc
    obtain ⟨i, rfl⟩ := (mem_cycleMinimaOf _ _).mp ((Finset.mem_sort _).mp hm)
    exact cycle_pairs_D_necSuf A τ υ D.val (perfectMatchingMate D)
      hτ (fun e => (perfectMatchingMate_spec D e).2) i
  · intro c hc
    obtain ⟨m, hm, rfl⟩ := List.mem_map.mp hc
    obtain ⟨i, rfl⟩ := (mem_cycleMinimaOf _ _).mp ((Finset.mem_sort _).mp hm)
    exact cycle_pairs_reference_necSuf A τ υ D₀.val (perfectMatchingMate D₀)
      hυ (fun e => (perfectMatchingMate_spec D₀ e).2) i
  · exact matchingPairOutsideEnumeration_spec D.val D₀.val
      (perfectMatchingMate D) (perfectMatchingMate D₀) A
      (fun e => (perfectMatchingMate_spec D e).2)
      (fun e => (perfectMatchingMate_spec D₀ e).2) hout
  · exact hsD

end Ising2DLambda.NecSuf.KacWard
