/-
「正の根の特定」の必要十分版。
値の表示、正錐への所属、二根の場合分けだけを要求し、体・順序・二次体の構造を要求しない。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.FisherZero

theorem represented_value_mem_necSuf
    {A K : Type} (combine : A → A → K) (a b : A) :
    ∃ a' b' : A, combine a b = combine a' b' := by
  exact ⟨a, b, rfl⟩

theorem representation_of_value_necSuf
    {A K : Type} (combine : A → A → K) (rep : K → A × A)
    (hUnique : ∀ x a b, x = combine a b → rep x = (a, b))
    (a b : A) : rep (combine a b) = (a, b) := by
  exact hUnique (combine a b) a b rfl

theorem positive_of_representation_necSuf
    {A K : Type} (rep : K → A × A) (positive : A × A → Prop)
    (x : K) (a b : A) (hrep : rep x = (a, b)) (hab : positive (a, b)) :
    positive (rep x) := by
  rw [hrep]
  exact hab

theorem not_positive_of_representation_necSuf
    {A K : Type} (rep : K → A × A) (positive : A × A → Prop)
    (x : K) (a b : A) (hrep : rep x = (a, b)) (hab : ¬ positive (a, b)) :
    ¬ positive (rep x) := by
  rw [hrep]
  exact hab

theorem positive_root_unique_necSuf
    {K : Type} (rootPlus rootMinus x : K) (positive : K → Prop)
    (hroots : x = rootPlus ∨ x = rootMinus)
    (hxPositive : positive x) (hminus : ¬ positive rootMinus) :
    x = rootPlus := by
  rcases hroots with hplus | hminusEq
  · exact hplus
  · exfalso
    apply hminus
    rw [← hminusEq]
    exact hxPositive

end Ising2DLambda.NecSuf.FisherZero
