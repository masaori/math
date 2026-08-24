/-
「点数乗表示の底の分母の素因子は、有理点の分母の素因子に限られる」の
Lean 必要十分版で使う算術の骨格。

具体版の前三段から素数・有理数・素指数を落とすと、残るのは、有限箱値の
整数値が非負であること、有限箱値が正の自然数倍の底の値に等しいこと、
および正の自然数倍が非負なら底の値も非負であることだけである。
-/
import Mathlib

namespace Ising3DCut.NecSuf

/-- 非負な整数値が、正の自然数倍として表されるなら、その底の整数値も非負である。 -/
theorem base_value_nonnegative_of_positive_multiple
    (value base : ℤ) (N : ℕ) (hvalue : 0 ≤ value) (hN : 0 < N)
    (hrep : value = (N : ℤ) * base) :
    0 ≤ base := by
  have hNpos : (0 : ℤ) < (N : ℤ) := by exact_mod_cast hN
  nlinarith

end Ising3DCut.NecSuf
