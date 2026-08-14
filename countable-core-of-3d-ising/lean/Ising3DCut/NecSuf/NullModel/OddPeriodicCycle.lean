/-
「奇数周期ではすべての周期辺を破る配位は無い」の必要十分版。

具体版の積の鎖で使う性質だけを残す。

  使っている性質                         なぜ削れないか
  周期の長さ `L` が奇数                  `(-1)^L = -1` とするため。
  各値が整数 `+1` または `-1`            異なる隣接値の積を `-1` とするため。
  次の添字が `finRotate L` で与えられる   第二の積を第一の積へ並べ替えるため。

証明は人手証明と同じく、各隣接対の積を全て掛け、一方では `(-1)^L`、
他方では同じ整数積の二乗になることから矛盾を得る。

住処: `Fin`、整数、有限積のみ。ℝ / ℂ は現れない。
-/
import Ising3DCut.NecSuf.NullModel.PeriodicConstantUnbroken
import Mathlib.Logic.Equiv.Fin.Rotate
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Algebra.Ring.Parity
import Mathlib.Tactic

namespace Ising3DCut.NecSuf.NullModel

open scoped BigOperators

/-- `+1` または `-1` の異なる二整数の積は `-1` である。 -/
lemma mul_eq_neg_one_of_mem_two_and_ne {u v : ℤ}
    (hu : u = 1 ∨ u = -1) (hv : v = 1 ∨ v = -1) (hne : u ≠ v) :
    u * v = -1 := by
  rcases hu with rfl | rfl <;> rcases hv with rfl | rfl
  · exact (hne rfl).elim
  · norm_num
  · norm_num
  · exact (hne rfl).elim

/-- 奇数個の `+1` / `-1` を輪に並べると、隣り合う値をすべて異ならせることはできない。 -/
theorem no_odd_cycle_all_opposite {L : ℕ} (hodd : Odd L)
    (value : Fin L → ℤ) (hvalue : ∀ k, value k = 1 ∨ value k = -1)
    (hopposite : ∀ k, value k ≠ value (finRotate L k)) : False := by
  let p : ℤ := ∏ k, value k
  have hpair : ∀ k, value k * value (finRotate L k) = (-1 : ℤ) := by
    intro k
    exact mul_eq_neg_one_of_mem_two_and_ne (hvalue k) (hvalue (finRotate L k)) (hopposite k)
  have hproducts : (-1 : ℤ) ^ L = p ^ 2 := by
    calc
      (-1 : ℤ) ^ L = ∏ _k : Fin L, (-1 : ℤ) := by simp
      _ = ∏ k : Fin L, (value k * value (finRotate L k)) := by
        apply Finset.prod_congr rfl
        intro k _
        exact (hpair k).symm
      _ = (∏ k : Fin L, value k) * (∏ k : Fin L, value (finRotate L k)) := by
        exact Finset.prod_mul_distrib
      _ = (∏ k : Fin L, value k) * (∏ k : Fin L, value k) := by
        rw [Fintype.prod_equiv (finRotate L) (fun k => value (finRotate L k)) value (fun _ => rfl)]
      _ = p ^ 2 := by simp [p, pow_two]
  rw [hodd.neg_one_pow] at hproducts
  nlinarith [sq_nonneg p]

end Ising3DCut.NecSuf.NullModel
