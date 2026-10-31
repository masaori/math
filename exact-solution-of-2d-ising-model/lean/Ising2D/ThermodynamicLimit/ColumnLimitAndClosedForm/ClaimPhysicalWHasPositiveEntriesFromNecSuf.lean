/-
# 具体的な `W` の成分の正値性を必要十分版の特殊化として導く

人手 `W_has_positive_entries`（`structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts`）。
具体版 `Ising2D/ThermodynamicLimit/ColumnLimitAndClosedForm/ClaimPhysicalWHasPositiveEntries.lean` の Step 3 の二つの主張が、
必要十分版 `Ising2D/NecSuf/SandwichByDiagonal.lean` の `B := V_1^{1/2}`・`V := V_2`・係数 `ℝ` での特殊化として得られることを示す。
特殊化に渡す仮定は、具体版の Step 1（`physicalV1halfR_offDiag`・`physicalV1halfR_apply_configBasisIso_self_pos`）と
Step 2（`physicalV2R_apply_configBasisIso_pos`）である。
-/
import Ising2D.ThermodynamicLimit.ColumnLimitAndClosedForm.ClaimPhysicalWHasPositiveEntries
import Ising2D.NecSuf.SandwichByDiagonal

namespace Ising2D

variable {M : ℕ}

/-- `physicalSymTransferR_apply_configBasisIso` は `NecSuf.sandwich_apply_of_offDiag_zero` の特殊化。 -/
theorem physicalSymTransferR_apply_configBasisIso_of_necSuf (K1 K2 : ℝ) (μ μ' : SpinConf M) :
    physicalSymTransferR M K1 K2 (configBasisIso M μ) (configBasisIso M μ')
      = physicalV1halfR M K1 (configBasisIso M μ) (configBasisIso M μ)
          * physicalV2R M K2 (configBasisIso M μ) (configBasisIso M μ')
          * physicalV1halfR M K1 (configBasisIso M μ') (configBasisIso M μ') :=
  NecSuf.sandwich_apply_of_offDiag_zero (physicalV1halfR_offDiag K1) _ _

/-- `W_has_positive_entries_physical` は `NecSuf.sandwich_apply_pos` の特殊化。 -/
theorem W_has_positive_entries_physical_of_necSuf (K1 K2 : ℝ) (μ μ' : SpinConf M) :
    0 < physicalSymTransferR M K1 K2 (configBasisIso M μ) (configBasisIso M μ') :=
  NecSuf.sandwich_apply_pos (physicalV1halfR_offDiag K1)
    (fun i => by
      obtain ⟨ν, rfl⟩ := (configBasisIso M).surjective i
      exact physicalV1halfR_apply_configBasisIso_self_pos K1 ν)
    (fun i j => by
      obtain ⟨ν, rfl⟩ := (configBasisIso M).surjective i
      obtain ⟨ν', rfl⟩ := (configBasisIso M).surjective j
      exact physicalV2R_apply_configBasisIso_pos K2 ν ν') _ _

end Ising2D
