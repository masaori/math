/-
「極限量が有限箱の列だけの関数であること」の Lean 具体版・実数側の段。

**ここが唯一の ℝ への脱出（箱の大きさの極限）である。**
可算側の三歩で $Z_L(q)=Z_L(q')$ が全 $L$ で得られたあと、実数列
$L\mapsto Z_L(q)^{1/\#V_L}$ と $L\mapsto Z_L(q')^{1/\#V_L}$ は項ごとに等しい。
本ファイルは、項ごとに等しい二つの実数列は極限の有無・値を共有し、極限は一意である、
という一般命題だけを述べる（分配多項式そのものは登場しない。可算側からは
「項ごとの等式」だけを受け取る）。
-/
import Mathlib.Topology.Instances.Real.Lemmas

namespace Ising3DCut.LimitQuantity

open Filter Topology

/-- 項ごとに等しい実数列は、同じ値へ収束するかどうかが一致する。 -/
theorem tendsto_iff_of_pointwise_eq (a b : ℕ → ℝ) (hab : ∀ n, a n = b n) (ℓ : ℝ) :
    Tendsto a atTop (𝓝 ℓ) ↔ Tendsto b atTop (𝓝 ℓ) := by
  have h : a = b := funext hab
  rw [h]

/-- 実数列の極限は一意である。 -/
theorem limit_unique (a : ℕ → ℝ) (ℓ ℓ' : ℝ)
    (h : Tendsto a atTop (𝓝 ℓ)) (h' : Tendsto a atTop (𝓝 ℓ')) : ℓ = ℓ' :=
  tendsto_nhds_unique h h'

/-- 二つの列が項ごとに等しく、それぞれ極限を持つなら、その極限は等しい。 -/
theorem limit_eq_of_pointwise_eq (a b : ℕ → ℝ) (hab : ∀ n, a n = b n) (ℓ ℓ' : ℝ)
    (ha : Tendsto a atTop (𝓝 ℓ)) (hb : Tendsto b atTop (𝓝 ℓ')) : ℓ = ℓ' :=
  limit_unique b ℓ ℓ' ((tendsto_iff_of_pointwise_eq a b hab ℓ).1 ha) hb

end Ising3DCut.LimitQuantity
