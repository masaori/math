/-
具体版が必要十分版の特殊化として得られることの明示。

二つの多重度を、前二主張の具体版で「1 以上」「0 に等しい」へ評価し、
値を比べる段だけを必要十分版へ渡す。

住処: `Nat`、有限型の元の個数のみ。ℝ / ℂ は現れない。
-/
import Ising3DCut.NullModel.PeriodicNotPalindrome
import Ising3DCut.NecSuf.NullModel.PeriodicNotPalindrome

namespace Ising3DCut.NullModel

/-- `claim_periodic_not_palindrome` の具体版を必要十分版から導いたもの。 -/
theorem periodicMultiplicity_not_palindrome_from_necSuf {L : ℕ} (hodd : Odd L) :
    periodicMultiplicity L 0 ≠
      periodicMultiplicity L (Fintype.card (PeriodicEdge L) - 0) := by
  rw [Nat.sub_zero]
  exact NecSuf.NullModel.ne_of_one_le_of_eq_zero
    (one_le_periodicMultiplicity_zero L)
    (periodicMultiplicity_full_eq_zero hodd)

end Ising3DCut.NullModel
