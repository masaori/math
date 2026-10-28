import Ising2DLambda.KacWard.EdgeModeIndexBijection
import Ising2DLambda.KacWard.FourierModeBlockEntries

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

theorem fourierModeBlock_off_fiber_zero {L : ℕ} [DecidableEq Qbar]
    (z : Qbar) (s : SpinStructure)
    (κ : OrientedEdge L ≃ {m // m ∈ fourierModeIndexSet L s})
    (g h : OrientedEdge L)
    (hneq : fourierModeBlockIndex s κ g ≠ fourierModeBlockIndex s κ h) :
    (1 - (Polynomial.X : QbarPoly) • (modeBlockMatrix z s κ).map Polynomial.C) g h = 0 := by
  have hm : ((κ g).val.1, (κ g).val.2.1) ≠
      ((κ h).val.1, (κ h).val.2.1) := by
    intro heq
    exact hneq ((fourierModeBlockIndex_eq_iff s κ g h).2 heq)
  rw [fourier_mode_block_entries]
  simp [hm]

end Ising2DLambda.KacWard
