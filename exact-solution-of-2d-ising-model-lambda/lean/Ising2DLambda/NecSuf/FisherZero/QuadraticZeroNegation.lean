/-
三分律の準備の必要十分版。
台集合は「二係数による表示を持つこと」だけ、表示写像は仕様と一意性だけを要求する。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.FisherZero

theorem zero_mem_necSuf
    {A K : Type} (zeroA : A) (zeroK : K) (combine : A → A → K)
    (hzero : zeroK = combine zeroA zeroA) :
    ∃ a b : A, zeroK = combine a b := by
  exact ⟨zeroA, zeroA, hzero⟩

theorem zero_representation_necSuf
    {A K V : Type} [Zero A]
    (value : K → V) (combine : A → A → V) (rep : K → A × A) (zeroK : K)
    (hSpec : ∀ x : K, value x = combine (rep x).1 (rep x).2)
    (hUnique : ∀ x : K, ∀ a b : A, value x = combine a b → rep x = (a, b))
    (hzero : value zeroK = combine 0 0) (x : K) :
    value x = value zeroK ↔ rep x = (0, 0) := by
  constructor
  · intro hx
    apply hUnique x 0 0
    calc
      value x = value zeroK := hx
      _ = combine 0 0 := hzero
  · intro hrep
    calc
      value x = combine (rep x).1 (rep x).2 := hSpec x
      _ = combine 0 0 := by rw [hrep]
      _ = value zeroK := hzero.symm

theorem neg_mem_necSuf
    {A K : Type} (negA : A → A) (negK : K → K) (combine : A → A → K)
    (a b : A) (x : K) (hx : x = combine a b)
    (hneg : negK x = combine (negA a) (negA b)) :
    ∃ a' b' : A, negK x = combine a' b' := by
  exact ⟨negA a, negA b, hneg⟩

theorem neg_representation_necSuf
    {A K V : Type} (negA : A → A) (negK : K → K) (value : K → V)
    (combine : A → A → V)
    (rep : K → A × A)
    (hUnique : ∀ x : K, ∀ a b : A, value x = combine a b → rep x = (a, b))
    (x : K)
    (hneg : value (negK x) = combine (negA (rep x).1) (negA (rep x).2)) :
    rep (negK x) = (negA (rep x).1, negA (rep x).2) := by
  exact hUnique (negK x) (negA (rep x).1) (negA (rep x).2) hneg

end Ising2DLambda.NecSuf.FisherZero
