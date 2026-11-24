/-
# `γ_1(θ) ≥ cosh(2K_1 - 2K_2^*)`（具体版を必要十分版から導く）

具体版 `ClaimGamma1LowerBound.lean` の `gamma1R_ge_cosh_sub` の主張を、必要十分版 `Ising2D/NecSuf/CoshLowerBound.lean` の
`cosh_sub_le_cosh_mul_cosh_sub` の `u := 2K_1`、`v := 2K_2^*`、`x := cos θ` への特殊化として得る。
仮定 `x ≤ 1` には `Real.cos_le_one`、`sinh u sinh v ≥ 0` には具体版の `IsingParam.s1_pos`・`IsingParam.s2star_pos` を渡す。
人手のラベルは `gamma1_lower_bound_all_theta`。
-/
import Ising2D.EigenvalueProblem.DiagonalizationAndExponentialForm.ClaimGamma1LowerBound
import Ising2D.NecSuf.CoshLowerBound

namespace Ising2D

/-- `gamma1R_ge_cosh_sub` を `NecSuf.cosh_sub_le_cosh_mul_cosh_sub`（`u := 2K_1`、`v := 2K_2^*`、`x := cos θ`）の特殊化として得る。 -/
theorem gamma1R_ge_cosh_sub_of_necSuf (P : IsingParam) (θ : ℝ) :
    Real.cosh (2 * P.K1 - 2 * P.K2star) ≤ gamma1R P.const θ := by
  have hs : 0 ≤ Real.sinh (2 * P.K1) * Real.sinh (2 * P.K2star) := by
    have h1 := P.s1_pos
    have h2 := P.s2star_pos
    simp only [IsingParam.const] at h1 h2
    positivity
  simpa [gamma1R, IsingParam.const] using
    NecSuf.cosh_sub_le_cosh_mul_cosh_sub (u := 2 * P.K1) (v := 2 * P.K2star)
      (x := Real.cos θ) (Real.cos_le_one θ) hs

end Ising2D
