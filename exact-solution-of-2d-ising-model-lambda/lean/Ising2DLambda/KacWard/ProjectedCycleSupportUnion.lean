import Ising2DLambda.KacWard.ProjectedCycleDistinctEdges
import Ising2DLambda.KacWard.TaggedComplementActiveVertices
import Ising2DLambda.KacWard.TaggedDifferenceCycleCover

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.PartitionPolynomial
attribute [local instance] Classical.propDecidable

/-- 本文の閉辺列の台の合併。各活動点 `i` の交互閉路について、一周期の列挙
`c(s) = σ^[s](m)`（`m` は二歩軌道の合併の最小元）の偶数番目 `c(2r)`（`r < n/2`）の
反転の台を集める。 -/
noncomputable def projectedCycleSupportUnion {L : ℕ}
    (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L)) : Set (Edge L) :=
  {e | ∃ i : {a : OrientedEdge L // a ∈ concreteTaggedActiveVertices D t}, ∃ r : ℕ,
      r < finitePermutationMinimalPeriod
          (matchingPairPermutation (concreteShortInvolution D t) (concreteLongInvolution D t))
          (matchingPairComponentMinimum (concreteShortInvolution D t)
            (concreteLongInvolution D t) i) / 2 ∧
      (reversal (finiteMapIterate
          (matchingPairPermutation (concreteShortInvolution D t) (concreteLongInvolution D t))
          (2 * r)
          (matchingPairComponentMinimum (concreteShortInvolution D t)
            (concreteLongInvolution D t) i)).val).1 = e}

/-- 本文の証明の準備の前半。最小元 `m` から後続置換で `s` 回進んだ点が第一色であることと、
`s` が偶数であることは同値である。 -/
theorem projectedCycle_iterate_color_iff_even {L : ℕ}
    (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L))
    (i : {a : OrientedEdge L // a ∈ concreteTaggedActiveVertices D t}) :
    let τ := concreteShortInvolution D t
    let υ := concreteLongInvolution D t
    let m := matchingPairComponentMinimum τ υ i
    let σ := matchingPairPermutation τ υ
    ∀ s : ℕ, finiteMapIterate σ s m ∈ matchingPairColor τ υ ↔ Even s := by
  intro τ υ m σ
  -- 本文: 最小元 `m` は `C` に属し、`m` を含む合併は `C` に等しい
  -- （`claim_matching_pair_component_basepoint`）ので、その最小元は `m` 自身。
  have hm : m ∈ matchingPairComponent τ υ i := matchingPairComponentMinimum_mem τ υ i
  have hmm : matchingPairComponentMinimum τ υ m = m :=
    matchingPairComponentMinimum_basepoint τ υ i m hm
  -- 本文: 零回の反復で自分の二歩軌道に属するので `c(0) = m` は第一色。
  have hm0 : m ∈ matchingPairColor τ υ := by
    change m ∈ finitePermutationOrbit (matchingPairStep τ υ)
      (matchingPairComponentMinimum τ υ m)
    rw [hmm]
    exact ⟨0, Or.inl rfl⟩
  -- 本文: 後続のたびに色が反転する（`claim_matching_pair_successor_color`）ので、
  -- 反復回数についての帰納法。
  intro s
  induction s with
  | zero => exact ⟨fun _ => ⟨0, rfl⟩, fun _ => hm0⟩
  | succ s ih =>
    have hstep : finiteMapIterate σ (s + 1) m = σ (finiteMapIterate σ s m) :=
      Function.iterate_succ_apply' _ _ _
    rw [hstep, Nat.even_add_one, ← ih]
    exact matchingPairSuccessor_color τ υ _

/-- 本文の証明の準備の後半。閉路の第一色の点は、ちょうど一周期の列挙の偶数番目である。 -/
theorem projectedCycle_firstColor_enumeration {L : ℕ}
    (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L))
    (i x : {a : OrientedEdge L // a ∈ concreteTaggedActiveVertices D t}) :
    let τ := concreteShortInvolution D t
    let υ := concreteLongInvolution D t
    let m := matchingPairComponentMinimum τ υ i
    let σ := matchingPairPermutation τ υ
    x ∈ matchingPairComponent τ υ i → x ∈ matchingPairColor τ υ →
      ∃ r : ℕ, r < finitePermutationMinimalPeriod σ m / 2 ∧
        finiteMapIterate σ (2 * r) m = x := by
  intro τ υ m σ hx hxcolor
  -- 本文: 一周期の列挙（`claim_tagged_difference_alternating_cycle`）。
  obtain ⟨hnEven, hbij, horbit, -, -, -⟩ := taggedActive_alternatingCycle D t i
  have hparity := projectedCycle_iterate_color_iff_even D t i
  have hxo : x ∈ finitePermutationOrbit σ m := by
    rw [horbit]
    exact hx
  obtain ⟨s, hs⟩ := hbij.2 ⟨x, hxo⟩
  have hsx : finiteMapIterate σ s.val m = x := congrArg Subtype.val hs
  have heven : Even s.val := (hparity s.val).1 (hsx ▸ hxcolor)
  obtain ⟨r, hr⟩ := heven
  refine ⟨r, ?_, ?_⟩
  · have hlt : s.val < finitePermutationMinimalPeriod σ m := s.isLt
    have hn : Even (finitePermutationMinimalPeriod σ m) := hnEven
    obtain ⟨k, hk⟩ := hn
    show r < finitePermutationMinimalPeriod σ m / 2
    omega
  · rw [show 2 * r = s.val by omega]
    exact hsx

/-- 閉辺列の台の合併を、各閉路の第一色の点の反転の台として読み直す。 -/
theorem projectedCycleSupportUnion_eq_firstColor {L : ℕ}
    (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L)) :
    projectedCycleSupportUnion D t =
      {e | ∃ i j : {a : OrientedEdge L // a ∈ concreteTaggedActiveVertices D t},
        j ∈ concreteAlternatingComponent D t i ∧
        j ∈ matchingPairColor (concreteShortInvolution D t) (concreteLongInvolution D t) ∧
        (reversal j.val).1 = e} := by
  classical
  let τ := concreteShortInvolution D t
  let υ := concreteLongInvolution D t
  let σ := matchingPairPermutation τ υ
  ext e
  constructor
  · rintro ⟨i, r, -, hedge⟩
    let m := matchingPairComponentMinimum τ υ i
    obtain ⟨-, -, horbit, -, -, -⟩ := taggedActive_alternatingCycle D t i
    have hmo : finiteMapIterate σ (2 * r) m ∈ finitePermutationOrbit σ m :=
      ⟨2 * r, Or.inl rfl⟩
    have hcomp : finiteMapIterate σ (2 * r) m ∈ matchingPairComponent τ υ i := by
      rw [← horbit]
      exact hmo
    exact ⟨i, finiteMapIterate σ (2 * r) m, hcomp,
      (projectedCycle_iterate_color_iff_even D t i (2 * r)).2 (even_two_mul r), hedge⟩
  · rintro ⟨i, j, hjcycle, hjcolor, hjedge⟩
    obtain ⟨r, hr, hrj⟩ := projectedCycle_firstColor_enumeration D t i j hjcycle hjcolor
    refine ⟨i, r, hr, ?_⟩
    change (reversal (finiteMapIterate σ (2 * r)
      (matchingPairComponentMinimum τ υ i)).val).1 = e
    rw [hrj]
    exact hjedge

/-- Every selected unoriented edge appears in exactly the support union of the
    projected cycles; no nonselected edge appears there. -/
theorem projectedCycleSupportUnion_eq_complement {L : ℕ} (z : Qbar)
    (s : SpinStructure) (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L))
    (ht : t ⊆ matchingOrientedPairs D)
    (hterm : matchingSignPolynomial D *
      ((-1 : Polynomial Qbar) ^ t.card *
        (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
        (∏ p ∈ t, gaugedShortContribution z s p)) ≠ 0) :
    projectedCycleSupportUnion D t = ↑(taggedComplementEdges D t) := by
  classical
  let A := concreteTaggedActiveVertices D t
  let τ := concreteShortInvolution D t
  let υ := concreteLongInvolution D t
  rw [projectedCycleSupportUnion_eq_firstColor]
  ext e
  constructor
  · rintro ⟨i, j, hjcycle, hjcolor, hjedge⟩
    have hbase : j.val.1 = e := by simpa only [reversal] using hjedge
    have hactive : j.val.1 ∈ taggedComplementEdges D t :=
      (taggedComplement_iff_active_concrete z s D t ht hterm j.val).2
        ((taggedActiveByLabels_eq_concreteTaggedActiveVertices D t).symm ▸ j.property)
    simpa [hbase] using hactive
  · intro he
    let a : OrientedEdge L := (e, false)
    have ha : a ∈ A := by
      dsimp [A]
      rw [← taggedActiveByLabels_eq_concreteTaggedActiveVertices D t]
      exact (taggedComplement_iff_active_concrete z s D t ht hterm a).1
        (by simpa [a] using he)
    let i : {a : OrientedEdge L // a ∈ A} := ⟨a, ha⟩
    have hcover := (taggedActive_cycleCover D t).1
    by_cases hfirst : i ∈ matchingPairColor τ υ
    · exact ⟨i, i, hcover i, hfirst, by simp [i, a, reversal]⟩
    · let j := υ.val i
      have hjcolor : j ∈ matchingPairColor τ υ :=
        (matchingPairSecondColor_alternates τ υ i).2 hfirst
      have hjcycle : j ∈ concreteAlternatingComponent D t i := by
        change j ∈ matchingPairComponent τ υ i
        -- 本文: 軌道の定義の零回の反復。
        have hτ : τ.val i ∈ finitePermutationOrbit (matchingPairStep τ υ) (τ.val i) :=
          ⟨0, Or.inl rfl⟩
        have hp := (finitePermutationOrbit_invariant (matchingPairStep τ υ)
          (τ.val i) (τ.val i)).mpr hτ
        change υ.val (τ.val (τ.val i)) ∈
          finitePermutationOrbit (matchingPairStep τ υ) (τ.val i) at hp
        rw [τ.property.2 i] at hp
        exact Or.inr hp
      have hjedge : (reversal j.val).1 = e := by
        change (reversal (perfectMatchingMate
          (⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩ :
            PerfectMatching (OrientedEdge L)) i.val)).1 = e
        rw [referenceLongMate_eq_reversal, reversal_involutive]
      exact ⟨i, j, hjcycle, hjcolor, hjedge⟩

end Ising2DLambda.KacWard
