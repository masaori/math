/-
「三つの等差項が正負 4 に収まるなら公差は零である」
（`claim_three_term_pm_four_difference_zero`）の具体版。
本文と同じく隣接二項の差を列挙し、公差 8 と -8 を各二場合で除く。
住処は ℤ。実数・順序極限は使わない。
-/
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

theorem threeTermPmFour_difference_zero (a b : ℤ)
    (hfirst : a + b = 4 ∨ a + b = -4)
    (hsecond : a + 2 * b = 4 ∨ a + 2 * b = -4)
    (hthird : a + 3 * b = 4 ∨ a + 3 * b = -4) :
    b = 0 ∧ a + b = a + 2 * b ∧ a + 2 * b = a + 3 * b := by
  -- 本文の差の全列挙。
  have hdifference : b = (a + 2 * b) - (a + b) := by ring
  have hcandidates : b = 0 ∨ b = 8 ∨ b = -8 := by
    rcases hfirst with hfirst | hfirst <;>
      rcases hsecond with hsecond | hsecond
    · left
      simpa [hfirst, hsecond] using hdifference
    · right; right
      simpa [hfirst, hsecond] using hdifference
    · right; left
      simpa [hfirst, hsecond] using hdifference
    · left
      simpa [hfirst, hsecond] using hdifference
  have hzero : b = 0 := by
    rcases hcandidates with hzero | hpositive | hnegative
    · exact hzero
    · -- 公差 8: 第一項が 4 なら第二項、-4 なら第三項が 12 になる。
      rcases hfirst with hfirst | hfirst
      · have hvalue : a + 2 * b = 12 := calc
          a + 2 * b = (a + b) + b := by ring
          _ = 4 + 8 := by rw [hfirst, hpositive]
          _ = 12 := by norm_num
        rcases hsecond with hsecond | hsecond <;> omega
      · have hvalue : a + 3 * b = 12 := calc
          a + 3 * b = (a + b) + 2 * b := by ring
          _ = -4 + 16 := by rw [hfirst, hpositive]; norm_num
          _ = 12 := by norm_num
        rcases hthird with hthird | hthird <;> omega
    · -- 公差 -8: 第一項が 4 なら第三項、-4 なら第二項が -12 になる。
      rcases hfirst with hfirst | hfirst
      · have hvalue : a + 3 * b = -12 := calc
          a + 3 * b = (a + b) + 2 * b := by ring
          _ = 4 - 16 := by rw [hfirst, hnegative]; norm_num
          _ = -12 := by norm_num
        rcases hthird with hthird | hthird <;> omega
      · have hvalue : a + 2 * b = -12 := calc
          a + 2 * b = (a + b) + b := by ring
          _ = -4 - 8 := by rw [hfirst, hnegative]; norm_num
          _ = -12 := by norm_num
        rcases hsecond with hsecond | hsecond <;> omega
  -- 本文末尾の三項の一致。
  exact ⟨hzero, by simp [hzero], by simp [hzero]⟩

end Ising2DLambda.KacWard
