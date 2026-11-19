/-
# 対称化した和と反対称化した差の加法定理（**必要十分版**）

対応する人手証明のラベル（具体版は
`Ising2D/MathematicalTools/RealSquareRootExponentialAndHyperbolicFunctions/ClaimCoshAdditionAndHalfAngle.lean`）:
`cosh_addition_formula`（具体版 `cosh_add_formula`・`cosh_sub_formula`）と
`sinh_addition_formula`（具体版 `sinh_add_formula`・`sinh_sub_formula`）。

写像 `f : G → K` から `c(z) = (f(z) + f(−z))·⅟2`・`s(z) = (f(z) − f(−z))·⅟2` と書ける `c`・`s` を考える
（具体版は `f := exp`、`c := cosh`、`s := sinh`。`⅟2` は `2` の逆元で、具体版の `/2` に当たる。具体版の `/4` は `·(⅟2·⅟2)` に当たる）。

## 何が効いているか / 効いていないか

| 具体版（`ℝ` の `cosh`・`sinh`） | 必要十分版 | 仮定 |
| --- | --- | --- |
| `cosh_add_formula`（8 段） | `symmetrized_add_formula'`（同じ 8 段） | 引数の側の `−(x + y) = (−x) + (−y)`（`hneg`）、`f(a + b) = f(a)f(b)`（`hf`）、値の側が環で `2` が逆元を持つこと（`[Ring K] [Invertible (2 : K)]`） |
| `sinh_add_formula`（8 段） | `antisymmetrized_add_formula'`（同じ 8 段） | 同上 |
| `cosh_sub_formula`（6 段） | `symmetrized_sub_formula'`（同じ 6 段） | 上に加えて、引数の側の `x − y = x + (−y)`（`hsub`）と符号反転の対合性（`InvolutiveNeg`） |
| `sinh_sub_formula`（6 段） | `antisymmetrized_sub_formula'`（同じ 6 段） | 同上 |

* 複号 `+` の人手の 8 行は「定義」「`real_negation_of_sum_is_sum_of_negations`」「`scalar_exp_product` を 2 箇所へ」
  「分母と分子に 2 を掛ける」「`E_x E_{−y}` と `E_{−x} E_y` を足して引く」「分配則」「分数の和と積」「定義を 4 箇所へ」で、
  必要十分版の 8 段と同じ並びである。`cosh`・`sinh` の定義は仮定 `hc`・`hs` として置く。2 段目は仮定 `hneg`、3 段目は仮定 `hf` である。
* 複号 `−` の人手の 6 行は「`def_real_difference`」「複号 `+` の場合を `−y` に当てはめる」「`cosh_is_even`」「`sinh_is_odd`」
  「`real_times_negation_is_negation_of_product`」「`def_real_difference` を右辺から左辺へ」で、必要十分版の 6 段と同じ並びである。
  1 段目は仮定 `hsub`、5・6 段目は環の `mul_neg`・`sub_eq_add_neg` である。3・4 段目は、偶奇の必要十分版 `symmetrized_sum_is_even'`
  （`SymmetrizedSumIsEven.lean`）・`antisymmetrized_difference_is_odd'`（`AntisymmetrizedDifferenceIsOdd.lean`）を
  同じ `f` と `d := (· * ⅟2)` に当てはめて引く（具体版が `cosh_is_even`・`sinh_is_odd` を引くのと同じ）。
* `exp` の性質のうち効いているのは指数法則 `f(a + b) = f(a)f(b)` だけである。`f(0) = 1`・正値性・連続性・級数による定義は効いていない。
* 引数の側 `G` の加法の結合律・交換律・零・逆元は効いていない。効くのは和の符号反転が符号反転の和であること（`hneg`）だけで、
  複号 `−` では差が符号反転の和であること（`hsub`）と `−(−y) = y`（偶奇の必要十分版が使う）が加わる。
