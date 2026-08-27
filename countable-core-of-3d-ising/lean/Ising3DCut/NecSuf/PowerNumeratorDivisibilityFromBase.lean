/-
「有限箱の量が末尾で一定となる正の有理点は 1 に限られる」の最後の接続で使う
整除の持ち上げについて、必要十分な抽象度で述べる。

具体版 `Ising3DCut.LimitQuantity.power_numerator_divisibility_of_base_divisibility` は
有理数の分子・自然数の引き算・係数 2・指数 `L₀ ^ 3` を伴うが、
そこで実際に効いているのは可換環における `x - y ∣ x ^ n - y ^ n` だけである。
有理点も箱も 2 倍も現れない形へ移す。
-/
import Mathlib

namespace Ising3DCut.NecSuf

/-- 底の差についての整除を冪の差へ持ち上げる。
仮定は可換環であることだけで、係数 `k`・指数 `n`・両辺 `x, y` は任意。 -/
theorem dvd_mul_pow_sub_pow_of_dvd_mul_sub
    {R : Type*} [CommRing R] {a k x y : R} (n : ℕ)
    (h : a ∣ k * (x - y)) :
    a ∣ k * (x ^ n - y ^ n) := by
  obtain ⟨t, ht⟩ := sub_dvd_pow_sub_pow x y n
  rw [ht, ← mul_assoc]
  exact h.mul_right t

end Ising3DCut.NecSuf
