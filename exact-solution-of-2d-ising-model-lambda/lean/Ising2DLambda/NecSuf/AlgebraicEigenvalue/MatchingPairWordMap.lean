import Mathlib.Data.List.Basic

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

variable {J : Type*}

/-- 第一色で第一の相手を選び、その相手では第二の相手を選ぶ写像は、
二点ずつ並べた列を対ごとに写す。使うのは二つの場合の値だけである。 -/
theorem matchingPairWordMap_necSuf (C : Set J) (σ τ υ : J → J)
    (w : List J) (hw : ∀ i ∈ w, i ∈ C)
    (hfirst : ∀ i ∈ C, σ i = τ i)
    (hflip : ∀ i ∈ C, τ i ∉ C)
    (hsecond : ∀ j ∉ C, σ j = υ j) :
    (w.flatMap (fun i => [i, τ i])).map σ =
      w.flatMap (fun i => [τ i, υ (τ i)]) := by
  induction w with
  | nil => rfl
  | cons i rest ih =>
      have hi : i ∈ C := hw i (by simp)
      have hrest : ∀ j ∈ rest, j ∈ C := by
        intro j hj
        exact hw j (by simp [hj])
      simp only [List.flatMap_cons, List.map_append, List.map_cons, List.map_nil]
      rw [hfirst i hi, hsecond (τ i) (hflip i hi), ih hrest]

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
