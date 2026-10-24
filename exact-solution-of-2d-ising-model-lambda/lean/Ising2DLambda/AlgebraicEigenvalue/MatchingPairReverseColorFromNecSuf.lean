import Ising2DLambda.AlgebraicEigenvalue.MatchingPairReverseColor

namespace Ising2DLambda.AlgebraicEigenvalue
variable {J : Type*} [Fintype J] [LinearOrder J]

/-- 抽象版の軌道上の色の一意性へ、具体的な最小元と色反転を供給する。 -/
theorem recoveredMatchingPair_color_eq_from_necSuf (σ : Equiv.Perm J)
    (heven : ∀ i, Even (finitePermutationOrbitLength σ i)) (i : J) :
    i ∈ matchingPairColor (recoveredFirstInvolution σ heven)
      (recoveredSecondInvolution σ heven) ↔ i ∈ finitePermutationEvenColor σ := by
  let τ := recoveredFirstInvolution σ heven
  let υ := recoveredSecondInvolution σ heven
  let m := finitePermutationOrbitMinimum σ i
  have hmPair : m ∈ matchingPairColor τ υ := by
    change m ∈ finitePermutationOrbit (matchingPairStep τ υ)
      (matchingPairComponentMinimum τ υ m)
    have hmin : matchingPairComponentMinimum τ υ m = m := by
      rw [recoveredMatchingPair_minimum_eq σ heven]
      exact finitePermutationOrbitMinimum_eq_of_mem σ i m
        (finitePermutationOrbitMinimum_mem σ i)
    rw [hmin]
    exact finitePermutationOrbit_self_mem _ m
  have hmEven : m ∈ finitePermutationEvenColor σ :=
    finitePermutationEvenColor_minimum_mem σ i
  have hi : i ∈ finitePermutationOrbit σ m :=
    finitePermutationOrbit_mem_symm σ i m (finitePermutationOrbitMinimum_mem σ i)
  exact (NecSuf.AlgebraicEigenvalue.alternatingColor_eq_on_orbit σ
    (finitePermutationEvenColor σ : Set J) (matchingPairColor τ υ)
    (finitePermutationEvenColor_alternates σ heven)
    (recoveredMatchingPair_color_alternates σ heven)
    m i (iff_of_true hmEven hmPair) hi).symm

end Ising2DLambda.AlgebraicEigenvalue
