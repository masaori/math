/-
「極限量が有限箱の列だけの関数であること」の Lean 具体版・束ねの段。

可算側の三歩（`PartitionValuesAgreeFromSequence.lean`）で得た「全 $L$ で $Z_L(q)=Z_L(q')$」と
正値性を受け取り、乗根の段（`PositiveRealRootUnique.lean`）と極限の段
（`RealLimitOfEqualSequences.lean`）を一本に束ねる。
ここでは分配多項式そのものは登場せず、有限箱ごとの値の列 $Z,Z'\colon\mathbb N\to\mathbb R$ と
サイト数の列 $N\colon\mathbb N\to\mathbb N$ だけを受け取る。
**唯一の ℝ への脱出は最後の極限（`Tendsto`）である。**
-/
import Ising3DCut.LimitQuantity.PositiveRealRootUnique
import Ising3DCut.LimitQuantity.RealLimitOfEqualSequences

namespace Ising3DCut.LimitQuantity

open Filter Topology

/-- 有限箱の列 $L\mapsto Z_L^{1/\#V_L}$（正の乗根の列）。 -/
noncomputable def rootSeq (Z : ℕ → ℝ) (N : ℕ → ℕ) : ℕ → ℝ := fun L => posRoot (Z L) (N L)

/-- 有限箱ごとの値が全 $L$ で等しければ、乗根の列は項ごとに等しい。 -/
theorem rootSeq_eq_of_pointwise_eq (Z Z' : ℕ → ℝ) (N : ℕ → ℕ) (hZ : ∀ L, Z L = Z' L) :
    ∀ L, rootSeq Z N L = rootSeq Z' N L := by
  intro L
  unfold rootSeq
  exact posRoot_congr (Z L) (Z' L) (hZ L) (N L)

/-- 束ねの主張：有限箱ごとの値が全 $L$ で等しいなら、一方の乗根列が $\ell$ へ収束すれば
他方も同じ $\ell$ へ収束する（極限量の存在と値が有限箱の列だけで決まる）。 -/
theorem limitQuantity_tendsto_of_pointwise_eq (Z Z' : ℕ → ℝ) (N : ℕ → ℕ)
    (hZ : ∀ L, Z L = Z' L) (ℓ : ℝ) (h : Tendsto (rootSeq Z N) atTop (𝓝 ℓ)) :
    Tendsto (rootSeq Z' N) atTop (𝓝 ℓ) :=
  (tendsto_iff_of_pointwise_eq (rootSeq Z N) (rootSeq Z' N)
    (rootSeq_eq_of_pointwise_eq Z Z' N hZ) ℓ).1 h

/-- 束ねの主張（値の一致）：両者が極限を持てば、その極限は等しい。 -/
theorem limitQuantity_eq_of_pointwise_eq (Z Z' : ℕ → ℝ) (N : ℕ → ℕ)
    (hZ : ∀ L, Z L = Z' L) (ℓ ℓ' : ℝ)
    (h : Tendsto (rootSeq Z N) atTop (𝓝 ℓ)) (h' : Tendsto (rootSeq Z' N) atTop (𝓝 ℓ')) :
    ℓ = ℓ' :=
  limit_eq_of_pointwise_eq (rootSeq Z N) (rootSeq Z' N)
    (rootSeq_eq_of_pointwise_eq Z Z' N hZ) ℓ ℓ' h h'

end Ising3DCut.LimitQuantity
