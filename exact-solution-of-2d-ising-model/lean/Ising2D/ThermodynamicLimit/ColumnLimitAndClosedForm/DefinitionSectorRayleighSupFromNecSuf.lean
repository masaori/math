/-
# `𝓡_+`・`c_+(M) := sup 𝓡_+`（必要十分版からの導出）

具体版 `DefinitionSectorRayleighSup.lean` の `Ising2D.evenSectorSet`・`evenSectorRayleighSup`（人手 `def_sector_rayleigh_sup`）と、必要十分版
`Ising2D/NecSuf/RayleighSupAndSectorRayleighSup.lean` の `NecSuf.evenSectorSet'`・`evenSectorRayleighSup'` は、同じ式で定義した同じ集合・同じ値である。
必要十分版の主張（形式化の記録 `NecSuf.rayleighSup_le_two_mul_evenSectorRayleighSup` など）から具体版を導くときは、この一致と
`DefinitionRayleighSupFromNecSuf.lean` の `rayleighSup_eq_rayleighSup_necSuf` で具体版へ読み替える。
-/
import Ising2D.ThermodynamicLimit.ColumnLimitAndClosedForm.DefinitionSectorRayleighSup
import Ising2D.ThermodynamicLimit.RowLimitAndMaxEigenvalue.DefinitionRayleighSupFromNecSuf

namespace Ising2D

variable {n : Type*} [Fintype n]

/-- 具体版の `𝓡_+` は、必要十分版の `𝓡_+` と一致する（同じ式の定義）。 -/
theorem evenSectorSet_eq_evenSectorSet_necSuf (W ε : Matrix n n ℝ) :
    evenSectorSet W ε = NecSuf.evenSectorSet' W ε :=
  rfl

/-- 具体版の `c_+(M) = sup 𝓡_+` は、必要十分版の `sup 𝓡_+` と一致する（同じ式の定義）。 -/
theorem evenSectorRayleighSup_eq_evenSectorRayleighSup_necSuf (W ε : Matrix n n ℝ) :
    evenSectorRayleighSup W ε = NecSuf.evenSectorRayleighSup' W ε :=
  rfl

end Ising2D
