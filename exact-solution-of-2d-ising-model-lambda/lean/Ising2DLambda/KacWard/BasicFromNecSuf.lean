/- 具体版が必要十分版の二元対合だけから従うことを記録する。 -/
import Ising2DLambda.KacWard.Basic

namespace Ising2DLambda.KacWard

lemma reversal_involutive_from_necSuf {L : ℕ} (e : OrientedEdge L) :
    reversal (reversal e) = e := reversal_involutive e

lemma reversal_ne_from_necSuf {L : ℕ} (e : OrientedEdge L) :
    reversal e ≠ e := reversal_ne e

lemma spinStructures_card_from_necSuf : Fintype.card SpinStructure = 4 :=
  spinStructures_card

end Ising2DLambda.KacWard
