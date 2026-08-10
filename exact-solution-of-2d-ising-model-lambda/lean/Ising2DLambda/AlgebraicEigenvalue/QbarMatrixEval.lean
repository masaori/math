/-
章「固有値の代数性」の「整係数多項式を成分とする行列の、代数的数における値」の具体版
（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは定義 1 件
（`def_qbar_matrix_eval`）と主張 1 件（`claim_qbar_matrix_eval_product`）に対応する。

  人手証明                                このファイル
  Ev_ξ(A)                                 qbarMatrixEval
  鎖の第 1 段（Ev_ξ の定義）              qbarMatrixEval の展開（rfl）
  鎖の第 2 段（ℤ[x] の行列の積の定義）    rowMatrixProduct の展開（rfl）
  鎖の第 3 段（代入が有限和を保つ）       map_sum
  鎖の第 4 段（代入が積を保つ）           map_mul
  鎖の第 5 段（Ev_ξ の定義へ戻す）        qbarMatrixEval の折りたたみ（rfl）
  鎖の第 6 段（Qbar の行列の積へまとめる）qbarRowMatrixProduct の折りたたみ（rfl）

代入 `evalFirstHom ξ : ℤ[x] →+* Qbar` は `OrbitFactorRoot.lean` で置いたものをそのまま使う
（人手証明が `def_partition_polynomial` で置いた「代入は有限和と積を保つ」という約束に対応する。
証明すべきことではないので、ここでも環準同型の性質 `map_sum` / `map_mul` として引く）。

ℤ[x] の行列（`RowMatrix`）と Qbar の行列（`QbarRowMatrix`）は成分の型が違う別の型であり、
それぞれの積も別の演算（`rowMatrixProduct` と `qbarRowMatrixProduct`）である。
人手証明が同一視を避けて写像 `Ev_ξ` に名前を与えていることに、Lean 側の型の違いが対応する。

住処: 人手証明のこれらのブロックは Qbar を宣言している。
ここに ℝ / ℂ は現れない（値は ℚ の代数閉包の元、添字は行配位）。
-/
import Ising2DLambda.AlgebraicEigenvalue.OrbitFactorRoot
import Ising2DLambda.AlgebraicEigenvalue.QbarAction

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset Ising2DLambda.TransferMatrix

variable (L : ℕ)

/-- 整係数多項式を成分とする行列の、代数的数 `ξ` における値（`def_qbar_matrix_eval`）。
成分ごとに `x = ξ` を代入する。 -/
noncomputable def qbarMatrixEval (ξ : Qbar) (A : RowMatrix L) : QbarRowMatrix L :=
  fun τ τ' => evalFirstHom ξ (A τ τ')

/-- 人手証明の本体。`Ev_ξ(AB) = Ev_ξ(A) Ev_ξ(B)`（`claim_qbar_matrix_eval_product`）。
両辺は `R_L × R_L` 上の写像なので、`τ`・`τ''` を任意に取ってその値が等しいことを示す。 -/
theorem qbarMatrixEval_product [NeZero L] (ξ : Qbar) (A B : RowMatrix L) :
    qbarMatrixEval L ξ (rowMatrixProduct L A B)
      = qbarRowMatrixProduct L (qbarMatrixEval L ξ A) (qbarMatrixEval L ξ B) := by
  funext τ τ''
  calc qbarMatrixEval L ξ (rowMatrixProduct L A B) τ τ''
      = evalFirstHom ξ ((rowMatrixProduct L A B) τ τ'') := rfl
        -- 第 1 段。Ev_ξ の定義（成分ごとの代入）。
    _ = evalFirstHom ξ (∑ τ' : RowConfig L, A τ τ' * B τ' τ'') := rfl
        -- 第 2 段。ℤ[x] の行列の積の定義。
    _ = ∑ τ' : RowConfig L, evalFirstHom ξ (A τ τ' * B τ' τ'') := by
        exact map_sum (evalFirstHom ξ) _ _
        -- 第 3 段。代入が有限和を保つこと。
    _ = ∑ τ' : RowConfig L, evalFirstHom ξ (A τ τ') * evalFirstHom ξ (B τ' τ'') := by
        exact sum_congr rfl fun τ' _ => map_mul (evalFirstHom ξ) _ _
        -- 第 4 段。代入が積を保つこと。
    _ = ∑ τ' : RowConfig L,
          (qbarMatrixEval L ξ A) τ τ' * (qbarMatrixEval L ξ B) τ' τ'' := rfl
        -- 第 5 段。Ev_ξ の定義（2 箇所へ適用）。
    _ = qbarRowMatrixProduct L (qbarMatrixEval L ξ A) (qbarMatrixEval L ξ B) τ τ'' := rfl
        -- 第 6 段。Qbar の行列の積の定義。

end Ising2DLambda.AlgebraicEigenvalue
