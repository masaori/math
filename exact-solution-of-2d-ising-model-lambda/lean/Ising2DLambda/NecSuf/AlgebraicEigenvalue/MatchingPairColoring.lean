import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairComponent
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairOrbitSeparation

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue
variable {J : Type*}

/- 有限性・全順序・最小元の探索手続きは不要。合併内の最小元の仕様と比較の反対称性だけを残す。
対合性は軌道の交換と合併の始点独立性に、不動点の不在は二軌道の非交叉に必要。 -/
theorem matchingPairMinimum_basepoint (τ υ : FixedPointFreeInvolution J)
    (le : J → J → Prop) (hanti : ∀ a b, le a b → le b a → a = b)
    (m : J → J)
    (hmem : ∀ i, m i ∈ matchingPairComponent τ.val υ.val τ.property.2 υ.property.2 i)
    (hleast : ∀ i j, j ∈ matchingPairComponent τ.val υ.val τ.property.2 υ.property.2 i → le (m i) j)
    (i j : J) (hj : j ∈ matchingPairComponent τ.val υ.val τ.property.2 υ.property.2 i) :
    m j = m i := by
  have hsets := matchingPairComponent_basepoint τ.val υ.val τ.property.2 υ.property.2 i j hj
  have hmj : m j ∈ matchingPairComponent τ.val υ.val τ.property.2 υ.property.2 i := by
    rw [← hsets]
    exact hmem j
  have hmi : m i ∈ matchingPairComponent τ.val υ.val τ.property.2 υ.property.2 j := by
    rw [hsets]
    exact hmem i
  have hle := hleast j (m i) hmi
  have hge := hleast i (m j) hmj
  exact hanti (m j) (m i) hle hge

def matchingPairColor (τ υ : FixedPointFreeInvolution J) (m : J → J) : Set J :=
  {i | i ∈ permutationOrbit (matchingPairStep τ υ) (m i)}

/-- 具体版と同じ、最小元の比較に続く二場合。 -/
theorem matchingPairColor_alternates (τ υ : FixedPointFreeInvolution J)
    (le : J → J → Prop) (hanti : ∀ a b, le a b → le b a → a = b)
    (m : J → J)
    (hmem : ∀ i, m i ∈ matchingPairComponent τ.val υ.val τ.property.2 υ.property.2 i)
    (hleast : ∀ i j, j ∈ matchingPairComponent τ.val υ.val τ.property.2 υ.property.2 i → le (m i) j)
    (i : J) : τ.val i ∈ matchingPairColor τ υ m ↔ i ∉ matchingPairColor τ υ m := by
  classical
  let p := matchingPairStep τ υ
  have hmin := hmem i
  have hcomponent : matchingPairComponent τ.val υ.val τ.property.2 υ.property.2 (m i) =
      matchingPairComponent τ.val υ.val τ.property.2 υ.property.2 i :=
    matchingPairComponent_basepoint τ.val υ.val τ.property.2 υ.property.2 i (m i) hmin
  have hi : i ∈ matchingPairComponent τ.val υ.val τ.property.2 υ.property.2 (m i) := by
    rw [hcomponent]
    exact Or.inl (permutationOrbit_self_mem_necSuf p i)
  have htau : τ.val i ∈ matchingPairComponent τ.val υ.val τ.property.2 υ.property.2 i :=
    Or.inr (permutationOrbit_self_mem_necSuf p (τ.val i))
  have hminTau : m (τ.val i) = m i :=
    matchingPairMinimum_basepoint τ υ le hanti m hmem hleast i (τ.val i) htau
  change τ.val i ∈ permutationOrbit p (m (τ.val i)) ↔ i ∉ permutationOrbit p (m i)
  rw [hminTau]
  by_cases hfirst : i ∈ permutationOrbit p (m i)
  · have hmate : τ.val i ∈ permutationOrbit p (τ.val (m i)) :=
      matchingPairStep_mate_mem τ.val υ.val τ.property.2 υ.property.2 (m i) i hfirst
    have hnot : τ.val i ∉ permutationOrbit p (m i) := by
      intro hbad
      exact Set.disjoint_left.mp (matchingPairStep_orbits_disjoint τ υ (m i)) hbad hmate
    exact iff_of_false hnot (not_not.mpr hfirst)
  · have hsecond : i ∈ permutationOrbit p (τ.val (m i)) := hi.resolve_left hfirst
    have hmate : τ.val i ∈ permutationOrbit p (τ.val (τ.val (m i))) :=
      matchingPairStep_mate_mem τ.val υ.val τ.property.2 υ.property.2 (τ.val (m i)) i hsecond
    have hcancel : τ.val (τ.val (m i)) = m i := τ.property.2 (m i)
    have hreturn : τ.val i ∈ permutationOrbit p (m i) := by
      rw [hcancel] at hmate
      exact hmate
    exact iff_of_true hreturn hfirst

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
