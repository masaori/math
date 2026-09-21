/-
「閉包の周期数の一般化」の必要十分版。

周期数を一から任意の正の自然数へ替えるときに新しく要る事実は、非零な
一周期並進の正の自然数倍が非零であることだけである。閉包の長さの表示も
同じ自然数の分配則から得る。
-/
import Mathlib.Algebra.Module.Torsion.Free

namespace Ising2DLambda.NecSuf.KacWard

/-- 加法的ねじれのない群では、非零な周期の正の自然数倍による並進は点を動かす。 -/
theorem positive_period_multiple_moves_point_necSuf
    {G : Type*} [AddCommGroup G] [IsAddTorsionFree G]
    (period point : G) (c : ℕ) (hperiod : period ≠ 0) (hc : 1 ≤ c) :
    point + c • period ≠ point := by
  have hc0 : c ≠ 0 := Nat.ne_of_gt hc
  have hmultiple : c • period ≠ 0 := by
    simpa using (nsmul_right_injective hc0).ne hperiod
  intro heq
  apply hmultiple
  apply add_left_cancel (a := point)
  simpa using heq

/-- 四部分の長さは、接続路二本と周期持ち上げ二本の長さの和になる。 -/
theorem periodic_closure_length_necSuf (h m c : ℕ) :
    2 * h + 2 * (c * m) = h + c * m + h + c * m := by
  omega

end Ising2DLambda.NecSuf.KacWard
