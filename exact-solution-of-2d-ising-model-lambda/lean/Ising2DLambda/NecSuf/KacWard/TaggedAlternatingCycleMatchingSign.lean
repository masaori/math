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

omit [Fintype J] [LinearOrder J] in
/-- 色を反転する写像の反復は、偶数回だけ初期の色に戻る。 -/
theorem iterate_color_parity_necSuf {K : Type*} (successor : K → K) (color : K → Prop)
    (iterate : ℕ → K → K)
    (hiterate : ∀ n m, iterate n m = successor^[n] m)
    (hflip : ∀ m, color (successor m) ↔ ¬ color m)
    (m : K) (hm : color m) :
    ∀ r : ℕ, color (iterate r m) ↔ Even r
  | 0 => by simpa [hiterate 0 m] using hm
  | r + 1 => by
      have ih := iterate_color_parity_necSuf successor color iterate hiterate hflip m hm r
      rw [hiterate, Function.iterate_succ_apply', ← hiterate r m, hflip, ih,
        Nat.even_add_one]

omit [Fintype J] [LinearOrder J] in
/-- 帰還時刻が正で、後続写像が色を反転すれば、帰還時刻は偶数。 -/
theorem cycle_period_necSuf {K : Type*} (successor : K → K) (color : K → Prop)
    (period : K → ℕ) (iterate : ℕ → K → K)
    (hiterate : ∀ n m, iterate n m = successor^[n] m)
    (hflip : ∀ m, color (successor m) ↔ ¬ color m)
    (hperiod : ∀ m, 0 < period m ∧ iterate (period m) m = m)
    (m : K) :
    0 < period m ∧ Even (period m) ∧ iterate (period m) m = m := by
  obtain ⟨hpos, hreturn⟩ := hperiod m
  refine ⟨hpos, ?_, hreturn⟩
  exact Ising2DLambda.NecSuf.AlgebraicEigenvalue.even_of_color_flip
    successor color hflip _ m ((hiterate _ _).symm ▸ hreturn)

omit [Fintype J] [LinearOrder J] in
theorem cyclePoints_even_necSuf {K : Type*} (period : K → ℕ)
    (iterate : ℕ → K → K) (point : K → J) (m : K)
    (hpos : 0 < period m) (hev : Even (period m)) :
    cyclePointsOf period iterate point m ≠ [] ∧
      Even (cyclePointsOf period iterate point m).length := by
  unfold cyclePointsOf
  refine ⟨?_, by simpa using hev⟩
  intro h
  have := congrArg List.length h
  simp at this
  omega