* 値の側で効くのは環の演算と、`2` が逆元 `⅟2` を持つことだけである。4 段目「分母と分子に 2 を掛ける」は約分
  `(2w)·⅟2 = (w·2)·⅟2 = w`（`2w = w + w = w·2` なので乗法の可換則は使わない）、7 段目「分数の和と積」は
  `⅟2` が任意の元と交換すること（`2` が任意の元と交換することから従う。`Commute.invOf_left`）を使う。
  5・6 段（足して引く・分配則）は非可換環の計算（`noncomm_ring`）である。
  2 以外の元の逆元（体・除法環であること）、乗法の可換則、順序は効いていない。
  `2` の可逆性は外せない（外すと具体版の `/2` に当たる元が無く、`c`・`s` の定義を書けない）。
-/

import Ising2D.NecSuf.SymmetrizedSumIsEven
import Ising2D.NecSuf.AntisymmetrizedDifferenceIsOdd
import Mathlib.Algebra.Group.Invertible.Basic
import Mathlib.Algebra.Ring.Invertible
import Mathlib.Algebra.Ring.Commute
import Mathlib.Tactic.NoncommRing
import Mathlib.Tactic.NormNum

namespace Ising2D.NecSuf

/-- 4 段目「分母と分子に 2 を掛ける」: `w·⅟2 = (2w)·(⅟2·⅟2)`。`2w = w·2` と約分 `(w·2)·⅟2 = w` だけを使う。 -/
theorem mul_invOf_two_eq_two_mul_mul_invOf_two_sq' {K : Type*} [Ring K] [Invertible (2 : K)] (w : K) :
    w * ⅟2 = (2 * w) * (⅟2 * ⅟2) := by
  rw [two_mul, ← mul_two, ← mul_assoc, mul_invOf_cancel_right]

/-- 7 段目「分数の和と積」: `(ab + pq)·(⅟2·⅟2) = (a·⅟2)(b·⅟2) + (p·⅟2)(q·⅟2)`。`⅟2` が `b`・`q` と交換することと分配則を使う。 -/
theorem add_mul_invOf_two_sq_eq' {K : Type*} [Ring K] [Invertible (2 : K)] (a b p q : K) :
    (a * b + p * q) * (⅟2 * ⅟2) = a * ⅟2 * (b * ⅟2) + p * ⅟2 * (q * ⅟2) := by
  have hb : Commute (⅟(2 : K)) b := (Commute.ofNat_left 2 b).invOf_left
  have hq : Commute (⅟(2 : K)) q := (Commute.ofNat_left 2 q).invOf_left
  rw [add_mul]
  congr 1
  · simp only [mul_assoc]; rw [← mul_assoc ⅟2 b, hb.eq, mul_assoc b]
  · simp only [mul_assoc]; rw [← mul_assoc ⅟2 q, hq.eq, mul_assoc q]

/-- **`c(x + y) = c(x)c(y) + s(x)s(y)`**（具体版 `cosh_add_formula`）。
`c z = (f z + f(−z))·⅟2`・`s z = (f z − f(−z))·⅟2` と書け、`f` が和を積へ移すとき。 -/
theorem symmetrized_add_formula' {G K : Type*} [Add G] [Neg G] [Ring K] [Invertible (2 : K)]
    (hneg : ∀ x y : G, -(x + y) = (-x) + (-y))
    (f : G → K) (hf : ∀ a b : G, f (a + b) = f a * f b)
    (c s : G → K) (hc : ∀ z, c z = (f z + f (-z)) * ⅟2) (hs : ∀ z, s z = (f z - f (-z)) * ⅟2)
    (x y : G) :
    c (x + y) = c x * c y + s x * s y :=
  calc c (x + y)
      = (f (x + y) + f (-(x + y))) * ⅟2 := hc (x + y)
          -- `c` の定義（具体版の `cosh` の定義）
    _ = (f (x + y) + f ((-x) + (-y))) * ⅟2 := by rw [hneg x y]
          -- 和の符号反転は符号反転の和（具体版の `real_negation_of_sum_is_sum_of_negations`）
    _ = (f x * f y + f (-x) * f (-y)) * ⅟2 := by rw [hf x y, hf (-x) (-y)]
          -- `f(a+b) = f(a)f(b)` を 2 箇所へ（具体版の `scalar_exp_product`）
    _ = (2 * (f x * f y) + 2 * (f (-x) * f (-y))) * (⅟2 * ⅟2) := by
          rw [← mul_add]; exact mul_invOf_two_eq_two_mul_mul_invOf_two_sq' _
          -- 分母と分子に `2` を掛ける
    _ = ((f x * f y + f x * f (-y) + f (-x) * f y + f (-x) * f (-y))
          + (f x * f y - f x * f (-y) - f (-x) * f y + f (-x) * f (-y))) * (⅟2 * ⅟2) := by
          congr 1; noncomm_ring
          -- `f(x)f(−y)` と `f(−x)f(y)` を足して引く
    _ = ((f x + f (-x)) * (f y + f (-y)) + (f x - f (-x)) * (f y - f (-y))) * (⅟2 * ⅟2) := by
          congr 1; noncomm_ring
          -- 分配則
    _ = (f x + f (-x)) * ⅟2 * ((f y + f (-y)) * ⅟2) + (f x - f (-x)) * ⅟2 * ((f y - f (-y)) * ⅟2) :=
          add_mul_invOf_two_sq_eq' _ _ _ _
          -- 分数の和と積
    _ = c x * c y + s x * s y := by rw [← hc x, ← hc y, ← hs x, ← hs y]
          -- `c`, `s` の定義を 4 箇所へ

