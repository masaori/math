/-
「有限接頭部を忘れた尾部一致は極限量に対して十分である」の
Lean 具体版・実数列の一般補題。

二つの実数列がある添字以降で項ごとに一致するなら、一方の箱の大きさの極限を
他方へ移せることだけを述べる。ここが唯一の ℝ への脱出であり、使うのは
`Filter.Tendsto` の eventually equal な写像に対する合同だけである。
-/
import Mathlib.Topology.Instances.Real.Lemmas

namespace Ising3DCut.LimitQuantity

open Filter Topology

/-- ある添字以降で項ごとに一致する二つの実数列について、一方が `ℓ` へ収束すれば
他方も同じ `ℓ` へ収束する。 -/
theorem tailAgreement_tendsto (a b : ℕ → ℝ)
    (hTail : ∃ N : ℕ, ∀ n : ℕ, N ≤ n → a n = b n) (ℓ : ℝ)
    (ha : Tendsto a atTop (𝓝 ℓ)) : Tendsto b atTop (𝓝 ℓ) := by
  obtain ⟨N, hN⟩ := hTail
  apply ha.congr'
  filter_upwards [eventually_ge_atTop N] with n hn
  exact hN n hn

end Ising3DCut.LimitQuantity
