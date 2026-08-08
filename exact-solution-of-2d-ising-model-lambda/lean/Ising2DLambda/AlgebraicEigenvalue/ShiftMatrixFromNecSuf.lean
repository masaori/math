/-
具体版が必要十分版の特殊化として得られることの明示（`lean/README.md` の要件 4）。

シフト行列そのもの: 必要十分版 `NecSuf.AlgebraicEigenvalue.permMatrix` に
  ι := RowConfig L、S := Polynomial ℤ、e := rowShiftEquiv L
を代入すると、具体版 `AlgebraicEigenvalue.shiftMatrix` と同じ行列が出る
（`κ(1)` と `κ(0)` が `Polynomial ℤ` の単位元と零元であることだけを使う）。

左から掛ける主張・右から掛ける主張・可換性も、同じ代入で出る。可換性へ渡す仮定は
  ∀ τ τ', T (S τ) (S τ') = T τ τ'
であり、これは人手証明の `claim_transfer_matrix_shift_invariant`（Lean では
`transferMatrix_rowShift`）そのものである。

このことは、具体版の証明が次を使っていないという主張の裏取りになっている。
行配位であること・格子の形・スピンの値が ±1 であること・成分が多項式であること・
成分が不定元の冪であること・シフトが巡回であること・`ℤ[x]` の分配則・積の結合則・
積の可換性・引き算。とくに **`A` が転送行列であることは使っておらず、
シフトで不変な行列であれば何でもシフト行列と可換になる**。

住処: ℤ / ℤ[x] のみ。ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.ShiftMatrix
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.ShiftMatrix

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 具体版の `U` が、必要十分版の置換行列の特殊化であること。 -/
theorem shiftMatrix_eq_necSuf (τ τ' : RowConfig L) :
    shiftMatrix L τ τ'
      = NecSuf.AlgebraicEigenvalue.permMatrix (S := Polynomial ℤ) (rowShiftEquiv L) τ τ' := by
  classical
  show (if τ' = rowShift L τ then constPoly 1 else constPoly 0)
    = if τ' = rowShiftEquiv L τ then (1 : Polynomial ℤ) else (0 : Polynomial ℤ)
  -- `rowShiftEquiv L τ` は `rowShift L τ` そのもの（`toFun` に置いた）なので、
  -- 場合分けの条件は同じものである。
  by_cases h : τ' = rowShift L τ
  · rw [if_pos h, if_pos (show τ' = rowShiftEquiv L τ from h), constPoly_one]
  · rw [if_neg h, if_neg (show ¬ (τ' = rowShiftEquiv L τ) from h), constPoly_zero]

/-- 左から掛ける主張を、必要十分版から導いたもの。 -/
theorem shiftMatrix_mul_apply_from_necSuf (A : RowMatrix L) (τ τ'' : RowConfig L) :
    rowMatrixProduct L (shiftMatrix L) A τ τ'' = A (rowShift L τ) τ'' := by
  classical
  show (∑ τ' : RowConfig L, shiftMatrix L τ τ' * A τ' τ'') = A (rowShift L τ) τ''
  have : (∑ τ' : RowConfig L, shiftMatrix L τ τ' * A τ' τ'')
      = ∑ τ' : RowConfig L,
          NecSuf.AlgebraicEigenvalue.permMatrix (S := Polynomial ℤ)
            (rowShiftEquiv L) τ τ' * A τ' τ'' := by
    refine Finset.sum_congr rfl fun τ' _ => ?_
    rw [shiftMatrix_eq_necSuf]
  rw [this]
  exact NecSuf.AlgebraicEigenvalue.permMatrix_mul_apply (rowShiftEquiv L) A τ τ''

/-- 右から掛ける主張を、必要十分版から導いたもの。 -/
theorem mul_shiftMatrix_apply_from_necSuf (A : RowMatrix L) (τ τ'' : RowConfig L) :
    rowMatrixProduct L A (shiftMatrix L) τ τ'' = A τ ((rowShiftEquiv L).symm τ'') := by
  classical
  show (∑ τ' : RowConfig L, A τ τ' * shiftMatrix L τ' τ'')
    = A τ ((rowShiftEquiv L).symm τ'')
  have : (∑ τ' : RowConfig L, A τ τ' * shiftMatrix L τ' τ'')
      = ∑ τ' : RowConfig L, A τ τ' *
          NecSuf.AlgebraicEigenvalue.permMatrix (S := Polynomial ℤ)
            (rowShiftEquiv L) τ' τ'' := by
    refine Finset.sum_congr rfl fun τ' _ => ?_
    rw [shiftMatrix_eq_necSuf]
  rw [this]
  exact NecSuf.AlgebraicEigenvalue.mul_permMatrix_apply (rowShiftEquiv L) A τ τ''

/-- 可換性を、必要十分版から導いたもの。

必要十分版へ渡す仮定は転送行列のシフト不変性 `transferMatrix_rowShift` ただ 1 つである。 -/
theorem shiftMatrix_transferMatrix_comm_from_necSuf :
    rowMatrixProduct L (shiftMatrix L) (transferMatrix L)
      = rowMatrixProduct L (transferMatrix L) (shiftMatrix L) := by
  classical
  funext τ τ''
  rw [shiftMatrix_mul_apply_from_necSuf, mul_shiftMatrix_apply_from_necSuf]
  have hA : ∀ a b : RowConfig L,
      transferMatrix L (rowShiftEquiv L a) (rowShiftEquiv L b) = transferMatrix L a b :=
    fun a b => transferMatrix_rowShift a b
  have := NecSuf.AlgebraicEigenvalue.permMatrix_comm (S := Polynomial ℤ)
    (rowShiftEquiv L) (transferMatrix L) hA τ τ''
  rw [NecSuf.AlgebraicEigenvalue.permMatrix_mul_apply,
    NecSuf.AlgebraicEigenvalue.mul_permMatrix_apply] at this
  exact this

end Ising2DLambda.AlgebraicEigenvalue
