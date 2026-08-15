/-
「倍数の辺での上限への任意近接（1 ≤ t の場合）」の必要十分版。

自由エネルギー密度・実数・減法・自然数の乗法を外し、線形順序、値の列、上限、
上限より小さい元、添字の「倍数」を作る写像とそれに沿った単調性だけを残す。
証明手順は具体版と同じである（反例の添字を取る → 倍数で単調 → 上界性）。
線形順序（三分律）は「上界でないことから反例を取る」段で要る。
-/
import Mathlib.Order.Bounds.Basic

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

/-- 上限より小さい `lower` に対し、ある添字 `i` が存在して、その全ての倍数 `mult i k` で
    `lower < value (mult i k) ≤ upper`。 -/
theorem rangeValue_supremum_approximation_multiples_necSuf
    {I K A : Type} [LinearOrder A]
    (value : I → A) (mult : I → K → I) (upper lower : A)
    (hupper : IsLUB (Set.range value) upper)
    (hmono : ∀ (i : I) (k : K), value i ≤ value (mult i k))
    (hlower_lt_upper : lower < upper) :
    ∃ i : I, ∀ k : K, lower < value (mult i k) ∧ value (mult i k) ≤ upper := by
  -- 第一段: lower は上界ではないので、反例の添字 i を取る
  have hlower_not_upper : lower ∉ upperBounds (Set.range value) := by
    intro hlower_upper
    have hupper_le_lower : upper ≤ lower := hupper.2 hlower_upper
    exact (not_le_of_gt hlower_lt_upper) hupper_le_lower
  have hexample : ∃ y : A, y ∈ Set.range value ∧ ¬y ≤ lower := by
    by_contra hno_example
    push_neg at hno_example
    apply hlower_not_upper
    intro y hy
    exact hno_example y hy
  obtain ⟨y, hy, hy_not_le⟩ := hexample
  have hlower_lt_y : lower < y := lt_of_not_ge hy_not_le
  rcases hy with ⟨i, rfl⟩
  refine ⟨i, fun k => ⟨?_, ?_⟩⟩
  -- 第二段: lower < value i ≤ value (mult i k)
  · exact lt_of_lt_of_le hlower_lt_y (hmono i k)
  -- 第三段: value (mult i k) ≤ upper（upper は上界）
  · exact hupper.1 ⟨mult i k, rfl⟩

end Ising2DLambda.NecSuf.ThermodynamicLimit
