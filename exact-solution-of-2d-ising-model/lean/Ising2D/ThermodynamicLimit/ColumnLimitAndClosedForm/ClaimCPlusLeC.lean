/-
# `c_+(M) ≤ c(M)`

正本: `structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts`
（`maxeig_claim_c_plus_le_c`、ラベル **`c_plus_le_c`**）

人手の証明: `𝓡_+` の元 `xᵀW_ℝx`（`x ∈ ℝ^{2^M}`、`ε_ℝx = x`、`‖x‖ = 1`）は、`x ∈ ℝ^{2^M}`、`‖x‖ = 1` なので
同じ式で `𝓡` の元であり、`𝓡_+ ⊆ 𝓡`。`𝓡_+ ≠ ∅`（`def_sector_rayleigh_sup`）と
上限の単調性から `c_+(M) = sup 𝓡_+ ≤ sup 𝓡 = c(M)`。Lean は `evenSectorSet_subset`、`evenSectorSet_epsilonR_nonempty`、
`csSup_le_csSup` と、上限の単調性が要る `𝓡` の上の有界性 `rayleighSet_bddAbove`（人手は `def_rayleigh_sup` で示し、
鎖の「上限の単調性」の行では明示して引いていない）の 4 つで示す。

`W` は実数の行列で、仮定を置かない（人手の `W_ℝ` の対称性・正定値性は、この不等式には効かない。
`W = V_1^{1/2}V_2V_1^{1/2}` という具体形にも依らない）。Ising では `W := physicalSymTransferR` で使う。

必要十分版はない（`sSup` の単調性は ℝ の完備性そのもの）。
-/
import Ising2D.ThermodynamicLimit.ColumnLimitAndClosedForm.DefinitionSectorRayleighSup

set_option linter.unusedSectionVars false

namespace Ising2D

open Matrix

variable {M : ℕ}

/-- **人手本文 `c_plus_le_c`**: `c_+(M) ≤ c(M)`（`W` に仮定を置かない）。 -/
theorem c_plus_le_c (W : Matrix (Conf M) (Conf M) ℝ) :
    evenSectorRayleighSup W (epsilonR M) ≤ rayleighSup W :=
  csSup_le_csSup (rayleighSet_bddAbove W) (evenSectorSet_epsilonR_nonempty W)
    (evenSectorSet_subset W (epsilonR M))

end Ising2D