/-- **`s(x + y) = s(x)c(y) + c(x)s(y)`**（具体版 `sinh_add_formula`）。仮定は `symmetrized_add_formula'` と同じ。 -/
theorem antisymmetrized_add_formula' {G K : Type*} [Add G] [Neg G] [Ring K] [Invertible (2 : K)]
    (hneg : ∀ x y : G, -(x + y) = (-x) + (-y))
    (f : G → K) (hf : ∀ a b : G, f (a + b) = f a * f b)
    (c s : G → K) (hc : ∀ z, c z = (f z + f (-z)) * ⅟2) (hs : ∀ z, s z = (f z - f (-z)) * ⅟2)
    (x y : G) :
    s (x + y) = s x * c y + c x * s y :=
  calc s (x + y)
      = (f (x + y) - f (-(x + y))) * ⅟2 := hs (x + y)
          -- `s` の定義（具体版の `sinh` の定義）
    _ = (f (x + y) - f ((-x) + (-y))) * ⅟2 := by rw [hneg x y]
          -- 和の符号反転は符号反転の和（具体版の `real_negation_of_sum_is_sum_of_negations`）
    _ = (f x * f y - f (-x) * f (-y)) * ⅟2 := by rw [hf x y, hf (-x) (-y)]
          -- `f(a+b) = f(a)f(b)` を 2 箇所へ（具体版の `scalar_exp_product`）
    _ = (2 * (f x * f y) - 2 * (f (-x) * f (-y))) * (⅟2 * ⅟2) := by
          rw [← mul_sub]; exact mul_invOf_two_eq_two_mul_mul_invOf_two_sq' _
          -- 分母と分子に `2` を掛ける
    _ = ((f x * f y + f x * f (-y) - f (-x) * f y - f (-x) * f (-y))
          + (f x * f y - f x * f (-y) + f (-x) * f y - f (-x) * f (-y))) * (⅟2 * ⅟2) := by
          congr 1; noncomm_ring
          -- `f(x)f(−y)` と `f(−x)f(y)` を足して引く
    _ = ((f x - f (-x)) * (f y + f (-y)) + (f x + f (-x)) * (f y - f (-y))) * (⅟2 * ⅟2) := by
          congr 1; noncomm_ring
          -- 分配則
    _ = (f x - f (-x)) * ⅟2 * ((f y + f (-y)) * ⅟2) + (f x + f (-x)) * ⅟2 * ((f y - f (-y)) * ⅟2) :=
          add_mul_invOf_two_sq_eq' _ _ _ _
          -- 分数の和と積
    _ = s x * c y + c x * s y := by rw [← hc x, ← hc y, ← hs x, ← hs y]
          -- `c`, `s` の定義を 4 箇所へ

