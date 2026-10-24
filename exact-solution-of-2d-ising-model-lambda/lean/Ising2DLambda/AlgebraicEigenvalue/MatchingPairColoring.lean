import Ising2DLambda.AlgebraicEigenvalue.MatchingPairComponent
import Mathlib.Data.Finset.Max

namespace Ising2DLambda.AlgebraicEigenvalue
variable {J : Type*} [Fintype J]

noncomputable def matchingPairComponentPoints (τ υ : FixedPointFreeInvolution J) (i : J) : Finset J :=
  open Classical in Set.toFinset (matchingPairComponent τ υ i)

theorem matchingPairComponentPoints_nonempty (τ υ : FixedPointFreeInvolution J) (i : J) :
    (matchingPairComponentPoints τ υ i).Nonempty := by
  classical
  exact ⟨i, Set.mem_toFinset.mpr (Or.inl (finitePermutationOrbit_self_mem _ i))⟩

variable [LinearOrder J]

/-- 合併の最小元。空集合では引数 i が存在しない。 -/
noncomputable def matchingPairComponentMinimum (τ υ : FixedPointFreeInvolution J) (i : J) : J :=
  (matchingPairComponentPoints τ υ i).min' (matchingPairComponentPoints_nonempty τ υ i)

theorem matchingPairComponentMinimum_mem (τ υ : FixedPointFreeInvolution J) (i : J) :
    matchingPairComponentMinimum τ υ i ∈ matchingPairComponent τ υ i := by
  classical
  exact Set.mem_toFinset.mp (Finset.min'_mem _ _)

theorem matchingPairComponentMinimum_le (τ υ : FixedPointFreeInvolution J) (i j : J)
    (hj : j ∈ matchingPairComponent τ υ i) : matchingPairComponentMinimum τ υ i ≤ j := by
  classical
  exact Finset.min'_le _ _ (Set.mem_toFinset.mpr hj)

/-- 同じ合併内の二最小元を互いに比較する、本文の準備。 -/
theorem matchingPairComponentMinimum_basepoint (τ υ : FixedPointFreeInvolution J) (i j : J)
    (hj : j ∈ matchingPairComponent τ υ i) :
    matchingPairComponentMinimum τ υ j = matchingPairComponentMinimum τ υ i := by
  have hsets := matchingPairComponent_basepoint τ υ i j hj
  have hmj : matchingPairComponentMinimum τ υ j ∈ matchingPairComponent τ υ i := by
    rw [← hsets]
    exact matchingPairComponentMinimum_mem τ υ j
  have hmi : matchingPairComponentMinimum τ υ i ∈ matchingPairComponent τ υ j := by
    rw [hsets]
    exact matchingPairComponentMinimum_mem τ υ i
  have hle := matchingPairComponentMinimum_le τ υ j _ hmi
  have hge := matchingPairComponentMinimum_le τ υ i _ hmj
  exact le_antisymm hle hge

/-- 最小元を含む二歩軌道を第一色に選ぶ。 -/
def matchingPairColor (τ υ : FixedPointFreeInvolution J) : Set J :=
  {i | i ∈ finitePermutationOrbit (matchingPairStep τ υ) (matchingPairComponentMinimum τ υ i)}

/-- 本文の二場合。第一色なら交換先との非交叉を、第二色なら対合性を使う。 -/
theorem matchingPairColor_alternates (τ υ : FixedPointFreeInvolution J) (i : J) :
    τ.val i ∈ matchingPairColor τ υ ↔ i ∉ matchingPairColor τ υ := by
  classical
  let p := matchingPairStep τ υ
  let m := matchingPairComponentMinimum τ υ i
  have hmin : m ∈ matchingPairComponent τ υ i := matchingPairComponentMinimum_mem τ υ i
  have hcomponent : matchingPairComponent τ υ m = matchingPairComponent τ υ i :=
    matchingPairComponent_basepoint τ υ i m hmin
  have hi : i ∈ matchingPairComponent τ υ m := by
    rw [hcomponent]
    exact Or.inl (finitePermutationOrbit_self_mem p i)
  have htau : τ.val i ∈ matchingPairComponent τ υ i :=
    Or.inr (finitePermutationOrbit_self_mem p (τ.val i))
  have hminTau : matchingPairComponentMinimum τ υ (τ.val i) = m :=
    matchingPairComponentMinimum_basepoint τ υ i (τ.val i) htau
  change (τ.val i ∈ finitePermutationOrbit p (matchingPairComponentMinimum τ υ (τ.val i))) ↔
    i ∉ finitePermutationOrbit p m
  rw [hminTau]
  by_cases hfirst : i ∈ finitePermutationOrbit p m
  · have hmate : τ.val i ∈ finitePermutationOrbit p (τ.val m) :=
      matchingPairStep_mate_mem τ υ m i hfirst
    have hnot : τ.val i ∉ finitePermutationOrbit p m := by
      intro hbad
      exact Set.disjoint_left.mp (matchingPairStep_orbits_disjoint τ υ m) hbad hmate
    exact iff_of_false hnot (not_not.mpr hfirst)
  · have hsecond : i ∈ finitePermutationOrbit p (τ.val m) := hi.resolve_left hfirst
    have hmate : τ.val i ∈ finitePermutationOrbit p (τ.val (τ.val m)) :=
      matchingPairStep_mate_mem τ υ (τ.val m) i hsecond
    have hcancel : τ.val (τ.val m) = m := τ.property.2 m
    have hreturn : τ.val i ∈ finitePermutationOrbit p m := by
      rw [hcancel] at hmate
      exact hmate
    exact iff_of_true hreturn hfirst

end Ising2DLambda.AlgebraicEigenvalue
