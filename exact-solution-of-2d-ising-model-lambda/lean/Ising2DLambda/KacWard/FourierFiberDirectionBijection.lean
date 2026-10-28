import Ising2DLambda.KacWard.FourierModePairIndex

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

/- `claim_fourier_fiber_direction_bijection`: κ の第三成分を方向へ送り、
   逆には固定したモードの二成分と方向を κ.symm へ渡す。 -/
def fourierFiberDirectionEquiv {L : ℕ} (s : SpinStructure)
    (κ : OrientedEdge L ≃ {m // m ∈ fourierModeIndexSet L s})
    (m : FourierModePair L s) :
    {e : OrientedEdge L // fourierModeBlockIndex s κ e = m} ≃ ZMod 4 where
  toFun e := (κ e.1).val.2.2
  invFun d := ⟨κ.symm ⟨(m.1.1, m.1.2, d), m.2⟩, by
    apply Subtype.ext
    simp [fourierModeBlockIndex]⟩
  left_inv e := by
    apply Subtype.ext
    have hm := e.2
    apply κ.injective
    apply Subtype.ext
    have hpair := congrArg Subtype.val hm
    rcases e with ⟨e, he⟩
    simp only at hpair
    obtain ⟨hfirst, hsecond⟩ := Prod.mk.inj hpair
    simp only [Equiv.apply_symm_apply]
    change (m.1.1, m.1.2, (κ e).val.2.2) = (κ e).val
    exact Prod.ext hfirst.symm (Prod.ext hsecond.symm rfl)
  right_inv d := by
    simp

end Ising2DLambda.KacWard
