/-
具体版が必要十分版の特殊化として得られることの導出。

具体版は必要十分版を `M := Qbar` と取ったものである。すなわちこの段が要求するのは
**可換群に零元を添えた構造（積・単位元・零元との積・零元でない元の逆元・1 ≠ 0）だけ**であり、
足し算も分配則も、体であることも代数閉であることも、値が代数的数であることも、
添字の型が有限であることも使っていない。

住処: ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarProdZero
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarProdZero

namespace Ising2DLambda.AlgebraicEigenvalue

/-- 具体版は必要十分版の特殊化である（`M := Qbar`）。 -/
theorem exists_eq_zero_of_prod_eq_zero_from_necSuf {β : Type*} [DecidableEq β] (c : β → Qbar) :
    ∀ s : Finset β, (∏ i ∈ s, c i) = 0 → ∃ i ∈ s, c i = 0 :=
  NecSuf.AlgebraicEigenvalue.exists_eq_zero_of_prod_eq_zero_necSuf c

end Ising2DLambda.AlgebraicEigenvalue
