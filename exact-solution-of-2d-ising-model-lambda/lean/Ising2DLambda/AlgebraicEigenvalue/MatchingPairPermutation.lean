import Ising2DLambda.AlgebraicEigenvalue.MatchingPairSecondColoring

namespace Ising2DLambda.AlgebraicEigenvalue
variable {J : Type*} [Fintype J] [LinearOrder J]

/-- def_matching_pair_successor: 第一色では第一の相手、第二色では第二の相手へ進む。 -/
noncomputable def matchingPairSuccessor (τ υ : FixedPointFreeInvolution J) (i : J) : J :=
  open Classical in if i ∈ matchingPairColor τ υ then τ.val i else υ.val i

/-- def_matching_pair_predecessor: 後続写像と反対の相手を選ぶ。 -/
noncomputable def matchingPairPredecessor (τ υ : FixedPointFreeInvolution J) (i : J) : J :=
  open Classical in if i ∈ matchingPairColor τ υ then υ.val i else τ.val i

/-- claim_matching_pair_permutation: 本文の二場合と、それぞれの三等号。 -/
theorem matchingPairSuccessor_inverse (τ υ : FixedPointFreeInvolution J) (i : J) :
    matchingPairPredecessor τ υ (matchingPairSuccessor τ υ i) = i ∧
    matchingPairSuccessor τ υ (matchingPairPredecessor τ υ i) = i := by
  classical
  by_cases hi : i ∈ matchingPairColor τ υ
  · have htau : τ.val i ∉ matchingPairColor τ υ :=
      fun h => (matchingPairColor_alternates τ υ i).mp h hi
    have hupsilon : υ.val i ∉ matchingPairColor τ υ :=
      fun h => (matchingPairSecondColor_alternates τ υ i).mp h hi
    constructor
    · calc
        matchingPairPredecessor τ υ (matchingPairSuccessor τ υ i) =
            matchingPairPredecessor τ υ (τ.val i) := by rw [matchingPairSuccessor, if_pos hi]
        _ = τ.val (τ.val i) := by rw [matchingPairPredecessor, if_neg htau]
        _ = i := τ.property.2 i
    · calc
        matchingPairSuccessor τ υ (matchingPairPredecessor τ υ i) =
            matchingPairSuccessor τ υ (υ.val i) := by rw [matchingPairPredecessor, if_pos hi]
        _ = υ.val (υ.val i) := by rw [matchingPairSuccessor, if_neg hupsilon]
        _ = i := υ.property.2 i
  · have htau : τ.val i ∈ matchingPairColor τ υ :=
      (matchingPairColor_alternates τ υ i).mpr hi
    have hupsilon : υ.val i ∈ matchingPairColor τ υ :=
      (matchingPairSecondColor_alternates τ υ i).mpr hi
    constructor
    · calc
        matchingPairPredecessor τ υ (matchingPairSuccessor τ υ i) =
            matchingPairPredecessor τ υ (υ.val i) := by rw [matchingPairSuccessor, if_neg hi]
        _ = υ.val (υ.val i) := by rw [matchingPairPredecessor, if_pos hupsilon]
        _ = i := υ.property.2 i
    · calc
        matchingPairSuccessor τ υ (matchingPairPredecessor τ υ i) =
            matchingPairSuccessor τ υ (τ.val i) := by rw [matchingPairPredecessor, if_neg hi]
        _ = τ.val (τ.val i) := by rw [matchingPairSuccessor, if_pos htau]
        _ = i := τ.property.2 i

/-- 本文の互いに逆であることから得る置換。 -/
noncomputable def matchingPairPermutation (τ υ : FixedPointFreeInvolution J) : Equiv.Perm J where
  toFun := matchingPairSuccessor τ υ
  invFun := matchingPairPredecessor τ υ
  left_inv i := (matchingPairSuccessor_inverse τ υ i).1
  right_inv i := (matchingPairSuccessor_inverse τ υ i).2

/-- claim_matching_pair_successor_color: 一歩進むと第一色と第二色が入れ替わる。 -/
theorem matchingPairSuccessor_color (τ υ : FixedPointFreeInvolution J) (i : J) :
    matchingPairSuccessor τ υ i ∈ matchingPairColor τ υ ↔ i ∉ matchingPairColor τ υ := by
  classical
  by_cases hi : i ∈ matchingPairColor τ υ
  · have hstep : matchingPairSuccessor τ υ i = τ.val i := by
      rw [matchingPairSuccessor, if_pos hi]
    have hmate : τ.val i ∉ matchingPairColor τ υ :=
      fun h => (matchingPairColor_alternates τ υ i).mp h hi
    rw [hstep]
    simp [hi, hmate]
  · have hstep : matchingPairSuccessor τ υ i = υ.val i := by
      rw [matchingPairSuccessor, if_neg hi]
    have hmate : υ.val i ∈ matchingPairColor τ υ :=
      (matchingPairSecondColor_alternates τ υ i).mpr hi
    rw [hstep]
    simp [hi, hmate]

end Ising2DLambda.AlgebraicEigenvalue
