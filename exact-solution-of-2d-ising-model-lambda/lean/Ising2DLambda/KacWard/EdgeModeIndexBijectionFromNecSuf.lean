import Ising2DLambda.KacWard.EdgeModeIndexBijection
import Ising2DLambda.NecSuf.KacWard.EdgeModeIndexBijection

/- `claim_edge_mode_index_bijection` の導出版。
   具体的な二つのモード集合の濃度を、必要十分版の有限集合の仮定へ渡す。 -/

namespace Ising2DLambda.KacWard

theorem edgeModeIndex_equiv_exists_from_necSuf {L : ℕ} [NeZero L]
    (s : SpinStructure) :
    Nonempty (OrientedEdge L ≃ {m // m ∈ fourierModeIndexSet L s}) := by
  obtain ⟨hU, hW, hUcard, hWcard⟩ := modeIndex_card_data (L := L) s
  have hE : Fintype.card (OrientedEdge L) = 4 * L ^ 2 := by
    change Fintype.card (Ising2DLambda.PartitionPolynomial.Edge L × Bool) = 4 * L ^ 2
    rw [Fintype.card_prod, Ising2DLambda.PartitionPolynomial.card_edge, Fintype.card_bool]
    ring
  simpa only [fourierModeIndexSet,
    Ising2DLambda.NecSuf.KacWard.modeIndexSet] using
    (Ising2DLambda.NecSuf.KacWard.edgeModeIndex_equiv_exists_necSuf
      (horizontalTwistedModes L s) (verticalTwistedModes L s) L
      hU hW hUcard hWcard hE)

end Ising2DLambda.KacWard
