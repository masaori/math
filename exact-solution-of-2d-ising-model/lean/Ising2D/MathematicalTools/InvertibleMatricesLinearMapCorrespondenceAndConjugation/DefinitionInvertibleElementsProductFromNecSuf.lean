/-
# 可逆元の積は可逆（具体版を必要十分版から導く）

具体版 `DefinitionInvertibleElementsProduct.lean` の 2 本の鎖と結論 `invertible_product_isUnit` を、必要十分版 `Ising2D/NecSuf/InvertibleElementsProduct.lean` の
`α := Matrix (Fin n) (Fin n) ℂ`（右単位元は `identity_matrix_is_right_unit_of_mat_mult` の具体版 `mul_identity_matrix`）の特殊化として得る。
人手のラベルは `def_invertible_elements_of_R` (ii)。

`TensorPow M`（添字 `Conf M`）の系も同じ必要十分版の特殊化として置く。具体版は添字が `Fin n` の行列について述べてあり、
`Conf M` の行列には当てはまらないためである。
-/
import Ising2D.MathematicalTools.InvertibleMatricesLinearMapCorrespondenceAndConjugation.DefinitionInvertibleElementsProduct
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityAndScalarMultipleInMatrixProductFromNecSuf
import Ising2D.NecSuf.InvertibleElementsProduct

namespace Ising2D

/-- `invertible_product_right_inverse` を `NecSuf.invertible_product_right_inverse'`（`α := Matrix (Fin n) (Fin n) ℂ`）の特殊化として得る。 -/
theorem invertible_product_right_inverse_of_necSuf {n : ℕ} {g1 g2 h1 h2 : Matrix (Fin n) (Fin n) ℂ}
    (hg1 : g1 * h1 = 1) (hg2 : g2 * h2 = 1) : (g1 * g2) * (h2 * h1) = 1 :=
  NecSuf.invertible_product_right_inverse' mul_identity_matrix hg1 hg2

/-- `invertible_product_left_inverse` を `NecSuf.invertible_product_left_inverse'`（`α := Matrix (Fin n) (Fin n) ℂ`）の特殊化として得る。 -/
theorem invertible_product_left_inverse_of_necSuf {n : ℕ} {g1 g2 h1 h2 : Matrix (Fin n) (Fin n) ℂ}
    (hh1 : h1 * g1 = 1) (hh2 : h2 * g2 = 1) : (h2 * h1) * (g1 * g2) = 1 :=
  NecSuf.invertible_product_left_inverse' mul_identity_matrix hh1 hh2

/-- `invertible_product_isUnit` を、2 本の鎖を `NecSuf.invertible_product_right_inverse'`・`NecSuf.invertible_product_left_inverse'`
（`α := Matrix (Fin n) (Fin n) ℂ`）の特殊化として組んで得る（`h := g_2^{-1}g_1^{-1}`）。 -/
theorem invertible_product_isUnit_of_necSuf {n : ℕ} {g1 g2 : Matrix (Fin n) (Fin n) ℂ}
    (hg1 : IsUnit g1) (hg2 : IsUnit g2) : IsUnit (g1 * g2) := by
  obtain ⟨u1, rfl⟩ := hg1
  obtain ⟨u2, rfl⟩ := hg2
  exact ⟨⟨(u1 : Matrix (Fin n) (Fin n) ℂ) * u2, ((u2⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ)
      * ((u1⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ),
    invertible_product_right_inverse_of_necSuf u1.mul_inv u2.mul_inv,
    invertible_product_left_inverse_of_necSuf u1.inv_mul u2.inv_mul⟩, rfl⟩

/-- `def_invertible_elements_of_R` (ii) の `TensorPow M` での系: `g_1, g_2 ∈ R^×` なら `g_1g_2 ∈ R^×`
（`h := g_2^{-1}g_1^{-1}` の 2 本の鎖は `NecSuf.invertible_product_right_inverse'`・`NecSuf.invertible_product_left_inverse'` の
添字 `Conf M` の特殊化。右単位元は `mul_identity_matrix_tensorPow`）。 -/
theorem invertible_product_isUnit_tensorPow {M : ℕ} {g1 g2 : TensorPow M}
    (hg1 : IsUnit g1) (hg2 : IsUnit g2) : IsUnit (g1 * g2) := by
  obtain ⟨u1, rfl⟩ := hg1
  obtain ⟨u2, rfl⟩ := hg2
  exact ⟨⟨(u1 : TensorPow M) * u2, ((u2⁻¹ : (TensorPow M)ˣ) : TensorPow M) * ((u1⁻¹ : (TensorPow M)ˣ) : TensorPow M),
    NecSuf.invertible_product_right_inverse' mul_identity_matrix_tensorPow u1.mul_inv u2.mul_inv,
    NecSuf.invertible_product_left_inverse' mul_identity_matrix_tensorPow u1.inv_mul u2.inv_mul⟩, rfl⟩

end Ising2D
