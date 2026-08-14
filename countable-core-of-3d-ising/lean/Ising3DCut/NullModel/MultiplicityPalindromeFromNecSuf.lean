/-
具体版が必要十分版の特殊化として得られることの明示。

有限型を配位、対合を奇数側反転、重みを破れ数、全体数を辺の個数に取る。
具体版ですでに示した対合性と破れ数の補数公式だけを必要十分版へ渡す。

住処: `Fin`、`Nat`、`Bool`、整数 ±1、有限型のみ。ℝ / ℂ は現れない。
-/
import Ising3DCut.NullModel.MultiplicityPalindrome
import Ising3DCut.NecSuf.NullModel.MultiplicityPalindrome

namespace Ising3DCut.NullModel

/-- `claim_palindrome` の具体版を必要十分版から導いたもの。 -/
theorem multiplicity_palindrome_from_necSuf {L m : ℕ}
    (h : m ≤ Fintype.card (Edge L)) :
    multiplicity L m = multiplicity L (Fintype.card (Edge L) - m) := by
  exact NecSuf.NullModel.card_fiber_complement
    (oddFlip (L := L)) brokenCount (Fintype.card (Edge L)) m
    oddFlip_oddFlip brokenCount_oddFlip h

end Ising3DCut.NullModel
