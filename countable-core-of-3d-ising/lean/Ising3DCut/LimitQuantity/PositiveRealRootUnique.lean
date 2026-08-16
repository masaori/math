/-
「極限量が有限箱の列だけの関数であること」の Lean 具体版・中段「正の実数乗根の一意性」。

可算側の三歩で $Z_L(q)=Z_L(q')$ が全 $L$ で得られ、かつ $Z_L(q)>0$ である。
実数側で $Z_L(q)^{1/\#V_L}$ を作る段の正当化として、
正の実数 $x$ と正の自然数 $n$ に対し「$y^n=x$ を満たす正の実数 $y$」が唯一つ存在し
それが $x^{1/n}$ であること、したがって $x=x'$ なら $x^{1/n}=x'^{1/n}$ であることを述べる。
ここは ℝ の内部の主張であり、極限は使わない（脱出は `RealLimitOfEqualSequences.lean` の段だけ）。
-/
import Mathlib.Analysis.SpecialFunctions.Pow.Real

namespace Ising3DCut.LimitQuantity

/-- 正の実数 $x$ の正の $n$ 乗根 $x^{1/n}$（$n\ge1$）。 -/
noncomputable def posRoot (x : ℝ) (n : ℕ) : ℝ := x ^ ((1 : ℝ) / n)

/-- 正の $n$ 乗根は正である。 -/
theorem posRoot_pos (x : ℝ) (hx : 0 < x) (n : ℕ) : 0 < posRoot x n :=
  Real.rpow_pos_of_pos hx _

/-- 正の $n$ 乗根の $n$ 乗はもとの数である。 -/
theorem posRoot_pow (x : ℝ) (hx : 0 < x) (n : ℕ) (hn : n ≠ 0) : posRoot x n ^ n = x := by
  unfold posRoot
  rw [← Real.rpow_natCast, ← Real.rpow_mul hx.le]
  have hn' : (n : ℝ) ≠ 0 := Nat.cast_ne_zero.mpr hn
  rw [one_div, inv_mul_cancel₀ hn', Real.rpow_one]

/-- 正の実数乗根の一意性：$y>0$ かつ $y^n=x$（$n\ge1$）なら $y=x^{1/n}$。 -/
theorem eq_posRoot_of_pow_eq (x y : ℝ) (hx : 0 < x) (hy : 0 < y) (n : ℕ) (hn : n ≠ 0)
    (h : y ^ n = x) : y = posRoot x n := by
  have h1 : posRoot x n ^ n = x := posRoot_pow x hx n hn
  have h2 : y ^ n = posRoot x n ^ n := by rw [h, h1]
  exact (pow_left_inj₀ hy.le (posRoot_pos x hx n).le hn).1 h2

/-- 等しい正の実数の正の $n$ 乗根は等しい（$Z_L(q)=Z_L(q')$ から乗根の一致へ）。 -/
theorem posRoot_congr (x x' : ℝ) (h : x = x') (n : ℕ) : posRoot x n = posRoot x' n := by
  rw [h]

end Ising3DCut.LimitQuantity
