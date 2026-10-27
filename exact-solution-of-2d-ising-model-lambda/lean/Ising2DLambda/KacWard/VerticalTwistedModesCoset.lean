import Ising2DLambda.KacWard.TwistedModeSets

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

/-- 縦方向の二つのねじれを、冪根集合とその乗法平行移動で表示する。 -/
theorem verticalTwistedModes_eq_coset (L : ℕ) (ξ : Qbar)
    (hξ : ξ ^ L = -1) :
    verticalTwistedModes L (false, false) = RootOfUnity L ∧
      verticalTwistedModes L (false, true) =
        (fun y : Qbar => ξ * y) '' RootOfUnity L := by
  constructor
  · rfl
  · apply Set.ext
    intro z
    constructor
    · intro hz
      -- 人手証明の逆向き包含: y = ξ⁻¹z を構成する。
      have hzpow : z ^ L = -1 := hz
      have hξne : ξ ≠ 0 := by
        intro hzero
        rw [hzero] at hξ
        cases L with
        | zero => norm_num at hξ
        | succ n => simp at hξ
      refine ⟨ξ⁻¹ * z, ?_, ?_⟩
      · change (ξ⁻¹ * z) ^ L = 1
        calc
          (ξ⁻¹ * z) ^ L = (ξ ^ L)⁻¹ * z ^ L := by rw [mul_pow, inv_pow]
          _ = (-1 : Qbar)⁻¹ * (-1) := by rw [hξ, hzpow]
          _ = 1 := by norm_num
      · simp [hξne]
    · rintro ⟨y, hy, rfl⟩
      change (ξ * y) ^ L = -1
      change y ^ L = 1 at hy
      calc
        (ξ * y) ^ L = ξ ^ L * y ^ L := mul_pow ξ y L
        _ = (-1 : Qbar) * 1 := by rw [hξ, hy]
        _ = -1 := by ring

end Ising2DLambda.KacWard
