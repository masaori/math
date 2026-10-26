import Ising2DLambda.KacWard.ReferenceLongMate
import Ising2DLambda.KacWard.TaggedDifferenceAlternatingCycle
import Ising2DLambda.NecSuf.KacWard.ProjectedClosedEdgeCycle

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
attribute [local instance] Classical.propDecidable

/-- The even-indexed oriented edges of an actual alternating cycle close. The
    intervening long match is the reversal of the preceding odd-indexed edge. -/
theorem taggedActive_projectedClosedEdgeCycle {L : ℕ}
    (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L))
    (i : {i : OrientedEdge L // i ∈
      Ising2DLambda.NecSuf.KacWard.activeVertices D
        ⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩
        (shortUnderlyingPairs t)}) :
    let τ := shortInvolution D t
    let υ := longInvolution D t
    let m := matchingPairComponentMinimum τ υ i
    let σ := matchingPairPermutation τ υ
    ∃ k : ℕ, 0 < k ∧ finiteMapIterate σ (2 * k) m = m ∧
      ∀ r : ℕ, r < k →
        (finiteMapIterate σ (2 * (r + 1)) m).val =
          reversal (finiteMapIterate σ (2 * r + 1) m).val := by
  dsimp
  let τ := shortInvolution D t
  let υ := longInvolution D t
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
    exact finitePermutationOrbit_self_mem _ m
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
  have hnreturn : finiteMapIterate σ n m = m :=
    (finitePermutationMinimalPeriod_spec σ m).2.1
  have hneven : Even n := by
    change Even (finitePermutationMinimalPeriod (matchingPairPermutation τ υ) m)
    rw [finitePermutationMinimalPeriod_eq_orbitLength]
    exact matchingPairPermutation_even_orbit τ υ m
  obtain ⟨k, hk⟩ := hneven
  have hkpos : 0 < k := by
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

/-- The abstract projection calculation specializes after forgetting the lattice labels. -/
theorem taggedActive_projectedClosedEdgeCycle_from_necSuf {L : ℕ}
    (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L))
    (i : {i : OrientedEdge L // i ∈
      Ising2DLambda.NecSuf.KacWard.activeVertices D
        ⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩
        (shortUnderlyingPairs t)}) :
    let τ := shortInvolution D t
    let υ := longInvolution D t
    let m := matchingPairComponentMinimum τ υ i
    let σ := matchingPairPermutation τ υ
    ∃ k : ℕ, 0 < k ∧ finiteMapIterate σ (2 * k) m = m ∧
      ∀ r : ℕ, r < k →
        (finiteMapIterate σ (2 * (r + 1)) m).val =
          reversal (finiteMapIterate σ (2 * r + 1) m).val := by
  dsimp
  let τ := shortInvolution D t
  let υ := longInvolution D t
  let m := matchingPairComponentMinimum τ υ i
  have hcomponent : m ∈ matchingPairComponent τ υ i :=
    matchingPairComponentMinimum_mem τ υ i
  have hbase : matchingPairComponentMinimum τ υ m = m :=
    matchingPairComponentMinimum_basepoint τ υ i m hcomponent
  have hm : m ∈ matchingPairColor τ υ := by
    change m ∈ finitePermutationOrbit (matchingPairStep τ υ)
      (matchingPairComponentMinimum τ υ m)
    rw [hbase]
    exact finitePermutationOrbit_self_mem _ m
  obtain ⟨k, hkpos, hreturn, hlong⟩ :=
    Ising2DLambda.NecSuf.KacWard.projectedClosedEdgeCycle τ υ m hm
  refine ⟨k, hkpos, hreturn, ?_⟩
  intro r hr
  have h := hlong r hr
  have hrev : (υ.val (finiteMapIterate (matchingPairPermutation τ υ) (2 * r + 1) m)).val =
      reversal (finiteMapIterate (matchingPairPermutation τ υ) (2 * r + 1) m).val := by
    change perfectMatchingMate
      (⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩ :
        PerfectMatching (OrientedEdge L))
      (finiteMapIterate (matchingPairPermutation τ υ) (2 * r + 1) m).val = _
    exact referenceLongMate_eq_reversal _
  calc
    (finiteMapIterate (matchingPairPermutation τ υ) (2 * (r + 1)) m).val =
        (υ.val (finiteMapIterate (matchingPairPermutation τ υ) (2 * r + 1) m)).val :=
      congrArg Subtype.val h.symm
    _ = reversal (finiteMapIterate (matchingPairPermutation τ υ) (2 * r + 1) m).val := hrev

end Ising2DLambda.KacWard
