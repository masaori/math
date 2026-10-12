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

/-- `claim_quadratic_negation_mem` の五等号と所属の証人。
表示の仕様、和の逆元則、右乗法の逆元保存、係数写像の逆元保存だけを使う。
零・単位元・結合則・可換則、写像の単射性、表示の一意性、根の平方条件は不要である。
右乗法は一変数写像で足り、値の側に乗法全体の構造を要求しない。 -/
theorem neg_mem_necSuf
    {A K V : Type*} [Neg A] [Neg V] [Add V]
    (hNegAdd : ∀ z w : V, -(z + w) = -z + -w)
    (embed : A → V) (hEmbedNeg : ∀ a : A, embed (-a) = -embed a)
    (rightMul : V → V) (hRightMulNeg : ∀ z : V, rightMul (-z) = -rightMul z)
    (value : K → V) (rep : K → A × A)
    (hSpec : ∀ x : K, value x = embed (rep x).1 + rightMul (embed (rep x).2))
    (x : K) :
    ∃ a b : A, -value x = embed a + rightMul (embed b) := by
  let a : A := (rep x).1
  let b : A := (rep x).2
  refine ⟨-a, -b, ?_⟩
  calc
    -value x = -(embed a + rightMul (embed b)) := congrArg Neg.neg (hSpec x)
    _ = -embed a + (-rightMul (embed b)) := hNegAdd _ _
    _ = -embed a + rightMul (-embed b) :=
      congrArg (-embed a + ·) (hRightMulNeg (embed b)).symm
    _ = embed (-a) + rightMul (-embed b) :=
      congrArg (· + rightMul (-embed b)) (hEmbedNeg a).symm
    _ = embed (-a) + rightMul (embed (-b)) :=
      congrArg (fun z : V => embed (-a) + rightMul z) (hEmbedNeg b).symm

/-- `claim_quadratic_negation_representation` の五等号と表示の一意性。
和・包含・右乗法の逆元保存と表示仕様だけから値の鎖を作る。
負元の値が元の値の逆元であることは負元写像の仕様であり、
係数の逆元表示を仮定しない。有限性・零・乗法全体の構造は不要。 -/
theorem neg_representation_necSuf
    {A K V : Type*} [Neg A] [Neg V] [Add V]
    (hNegAdd : ∀ z w : V, -(z + w) = -z + -w)
    (embed : A → V) (hEmbedNeg : ∀ a : A, embed (-a) = -embed a)
    (rightMul : V → V) (hRightMulNeg : ∀ z : V, rightMul (-z) = -rightMul z)
    (negK : K → K) (value : K → V)
    (hValueNeg : ∀ x : K, value (negK x) = -value x)
    (rep : K → A × A)
    (hSpec : ∀ x : K, value x = embed (rep x).1 + rightMul (embed (rep x).2))
    (hUnique : ∀ x : K, ∀ a b : A,
      value x = embed a + rightMul (embed b) → rep x = (a, b))
    (x : K) :
    rep (negK x) = (-(rep x).1, -(rep x).2) := by
  let a : A := (rep x).1
  let b : A := (rep x).2
  have hneg : -value x = embed (-a) + rightMul (embed (-b)) := by
    calc
      -value x = -(embed a + rightMul (embed b)) := congrArg Neg.neg (hSpec x)
      _ = -embed a + (-rightMul (embed b)) := hNegAdd _ _
      _ = -embed a + rightMul (-embed b) :=
        congrArg (-embed a + ·) (hRightMulNeg (embed b)).symm
      _ = embed (-a) + rightMul (-embed b) :=
        congrArg (· + rightMul (-embed b)) (hEmbedNeg a).symm
      _ = embed (-a) + rightMul (embed (-b)) :=
        congrArg (fun z : V => embed (-a) + rightMul z) (hEmbedNeg b).symm
  calc
    rep (negK x) = (-a, -b) :=
      hUnique (negK x) (-a) (-b) ((hValueNeg x).trans hneg)

end Ising2DLambda.NecSuf.FisherZero
