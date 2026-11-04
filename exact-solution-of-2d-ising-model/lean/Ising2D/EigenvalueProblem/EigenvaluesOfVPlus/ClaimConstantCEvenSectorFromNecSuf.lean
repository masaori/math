/-
# 定数 `c` の決定の Step 4・Step 5（具体版を必要十分版から導く）

具体版 `ClaimConstantCEvenSector.lean` の `constant_c_steps_four_five` の主張を、必要十分版
`Ising2D/NecSuf/ConstantC.lean` の `NecSuf.const_eq_of_trace_chains` の `K := ℂ`、`k := ℝ`、
包含 `φ := (·)_ℂ`（`Complex.ofRealHom` を積と `0`・`1` を保つ写像として見たもの。単射性は `Complex.ofReal_injective`）の特殊化として得る。
人手のラベルは `constant_c_value_even_sector`。
-/
import Ising2D.EigenvalueProblem.EigenvaluesOfVPlus.ClaimConstantCEvenSector
import Ising2D.NecSuf.ConstantC

namespace Ising2D

/-- `constant_c_steps_four_five` を `NecSuf.const_eq_of_trace_chains`（`K := ℂ`、`k := ℝ`、`φ := (·)_ℂ`）の特殊化として得る。 -/
theorem constant_c_steps_four_five_of_necSuf {c τ τ' T T' : ℂ} {a r t : ℝ} (hcne : c ≠ 0)
    (hT : T = (a : ℂ) * τ) (hT' : T' = ((a⁻¹ : ℝ) : ℂ) * τ') (hτ : τ' = τ)
    (hTc : T = c * (t : ℂ)) (hT'c : T' = c⁻¹ * (t : ℂ)) (hTr : T = (r : ℂ))
    (ha : 0 < a) (hr : 0 < r) (ht : 0 < t) : c = (a : ℂ) :=
  NecSuf.const_eq_of_trace_chains Complex.ofRealHom.toMonoidWithZeroHom Complex.ofReal_injective
    hcne hT hT' hτ hTc hT'c hTr ha hr ht

end Ising2D
