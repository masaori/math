/-
「ずらした自由族は既約分解の型が極限量を決めないことの反例である」の
Lean 具体版。

SageMath の厳密因数分解で得た二つの型を、(既約因子の次数, 重複度) の
正規化済みリストとしてそのまま置く。Lean では元 `(2, 2)` の有無により
二つの有限データが異なることを決定計算し、既存の末尾ずらし極限定理と束ねる。
ℝ への脱出は仮定・結論の箱の大きさの極限だけである。
-/
import Ising3DCut.LimitQuantity.TailShiftLimit

namespace Ising3DCut.LimitQuantity

open Filter Topology

/-- 自由境界の `Z₂` の既約因子の (次数, 重複度) の正規化済みリスト。 -/
def freeBoxTwoFactorizationType : List (ℕ × ℕ) :=
  [(1, 4), (2, 2), (4, 1)]

/-- ずらした自由族の `Z'₂ = Z₃` の既約因子の (次数, 重複度) の正規化済みリスト。 -/
def shiftedFreeBoxTwoFactorizationType : List (ℕ × ℕ) :=
  [(1, 14), (40, 1)]

/-- ずらした自由族の判定枠で、既約分解の型は極限量を決めない。
二つの具体的な有限因子型は異なるが、ずらした自由族の極限量は元の族の
極限量に一致する。 -/
theorem factorization_type_does_not_determine_limit_quantity
    (q : ℚ) (N : ℕ → ℕ) (α α' : ℝ)
    (h : Tendsto (rootSeq (finiteBoxValueSeq q) N) atTop (𝓝 α))
    (h' : Tendsto (shiftedFreeFiniteBoxQuantitySeq q N) atTop (𝓝 α')) :
    freeBoxTwoFactorizationType ≠ shiftedFreeBoxTwoFactorizationType ∧ α' = α := by
  refine ⟨by decide, ?_⟩
  exact shiftedFreeFiniteBoxQuantitySeq_limit_eq q N α α' h h'

end Ising3DCut.LimitQuantity
