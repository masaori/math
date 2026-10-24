import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairColoring

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue
variable {J : Type*}

/- 有限性と全順序は不要。最小元の所属・下界性と比較の反対称性は、
二歩後の最小元の一致と、既存の第一の相手による色反転に使う。
対合性は二歩の構成と相手の打ち消し、不動点の不在は第一の色反転に必要。 -/
theorem matchingPairSecondColor_alternates (τ υ : FixedPointFreeInvolution J)
    (le : J → J → Prop) (hanti : ∀ a b, le a b → le b a → a = b)
    (m : J → J)
    (hmem : ∀ i, m i ∈ matchingPairComponent τ.val υ.val τ.property.2 υ.property.2 i)
    (hleast : ∀ i j, j ∈ matchingPairComponent τ.val υ.val τ.property.2 υ.property.2 i → le (m i) j)
    (i : J) :
    υ.val i ∈ matchingPairColor τ υ m ↔ i ∉ matchingPairColor τ υ m := by
  let p := matchingPairStep τ υ
  have hpreserve (j : J) : p j ∈ matchingPairColor τ υ m ↔ j ∈ matchingPairColor τ υ m := by
    have hj : j ∈ permutationOrbit p j := permutationOrbit_self_mem_necSuf p j
    have hpj : p j ∈ permutationOrbit p j :=
      (permutationOrbit_invariant_necSuf p j j).mpr hj
    have hcomponent : p j ∈ matchingPairComponent τ.val υ.val τ.property.2 υ.property.2 j := Or.inl hpj
    have hmin : m (p j) = m j :=
      matchingPairMinimum_basepoint τ υ le hanti m hmem hleast j (p j) hcomponent
    calc
      p j ∈ matchingPairColor τ υ m ↔ p j ∈ permutationOrbit p (m (p j)) := Iff.rfl
      _ ↔ p j ∈ permutationOrbit p (m j) := by rw [hmin]
      _ ↔ j ∈ permutationOrbit p (m j) := permutationOrbit_invariant_necSuf p (m j) j
      _ ↔ j ∈ matchingPairColor τ υ m := Iff.rfl
  have hstep : p (τ.val i) = υ.val i := by
    calc
      p (τ.val i) = υ.val (τ.val (τ.val i)) := rfl
      _ = υ.val i := congrArg υ.val (τ.property.2 i)
  calc
    υ.val i ∈ matchingPairColor τ υ m ↔ p (τ.val i) ∈ matchingPairColor τ υ m := by rw [hstep]
    _ ↔ τ.val i ∈ matchingPairColor τ υ m := hpreserve (τ.val i)
    _ ↔ i ∉ matchingPairColor τ υ m := matchingPairColor_alternates τ υ le hanti m hmem hleast i

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
