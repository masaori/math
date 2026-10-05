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

/-- 表示の仕様、零との等式、零の表示、一意性の順で具体版と同じ鎖をたどる。
具体版の零の四則は `hzero` にまとめ、既存の一意性の入力形式へ戻す段を明示する。 -/
theorem zero_representation_necSuf
    {A K V : Type} [Zero A]
    (value : K → V) (combine : A → A → V) (rep : K → A × A) (zeroK : K)
    (hSpec : ∀ x : K, value x = combine (rep x).1 (rep x).2)
    (hUnique : ∀ x : K, ∀ a b : A, value x = combine a b → rep x = (a, b))
    (hzero : value zeroK = combine 0 0) (x : K) :
    value x = value zeroK ↔ rep x = (0, 0) := by
  let a : A := (rep x).1
  let b : A := (rep x).2
  constructor
  · intro hx
    have hcombine : combine a b = combine 0 0 := by
      calc
        combine a b = value x := (hSpec x).symm
        _ = value zeroK := hx
        _ = combine 0 0 := hzero
    have hvalue : value x = combine 0 0 := by
      calc
        value x = combine a b := hSpec x
        _ = combine 0 0 := hcombine
    calc
      rep x = (a, b) := rfl
      _ = (0, 0) := hUnique x 0 0 hvalue
  · intro hrep
    calc
      value x = combine a b := hSpec x
      _ = combine 0 0 := by
        dsimp only [a, b]
        rw [hrep]
      _ = value zeroK := hzero.symm

theorem neg_mem_necSuf
    {A K : Type} (negA : A → A) (negK : K → K) (combine : A → A → K)
    (a b : A) (x : K)
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
