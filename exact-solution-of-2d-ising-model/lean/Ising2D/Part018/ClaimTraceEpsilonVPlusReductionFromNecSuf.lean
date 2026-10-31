/-
# `exp(tA) = cosh(t)I + sinh(t)A`（`A^2 = I`）を必要十分版の系として導く

正本: `structured-latex/content/eigenvalue_problem_eigenvector_of_max_eigenvalue.ts`
（ラベル **`trace_of_epsilon_V_plus`** の Step 2 の偶奇分解）

人手と 1 対 1 に対応する主張は `Ising2D.matExp_smul_of_sq_eq_one`
（`Part018/ClaimTraceEpsilonVPlusReduction.lean`）である。ここでは同じ主張を、必要十分版
`Ising2D.NecSuf.exp_series_sum_of_sq_eq_one`（`NecSuf/ExpOfInvolution.lean`）を
`𝔸 = TensorPow M`（`2^M × 2^M` 複素行列）、`E = exp(tA)`、`t` を実数の像に特殊化して得る。
必要十分版の仮定 `hE`（指数級数の部分和の極限が `E`）は、行列指数関数の級数表示 `matExp_hasSum` が与える。
-/
import Ising2D.NecSuf.ExpOfInvolution
import Ising2D.Part018.ClaimTraceEpsilonVPlusReduction

namespace Ising2D

variable {M : ℕ}

/-- `matExp_smul_of_sq_eq_one` を必要十分版の特殊化として導いたもの。 -/
theorem matExp_smul_of_sq_eq_one_of_necSuf {A : TensorPow M} (hA : A ^ 2 = 1) (t : ℝ) :
    matExp ((t : ℂ) • A) = ((Real.cosh t : ℝ) : ℂ) • (1 : TensorPow M) + ((Real.sinh t : ℝ) : ℂ) • A := by
  rw [NecSuf.exp_series_sum_of_sq_eq_one hA (t : ℂ) (matExp_hasSum ((t : ℂ) • A)).tendsto_sum_nat,
    ← Complex.ofReal_cosh, ← Complex.ofReal_sinh]

end Ising2D
