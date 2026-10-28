import Ising2DLambda.AlgebraicEigenvalue.MatchingPairReversePermutation
import Ising2DLambda.AlgebraicEigenvalue.MatchingPairFirstRecovery
import Ising2DLambda.AlgebraicEigenvalue.MatchingPairSecondRecovery
import Ising2DLambda.AlgebraicEigenvalue.MatchingPairEvenOrbit
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairBijection

namespace Ising2DLambda.AlgebraicEigenvalue
variable {J : Type*} [Fintype J] [LinearOrder J]
open Classical

/-- 全軌道が偶数長の有限置換。 -/
def EvenOrbitPermutation (J : Type*) [Fintype J] :=
  {σ : Equiv.Perm J // ∀ i, Even (finitePermutationOrbitLength σ i)}

/-- マッチング対から偶数軌道の置換を作る。 -/
noncomputable def matchingPairToEvenOrbit
    (p : FixedPointFreeInvolution J × FixedPointFreeInvolution J) :
    EvenOrbitPermutation J :=
  ⟨matchingPairPermutation p.1 p.2, matchingPairPermutation_even_orbit p.1 p.2⟩

/-- 偶数軌道の置換から順序付きマッチング対を復元する。 -/
noncomputable def evenOrbitToMatchingPair (s : EvenOrbitPermutation J) :
    FixedPointFreeInvolution J × FixedPointFreeInvolution J :=
  (recoveredFirstInvolution s.val s.property,
    recoveredSecondInvolution s.val s.property)

/-- 最小元を第一色に取る二つの構成は、同じ色を選ぶ。 -/
theorem matchingPair_evenColor_eq (τ υ : FixedPointFreeInvolution J) (i : J) :
    i ∈ finitePermutationEvenColor (matchingPairPermutation τ υ) ↔
      i ∈ matchingPairColor τ υ := by
  let σ := matchingPairPermutation τ υ
  let m := finitePermutationOrbitMinimum σ i
  have hsets : matchingPairComponent τ υ i = finitePermutationOrbit σ i :=
    (matchingPairPermutation_orbit_eq_component τ υ i).symm
  have hpoints : matchingPairComponentPoints τ υ i = finitePermutationOrbitPoints σ i := by
    apply Finset.ext
    intro j
    simpa [matchingPairComponentPoints, finitePermutationOrbitPoints] using
      Set.ext_iff.mp hsets j
  have hmin : matchingPairComponentMinimum τ υ i = m := by
    change matchingPairComponentMinimum τ υ i = finitePermutationOrbitMinimum σ i
    simpa only [matchingPairComponentMinimum, finitePermutationOrbitMinimum, hpoints]
  have hmEven : m ∈ finitePermutationEvenColor σ :=
    finitePermutationEvenColor_minimum_mem σ i
  have hmPair : m ∈ matchingPairColor τ υ := by
    have hmComp : m ∈ matchingPairComponent τ υ i := by
      rw [hsets]
      exact finitePermutationOrbitMinimum_mem σ i
    have hbase := matchingPairComponentMinimum_basepoint τ υ i m hmComp
    change m ∈ finitePermutationOrbit (matchingPairStep τ υ)
      (matchingPairComponentMinimum τ υ m)
    rw [hbase, hmin]
    exact finitePermutationOrbit_self_mem _ m
  have hC (j : J) : σ j ∈ finitePermutationEvenColor σ ↔
      j ∉ finitePermutationEvenColor σ :=
    finitePermutationEvenColor_alternates σ
      (matchingPairPermutation_even_orbit τ υ) j
  have hD (j : J) : σ j ∈ matchingPairColor τ υ ↔
      j ∉ matchingPairColor τ υ := matchingPairSuccessor_color τ υ j
  have hi : i ∈ finitePermutationOrbit σ m :=
    finitePermutationOrbit_mem_symm σ i m (finitePermutationOrbitMinimum_mem σ i)
  let C : Set J := finitePermutationEvenColor σ
  let D : Set J := matchingPairColor τ υ
  have hbase : m ∈ C ↔ m ∈ D := iff_of_true hmEven hmPair
  exact finiteAlternatingColor_eq_on_orbit σ C D hC hD m i hbase hi

theorem matchingPair_bijection_left
    (p : FixedPointFreeInvolution J × FixedPointFreeInvolution J) :
    evenOrbitToMatchingPair (matchingPairToEvenOrbit p) = p := by
  rcases p with ⟨τ, υ⟩
  have hcolor : finitePermutationEvenColor (matchingPairPermutation τ υ) =
      matchingPairColor τ υ := by
    ext i
    exact matchingPair_evenColor_eq τ υ i
  apply Prod.ext
  · apply Subtype.ext
    funext i
    change alternatingNeighbor (matchingPairPermutation τ υ)
      (finitePermutationEvenColor (matchingPairPermutation τ υ)) i = τ.val i
    rw [hcolor]
    exact matchingPair_first_neighbor_recovered τ υ i
  · apply Subtype.ext
    funext i
    change alternatingNeighbor (matchingPairPermutation τ υ).symm
      (finitePermutationEvenColor (matchingPairPermutation τ υ)) i = υ.val i
    rw [hcolor]
    exact matchingPair_second_neighbor_recovered τ υ i

theorem matchingPair_bijection_right (s : EvenOrbitPermutation J) :
    matchingPairToEvenOrbit (evenOrbitToMatchingPair s) = s := by
  apply Subtype.ext
  exact recoveredMatchingPair_permutation_eq s.val s.property

/-- 順序付きマッチング対と偶数軌道の置換との全単射。 -/
noncomputable def matchingPairEvenOrbitEquiv :
    (FixedPointFreeInvolution J × FixedPointFreeInvolution J) ≃ EvenOrbitPermutation J where
  toFun := matchingPairToEvenOrbit
  invFun := evenOrbitToMatchingPair
  left_inv := matchingPair_bijection_left
  right_inv := matchingPair_bijection_right

noncomputable def matchingPairEvenOrbitEquiv_from_necSuf :
    (FixedPointFreeInvolution J × FixedPointFreeInvolution J) ≃ EvenOrbitPermutation J :=
  NecSuf.AlgebraicEigenvalue.equivalenceOfTwoSidedInverse
    matchingPairToEvenOrbit evenOrbitToMatchingPair
    matchingPair_bijection_left matchingPair_bijection_right

noncomputable def perfectMatchingPairEvenOrbitEquiv :
    (PerfectMatching J × PerfectMatching J) ≃ EvenOrbitPermutation J :=
  (Equiv.prodCongr perfectMatchingEquivInvolution
    perfectMatchingEquivInvolution).trans matchingPairEvenOrbitEquiv

end Ising2DLambda.AlgebraicEigenvalue
