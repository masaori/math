/-
「1 の冪根の全体は有限であり元の個数は指数を超えない」の具体版。
人手証明と同じく、無限性から n+1 個の有限部分集合を取り、直前の上界と矛盾させる。
住処は Qbar と ℕ であり、ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnitySubsetCardBound
import Mathlib.Data.Set.Card

namespace Ising2DLambda.AlgebraicEigenvalue

theorem rootOfUnityFiniteCardLe (n : ℕ) (hn : 1 ≤ n) :
    (RootOfUnity n).Finite ∧ (RootOfUnity n).ncard ≤ n := by
  classical
  have hfinite : (RootOfUnity n).Finite := by
    by_contra hnot
    have hinfinite : (RootOfUnity n).Infinite := hnot
    obtain ⟨s, hs, hcard⟩ := hinfinite.exists_subset_card_eq (n + 1)
    have hle : s.card ≤ n := rootOfUnitySubsetCardLe n hn s fun w hw =>
      (mem_rootOfUnity).1 (hs hw)
    omega
  constructor
  · exact hfinite
  · rw [Set.ncard_eq_toFinset_card (RootOfUnity n) hfinite]
    exact rootOfUnitySubsetCardLe n hn hfinite.toFinset fun w hw =>
      (mem_rootOfUnity).1 (hfinite.mem_toFinset.1 hw)

end Ising2DLambda.AlgebraicEigenvalue
