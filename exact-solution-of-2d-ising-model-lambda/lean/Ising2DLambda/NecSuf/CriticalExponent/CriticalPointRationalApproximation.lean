/-
挟み込み区間から平方誤差をもつ近似点を取り出す論法の必要十分版。

必要なのは体の四則、平方による狭義・広義の比較、二平方和の平方表示と零性だけである。
-/
import Mathlib.Tactic.Ring

namespace Ising2DLambda.NecSuf.CriticalExponent

/--
`p ≤ xc < q`、`q - p = h`、`h² < delta` をすべて平方証人で受けると、
`(xc-q)² < delta` の平方証人を構成できる。
-/
theorem rational_approximation_square_lt_necSuf {K : Type*} [Field K]
    (sumIsSquare : ∀ a b : K, ∃ v : K, a * a + b * b = v * v)
    (sumEqZero : ∀ a b : K, a * a + b * b = 0 → a = 0 ∧ b = 0)
    (xc p q h delta : K)
    (hWidth : q - p = h)
    (hLower : (∃ d : K, xc - p = d * d) ∨ xc = p)
    (hUpper : ∃ a : K, a ≠ 0 ∧ q - xc = a * a)
    (hPositive : ∃ e : K, e ≠ 0 ∧ h = e * e)
    (hFine : ∃ r : K, r ≠ 0 ∧ delta - h * h = r * r) :
    ∃ z : K, z ≠ 0 ∧ delta - (xc - q) * (xc - q) = z * z := by
  obtain ⟨a, ha0, ha⟩ := hUpper
  obtain ⟨e, he0, he⟩ := hPositive
  obtain ⟨r, hr0, hr⟩ := hFine
  obtain ⟨d, hd⟩ : ∃ d : K, xc - p = d * d := by
    rcases hLower with hStrict | hEqual
    · exact hStrict
    · exact ⟨0, by rw [hEqual]; ring⟩
  have hGap : h - a * a = d * d := by
    rw [← hWidth, ← ha, ← hd]
    ring
  obtain ⟨v, hv⟩ := sumIsSquare e a
  have hv0 : v ≠ 0 := by
    intro hvZero
    have hsum : e * e + a * a = 0 := by rw [hv, hvZero]; ring
    exact he0 (sumEqZero e a hsum).1
  obtain ⟨z, hz⟩ := sumIsSquare r (d * v)
  have hz0 : z ≠ 0 := by
    intro hzZero
    have hsum : r * r + (d * v) * (d * v) = 0 := by rw [hz, hzZero]; ring
    exact hr0 (sumEqZero r (d * v) hsum).1
  refine ⟨z, hz0, ?_⟩
  calc
    delta - (xc - q) * (xc - q)
        = (delta - h * h) + (h * h - (a * a) * (a * a)) := by rw [← ha]; ring
    _ = r * r + (h - a * a) * (h + a * a) := by rw [hr]; ring
    _ = r * r + (d * d) * ((e * e) + (a * a)) := by rw [hGap, he]
    _ = r * r + (d * d) * (v * v) := by rw [hv]
    _ = r * r + (d * v) * (d * v) := by ring
    _ = z * z := hz

end Ising2DLambda.NecSuf.CriticalExponent
