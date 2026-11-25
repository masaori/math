/-
# `γ` は `ℝ` 上で連続（具体版を必要十分版から導く）

具体版 `ClaimGammaContinuous.lean` の `gamma_is_continuous` の主張を、必要十分版
`Ising2D/NecSuf/Arcosh.lean` の `continuous_arcosh_comp` の `f := γ_1` への特殊化として得る。
人手のラベルは `gamma_is_continuous`。
-/
import Ising2D.ThermodynamicLimit.ColumnLimitAndClosedForm.ClaimGammaContinuous
import Ising2D.NecSuf.Arcosh

namespace Ising2D

/-- `gamma_is_continuous` を `NecSuf.continuous_arcosh_comp`（`f := γ_1`）の特殊化として得る。 -/
theorem gamma_is_continuous_of_necSuf (P : IsingParam) : Continuous (gammaFn P) :=
  NecSuf.continuous_arcosh_comp (continuous_gamma1R P.const) (one_le_gamma1R P)

end Ising2D
