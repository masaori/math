/-
「有限接頭部を忘れた尾部一致は極限量に対して十分である」の
Lean 必要十分版。

有理点・有限箱の分配多項式値・自然数乗根は本質ではない。
証明が使うのは、位相空間に値を持つ二列がある添字以降で一致することと、
`atTop` での収束だけである。極限値の一致にだけ Hausdorff 性を使う。
-/
import Mathlib.Topology.Instances.Real.Lemmas

namespace Ising3DCut.LimitQuantity

open Filter Topology

variable {X : Type*}

/-- 必要十分版（収束の移送）：尾部一致する二列の一方が収束すれば、
他方も同じ値へ収束する。 -/
theorem tailAgreement_tendsto_abstract [TopologicalSpace X] (a b : ℕ → X)
    (hTail : ∃ N : ℕ, ∀ n : ℕ, N ≤ n → a n = b n) (x : X)
    (ha : Tendsto a atTop (𝓝 x)) : Tendsto b atTop (𝓝 x) := by
  obtain ⟨N, hN⟩ := hTail
  apply ha.congr'
  filter_upwards [eventually_ge_atTop N] with n hn
  exact hN n hn

/-- 必要十分版（値の一致）：Hausdorff 空間で尾部一致する二列が
それぞれ極限を持つなら、その極限は等しい。 -/
theorem tailAgreement_limit_eq_abstract [TopologicalSpace X] [T2Space X] (a b : ℕ → X)
    (hTail : ∃ N : ℕ, ∀ n : ℕ, N ≤ n → a n = b n) (x x' : X)
    (ha : Tendsto a atTop (𝓝 x)) (hb : Tendsto b atTop (𝓝 x')) : x = x' :=
  tendsto_nhds_unique (tailAgreement_tendsto_abstract a b hTail x ha) hb

end Ising3DCut.LimitQuantity
