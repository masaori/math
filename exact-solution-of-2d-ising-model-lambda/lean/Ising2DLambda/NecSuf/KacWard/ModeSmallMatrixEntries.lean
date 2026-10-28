import Ising2DLambda.NecSuf.KacWard.ModeSmallMatrix

namespace Ising2DLambda.NecSuf.KacWard


/-- `claim_mode_small_matrix_entries`: the same four-direction table uses only
the arithmetic already present in the generic mode-matrix definition. -/
noncomputable def modeSmallMatrixEntries {R : Type*} [Field R]
    (z varpi varsigma : R) : Matrix (ZMod 4) (ZMod 4) R := fun i j =>
  if i = 0 then
    if j = 0 then varpi else if j = 1 then z * varsigma
    else if j = 2 then 0 else z⁻¹ * varsigma⁻¹
  else if i = 1 then
    if j = 0 then z⁻¹ * varpi else if j = 1 then varsigma
    else if j = 2 then z * varpi⁻¹ else 0
  else if i = 2 then
    if j = 0 then 0 else if j = 1 then z⁻¹ * varsigma
    else if j = 2 then varpi⁻¹ else z * varsigma⁻¹
  else
    if j = 0 then z * varpi else if j = 1 then 0
    else if j = 2 then z⁻¹ * varpi⁻¹ else varsigma⁻¹

theorem modeSmallMatrix_eq_entries {R : Type*} [Field R]
    (z varpi varsigma : R) :
    modeSmallMatrix z varpi varsigma = modeSmallMatrixEntries z varpi varsigma := by
  ext i j
  have h0 : (⟨0, by decide⟩ : ZMod 4) = 0 := by decide
  have h1 : (⟨1, by decide⟩ : ZMod 4) = 1 := by decide
  have h2 : (⟨2, by decide⟩ : ZMod 4) = 2 := by decide
  have h3 : (⟨3, by decide⟩ : ZMod 4) = 3 := by decide
  fin_cases i <;> fin_cases j <;>
    simp [h0, h1, h2, h3, modeSmallMatrix, modeSmallMatrixEntries] <;> rfl

end Ising2DLambda.NecSuf.KacWard
