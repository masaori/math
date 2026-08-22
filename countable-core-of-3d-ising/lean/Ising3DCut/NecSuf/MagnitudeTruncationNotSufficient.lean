/-
「素指数を大きさで切り詰める粗視化は箱サイズ極限の一致に十分でない」の Lean 必要十分版。

具体版（`Ising3DCut/LimitQuantity/MagnitudeTruncatedPrimeExponentsNotSufficient.lean`）と
手順を同じにしたまま、仮定を具体版の証明が実際に使っている性質だけへ削る。
具体版が使ったのは次の三つである。

* 「切り詰めた座標データが、すべての座標で一致する」——切り詰めが大きさによる `min` であること・
  座標が素数であること・値が整数であることは使っていない。座標ごとの一致だけを仮定する。
* 「ある一つの座標では、切り詰める前の値が一致しない」——その座標が素数 2 であることも、
  値が `N` と `N+1` であることも使っていない。相異なることだけを仮定する。
* 「二つの極限値が異なる」——極限値が 2 のべきであること・正の実数の乗根であることは
  使っていない。相異なる二点であることだけを仮定する。

削れなかった仮定は `TopologicalSpace X` だけである。定数列の収束（`tendsto_const_nhds`）を
述べるために位相が要る。Hausdorff 性・順序・代数構造は使っていない。
-/
import Mathlib.Topology.Basic
import Mathlib.Topology.Constructions
import Mathlib.Order.Filter.AtTopBot.Defs

namespace Ising3DCut.NecSuf

open Filter Topology

/-- 座標ごとに切り詰めたデータが一致していても、切り詰める前に相異なる座標が残っているなら、
切り詰めたデータは値を決めない。

`t` は座標の値を切り詰める写像、`a` と `b` は座標データ、`i₀` は切り詰める前の値が
一致しない座標、`x` と `y` は二つのデータに対応する値である。 -/
theorem truncated_coordinate_data_not_sufficient
    {ι V W X : Type*} [TopologicalSpace X]
    (t : V → W) (a b : ι → V) (i₀ : ι) (x y : X)
    (hagree : ∀ i, t (a i) = t (b i))
    (hsep : a i₀ ≠ b i₀)
    (hxy : x ≠ y) :
    (∀ i, t (a i) = t (b i)) ∧ a i₀ ≠ b i₀ ∧
      Tendsto (fun _ : ℕ => x) atTop (𝓝 x) ∧
      Tendsto (fun _ : ℕ => y) atTop (𝓝 y) ∧ x ≠ y :=
  -- 具体版の「切り詰めた素指数はすべての素数で一致する」「素数 2 では一致しない」
  -- 「二つの定数列がそれぞれ収束する」「二つの極限値が異なる」の四段に 1 対 1 に対応する。
  ⟨hagree, hsep, tendsto_const_nhds, tendsto_const_nhds, hxy⟩

end Ising3DCut.NecSuf
