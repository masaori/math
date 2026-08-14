/-
具体版が必要十分版の特殊化として得られることの明示。

有限型を配位、重みを周期族の破れ数、証人を定数配位に取り、
具体版ですでに示した「定数配位の破れ数は 0」だけを必要十分版へ渡す。

必要十分版の `Fiber periodicBrokenCount 0` と具体版の
`periodicMultiplicity L 0` が数える有限集合は定義がどちらも
`Finset.univ.filter` で一致するので、元の個数もそのまま一致する。

住処: `Fin`、`Nat`、`Bool`、整数 ±1、有限型のみ。ℝ / ℂ は現れない。
-/
import Ising3DCut.NullModel.PeriodicConstantUnbroken
import Ising3DCut.NecSuf.NullModel.PeriodicConstantUnbroken

namespace Ising3DCut.NullModel

/-- `claim_periodic_constant_unbroken` の具体版を必要十分版から導いたもの。 -/
theorem one_le_periodicMultiplicity_zero_from_necSuf (L : ℕ) :
    1 ≤ periodicMultiplicity L 0 := by
  have h := NecSuf.NullModel.one_le_card_fiber
    (periodicBrokenCount (L := L)) 0 (constConfig L) (periodicBrokenCount_constConfig L)
  exact h

end Ising3DCut.NullModel
