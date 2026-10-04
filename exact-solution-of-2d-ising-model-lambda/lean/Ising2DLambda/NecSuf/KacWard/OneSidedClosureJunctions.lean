/- 四部分の接合対の必要十分版。
値の型に代数構造は要らない。反復二列の長さと反復数の正値性だけで末項が定まる。
固定二列の長さの正値性はこの添字計算には使わず、具体的な閉包でのみ保証する。 -/
import Ising2DLambda.NecSuf.KacWard.RepeatedAdjacentSum

namespace Ising2DLambda.NecSuf.KacWard

def fourJunctionPairs {α : Type*} (a b c d : ℕ)
    (u v w x : ℕ → α) : List (α × α) :=
  [(u (a - 1), v 0), (v (b - 1), w 0),
    (w (c - 1), x 0), (x (d - 1), u 0)]

/-- 本文の反復二列の先頭・末尾を代入する計算。 -/
theorem fourJunctionPairs_repetition_necSuf {α : Type*}
    (u v w x : ℕ → α) (m b n d c : ℕ)
    (hm : 0 < m) (hn : 0 < n) (hc : 0 < c) :
    fourJunctionPairs (c * m) b (c * n) d
        (repeatDirectionSequence u m) v (repeatDirectionSequence w n) x =
      fourJunctionPairs m b n d u v w x := by
  have hu0 : repeatDirectionSequence u m 0 = u 0 := by
    simp [repeatDirectionSequence]
  have hw0 : repeatDirectionSequence w n 0 = w 0 := by
    simp [repeatDirectionSequence]
  have hulast := repeatDirectionSequence_last u m c hm hc
  have hwlast := repeatDirectionSequence_last w n c hn hc
  unfold fourJunctionPairs
  rw [hulast, hw0, hwlast, hu0]

end Ising2DLambda.NecSuf.KacWard
