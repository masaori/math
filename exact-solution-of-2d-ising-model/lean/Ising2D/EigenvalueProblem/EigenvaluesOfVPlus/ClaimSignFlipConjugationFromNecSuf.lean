/-
# `U exp(S) U^{-1} = exp(USU^{-1})` を必要十分版の特殊化として導く

正本: `structured-latex/content/eigenvalue_problem_eigenvalues_of_V_plus.ts`
（ラベル **`constant_c_value_even_sector`** の Step 2）

人手と 1 対 1 に対応する具体版は `ClaimSignFlipConjugation.lean` の
`Uflip_conj_pow`・`Uflip_conj_expPartialSum`・`Uflip_conj_matExp` である。
ここでは同じ主張を、必要十分版 `NecSuf/ConjugationOfExpSeries.lean` を
`𝔸 = Mat(2^{M_col}, ℂ)`、`u = U`、`v = U^{-1}`、係数 `c_k = (k!)^{-1} ∈ ℂ` に特殊化して導く。
部分和の極限は人手 `def_exp`（`matExp_hasSum`）から、`X ↦ UXU^{-1}` の連続性は
行列の積の連続性から与える（具体版はこれをノルム評価 `‖U(X-W)U^{-1}‖ ≤ ‖U‖‖U^{-1}‖‖X-W‖` から出す）。
-/
import Ising2D.EigenvalueProblem.EigenvaluesOfVPlus.ClaimSignFlipConjugation
import Ising2D.NecSuf.ConjugationOfExpSeries

namespace Ising2D

variable {M : ℕ}

/-- 具体版 `Uflip_conj_pow` の必要十分版 `NecSuf.conj_pow_of_inv` からの導出。 -/
theorem Uflip_conj_pow_of_necSuf (S : TensorPow M) (k : ℕ) :
    Uflip M * S ^ k * UflipInv M = (Uflip M * S * UflipInv M) ^ k :=
  NecSuf.conj_pow_of_inv Uflip_mul_inv UflipInv_mul S k

/-- 具体版 `Uflip_conj_expPartialSum` の必要十分版 `NecSuf.conj_partialSum_of_inv` からの導出。 -/
theorem Uflip_conj_expPartialSum_of_necSuf (S : TensorPow M) (n : ℕ) :
    Uflip M * (∑ k ∈ Finset.range n, ((k.factorial : ℂ))⁻¹ • S ^ k) * UflipInv M
      = ∑ k ∈ Finset.range n, ((k.factorial : ℂ))⁻¹ • (Uflip M * S * UflipInv M) ^ k :=
  NecSuf.conj_partialSum_of_inv Uflip_mul_inv UflipInv_mul (fun k => ((k.factorial : ℂ))⁻¹) S n

/-- 具体版 `Uflip_conj_matExp` の必要十分版 `NecSuf.conj_series_limit_of_inv` からの導出。 -/
theorem Uflip_conj_matExp_of_necSuf (S : TensorPow M) :
    Uflip M * matExp S * UflipInv M = matExp (Uflip M * S * UflipInv M) :=
  NecSuf.conj_series_limit_of_inv Uflip_mul_inv UflipInv_mul (fun k => ((k.factorial : ℂ))⁻¹)
    S (matExp S) (matExp (Uflip M * S * UflipInv M))
    ((continuous_const.mul continuous_id).mul continuous_const).continuousAt
    (matExp_hasSum S).tendsto_sum_nat
    (matExp_hasSum (Uflip M * S * UflipInv M)).tendsto_sum_nat

end Ising2D
