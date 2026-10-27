import Ising2DLambda.KacWard.ShortPairRotationPhaseNonzero
import Ising2DLambda.NecSuf.KacWard.SourceDirectionBijection

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

theorem sourceDirection_bijective_from_necSuf {L : ℕ} [NeZero L] :
    Function.Bijective (fun e : OrientedEdge L =>
      (orientedSource e, directionNumber e)) := by
  have hcover : ∀ v d, ∃ e : OrientedEdge L,
      orientedSource e = v ∧ directionNumber e = d := by
    intro v d
    obtain ⟨e, he⟩ := sourceDirection_surjective (v, d)
    exact ⟨e, congrArg Prod.fst he, congrArg Prod.snd he⟩
  have hcard : Fintype.card (OrientedEdge L) =
      Fintype.card (Vertex L × ZMod 4) := by
    rw [show Fintype.card (OrientedEdge L) = Fintype.card (Edge L) * 2 by
      change Fintype.card (Edge L × Bool) = Fintype.card (Edge L) * 2
      rw [Fintype.card_prod, Fintype.card_bool],
      show Fintype.card (Vertex L × ZMod 4) = L ^ 2 * 4 by
        simp [Fintype.card_prod, card_vertex, ZMod.card], card_edge]
    ring
  exact Ising2DLambda.NecSuf.KacWard.sourceDirection_bijective_necSuf
    orientedSource directionNumber hcover hcard

end Ising2DLambda.KacWard