/-- **`c(x − y) = c(x)c(y) − s(x)s(y)`**（具体版 `cosh_sub_formula`）。 -/
theorem symmetrized_sub_formula' {G K : Type*} [Add G] [Sub G] [InvolutiveNeg G] [Ring K] [Invertible (2 : K)]
    (hneg : ∀ x y : G, -(x + y) = (-x) + (-y)) (hsub : ∀ x y : G, x - y = x + (-y))
    (f : G → K) (hf : ∀ a b : G, f (a + b) = f a * f b)
    (c s : G → K) (hc : ∀ z, c z = (f z + f (-z)) * ⅟2) (hs : ∀ z, s z = (f z - f (-z)) * ⅟2)
    (x y : G) :
    c (x - y) = c x * c y - s x * s y :=
  calc c (x - y)
      = c (x + (-y)) := by rw [hsub x y]
          -- `x − y = x + (−y)`（具体版の `def_real_difference`）
    _ = c x * c (-y) + s x * s (-y) := symmetrized_add_formula' hneg f hf c s hc hs x (-y)
          -- 複号が `+` の場合を `−y` に当てはめる
    _ = c x * c y + s x * s (-y) := by
          rw [symmetrized_sum_is_even' f (fun r : K => r * ⅟2) c hc y]
          -- `c` は偶（具体版の `cosh_is_even`）
    _ = c x * c y + s x * (-s y) := by
          rw [antisymmetrized_difference_is_odd' (fun a b : K => (neg_sub b a).symm) f (fun r : K => r * ⅟2)
              (fun r => neg_mul r ⅟2) s hs y]
          -- `s` は奇（具体版の `sinh_is_odd`）
    _ = c x * c y + (-(s x * s y)) := by rw [mul_neg (s x) (s y)]
          -- `a·(−b) = −(ab)`（具体版の `real_times_negation_is_negation_of_product`）
    _ = c x * c y - s x * s y := by rw [← sub_eq_add_neg (c x * c y) (s x * s y)]
          -- `p + (−q) = p − q`（具体版の `def_real_difference` を右辺から左辺へ）

/-- **`s(x − y) = s(x)c(y) − c(x)s(y)`**（具体版 `sinh_sub_formula`）。仮定は `symmetrized_sub_formula'` と同じ。 -/
theorem antisymmetrized_sub_formula' {G K : Type*} [Add G] [Sub G] [InvolutiveNeg G] [Ring K] [Invertible (2 : K)]
    (hneg : ∀ x y : G, -(x + y) = (-x) + (-y)) (hsub : ∀ x y : G, x - y = x + (-y))
    (f : G → K) (hf : ∀ a b : G, f (a + b) = f a * f b)
    (c s : G → K) (hc : ∀ z, c z = (f z + f (-z)) * ⅟2) (hs : ∀ z, s z = (f z - f (-z)) * ⅟2)
    (x y : G) :
    s (x - y) = s x * c y - c x * s y :=
  calc s (x - y)
      = s (x + (-y)) := by rw [hsub x y]
          -- `x − y = x + (−y)`（具体版の `def_real_difference`）
    _ = s x * c (-y) + c x * s (-y) := antisymmetrized_add_formula' hneg f hf c s hc hs x (-y)
          -- 複号が `+` の場合を `−y` に当てはめる
    _ = s x * c y + c x * s (-y) := by
          rw [symmetrized_sum_is_even' f (fun r : K => r * ⅟2) c hc y]
          -- `c` は偶（具体版の `cosh_is_even`）
    _ = s x * c y + c x * (-s y) := by
          rw [antisymmetrized_difference_is_odd' (fun a b : K => (neg_sub b a).symm) f (fun r : K => r * ⅟2)
              (fun r => neg_mul r ⅟2) s hs y]
          -- `s` は奇（具体版の `sinh_is_odd`）
    _ = s x * c y + (-(c x * s y)) := by rw [mul_neg (c x) (s y)]
          -- `a·(−b) = −(ab)`（具体版の `real_times_negation_is_negation_of_product`）
    _ = s x * c y - c x * s y := by rw [← sub_eq_add_neg (s x * c y) (c x * s y)]
          -- `p + (−q) = p − q`（具体版の `def_real_difference` を右辺から左辺へ）

end Ising2D.NecSuf
