import Ising2DLambda.KacWard.EdgeModeIndexBijection

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

def FourierModePair (L : ℕ) (s : SpinStructure) :=
  {p : Qbar × Qbar // p.1 ∈ horizontalTwistedModes L s ∧
    p.2 ∈ verticalTwistedModes L s}

noncomputable instance fourierModePairFintype {L : ℕ} [NeZero L]
    (s : SpinStructure) : Fintype (FourierModePair L s) := by
  classical
  obtain ⟨hU, hW, _, _⟩ := modeIndex_card_data (L := L) s
  have h : (horizontalTwistedModes L s ×ˢ verticalTwistedModes L s).Finite :=
    hU.prod hW
  exact h.fintype

noncomputable instance fourierModePairOrder {L : ℕ} [NeZero L]
    (s : SpinStructure) : LinearOrder (FourierModePair L s) := by
  classical
  exact LinearOrder.lift' (Fintype.equivFin (FourierModePair L s))
    (Fintype.equivFin (FourierModePair L s)).injective

def fourierModeBlockIndex {L : ℕ} (s : SpinStructure)
    (κ : OrientedEdge L ≃ {m // m ∈ fourierModeIndexSet L s})
    (e : OrientedEdge L) : FourierModePair L s :=
  ⟨((κ e).val.1, (κ e).val.2.1), (κ e).property⟩

theorem fourierModeBlockIndex_eq_iff {L : ℕ} (s : SpinStructure)
    (κ : OrientedEdge L ≃ {m // m ∈ fourierModeIndexSet L s})
    (e f : OrientedEdge L) :
    fourierModeBlockIndex s κ e = fourierModeBlockIndex s κ f ↔
      ((κ e).val.1, (κ e).val.2.1) = ((κ f).val.1, (κ f).val.2.1) := by
  constructor
  · intro h
    exact congrArg Subtype.val h
  · intro h
    exact Subtype.ext h

end Ising2DLambda.KacWard
