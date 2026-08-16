/- 必要十分版を具体的な `Λ_ℚ`（`X := RationalLogOrderGroup`、`le := rationalLogOrderLE`）へ特殊化する。
(1) は `rationalLogOrderLE_trans`、(2) は `rationalLogOrderLE_ratSmul_of_nonneg`、
(3) は `rationalLogOrderLE_ratSmul_le_ratSmul_of_le`、結合則と単位は `mul_smul`・`one_smul`。 -/
import Ising2DLambda.ThermodynamicLimit.RationalLogOrderGroupDivGeMultiplierLe
import Ising2DLambda.NecSuf.ThermodynamicLimit.RationalLogOrderGroupDivGeMultiplierLe

namespace Ising2DLambda.ThermodynamicLimit

theorem rationalLogOrderLE_inv_natSmul_le_of_le_natSmul_from_necSuf {μ ε : RationalLogOrderGroup}
    (hε : rationalLogOrderLE 0 ε) {n a : ℕ} (ha : 1 ≤ a) (hna : n ≤ a)
    (hμ : rationalLogOrderLE μ ((n : ℚ) • ε)) :
    rationalLogOrderLE (((1 : ℚ) / a) • μ) ε :=
  NecSuf.ThermodynamicLimit.inv_smul_le_of_le_smul_necSuf rationalLogOrderLE
    (fun _x _y _z hxy hyz => rationalLogOrderLE_trans hxy hyz)
    (fun _c hc _x _y hxy => rationalLogOrderLE_ratSmul_of_nonneg hc hxy)
    (fun _r _s hrs _ν hν => rationalLogOrderLE_ratSmul_le_ratSmul_of_le hrs hν)
    (fun r s x => mul_smul r s x) (fun x => one_smul ℚ x) hε ha hna hμ

end Ising2DLambda.ThermodynamicLimit
