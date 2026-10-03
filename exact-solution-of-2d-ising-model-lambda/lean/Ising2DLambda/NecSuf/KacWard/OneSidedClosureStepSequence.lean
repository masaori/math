/-
「一側閉包の歩ベクトル列は四部分の連結である」の必要十分版。
隣接する二点を読む写像には代数法則を要求しない。点と値の型にも構造は不要。
使う仮定は三つの接合点の一致と第二・第三の区間長の正値性だけである。
第一の区間長は零でもよい。
第四部分は添字を逆向きに読むため、写像に渡す二点の順序を保つ必要がある。
-/
import Ising2DLambda.NecSuf.KacWard.OneSidedPeriodicLiftClosure
import Ising2DLambda.NecSuf.KacWard.FourPartAdjacentSum

namespace Ising2DLambda.NecSuf.KacWard

theorem oneSidedClosure_stepSequence_necSuf {X Y : Type*}
    (step : X → X → Y) (p q r s : ℕ → X) (a b c : ℕ)
    (hb : 0 < b) (hc : 0 < c)
    (h12 : p a = q 0) (h23 : q b = r 0) (h34 : r c = s b)
    (j : ℕ) (hj : j < a + 2 * b + c) :
    step (oneSidedFourSegmentPath p q r s a b c j)
        (oneSidedFourSegmentPath p q r s a b c (j + 1)) =
      joinDirectionSequence
        (joinDirectionSequence
          (joinDirectionSequence (fun i => step (p i) (p (i + 1)))
            (fun i => step (q i) (q (i + 1))) a)
          (fun i => step (r i) (r (i + 1))) (a + b))
        (fun i => step (s (b - i)) (s (b - (i + 1)))) (a + b + c) j := by
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

end Ising2DLambda.NecSuf.KacWard
