import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairSecondColoring
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairPermutation

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

variable {J : Type*} [Fintype J] [LinearOrder J]

/-- 成分の最小元を含む二歩軌道から第一色を選ぶ。 -/
def matchingPairFirstColor (τ υ : FixedPointFreeInvolution J) : Set J :=
  matchingPairColor τ υ (matchingPairComponentMinimum τ υ)

theorem matchingPairFirstColor_first_mate (τ υ : FixedPointFreeInvolution J) (i : J) :
    τ.val i ∈ matchingPairFirstColor τ υ ↔ i ∉ matchingPairFirstColor τ υ :=
  matchingPairColor_alternates τ υ (· ≤ ·) (fun _ _ => le_antisymm)
    (matchingPairComponentMinimum τ υ)
    (matchingPairComponentMinimum_mem τ υ)
    (matchingPairComponentMinimum_le τ υ) i

theorem matchingPairFirstColor_second_mate (τ υ : FixedPointFreeInvolution J) (i : J) :
    υ.val i ∈ matchingPairFirstColor τ υ ↔ i ∉ matchingPairFirstColor τ υ :=
  matchingPairSecondColor_alternates τ υ (· ≤ ·) (fun _ _ => le_antisymm)
    (matchingPairComponentMinimum τ υ)
    (matchingPairComponentMinimum_mem τ υ)
    (matchingPairComponentMinimum_le τ υ) i

/-- 第一色では第一の相手、第二色では第二の相手へ進む。 -/
noncomputable def matchingPairMinimumSuccessor (τ υ : FixedPointFreeInvolution J) (i : J) : J :=
  matchingPairSuccessor τ.val υ.val (fun j => j ∈ matchingPairFirstColor τ υ) i

/-- 前後で異なる相手を選ぶ写像を逆写像とする。 -/
noncomputable def matchingPairMinimumPermutation (τ υ : FixedPointFreeInvolution J) : Equiv.Perm J :=
  matchingPairPermutation τ.val υ.val (fun j => j ∈ matchingPairFirstColor τ υ)
    τ.property.2 υ.property.2
    (matchingPairFirstColor_first_mate τ υ)
    (matchingPairFirstColor_second_mate τ υ)

theorem matchingPairMinimumPermutation_apply (τ υ : FixedPointFreeInvolution J) (i : J) :
    matchingPairMinimumPermutation τ υ i = matchingPairMinimumSuccessor τ υ i :=
  rfl

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
