/- 第一色の辺列が閉じることの具体版が、必要十分版の交互閉路の計算の特殊化であることの導出。 -/
import Ising2DLambda.KacWard.ProjectedClosedEdgeCycle
import Ising2DLambda.KacWard.TaggedDifferenceOrbitSeparationFromNecSuf
import Ising2DLambda.NecSuf.KacWard.ProjectedClosedEdgeCycleCore

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
attribute [local instance] Classical.propDecidable

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
  let σ := matchingPairPermutation τ υ
  let C := matchingPairColor τ υ
  have hcomponent : m ∈ matchingPairComponent τ υ i :=
    matchingPairComponentMinimum_mem τ υ i
  have hbase : matchingPairComponentMinimum τ υ m = m :=
    matchingPairComponentMinimum_basepoint τ υ i m hcomponent
  have hm : m ∈ matchingPairColor τ υ := by
    change m ∈ finitePermutationOrbit (matchingPairStep τ υ)
      (matchingPairComponentMinimum τ υ m)
    rw [hbase]
    exact finitePermutationOrbit_self_mem _ m
  have hflip' (j : _) : (σ j ∈ C ↔ j ∉ C) :=
    matchingPairSuccessor_color τ υ j
  have hsecond (j : _) (hj : j ∉ C) : σ j = υ.val j := by
    change matchingPairSuccessor τ υ j = υ.val j
    rw [matchingPairSuccessor, if_neg hj]
  obtain ⟨k, hkpos, hreturn, hlong⟩ :=
    Ising2DLambda.NecSuf.KacWard.projectedClosedEdgeCycleCore
      σ υ.val (fun j => j ∈ C) hflip' hsecond m hm
  change finiteMapIterate σ (2 * k) m = m at hreturn
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
