/-
「一側閉包は閉じた単位格子路である」の必要十分版。

具体的な周期持ち上げ・横断階段・平行階段から切り離すと、必要なのは四つの有限路、
隣り合う部分の境界値の一致、各部分の許容された一歩だけである。第四部分だけは
添字を逆向きにたどる。点の型には代数構造も有限性も要らない。
-/
import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- 長さ `a`, `b`, `c`, `b` の四部分を、第四部分だけ逆向きに連結する有限路。 -/
def oneSidedFourSegmentPath {X : Type*}
    (first second third fourth : ℕ → X) (a b c j : ℕ) : X :=
  if j < a then first j
  else if j < a + b then second (j - a)
  else if j < a + b + c then third (j - a - b)
  else fourth (a + 2 * b + c - j)

/-- 四部分の境界が一致し、各部分の一歩が許容されれば、連結路は閉じ、全ての一歩が許容される。 -/
theorem one_sided_four_segments_closed_steps_necSuf
    {X : Type*} (AllowedStep : X → X → Prop)
    (first second third fourth : ℕ → X) (a b c : ℕ)
    (ha : 0 < a) (hb : 0 < b) (hc : 0 < c)
    (h12 : first a = second 0)
    (h23 : second b = third 0)
    (h34 : third c = fourth b)
    (h41 : fourth 0 = first 0)
    (hfirst : ∀ i < a, AllowedStep (first i) (first (i + 1)))
    (hsecond : ∀ i < b, AllowedStep (second i) (second (i + 1)))
    (hthird : ∀ i < c, AllowedStep (third i) (third (i + 1)))
    (hfourth : ∀ i < b, AllowedStep (fourth (i + 1)) (fourth i)) :
    oneSidedFourSegmentPath first second third fourth a b c 0 = first 0 ∧
      oneSidedFourSegmentPath first second third fourth a b c (a + 2 * b + c) = first 0 ∧
      ∀ j < a + 2 * b + c,
        AllowedStep
          (oneSidedFourSegmentPath first second third fourth a b c j)
          (oneSidedFourSegmentPath first second third fourth a b c (j + 1)) := by
  constructor
  · simp [oneSidedFourSegmentPath, ha]
  constructor
  · have htotalA : ¬a + 2 * b + c < a := by omega
    have htotalAB : ¬a + 2 * b + c < a + b := by omega
    have htotalABC : ¬a + 2 * b + c < a + b + c := by omega
    simp [oneSidedFourSegmentPath, htotalA, htotalAB, htotalABC, h41]
  · intro j hj
    by_cases hja : j < a
    · by_cases hnext : j + 1 < a
      · simpa [oneSidedFourSegmentPath, hja, hnext] using hfirst j hja
      · have hjeq : j + 1 = a := by omega
        have hjnext : ¬j + 1 < a := hnext
        have hjnextab : j + 1 < a + b := by omega
        simpa [oneSidedFourSegmentPath, hja, hjnext, hjnextab, hjeq, h12, hb] using
          hfirst j hja
    · have haj : a ≤ j := Nat.le_of_not_gt hja
      by_cases hjab : j < a + b
      · by_cases hnext : j + 1 < a + b
        · have hnexta : ¬j + 1 < a := by omega
          have hsub : j + 1 - a = (j - a) + 1 := by omega
          simpa [oneSidedFourSegmentPath, hja, hnexta, hjab, hnext, hsub]
            using hsecond (j - a) (by omega)
        · have hjeq : j + 1 = a + b := by omega
          have hnexta : ¬j + 1 < a := by omega
          have hnextab : ¬j + 1 < a + b := hnext
          have hnextabc : j + 1 < a + b + c := by omega
          have hindex : (j - a) + 1 = b := by omega
          simpa [oneSidedFourSegmentPath, hja, hnexta, hjab, hnextab, hnextabc,
            hjeq, hindex, h23, hc]
            using hsecond (j - a) (by omega)
      · have habj : a + b ≤ j := Nat.le_of_not_gt hjab
        by_cases hjabc : j < a + b + c
        · by_cases hnext : j + 1 < a + b + c
          · have hnexta : ¬j + 1 < a := by omega
            have hnextab : ¬j + 1 < a + b := by omega
            have hsub : j + 1 - a - b = (j - a - b) + 1 := by omega
            simpa [oneSidedFourSegmentPath, hja, hnexta, hjab, hnextab, hjabc, hnext,
              hsub]
              using hthird (j - a - b) (by omega)
          · have hjeq : j + 1 = a + b + c := by omega
            have hnexta : ¬j + 1 < a := by omega
            have hnextab : ¬j + 1 < a + b := by omega
            have hnextabc : ¬j + 1 < a + b + c := hnext
            have hsumA : ¬a + b + c < a := by omega
            have hsumAB : ¬a + b + c < a + b := by omega
            have hsumABC : ¬a + b + c < a + b + c := by omega
            have hthirdIndex : (j - a - b) + 1 = c := by omega
            have hfourthIndex : a + 2 * b + c - (a + b + c) = b := by omega
            simpa [oneSidedFourSegmentPath, hja, hnexta, hjab, hnextab, hjabc,
              hnextabc, hjeq, hsumA, hsumAB, hsumABC, hthirdIndex,
              hfourthIndex, h34]
              using hthird (j - a - b) (by omega)
        · have habcj : a + b + c ≤ j := Nat.le_of_not_gt hjabc
          have hnexta : ¬j + 1 < a := by omega
          have hnextab : ¬j + 1 < a + b := by omega
          have hnextabc : ¬j + 1 < a + b + c := by omega
          have hindex : a + 2 * b + c - j = (a + 2 * b + c - (j + 1)) + 1 := by
            omega
          simpa [oneSidedFourSegmentPath, hja, hnexta, hjab, hnextab, hjabc,
            hnextabc, hindex]
            using hfourth (a + 2 * b + c - (j + 1)) (by omega)

end Ising2DLambda.NecSuf.KacWard
