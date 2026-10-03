/- 三周期比較の具体版を、必要十分版の ℤ・二値 4, -4 への特殊化として導く。 -/
import Ising2DLambda.KacWard.ThreeTermPmFourDifferenceZero
import Ising2DLambda.NecSuf.KacWard.ThreeTermPmFourDifferenceZero

namespace Ising2DLambda.KacWard

theorem threeTermPmFour_difference_zero_from_necSuf (a b : ℤ)
    (hfirst : a + b = 4 ∨ a + b = -4)
    (hsecond : a + 2 * b = 4 ∨ a + 2 * b = -4)
    (hthird : a + 3 * b = 4 ∨ a + 3 * b = -4) :
    b = 0 ∧ a + b = a + 2 * b ∧ a + 2 * b = a + 3 * b := by
  have htwo : 2 * b = b + b := by ring
  have hthree : 3 * b = (b + b) + b := by ring
  have hdouble : (-(-4 : ℤ) + 4) + (-(-4 : ℤ) + 4) ≠ 0 := by norm_num
  have h := Ising2DLambda.NecSuf.KacWard.threeTermTwoValue_difference_zero_necSuf
    a b 4 (-4) hdouble hfirst
    (by simpa only [htwo] using hsecond)
    (by simpa only [hthree] using hthird)
  simpa only [htwo, hthree] using h

end Ising2DLambda.KacWard
