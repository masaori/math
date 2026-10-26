import Ising2DLambda.NecSuf.KacWard.ProjectedClosedEdgeCycle
import Ising2DLambda.AlgebraicEigenvalue.FinitePermutationPeriodInjective

namespace Ising2DLambda.NecSuf.KacWard

open Ising2DLambda.AlgebraicEigenvalue
attribute [local instance] Classical.propDecidable

variable {J E : Type*} [Fintype J] [LinearOrder J]

/-- A two-point fibre consisting of an edge and its long mate meets the first
    colour of an alternating cycle at most once. -/
theorem projectedCycle_edges_injective (τ υ : FixedPointFreeInvolution J)
    (p : J → E) (hfibre : ∀ j l, p j = p l → j = l ∨ j = υ.val l)
    (i : J) (hi : i ∈ matchingPairColor τ υ) :
    let σ := matchingPairPermutation τ υ
    let k := finitePermutationMinimalPeriod σ i / 2
    ∀ r s : ℕ, r < k → s < k →
      p (finiteMapIterate σ (2 * r) i) =
        p (finiteMapIterate σ (2 * s) i) → r = s := by
  dsimp
  let σ := matchingPairPermutation τ υ
  let C := matchingPairColor τ υ
  let n := finitePermutationMinimalPeriod σ i
  let k := n / 2
  have hneven : Even n := by
    change Even (finitePermutationMinimalPeriod (matchingPairPermutation τ υ) i)
    rw [finitePermutationMinimalPeriod_eq_orbitLength]
    exact matchingPairPermutation_even_orbit τ υ i
  have hnk : n = 2 * k := by
    obtain ⟨a, ha⟩ := hneven
    dsimp [k]
    omega
  have hflip (j : J) : σ j ∈ C ↔ j ∉ C := matchingPairSuccessor_color τ υ j
  have heven (r : ℕ) : finiteMapIterate σ (2 * r) i ∈ C := by
    induction r with
    | zero => simpa [finiteMapIterate, C] using hi
    | succ r ih =>
      let j := finiteMapIterate σ (2 * r) i
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
  have hpair := hfibre _ _ hprojection
  have heq : finiteMapIterate σ (2 * r) i = finiteMapIterate σ (2 * s) i := by
    rcases hpair with h | h
    · exact h
    · exfalso
      have hnot : υ.val (finiteMapIterate σ (2 * s) i) ∉ C := by
        intro hc
        exact (matchingPairSecondColor_alternates τ υ _).mp hc (heven s)
      exact hnot (h ▸ heven r)
  have hrn : 2 * r < n := by omega
  have hsn : 2 * s < n := by omega
  have hindex := finitePermutationIterate_injOn_period σ i hrn hsn heq
  omega

end Ising2DLambda.NecSuf.KacWard
