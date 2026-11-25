import Ising2DLambda.NecSuf.KacWard.AlternatingCycleEnumeration
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairSecondColoring

namespace Ising2DLambda.NecSuf.KacWard

open Ising2DLambda.NecSuf.AlgebraicEigenvalue
attribute [local instance] Classical.propDecidable

variable {J : Type*} [Fintype J]

/-- 成分の指定された代表から始めても、交互閉路は元の点の成分を列挙する。 -/
theorem alternatingCycleAtRepresentative (τ υ : FixedPointFreeInvolution J)
    (le : J → J → Prop) (hanti : ∀ a b, le a b → le b a → a = b)
    (m : J → J)
    (hmem : ∀ i, m i ∈ matchingPairComponent τ.val υ.val τ.property.2 υ.property.2 i)
    (hleast : ∀ i j, j ∈ matchingPairComponent τ.val υ.val τ.property.2 υ.property.2 i → le (m i) j)
    (i : J) :
    let C : J → Prop := fun j => j ∈ matchingPairColor τ υ m
    let σ := matchingPairPermutation τ.val υ.val C τ.property.2 υ.property.2
      (matchingPairColor_alternates τ υ le hanti m hmem hleast)
      (matchingPairSecondColor_alternates τ υ le hanti m hmem hleast)
    let p := finiteInjectiveMinimalPeriod σ σ.injective (m i)
    Even p ∧
      Function.Bijective (twoWayOrbitEnumeration σ σ.symm (m i) p) ∧
      twoWayOrbit σ σ.symm (m i) =
        matchingPairComponent τ.val υ.val τ.property.2 υ.property.2 i ∧
      σ^[p] (m i) = m i ∧
      (∀ j, C (σ j) ↔ ¬ C j) ∧
      (∀ j, σ j = if C j then τ.val j else υ.val j) := by
  let C : J → Prop := fun j => j ∈ matchingPairColor τ υ m
  have hτcolor (j : J) : C (τ.val j) ↔ ¬ C j :=
    matchingPairColor_alternates τ υ le hanti m hmem hleast j
  have hυcolor (j : J) : C (υ.val j) ↔ ¬ C j :=
    matchingPairSecondColor_alternates τ υ le hanti m hmem hleast j
  have hcycle := alternatingCycleEnumeration_necSuf
    τ.val υ.val C τ.property.2 υ.property.2 hτcolor hυcolor (m i)
  dsimp at hcycle ⊢
  rcases hcycle with ⟨heven, hbij, horbit, hreturn, hflip, hstep⟩
  refine ⟨heven, hbij, ?_, hreturn, hflip, hstep⟩
  calc
    twoWayOrbit
        (matchingPairPermutation τ.val υ.val C τ.property.2 υ.property.2 hτcolor hυcolor)
        (matchingPairPermutation τ.val υ.val C τ.property.2 υ.property.2 hτcolor hυcolor).symm
        (m i) = matchingPairComponent τ.val υ.val τ.property.2 υ.property.2 (m i) := horbit
    _ = matchingPairComponent τ.val υ.val τ.property.2 υ.property.2 i :=
      matchingPairComponent_basepoint τ.val υ.val τ.property.2 υ.property.2 i (m i) (hmem i)

end Ising2DLambda.NecSuf.KacWard
