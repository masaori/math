/-
具体版が必要十分版の特殊化として得られることの明示（`lean/README.md` の要件 4）。

必要十分版 `NecSuf.PartitionPolynomial.sum_card_fiber_eq_card` に
  α := 配位の集合 Config L
  f := 破れボンド数 brokenBondCount L
  N := 2L²
を代入し、Step 4（配位の総数が `2^{L²}`）を足すと、具体版
`PartitionPolynomial.multiplicity_sum_eq_two_pow` がそのまま出る。
このことは、具体版の証明が格子の形・周期境界条件・スピンの値が `{+1,-1}` であることを
使っていないという主張の裏取りになっている。

住処: ℕ のみ。
-/
import Ising2DLambda.PartitionPolynomial.CoefficientSum
import Ising2DLambda.NecSuf.PartitionPolynomial.CoefficientSum

namespace Ising2DLambda.PartitionPolynomial

open Finset

variable (L : ℕ) [NeZero L]

/-- 具体版の類 `A_m` は、必要十分版の類の特殊化そのものである（定義が一致する）。 -/
lemma brokenFiber_eq_necSuf_fiber (m : ℕ) :
    brokenFiber L m = NecSuf.PartitionPolynomial.fiber (brokenBondCount L) m := rfl

/-- 具体版の定理を、必要十分版から導いたもの。 -/
theorem multiplicity_sum_eq_two_pow_from_necSuf :
    ∑ m ∈ range (2 * L ^ 2 + 1), multiplicity L m = 2 ^ L ^ 2 := by
  have h := NecSuf.PartitionPolynomial.sum_card_fiber_eq_card
    (α := Config L) (brokenBondCount L) (2 * L ^ 2) (brokenBondCount_le L)
  rw [card_config] at h
  rw [← h]
  exact sum_congr rfl fun m _ => rfl

end Ising2DLambda.PartitionPolynomial
