/-
「持ち上げ点が相異なる閉路の各訪問頂点に接する四辺はそれぞれ高々一度通過される」の必要十分版。

格子から切り離すと、必要なのは、四つの通過回数の総和が訪問回数の二倍であること、
訪問回数が一であること、そして四つのうち相異なる二つ（訪問へ入る辺と出る辺）が正であることだけである。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

/-- 総和が訪問回数の二倍で訪問回数が一、相異なる二項が正なら、四つの自然数はそれぞれ高々一である。
自然数の加法と順序だけを使う。 -/
theorem four_incident_counts_le_one_necSuf (a b c d v : ℕ)
    (hsum : a + b + c + d = 2 * v) (hv : v = 1)
    (hpositive :
      (0 < a ∧ 0 < b) ∨ (0 < a ∧ 0 < c) ∨
      (0 < a ∧ 0 < d) ∨ (0 < b ∧ 0 < c) ∨
      (0 < b ∧ 0 < d) ∨ (0 < c ∧ 0 < d)) :
    a ≤ 1 ∧ b ≤ 1 ∧ c ≤ 1 ∧ d ≤ 1 := by
  subst hv
  rcases hpositive with ⟨ha, hb⟩ | ⟨ha, hc⟩ | ⟨ha, hd⟩ |
    ⟨hb, hc⟩ | ⟨hb, hd⟩ | ⟨hc, hd⟩
  all_goals omega

end Ising2DLambda.NecSuf.KacWard
