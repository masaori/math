/-
# 数演算子とその補の積のトレース（具体版を必要十分版から導く）

具体版 `ClaimTraceCheckNumberOperatorProduct.lean` の `CheckFermiSetup.trace_projFactor_finProdLeft`（人手 `trace_of_check_number_operator_product` の
帰納法と 1 対 1）を、必要十分版 `Ising2D/NecSuf/TraceOfNumberOperatorProductByLastFactor.lean` の `NecSuf.tau_finProdLeft_projFactor` の
`A := TensorPow M`（`= Mat(2^{M_col},ℂ)`）、`K := ℂ`、`τ := tr`、`half := 2_ℂ^{-1}`（`hhalf` は準備 4 の `inv_two_mul_two_prep4`）、`c := ψ̌^†`（`F.cre`）、`a := ψ̌_{M_col+1-·}`（`F.ann`）、`ι := 𝓜̌` の特殊化として得る。
渡す仮定は、`hlin` が `trace_basic_properties` (1)（`trace_linear`）、`hcyc` が (2)（`trace_cyclic`）、`hac` が `check_number_operator_idempotent` (2)
（`ann_mul_cre`）、`hcomm` が `check_number_operators_commute` (1) の第 2 式（`commute_ann_nOp`）、`hτ1` が基底段階（`trace_identity_base_case` と `|𝓜̌| = M_col`）である。
-/
import Ising2D.EigenvalueProblem.EigenvaluesOfVPlus.ClaimTraceCheckNumberOperatorProduct
import Ising2D.NecSuf.TraceOfNumberOperatorProductByLastFactor

namespace Ising2D

namespace CheckFermiSetup

variable {M : ℕ} (F : CheckFermiSetup M)

/-- `trace_projFactor_finProdLeft` を `NecSuf.tau_finProdLeft_projFactor` の特殊化として得る。 -/
theorem trace_projFactor_finProdLeft_of_necSuf (T : Finset (CheckIdx M)) (r : ℕ) (μ : Fin (r + 1) → CheckIdx M)
    (hμ : Function.Injective μ) :
    (NecSuf.finProdLeft r (fun j => NecSuf.projFactor F.nOp T (μ j))).trace = (2 : ℂ) ^ (M - (r + 1)) := by
  have hτ1 : (1 : TensorPow M).trace = (2 : ℂ) ^ (Fintype.card (CheckIdx M) - 0) := by
    rw [CheckIdx.card]; exact trace_identity_base_case
  have h := NecSuf.tau_finProdLeft_projFactor (A := TensorPow M) (K := ℂ) Matrix.trace
    (fun α β x y => trace_linear α β x y) (fun x y => trace_cyclic x y) (2 : ℂ)⁻¹ inv_two_mul_two_prep4
    F.cre F.ann F.ann_mul_cre (fun i j hij => F.commute_ann_nOp hij) hτ1 T r μ hμ
  rw [CheckIdx.card] at h
  exact h

end CheckFermiSetup

end Ising2D
