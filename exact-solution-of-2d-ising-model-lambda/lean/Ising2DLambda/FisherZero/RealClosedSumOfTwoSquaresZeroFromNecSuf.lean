/-
具体版が必要十分版の特殊化として得られることの導出（整域 `R := Qbar`）。
必要十分版は因数分解と零因子の非存在までを引き受け、一意表示を当てる段だけが具体側の仕事である。
住処: ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.FisherZero.RealClosedSumOfTwoSquaresZero
import Ising2DLambda.NecSuf.FisherZero.RealClosedSumOfTwoSquaresZero

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

theorem realClosed_sq_add_sq_eq_zero_from_necSuf (data : RealClosedSubfieldData)
    (x y : data.carrier)
    (h : (x : Qbar) * (x : Qbar) + (y : Qbar) * (y : Qbar) = 0) :
    x = 0 ∧ y = 0 := by
  rcases Ising2DLambda.NecSuf.FisherZero.sq_add_sq_eq_zero_factor_necSuf
      data.omega (x : Qbar) (y : Qbar) data.omega_sq h with hzero | hzero
  · exact zero_decomposition_unique data x y hzero.symm
  · have hzero' : (0 : Qbar) = (x : Qbar) + ((-y : data.carrier) : Qbar) * data.omega := by
      push_cast
      linear_combination -hzero
    obtain ⟨hx, hy⟩ := zero_decomposition_unique data x (-y) hzero'
    exact ⟨hx, by simpa using neg_eq_zero.mp hy⟩

end Ising2DLambda.FisherZero
