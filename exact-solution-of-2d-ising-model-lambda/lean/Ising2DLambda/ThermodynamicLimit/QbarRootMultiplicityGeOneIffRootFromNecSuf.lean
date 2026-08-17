/- 具体版が必要十分版の特殊化として得られることの導出（R := Q̄）。
必要十分版は重複度を経由せず「指数 1 以上の整除の存在」で述べているので、
最大元の読み取り 1・2（`qbarRootMultiplicity_divides` / `_ge_of_divides`）でその形と結ぶ。 -/
import Ising2DLambda.ThermodynamicLimit.QbarRootMultiplicityGeOneIffRoot
import Ising2DLambda.NecSuf.ThermodynamicLimit.QbarRootMultiplicityGeOneIffRoot

namespace Ising2DLambda.ThermodynamicLimit

open Ising2DLambda.AlgebraicEigenvalue

theorem qbarRootMultiplicityGeOneIffRoot_from_necSuf (w : Qbar) (f : QbarPoly) (hf : f ≠ 0) :
    1 ≤ qbarRootMultiplicity w f hf ↔ qbarPolyEval w f = 0 := by
  rw [qbarPolyEval_eq_eval]
  rw [← NecSuf.ThermodynamicLimit.poly_root_multiplicity_ge_one_iff_root_necSuf w f]
  constructor
  · intro hge
    exact ⟨qbarRootMultiplicity w f hf, hge,
      (qbarLinearFactorPowDivides_iff_dvd w _ f).mp (qbarRootMultiplicity_divides w f hf)⟩
  · intro h
    obtain ⟨k, hk, hdvd⟩ := h
    exact le_trans hk
      (qbarRootMultiplicity_ge_of_divides w f hf k
        ((qbarLinearFactorPowDivides_iff_dvd w k f).mpr hdvd))

end Ising2DLambda.ThermodynamicLimit
