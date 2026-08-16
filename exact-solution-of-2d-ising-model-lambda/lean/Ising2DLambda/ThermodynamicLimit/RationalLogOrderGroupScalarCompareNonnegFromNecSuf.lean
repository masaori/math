/- 必要十分版を具体的な `Λ_ℚ`（`K := ℚ`、`X := RationalLogOrderGroup`、`le := rationalLogOrderLE`）へ
特殊化する。(1) は `rationalLogOrderLE_ratSmul_of_nonneg`、(2) は `rationalLogOrderLE_add_right`。 -/
import Ising2DLambda.ThermodynamicLimit.RationalLogOrderGroupScalarCompareNonneg
import Ising2DLambda.NecSuf.ThermodynamicLimit.RationalLogOrderGroupScalarCompareNonneg

namespace Ising2DLambda.ThermodynamicLimit

theorem rationalLogOrderLE_ratSmul_le_ratSmul_of_le_from_necSuf {r s : ℚ} (hrs : r ≤ s)
    {ν : RationalLogOrderGroup} (hν : rationalLogOrderLE 0 ν) :
    rationalLogOrderLE (r • ν) (s • ν) :=
  NecSuf.ThermodynamicLimit.smul_le_smul_of_le_of_nonneg_necSuf rationalLogOrderLE
    (fun _c hc _x _y hxy => rationalLogOrderLE_ratSmul_of_nonneg hc hxy)
    (fun _x _y z hxy => rationalLogOrderLE_add_right hxy z) hrs hν

end Ising2DLambda.ThermodynamicLimit
