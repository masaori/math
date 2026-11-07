/-
# `Σ_k ((W_ℝ)^n)_kk ≤ 2^{M_col} c(M_col)^n` を必要十分版から得る

正本: `structured-latex/content/thermodynamic_limit_row_limit_and_max_eigenvalue.ts`
（`maxeig_008a_claim_trace_power_upper_bound`、ラベル **`trace_power_upper_bound`**）

具体版 `Ising2D.trace_power_upper_bound`（`ClaimTracePowerUpperBound.lean`）と同じ型の主張を、各 `k` の評価が必要十分版
`Ising2D.NecSuf.IsPsdPair.moment_le_pow` の特殊化である `trace_pow_le`（`ClaimTracePowerSandwich.lean`）から得る。
具体版が必要十分版の特殊化として得られることの記録で、具体版の証明と通しの証明には使わない。
必要十分版の側では `W_ℝ` の正定値性は要らず、半正定値性（`psd_of_pd` で正定値性から出す）で足りる。
-/
import Ising2D.ThermodynamicLimit.RowLimitAndMaxEigenvalue.ClaimTracePowerUpperBound
import Ising2D.ThermodynamicLimit.RowLimitAndMaxEigenvalue.ClaimTracePowerSandwich

set_option linter.unusedSectionVars false

namespace Ising2D

open Matrix

variable {M : ℕ}

/-- **人手 `trace_power_upper_bound` を必要十分版から得たもの**（具体版 `trace_power_upper_bound` と同じ型）。 -/
theorem trace_power_upper_bound_of_necSuf (W : TensorPow M) (hW : MatrixIsRealSymmetric W)
    (hWRsymm : (realMatrixOfRealEntries W hW.1).IsSymm)
    (hpd : ∀ x : Conf M → ℝ, x ≠ 0 → 0 < x ⬝ᵥ realMatrixOfRealEntries W hW.1 *ᵥ x)
    {n : ℕ} (_hn : 1 ≤ n) :
    ∑ k, (realMatrixOfRealEntries W hW.1 ^ n) k k
      ≤ 2 ^ M * rayleighSup (realMatrixOfRealEntries W hW.1) ^ n := by
  have h := trace_pow_le hWRsymm (psd_of_pd hpd) n
  rw [card_conf] at h
  exact h

end Ising2D
