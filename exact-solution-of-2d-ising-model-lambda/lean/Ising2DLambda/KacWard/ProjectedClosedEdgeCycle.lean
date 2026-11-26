import Ising2DLambda.KacWard.ReferenceLongMate
import Ising2DLambda.KacWard.TaggedDifferenceAlternatingCycle

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
attribute [local instance] Classical.propDecidable

/-- The even-indexed oriented edges of an concrete tagged alternating cycle close. The
    intervening long match is the reversal of the preceding odd-indexed edge. -/
theorem taggedActive_projectedClosedEdgeCycle {L : ℕ}
    (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L))
    (i : {i : OrientedEdge L // i ∈
      concreteTaggedActiveVertices D t}) :
    let τ := concreteShortInvolution D t
    let υ := concreteLongInvolution D t
    let m := matchingPairComponentMinimum τ υ i
    let σ := matchingPairPermutation τ υ
    ∃ k : ℕ, 0 < k ∧ finiteMapIterate σ (2 * k) m = m ∧
      ∀ r : ℕ, r < k →
        (finiteMapIterate σ (2 * (r + 1)) m).val =
          reversal (finiteMapIterate σ (2 * r + 1) m).val := by
  dsimp
  let τ := concreteShortInvolution D t
  let υ := concreteLongInvolution D t
  let m := matchingPairComponentMinimum τ υ i
  let σ := matchingPairPermutation τ υ
  let C := matchingPairColor τ υ
  have hcomponent : m ∈ matchingPairComponent τ υ i :=
    matchingPairComponentMinimum_mem τ υ i
  have hbase : matchingPairComponentMinimum τ υ m = m := by
    exact matchingPairComponentMinimum_basepoint τ υ i m hcomponent
  have hm : m ∈ C := by
    change m ∈ finitePermutationOrbit (matchingPairStep τ υ)
      (matchingPairComponentMinimum τ υ m)
    rw [hbase]
    -- 本文: 軌道の定義の零回の反復。
    exact ⟨0, Or.inl rfl⟩
  have hflip (j : _) : σ j ∈ C ↔ j ∉ C := matchingPairSuccessor_color τ υ j
  have heven (r : ℕ) : finiteMapIterate σ (2 * r) m ∈ C := by
    induction r with
    | zero => simpa [finiteMapIterate, C] using hm
    | succ r ih =>
      let j := finiteMapIterate σ (2 * r) m
      have hodd : σ j ∉ C := by
        intro h
        exact (hflip j).mp h ih
      have hnext : σ (σ j) ∈ C := (hflip (σ j)).mpr hodd
      have hindex : 2 * (r + 1) = 2 + 2 * r := by omega
      rw [hindex, finiteMapIterate_add]
      exact hnext
  let n := finitePermutationMinimalPeriod σ m
  -- 本文: 交互閉路の主張により n は偶数で、周期で始点へ帰る。
  have hcycle := taggedActive_alternatingCycle D t i
  have hneven : Even n := hcycle.1
  have hnreturn : finiteMapIterate σ n m = m := hcycle.2.2.2.1
  obtain ⟨k, hk⟩ := hneven
  have hkpos : 0 < k := by
    -- 本文: 最小正周期は正の帰還時刻の最小元なので正である。
    have hnpos : 0 < n := (finitePermutationMinimalPeriod_spec σ m).1
    omega
  refine ⟨k, hkpos, ?_, ?_⟩
  · calc
      finiteMapIterate σ (2 * k) m = finiteMapIterate σ n m := by
        congr 1
        omega
      _ = m := hnreturn
  · intro r _
    have hodd : finiteMapIterate σ (2 * r + 1) m ∉ C := by
      have hstep : finiteMapIterate σ (2 * r + 1) m =
          σ (finiteMapIterate σ (2 * r) m) := by
        rw [show 2 * r + 1 = 1 + 2 * r by omega, finiteMapIterate_add]
        rfl
      rw [hstep]
      intro h
      exact (hflip _).mp h (heven r)
    have hlong : υ.val (finiteMapIterate σ (2 * r + 1) m) =
        finiteMapIterate σ (2 * (r + 1)) m := by
      calc
        υ.val (finiteMapIterate σ (2 * r + 1) m) =
            σ (finiteMapIterate σ (2 * r + 1) m) := by
              change υ.val _ = matchingPairSuccessor τ υ _
              rw [matchingPairSuccessor, if_neg hodd]
        _ = finiteMapIterate σ (1 + (2 * r + 1)) m :=
          (finiteMapIterate_add σ 1 (2 * r + 1) m).symm
        _ = finiteMapIterate σ (2 * (r + 1)) m := by
          congr 1
          omega
    have hrev : (υ.val (finiteMapIterate σ (2 * r + 1) m)).val =
        reversal (finiteMapIterate σ (2 * r + 1) m).val := by
      change perfectMatchingMate
        (⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩ :
          PerfectMatching (OrientedEdge L))
        (finiteMapIterate σ (2 * r + 1) m).val = _
      exact referenceLongMate_eq_reversal _
    calc
      (finiteMapIterate σ (2 * (r + 1)) m).val =
          (υ.val (finiteMapIterate σ (2 * r + 1) m)).val := congrArg Subtype.val hlong.symm
      _ = reversal (finiteMapIterate σ (2 * r + 1) m).val := hrev

end Ising2DLambda.KacWard
