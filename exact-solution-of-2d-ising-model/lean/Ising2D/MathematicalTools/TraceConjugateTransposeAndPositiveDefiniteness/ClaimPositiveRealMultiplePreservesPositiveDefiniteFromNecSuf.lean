/-
# 正定値行列の正の実数倍は正定値（具体版を必要十分版から導く）

具体版 `ClaimPositiveRealMultiplePreservesPositiveDefinite.lean` の主張を、必要十分版
`Ising2D/NecSuf/PositiveMultiplePreservesPositiveDefinite.lean` の係数 `R := ℂ`、`S := ℝ`、包含 `ι := (·)_ℂ`、添字 `Fin n` の
特殊化として得る。エルミート性は `NecSuf/StarFixedScalarMultipleOfHermitian.lean` の特殊化（`real_multiple_isHermitian_of_necSuf` と同じ）、
包含が積を保つこと `hincl` は人手 `real_inclusion_preserves_product`（具体版 `real_inclusion_mul`）、
`α_ℂ` が交換すること `hcomm` は `ℂ` の積の可換律（`complex_numbers_form_a_field`）である。
人手のラベルは `positive_real_multiple_preserves_positive_definite`。

`TensorPow M`（添字 `Conf M`）の具体版 `ClaimTensorPowPositiveDefiniteCongruenceRealMultipleAndTrace.lean` の `positive_real_multiple_preserves_positive_definite_tensorPow` も、
同じ必要十分版の添字 `Conf M` の特殊化として得る（`positive_real_multiple_preserves_positive_definite_tensorPow_of_necSuf`）。
-/
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimPositiveRealMultiplePreservesPositiveDefinite
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimCongruencePreservesPositiveDefiniteFromNecSuf
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesProduct
import Ising2D.NecSuf.PositiveMultiplePreservesPositiveDefinite
import Ising2D.NecSuf.StarFixedScalarMultipleOfHermitian

namespace Ising2D

open Matrix
open scoped ComplexOrder

/-- 添字が任意の有限型の行列について、mathlib の `Matrix.PosDef` で述べた `positive_real_multiple_preserves_positive_definite` を必要十分版のエルミート性の段
`NecSuf.star_fixed_smul_isHermitian` と正値性の段 `NecSuf.smul_preserves_pos'` の特殊化として得る。 -/
theorem positive_real_multiple_preserves_positive_definite_of_necSuf' {ι : Type*} [Fintype ι] [DecidableEq ι]
    {A : Matrix ι ι ℂ} (hA : A.PosDef) {α : ℝ} (hα : 0 < α) : ((α : ℂ) • A).PosDef :=
  posDef_of_conjBilin'_pos
    (NecSuf.star_fixed_smul_isHermitian (complex_conjugate_of_product_eq _) (complex_conjugate_of_real_inclusion α)
      hA.isHermitian.eq)
    (NecSuf.smul_preserves_pos' realInclusionAddHom (fun a b => real_inclusion_mul a b) hα
      (fun y => mul_comm y _) (posDef_conjBilin'_pos hA))

/-- `positive_real_multiple_preserves_positive_definite`（添字 `Fin n`）を必要十分版の特殊化として得る。 -/
theorem positive_real_multiple_preserves_positive_definite_of_necSuf {n : ℕ} {A : Matrix (Fin n) (Fin n) ℂ}
    (hA : (Aᴴ = A ∧ ∀ x : Fin n → ℂ, x ≠ 0 → ∃ r : ℝ, 0 < r ∧ conjugateBilinearValue x A x = (r : ℂ))) {α : ℝ} (hα : 0 < α) :
    (((α : ℂ) • A)ᴴ = (α : ℂ) • A ∧
      ∀ x : Fin n → ℂ, x ≠ 0 → ∃ r : ℝ, 0 < r ∧ conjugateBilinearValue x ((α : ℂ) • A) x = (r : ℂ)) :=
  ⟨NecSuf.star_fixed_smul_isHermitian (complex_conjugate_of_product_eq _) (complex_conjugate_of_real_inclusion α) hA.1,
    NecSuf.smul_preserves_pos' realInclusionAddHom (fun a b => real_inclusion_mul a b) hα (fun y => mul_comm y _) hA.2⟩

/-- `positive_real_multiple_preserves_positive_definite` の `TensorPow M` の具体版を、必要十分版の添字 `Conf M` の特殊化として得る。 -/
theorem positive_real_multiple_preserves_positive_definite_tensorPow_of_necSuf {M : ℕ} {A : TensorPow M}
    (hA : IsPositiveDefiniteTensorPow A) {α : ℝ} (hα : 0 < α) : IsPositiveDefiniteTensorPow ((α : ℂ) • A) :=
  ⟨NecSuf.star_fixed_smul_isHermitian (complex_conjugate_of_product_eq _) (complex_conjugate_of_real_inclusion α) hA.1,
    NecSuf.smul_preserves_pos' realInclusionAddHom (fun a b => real_inclusion_mul a b) hα (fun y => mul_comm y _) hA.2⟩

end Ising2D
