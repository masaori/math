/-
# 左逆行列をもつ `B` による `B^*(AB)` は正定値（具体版を必要十分版から導く）

具体版 `ClaimCongruencePreservesPositiveDefinite.lean` の主張を、必要十分版 `Ising2D/NecSuf/CongruencePreservesPositiveDefinite.lean` の
係数 `R := ℂ`、述語 `P(z) := (z = r_ℂ を満たす r ∈ ℝ_{>0} がある)`、添字 `Fin n` の特殊化として得る。
人手のラベルは `conjugate_bilinear_value_of_congruence`・`congruence_preserves_positive_definite`。

`TensorPow M`（添字 `Conf M`）の系も同じ必要十分版の特殊化として置く。具体版は添字が `Fin n` の行列について述べてあり、
`Conf M` の行列には当てはまらないためである。
-/
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimCongruencePreservesPositiveDefinite
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimTraceOfPositiveDefiniteIsPositiveFromNecSuf
import Ising2D.NecSuf.CongruencePreservesPositiveDefinite

namespace Ising2D

open Matrix
open scoped ComplexOrder

/-- 具体版の `x^*Ay`（`conjugateBilinearValue`）と必要十分版の `x^*Ay`（`NecSuf.conjBilin'`）は同じ式である。 -/
theorem conjugateBilinearValue_eq_conjBilin' {n : ℕ} (x : Fin n → ℂ) (A : Matrix (Fin n) (Fin n) ℂ) (y : Fin n → ℂ) :
    conjugateBilinearValue x A y = NecSuf.conjBilin' x A y := rfl

/-- `conjugate_bilinear_value_of_congruence` を `NecSuf.conjBilin_congruence'`（係数 `ℂ`、添字 `Fin n`）の特殊化として得る。 -/
theorem conjugate_bilinear_value_of_congruence_of_necSuf {n : ℕ} (A B : Matrix (Fin n) (Fin n) ℂ) (x y : Fin n → ℂ) :
    conjugateBilinearValue x (Bᴴ * (A * B)) y = conjugateBilinearValue (B *ᵥ x) A (B *ᵥ y) :=
  NecSuf.conjBilin_congruence' A B x y

/-- 必要十分版の正値性の述語 `P` の形（`x^*Ax = (r)_ℂ`、`r > 0`）から mathlib の `Matrix.PosDef` を得る（添字は任意の有限型。
`posDef_conjBilin'_pos` の逆向き）。 -/
theorem posDef_of_conjBilin'_pos {ι : Type*} [Fintype ι] [DecidableEq ι] {A : Matrix ι ι ℂ} (hH : Aᴴ = A)
    (hpos : ∀ x : ι → ℂ, x ≠ 0 → ∃ r : ℝ, 0 < r ∧ NecSuf.conjBilin' x A x = realInclusionAddHom r) :
    A.PosDef := by
  refine Matrix.PosDef.of_dotProduct_mulVec_pos hH fun x hx => ?_
  obtain ⟨r, hr, hval⟩ := hpos x hx
  have heq : star x ⬝ᵥ (A *ᵥ x) = NecSuf.conjBilin' x A x := by
    unfold NecSuf.conjBilin'
    simp only [dotProduct, mulVec, Pi.star_apply, Finset.mul_sum, mul_assoc]
  rw [heq, hval]
  exact Complex.zero_lt_real.mpr hr

/-- 添字が任意の有限型の行列について、`congruence_preserves_positive_definite` を必要十分版のエルミート性の段
`NecSuf.congruence_isHermitian'` と正値性の段 `NecSuf.congruence_preserves_pos'` の特殊化として得る。 -/
theorem congruence_preserves_positive_definite_of_necSuf' {ι : Type*} [Fintype ι] [DecidableEq ι]
    {A B B' : Matrix ι ι ℂ} (hA : A.PosDef) (hB : B' * B = 1) : (Bᴴ * (A * B)).PosDef :=
  posDef_of_conjBilin'_pos (NecSuf.congruence_isHermitian' hA.isHermitian.eq B)
    (NecSuf.congruence_preserves_pos' (fun z => ∃ r : ℝ, 0 < r ∧ z = realInclusionAddHom r) hB
      (posDef_conjBilin'_pos hA))

/-- `congruence_preserves_positive_definite`（添字 `Fin n`）を必要十分版の特殊化として得る。 -/
theorem congruence_preserves_positive_definite_of_necSuf {n : ℕ} {A B B' : Matrix (Fin n) (Fin n) ℂ}
    (hA : A.PosDef) (hB : B' * B = 1) : (Bᴴ * (A * B)).PosDef :=
  congruence_preserves_positive_definite_of_necSuf' hA hB

/-- `congruence_preserves_positive_definite` の `TensorPow M` での系（必要十分版の添字 `Conf M` の特殊化）。 -/
theorem congruence_preserves_positive_definite_tensorPow {M : ℕ} {A B B' : TensorPow M}
    (hA : A.PosDef) (hB : B' * B = 1) : (Bᴴ * (A * B)).PosDef :=
  congruence_preserves_positive_definite_of_necSuf' hA hB

end Ising2D
