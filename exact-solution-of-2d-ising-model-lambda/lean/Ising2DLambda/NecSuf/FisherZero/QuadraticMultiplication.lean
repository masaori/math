/-
「二次体の積の表示」の必要十分版。
積の表示を作る等式と、表示写像の一意性だけを要求する。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.FisherZero

theorem mul_mem_necSuf
    {A K : Type} (mulK : K → K → K) (combine : A → A → K)
    (a b a' b' c d : A)
    (hmul : mulK (combine a b) (combine a' b') = combine c d) :
    ∃ u v : A, mulK (combine a b) (combine a' b') = combine u v := by
  exact ⟨c, d, hmul⟩

theorem mul_representation_necSuf
    {A K V : Type} (mulK : K → K → K)
    (value : K → V) (combine : A → A → V) (rep : K → A × A)
    (hUnique : ∀ x : K, ∀ a b : A, value x = combine a b → rep x = (a, b))
    (x y : K) (c d : A)
    (hmul : value (mulK x y) = combine c d) :
    rep (mulK x y) = (c, d) := by
  exact hUnique (mulK x y) c d hmul

end Ising2DLambda.NecSuf.FisherZero
