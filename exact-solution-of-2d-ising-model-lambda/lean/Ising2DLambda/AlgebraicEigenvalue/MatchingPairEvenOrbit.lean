import Ising2DLambda.AlgebraicEigenvalue.MatchingPairPermutation
import Ising2DLambda.AlgebraicEigenvalue.FinitePermutationOrbitEnumeration
import Mathlib.Tactic

namespace Ising2DLambda.AlgebraicEigenvalue
variable {J : Type*} [Fintype J] [LinearOrder J]

/-- 色の交替と最小正周期から、構成した置換の各軌道長は偶数。 -/
theorem matchingPairPermutation_even_orbit (τ υ : FixedPointFreeInvolution J) (i : J) :
    Even (finitePermutationOrbitLength (matchingPairPermutation τ υ) i) := by
  let σ := matchingPairPermutation τ υ
  let C := matchingPairColor τ υ
  let p := finitePermutationMinimalPeriod σ i
  have hflip (j : J) : σ j ∈ C ↔ j ∉ C := matchingPairSuccessor_color τ υ j
  have hpar : ∀ k : ℕ, finiteMapIterate σ k i ∈ C ↔ (k % 2 = 0 ↔ i ∈ C) := by
    intro k
    induction k with
    | zero => simp [finiteMapIterate]
    | succ k ih =>
      rw [finiteMapIterate, Function.iterate_succ_apply', hflip, ← finiteMapIterate, ih]
      by_cases hk : k % 2 = 0 <;> by_cases hi : i ∈ C <;> simp [hk, hi] <;> omega
  have hreturn : finiteMapIterate σ p i = i := (finitePermutationMinimalPeriod_spec σ i).2.1
  have hsame : (finiteMapIterate σ p i ∈ C) ↔ i ∈ C := by rw [hreturn]
  have heven : p % 2 = 0 := by
    by_cases hi : i ∈ C
    · have hp := (hpar p).mp (hsame.mpr hi)
      exact hp.mpr hi
    · by_contra hp
      have hp' := (hpar p).mpr (by simp [hp, hi])
      exact hi (hsame.mp hp')
  rw [← finitePermutationMinimalPeriod_eq_orbitLength]
  change Even p
  exact Nat.even_iff.mpr heven

end Ising2DLambda.AlgebraicEigenvalue
