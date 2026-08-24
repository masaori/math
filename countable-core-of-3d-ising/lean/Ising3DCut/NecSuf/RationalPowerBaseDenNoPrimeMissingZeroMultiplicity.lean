/-
「点数乗表示の底の既約分母は破れ数ゼロの配位数を割らない素数では割り切れない」の
Lean 必要十分版で使う算術の骨格。

具体版から有限箱、分配多項式、合同式、素因子分解を落とすと、残るのは同じ二つの
自然数 `ev`, `eb` が隣接する二つの箱に対応する釣り合い式を満たし、かつ `eb` が正で
あるという三仮定の不両立である。係数 3 は正であることしか使わないので、正の自然数
`c` まで一般化する。
-/
import Mathlib

namespace Ising3DCut.NecSuf

/-- 隣接する二つの釣り合い式は、右辺の共通指数が正であることと両立しない。 -/
theorem false_of_positive_adjacent_balance
    (K c ev eb : ℕ) (hc : 0 < c) (heb : 0 < eb)
    (hL : (K + 1) * ev = c * K * eb)
    (hL1 : (K + 2) * ev = c * (K + 1) * eb) :
    False := by
  have h1 : (K + 2) * ((K + 1) * ev) = (K + 2) * (c * K * eb) := by rw [hL]
  have h2 : (K + 1) * ((K + 2) * ev) = (K + 1) * (c * (K + 1) * eb) := by rw [hL1]
  have hcross : (K + 2) * (c * K * eb) = (K + 1) * (c * (K + 1) * eb) := by
    rw [← h1, ← h2]
    ring
  have hzero : c * eb = 0 := by
    have hA : c * (K * K + 2 * K) * eb = c * (K * K + 2 * K + 1) * eb := by
      ring_nf
      ring_nf at hcross
      linarith
    have hR : c * (K * K + 2 * K + 1) * eb =
        c * (K * K + 2 * K) * eb + c * eb := by ring
    rw [hR] at hA
    omega
  exact (Nat.mul_pos hc heb).ne' hzero

end Ising3DCut.NecSuf
