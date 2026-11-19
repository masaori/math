import Mathlib

namespace Ising2DLambda.NecSuf.FisherZero

/-- 可換環の演算と、正錐の加法・乗法閉性、三分法だけを使う。 -/
theorem sumOfSquares_positiveRoot_plusReal_positive
    {K : Type*} [CommRing K] (C : Set K)
    (hadd : ∀ x y, x ∈ C → y ∈ C → x + y ∈ C)
    (hmul : ∀ x y, x ∈ C → y ∈ C → x * y ∈ C)
    (hzero : (0 : K) ∉ C) (a b c : K) (hc : c ∈ C)
    (hb2 : b * b ∈ C) (hc2 : c * c = a * a + b * b)
    (htri : c + a = 0 ∨ c + a ∈ C ∨ -(c + a) ∈ C) : c + a ∈ C := by
  rcases htri with hz | hp | hn
  · have hbzero : b * b = 0 := by
      have hca : c = -a := by linear_combination hz
      rw [hca] at hc2
      linear_combination -hc2
    exact False.elim (hzero (hbzero ▸ hb2))
  · exact hp
  · have hnega : -a ∈ C := by
      convert hadd _ _ hn hc using 1 <;> ring
    have hdiff : c - a ∈ C := by
      convert hadd _ _ hc hnega using 1 <;> ring
    have hnegB : -(b * b) ∈ C := by
      have hprod := hmul _ _ hn hdiff
      convert hprod using 1
      linear_combination hc2
    have hbad : (0 : K) ∈ C := by
      convert hadd _ _ hb2 hnegB using 1 <;> ring
    exact False.elim (hzero hbad)

end Ising2DLambda.NecSuf.FisherZero
