/-
# エルミート行列の実数倍はエルミート（具体版を必要十分版から導く）

具体版 `real_multiple_isHermitian` の主張を、必要十分版
`Ising2D/NecSuf/StarFixedScalarMultipleOfHermitian.lean` の `star_fixed_smul_isHermitian` の係数 `R := ℂ`、
`α := α_ℂ`（`α ∈ ℝ`）の特殊化として得る。積と共役の仮定 `hmul` は人手 `complex_conjugate_of_product`（mathlib の `star_mul'`）、共役で動かないこと `hα` は、人手 `complex_conjugate_of_real_inclusion`
（具体版 `complex_conjugate_of_real_inclusion`）である。人手のラベルは `real_multiple_of_hermitian_is_hermitian`。
-/
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimRealMultipleOfHermitianIsHermitian
import Ising2D.NecSuf.StarFixedScalarMultipleOfHermitian

namespace Ising2D

/-- `real_multiple_isHermitian` を `NecSuf.star_fixed_smul_isHermitian` の特殊化として得る。 -/
theorem real_multiple_isHermitian_of_necSuf {n : Type*} (α : ℝ) {A : Matrix n n ℂ} (hA : A.IsHermitian) :
    ((α : ℂ) • A).IsHermitian :=
  NecSuf.star_fixed_smul_isHermitian (fun a => star_mul' _ a) (complex_conjugate_of_real_inclusion α) hA.eq

end Ising2D
