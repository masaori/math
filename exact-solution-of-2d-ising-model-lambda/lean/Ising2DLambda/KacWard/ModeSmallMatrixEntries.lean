import Ising2DLambda.KacWard.ModeSmallMatrix

namespace Ising2DLambda.KacWard


open Ising2DLambda.AlgebraicEigenvalue

/-- The row and column table used in the four-direction determinant expansion. -/
noncomputable def modeSmallMatrixEntries (z varpi varsigma : Qbar) :
    Matrix (ZMod 4) (ZMod 4) Qbar := fun i j =>
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

/-- `claim_mode_small_matrix_entries`: each entry follows by substituting one of
the four direction numbers, exactly as in the human proof. -/
theorem modeSmallMatrix_eq_entries (z varpi varsigma : Qbar) :
    modeSmallMatrix z varpi varsigma = modeSmallMatrixEntries z varpi varsigma := by
  ext i j
  have h0 : (⟨0, by decide⟩ : ZMod 4) = 0 := by decide
  have h1 : (⟨1, by decide⟩ : ZMod 4) = 1 := by decide
  have h2 : (⟨2, by decide⟩ : ZMod 4) = 2 := by decide
  have h3 : (⟨3, by decide⟩ : ZMod 4) = 3 := by decide
  fin_cases i <;> fin_cases j <;>
    simp [h0, h1, h2, h3, modeSmallMatrix, modeSmallMatrixEntries,
      directionModeWeight] <;> rfl

end Ising2DLambda.KacWard
