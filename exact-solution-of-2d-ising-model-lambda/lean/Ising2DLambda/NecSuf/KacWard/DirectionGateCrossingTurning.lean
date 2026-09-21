/-
「循環総回転数は方向番号の門の符号付き横断数の 4 倍である」の必要十分版。

格子と四方向から切り離すと、必要なのは各項が「次の標準代表 − 現在の標準代表」に
正横断の 4 倍を足し、負横断の 4 倍を引いた形であることと、代表列の終点が始点へ
戻ることだけである。証明手順は人手証明と同じく、各項の分解、有限和、望遠和、
終点と始点の一致、分配法則の順で進む。
-/
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- 各項の門横断分解と端点の一致から、符号付き横断数の四倍を得る。 -/
theorem direction_gate_crossing_turning_necSuf
    (n : ℕ) (representative turning : ℕ → ℤ)
    (positiveGate negativeGate : ℕ → ℕ)
    (hlocal : ∀ k < n,
      turning k = representative (k + 1) - representative k
        + 4 * (positiveGate k : ℤ) - 4 * (negativeGate k : ℤ))
    (hclosed : representative n = representative 0) :
    (∑ k ∈ Finset.range n, turning k) =
      4 * (((∑ k ∈ Finset.range n, positiveGate k : ℕ) : ℤ)
        - ((∑ k ∈ Finset.range n, negativeGate k : ℕ) : ℤ)) := by
  calc
    (∑ k ∈ Finset.range n, turning k)
        = ∑ k ∈ Finset.range n,
            (representative (k + 1) - representative k
              + 4 * (positiveGate k : ℤ) - 4 * (negativeGate k : ℤ)) := by
              apply Finset.sum_congr rfl
              intro k hk
              exact hlocal k (Finset.mem_range.mp hk)
    _ = (∑ k ∈ Finset.range n, (representative (k + 1) - representative k))
          + 4 * ∑ k ∈ Finset.range n, (positiveGate k : ℤ)
          - 4 * ∑ k ∈ Finset.range n, (negativeGate k : ℤ) := by
            simp only [Finset.sum_sub_distrib, Finset.sum_add_distrib, Finset.mul_sum]
    _ = representative n - representative 0
          + 4 * ∑ k ∈ Finset.range n, (positiveGate k : ℤ)
          - 4 * ∑ k ∈ Finset.range n, (negativeGate k : ℤ) := by
            rw [Finset.sum_range_sub]
    _ = 4 * ∑ k ∈ Finset.range n, (positiveGate k : ℤ)
          - 4 * ∑ k ∈ Finset.range n, (negativeGate k : ℤ) := by
            rw [hclosed]
            ring
    _ = 4 * (((∑ k ∈ Finset.range n, positiveGate k : ℕ) : ℤ)
          - ((∑ k ∈ Finset.range n, negativeGate k : ℕ) : ℤ)) := by
            push_cast
            ring

end Ising2DLambda.NecSuf.KacWard
