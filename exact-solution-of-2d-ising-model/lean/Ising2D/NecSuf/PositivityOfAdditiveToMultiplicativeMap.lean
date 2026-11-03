/-
# 和を積へ送り 0 を 1 へ送る写像は、半分を持つ元で正（必要十分版）

具体版: `Ising2D/MathematicalTools/MatrixExponentialAndCommutators/ClaimRealExpPositive.lean`
（人手 `real_exp_positive`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/MatrixExponentialAndCommutators/ClaimRealExpPositiveFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `real_exp_mul_exp_neg`（`scalar_exp_product` → 加法の逆元 → `scalar_exp_zero`） | `mul_map_neg_eq_one`（`f(a+b) = f(a)f(b)` → 加法の逆元 → `f(0) = 1`） |
| `real_exp_ne_zero`（上の鎖 → 仮定 → `0·y = 0`、`1 ≠ 0` に反する） | `map_ne_zero` |
| `real_exp_nonneg`（`x/2 + x/2 = x` → `scalar_exp_product` → 冪の定義 → 平方は非負） | `map_nonneg`（`y + y = x` → `f(a+b) = f(a)f(b)` → 冪の定義 → 平方は非負） |
| `real_exp_positive` | `map_pos` |

## 何が効いているか / 効いていないか

- 写像について効くのは、和を積へ送ること `f(a+b) = f(a)f(b)` と `f(0) = 1` の 2 つだけである。
  `exp` が級数（行列の exp の成分）で定義されていること、連続であること、極限は効いていない。
  `f(0) = 1`（`hzero`）は外すと通らない: 恒等的に `0` の写像は和を積へ送るが `f(x) > 0` を満たさない。
- 定義域について効くのは、加法の逆元 `x + (-x) = 0`（Step 1）と、`x` が `y + y` の形に書けること（Step 2 の `x/2`）だけである。
  後者は仮定 `hhalf` として残した。外すと通らない: `ℤ` 上の `f(n) = (-1)^n` は和を積へ送り `f(0) = 1` だが `f(1) = -1 < 0` で、
  `1` は `ℤ` の中で `y + y` の形に書けない。加法の可換則は効いていない（`AddGroup`）。
  定義域が ℝ であること、割り算ができること（体であること）は効いていない。
- 値域について効くのは、`0·y = 0` と `1 ≠ 0`（Step 1）、平方が非負であること（Step 2）、`≤` と `≠` から `<`（結び）である。
  補題ごとに型クラスを分けた。`f(x)f(-x) = 1` は値域の積と `1` だけ、`f(x) ≠ 0` はそれに `0·y = 0`（`MulZeroOneClass`）と
  `1 ≠ 0`（`Nontrivial`）を足したものだけを使う。`Nontrivial` は外すと通らない: 零環では `0 = 1` なので、恒等的に `0` の写像が
  `hadd`・`hzero` を満たし、`f(x) ≠ 0` が成り立たない。平方の非負（`sq_nonneg`）は全順序を使うので、`f(x) ≥ 0`・`f(x) > 0` の値域は
  全順序環 `[Ring R] [LinearOrder R] [IsStrictOrderedRing R]` にした。`Ring` を `Semiring` に弱めると、
  `a ≤ b` から `b = a + c` を取り出す性質（`ExistsAddOfLE`）が無くなり `sq_nonneg` が通らない。`f(x) ≥ 0` の定義域は加法だけを使う（逆元は効かない）。
  値域の乗法の可換則、値域が ℝ であること、完備性は効いていない。
-/
import Mathlib.Algebra.Order.Ring.Defs

namespace Ising2D.NecSuf

/-- **`f(x)f(-x) = 1`**（具体版 `real_exp_mul_exp_neg`）。定義域は加法の逆元を持つ `AddGroup`、値域は積と `1` だけを使う。 -/
theorem mul_map_neg_eq_one {G R : Type*} [AddGroup G] [Mul R] [One R]
    (f : G → R) (hadd : ∀ a b, f (a + b) = f a * f b) (hzero : f 0 = 1)
    (x : G) : f x * f (-x) = 1 :=
  calc f x * f (-x)
      = f (x + -x) := (hadd x (-x)).symm      -- 和を積へ送る
    _ = f 0 := by rw [add_neg_cancel]          -- 加法の逆元
    _ = 1 := hzero                             -- `f(0) = 1`

/-- **`f(x) ≠ 0`**（具体版 `real_exp_ne_zero`）。値域は `0·y = 0` を持つ `MulZeroOneClass` で、`1 ≠ 0`（`Nontrivial`）。 -/
theorem map_ne_zero {G R : Type*} [AddGroup G] [MulZeroOneClass R] [Nontrivial R]
    (f : G → R) (hadd : ∀ a b, f (a + b) = f a * f b) (hzero : f 0 = 1)
    (x : G) : f x ≠ 0 := by
  intro h
  have h10 : (1 : R) = 0 :=
    calc (1 : R)
        = f x * f (-x) := (mul_map_neg_eq_one f hadd hzero x).symm   -- 上の鎖
      _ = 0 * f (-x) := by rw [h]                                     -- 仮定 `f(x) = 0`
      _ = 0 := zero_mul _                                             -- `0·y = 0`
  exact one_ne_zero h10

/-- **`f(x) ≥ 0`**（具体版 `real_exp_nonneg`）。`x = y + y` と書ける `x` について。
定義域は加法だけを使う。値域は平方が非負になる全順序環。 -/
theorem map_nonneg {G R : Type*} [Add G] [Ring R] [LinearOrder R] [IsStrictOrderedRing R]
    (f : G → R) (hadd : ∀ a b, f (a + b) = f a * f b)
    (x y : G) (hy : y + y = x) : f x ≥ 0 :=
  calc f x
      = f (y + y) := by rw [hy]                -- `y + y = x`
    _ = f y * f y := hadd y y                  -- 和を積へ送る
    _ = (f y) ^ 2 := (sq _).symm               -- 冪の定義
    _ ≥ 0 := sq_nonneg _                       -- 平方は非負

/-- **`f(x) > 0`**（具体版 `real_exp_positive`）。どの元も `y + y` の形に書ける定義域について。 -/
theorem map_pos {G R : Type*} [AddGroup G] [Ring R] [LinearOrder R] [IsStrictOrderedRing R]
    (f : G → R) (hadd : ∀ a b, f (a + b) = f a * f b) (hzero : f 0 = 1)
    (hhalf : ∀ x : G, ∃ y : G, y + y = x) (x : G) : f x > 0 := by
  obtain ⟨y, hy⟩ := hhalf x
  exact lt_of_le_of_ne (map_nonneg f hadd x y hy) (map_ne_zero f hadd hzero x).symm

end Ising2D.NecSuf
