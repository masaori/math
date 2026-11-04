/-
# 正定値行列のトレースは正（具体版を必要十分版から導く）

具体版 `ClaimTraceOfPositiveDefiniteIsPositive.lean` の主張を、必要十分版 `Ising2D/NecSuf/TraceOfPositiveDefinite.lean` の
係数 `R := ℂ`、`S := ℝ`、包含 `ι := (·)_ℂ`、添字 `Fin n` の特殊化として得る。人手のラベルは `trace_of_positive_definite_is_positive`。

`TensorPow M`（添字 `Conf M`）の系も同じ必要十分版の特殊化として置く。具体版は添字が `Fin n` の行列について述べてあり、
`Conf M` の行列には当てはまらないためである。
-/
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimTraceOfPositiveDefiniteIsPositive
import Ising2D.NecSuf.TraceOfPositiveDefinite
import Ising2D.Representation

namespace Ising2D

open Matrix
open scoped ComplexOrder

/-- 包含 `(·)_ℂ : ℝ → ℂ` を和を保つ写像として。 -/
noncomputable def realInclusionAddHom : ℝ →+ ℂ := Complex.ofRealHom.toAddMonoidHom

/-- mathlib の `Matrix.PosDef` を、必要十分版の正定値の仮定の形（`x^*Ax = (r)_ℂ`、`r > 0`）に読む（添字は任意の有限型）。 -/
theorem posDef_conjBilin'_pos {ι : Type*} [Fintype ι] [DecidableEq ι] {A : Matrix ι ι ℂ} (hA : A.PosDef)
    (x : ι → ℂ) (hx : x ≠ 0) : ∃ r : ℝ, 0 < r ∧ NecSuf.conjBilin' x A x = realInclusionAddHom r := by
  have h := Complex.pos_iff.mp (hA.dotProduct_mulVec_pos hx)
  have heq : star x ⬝ᵥ (A *ᵥ x) = NecSuf.conjBilin' x A x := by
    unfold NecSuf.conjBilin'
    simp only [dotProduct, mulVec, Pi.star_apply, Finset.mul_sum, mul_assoc]
  rw [heq] at h
  exact ⟨(NecSuf.conjBilin' x A x).re, h.1, Complex.ext rfl h.2.symm⟩

/-- `trace_of_positive_definite_is_positive` を `NecSuf.trace_pos_of_conjBilin_pos'`（係数 `ℂ`、添字 `Fin n`）の特殊化として得る。 -/
theorem trace_of_positive_definite_is_positive_of_necSuf {n : ℕ} (hn : 1 ≤ n) (A : Matrix (Fin n) (Fin n) ℂ)
    (hA : A.PosDef) : ∃ s : ℝ, 0 < s ∧ A.trace = (s : ℂ) := by
  haveI : Nonempty (Fin n) := ⟨⟨0, hn⟩⟩
  exact NecSuf.trace_pos_of_conjBilin_pos' (star_one ℂ) (star_zero ℂ) realInclusionAddHom A (posDef_conjBilin'_pos hA)

/-- `trace_of_positive_definite_is_positive` の `TensorPow M` での系（`NecSuf.trace_pos_of_conjBilin_pos'` の添字 `Conf M` の特殊化）。 -/
theorem trace_of_positive_definite_is_positive_tensorPow {M : ℕ} (A : TensorPow M) (hA : A.PosDef) :
    ∃ s : ℝ, 0 < s ∧ A.trace = (s : ℂ) := by
  haveI : Nonempty (Conf M) := ⟨fun _ => 0⟩
  exact NecSuf.trace_pos_of_conjBilin_pos' (star_one ℂ) (star_zero ℂ) realInclusionAddHom A (posDef_conjBilin'_pos hA)

end Ising2D
