/-
「粗視化 $q\mapsto\varepsilon_{L,q}(\mathcal Z_L)$ は極限量に対して十分である」の Lean 必要十分版。

具体版（`PartitionValueCoarseGrainingSufficient.lean`）は分配多項式の有理点での値 $\pi_L(q)=Z_L(q)$ を
粗視化とし、素指数データからの復元と実数乗根の極限を使うが、本質は次の二つだけである。
- 粗視化であること：添字 $i$ ごとの写像 $\pi$ が、有限箱のデータ $D_q(i)$ だけで決まること
  （`hπ : D_q(i) = D_{q'}(i) → π_q(i) = π_{q'}(i)`）。
- 十分性：極限量の入力となる値の列 $Z_q(i)$ が粗視化の値 $\pi_q(i)$ だけで決まること
  （`hZ : π_q(i) = π_{q'}(i) → Z_q(i) = Z_{q'}(i)`）。このとき既存の必要十分版
  `limitQuantity_eq_of_data_eq` において $D:=C$、$D_q:=\pi_q$ と置いたものがそのまま十分性である。
実数側は位相空間 $X$ と任意のフィルタ $F$ に沿った `Tendsto`。値の一致には Hausdorff 性と `NeBot` だけが要る。
-/
import Ising3DCut.LimitQuantity.LimitQuantityDeterminedBySequenceAbstract

namespace Ising3DCut.LimitQuantity

open Filter Topology

variable {ι Q D C X : Type*}

/-- 粗視化であること（必要十分版）：`π` がデータ `Dseq` で決まるなら、データの一致から
粗視化の値の一致が従う。仮定は決定性 `hπ` だけである。 -/
theorem coarseGraining_eq_of_data_eq (Dseq : Q → ι → D) (π : Q → ι → C)
    (hπ : ∀ q q' i, Dseq q i = Dseq q' i → π q i = π q' i)
    (q q' : Q) (i : ι) (hD : Dseq q i = Dseq q' i) : π q i = π q' i :=
  hπ q q' i hD

/-- 十分性（存在）：粗視化の値が項ごとに一致し、値の列が粗視化で決まるなら、
一方が $x$ へ収束するとき他方も $x$ へ収束する。 -/
theorem limitQuantity_tendsto_of_coarseGraining_eq [TopologicalSpace X] (F : Filter ι)
    (π : Q → ι → C) (Z : Q → ι → X)
    (hZ : ∀ q q' i, π q i = π q' i → Z q i = Z q' i)
    (q q' : Q) (hπ : ∀ i, π q i = π q' i) (x : X)
    (h : Tendsto (Z q) F (𝓝 x)) : Tendsto (Z q') F (𝓝 x) :=
  limitQuantity_tendsto_of_data_eq F π Z hZ q q' hπ x h

/-- 十分性（値の一致）：$X$ が Hausdorff でフィルタが自明でなければ、粗視化の値が項ごとに一致する
二点の極限量は等しい。 -/
theorem limitQuantity_eq_of_coarseGraining_eq [TopologicalSpace X] [T2Space X] (F : Filter ι) [F.NeBot]
    (π : Q → ι → C) (Z : Q → ι → X)
    (hZ : ∀ q q' i, π q i = π q' i → Z q i = Z q' i)
    (q q' : Q) (hπ : ∀ i, π q i = π q' i) (x x' : X)
    (h : Tendsto (Z q) F (𝓝 x)) (h' : Tendsto (Z q') F (𝓝 x')) : x = x' :=
  limitQuantity_eq_of_data_eq F π Z hZ q q' hπ x x' h h'

end Ising3DCut.LimitQuantity
