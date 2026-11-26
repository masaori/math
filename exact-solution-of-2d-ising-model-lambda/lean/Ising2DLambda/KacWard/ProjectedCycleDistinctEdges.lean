import Ising2DLambda.KacWard.ProjectedCycleNonbacktracking
import Ising2DLambda.KacWard.TaggedDifferenceAlternatingCycle

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
attribute [local instance] Classical.propDecidable

private theorem same_edge_eq_or_reversal {L : ℕ}
    (e f : OrientedEdge L) (h : e.1 = f.1) :
    e = f ∨ e = reversal f := by
  rcases e with ⟨edge, direction⟩
  rcases f with ⟨other, otherDirection⟩
  cases h
  cases direction <;> cases otherDirection <;>
    simp [reversal]

/-- Distinct first-colour positions of an actual alternating cycle use distinct
    unoriented lattice edges, including when the cycle has one projected step. -/
theorem taggedActive_projectedCycle_distinctEdges {L : ℕ}
    (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L))
    (i : {i : OrientedEdge L // i ∈ concreteTaggedActiveVertices D t}) :
    let τ := concreteShortInvolution D t
    let υ := concreteLongInvolution D t
    let m := matchingPairComponentMinimum τ υ i
    let σ := matchingPairPermutation τ υ
    let k := finitePermutationMinimalPeriod σ m / 2
    ∀ r s : ℕ, r < k → s < k →
      (reversal (finiteMapIterate σ (2 * r) m).val).1 =
        (reversal (finiteMapIterate σ (2 * s) m).val).1 → r = s := by
  dsimp
  let τ := concreteShortInvolution D t
  let υ := concreteLongInvolution D t
  let m := matchingPairComponentMinimum τ υ i
  have hcomponent : m ∈ matchingPairComponent τ υ i :=
    matchingPairComponentMinimum_mem τ υ i
  have hbase : matchingPairComponentMinimum τ υ m = m :=
    matchingPairComponentMinimum_basepoint τ υ i m hcomponent
  have hm : m ∈ matchingPairColor τ υ := by
    change m ∈ finitePermutationOrbit (matchingPairStep τ υ)
      (matchingPairComponentMinimum τ υ m)
    rw [hbase]
    -- 本文: 軌道の定義の零回の反復。
    exact ⟨0, Or.inl rfl⟩
  have hfibre (j l : {e : OrientedEdge L // e ∈ concreteTaggedActiveVertices D t})
      (h : j.val.1 = l.val.1) : j = l ∨ j = υ.val l := by
    rcases same_edge_eq_or_reversal j.val l.val h with heq | heq
    · exact Or.inl (Subtype.ext heq)
    · right
      apply Subtype.ext
      change j.val = perfectMatchingMate
        (⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩ :
          PerfectMatching (OrientedEdge L)) l.val
      rw [referenceLongMate_eq_reversal]
      exact heq
  let σ := matchingPairPermutation τ υ
  let C := matchingPairColor τ υ
  let n := finitePermutationMinimalPeriod σ m
  let k := n / 2
  -- 本文: 交互閉路の主張により最小正周期は偶数である。
  have hneven : Even n := (taggedActive_alternatingCycle D t i).1
  have hnk : n = 2 * k := by
    obtain ⟨a, ha⟩ := hneven
    dsimp [k]
    omega
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
  intro r s hr hs hprojection
  change r < k at hr
  change s < k at hs
  have hsupport : (finiteMapIterate σ (2 * r) m).val.1 =
      (finiteMapIterate σ (2 * s) m).val.1 := by
    simpa only [reversal] using hprojection
  have hpair := hfibre _ _ hsupport
  have heq : finiteMapIterate σ (2 * r) m = finiteMapIterate σ (2 * s) m := by
    rcases hpair with h | h
    · exact h
    · exfalso
      have hnot : υ.val (finiteMapIterate σ (2 * s) m) ∉ C := by
        intro hc
        exact (matchingPairSecondColor_alternates τ υ _).mp hc (heven s)
      exact hnot (h ▸ heven r)
  have hrn : 2 * r < n := by omega
  have hsn : 2 * s < n := by omega
  -- 本文: 軌道の列挙の単射性（最小正周期未満の反復回数の一意性）により 2r = 2s。
  have hindex : (⟨2 * r, hrn⟩ : Fin n) = ⟨2 * s, hsn⟩ :=
    (finitePermutationOrbitEnumeration_bijective σ m).1 (Subtype.ext heq)
  have hval := congrArg Fin.val hindex
  dsimp at hval
  omega

end Ising2DLambda.KacWard
