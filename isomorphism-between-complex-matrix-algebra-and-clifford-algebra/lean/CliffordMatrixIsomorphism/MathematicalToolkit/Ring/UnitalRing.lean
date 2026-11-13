/-
節「環」の具体版。本文の二つの定義を、mathlib の `Ring`・`RingHom` を使わず、
本文の組 (R, +_R, ·_R, 0_R, 1_R) のとおりに structure で書く。

  本文のラベル                 このファイル
  def_unital_ring              UnitalRing
  def_ring_homomorphism        IsRingHomomorphism

必要十分版は置かない。二つの定義はどちらも ℂ を含まず、係数を型の変数に替える余地が無いので、
具体版がそのまま必要十分である。
-/
namespace CliffordMatrixIsomorphism

universe u v

/-- 本文 `def_unital_ring`：単位元をもつ環 (R, +_R, ·_R, 0_R, 1_R)。
加法の逆元は「存在する」とだけ要求し、逆元を返す写像は組に含めない（本文と同じ）。
乗法の交換法則は仮定しない。 -/
structure UnitalRing (R : Type u) where
  add : R → R → R
  mul : R → R → R
  zero : R
  one : R
  /-- 加法の結合法則 -/
  add_assoc : ∀ x y z : R, add (add x y) z = add x (add y z)
  /-- 加法の交換法則 -/
  add_comm : ∀ x y : R, add x y = add y x
  /-- 加法の単位元 -/
  add_zero : ∀ x : R, add x zero = x
  /-- 加法の逆元 -/
  exists_add_inverse : ∀ x : R, ∃ x' : R, add x x' = zero
  /-- 乗法の結合法則 -/
  mul_assoc : ∀ x y z : R, mul (mul x y) z = mul x (mul y z)
  /-- 乗法の単位元（右） -/
  mul_one : ∀ x : R, mul x one = x
  /-- 乗法の単位元（左） -/
  one_mul : ∀ x : R, mul one x = x
  /-- 分配法則（左） -/
  left_distrib : ∀ x y z : R, mul x (add y z) = add (mul x y) (mul x z)
  /-- 分配法則（右） -/
  right_distrib : ∀ x y z : R, mul (add x y) z = add (mul x z) (mul y z)

/-- 本文 `def_ring_homomorphism`：加法・乗法・乗法の単位元を保つ写像。
加法の単位元を保つことは条件に含めない（本文と同じ）。 -/
structure IsRingHomomorphism {R : Type u} {S : Type v} (r : UnitalRing R) (s : UnitalRing S)
    (φ : R → S) : Prop where
  /-- 加法を保つ -/
  map_add : ∀ x y : R, φ (r.add x y) = s.add (φ x) (φ y)
  /-- 乗法を保つ -/
  map_mul : ∀ x y : R, φ (r.mul x y) = s.mul (φ x) (φ y)
  /-- 乗法の単位元を保つ -/
  map_one : φ r.one = s.one

end CliffordMatrixIsomorphism
