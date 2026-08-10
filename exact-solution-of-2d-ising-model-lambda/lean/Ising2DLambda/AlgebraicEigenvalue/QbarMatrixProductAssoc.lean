/-
章「固有値の代数性」の主張「代数的数を成分とする行列の積は結合的である」の具体版
（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは主張 1 件
（`claim_qbar_matrix_product_assoc`）に対応する。

  人手証明                                このファイル
  鎖の第 1 段（積の定義）                 qbarRowMatrixProduct の展開（rfl）
  鎖の第 2 段（積の定義）                 qbarRowMatrixProduct の展開（rfl）
  鎖の第 3 段（有限和と元の積の分配則）   Finset.sum_mul
  鎖の第 4 段（積の結合則）               mul_assoc
  鎖の第 5 段（有限和の順序の入れ替え）   Finset.sum_comm
  鎖の第 6 段（元と有限和の積の分配則）   Finset.mul_sum
  鎖の第 7・8 段（積の定義へ戻す）        qbarRowMatrixProduct の折りたたみ（rfl）

mathlib の `Matrix.mul_assoc`（`Matrix` の半環構造）へは委ねず、人手証明の鎖をそのまま書く。

住処: 人手証明のこのブロックは Qbar を宣言している。
ここに ℝ / ℂ は現れない（成分は ℚ の代数閉包の元、添字は行配位）。
-/
import Mathlib.Algebra.BigOperators.Ring.Finset
import Ising2DLambda.AlgebraicEigenvalue.QbarAction

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset Ising2DLambda.TransferMatrix

/-- 人手証明の本体。`(AB)C = A(BC)`（`claim_qbar_matrix_product_assoc`）。
両辺は `R_L × R_L` 上の写像なので、`τ` と `τ'''` を任意に取ってその成分が等しいことを示す。 -/
theorem qbarMatrixProduct_assoc (L : ℕ) [NeZero L]
    (A B C : QbarRowMatrix L) :
    qbarRowMatrixProduct L (qbarRowMatrixProduct L A B) C
      = qbarRowMatrixProduct L A (qbarRowMatrixProduct L B C) := by
  funext τ τ'''
  calc qbarRowMatrixProduct L (qbarRowMatrixProduct L A B) C τ τ'''
      = ∑ τ'' : RowConfig L, (qbarRowMatrixProduct L A B) τ τ'' * C τ'' τ''' := rfl
        -- 第 1 段。積の定義（外側の和）。
    _ = ∑ τ'' : RowConfig L, (∑ τ' : RowConfig L, A τ τ' * B τ' τ'') * C τ'' τ''' := rfl
        -- 第 2 段。積の定義（内側の和へ開く）。
    _ = ∑ τ'' : RowConfig L, ∑ τ' : RowConfig L, (A τ τ' * B τ' τ'') * C τ'' τ''' :=
        sum_congr rfl fun τ'' _ => sum_mul _ _ _
        -- 第 3 段。有限和と元の積についての分配則。
    _ = ∑ τ'' : RowConfig L, ∑ τ' : RowConfig L, A τ τ' * (B τ' τ'' * C τ'' τ''') :=
        sum_congr rfl fun τ'' _ => sum_congr rfl fun τ' _ => mul_assoc _ _ _
        -- 第 4 段。積の結合則。
    _ = ∑ τ' : RowConfig L, ∑ τ'' : RowConfig L, A τ τ' * (B τ' τ'' * C τ'' τ''') := sum_comm
        -- 第 5 段。有限和の順序の入れ替え。
    _ = ∑ τ' : RowConfig L, A τ τ' * ∑ τ'' : RowConfig L, B τ' τ'' * C τ'' τ''' :=
        sum_congr rfl fun τ' _ => (mul_sum _ _ _).symm
        -- 第 6 段。元と有限和の積についての分配則。
    _ = ∑ τ' : RowConfig L, A τ τ' * (qbarRowMatrixProduct L B C) τ' τ''' := rfl
        -- 第 7 段。積の定義（BC の成分へ畳む）。
    _ = qbarRowMatrixProduct L A (qbarRowMatrixProduct L B C) τ τ''' := rfl
        -- 第 8 段。積の定義（A(BC) の成分へ畳む）。

end Ising2DLambda.AlgebraicEigenvalue
