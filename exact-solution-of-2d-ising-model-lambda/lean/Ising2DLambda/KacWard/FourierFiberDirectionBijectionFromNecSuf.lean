import Ising2DLambda.KacWard.FourierFiberDirectionBijection
import Ising2DLambda.NecSuf.KacWard.FourierFiberDirectionBijection

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

def fourierModeIndexPairEquiv {L : ℕ} (s : SpinStructure) :
    {u // u ∈ fourierModeIndexSet L s} ≃ FourierModePair L s × ZMod 4 where
  toFun u := (⟨(u.val.1, u.val.2.1), u.property⟩, u.val.2.2)
  invFun p := ⟨(p.1.val.1, p.1.val.2, p.2), p.1.property⟩
  left_inv u := by
    apply Subtype.ext
    rfl
  right_inv p := by
    apply Prod.ext
    · apply Subtype.ext
      rfl
    · rfl

/- 抽象版の直積添字を、具体的なねじれモードと方向の添字へ戻す。 -/
theorem fourier_fiber_direction_bijective_from_necSuf {L : ℕ}
    (s : SpinStructure)
    (κ : OrientedEdge L ≃ {u // u ∈ fourierModeIndexSet L s})
    (m : FourierModePair L s) :
    Function.Bijective (fun e : {e : OrientedEdge L // fourierModeBlockIndex s κ e = m} =>
      (κ e.1).val.2.2) := by
  let κ' := κ.trans (fourierModeIndexPairEquiv s)
  have h := (Ising2DLambda.NecSuf.KacWard.fiberDirectionEquiv κ' m).bijective
  exact h

end Ising2DLambda.KacWard
