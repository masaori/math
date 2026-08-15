/-
「倍数の辺での下限への任意近接（0 < t ≤ 1 の場合）」の必要十分版。

自由エネルギー密度・実数・加法・自然数の乗法を外し、線形順序、値の列、下限、
下限より大きい元、添字の「倍数」を作る写像とそれに沿った単調性だけを残す。
証明手順は具体版と同じである（反例の添字を取る → 倍数で単調 → 下界性）。
-/
import Mathlib.Order.Bounds.Basic

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

/-- 下限 `lower` より大きい `upper` に対し、ある添字 `i` が存在して、その全ての倍数
    `mult i k` で `lower ≤ value (mult i k) < upper`。 -/
theorem rangeValue_infimum_approximation_multiples_necSuf
    {I K A : Type} [LinearOrder A]
    (value : I → A) (mult : I → K → I) (lower upper : A)
    (hlower : IsGLB (Set.range value) lower)
    (hmono : ∀ (i : I) (k : K), value (mult i k) ≤ value i)
    (hlower_lt_upper : lower < upper) :
    ∃ i : I, ∀ k : K, lower ≤ value (mult i k) ∧ value (mult i k) < upper := by
  -- 第一段: upper は下界ではないので、反例の添字 i を取る
  have hupper_not_lower : upper ∉ lowerBounds (Set.range value) := by
    intro hupper_lower
    have hupper_le_lower : upper ≤ lower := hlower.2 hupper_lower
    exact (not_le_of_gt hlower_lt_upper) hupper_le_lower
  have hexample : ∃ y : A, y ∈ Set.range value ∧ ¬upper ≤ y := by
    by_contra hno_example
    push_neg at hno_example
    apply hupper_not_lower
    intro y hy
    exact hno_example y hy
  obtain ⟨y, hy, hupper_not_le⟩ := hexample
  have hy_lt_upper : y < upper := lt_of_not_ge hupper_not_le
  rcases hy with ⟨i, rfl⟩
  refine ⟨i, fun k => ⟨?_, ?_⟩⟩
  -- 第二段: lower ≤ value (mult i k)（lower は下界）
  · exact hlower.1 ⟨mult i k, rfl⟩
  -- 第三段: value (mult i k) ≤ value i < upper
  · exact lt_of_le_of_lt (hmono i k) hy_lt_upper

end Ising2DLambda.NecSuf.ThermodynamicLimit
