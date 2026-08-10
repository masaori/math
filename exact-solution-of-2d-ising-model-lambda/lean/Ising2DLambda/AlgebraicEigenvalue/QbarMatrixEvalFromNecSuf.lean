/-
具体版 `Ising2DLambda.AlgebraicEigenvalue.qbarMatrixEval_product` が、必要十分版
`Ising2DLambda.NecSuf.AlgebraicEigenvalue.matEval_product_necSuf` の特殊化として得られることを書く。

特殊化の仕方は次のとおりである。

  必要十分版            ここで代入するもの
  ι                     RowConfig L（行配位の全体）
  S                     Polynomial ℤ（ℤ[x]）
  T                     Qbar（代数的数の全体）
  f                     evalFirstHom ξ（x = ξ の代入）
  hsum                  map_sum（環準同型が有限和を保つこと）
  hmul                  map_mul（環準同型が積を保つこと）

`rowMatrixProduct` と `qbarRowMatrixProduct` はどちらも必要十分版の `matProduct` と
定義が一致する（成分の型だけが違う）。その一致を補題として置いてから特殊化する。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarMatrixEval
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarMatrixEval

namespace Ising2DLambda.AlgebraicEigenvalue

open Ising2DLambda.TransferMatrix

/-- ℤ[x] の行列の積は、必要十分版の `matProduct` そのものである。 -/
lemma rowMatrixProduct_eq_matProduct (L : ℕ) [NeZero L] (A B : RowMatrix L) :
    rowMatrixProduct L A B = NecSuf.AlgebraicEigenvalue.matProduct A B := rfl

/-- Qbar の行列の積も、必要十分版の `matProduct` そのものである。 -/
lemma qbarRowMatrixProduct_eq_matProduct (L : ℕ) [NeZero L] (A B : QbarRowMatrix L) :
    qbarRowMatrixProduct L A B = NecSuf.AlgebraicEigenvalue.matProduct A B := rfl

/-- 具体版は必要十分版の特殊化である。 -/
theorem qbarMatrixEval_product_from_necSuf (L : ℕ) [NeZero L] (ξ : Qbar) (A B : RowMatrix L) :
    qbarMatrixEval L ξ (rowMatrixProduct L A B)
      = qbarRowMatrixProduct L (qbarMatrixEval L ξ A) (qbarMatrixEval L ξ B) := by
  funext τ τ''
  exact
    NecSuf.AlgebraicEigenvalue.matEval_product_necSuf
      (ι := RowConfig L) (S := Polynomial ℤ) (T := Qbar)
      (fun a => evalFirstHom ξ a)
      (fun g => map_sum (evalFirstHom ξ) g Finset.univ)
      (fun a b => map_mul (evalFirstHom ξ) a b)
      A B τ τ''

end Ising2DLambda.AlgebraicEigenvalue
