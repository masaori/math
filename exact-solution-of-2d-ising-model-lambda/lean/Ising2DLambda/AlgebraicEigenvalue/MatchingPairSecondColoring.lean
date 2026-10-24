import Ising2DLambda.AlgebraicEigenvalue.MatchingPairColoring

namespace Ising2DLambda.AlgebraicEigenvalue
variable {J : Type*} [Fintype J] [LinearOrder J]

/-- 二歩で色が保たれる四同値と、第一の相手による色反転をつなぐ。 -/
theorem matchingPairSecondColor_alternates (τ υ : FixedPointFreeInvolution J) (i : J) :
    υ.val i ∈ matchingPairColor τ υ ↔ i ∉ matchingPairColor τ υ := by
  let p := matchingPairStep τ υ
  let m := matchingPairComponentMinimum τ υ
  have hpreserve (j : J) : p j ∈ matchingPairColor τ υ ↔ j ∈ matchingPairColor τ υ := by
    have hj : j ∈ finitePermutationOrbit p j := finitePermutationOrbit_self_mem p j
    have hpj : p j ∈ finitePermutationOrbit p j :=
      (finitePermutationOrbit_invariant p j j).mpr hj
    have hcomponent : p j ∈ matchingPairComponent τ υ j := Or.inl hpj
    have hmin : m (p j) = m j :=
      matchingPairComponentMinimum_basepoint τ υ j (p j) hcomponent
    calc
      p j ∈ matchingPairColor τ υ ↔ p j ∈ finitePermutationOrbit p (m (p j)) := Iff.rfl
      _ ↔ p j ∈ finitePermutationOrbit p (m j) := by rw [hmin]
      _ ↔ j ∈ finitePermutationOrbit p (m j) := finitePermutationOrbit_invariant p (m j) j
      _ ↔ j ∈ matchingPairColor τ υ := Iff.rfl
  have hstep : p (τ.val i) = υ.val i := by
    calc
      p (τ.val i) = υ.val (τ.val (τ.val i)) := rfl
      _ = υ.val i := congrArg υ.val (τ.property.2 i)
  calc
    υ.val i ∈ matchingPairColor τ υ ↔ p (τ.val i) ∈ matchingPairColor τ υ := by rw [hstep]
    _ ↔ τ.val i ∈ matchingPairColor τ υ := hpreserve (τ.val i)
    _ ↔ i ∉ matchingPairColor τ υ := matchingPairColor_alternates τ υ i

end Ising2DLambda.AlgebraicEigenvalue
