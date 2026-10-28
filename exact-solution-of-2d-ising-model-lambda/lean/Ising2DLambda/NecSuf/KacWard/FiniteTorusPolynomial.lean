import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

open Finset

/-- The finite Fourier sum needs only the four character sums and a trivial-sector identity. -/
theorem finiteTorusPolynomial
    {R : Type*} [CommSemiring R]
    (coefficient : (Fin 2 × Fin 2) → (Fin 2 × Fin 2) → R)
    (Q G : (Fin 2 × Fin 2) → R) (Z : R)
    (hQ : ∀ spin, Q spin = ∑ sector, coefficient spin sector * G sector)
    (hOrth : ∀ sector, (∑ spin, coefficient spin sector) =
      if sector = (0, 0) then 4 else 0)
    (hZ : Z = 2 * G (0, 0)) :
    (∑ spin, Q spin) = 2 * Z := by
  classical
  calc
    (∑ spin, Q spin)
        = ∑ spin, ∑ sector, coefficient spin sector * G sector := by
            apply Finset.sum_congr rfl
            intro spin _
            exact hQ spin
    _ = ∑ sector, ∑ spin, coefficient spin sector * G sector := Finset.sum_comm
    _ = ∑ sector, (∑ spin, coefficient spin sector) * G sector := by
          apply Finset.sum_congr rfl
          intro sector _
          rw [Finset.sum_mul]
    _ = 4 * G (0, 0) := by simp [hOrth]
    _ = 2 * Z := by rw [hZ]; ring

end Ising2DLambda.NecSuf.KacWard
