/-
# `{-1,1}` と行配位の集合（必要十分版の側の定義との一致）

具体版の `SpinVal`・その `Fintype` の構造・`SpinConf`（`DefinitionRowConfigurations.lean`。人手 `def_row_configurations`）と
`spinIdxEquiv`（`DefinitionConfigBasisIso.lean`。人手 `def_config_basis_iso` の成分ごとの全単射）は、必要十分版の側の
`NecSuf.SpinVal'`・`NecSuf.instFintypeSpinVal'`・`NecSuf.SpinConf'`・`NecSuf.spinIdxEquiv'`（`Ising2D/NecSuf/SpinValues.lean`）と
同じ式で定義してあり、定義上一致する。`{-1,1}` を使う必要十分版から具体版を導く導出のファイルは、この一致で読み替える。
-/
import Ising2D.PartitionFunction.TransferMatrixRepresentation.DefinitionConfigBasisIso
import Ising2D.NecSuf.SpinValues

namespace Ising2D

/-- 具体版の `{-1,1}` は必要十分版の側の `{-1,1}` と同じ型（同じ式の定義）。 -/
theorem spinVal_eq_spinVal_necSuf : SpinVal = NecSuf.SpinVal' := rfl

/-- 具体版の `{-1,1}` の有限集合の構造は、必要十分版の側のものと一致する（同じ式の定義）。 -/
theorem fintype_spinVal_eq_necSuf : (inferInstance : Fintype SpinVal) = NecSuf.instFintypeSpinVal' := rfl

/-- 具体版の `𝔐` は必要十分版の側の `𝔐` と同じ型（同じ式の定義）。 -/
theorem spinConf_eq_spinConf_necSuf (M : ℕ) : SpinConf M = NecSuf.SpinConf' M := rfl

/-- 具体版の成分ごとの全単射 `{-1,1} → {0,1}` は、必要十分版の側のものと一致する（同じ式の定義）。 -/
theorem spinIdxEquiv_eq_spinIdxEquiv_necSuf : spinIdxEquiv = NecSuf.spinIdxEquiv' := rfl

end Ising2D