omit [Fintype J] [LinearOrder J] in
theorem cycle_pairs_D_necSuf {K : Type*} (D' : Set (Set J)) (mate : J → J)
    (hD' : ∀ e, ({e, mate e} : Set J) ∈ D')
    (period : K → ℕ) (iterate : ℕ → K → K) (point : K → J) (m : K)
    (heven : Even (period m))
    (hstep : ∀ r, point (iterate (2 * r + 1) m) = mate (point (iterate (2 * r) m))) :
    ∀ p ∈ pairChunks (cyclePointsOf period iterate point m),
      ({p.1, p.2} : Set J) ∈ D' := by
  intro p hp
  obtain ⟨k, hk⟩ := heven
  unfold cyclePointsOf at hp
  rw [hk, show k + k = 2 * k by omega, pairChunks_map_range] at hp
  obtain ⟨r, _, rfl⟩ := List.mem_map.mp hp
  simp only
  rw [hstep r]
  exact hD' _

omit [Fintype J] [LinearOrder J] in
theorem cycle_pairs_reference_necSuf {K : Type*} (D₀' : Set (Set J)) (mate : J → J)
    (hD₀' : ∀ e, ({e, mate e} : Set J) ∈ D₀')
    (period : K → ℕ) (iterate : ℕ → K → K) (point : K → J) (m : K)
    (hpos : 0 < period m) (heven : Even (period m))
    (hreturn : point (iterate (period m) m) = point (iterate 0 m))
    (hstep : ∀ r, point (iterate (2 * r + 1 + 1) m) =
      mate (point (iterate (2 * r + 1) m))) :
    ∀ p ∈ pairChunks ((cyclePointsOf period iterate point m).rotate 1),
      ({p.1, p.2} : Set J) ∈ D₀' := by
  intro p hp
  obtain ⟨k, hk⟩ := heven
  unfold cyclePointsOf at hp
  rw [rotate_range_of_period _ _ hpos hreturn, hk,
    show k + k = 2 * k by omega, pairChunks_map_range] at hp
  obtain ⟨r, _, rfl⟩ := List.mem_map.mp hp
  simp only
  rw [hstep r]
  exact hD₀' _

omit [Fintype J] [LinearOrder J] in
theorem cyclePoints_mem_component_necSuf
    (period : {x // x ∈ A} → ℕ)
    (iterate : ℕ → {x // x ∈ A} → {x // x ∈ A})
    (component : {x // x ∈ A} → Set {x // x ∈ A})
    (m : {x // x ∈ A}) (x : J)
    (hiterate : ∀ r, iterate r m ∈ component m)
    (hx : x ∈ cyclePointsOf period iterate Subtype.val m) :
    ∃ h : x ∈ A, (⟨x, h⟩ : {x // x ∈ A}) ∈ component m := by
  unfold cyclePointsOf at hx
  obtain ⟨r, _, rfl⟩ := List.mem_map.mp hx
  exact ⟨(iterate r m).2, hiterate r⟩

omit [Fintype J] [LinearOrder J] in
theorem cyclePoints_nodup_necSuf {K : Type*} (period : K → ℕ)
    (iterate : ℕ → K → K) (point : K → J) (m : K)
    (hinj : ∀ r s, r < period m → s < period m →
      point (iterate r m) = point (iterate s m) → r = s) :
    (cyclePointsOf period iterate point m).Nodup := by
  unfold cyclePointsOf
  apply List.Nodup.map_on _ List.nodup_range
  intro r hr s hs hrs
  exact hinj r s (List.mem_range.mp hr) (List.mem_range.mp hs) hrs

omit [Fintype J] [LinearOrder J] in
theorem cyclePoints_disjoint_necSuf {K : Type*} [Fintype K]
    (minimum : K → K) (period : K → ℕ) (iterate : ℕ → K → K) (point : K → J)
    (hself : ∀ i, minimum (minimum i) = minimum i)
    (hiterate : ∀ i r, minimum (iterate r i) = minimum i)
    (hpoint : Function.Injective point)
    (m₁ m₂ : K) (h₁ : m₁ ∈ cycleMinimaOf minimum)
    (h₂ : m₂ ∈ cycleMinimaOf minimum) (hne : m₁ ≠ m₂) :
    List.Disjoint (cyclePointsOf period iterate point m₁)
      (cyclePointsOf period iterate point m₂) := by
  intro x hx₁ hx₂
  obtain ⟨i₁, rfl⟩ := (mem_cycleMinimaOf minimum m₁).mp h₁
  obtain ⟨i₂, rfl⟩ := (mem_cycleMinimaOf minimum m₂).mp h₂
  unfold cyclePointsOf at hx₁ hx₂
  obtain ⟨r₁, _, hr₁⟩ := List.mem_map.mp hx₁
  obtain ⟨r₂, _, hr₂⟩ := List.mem_map.mp hx₂
  have heq : iterate r₁ (minimum i₁) = iterate r₂ (minimum i₂) :=
    hpoint (hr₁.trans hr₂.symm)
  apply hne
  calc
    minimum i₁ = minimum (minimum i₁) := (hself i₁).symm
    _ = minimum (iterate r₁ (minimum i₁)) := (hiterate _ _).symm
    _ = minimum (iterate r₂ (minimum i₂)) := congrArg minimum heq
    _ = minimum (minimum i₂) := hiterate _ _
    _ = minimum i₂ := hself i₂

omit [Fintype J] [LinearOrder J] in
theorem cycleWords_flatten_nodup_necSuf {K : Type*} [Fintype K] [LinearOrder K]
    (minimum : K → K) (period : K → ℕ) (iterate : ℕ → K → K) (point : K → J)
    (hinj : ∀ m r s, r < period m → s < period m →
      point (iterate r m) = point (iterate s m) → r = s)
    (hself : ∀ i, minimum (minimum i) = minimum i)
    (hiterate : ∀ i r, minimum (iterate r i) = minimum i)
    (hpoint : Function.Injective point) :
    (cycleWordsOf minimum period iterate point).flatten.Nodup := by
  unfold cycleWordsOf
  rw [List.nodup_flatten]
  refine ⟨fun l hl => ?_, ?_⟩
  · obtain ⟨m, _, rfl⟩ := List.mem_map.mp hl
    exact cyclePoints_nodup_necSuf period iterate point m (hinj m)
  · rw [List.pairwise_map]
    apply List.Nodup.pairwise_of_forall_ne (Finset.sort_nodup _ _)
    intro a ha b hb hab
    apply cyclePoints_disjoint_necSuf
      minimum period iterate point
    · exact hself
    · exact hiterate
    · exact hpoint
    · exact (Finset.mem_sort _).mp ha
    · exact (Finset.mem_sort _).mp hb
    · exact hab

omit [Fintype J] [LinearOrder J] in
/-- 各点が代表点から一周期以内の反復で得られれば、閉路点列が全点を覆う。 -/
theorem cycleWords_cover_necSuf {K : Type*} [Fintype K] [LinearOrder K]
    (minimum : K → K) (period : K → ℕ) (iterate : ℕ → K → K)
    (point : K → J)
    (hcover : ∀ i : K, ∃ m ∈ cycleMinimaOf minimum,
      ∃ r : ℕ, r < period m ∧ iterate r m = i)
    (i : K) :
    point i ∈ (cycleWordsOf minimum period iterate point).flatten := by
  obtain ⟨m, hm, r, hr, hir⟩ := hcover i
  apply List.mem_flatten.mpr
  refine ⟨cyclePointsOf period iterate point m, ?_, ?_⟩
  · exact List.mem_map.mpr ⟨m, (Finset.mem_sort _).mpr hm, rfl⟩
  · exact List.mem_map.mpr ⟨r, List.mem_range.mpr hr, by rw [hir]⟩

include hτ in
theorem cycleWords_complete_necSuf :
    IsCompleteWord ((cycleWordsOf (Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum τ υ)
    (finitePermutationMinimalPeriod (matchingPairPermutation τ υ))
    (finiteMapIterate (matchingPairPermutation τ υ)) Subtype.val).flatten ++
      matchingPairWord (matchingPairOutsideEnumeration (perfectMatchingMate D) A)) := by
  constructor
  · rw [List.nodup_append]
    refine ⟨cycleWords_flatten_nodup_necSuf
      (Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum τ υ)
      (finitePermutationMinimalPeriod (matchingPairPermutation τ υ))
      (finiteMapIterate (matchingPairPermutation τ υ)) Subtype.val
      (by
        intro m r s hr hs hrs
        have hinj := (finitePermutationOrbitEnumeration_bijective
          (matchingPairPermutation τ υ) m).1
        have h := @hinj ⟨r, hr⟩ ⟨s, hs⟩ (Subtype.ext (Subtype.ext hrs))
        exact congrArg Fin.val h)
      (by
        intro i
        exact (Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairMinimum_self_and_color
          τ υ (· ≤ ·) (fun _ _ => le_antisymm)
          (Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum τ υ)
          (Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum_mem τ υ)
          (Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum_le τ υ) i).1)
      (by
        intro i r
        have horbit : finiteMapIterate (matchingPairPermutation τ υ) r i ∈
            matchingPairComponent τ υ i := by
          rw [← matchingPairPermutation_orbit_eq_component]
          exact ⟨r, Or.inl rfl⟩
        apply Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairMinimum_basepoint
          τ υ (· ≤ ·) (fun _ _ => le_antisymm)
          (Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum τ υ)
          (Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum_mem τ υ)
          (Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum_le τ υ)
        exact horbit)
      Subtype.val_injective,
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
    apply (cyclePoints_mem_component_necSuf A
      (finitePermutationMinimalPeriod (matchingPairPermutation τ υ))
      (finiteMapIterate (matchingPairPermutation τ υ)) (matchingPairComponent τ υ)
      m x (by
        intro r
        rw [← matchingPairPermutation_orbit_eq_component]
        exact ⟨r, Or.inl rfl⟩) hxl).1
  · intro x
    by_cases hx : x ∈ A
    · apply List.mem_append_left
      let xx : {x // x ∈ A} := ⟨x, hx⟩
      exact cycleWords_cover_necSuf
        (Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum τ υ)
        (finitePermutationMinimalPeriod (matchingPairPermutation τ υ))
        (finiteMapIterate (matchingPairPermutation τ υ)) Subtype.val
        (by
          intro i
          let m := Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum τ υ i
          have hm : m ∈ cycleMinimaOf
              (Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum τ υ) :=
            (mem_cycleMinimaOf _ _).mpr ⟨i, rfl⟩
          have horbit : i ∈ finitePermutationOrbit (matchingPairPermutation τ υ) m := by
            rw [matchingPairPermutation_orbit_eq_component,
              matchingPairComponent_basepoint τ υ i m
                (Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum_mem τ υ i)]
            exact Or.inl (finitePermutationOrbit_self_mem _ _)
          obtain ⟨r, hr⟩ := (finitePermutationOrbitEnumeration_bijective
            (matchingPairPermutation τ υ) m).2 ⟨i, horbit⟩
          exact ⟨m, hm, r.val, r.isLt, congrArg Subtype.val hr⟩) xx
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
    obtain ⟨hpos, hev, _⟩ := cycle_period_necSuf
      (matchingPairPermutation τ υ) (fun j => j ∈ matchingPairColor τ υ)
      (finitePermutationMinimalPeriod (matchingPairPermutation τ υ))
      (finiteMapIterate (matchingPairPermutation τ υ))
      (by intro n j; rfl)
      (matchingPairSuccessor_color τ υ)
      (by intro j; have hs := finitePermutationMinimalPeriod_spec (matchingPairPermutation τ υ) j
          exact ⟨hs.1, hs.2.1⟩) m
    exact cyclePoints_even_necSuf
      (finitePermutationMinimalPeriod (matchingPairPermutation τ υ))
      (finiteMapIterate (matchingPairPermutation τ υ)) Subtype.val m hpos hev
  · exact cycleWords_complete_necSuf D A τ υ hτ
  · intro c hc
    obtain ⟨m, hm, rfl⟩ := List.mem_map.mp hc
    obtain ⟨i, rfl⟩ := (mem_cycleMinimaOf _ _).mp ((Finset.mem_sort _).mp hm)
    let m := Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum τ υ i
    apply cycle_pairs_D_necSuf D.val (perfectMatchingMate D)
      (fun e => (perfectMatchingMate_spec D e).2)
      (finitePermutationMinimalPeriod (matchingPairPermutation τ υ))
      (finiteMapIterate (matchingPairPermutation τ υ)) Subtype.val m
    · exact (cycle_period_necSuf
        (matchingPairPermutation τ υ) (fun j => j ∈ matchingPairColor τ υ)
        (finitePermutationMinimalPeriod (matchingPairPermutation τ υ))
        (finiteMapIterate (matchingPairPermutation τ υ))
        (by intro n j; rfl) (matchingPairSuccessor_color τ υ)
        (by intro j; have hs := finitePermutationMinimalPeriod_spec (matchingPairPermutation τ υ) j
            exact ⟨hs.1, hs.2.1⟩) m).2.1
    · intro r
      have hmin := Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairMinimum_self_and_color
        τ υ (· ≤ ·) (fun _ _ => le_antisymm)
        (Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum τ υ)
        (Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum_mem τ υ)
        (Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum_le τ υ) i
      have hcol := (iterate_color_parity_necSuf
        (matchingPairPermutation τ υ) (fun j => j ∈ matchingPairColor τ υ)
        (finiteMapIterate (matchingPairPermutation τ υ))
        (by intro n j; rfl) (matchingPairSuccessor_color τ υ) m hmin.2
        (2 * r)).mpr (even_two_mul r)
      have hnext : finiteMapIterate (matchingPairPermutation τ υ) (2 * r + 1) m =
          matchingPairSuccessor τ υ (finiteMapIterate (matchingPairPermutation τ υ) (2 * r) m) := by
        simp only [finiteMapIterate, Function.iterate_succ_apply']
        rfl
      rw [hnext, matchingPairSuccessor, if_pos hcol]
      exact hτ _
  · intro c hc
    obtain ⟨m, hm, rfl⟩ := List.mem_map.mp hc
    obtain ⟨i, rfl⟩ := (mem_cycleMinimaOf _ _).mp ((Finset.mem_sort _).mp hm)
    let m := Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum τ υ i
    apply cycle_pairs_reference_necSuf D₀.val (perfectMatchingMate D₀)
      (fun e => (perfectMatchingMate_spec D₀ e).2)
      (finitePermutationMinimalPeriod (matchingPairPermutation τ υ))
      (finiteMapIterate (matchingPairPermutation τ υ)) Subtype.val m
    · exact (cycle_period_necSuf
        (matchingPairPermutation τ υ) (fun j => j ∈ matchingPairColor τ υ)
        (finitePermutationMinimalPeriod (matchingPairPermutation τ υ))
        (finiteMapIterate (matchingPairPermutation τ υ))
        (by intro n j; rfl) (matchingPairSuccessor_color τ υ)
        (by intro j; have hs := finitePermutationMinimalPeriod_spec (matchingPairPermutation τ υ) j
            exact ⟨hs.1, hs.2.1⟩) m).1
    · exact (cycle_period_necSuf
        (matchingPairPermutation τ υ) (fun j => j ∈ matchingPairColor τ υ)
        (finitePermutationMinimalPeriod (matchingPairPermutation τ υ))
        (finiteMapIterate (matchingPairPermutation τ υ))
        (by intro n j; rfl) (matchingPairSuccessor_color τ υ)
        (by intro j; have hs := finitePermutationMinimalPeriod_spec (matchingPairPermutation τ υ) j
            exact ⟨hs.1, hs.2.1⟩) m).2.1
    · have hper := (cycle_period_necSuf
        (matchingPairPermutation τ υ) (fun j => j ∈ matchingPairColor τ υ)
        (finitePermutationMinimalPeriod (matchingPairPermutation τ υ))
        (finiteMapIterate (matchingPairPermutation τ υ))
        (by intro n j; rfl) (matchingPairSuccessor_color τ υ)
        (by intro j; have hs := finitePermutationMinimalPeriod_spec (matchingPairPermutation τ υ) j
            exact ⟨hs.1, hs.2.1⟩) m).2.2
      simpa [finiteMapIterate] using congrArg Subtype.val hper
    · intro r
      have hmin := Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairMinimum_self_and_color
        τ υ (· ≤ ·) (fun _ _ => le_antisymm)
        (Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum τ υ)
        (Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum_mem τ υ)
        (Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum_le τ υ) i
      have hcol : ¬ finiteMapIterate (matchingPairPermutation τ υ) (2 * r + 1) m ∈
          matchingPairColor τ υ := by
        rw [iterate_color_parity_necSuf
          (matchingPairPermutation τ υ) (fun j => j ∈ matchingPairColor τ υ)
          (finiteMapIterate (matchingPairPermutation τ υ))
          (by intro n j; rfl) (matchingPairSuccessor_color τ υ) m hmin.2 (2 * r + 1)]
        exact Nat.not_even_iff_odd.mpr (odd_two_mul_add_one r)
      have hnext : finiteMapIterate (matchingPairPermutation τ υ) (2 * r + 1 + 1) m =
          matchingPairSuccessor τ υ
            (finiteMapIterate (matchingPairPermutation τ υ) (2 * r + 1) m) := by
        simp only [finiteMapIterate, Function.iterate_succ_apply']
        rfl
      rw [hnext, matchingPairSuccessor, if_neg hcol]
      exact hυ _
  · exact matchingPairOutsideEnumeration_spec D.val D₀.val
      (perfectMatchingMate D) (perfectMatchingMate D₀) A
      (fun e => (perfectMatchingMate_spec D e).2)
      (fun e => (perfectMatchingMate_spec D₀ e).2) hout
  · exact hsD

end Ising2DLambda.NecSuf.KacWard
