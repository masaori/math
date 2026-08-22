/-
「有限個の添字でしか成り立たない交差べき等式は箱サイズ極限の一致に十分でない」の
Lean 必要十分版。

具体版の証明が実際に使っているのは二つだけである。定数列と添字 1 以降の定数列が
それぞれ収束すること（位相空間であれば書ける）と、二つの値が異なること
（共終でないことを出す段で使う）。正の実数・乗根・単調性・Hausdorff 性は使っていない。
したがって台としては位相空間だけを仮定し、手順は具体版と同じく
「添字 0 での一致・添字 1 以降での不一致・二つの定数列の収束」の三段である。

削れなかった仮定：`TopologicalSpace` は `Tendsto … (nhds …)` を書くために要る。
`hpq : p ≠ q` は共終でないことの結論に必要である（`p = q` なら二列は一致し結論が偽になる）。
-/
import Mathlib.Topology.Order
import Mathlib.Order.Filter.AtTopBot.Basic

namespace Ising3DCut.NecSuf

open Filter Topology

/-- 必要十分版：添字 0 でだけ一致し、以降は異なる二つの定数値をとる列は、
一致する添字が共終でないのにそれぞれ収束する。 -/
theorem finitely_many_agreements_are_not_sufficient_abstract
    {G : Type*} [TopologicalSpace G] (p q : G) (hpq : p ≠ q)
    (x y : ℕ → G) (hx : ∀ L, x L = p) (hy0 : y 0 = p) (hy : ∀ L, L ≠ 0 → y L = q) :
    (∃ L, x L = y L) ∧ (¬ ∀ L1 : ℕ, ∃ L : ℕ, L1 ≤ L ∧ x L = y L) ∧
      Tendsto x atTop (nhds p) ∧ Tendsto y atTop (nhds q) := by
  refine ⟨⟨0, by rw [hx, hy0]⟩, ?_, ?_, ?_⟩
  · -- 具体版と同じ段：添字 1 以降では一致しないので共終でない。
    intro h
    obtain ⟨L, hL, hEq⟩ := h 1
    have hL0 : L ≠ 0 := Nat.one_le_iff_ne_zero.mp hL
    rw [hx, hy L hL0] at hEq
    exact hpq hEq
  · -- 具体版と同じ段：`x` は定数列。
    have hfun : x = fun _ : ℕ => p := funext hx
    rw [hfun]
    exact tendsto_const_nhds
  · -- 具体版と同じ段：`y` は添字 1 以降で定数。
    have hev : (fun _ : ℕ => q) =ᶠ[atTop] y := by
      filter_upwards [eventually_ge_atTop 1] with L hL
      exact (hy L (Nat.one_le_iff_ne_zero.mp hL)).symm
    exact Tendsto.congr' hev tendsto_const_nhds

end Ising3DCut.NecSuf
