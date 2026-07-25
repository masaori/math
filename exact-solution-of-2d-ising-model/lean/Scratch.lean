import Mathlib

open scoped TensorProduct
open Matrix

-- ============ 1. conjugation ============
section Conj
variable {R : Type*} [Ring R]

-- mathlib: MulSemiringAction (ConjAct Rˣ) R
#check @ConjAct.unitsMulSemiringAction
#check @MulSemiringAction.toRingHom
example (B : Rˣ) (A : R) : (ConjAct.toConjAct B) • A = (B : R) * A * ↑B⁻¹ := by
  rfl

end Conj

-- ============ 2. tensor basis ============
#check @Basis.piTensorProduct
#check @Basis.piTensorProduct_apply
#check @Matrix.stdBasis

-- ============ 3. Matrix center ============
#check @Matrix.center_eq_scalar_image
#check @Matrix.mem_range_scalar_iff_commute_single'

-- ============ 4. algebra structure on PiTensorProduct ============
example (M : ℕ) : Ring (⨂[ℂ] (_ : Fin M), Matrix (Fin 2) (Fin 2) ℂ) := by infer_instance
example (M : ℕ) : Algebra ℂ (⨂[ℂ] (_ : Fin M), Matrix (Fin 2) (Fin 2) ℂ) := by infer_instance

-- is there a norm / exp?
-- example (M : ℕ) : NormedRing (⨂[ℂ] (_ : Fin M), Matrix (Fin 2) (Fin 2) ℂ) := by infer_instance

-- ============ 5. matrix rep with config index ============
abbrev Conf (M : ℕ) := Fin M → Fin 2
example (M : ℕ) : Ring (Matrix (Conf M) (Conf M) ℂ) := by infer_instance
example (M : ℕ) : Algebra ℂ (Matrix (Conf M) (Conf M) ℂ) := by infer_instance
#check @Matrix.exp
example (M : ℕ) (A : Matrix (Conf M) (Conf M) ℂ) : Matrix (Conf M) (Conf M) ℂ := Matrix.exp ℂ A

#check @finFunctionFinEquiv
