/-
「奇数周期では多重度は回文でない」の必要十分版。

具体版の証明で使う性質だけを残す。

  使っている性質        なぜ削れないか
  `1 ≤ a`               一方の値が空でない水準集合の元の個数であること。
  `b = 0`               他方の値が空な水準集合の元の個数であること。
  自然数の順序 `¬(1 ≤ 0)`  等しいと仮定したときの矛盾を取り出すため。

周期辺・周期端点写像・値 ±1・多重度の定義は仮定しない——具体版の証明が
それらを使うのは二つの値を得る段（前二主張）だけであり、値を比べる段では
「一方は 1 以上、他方は 0」しか使わないからである。

証明手順は具体版と同じ（等しいと仮定し、1 ≤ 0 を得て矛盾）。

住処: 自然数のみ。ℝ / ℂ は現れない。
-/
import Ising3DCut.NecSuf.NullModel.OddPeriodicCycle

namespace Ising3DCut.NecSuf.NullModel

/-- 1 以上の自然数と 0 に等しい自然数は等しくない。 -/
theorem ne_of_one_le_of_eq_zero {a b : ℕ} (h1 : 1 ≤ a) (h0 : b = 0) : a ≠ b := by
  intro heq
  rw [heq, h0] at h1
  exact Nat.not_succ_le_zero 0 h1

end Ising3DCut.NecSuf.NullModel
