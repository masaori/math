/-
「有限箱の等式の族は極限量の等式へ渡る」の Lean 必要十分版。

具体版（`FiniteBoxEqualitiesTransfer.lean`）は分配多項式・正の有理数・素指数データ・実数乗根を使うが、
本質は次の二つだけである。
- 可算側：添字 $i$（有限箱の大きさ）ごとに値の列 $Z_q$ と $Z_{q'}$ が一致すること。等式の族そのものが
  「有限箱ごとのデータ」の役を果たすので、素指数データを経由する段は要らない
  （既存の必要十分版 `limitQuantity_tendsto_of_data_eq` において $D:=X$、$D_q:=Z_q$ と置いたものに一致する）。
- 実数側：位相空間 $X$ と任意のフィルタ $F$ に沿った `Tendsto`。値の一致には Hausdorff 性と `NeBot` だけが要る。
-/
import Ising3DCut.LimitQuantity.LimitQuantityDeterminedBySequenceAbstract

namespace Ising3DCut.LimitQuantity

open Filter Topology

variable {ι Q X : Type*}

/-- 必要十分版（存在）：値の列が項ごとに一致すれば、一方が $x$ へ収束するとき他方も $x$ へ収束する。 -/
theorem limitQuantity_tendsto_of_family_eq [TopologicalSpace X] (F : Filter ι) (Z : Q → ι → X)
    (q q' : Q) (hZ : ∀ i, Z q i = Z q' i) (x : X)
    (h : Tendsto (Z q) F (𝓝 x)) : Tendsto (Z q') F (𝓝 x) :=
  limitQuantity_tendsto_of_data_eq F Z Z (fun _ _ _ e => e) q q' hZ x h

/-- 必要十分版（値の一致）：$X$ が Hausdorff でフィルタが自明でなければ、両者の極限は等しい。 -/
theorem limitQuantity_eq_of_family_eq [TopologicalSpace X] [T2Space X] (F : Filter ι) [F.NeBot]
    (Z : Q → ι → X) (q q' : Q) (hZ : ∀ i, Z q i = Z q' i) (x x' : X)
    (h : Tendsto (Z q) F (𝓝 x)) (h' : Tendsto (Z q') F (𝓝 x')) : x = x' :=
  limitQuantity_eq_of_data_eq F Z Z (fun _ _ _ e => e) q q' hZ x x' h h'

end Ising3DCut.LimitQuantity
