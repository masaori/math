/-
「正の乗根の一致は交差べき等式を決める」の Lean 必要十分版からの導出。

具体側では共通の元を `posRoot A N` とし、乗根の一致によって
その `M` 乗が `B` であることを得る。交差べき等式の五段は必要十分版に
一度だけ担わせる。極限は使わない。
-/
import Ising3DCut.LimitQuantity.RootEqualityImpliesCrossPowerEquality
import Ising3DCut.NecSuf.RootEqualityImpliesCrossPowerEquality

namespace Ising3DCut.LimitQuantity

/-- 具体版は、共通の乗根が二つの箱値を与えることを必要十分版へ渡す特殊化である。 -/
theorem posRoot_equality_implies_cross_power_equality_fromNecSuf
    (A B : ℝ) (hA : 0 < A) (hB : 0 < B)
    (N M : ℕ) (hN : N ≠ 0) (hM : M ≠ 0)
    (hroot : posRoot A N = posRoot B M) :
    A ^ M = B ^ N := by
  apply NecSuf.common_root_implies_cross_power_equality
      (posRoot A N) A B N M (posRoot_pow A hA N hN)
  show posRoot A N ^ M = B
  rw [hroot]
  exact posRoot_pow B hB M hM

end Ising3DCut.LimitQuantity
