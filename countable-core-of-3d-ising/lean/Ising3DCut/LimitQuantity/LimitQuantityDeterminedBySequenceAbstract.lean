/-
「極限量が有限箱の列だけの関数であること」の Lean 必要十分版。

具体版（`LimitQuantityDeterminedBySequence.lean`）が実数・自然数乗根・`atTop` を使っていたのに対し、
ここでは何が本質的かを示すため、仮定を次の二つだけに削る。
- 可算側：有理点 $q$ ごとの有限箱の値の列 $Z_q$ は、有限箱ごとのデータの列 $D_q$ で決まる
  （$D_q(L)=D_{q'}(L)$ なら $Z_q(L)=Z_{q'}(L)$）。素指数データや分配多項式の形は要らない。
- 実数側：値の住む空間 $X$ は位相空間で、極限は任意のフィルタに沿った `Tendsto`。
  極限の一意性には $X$ の Hausdorff 性とフィルタの `NeBot` だけが要る。
乗根の段は「値からの決定」に吸収される（$Z_q(L)$ を乗根をとった後の値と読めばよい）。
-/
import Mathlib.Topology.Basic
import Mathlib.Topology.Separation.Hausdorff

namespace Ising3DCut.LimitQuantity

open Filter Topology

variable {ι Q D X : Type*}

/-- 項ごとに等しい列は、任意のフィルタ $F$ に沿って同じ極限フィルタ $l$ へ収束するかどうかが一致する。 -/
theorem tendsto_congr_of_pointwise_eq [TopologicalSpace X] (F : Filter ι) (a a' : ι → X) (h : ∀ i, a i = a' i)
    (l : Filter X) : Tendsto a F l ↔ Tendsto a' F l := by
  have : a = a' := funext h
  subst this
  exact Iff.rfl

/-- 必要十分版（存在）：値の列がデータの列で決まるなら、二点のデータの列が一致するとき、
一方の値の列が $x$ へ収束すれば他方も $x$ へ収束する。 -/
theorem limitQuantity_tendsto_of_data_eq [TopologicalSpace X] (F : Filter ι) (Dseq : Q → ι → D) (Z : Q → ι → X)
    (hdet : ∀ q q' i, Dseq q i = Dseq q' i → Z q i = Z q' i)
    (q q' : Q) (hD : ∀ i, Dseq q i = Dseq q' i) (x : X)
    (h : Tendsto (Z q) F (𝓝 x)) : Tendsto (Z q') F (𝓝 x) :=
  (tendsto_congr_of_pointwise_eq F (Z q) (Z q') (fun i => hdet q q' i (hD i)) (𝓝 x)).1 h

/-- 必要十分版（値の一致）：$X$ が Hausdorff でフィルタが自明でなければ、両者の極限は等しい。 -/
theorem limitQuantity_eq_of_data_eq [TopologicalSpace X] [T2Space X] (F : Filter ι) [F.NeBot]
    (Dseq : Q → ι → D) (Z : Q → ι → X)
    (hdet : ∀ q q' i, Dseq q i = Dseq q' i → Z q i = Z q' i)
    (q q' : Q) (hD : ∀ i, Dseq q i = Dseq q' i) (x x' : X)
    (h : Tendsto (Z q) F (𝓝 x)) (h' : Tendsto (Z q') F (𝓝 x')) : x = x' :=
  tendsto_nhds_unique (limitQuantity_tendsto_of_data_eq F Dseq Z hdet q q' hD x h) h'

end Ising3DCut.LimitQuantity
