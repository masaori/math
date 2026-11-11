/-
# 2×2 行列の余因子行列と両側逆元（具体版を必要十分版から導く）

具体版 `ClaimTwoSidedInverseOfTwoByTwo.lean` の主張を、必要十分版 `Ising2D/NecSuf/TwoByTwoAdjugateInverse.lean` の
係数 `R → ℂ`、`u → (det B)^{-1}`（`inv_mul_cancel₀`。人手の `multiplicative_group_of_cc` の逆元）の特殊化として得る。
人手のラベルは `matrix_times_adjugate_two_by_two`・`adjugate_times_matrix_two_by_two`・
`two_sided_inverse_of_two_by_two_with_nonzero_det`。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimTwoSidedInverseOfTwoByTwo
import Ising2D.NecSuf.TwoByTwoAdjugateInverse

namespace Ising2D

/-- 具体版の `adjTwo` は必要十分版の `adjTwo'` の `R → ℂ` である。 -/
theorem adjTwo_eq_necSuf (B : Matrix (Fin 2) (Fin 2) ℂ) : adjTwo B = NecSuf.adjTwo' B := rfl

theorem mul_adjTwo_of_necSuf (B : Matrix (Fin 2) (Fin 2) ℂ) :
    B * adjTwo B = B.det • (1 : Matrix (Fin 2) (Fin 2) ℂ) :=
  NecSuf.mul_adjTwo' B

theorem adjTwo_mul_of_necSuf (B : Matrix (Fin 2) (Fin 2) ℂ) :
    adjTwo B * B = B.det • (1 : Matrix (Fin 2) (Fin 2) ℂ) :=
  NecSuf.adjTwo_mul' B

theorem two_sided_inverse_of_two_by_two_of_necSuf (B : Matrix (Fin 2) (Fin 2) ℂ) (hB : B.det ≠ 0) :
    B * (B.det⁻¹ • adjTwo B) = 1 ∧ (B.det⁻¹ • adjTwo B) * B = 1 :=
  ⟨NecSuf.mul_smul_adjTwo_of_mul_det' B _ (inv_mul_cancel₀ hB),
    NecSuf.smul_adjTwo_mul_of_mul_det' B _ (inv_mul_cancel₀ hB)⟩

end Ising2D
