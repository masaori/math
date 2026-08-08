/-
具体版が必要十分版の特殊化として得られることの明示（`lean/README.md` の要件 4）。

必要十分版 `NecSuf.TransferMatrix.matPow_apply_eq_sum_walkWeight` に
  S := ℤ[x]（可換半環として使う。環であることは使わない）、ι := RowConfig L
を代入すると、具体版 `TransferMatrix.rowMatrixPow_apply` がそのまま出る。
両者の定義（行列・積・冪・道・道の重み・両端を指定した道の全体）は 1 つずつ一致しており、
その一致もこのファイルで述べる。

このことは、冪の成分表示の証明が「値の側が可換半環であること」と
「添字の側が相等の判定できる有限型であること」しか使っておらず、
多項式であること・係数が ℤ であること・成分が不定元の冪であること・添字が行配位であること・
格子の形を使っていないという主張の裏取りになっている。

住処: ℤ[x] のみ。ℝ / ℂ は現れない。
-/
import Ising2DLambda.TransferMatrix.PowerEntry
import Ising2DLambda.NecSuf.TransferMatrix.PowerEntry

namespace Ising2DLambda.TransferMatrix

open Finset PartitionPolynomial

variable (L : ℕ) [NeZero L]

/-- 行列の積が一致する。 -/
lemma rowMatrixProduct_eq_matProduct (A B : RowMatrix L) :
    rowMatrixProduct L A B = NecSuf.TransferMatrix.matProduct A B := rfl

/-- 行列の冪が一致する（引数のずらし方も同じ）。 -/
lemma rowMatrixPow_eq_matPow (A : RowMatrix L) (m : ℕ) :
    rowMatrixPow L A m = NecSuf.TransferMatrix.matPow A m := by
  induction m with
  | zero => rfl
  | succ m ih =>
      rw [rowMatrixPow_succ, ih, rowMatrixProduct_eq_matProduct]
      rfl

omit [NeZero L] in
/-- 道の重みが一致する。 -/
lemma walkWeight_eq (A : RowMatrix L) {k : ℕ} (p : RowWalk L k) :
    walkWeight L A p = NecSuf.TransferMatrix.walkWeight A p := rfl

/-- 両端を指定した道の全体が一致する。 -/
lemma rowWalksBetween_eq (k : ℕ) (τ τ'' : RowConfig L) :
    rowWalksBetween L k τ τ'' = NecSuf.TransferMatrix.walksBetween k τ τ'' := rfl

/-- 具体版の定理を、必要十分版から導いたもの。 -/
theorem rowMatrixPow_apply_from_necSuf (A : RowMatrix L) (m : ℕ) (τ τ'' : RowConfig L) :
    rowMatrixPow L A m τ τ''
      = ∑ p ∈ rowWalksBetween L (m + 1) τ τ'', walkWeight L A p := by
  rw [rowMatrixPow_eq_matPow, rowWalksBetween_eq]
  exact NecSuf.TransferMatrix.matPow_apply_eq_sum_walkWeight
    (S := Polynomial ℤ) (ι := RowConfig L) A m τ τ''

end Ising2DLambda.TransferMatrix
