import Ising2DLambda.NecSuf.KacWard.TaggedDifferenceAlternatingCycle

namespace Ising2DLambda.NecSuf.KacWard

open Ising2DLambda.AlgebraicEigenvalue
attribute [local instance] Classical.propDecidable

variable {J : Type*} [Fintype J] [LinearOrder J]

/-- The first-colour vertices of an alternating cycle return after half its even period.
    The long mate of each intervening second-colour vertex is the next first-colour vertex. -/
theorem projectedClosedEdgeCycle (τ υ : FixedPointFreeInvolution J) (i : J)
    (hi : i ∈ matchingPairColor τ υ) :
    let σ := matchingPairPermutation τ υ
    ∃ k : ℕ, 0 < k ∧ finiteMapIterate σ (2 * k) i = i ∧
      ∀ r : ℕ, r < k →
        υ.val (finiteMapIterate σ (2 * r + 1) i) =
          finiteMapIterate σ (2 * (r + 1)) i := by
  dsimp
  let σ := matchingPairPermutation τ υ
  let C := matchingPairColor τ υ
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
  let n := finitePermutationMinimalPeriod σ i
  have hnpos : 0 < n := (finitePermutationMinimalPeriod_spec σ i).1
  have hnreturn : finiteMapIterate σ n i = i :=
    (finitePermutationMinimalPeriod_spec σ i).2.1
  have hneven : Even n := by
    change Even (finitePermutationMinimalPeriod (matchingPairPermutation τ υ) i)
    rw [finitePermutationMinimalPeriod_eq_orbitLength]
    exact matchingPairPermutation_even_orbit τ υ i
  obtain ⟨k, hk⟩ := hneven
  have hkpos : 0 < k := by omega
  refine ⟨k, hkpos, ?_, ?_⟩
  · calc
      finiteMapIterate σ (2 * k) i = finiteMapIterate σ n i := by
        congr 1
        omega
      _ = i := hnreturn
  · intro r _
    have hodd : finiteMapIterate σ (2 * r + 1) i ∉ C := by
      have hstep : finiteMapIterate σ (2 * r + 1) i =
          σ (finiteMapIterate σ (2 * r) i) := by
        rw [show 2 * r + 1 = 1 + 2 * r by omega, finiteMapIterate_add]
        rfl
      rw [hstep]
      intro h
      exact (hflip _).mp h (heven r)
    calc
      υ.val (finiteMapIterate σ (2 * r + 1) i) =
          σ (finiteMapIterate σ (2 * r + 1) i) := by
            change υ.val _ = matchingPairSuccessor τ υ _
            rw [matchingPairSuccessor, if_neg hodd]
      _ = finiteMapIterate σ (1 + (2 * r + 1)) i :=
        (finiteMapIterate_add σ 1 (2 * r + 1) i).symm
      _ = finiteMapIterate σ (2 * (r + 1)) i := by
        congr 1
        omega

end Ising2DLambda.NecSuf.KacWard
