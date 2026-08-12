/-
「自明セクターの偶部分グラフから配位を復元できる」の具体版のうち、復元した配位が
一つ得られたあとの個数計算。人手証明の末尾と同じく、全スピン反転による二つの原像を
作り、同じ破れた辺集合の一意性で他の原像を排除する。

基点からの道和によって原像を構成する部分は、続く tick でこのファイルへ加える。
-/
import Ising2DLambda.FisherZero.DualBrokenEdgesWinding
import Ising2DLambda.FisherZero.LowTemperaturePolynomial
import Ising2DLambda.NecSuf.FisherZero.TrivialSectorConfigurationReconstruction

namespace Ising2DLambda.FisherZero

open Finset Ising2DLambda.PartitionPolynomial

theorem globalSpinReversal_dualBrokenEdgeSet (L : ℕ) [NeZero L] (σ : Config L) :
    dualBrokenEdgeSet L (globalSpinReversal L σ) = dualBrokenEdgeSet L σ := by
  simp only [dualBrokenEdgeSet]
  rw [globalSpinReversal_brokenEdgeSet]

theorem sameDualBrokenEdges_eq_or_globalSpinReversal (L : ℕ) [NeZero L]
    (σ τ : Config L) (hdual : dualBrokenEdgeSet L τ = dualBrokenEdgeSet L σ) :
    τ = σ ∨ τ = globalSpinReversal L σ := by
  apply sameBrokenEdges_eq_or_globalSpinReversal L σ τ
  intro e
  have himage := Finset.ext_iff.mp hdual (dualEdgeEquiv L e)
  simpa only [mem_dualBrokenEdgeSet_iff, (dualEdgeEquiv L).symm_apply_apply,
    brokenEdgeSet, mem_filter, mem_univ, true_and] using himage.symm

/-- 復元した配位が一つ存在すれば、双対破れ像の原像はその配位と全反転の二つだけである。 -/
theorem trivialSectorConfiguration_fiber_card_two_of_exists
    (L : ℕ) [NeZero L] (A : Finset (Edge L))
    (hexists : ∃ σ : Config L, dualBrokenEdgeSet L σ = A) :
    (univ.filter fun σ : Config L => dualBrokenEdgeSet L σ = A).card = 2 := by
  obtain ⟨σ, hσ⟩ := hexists
  have h := Ising2DLambda.NecSuf.FisherZero.paired_fiber_card_two_necSuf
    (dualBrokenEdgeSet L) (globalSpinReversal L) σ
    (globalSpinReversal_ne_self L σ)
    (globalSpinReversal_dualBrokenEdgeSet L σ)
    (sameDualBrokenEdges_eq_or_globalSpinReversal L σ)
  simpa [hσ] using h

end Ising2DLambda.FisherZero
