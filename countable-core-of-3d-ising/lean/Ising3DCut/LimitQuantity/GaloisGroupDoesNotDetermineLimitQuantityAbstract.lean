/-
「ずらした自由族は Galois 群が極限量を決めないことの反例である」の Lean 必要十分版。

多項式・分解体・次数 40・位数 4・実数列は本質ではない。証明が使うのは、二つの有限型の
位数について `m` が一方を割るが他方を割らないこと、添字写像がフィルタを保つこと、
二つの列が項ごとに末尾ずらしで一致すること、極限の一意性だけである。
-/
import Ising3DCut.LimitQuantity.GaloisGroupOrderComparison
import Ising3DCut.LimitQuantity.TailShiftLimitAbstract

namespace Ising3DCut.LimitQuantity

open Filter Topology

/-- 二つの有限型の位数について、`m` が一方だけを割るなら型同値は存在しない。 -/
theorem no_equiv_of_card_eq_of_dvd_of_not_dvd
    {G G' : Type*} [Fintype G] [Fintype G']
    (n m : ℕ) (hG : Fintype.card G = n)
    (hG' : m ∣ Fintype.card G') (hnot : ¬m ∣ n) :
    ¬ Nonempty (G ≃ G') := by
  rintro ⟨e⟩
  apply hnot
  rw [← hG, Fintype.card_congr e]
  exact hG'

/-- 必要十分版：有限不変量が異なる二対象の列が同じ極限を持つなら、
その有限不変量は極限量を決めない。 -/
theorem finite_invariant_does_not_determine_limit_quantity
    {G G' ι X : Type*} [Fintype G] [Fintype G']
    [TopologicalSpace X] [T2Space X]
    (n m : ℕ) (hG : Fintype.card G = n)
    (hG' : m ∣ Fintype.card G') (hnot : ¬m ∣ n)
    (F : Filter ι) [F.NeBot] (shift : ι → ι) (hshift : Tendsto shift F F)
    (a a' : ι → X) (hpoint : ∀ i, a' i = a (shift i))
    (x x' : X) (ha : Tendsto a F (𝓝 x)) (ha' : Tendsto a' F (𝓝 x')) :
    ¬ Nonempty (G ≃ G') ∧ x' = x := by
  refine ⟨no_equiv_of_card_eq_of_dvd_of_not_dvd n m hG hG' hnot, ?_⟩
  exact shiftedSequence_limit_eq F shift hshift a a' hpoint x x' ha ha'

end Ising3DCut.LimitQuantity
