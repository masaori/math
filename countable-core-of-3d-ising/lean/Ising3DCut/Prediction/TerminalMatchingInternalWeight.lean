/-
本文 `claim_two_dimensional_boundary_response_pfaffian_prediction` の証明にある
「この対応では、選ばれていない辺に対応する外部辺だけが完全マッチングへ入り、
内部辺の重みはすべて 1 である」という段の Lean 具体版。

これまで仮定として受け取っていた「完全マッチングの重みが対応する偶部分グラフの
補集合上の積に等しいこと」を、terminal graph の重みの置き方から導く段である。
すなわち、内部辺の重みが 1 であることから完全マッチングの重みが外部辺の部分だけの
積に落ち、さらに外部辺が元の辺と単射に対応することから、元の辺の集合上の積になる。

terminal graph の具体的な形（各頂点をどう分解するか、どの内部辺を張るか）はここでは
使わない。使うのは「内部辺の重みが 1」「外部辺は元の辺と単射に対応し、その重みが
`(1 + x) / (1 - x)`」という二つの置き方だけである。
-/
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Algebra.Order.Field.Basic

namespace Ising3DCut.Prediction

open scoped BigOperators

/-- 内部辺の重みがすべて 1 なら、完全マッチングの重みは外部辺の部分だけの積に等しい。 -/
theorem terminalMatching_weight_eq_externalPart_prod
    {TerminalEdge R : Type*} [DecidableEq TerminalEdge] [CommRing R]
    (matching external : Finset TerminalEdge) (weight : TerminalEdge → R)
    (hInternal : ∀ edge ∈ matching, edge ∉ external → weight edge = 1) :
    ∏ edge ∈ matching, weight edge = ∏ edge ∈ matching ∩ external, weight edge := by
  refine (Finset.prod_subset Finset.inter_subset_left ?_).symm
  intro edge hEdge hNotInter
  refine hInternal edge hEdge ?_
  intro hExternal
  exact hNotInter (Finset.mem_inter.mpr ⟨hEdge, hExternal⟩)

/-- 完全マッチングの外部辺の部分が、選ばれていない辺の集合の単射な像であるとき、
完全マッチングの重みは選ばれていない辺の上の `(1 + x) / (1 - x)` の積に等しい。 -/
theorem terminalMatching_weight_eq_unselectedEdges_prod
    {Edge TerminalEdge K : Type*} [DecidableEq Edge] [DecidableEq TerminalEdge] [Field K]
    (A F matching : Finset Edge) (externalEdge : Edge → TerminalEdge)
    (terminalMatching external : Finset TerminalEdge) (weight : TerminalEdge → K)
    (x : Edge → K)
    (hInternal : ∀ edge ∈ terminalMatching, edge ∉ external → weight edge = 1)
    (hExternalWeight : ∀ edge : Edge, weight (externalEdge edge) = (1 + x edge) / (1 - x edge))
    (hInjective : ∀ edge ∈ A \ F, ∀ edge' ∈ A \ F,
      externalEdge edge = externalEdge edge' → edge = edge')
    (hMatching : matching = A \ F)
    (hImage : terminalMatching ∩ external = (A \ F).image externalEdge) :
    ∏ edge ∈ terminalMatching, weight edge =
      ∏ edge ∈ matching, ((1 + x edge) / (1 - x edge)) := by
  calc
    ∏ edge ∈ terminalMatching, weight edge
        = ∏ edge ∈ terminalMatching ∩ external, weight edge :=
      terminalMatching_weight_eq_externalPart_prod terminalMatching external weight hInternal
    _ = ∏ edge ∈ (A \ F).image externalEdge, weight edge := by rw [hImage]
    _ = ∏ edge ∈ A \ F, weight (externalEdge edge) :=
      Finset.prod_image fun edge hEdge edge' hEdge' hEq =>
        hInjective edge hEdge edge' hEdge' hEq
    _ = ∏ edge ∈ A \ F, ((1 + x edge) / (1 - x edge)) :=
      Finset.prod_congr rfl fun edge _ => hExternalWeight edge
    _ = ∏ edge ∈ matching, ((1 + x edge) / (1 - x edge)) := by rw [hMatching]

end Ising3DCut.Prediction
