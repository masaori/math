/-
「ずらした自由族では Galois 群が非同型である」の Lean 具体版の有限位数側。

SageMath が確かめた二つの入力（最初の群の位数は 4、二つ目の群の位数は
40 の倍数）から、二つの有限群の間に同値が存在しないことを一段で示す。
群作用から 40 が位数を割る段と、末尾ずらしによる極限一致との束ねは後続で行う。
-/
import Mathlib

namespace Ising3DCut.LimitQuantity

/-- 位数 4 の有限群と、位数が 40 の倍数である有限群は同値でない。 -/
theorem no_equiv_of_card_four_of_forty_dvd_card
    {G₂ G₃ : Type*} [Fintype G₂] [Fintype G₃]
    (h₂ : Fintype.card G₂ = 4)
    (h₃ : 40 ∣ Fintype.card G₃) :
    ¬ Nonempty (G₂ ≃ G₃) := by
  rintro ⟨e⟩
  have hcard : Fintype.card G₂ = Fintype.card G₃ := Fintype.card_congr e
  omega

end Ising3DCut.LimitQuantity
