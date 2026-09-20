/-
「内側セルは行に沿って奇数回通過の縦辺まで届く」の必要十分版。

格子路から切り離すと、必要なのは開始位置で個数が奇数であること、右側に個数が偶数となる
位置が存在すること、隣接する二位置の個数の差が境界の個数であることだけである。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

/-- 奇数の区間から最初の偶数位置へ移る境界では、増分が奇数になる。 -/
theorem odd_run_reaches_odd_increment_necSuf
    (count increment : ℤ → ℕ) (c : ℤ)
    (hstart : Odd (count c))
    (houtside : ∃ j : ℤ, c < j ∧ ¬ Odd (count j))
    (hsplit : ∀ j : ℤ, count (j - 1) = count j + increment j) :
    ∃ g : ℤ,
      c < g ∧
      (∀ j : ℤ, c ≤ j → j < g → Odd (count j)) ∧
      ¬ Odd (count g) ∧
      Odd (increment g) ∧
      0 < increment g := by
  let P : ℤ → Prop := fun j => c < j ∧ ¬ Odd (count j)
  have hbounded : ∃ b : ℤ, ∀ j : ℤ, P j → b ≤ j := by
    refine ⟨c + 1, ?_⟩
    intro j hj
    exact Int.add_one_le_iff.mpr hj.1
  obtain ⟨g, hgP, hgmin⟩ := Int.exists_least_of_bdd hbounded houtside
  have hinterior : ∀ j : ℤ, c ≤ j → j < g → Odd (count j) := by
    intro j hcj hjg
    by_cases hjc : j = c
    · simpa [hjc] using hstart
    · have hcj' : c < j := lt_of_le_of_ne hcj (Ne.symm hjc)
      by_contra hjodd
      have hjP : P j := ⟨hcj', hjodd⟩
      exact (not_le_of_gt hjg) (hgmin j hjP)
  have hprevious : Odd (count (g - 1)) := by
    apply hinterior (g - 1)
    · omega
    · omega
  have hcurrentEven : Even (count g) := Nat.not_odd_iff_even.mp hgP.2
  have hincrement : Odd (increment g) := by
    rcases hprevious with ⟨q, hq⟩
    rcases hcurrentEven with ⟨t, ht⟩
    refine ⟨q - t, ?_⟩
    have h := hsplit g
    omega
  have hincrementPos : 0 < increment g := by
    rcases hincrement with ⟨q, hq⟩
    omega
  exact ⟨g, hgP.1, hinterior, hgP.2, hincrement, hincrementPos⟩

end Ising2DLambda.NecSuf.KacWard
