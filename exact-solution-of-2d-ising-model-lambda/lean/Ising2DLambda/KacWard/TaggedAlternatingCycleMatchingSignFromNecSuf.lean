/-
具体版 `taggedAlternatingCycles_matching_sign` の符号の等式を、接続の段の必要十分版の特殊化として得る。
J は辞書式順序の向き付き辺、D₀ は基準完全マッチング、A は実際の標識付き対称差の活動点、
τ, υ は実際の短い・長い対合、F は転倒符号による端点列の符号 `matchingWordSign`、R = ℤ とする。
A の外で二つの相手が一致することは `inactive_mate_eq_reference`、隣接交換の符号反転は
`matchingWordSign_swap`、sgn(D) の平方が一であることは `perfectMatchingSign_eq_one_or_neg_one` で満たす。
-/
import Ising2DLambda.KacWard.TaggedAlternatingCycleMatchingSign
import Ising2DLambda.NecSuf.KacWard.TaggedAlternatingCycleMatchingSign
import Ising2DLambda.KacWard.PairChunksFromNecSuf

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.NecSuf.KacWard
attribute [local instance] Classical.propDecidable

variable {J : Type*} [Fintype J] [LinearOrder J]

/-- 一般の符号計算を具体的なマッチング対へ適用する。sgn_F(D) sgn_F(D₀) = (-1)^{閉路の数} ∏ α_D(C) α₀(C)。 -/
theorem taggedAlternatingCycles_matching_sign_application {R : Type*} [CommRing R]
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
  · exact cycleWords_complete_necSuf A
      (perfectMatchingMate D) (perfectMatchingMate_ne D)
      (perfectMatchingMate_involutive D)
      (by
        intro e he
        have h := (τ.val ⟨e, he⟩).2
        rwa [hτ] at h)
      (finitePermutationMinimalPeriod (matchingPairPermutation τ υ))
      (finiteMapIterate (matchingPairPermutation τ υ))
      (by
        intro m r s hr hs hrs
        let σ := matchingPairPermutation τ υ
        have hspec := finitePermutationMinimalPeriod_spec σ m
        have hmin : ∀ n : ℕ, 0 < n → σ^[n] m = m →
            finitePermutationMinimalPeriod σ m ≤ n := by
          intro n hn heq
          exact hspec.2.2 n hn heq
        exact Ising2DLambda.NecSuf.AlgebraicEigenvalue.iterate_injOn_of_no_short_return_necSuf
          σ σ.injective m (finitePermutationMinimalPeriod σ m) hmin
          hr hs (Subtype.val_injective hrs))
      (Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum τ υ)
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
          have heq : finitePermutationOrbit (matchingPairPermutation τ υ) i =
              matchingPairComponent τ υ i := by
            exact Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairMinimumPermutation_orbit_eq_component τ υ i
          rw [← heq]
          exact ⟨r, Or.inl rfl⟩
        apply Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairMinimum_basepoint
          τ υ (· ≤ ·) (fun _ _ => le_antisymm)
          (Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum τ υ)
          (Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum_mem τ υ)
          (Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum_le τ υ)
        exact horbit)
      (by
        intro i
        let σ := Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairMinimumPermutation τ υ
        let m := Ising2DLambda.NecSuf.AlgebraicEigenvalue.permutationOrbitMinimum σ i
        have hm : m ∈ Ising2DLambda.NecSuf.AlgebraicEigenvalue.permutationOrbit σ i :=
          Ising2DLambda.NecSuf.AlgebraicEigenvalue.permutationOrbitMinimum_mem σ i
        have horbit : i ∈ Ising2DLambda.NecSuf.AlgebraicEigenvalue.permutationOrbit σ m := by
          rw [Ising2DLambda.NecSuf.AlgebraicEigenvalue.permutationOrbit_basepoint_necSuf σ i m hm]
          exact Ising2DLambda.NecSuf.AlgebraicEigenvalue.permutationOrbit_self_mem_necSuf σ i
        have hmin : Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum τ υ i = m := by
          exact Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum_eq_permutationOrbitMinimum τ υ i
        refine ⟨_, (mem_cycleMinimaOf _ _).mpr ⟨i, rfl⟩, ?_⟩
        have hmem : i ∈ finitePermutationOrbit (matchingPairPermutation τ υ)
            (Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum τ υ i) := by
          rw [hmin]
          exact horbit
        let σ' := matchingPairPermutation τ υ
        have hs := finitePermutationMinimalPeriod_spec σ'
          (Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum τ υ i)
        obtain ⟨r, hr, heq⟩ :=
          (Ising2DLambda.NecSuf.AlgebraicEigenvalue.twoWayOrbit_mem_iff_lt_period_necSuf
            σ' σ'.symm σ'.symm_apply_apply _ (finitePermutationMinimalPeriod σ' _)
            hs.1 hs.2.1 i).mp hmem
        exact ⟨r, hr, heq⟩)
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


theorem taggedAlternatingCycles_matching_sign_from_necSuf {L : ℕ}
    (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L)) :
    perfectMatchingSign D * perfectMatchingSign (referenceLongMatching L) =
      (-1) ^ (taggedCycleMinima D t).card *
        ((taggedCycleWords D t).map
          (fun c => cycleShortOrientation c * cycleReferenceOrientation c)).prod := by
  have hsD : perfectMatchingSign D * perfectMatchingSign D = 1 := by
    rcases perfectMatchingSign_eq_one_or_neg_one D with h | h <;> simp [h]
  have hτ : ∀ i, ((concreteShortInvolution D t).val i).1 = perfectMatchingMate D i.1 :=
    fun _ => rfl
  have hυ : ∀ i, ((concreteLongInvolution D t).val i).1 =
      perfectMatchingMate (referenceLongMatching L) i.1 := fun _ => rfl
  have h := taggedAlternatingCycles_matching_sign_application (R := ℤ)
    matchingWordSign matchingWordSign_swap D (referenceLongMatching L)
    (concreteTaggedActiveVertices D t) (concreteShortInvolution D t) (concreteLongInvolution D t)
    hτ hυ (fun e he => (inactive_mate_eq_reference D t e he).1) hsD
  have hminimum :
      NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum
          (concreteShortInvolution D t) (concreteLongInvolution D t) =
        matchingPairComponentMinimum
          (concreteShortInvolution D t) (concreteLongInvolution D t) := by
    funext i
    rfl
  have hm : NecSuf.KacWard.cycleMinimaOf
      (matchingPairComponentMinimum
        (concreteShortInvolution D t) (concreteLongInvolution D t)) = taggedCycleMinima D t := by
    ext x
    simp [NecSuf.KacWard.mem_cycleMinimaOf, taggedCycleMinima]
  have hw : NecSuf.KacWard.cycleWordsOf
      (NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum
        (concreteShortInvolution D t) (concreteLongInvolution D t))
      (finitePermutationMinimalPeriod (matchingPairPermutation
        (concreteShortInvolution D t) (concreteLongInvolution D t)))
      (finiteMapIterate (matchingPairPermutation
        (concreteShortInvolution D t) (concreteLongInvolution D t)))
      Subtype.val = taggedCycleWords D t := by
    unfold NecSuf.KacWard.cycleWordsOf taggedCycleWords
    rw [hminimum, hm]
    rfl
  have hη : NecSuf.KacWard.pairOrientationIn ℤ =
      (pairOrientation : OrientedEdge L × OrientedEdge L → ℤ) := rfl
  rw [hw, hminimum, hm, hη] at h
  simp only [pairChunks_eq_consecutivePairs] at h
  exact h

end Ising2DLambda.KacWard
