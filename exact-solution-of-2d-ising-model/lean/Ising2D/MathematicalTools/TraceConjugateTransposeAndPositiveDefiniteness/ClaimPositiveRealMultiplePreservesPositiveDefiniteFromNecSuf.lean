/-
# 正定値行列の正の実数倍は正定値（具体版を必要十分版から導く）

具体版 `ClaimPositiveRealMultiplePreservesPositiveDefinite.lean` の主張を、必要十分版
`Ising2D/NecSuf/PositiveMultiplePreservesPositiveDefinite.lean` の係数 `R := ℂ`、`S := ℝ`、包含 `ι := (·)_ℂ`、添字 `Fin n` の
特殊化として得る。エルミート性は `NecSuf/StarFixedScalarMultipleOfHermitian.lean` の特殊化（`real_multiple_isHermitian_of_necSuf` と同じ）、
包含が積を保つこと `hincl` は人手 `real_inclusion_preserves_product`（具体版 `real_inclusion_mul`）、
`α_ℂ` が交換すること `hcomm` は `ℂ` の積の可換律（`complex_numbers_form_a_field`）である。
人手のラベルは `positive_real_multiple_preserves_positive_definite`。

`TensorPow M`（添字 `Conf M`）の系も同じ必要十分版の特殊化として置く。具体版は添字が `Fin n` の行列について述べてあり、
`Conf M` の行列には当てはまらないためである。
-/
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimPositiveRealMultiplePreservesPositiveDefinite
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimCongruencePreservesPositiveDefiniteFromNecSuf
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesProduct
import Ising2D.NecSuf.PositiveMultiplePreservesPositiveDefinite
import Ising2D.NecSuf.StarFixedScalarMultipleOfHermitian

namespace Ising2D

open Matrix
open scoped ComplexOrder

/-- 添字が任意の有限型の行列について、`positive_real_multiple_preserves_positive_definite` を必要十分版のエルミート性の段
`NecSuf.star_fixed_smul_isHermitian` と正値性の段 `NecSuf.smul_preserves_pos'` の特殊化として得る。 -/
theorem positive_real_multiple_preserves_positive_definite_of_necSuf' {ι : Type*} [Fintype ι] [DecidableEq ι]
    {A : Matrix ι ι ℂ} (hA : A.PosDef) {α : ℝ} (hα : 0 < α) : ((α : ℂ) • A).PosDef :=
  posDef_of_conjBilin'_pos
    (NecSuf.star_fixed_smul_isHermitian (fun a => star_mul' _ a) (complex_conjugate_of_real_inclusion α)
      hA.isHermitian.eq)
    (NecSuf.smul_preserves_pos' realInclusionAddHom (fun a b => real_inclusion_mul a b) hα
      (fun y => mul_comm y _) (posDef_conjBilin'_pos hA))

/-- `positive_real_multiple_preserves_positive_definite`（添字 `Fin n`）を必要十分版の特殊化として得る。 -/
theorem positive_real_multiple_preserves_positive_definite_of_necSuf {n : ℕ} {A : Matrix (Fin n) (Fin n) ℂ}
    (hA : A.PosDef) {α : ℝ} (hα : 0 < α) : ((α : ℂ) • A).PosDef :=
  positive_real_multiple_preserves_positive_definite_of_necSuf' hA hα

/-- `positive_real_multiple_preserves_positive_definite` の `TensorPow M` での系（必要十分版の添字 `Conf M` の特殊化）。 -/
theorem positive_real_multiple_preserves_positive_definite_tensorPow {M : ℕ} {A : TensorPow M}
    (hA : A.PosDef) {α : ℝ} (hα : 0 < α) : ((α : ℂ) • A).PosDef :=
  positive_real_multiple_preserves_positive_definite_of_necSuf' hA hα

end Ising2D
