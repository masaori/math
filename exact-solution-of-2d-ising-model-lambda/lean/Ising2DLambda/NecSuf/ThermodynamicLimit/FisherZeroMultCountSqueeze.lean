/-
「個数は重複度付きの個数を超えない」の必要十分版。

零点も代数的数も重複度も本質でない。効いているのは
「有限集合上の自然数の族が各点で 1 以上なら、その和は集合の元の個数以上である」
という有限和の単調性だけである（順序付き半環すら要らず、`ℕ` で足りる）。
-/
import Mathlib.Algebra.Order.BigOperators.Group.Finset

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

theorem card_le_sum_of_one_le_necSuf {α : Type*} (s : Finset α) (f : α → ℕ)
    (hf : ∀ a ∈ s, 1 ≤ f a) : s.card ≤ ∑ a ∈ s, f a := by
  calc s.card = ∑ _a ∈ s, 1 := Finset.card_eq_sum_ones s
    _ ≤ ∑ a ∈ s, f a := Finset.sum_le_sum hf

end Ising2DLambda.NecSuf.ThermodynamicLimit
