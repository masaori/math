/-
# 具体的な `W` の成分の正値性を必要十分版の特殊化として導く

人手 `W_has_positive_entries`（`structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts`）。
具体版 `Ising2D/ThermodynamicLimit/ColumnLimitAndClosedForm/ClaimPhysicalWHasPositiveEntries.lean` の Step 3（補助の鎖 2 本・
主の鎖・`w > 0` の鎖）と主張の形 `W_has_positive_entries` が、必要十分版 `Ising2D/NecSuf/SandwichByDiagonal.lean` の
添字 `Conf M`、係数 `R := ℂ`・`S := ℝ`、`φ := (ℝ → ℂ の埋め込み)`、`B := V_1^{1/2}`（複素行列 `physicalV1halfC`）・
`V := V_2`、`k := ι(μ)`・`l := ι(μ')` での特殊化として得られることを示す。
特殊化に渡す仮定は、`x·0 = 0`・`0·x = 0`（ℂ の `mul_zero`・`zero_mul`）、具体版の Step 1（`physicalV1halfC_apply_of_ne` を `l` 列と `k` 行へ・`physicalV1halfC_apply_configBasisIso_self`）、
Step 2（`V2_apply_configBasisIso_eq_secondTransferEntry`）、準備（`squareRootV1DiagonalEntry_pos`・`secondTransferEntry_pos`）、
`real_inclusion_mul`（`real_inclusion_preserves_product`）、ℝ の `mul_pos` である。
-/
import Ising2D.ThermodynamicLimit.ColumnLimitAndClosedForm.ClaimPhysicalWHasPositiveEntries
import Ising2D.NecSuf.SandwichByDiagonal

namespace Ising2D

variable {M : ℕ}

/-- `physicalV1halfC_mul_V2_apply_mul_apply_of_ne` は `NecSuf.sandwich_outer_term_of_ne` の特殊化。 -/
theorem physicalV1halfC_mul_V2_apply_mul_apply_of_ne_of_necSuf (K1 K2 : ℝ) (μ μ' : SpinConf M)
    {t : Conf M} (htl : t ≠ configBasisIso M μ') :
    (physicalV1halfC M K1 * V2 M K2) (configBasisIso M μ) t * physicalV1halfC M K1 t (configBasisIso M μ')
      = 0 :=
  NecSuf.sandwich_outer_term_of_ne mul_zero (fun _ h => physicalV1halfC_apply_of_ne K1 h) _ htl

/-- `physicalV1halfC_apply_mul_V2_apply_of_ne` は `NecSuf.sandwich_inner_term_of_ne` の特殊化。 -/
theorem physicalV1halfC_apply_mul_V2_apply_of_ne_of_necSuf (K1 K2 : ℝ) (μ μ' : SpinConf M)
    {s : Conf M} (hsk : s ≠ configBasisIso M μ) :
    physicalV1halfC M K1 (configBasisIso M μ) s * V2 M K2 s (configBasisIso M μ') = 0 :=
  NecSuf.sandwich_inner_term_of_ne zero_mul (fun _ h => physicalV1halfC_apply_of_ne K1 (Ne.symm h)) _ hsk

/-- `physicalSymTransferC_apply_configBasisIso`（主の鎖）は `NecSuf.sandwich_apply_eq_map` の特殊化。
具体版の主の鎖の 1 行目（`W_{kl} = ((BV_2)B)_{kl}`、`def_symmetrized_transfer_matrix`）は、`physicalSymTransferC` の
定義の展開で特殊化の型 `(B * V * B) k l` に吸収される。 -/
theorem physicalSymTransferC_apply_configBasisIso_of_necSuf (K1 K2 : ℝ) (μ μ' : SpinConf M) :
    physicalSymTransferC M K1 K2 (configBasisIso M μ) (configBasisIso M μ')
      = (((squareRootV1DiagonalEntry K1 μ * secondTransferEntry K2 μ μ')
            * squareRootV1DiagonalEntry K1 μ' : ℝ) : ℂ) :=
  NecSuf.sandwich_apply_eq_map mul_zero zero_mul (fun x : ℝ => (x : ℂ)) real_inclusion_mul _ _
    (fun _ h => physicalV1halfC_apply_of_ne K1 h) (fun _ h => physicalV1halfC_apply_of_ne K1 (Ne.symm h)) _ _ _
    (physicalV1halfC_apply_configBasisIso_self K1 μ)
    (V2_apply_configBasisIso_eq_secondTransferEntry K2 μ μ')
    (physicalV1halfC_apply_configBasisIso_self K1 μ')

/-- `symTransferEntryProduct_pos`（`w > 0` の鎖）は `NecSuf.sandwich_weight_pos`（`hmul := mul_pos`）の特殊化。 -/
theorem symTransferEntryProduct_pos_of_necSuf (K1 K2 : ℝ) (μ μ' : SpinConf M) :
    (squareRootV1DiagonalEntry K1 μ * secondTransferEntry K2 μ μ') * squareRootV1DiagonalEntry K1 μ' > 0 :=
  NecSuf.sandwich_weight_pos (fun _ _ ha hb => mul_pos ha hb)
    (squareRootV1DiagonalEntry_pos K1 μ) (secondTransferEntry_pos K2 μ μ')
    (squareRootV1DiagonalEntry_pos K1 μ')

/-- `W_has_positive_entries`（主張の形）は `NecSuf.sandwich_apply_pos` の特殊化（仮定 `K_1, K_2 > 0` は具体版と同じく
主張を人手どおりにするために受け取るだけで、特殊化に渡す仮定はどれも `K_1, K_2` の正値性を使わない）。 -/
theorem W_has_positive_entries_of_necSuf {K1 K2 : ℝ} (_hK1 : 0 < K1) (_hK2 : 0 < K2) (μ μ' : SpinConf M) :
    ∃ w : ℝ, 0 < w ∧
      physicalSymTransferC M K1 K2 (configBasisIso M μ) (configBasisIso M μ') = (w : ℂ) :=
  NecSuf.sandwich_apply_pos (fun _ _ ha hb => mul_pos ha hb) mul_zero zero_mul (fun x : ℝ => (x : ℂ))
    real_inclusion_mul _ _ (fun _ h => physicalV1halfC_apply_of_ne K1 h)
    (fun _ h => physicalV1halfC_apply_of_ne K1 (Ne.symm h))
    (physicalV1halfC_apply_configBasisIso_self K1 μ)
    (V2_apply_configBasisIso_eq_secondTransferEntry K2 μ μ')
    (physicalV1halfC_apply_configBasisIso_self K1 μ')
    (squareRootV1DiagonalEntry_pos K1 μ) (secondTransferEntry_pos K2 μ μ')
    (squareRootV1DiagonalEntry_pos K1 μ')

end Ising2D
