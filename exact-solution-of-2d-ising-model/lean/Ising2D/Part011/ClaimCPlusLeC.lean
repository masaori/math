/-
# `c_+(M) ≤ c(M)`

正本: `structured-latex/content/011_max_eigenvalue.ts`
（`maxeig_claim_c_plus_le_c`、ラベル **`c_plus_le_c`**）

人手の証明: `𝓕^{(+)} ∩ ℝ^{2^M} ⊆ ℝ^{2^M}` なので `𝓡_+ ⊆ 𝓡`。`𝓡_+ ≠ ∅`（`def_sector_rayleigh_sup`）と
上限の単調性から `c_+(M) = sup 𝓡_+ ≤ sup 𝓡 = c(M)`。Lean も同じ 3 つ
（`evenSectorSet_subset`、`evenSectorSet_epsilonR_nonempty`、`csSup_le_csSup`）で示す。

`W` は実対称半正定値であることだけを仮定する（`𝓡` の有界性に使う。章 011 の他の主張と同じく、
`W = V_1^{1/2}V_2V_1^{1/2}` という具体形には依らない）。

必要十分版はない（`sSup` の単調性は ℝ の完備性そのもの）。
-/
import Ising2D.Part011.DefinitionSectorRayleighSup

set_option linter.unusedSectionVars false

namespace Ising2D

open Matrix

variable {M : ℕ}

/-- **人手本文 `c_plus_le_c`**: `c_+(M) ≤ c(M)`。 -/
theorem c_plus_le_c {W : Matrix (Conf M) (Conf M) ℝ} (hW : W.IsSymm)
    (hpsd : ∀ x : Conf M → ℝ, 0 ≤ x ⬝ᵥ W *ᵥ x) :
    evenSectorRayleighSup W (epsilonR M) ≤ rayleighSup W :=
  csSup_le_csSup (rayleighSet_bddAbove hW hpsd) (evenSectorSet_epsilonR_nonempty W)
    (evenSectorSet_subset W (epsilonR M))

end Ising2D
