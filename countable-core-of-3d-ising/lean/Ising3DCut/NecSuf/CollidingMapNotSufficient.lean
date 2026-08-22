/-
「値の衝突を持つ粗視化は箱サイズ極限の一致に十分でない」の Lean 必要十分版。

具体版（`Ising3DCut/LimitQuantity/CollidingCoarseGrainingNotSufficient.lean`）と
手順を同じにしたまま、仮定を具体版の証明が実際に使っている性質だけへ削る。
具体版が使ったのは次の二つである。

* 「粗視化の値が衝突する二つの値がある」——値が正の有理数であること・粗視化の行き先が
  何であるかは使っていない。二点で値が等しいことだけを仮定する。
* 「二つの値に対応する極限値が異なる」——極限値が正の実数の乗根であること・乗根の一意性・
  定数列の乗根列が定数列であることは使っていない。相異なる二点であることだけを仮定する。

削れなかった仮定は `TopologicalSpace X` だけである。定数列の収束（`tendsto_const_nhds`）を
述べるために位相が要る。Hausdorff 性・順序・代数構造・正値性は使っていない。
-/
import Mathlib.Topology.Basic
import Mathlib.Topology.Constructions
import Mathlib.Order.Filter.AtTopBot.Defs

namespace Ising3DCut.NecSuf

open Filter Topology

/-- 粗視化 `π` が二つの値 `u`, `w` で衝突し、その二つに対応する値 `val` が異なるなら、
二つの定数列は、すべての添字で粗視化の値が一致するのに、異なる二点へ収束する。

`V` は粗視化の入力の型、`S` は粗視化の行き先、`X` は極限が住む位相空間、
`val` は入力から極限が住む空間への写像である。 -/
theorem colliding_map_not_sufficient
    {V S X : Type*} [TopologicalSpace X]
    (π : V → S) (val : V → X) (u w : V)
    (hcol : π u = π w) (hne : val u ≠ val w) :
    (∀ _L : ℕ, π u = π w) ∧
      Tendsto (fun _L : ℕ => val u) atTop (𝓝 (val u)) ∧
      Tendsto (fun _L : ℕ => val w) atTop (𝓝 (val w)) ∧ val u ≠ val w :=
  -- 具体版の「衝突する二つの値をそのまま定数列に取る」「定数列の極限はその値である」
  -- 「二つの値が異なるので極限も異なる」の三段に 1 対 1 で対応する。
  ⟨fun _ => hcol, tendsto_const_nhds, tendsto_const_nhds, hne⟩

end Ising3DCut.NecSuf
