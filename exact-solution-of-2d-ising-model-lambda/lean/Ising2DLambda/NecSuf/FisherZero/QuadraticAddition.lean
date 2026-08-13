/-
「二次体の和の表示」の必要十分版。
和の表示を作る等式と、表示写像の一意性だけを要求する。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.FisherZero

theorem add_mem_necSuf
    {A K : Type} (addA : A → A → A) (addK : K → K → K)
    (combine : A → A → K) (a b a' b' : A)
    (hadd : addK (combine a b) (combine a' b') =
      combine (addA a a') (addA b b')) :
    ∃ c d : A, addK (combine a b) (combine a' b') = combine c d := by
  exact ⟨addA a a', addA b b', hadd⟩

theorem add_representation_necSuf
    {A K V : Type} (addA : A → A → A) (addK : K → K → K)
    (value : K → V) (combine : A → A → V) (rep : K → A × A)
    (hUnique : ∀ x : K, ∀ a b : A, value x = combine a b → rep x = (a, b))
    (x y : K)
    (hadd : value (addK x y) =
      combine (addA (rep x).1 (rep y).1) (addA (rep x).2 (rep y).2)) :
    rep (addK x y) =
      (addA (rep x).1 (rep y).1, addA (rep x).2 (rep y).2) := by
  exact hUnique (addK x y)
    (addA (rep x).1 (rep y).1) (addA (rep x).2 (rep y).2) hadd

end Ising2DLambda.NecSuf.FisherZero
