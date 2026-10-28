import Ising2DLambda.AlgebraicEigenvalue.MatchingPairReverseOrbit
import Ising2DLambda.AlgebraicEigenvalue.MatchingPairSecondColoring

namespace Ising2DLambda.AlgebraicEigenvalue
variable {J : Type*} [Fintype J] [LinearOrder J]
open Classical

/-- 一歩ごとに反転する二色は、同じ軌道の一つの点で一致すれば全点で一致する。 -/
theorem finiteAlternatingColor_eq_on_orbit (σ : Equiv.Perm J)
    (C D : Set J)
    (hC : ∀ j, σ j ∈ C ↔ j ∉ C)
    (hD : ∀ j, σ j ∈ D ↔ j ∉ D)
    (m i : J) (hm : m ∈ C ↔ m ∈ D)
    (hi : i ∈ finitePermutationOrbit σ m) : (i ∈ C ↔ i ∈ D) := by
  have hforward (j : J) (hj : j ∈ C ↔ j ∈ D) :
      σ j ∈ C ↔ σ j ∈ D := by
    rw [hC j, hD j]
    exact not_congr hj
  have hback (j : J) (hj : j ∈ C ↔ j ∈ D) :
      σ.symm j ∈ C ↔ σ.symm j ∈ D := by
    have hc := hC (σ.symm j)
    have hd := hD (σ.symm j)
    simp only [Equiv.apply_symm_apply] at hc hd
    tauto
  rcases hi with ⟨n, hn | hn⟩
  · subst i
    induction n with
    | zero =>
      change m ∈ C ↔ m ∈ D
      exact hm
    | succ n ih =>
      rw [finiteMapIterate, Function.iterate_succ_apply']
      exact hforward _ ih
  · subst i
    induction n with
    | zero =>
      change m ∈ C ↔ m ∈ D
      exact hm
    | succ n ih =>
      rw [finiteMapIterate, Function.iterate_succ_apply']
      exact hback _ ih

/-- 合併と軌道が一致するので、それぞれの最小元も一致する。 -/
theorem recoveredMatchingPair_minimum_eq (σ : Equiv.Perm J)
    (heven : ∀ i, Even (finitePermutationOrbitLength σ i)) (i : J) :
    matchingPairComponentMinimum (recoveredFirstInvolution σ heven)
      (recoveredSecondInvolution σ heven) i = finitePermutationOrbitMinimum σ i := by
  have hsets := recoveredMatchingPair_component_eq_orbit σ heven i
  have hpoints : matchingPairComponentPoints (recoveredFirstInvolution σ heven)
      (recoveredSecondInvolution σ heven) i = finitePermutationOrbitPoints σ i := by
    apply Finset.ext
    intro j
    simpa [matchingPairComponentPoints, finitePermutationOrbitPoints] using
      Set.ext_iff.mp hsets j
  simpa only [matchingPairComponentMinimum, finitePermutationOrbitMinimum, hpoints]

/-- 復元した対の第一色も、元の置換の一歩で反転する。 -/
theorem recoveredMatchingPair_color_alternates (σ : Equiv.Perm J)
    (heven : ∀ i, Even (finitePermutationOrbitLength σ i)) (j : J) :
    σ j ∈ matchingPairColor (recoveredFirstInvolution σ heven)
      (recoveredSecondInvolution σ heven) ↔
    j ∉ matchingPairColor (recoveredFirstInvolution σ heven)
      (recoveredSecondInvolution σ heven) := by
  let τ := recoveredFirstInvolution σ heven
  let υ := recoveredSecondInvolution σ heven
  by_cases hj : j ∈ finitePermutationEvenColor σ
  · have ht : τ.val j = σ j := by simp [τ, recoveredFirstInvolution, alternatingNeighbor, hj]
    rw [← ht]
    exact matchingPairColor_alternates τ υ j
  · have hu : υ.val j = σ j := by simp [υ, recoveredSecondInvolution, alternatingNeighbor, hj]
    rw [← hu]
    exact matchingPairSecondColor_alternates τ υ j

/-- 軌道の最小元は両方の第一色に入り、二つの色は一歩ごとに反転する。 -/
theorem recoveredMatchingPair_color_eq (σ : Equiv.Perm J)
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
  let C : Set J := finitePermutationEvenColor σ
  let D : Set J := matchingPairColor τ υ
  have hC (j : J) : σ j ∈ C ↔ j ∉ C :=
    finitePermutationEvenColor_alternates σ heven j
  have hD (j : J) : σ j ∈ D ↔ j ∉ D :=
    recoveredMatchingPair_color_alternates σ heven j
  have hbase : m ∈ C ↔ m ∈ D := iff_of_true hmEven hmPair
  exact (finiteAlternatingColor_eq_on_orbit σ C D hC hD m i hbase hi).symm

end Ising2DLambda.AlgebraicEigenvalue
