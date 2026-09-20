/-
具体版が必要十分版の特殊化として得られることの導出。

具体側は整数の順序と一歩条件から各隣接差を上横断・下横断の指示値へ同定する。
有限和を端点差へ移す段だけを、加法可換群で成り立つ必要十分版へ渡す。
-/
import Ising2DLambda.Tools.IntegerSequenceLevelCrossing
import Ising2DLambda.NecSuf.Tools.IntegerSequenceLevelCrossing

namespace Ising2DLambda.Tools

open BigOperators

/-- `claim_integer_sequence_level_crossing` を必要十分版から導く。 -/
theorem integerSequence_levelCrossing_from_necSuf (n : ℕ) (a : ℕ → ℤ) (c : ℤ)
    (hstep : ∀ k < n, a (k + 1) - a k = -1 ∨
      a (k + 1) - a k = 0 ∨ a (k + 1) - a k = 1) :
    (upCrossingCount n a c : ℤ) - (downCrossingCount n a c : ℤ)
      = endpointCrossingValue c (a 0) (a n) := by
  have hlocal : ∀ k ∈ Finset.range n,
      levelIndicator c (a (k + 1)) - levelIndicator c (a k)
        = (if a k = c ∧ a (k + 1) = c + 1 then 1 else 0)
          - (if a k = c + 1 ∧ a (k + 1) = c then 1 else 0) := by
    intro k hk
    exact levelIndicator_step c (a k) (a (k + 1)) (hstep k (Finset.mem_range.mp hk))
  calc
    (upCrossingCount n a c : ℤ) - (downCrossingCount n a c : ℤ)
        = (∑ k ∈ Finset.range n,
            ((if a k = c ∧ a (k + 1) = c + 1 then 1 else 0) : ℤ))
          - (∑ k ∈ Finset.range n,
            ((if a k = c + 1 ∧ a (k + 1) = c then 1 else 0) : ℤ)) := by
              simp [upCrossingCount, downCrossingCount]
    _ = ∑ k ∈ Finset.range n,
          (((if a k = c ∧ a (k + 1) = c + 1 then 1 else 0) : ℤ)
            - ((if a k = c + 1 ∧ a (k + 1) = c then 1 else 0) : ℤ)) := by
              rw [Finset.sum_sub_distrib]
    _ = ∑ k ∈ Finset.range n,
          (levelIndicator c (a (k + 1)) - levelIndicator c (a k)) := by
              apply Finset.sum_congr rfl
              intro k hk
              exact (hlocal k hk).symm
    _ = levelIndicator c (a n) - levelIndicator c (a 0) :=
          Ising2DLambda.NecSuf.Tools.adjacent_difference_sum_necSuf
            (fun k => levelIndicator c (a k)) n
    _ = endpointCrossingValue c (a 0) (a n) := levelIndicator_endpoint _ _ _

end Ising2DLambda.Tools
