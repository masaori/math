/-
具体版が必要十分版（Gauss の恒等式）の特殊化として得られることの導出。
具体側の仕事は、代数閉性と一意表示から成分 `a`, `b` を取り出すところだけであり、
そこから先は恒等式 `(a·a - b·b)² + (a·b + a·b)² = (a·a + b·b)²` へ代入するだけである。
住処: ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.FisherZero.RealClosedSumOfTwoSquaresIsSquare

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

theorem realClosed_sum_of_two_squares_is_square_from_necSuf (data : RealClosedSubfieldData)
    (x y : data.carrier) :
    ∃ c : data.carrier, x * x + y * y = c * c := by
  obtain ⟨u, hu⟩ :=
    IsAlgClosed.exists_pow_nat_eq ((x : Qbar) + (y : Qbar) * data.omega) (n := 2) two_pos
  have hu2 : u * u = (x : Qbar) + (y : Qbar) * data.omega := by
    rw [← hu]; ring
  obtain ⟨⟨a, b⟩, hab, _⟩ := data.unique_decomposition u
  have hexp : (x : Qbar) + (y : Qbar) * data.omega
      = ((a * a - b * b : data.carrier) : Qbar)
        + ((a * b + a * b : data.carrier) : Qbar) * data.omega := by
    push_cast
    linear_combination (-1 : Qbar) * hu2
      + (u + (a : Qbar) + (b : Qbar) * data.omega) * hab
      + ((b : Qbar) * (b : Qbar)) * data.omega_sq
  obtain ⟨cd, _, huniq2⟩ := data.unique_decomposition ((x : Qbar) + (y : Qbar) * data.omega)
  have hxy : ((x, y) : data.carrier × data.carrier)
      = (a * a - b * b, a * b + a * b) := by
    rw [huniq2 (x, y) rfl, ← huniq2 (a * a - b * b, a * b + a * b) hexp]
  have hx : x = a * a - b * b := congrArg Prod.fst hxy
  have hy : y = a * b + a * b := congrArg Prod.snd hxy
  refine ⟨a * a + b * b, ?_⟩
  rw [hx, hy]
  -- ここから先は可換環の恒等式だけである（必要十分版）。
  have hid := Ising2DLambda.NecSuf.FisherZero.gauss_sum_of_two_squares_identity_necSuf a b
  calc (a * a - b * b) * (a * a - b * b) + (a * b + a * b) * (a * b + a * b)
      = (a * a - b * b) * (a * a - b * b) + (2 * a * b) * (2 * a * b) := by ring
    _ = (a * a + b * b) * (a * a + b * b) := hid

end Ising2DLambda.FisherZero
