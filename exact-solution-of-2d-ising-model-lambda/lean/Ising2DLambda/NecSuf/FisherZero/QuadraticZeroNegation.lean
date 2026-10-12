/-
三分律の準備の必要十分版。
台集合は「二係数による表示を持つこと」だけ、表示写像は仕様と一意性だけを要求する。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.FisherZero

/-- `claim_quadratic_zero_mem` の四等号と所属の証人。
最初の行には零同士の和、次の行には固定した根への右乗法の零保存、
残る二行には係数写像の零保存だけが必要である。
加法の結合則・可換則、係数の演算、写像の単射性、根の平方条件は使わない。 -/
theorem zero_mem_necSuf
    {A K : Type*} [Zero A] [Zero K] [Add K]
    (hZeroAddZero : (0 : K) + 0 = 0)
    (embed : A → K) (hEmbedZero : embed 0 = 0)
    (rightMul : K → K) (hRightMulZero : rightMul 0 = 0) :
    ∃ a b : A, (0 : K) = embed a + rightMul (embed b) := by
  refine ⟨0, 0, ?_⟩
  calc
    (0 : K) = 0 + 0 := hZeroAddZero.symm
    _ = 0 + rightMul 0 := congrArg ((0 : K) + ·) hRightMulZero.symm
    _ = embed 0 + rightMul 0 :=
      congrArg (· + rightMul 0) hEmbedZero.symm
    _ = embed 0 + rightMul (embed 0) :=
      congrArg (fun z : K => embed 0 + rightMul z) hEmbedZero.symm

/-- `claim_quadratic_zero_representation` の十四等号。
表示の仕様と係数表示の一意性に加え、零同士の和、係数写像の零保存、
固定した根への右乗法の零保存だけを使う。加法の結合則・可換則、係数の演算、
乗法の全体構造は使わず、根の平方条件も既証の一意性の側だけで必要である。 -/
theorem zero_representation_necSuf
    {A K V : Type*} [Zero A] [Zero V] [Add V]
    (hZeroAddZero : (0 : V) + 0 = 0)
    (embed : A → V) (hEmbedZero : embed 0 = 0)
    (rightMul : V → V) (hRightMulZero : rightMul 0 = 0)
    (value : K → V) (rep : K → A × A)
    (hSpec : ∀ x : K, value x = embed (rep x).1 + rightMul (embed (rep x).2))
    (hUnique : ∀ a b a' b' : A,
      embed a + rightMul (embed b) = embed a' + rightMul (embed b') →
        a = a' ∧ b = b')
    (x : K) :
    value x = 0 ↔ rep x = (0, 0) := by
  let a : A := (rep x).1
  let b : A := (rep x).2
  constructor
  · intro hx
    have hvalue : embed a + rightMul (embed b) = embed 0 + rightMul (embed 0) := by
      calc
        embed a + rightMul (embed b) = value x := (hSpec x).symm
        _ = 0 := hx
        _ = 0 + 0 := hZeroAddZero.symm
        _ = 0 + rightMul 0 := congrArg ((0 : V) + ·) hRightMulZero.symm
        _ = embed 0 + rightMul 0 := congrArg (· + rightMul 0) hEmbedZero.symm
        _ = embed 0 + rightMul (embed 0) :=
          congrArg (fun z : V => embed 0 + rightMul z) hEmbedZero.symm
    have hcoeff := hUnique a b 0 0 hvalue
    calc
      rep x = (a, b) := rfl
      _ = (0, 0) := Prod.ext hcoeff.1 hcoeff.2
  · intro hrep
    calc
      value x = embed a + rightMul (embed b) := hSpec x
      _ = embed 0 + rightMul (embed 0) := by
        dsimp only [a, b]
        rw [hrep]
      _ = 0 + rightMul (embed 0) := congrArg (· + rightMul (embed 0)) hEmbedZero
      _ = 0 + rightMul 0 := congrArg (fun z : V => 0 + rightMul z) hEmbedZero
      _ = 0 + 0 := congrArg ((0 : V) + ·) hRightMulZero
      _ = 0 := hZeroAddZero

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
