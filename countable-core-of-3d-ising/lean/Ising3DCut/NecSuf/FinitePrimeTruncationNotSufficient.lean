/-
「有限個の素数での指数だけを見る粗視化は箱サイズ極限の一致に十分でない」の Lean 必要十分版。

具体版（`Ising3DCut/LimitQuantity/FinitelyManyPrimesNotSufficient.lean`）と手順を同じにしたまま、
仮定を具体版の証明が実際に使っている性質だけへ削る。具体版が使ったのは次の三つである。

* 「素数は無限に多く存在する」——ここでは述語 `P` について、どの有限集合の外にも
  `P` を満たす添字が残ることだけを仮定する（素数であること・自然数であることは使っていない）。
* 「切り詰めた座標の上では二つの座標データが一致する」——付値が 0 であることは使わず、
  一致だけを仮定する。
* 「二つの値が異なる」——`1 ≠ r` の具体的な理由は使わず、相異なることだけを仮定する。

削れなかった仮定は `TopologicalSpace X` だけである。定数列の収束（`tendsto_const_nhds`）を
述べるために位相が要る。正の実数であること・乗根であること・Hausdorff 性は使っていない。
-/
import Mathlib.Topology.Order
import Mathlib.Topology.Basic
import Mathlib.Order.Filter.AtTopBot.Defs
import Mathlib.Topology.Constructions

namespace Ising3DCut.NecSuf

open Filter Topology

/-- 有限個の座標への切り詰めは、切り詰めの外に証人が残る限り、値を決めない。

`S` は切り詰めて残す座標の有限集合、`P` は証人が満たす性質、`data r` と `base` は
座標データ、`f` は座標データから値を作る写像である。 -/
theorem finite_coordinate_truncation_not_sufficient
    {I D X : Type*} [TopologicalSpace X]
    (S : Finset I) (P : I → Prop)
    (hP : ∃ r, P r ∧ r ∉ S)
    (base : I → D) (data : I → I → D) (f : (I → D) → X)
    (hagree : ∀ r, P r → r ∉ S → ∀ p ∈ S, base p = data r p)
    (hsep : ∀ r, P r → r ∉ S → f base ≠ f (data r)) :
    ∃ r, P r ∧ r ∉ S ∧ (∀ p ∈ S, base p = data r p) ∧
      Tendsto (fun _ : ℕ => f base) atTop (𝓝 (f base)) ∧
      Tendsto (fun _ : ℕ => f (data r)) atTop (𝓝 (f (data r))) ∧
      f base ≠ f (data r) := by
  -- 具体版の「`S` は有限集合なので `S` に属さない素数 `r` が存在する」の段。
  obtain ⟨r, hPr, hrS⟩ := hP
  refine ⟨r, hPr, hrS, hagree r hPr hrS, tendsto_const_nhds, tendsto_const_nhds,
    hsep r hPr hrS⟩

end Ising3DCut.NecSuf
