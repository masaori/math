/-
主張「1 の冪根の全体にわたる冪の和の値」の必要十分版。

具体版と同じ場合分けだけを、値の型に構造を一切要求せずに通す。
必要なのは命題 `P` が成り立つ場合の値と、成り立たない場合の値だけである。
有限和・冪・加法・積・体・代数閉性はこの組み立ての段では使わない。

住処: 一般の型。ここに ℝ / ℂ は現れない。
-/
namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

universe u

/-- `P` の両側で値が確定していれば、その値は `if P then c else z` で表される。 -/
theorem piecewise_value_necSuf {M : Type u} {p : Prop} [Decidable p] {s c z : M}
    (hpos : p → s = c) (hneg : ¬p → s = z) :
    s = if p then c else z := by
  by_cases hp : p
  · rw [if_pos hp]
    exact hpos hp
  · rw [if_neg hp]
    exact hneg hp

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
