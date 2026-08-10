/-
具体版が必要十分版の特殊化として得られることの導出。

この段の必要十分版は、既に置いてある
`NecSuf.AlgebraicEigenvalue.map_prod_of_mul`（単位元を単位元へ送り積を保つ写像は
有限積を有限積へ写す）そのものである。新しい仮定を要求しないので、必要十分版を
別に書き起こさない（書き起こせば同じ言明の別名になり、`docs/context/証明の書き方.md` の
「一行で終わる宣言や単なる別名定義は認めない」に当たる）。

具体版は `M := ℤ[x][t]`・`N := Qbar`・`h := evalSecond ξ z` と取ったものである。
すなわちこの段が要求するのは**単位元の保存と積の保存の 2 つだけ**であり、
`ev` が和を保つことも、係数環が ℤ[x] であることも、値が代数的数であることも、
`ev` が代入として作られていることも使っていない。
同じ必要十分版を `constSecond_constPoly_prod`（ι∘κ の側）も使っており、
2 つの具体版が同じ 1 つの言明の特殊化であることがここで見える。

住処: ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.SecondEvaluationProd
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.OrbitTermFactorization

namespace Ising2DLambda.AlgebraicEigenvalue

/-- 具体版は必要十分版の特殊化である（`h := evalSecond ξ z`）。 -/
theorem evalSecond_prod_from_necSuf {β : Type*} [DecidableEq β] (ξ z : Qbar)
    (s : Finset β) (f : β → SecondPoly) :
    evalSecond ξ z (∏ i ∈ s, f i) = ∏ i ∈ s, evalSecond ξ z (f i) :=
  NecSuf.AlgebraicEigenvalue.map_prod_of_mul
    (evalSecond ξ z) (evalSecond_one ξ z) (evalSecond_mul ξ z) s f

end Ising2DLambda.AlgebraicEigenvalue
