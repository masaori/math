import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

/-- 体の冪と逆元だけを用いる剰余類表示。 -/
theorem twistedModes_eq_coset_necSuf {R : Type*} [Field R] (L : ℕ) (ξ : R)
    (hξ : ξ ^ L = -1) (hξne : ξ ≠ 0) :
    ({z : R | z ^ L = (1 : R)} : Set R) = {z : R | z ^ L = (1 : R)} ∧
      ({z : R | z ^ L = (-1 : R)} : Set R) =
        Set.image (fun y : R => ξ * y) {y : R | y ^ L = 1} := by
  constructor
  · rfl
  · apply Set.ext
    intro z
    constructor
    · intro hz
      refine ⟨ξ⁻¹ * z, ?_, ?_⟩
      · change (ξ⁻¹ * z) ^ L = 1
        calc
          (ξ⁻¹ * z) ^ L = (ξ ^ L)⁻¹ * z ^ L := by rw [mul_pow, inv_pow]
          _ = (-1 : R)⁻¹ * (-1) := by rw [hξ, hz]
          _ = 1 := by norm_num
      · simp [hξne]
    · rintro ⟨y, hy, rfl⟩
      change (ξ * y) ^ L = -1
      calc
        (ξ * y) ^ L = ξ ^ L * y ^ L := mul_pow ξ y L
        _ = (-1 : R) * 1 := by rw [hξ, hy]
        _ = -1 := by ring

end Ising2DLambda.NecSuf.KacWard
