/-
「ずらした自由族は判別式が極限量を決めないことの反例である」の
Lean 具体版・極限側の一段。

本文の列 `a_L(q)` を抽象化した実数列 `a` について、箱の添字を一つ進めた
列 `n ↦ a (n + 1)` も同じ値へ収束することだけを述べる。
**ここが唯一の ℝ への脱出（箱の大きさの極限）である。**
-/
import Ising3DCut.LimitQuantity.FiniteBoxEqualitiesTransfer
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
  exact ha.comp (tendsto_add_atTop_nat 1)

end Ising3DCut.LimitQuantity
