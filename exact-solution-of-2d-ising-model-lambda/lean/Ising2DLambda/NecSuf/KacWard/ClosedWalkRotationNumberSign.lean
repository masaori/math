/-
閉歩道の循環総回転数を 4 で割った回転数へ移し、回転位相を符号へ落とす計算の必要十分版。
使うのは整数指数の積の法則と `z ^ 4 = -1` だけである。
-/
import Mathlib.Algebra.Field.Basic

namespace Ising2DLambda.NecSuf.KacWard

theorem zpow_four_mul_eq_neg_one_zpow_necSuf {K : Type*} [Field K]
    {z : K} (hz4 : z ^ 4 = -1) (r : ℤ) :
    z ^ ((4 : ℤ) * r) = (-1 : K) ^ r := by
  have hz4z : z ^ (4 : ℤ) = -1 := by
    change z ^ ((4 : ℕ) : ℤ) = -1
    rw [zpow_natCast, hz4]
  rw [zpow_mul, hz4z]

end Ising2DLambda.NecSuf.KacWard
