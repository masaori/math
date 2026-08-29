/-
「横断の平滑化は他の頂点の横断数を変えない」
（`claim_smoothing_other_vertex_crossing_invariance`）の必要十分版。

人手証明が使うのは、二つの量がそれぞれ二因子の積で書け、対応する因子が
等しいことだけである。積の結合性・可換性・単位元は使わないので、
仮定は二項演算 `Mul` と四つの等式だけに絞る。格子・軸・閉歩道の構造は使わない。
住処は有限集合の数え上げ（ℕ）であり、ℝ / ℂ は現れない。
-/

namespace Ising2DLambda.NecSuf.KacWard

/-- 二つの量がそれぞれ二因子の積で書け、対応する因子が等しいなら、二つの量は等しい。
`Mul α` は積を書くためだけに必要で、積の法則（結合・可換・単位元）は一切使わない。 -/
theorem product_with_equal_factors_necSuf {α : Type} [Mul α]
    (c c' x y x' y' : α)
    (hc : c = x * y) (hc' : c' = x' * y') (hx : x = x') (hy : y = y') :
    c = c' := by
  rw [hc, hc', hx, hy]

end Ising2DLambda.NecSuf.KacWard
