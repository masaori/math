/-
「有限個の値しかとらない列が極限を持つなら末尾定数である」の Lean 必要十分版。

具体版が実際に使うのは、Hausdorff 位相空間に値を持つ自然数列、列の値域の有限性、
および列の極限だけである。Ising 模型・有理数・実数・正の乗根・箱の点数は使わない。

削れなかった仮定：`T2Space` は、無限回現れる値と列の極限の一意性に必要である。
-/
import Mathlib.Topology.Sequences

namespace Ising3DCut.NecSuf

open Filter Topology

/-- 収束列で、ある値をとる添字集合が無限なら、その値は列の極限に等しい。 -/
theorem eqLimit_of_infiniteLevelSet
    {X : Type*} [TopologicalSpace X] [T2Space X]
    {a : ℕ → X} {α v : X}
    (hlimit : Tendsto a atTop (nhds α))
    (hinf : {L : ℕ | a L = v}.Infinite) :
    v = α := by
  by_contra hne
  obtain ⟨U, V, hU, hV, hvU, haV, hdisj⟩ := t2_separation hne
  have hev : ∀ᶠ L in atTop, a L ∈ V := hlimit (hV.mem_nhds haV)
  have hfr : ∃ᶠ L in atTop, a L = v := by
    rw [Filter.frequently_atTop]
    intro n
    obtain ⟨L, hL, hnL⟩ := hinf.exists_gt n
    exact ⟨L, le_of_lt hnL, hL⟩
  obtain ⟨L, hLv, hLV⟩ := (hfr.and_eventually hev).exists
  exact Set.disjoint_left.mp hdisj hvU (hLv ▸ hLV)

/-- Hausdorff 空間への自然数列が有限個の値しかとらず収束するなら、末尾で極限値に等しい。 -/
theorem finiteRangeConvergent_eventuallyConstant
    {X : Type*} [TopologicalSpace X] [T2Space X]
    {a : ℕ → X} {α : X}
    (hlimit : Tendsto a atTop (nhds α))
    (hfin : (Set.range a).Finite) :
    ∃ L0 : ℕ, ∀ L, L0 ≤ L → a L = α := by
  have hE : {L : ℕ | a L ≠ α}.Finite := by
    have hsub : {L : ℕ | a L ≠ α} ⊆
        ⋃ v ∈ (Set.range a \ {α}), {L : ℕ | a L = v} := by
      intro L hL
      exact Set.mem_biUnion ⟨⟨L, rfl⟩, hL⟩ rfl
    refine Set.Finite.subset (Set.Finite.biUnion hfin.diff (fun v hv => ?_)) hsub
    by_contra hinf
    exact hv.2 (by simpa using eqLimit_of_infiniteLevelSet hlimit hinf)
  obtain ⟨M, hM⟩ := hE.bddAbove
  refine ⟨M + 1, fun L hL => ?_⟩
  by_contra hne
  have hLM : L ≤ M := hM hne
  omega

end Ising3DCut.NecSuf
