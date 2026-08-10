/-
具体版が必要十分版の特殊化として得られることの導出。

必要十分版（`NecSuf.AlgebraicEigenvalue.eval₂_X_pow_add_C_necSuf`）は、可換半環の間の
環準同型 `φ` と値 `z` について `X ^ m + C a` の値が `z ^ m + φ a` であることを言う。
具体版は `R := ℤ[x]`・`S := Qbar`・`φ := evalFirstHom ξ`・`a := -(constPoly 1)` と取り、
そのうえで人手証明の第 4・第 5 段（逆元を逆元へ送る／κ(1) の値は 1）を当てたものである。

住処: ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.OrbitFactorRoot
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.OrbitFactorRoot

namespace Ising2DLambda.AlgebraicEigenvalue

open Polynomial

/-- 具体版は必要十分版の特殊化である（`φ := evalFirstHom ξ`、`a := -(constPoly 1)`）。 -/
theorem rootOfUnity_of_orbitFactor_eval_eq_zero_from_necSuf {m : ℕ} {ξ z : Qbar}
    (h : evalSecond ξ z ((X : SecondPoly) ^ m + constSecond (-(constPoly 1))) = 0) :
    z ∈ RootOfUnity m := by
  rw [mem_rootOfUnity]
  have hval : evalSecond ξ z ((X : SecondPoly) ^ m + constSecond (-(constPoly 1)))
      = z ^ m + evalFirstHom ξ (-(constPoly 1)) :=
    NecSuf.AlgebraicEigenvalue.eval₂_X_pow_add_C_necSuf
      (evalFirstHom ξ) z m (-(constPoly 1))
  have h' : z ^ m - 1 = 0 := by
    rw [← h, hval, map_neg, constPoly_one, map_one, ← sub_eq_add_neg]
  exact sub_eq_zero.mp h'

end Ising2DLambda.AlgebraicEigenvalue
