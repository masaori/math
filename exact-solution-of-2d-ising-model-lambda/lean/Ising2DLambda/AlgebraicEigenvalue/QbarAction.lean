/-
章「固有値の代数性」の「代数的数を成分とする行列と列ベクトル、およびその作用」の具体版
（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは定義 4 件
（`def_qbar_matrix` / `def_qbar_matrix_product` / `def_qbar_vector` /
`def_qbar_matrix_action`）と主張 1 件（`claim_qbar_action_product`）に対応する。

  人手証明                                このファイル
  Mat_{R_L}(Qbar)                         QbarRowMatrix
  行列の積 AB                             qbarRowMatrixProduct
  列ベクトルの全体 V_L                    QbarRowVector
  作用 A·v                                qbarAction
  鎖の第 1 段（作用の定義）               qbarAction の展開（rfl）
  鎖の第 2 段（積の定義）                 qbarRowMatrixProduct の展開（rfl）
  鎖の第 3 段（有限和と元の積の分配則）   Finset.sum_mul
  鎖の第 4 段（積の結合則）               mul_assoc
  鎖の第 5 段（有限和の順序の入れ替え）   Finset.sum_comm
  鎖の第 6 段（元と有限和の積の分配則）   Finset.mul_sum
  鎖の第 7・8 段（作用の定義へ戻す）      qbarAction の折りたたみ（rfl）

mathlib の `Matrix.mulVec` とその一般論（`Matrix.mulVec_mulVec` 等）へは委ねず、
人手証明の鎖をそのまま書く。

住処: 人手証明のこれらのブロックは Qbar を宣言している。
ここに ℝ / ℂ は現れない（成分は ℚ の代数閉包の元、添字は行配位）。
-/
import Mathlib.Algebra.BigOperators.Ring.Finset
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnity
import Ising2DLambda.TransferMatrix.Basic

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset Ising2DLambda.TransferMatrix

variable (L : ℕ)

/-- 代数的数を成分とし、行と列を行配位で添字づけた行列（`def_qbar_matrix`）。 -/
def QbarRowMatrix : Type := RowConfig L → RowConfig L → Qbar

/-- 代数的数を成分とする行列の積（`def_qbar_matrix_product`）。 -/
noncomputable def qbarRowMatrixProduct [NeZero L]
    (A B : QbarRowMatrix L) : QbarRowMatrix L :=
  fun τ τ'' => ∑ τ' : RowConfig L, A τ τ' * B τ' τ''

/-- 代数的数を成分とする列ベクトル（`def_qbar_vector`）。 -/
def QbarRowVector : Type := RowConfig L → Qbar

/-- 行列の列ベクトルへの作用 `A·v`（`def_qbar_matrix_action`）。 -/
noncomputable def qbarAction [NeZero L]
    (A : QbarRowMatrix L) (v : QbarRowVector L) : QbarRowVector L :=
  fun τ => ∑ τ' : RowConfig L, A τ τ' * v τ'

/-- 人手証明の本体。`(AB)·v = A·(B·v)`（`claim_qbar_action_product`）。
両辺は `R_L` 上の写像なので、`τ` を任意に取ってその値が等しいことを示す。 -/
theorem qbarAction_product [NeZero L]
    (A B : QbarRowMatrix L) (v : QbarRowVector L) :
    qbarAction L (qbarRowMatrixProduct L A B) v = qbarAction L A (qbarAction L B v) := by
  funext τ
  calc qbarAction L (qbarRowMatrixProduct L A B) v τ
      = ∑ τ'' : RowConfig L, (qbarRowMatrixProduct L A B) τ τ'' * v τ'' := rfl
        -- 第 1 段。作用の定義。
    _ = ∑ τ'' : RowConfig L, (∑ τ' : RowConfig L, A τ τ' * B τ' τ'') * v τ'' := rfl
        -- 第 2 段。積の定義。
    _ = ∑ τ'' : RowConfig L, ∑ τ' : RowConfig L, (A τ τ' * B τ' τ'') * v τ'' :=
        sum_congr rfl fun τ'' _ => sum_mul _ _ _
        -- 第 3 段。有限和と元の積についての分配則。
    _ = ∑ τ'' : RowConfig L, ∑ τ' : RowConfig L, A τ τ' * (B τ' τ'' * v τ'') :=
        sum_congr rfl fun τ'' _ => sum_congr rfl fun τ' _ => mul_assoc _ _ _
        -- 第 4 段。積の結合則。
    _ = ∑ τ' : RowConfig L, ∑ τ'' : RowConfig L, A τ τ' * (B τ' τ'' * v τ'') := sum_comm
        -- 第 5 段。有限和の順序の入れ替え。
    _ = ∑ τ' : RowConfig L, A τ τ' * ∑ τ'' : RowConfig L, B τ' τ'' * v τ'' :=
        sum_congr rfl fun τ' _ => (mul_sum _ _ _).symm
        -- 第 6 段。元と有限和の積についての分配則。
    _ = ∑ τ' : RowConfig L, A τ τ' * (qbarAction L B v) τ' := rfl
        -- 第 7 段。作用の定義。
    _ = qbarAction L A (qbarAction L B v) τ := rfl
        -- 第 8 段。作用の定義。

end Ising2DLambda.AlgebraicEigenvalue
