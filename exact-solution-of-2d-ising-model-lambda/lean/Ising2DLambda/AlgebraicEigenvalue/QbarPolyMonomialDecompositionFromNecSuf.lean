/-
「多項式は、その係数を定数として送ったものと不定元の冪との積の有限和に等しい」の具体版が、
必要十分版の特殊化として得られることの導出。

具体版は必要十分版（`monomial_decomposition_necSuf`）を次のように取ったものである。

  R := Qbar（体なので当然に半環である）
  f := f        n := n        h := h

すなわち具体版は、係数環を `Qbar` に固定した場合にほかならない
（`qbarConst` は `Polynomial.C` の別名なので、右辺も字句どおり一致する）。
人手証明で `Qbar[t]` について書いているのは、人手証明を一般の半環へ持ち上げないという規則によるもので、
数学的に 2 つの内容があるわけではない。この導出がそのことを示す。

住処: ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyMonomialDecomposition
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarPolyMonomialDecomposition

namespace Ising2DLambda.AlgebraicEigenvalue

/-- 具体版は必要十分版の特殊化である。 -/
theorem qbarPolyMonomialDecomposition_from_necSuf (f : QbarPoly) (n : ℕ)
    (h : ∀ k : ℕ, n < k → f.coeff k = 0) :
    f = ∑ k ∈ Finset.range (n + 1), (qbarConst (f.coeff k)) * Polynomial.X ^ k :=
  NecSuf.AlgebraicEigenvalue.monomial_decomposition_necSuf (R := Qbar) f n h

end Ising2DLambda.AlgebraicEigenvalue
