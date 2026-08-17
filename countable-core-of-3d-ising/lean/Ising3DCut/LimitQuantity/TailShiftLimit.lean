/-
「ずらした自由族は判別式が極限量を決めないことの反例である」の
Lean 具体版・極限側の一段。

本文の列 `a_L(q)` を抽象化した実数列 `a` について、箱の添字を一つ進めた
列 `n ↦ a (n + 1)` も同じ値へ収束することだけを述べる。
**ここが唯一の ℝ への脱出（箱の大きさの極限）である。**
-/
import Ising3DCut.LimitQuantity.FiniteBoxEqualitiesTransfer
import Ising3DCut.LimitQuantity.TailShiftLimitAbstract
import Mathlib.Topology.Instances.Real.Lemmas

namespace Ising3DCut.LimitQuantity

open Filter Topology

/-- ずらした自由族 `Z'_L = Z_{L+1}` の有限箱量。
自然数添字 `n` は本文の箱 `L = n + 1` を表すので、分配多項式とサイト数をともに一つ進める。 -/
noncomputable def shiftedFreeFiniteBoxQuantitySeq (q : ℚ) (N : ℕ → ℕ) : ℕ → ℝ :=
  fun n => rootSeq (finiteBoxValueSeq q) N (n + 1)

/-- ずらした自由族の有限箱量の列は、元の有限箱量の列の末尾を一つずらした列に
項ごとに一致する。これは定義の展開だけであり、極限を使わない。 -/
theorem shiftedFreeFiniteBoxQuantitySeq_eq_tail (q : ℚ) (N : ℕ → ℕ) :
    ∀ n, shiftedFreeFiniteBoxQuantitySeq q N n = rootSeq (finiteBoxValueSeq q) N (n + 1) := by
  intro n
  rfl

/-- 実数列が極限を持てば、先頭項を除いた列も同じ極限を持つ。 -/
theorem tendsto_tail_one (a : ℕ → ℝ) (ℓ : ℝ)
    (ha : Tendsto a atTop (𝓝 ℓ)) : Tendsto (fun n => a (n + 1)) atTop (𝓝 ℓ) := by
  exact tendsto_shift atTop (fun n => n + 1) (tendsto_add_atTop_nat 1) a ℓ ha

/-- 元の有限箱量の列が極限量 `α` を持てば、ずらした自由族の有限箱量の列も
同じ `α` へ収束する。項ごとの一致 `shiftedFreeFiniteBoxQuantitySeq_eq_tail` と
`tendsto_tail_one` の合成だけで、脱出は仮定・結論の極限に限る。 -/
theorem shiftedFreeFiniteBoxQuantitySeq_tendsto (q : ℚ) (N : ℕ → ℕ) (α : ℝ)
    (h : Tendsto (rootSeq (finiteBoxValueSeq q) N) atTop (𝓝 α)) :
    Tendsto (shiftedFreeFiniteBoxQuantitySeq q N) atTop (𝓝 α) := by
  exact shiftedSequence_tendsto atTop (fun n => n + 1) (tendsto_add_atTop_nat 1)
    (rootSeq (finiteBoxValueSeq q) N) (shiftedFreeFiniteBoxQuantitySeq q N)
    (shiftedFreeFiniteBoxQuantitySeq_eq_tail q N) α h

/-- ずらした自由族の極限量 `α'` が存在すれば、それは元の族の極限量 `α` と一致する。 -/
theorem shiftedFreeFiniteBoxQuantitySeq_limit_eq (q : ℚ) (N : ℕ → ℕ) (α α' : ℝ)
    (h : Tendsto (rootSeq (finiteBoxValueSeq q) N) atTop (𝓝 α))
    (h' : Tendsto (shiftedFreeFiniteBoxQuantitySeq q N) atTop (𝓝 α')) :
    α' = α := by
  exact shiftedSequence_limit_eq atTop (fun n => n + 1) (tendsto_add_atTop_nat 1)
    (rootSeq (finiteBoxValueSeq q) N) (shiftedFreeFiniteBoxQuantitySeq q N)
    (shiftedFreeFiniteBoxQuantitySeq_eq_tail q N) α α' h h'

end Ising3DCut.LimitQuantity
