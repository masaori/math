/-
「ずらした自由族は交差べき等式が極限量に対して必要でないことの反例である」の
Lean 必要十分版からの導出。

既約分解型の必要十分版 `value_invariant_does_not_determine_limit_quantity` は、
不変量の二つの値の不一致・フィルタを保つ添字写像・二列の項別一致・Hausdorff 空間での
極限一意性だけを仮定し、値の型は任意である。本主張の抽象形はこれがそのまま担う：
値の型を `ℕ`、二つの値を `freeBoxTwoValueAtTwo ^ 27` と `shiftedFreeBoxTwoValueAtTwo ^ 8`、
不一致を `crossPowerEquality_fails_at_two`、添字写像を末尾ずらしに取ればよい。
非可算への脱出は、二つの有限箱量列がそれぞれ実数へ収束するという仮定 `h` と `h'` に
現れる箱の大きさの極限だけである。
-/
import Ising3DCut.LimitQuantity.CrossPowerEqualityNotNecessaryForLimitQuantity
import Ising3DCut.LimitQuantity.FactorizationTypeDoesNotDetermineLimitQuantityAbstract

namespace Ising3DCut.LimitQuantity

open Filter Topology

/-- 具体版 `cross_power_equality_is_not_necessary_for_limit_quantity` は必要十分版
`value_invariant_does_not_determine_limit_quantity` の特殊化として導出できる。 -/
theorem cross_power_equality_is_not_necessary_for_limit_quantity_fromNecSuf
    (N : ℕ → ℕ) (α α' : ℝ)
    (h : Tendsto (rootSeq (finiteBoxValueSeq (2 : ℚ)) N) atTop (𝓝 α))
    (h' : Tendsto (shiftedFreeFiniteBoxQuantitySeq (2 : ℚ) N) atTop (𝓝 α')) :
    freeBoxTwoValueAtTwo ^ 27 ≠ shiftedFreeBoxTwoValueAtTwo ^ 8 ∧ α' = α :=
  value_invariant_does_not_determine_limit_quantity
    (freeBoxTwoValueAtTwo ^ 27) (shiftedFreeBoxTwoValueAtTwo ^ 8)
    crossPowerEquality_fails_at_two
    atTop (fun n => n + 1) (tendsto_add_atTop_nat 1)
    (rootSeq (finiteBoxValueSeq (2 : ℚ)) N) (shiftedFreeFiniteBoxQuantitySeq (2 : ℚ) N)
    (shiftedFreeFiniteBoxQuantitySeq_eq_tail (2 : ℚ) N) α α' h h'

end Ising3DCut.LimitQuantity
