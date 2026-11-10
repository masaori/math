import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- Three bijections through two edge representations identify the two finite families. -/
theorem cell_subset_graph_even_edge_card
    {CellSubsets GridEven EncodedEven GraphEven : Type*}
    (boundary : CellSubsets → GridEven)
    (encode : GridEven → EncodedEven)
    (graph : EncodedEven → GraphEven)
    (hboundary : Function.Bijective boundary)
    (hencode : Function.Bijective encode)
    (hgraph : Function.Bijective graph) :
    Nat.card GraphEven = Nat.card CellSubsets := by
  calc
    Nat.card GraphEven = Nat.card EncodedEven :=
      (Nat.card_congr (Equiv.ofBijective graph hgraph)).symm
    _ = Nat.card GridEven :=
      (Nat.card_congr (Equiv.ofBijective encode hencode)).symm
    _ = Nat.card CellSubsets :=
      (Nat.card_congr (Equiv.ofBijective boundary hboundary)).symm

end Ising2DLambda.NecSuf.KacWard
