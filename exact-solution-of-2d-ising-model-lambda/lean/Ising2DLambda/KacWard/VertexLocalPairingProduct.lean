import Ising2DLambda.KacWard.LocalPairingChoiceCount
import Ising2DLambda.KacWard.VertexPortBijection

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial Ising2DLambda.TransferMatrix

def selectedPortNumbers {L : ℕ} [NeZero L] (P : Finset (Edge L))
    (v : Vertex L) : Finset (Fin 4) :=
  (Finset.univ.filter (fun e : OrientedEdge L =>
    orientedSource e = v ∧ e.1 ∈ P)).image
      (fun e => (ZMod.finEquiv 4).symm (directionNumber e))

def vertexLocalPairingChoices {L : ℕ} [NeZero L]
    (P : Finset (Edge L)) : Finset (Vertex L → Fin 4 → Fin 4) :=
  Fintype.piFinset (fun v => localPairingChoices (selectedPortNumbers P v))

theorem vertexLocalPairingChoices_mem_iff {L : ℕ} [NeZero L]
    (P : Finset (Edge L)) (κ : Vertex L → Fin 4 → Fin 4) :
    κ ∈ vertexLocalPairingChoices P ↔
      ∀ v : Vertex L, κ v ∈ localPairingChoices (selectedPortNumbers P v) := by
  classical
  exact Fintype.mem_piFinset

theorem vertexLocalPairingChoices_card {L : ℕ} [NeZero L]
    (P : Finset (Edge L)) :
    (vertexLocalPairingChoices P).card =
      ∏ v : Vertex L, (localPairingChoices (selectedPortNumbers P v)).card := by
  classical
  exact Fintype.card_piFinset _

end Ising2DLambda.KacWard
