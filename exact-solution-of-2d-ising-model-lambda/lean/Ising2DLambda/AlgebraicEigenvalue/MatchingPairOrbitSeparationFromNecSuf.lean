import Ising2DLambda.AlgebraicEigenvalue.MatchingPairOrbitSeparation
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairOrbitSeparation

namespace Ising2DLambda.AlgebraicEigenvalue
variable {J : Type*} [Fintype J]

/-- 有限集合上の二歩置換は、有限性を除いた定義の特殊化である。 -/
theorem matchingPairStep_eq_necSuf (τ υ : FixedPointFreeInvolution J) :
    matchingPairStep τ υ = NecSuf.AlgebraicEigenvalue.matchingPairStep τ υ := rfl

theorem matchingPairStep_iterate_ne_mate_from_necSuf
    (τ υ : FixedPointFreeInvolution J) (n : ℕ) (i : J) :
    finiteMapIterate (matchingPairStep τ υ) n i ≠ τ.val i :=
  NecSuf.AlgebraicEigenvalue.matchingPairStep_iterate_ne_mate τ υ n i

theorem matchingPairStep_inverse_iterate_ne_mate_from_necSuf
    (τ υ : FixedPointFreeInvolution J) (n : ℕ) (i : J) :
    finiteMapIterate (matchingPairStep τ υ).symm n i ≠ τ.val i :=
  NecSuf.AlgebraicEigenvalue.matchingPairStep_inverse_iterate_ne_mate τ υ n i

theorem matchingPairStep_mate_not_mem_from_necSuf
    (τ υ : FixedPointFreeInvolution J) (i : J) :
    τ.val i ∉ finitePermutationOrbit (matchingPairStep τ υ) i :=
  NecSuf.AlgebraicEigenvalue.matchingPairStep_mate_not_mem τ υ i

theorem matchingPairStep_orbits_disjoint_from_necSuf
    (τ υ : FixedPointFreeInvolution J) (i : J) :
    Disjoint (finitePermutationOrbit (matchingPairStep τ υ) i)
      (finitePermutationOrbit (matchingPairStep τ υ) (τ.val i)) :=
  NecSuf.AlgebraicEigenvalue.matchingPairStep_orbits_disjoint τ υ i

end Ising2DLambda.AlgebraicEigenvalue
