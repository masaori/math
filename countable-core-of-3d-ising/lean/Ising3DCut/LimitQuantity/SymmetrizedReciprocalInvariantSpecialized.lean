/-
「対称化した列は q↔1/q で不変である（有限箱の等式）」の Lean 具体版：特殊化。
一般の重複度列についての `reflect_polyOfMultiplicity_eq` に、本文の重複度
（零モデルの `multiplicity L`、および構造コアの `multiplicity S`）と辺数を渡し、
それぞれの回文性（`multiplicity_palindrome` / `multiplicity_palindrome_from_necSuf`）から
分配多項式が `reflect E` で不変であることを得る。

住処: 有限型、`Finset`、`ℚ[X]` の係数操作のみ。ℝ / ℂ は現れない。
-/
import Mathlib.Algebra.Polynomial.BigOperators
import Ising3DCut.LimitQuantity.SymmetrizedReciprocalInvariantPolyOfMultiplicity
import Ising3DCut.NullModel.MultiplicityPalindrome
import Ising3DCut.StructuralCore.BipartiteSuccessorPalindromeFromNecSuf

namespace Ising3DCut.LimitQuantity

open Polynomial

/-- 零モデル：$Z_L=\sum_{m\le E}\Omega_L(m)X^m$ は `reflect E` で不変。 -/
theorem reflect_nullModel_poly_eq (L : ℕ) :
    reflect (Fintype.card (NullModel.Edge L))
        (polyOfMultiplicity (Fintype.card (NullModel.Edge L)) (NullModel.multiplicity L)) =
      polyOfMultiplicity (Fintype.card (NullModel.Edge L)) (NullModel.multiplicity L) :=
  reflect_polyOfMultiplicity_eq (fun _ hm => NullModel.multiplicity_palindrome hm)

/-- 構造コア：有限二部後続系 `S` の分配多項式は `reflect (#StructuralEdge S)` で不変。 -/
theorem reflect_structuralCore_poly_eq {V I : Type} [Fintype V] [Fintype I]
    [DecidableEq V] [DecidableEq I] (S : StructuralCore.BipartiteSuccessorSystem V I) :
    reflect (Fintype.card (StructuralCore.StructuralEdge S))
        (polyOfMultiplicity (Fintype.card (StructuralCore.StructuralEdge S))
          (StructuralCore.multiplicity S)) =
      polyOfMultiplicity (Fintype.card (StructuralCore.StructuralEdge S))
        (StructuralCore.multiplicity S) :=
  reflect_polyOfMultiplicity_eq
    (fun _ hm => StructuralCore.multiplicity_palindrome_from_necSuf S hm)

end Ising3DCut.LimitQuantity

namespace Ising3DCut.LimitQuantity

open Polynomial

/-- 重複度列から作った多項式の次数は辺数 `E` を超えない（束ねた定理の次数仮定へ渡す）。 -/
theorem natDegree_polyOfMultiplicity_le (E : ℕ) (Ω : ℕ → ℕ) :
    (polyOfMultiplicity E Ω).natDegree ≤ E := by
  unfold polyOfMultiplicity
  apply natDegree_sum_le_of_forall_le
  intro m hm
  exact (natDegree_C_mul_X_pow_le _ _).trans (Nat.le_of_lt_succ (Finset.mem_range.mp hm))

end Ising3DCut.LimitQuantity
