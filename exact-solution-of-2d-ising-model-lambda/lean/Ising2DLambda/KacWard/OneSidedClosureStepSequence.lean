/-
「一側閉包の歩ベクトル列は四部分の連結である」の具体版。
本文の四区間と三つの接合点を、整数格子点の差について個別に照合する。
閉性・単位性・非後退性はこの列の等式には不要であり、仮定しない。
-/
import Ising2DLambda.KacWard.OneSidedPeriodicLiftClosure
import Ising2DLambda.NecSuf.KacWard.FourPartAdjacentSum

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

/-- 接合点で途切れない歩ベクトル列の四部分表示。 -/
theorem oneSidedClosure_stepSequence
    (p q r s : ℕ → ℤ × ℤ) (a b c : ℕ)
    (_ha : 0 < a) (hb : 0 < b) (hc : 0 < c)
    (h12 : p a = q 0) (h23 : q b = r 0) (h34 : r c = s b)
    (j : ℕ) (hj : j < a + 2 * b + c) :
    oneSidedPeriodicLiftClosure p q r s a b c (j + 1) -
        oneSidedPeriodicLiftClosure p q r s a b c j =
      joinDirectionSequence
        (joinDirectionSequence
          (joinDirectionSequence (fun i => p (i + 1) - p i)
            (fun i => q (i + 1) - q i) a)
          (fun i => r (i + 1) - r i) (a + b))
        (fun i => s (b - (i + 1)) - s (b - i)) (a + b + c) j := by
  unfold oneSidedPeriodicLiftClosure
  -- 本文の四区間と、その内側・接合点の七場合に対応する。
  by_cases hja : j < a
  · have hjab : j < a + b := by omega
    have hjabc : j < a + b + c := by omega
    by_cases hn : j + 1 < a
    · simp only [oneSidedFourSegmentPath, joinDirectionSequence,
        if_pos hja, if_pos hjab, if_pos hjabc, if_pos hn]
    · have he : j + 1 = a := by omega
      simp only [oneSidedFourSegmentPath, joinDirectionSequence,
        if_pos hja, if_pos hjab, if_pos hjabc, he, if_neg (lt_irrefl a),
        if_pos (show a < a + b by omega), Nat.sub_self, h12]
  · by_cases hjab : j < a + b
    · have hjabc : j < a + b + c := by omega
      have hna : ¬j + 1 < a := by omega
      by_cases hn : j + 1 < a + b
      · have hi : j + 1 - a = j - a + 1 := by omega
        simp only [oneSidedFourSegmentPath, joinDirectionSequence,
          if_neg hja, if_neg hna, if_pos hjab, if_pos hjabc, if_pos hn, hi]
      · have he : j + 1 = a + b := by omega
        have hi : j - a + 1 = b := by omega
        simp only [oneSidedFourSegmentPath, joinDirectionSequence,
          if_neg hja, if_pos hjab, if_pos hjabc, he,
          if_neg (show ¬a + b < a by omega), if_neg (lt_irrefl (a + b)),
          if_pos (show a + b < a + b + c by omega),
          show a + b - a - b = 0 by omega, hi, h23]
    · by_cases hjabc : j < a + b + c
      · have hna : ¬j + 1 < a := by omega
        have hnab : ¬j + 1 < a + b := by omega
        have hi : j - (a + b) = j - a - b := by omega
        by_cases hn : j + 1 < a + b + c
        · have hnext : j + 1 - a - b = j - a - b + 1 := by omega
          simp only [oneSidedFourSegmentPath, joinDirectionSequence,
            if_neg hja, if_neg hjab, if_pos hjabc,
            if_neg hna, if_neg hnab, if_pos hn, hi, hnext]
        · have he : j + 1 = a + b + c := by omega
          have hlast : j - a - b + 1 = c := by omega
          simp only [oneSidedFourSegmentPath, joinDirectionSequence,
            if_neg hja, if_neg hjab, if_pos hjabc, he,
            if_neg (show ¬a + b + c < a by omega),
            if_neg (show ¬a + b + c < a + b by omega),
            if_neg (lt_irrefl (a + b + c)), hi, hlast,
            show a + 2 * b + c - (a + b + c) = b by omega, h34]
      · have hna : ¬j + 1 < a := by omega
        have hnab : ¬j + 1 < a + b := by omega
        have hnabc : ¬j + 1 < a + b + c := by omega
        have hi : a + 2 * b + c - j = b - (j - (a + b + c)) := by omega
        have hnext : a + 2 * b + c - (j + 1) =
            b - (j - (a + b + c) + 1) := by omega
        simp only [oneSidedFourSegmentPath, joinDirectionSequence,
          if_neg hja, if_neg hjab, if_neg hjabc,
          if_neg hna, if_neg hnab, if_neg hnabc, hi, hnext]


end Ising2DLambda.KacWard
