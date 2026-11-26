import Ising2DLambda.AlgebraicEigenvalue.MatchingPairPermutation

namespace Ising2DLambda.AlgebraicEigenvalue

variable {J : Type*} [Fintype J] [LinearOrder J]

/-- 実際の二つの完全マッチングから作った置換について、
第一色の各点とその第一の相手を順に写す。 -/
theorem matchingPairWordMap (τ υ : FixedPointFreeInvolution J)
    (w : List J) (hw : ∀ i ∈ w, i ∈ matchingPairColor τ υ) :
    (w.flatMap (fun i => [i, τ.val i])).map (matchingPairPermutation τ υ) =
      w.flatMap (fun i => [τ.val i, υ.val (τ.val i)]) := by
  classical
  induction w with
  | nil => rfl
  | cons i rest ih =>
      have hi : i ∈ matchingPairColor τ υ := hw i (by simp)
      have hrest : ∀ j ∈ rest, j ∈ matchingPairColor τ υ := by
        intro j hj
        exact hw j (by simp [hj])
      have hmate : τ.val i ∉ matchingPairColor τ υ := by
        intro h
        exact ((matchingPairColor_alternates τ υ i).mp h) hi
      have hfirst : matchingPairPermutation τ υ i = τ.val i := by
        simp [matchingPairPermutation, matchingPairSuccessor, hi]
      have hsecond : matchingPairPermutation τ υ (τ.val i) = υ.val (τ.val i) := by
        simp [matchingPairPermutation, matchingPairSuccessor, hmate]
      simp only [List.flatMap_cons, List.map_append, List.map_cons, List.map_nil]
      rw [hfirst, hsecond, ih hrest]

end Ising2DLambda.AlgebraicEigenvalue
