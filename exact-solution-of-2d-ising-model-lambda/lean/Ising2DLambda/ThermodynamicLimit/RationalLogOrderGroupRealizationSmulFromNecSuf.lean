/-
「実現写像は有理数倍と可換である」の具体版を、必要十分版 `realizeWith_smul_necSuf` の特殊化として導く。
渡すのは `K := ℚ`、`R := ℝ`、`ι := ι_{ℚ→ℝ}`（型強制。乗法保存は `Rat.cast_mul`、`ι 0 = 0` は `Rat.cast_zero`）、
重み `w p := log_ℝ(ι p)` だけである。具体版の `ρ_ℝ` は必要十分版の `realizeWith` と `rfl` で一致する。
-/
import Ising2DLambda.ThermodynamicLimit.RationalLogOrderGroupRealizationSmul
import Ising2DLambda.NecSuf.ThermodynamicLimit.RationalLogOrderGroupRealizationSmul

namespace Ising2DLambda.ThermodynamicLimit

/-- `ρ_ℝ` は必要十分版の `realizeWith` の特殊化である。 -/
theorem realizeRational_eq_realizeWith (μ : RationalLogOrderGroup) :
    realizeRational μ =
      NecSuf.ThermodynamicLimit.realizeWith (fun r : ℚ => (r : ℝ))
        (fun p => realLog (primePositiveReal p)) μ := rfl

theorem realizeRational_smul_from_necSuf (r : ℚ) (μ : RationalLogOrderGroup) :
    realizeRational (r • μ) = (r : ℝ) * realizeRational μ := by
  rw [realizeRational_eq_realizeWith, realizeRational_eq_realizeWith]
  exact NecSuf.ThermodynamicLimit.realizeWith_smul_necSuf (fun r : ℚ => (r : ℝ))
    (fun a b => Rat.cast_mul a b) Rat.cast_zero (fun p => realLog (primePositiveReal p)) r μ

end Ising2DLambda.ThermodynamicLimit
