/-
「開境界正方形と部分正方形の値の比較（t は 1 以下）」の必要十分版。

格子・配位・分配多項式・実数を外し、二段の分割（第一座標方向・第二座標方向）の
下側・上側の評価、分割で生じた二つの余りが 1 以上であること、余りの一様上界、
掛ける因子が非負であることだけを残す。証明手順は具体版と同じ
（下側: 余りを 1 以上で挿し込み接合の下側を二回。上側: 接合の上側を二回、余りを一様上界で置換）。
必要なのは可換半環と順序（非負元の乗法単調性）だけである。乗法の可換性は
最後の因子の並べ替えにだけ使う。
-/
import Mathlib.Algebra.Order.Ring.Defs

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

/-- 二段の分割による下側・上側の評価。
`p`, `q` は各分割の下側に付く係数（具体版では `t^L`, `t^a`）、
`Bac`, `BcL` は余りの一様上界（具体版では `2^{ac}`, `2^{cL}`）である。 -/
theorem split_twice_bounds_necSuf
    {K : Type*} [CommSemiring K] [PartialOrder K] [IsOrderedRing K]
    {p q Zaa Zac ZaL ZcL ZLL Bac BcL : K}
    (hp : 0 ≤ p) (hq : 0 ≤ q) (hZaa : 0 ≤ Zaa) (hZaL : 0 ≤ ZaL) (hZcL : 0 ≤ ZcL)
    (hBac : 0 ≤ Bac)
    (h1ac : 1 ≤ Zac) (h1cL : 1 ≤ ZcL)
    (hsecond_lo : q * (Zaa * Zac) ≤ ZaL) (hsecond_hi : ZaL ≤ Zaa * Zac)
    (hfirst_lo : p * (ZaL * ZcL) ≤ ZLL) (hfirst_hi : ZLL ≤ ZaL * ZcL)
    (hac : Zac ≤ Bac) (hcL : ZcL ≤ BcL) :
    p * (q * Zaa) ≤ ZLL ∧ ZLL ≤ Bac * BcL * Zaa := by
  constructor
  · calc
      p * (q * Zaa) ≤ p * (q * (Zaa * Zac)) :=
            mul_le_mul_of_nonneg_left
              (mul_le_mul_of_nonneg_left (le_mul_of_one_le_right hZaa h1ac) hq) hp
      _ ≤ p * ZaL := mul_le_mul_of_nonneg_left hsecond_lo hp
      _ ≤ p * (ZaL * ZcL) := mul_le_mul_of_nonneg_left (le_mul_of_one_le_right hZaL h1cL) hp
      _ ≤ ZLL := hfirst_lo
  · calc
      ZLL ≤ ZaL * ZcL := hfirst_hi
      _ ≤ (Zaa * Zac) * ZcL := mul_le_mul_of_nonneg_right hsecond_hi hZcL
      _ ≤ (Zaa * Bac) * ZcL := mul_le_mul_of_nonneg_right (mul_le_mul_of_nonneg_left hac hZaa) hZcL
      _ ≤ (Zaa * Bac) * BcL := mul_le_mul_of_nonneg_left hcL (mul_nonneg hZaa hBac)
      _ = Bac * BcL * Zaa := by rw [mul_comm Zaa Bac, mul_right_comm]

end Ising2DLambda.NecSuf.ThermodynamicLimit
