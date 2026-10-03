/-
三周期比較の必要十分版。隣接差の列挙と二つの非零候補の排除は具体版と同じ。
必要なのは加法群と、許される二値の差を二回足しても零にならないことだけである。
可換性・順序・乗法も、群全体がねじれを持たないという仮定も使わない。
二倍非零の仮定は、非零な位数二の差で二値を交互に訪れる場合を除くために要る。
-/
import Mathlib.Algebra.Group.Basic

namespace Ising2DLambda.NecSuf.KacWard

theorem threeTermTwoValue_difference_zero_necSuf {G : Type*} [AddGroup G]
    (a b upper lower : G)
    (hdouble : (-lower + upper) + (-lower + upper) ≠ 0)
    (hfirst : a + b = upper ∨ a + b = lower)
    (hsecond : a + (b + b) = upper ∨ a + (b + b) = lower)
    (hthird : a + ((b + b) + b) = upper ∨ a + ((b + b) + b) = lower) :
    b = 0 ∧ a + b = a + (b + b) ∧ a + (b + b) = a + ((b + b) + b) := by
  let delta := -lower + upper
  have hdelta : delta ≠ 0 := by
    intro hzero
    apply hdouble
    change delta + delta = 0
    simp [hzero]
  have hupper : lower + delta = upper := by simp [delta]
  have hlower : upper + -delta = lower := by
    simp [delta, neg_add_rev]
  -- 具体版の 12 と -12 が許された二値から外れることに対応する。
  have hpositive : upper + delta ≠ upper ∧ upper + delta ≠ lower := by
    constructor
    · intro h
      apply hdelta
      exact add_left_cancel (h.trans (add_zero upper).symm)
    · intro h
      apply hdouble
      change delta + delta = 0
      apply add_left_cancel (a := lower)
      calc
        lower + (delta + delta) = (lower + delta) + delta := (add_assoc _ _ _).symm
        _ = upper + delta := by rw [hupper]
        _ = lower := h
        _ = lower + 0 := (add_zero _).symm
  have hnegative : lower + -delta ≠ upper ∧ lower + -delta ≠ lower := by
    constructor
    · intro h
      have hneg : -delta = delta := add_left_cancel (h.trans hupper.symm)
      apply hdouble
      change delta + delta = 0
      calc
        delta + delta = -delta + delta := by rw [hneg]
        _ = 0 := neg_add_cancel _
    · intro h
      have hneg : -delta = 0 := add_left_cancel (h.trans (add_zero lower).symm)
      apply hdelta
      simpa using congrArg Neg.neg hneg
  -- 隣接二項の差は零、delta、-delta の三候補。
  have hdifference : b = -(a + b) + (a + (b + b)) := by
    simp [neg_add_rev, add_assoc]
  have hcandidates : b = 0 ∨ b = delta ∨ b = -delta := by
    rcases hfirst with hfirst | hfirst <;>
      rcases hsecond with hsecond | hsecond
    · left
      simpa [hfirst, hsecond] using hdifference
    · right; right
      simpa [hfirst, hsecond, delta, neg_add_rev] using hdifference
    · right; left
      simpa [hfirst, hsecond, delta] using hdifference
    · left
      simpa [hfirst, hsecond] using hdifference
  have hzero : b = 0 := by
    rcases hcandidates with hzero | hplus | hminus
    · exact hzero
    · rcases hfirst with hfirst | hfirst
      · have hvalue : a + (b + b) = upper + delta := calc
          a + (b + b) = (a + b) + b := (add_assoc _ _ _).symm
          _ = upper + delta := by rw [hfirst, hplus]
        rcases hsecond with hsecond | hsecond
        · exact False.elim (hpositive.1 (hvalue.symm.trans hsecond))
        · exact False.elim (hpositive.2 (hvalue.symm.trans hsecond))
      · have hvalue : a + ((b + b) + b) = upper + delta := calc
          a + ((b + b) + b) = ((a + b) + b) + b := by simp only [add_assoc]
          _ = (lower + delta) + delta := by rw [hfirst, hplus]
          _ = upper + delta := by rw [hupper]
        rcases hthird with hthird | hthird
        · exact False.elim (hpositive.1 (hvalue.symm.trans hthird))
        · exact False.elim (hpositive.2 (hvalue.symm.trans hthird))
    · rcases hfirst with hfirst | hfirst
      · have hvalue : a + ((b + b) + b) = lower + -delta := calc
          a + ((b + b) + b) = ((a + b) + b) + b := by simp only [add_assoc]
          _ = (upper + -delta) + -delta := by rw [hfirst, hminus]
          _ = lower + -delta := by rw [hlower]
        rcases hthird with hthird | hthird
        · exact False.elim (hnegative.1 (hvalue.symm.trans hthird))
        · exact False.elim (hnegative.2 (hvalue.symm.trans hthird))
      · have hvalue : a + (b + b) = lower + -delta := calc
          a + (b + b) = (a + b) + b := (add_assoc _ _ _).symm
          _ = lower + -delta := by rw [hfirst, hminus]
        rcases hsecond with hsecond | hsecond
        · exact False.elim (hnegative.1 (hvalue.symm.trans hsecond))
        · exact False.elim (hnegative.2 (hvalue.symm.trans hsecond))
  exact ⟨hzero, by simp [hzero], by simp [hzero]⟩

end Ising2DLambda.NecSuf.KacWard
