/-
# `tr(εV^{(+)})` を `V̌^{(+)}` の固有値で書く（必要十分版からの導出）

具体版 `ClaimTraceEpsilonVPlusViaCheckEigenvalues.lean` の Step 2 の `checkU_prod_eq_neg_one_pow` を
必要十分版 `Ising2D/NecSuf/PowerFromProductOfTwoValuedFactors.lean` の特殊化として、Step 3 の
`VPlusData.eta_mul_checkLambda_eq_checkT_mul_checkH` を `Ising2D/NecSuf/SignedTermAsImageOfReorderedProduct.lean` の
特殊化として得る。人手のラベルは `trace_of_epsilon_V_plus_via_check_eigenvalues`。
-/
import Ising2D.EigenvalueProblem.EigenvectorOfMaxEigenvalue.ClaimTraceEpsilonVPlusViaCheckEigenvalues
import Ising2D.NecSuf.PowerFromProductOfTwoValuedFactors
import Ising2D.NecSuf.SignedTermAsImageOfReorderedProduct
import Ising2D.MathematicalTools.MatrixExponentialAndCommutators.ClaimRealExpOfFiniteSumFromNecSuf

namespace Ising2D

open Matrix

variable {M : ℕ}

/-- `checkU_prod_eq_neg_one_pow` を必要十分版 `NecSuf.map_prod_two_valued_eq_pow'`（`f → (·)_ℂ`、`u → ǔ`、`s → −1_ℂ`）の
特殊化として。`Finset.prod` と左から掛ける有限積の一致は `real_finset_prod_eq_finProdLeft`、`|ε|` は `wordCount'` と同じ数である。 -/
theorem checkU_prod_eq_neg_one_pow_of_necSuf (n : ℕ) (ε : Fin (n + 1) → Fin 2) :
    ((∏ μ, checkU (ε μ) : ℝ) : ℂ) = (-1 : ℂ) ^ ((n + 1) - (CheckFermi.finsetOfWord ε).card) := by
  rw [real_finset_prod_eq_finProdLeft n (fun μ => checkU (ε μ))]
  exact NecSuf.map_prod_two_valued_eq_pow' (fun a : ℝ => (a : ℂ)) (fun a b => (real_inclusion_mul a b).symm)
    checkU (-1 : ℂ) (by rw [checkU_one, Complex.ofReal_one])
    (by rw [checkU_zero, Complex.ofReal_neg, Complex.ofReal_one]) n ε

namespace VPlusData

/-- `eta_mul_checkLambda_eq_checkT_mul_checkH` を必要十分版 `NecSuf.signed_term_eq_map_mul'`
（`f → (·)_ℂ`、`h → ȟ`、`u → Π_μǔ^{(ε(μ))}`、`l → Λ̌_ε`）の特殊化として。 -/
theorem eta_mul_checkLambda_eq_checkT_mul_checkH_of_necSuf {r : ℕ} {F : CheckFermi (r + 1)}
    (D : VPlusData (r + 1) F) (ε : Fin (r + 1) → Fin 2) :
    F.eta (CheckFermi.finsetOfWord ε) * ((checkLambda D.C D.gam (CheckFermi.finsetOfWord ε) : ℝ) : ℂ)
      = ((D.checkT ε * F.checkH : ℝ) : ℂ) :=
  NecSuf.signed_term_eq_map_mul' (fun a : ℝ => (a : ℂ)) real_inclusion_mul
    (F.eta_eq_eta_univ_mul _) (checkU_prod_eq_neg_one_pow r ε) F.checkH_ofReal

end VPlusData

end Ising2D
