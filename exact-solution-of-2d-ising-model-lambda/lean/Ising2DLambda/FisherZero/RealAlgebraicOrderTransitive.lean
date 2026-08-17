/-
章「零点の詰め寄り」の「実代数的数の狭義順序は推移的である」
（`claim_real_algebraic_order_transitive`）の具体版。

  人手証明                                                          このファイル
  b - a = u·u、c - b = v·v（零でない u, v）                          `hab`, `hbc`
  c - a = (c-b) + (b-a) = v·v + u·u = u·u + v·v                      `calc`（三段）
  平方の和は平方（w·w）                                              `realClosed_sum_of_two_squares_is_square`
  w ≠ 0（w = 0 なら平方の和が零で u = 0 になる）                     `realClosed_sq_add_sq_eq_zero`

住処: Qbar。実数体・複素数体は現れない。
-/
import Ising2DLambda.FisherZero.RealClosedSumOfTwoSquaresIsSquare
import Ising2DLambda.FisherZero.RealClosedSumOfTwoSquaresZero
import Ising2DLambda.FisherZero.RealAlgebraicOrder

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

theorem realAlgebraicLt_trans (data : RealClosedSubfieldData) (a b c : data.carrier)
    (hab : realAlgebraicLt data a b) (hbc : realAlgebraicLt data b c) :
    realAlgebraicLt data a c := by
  obtain ⟨u, hu0, hu⟩ := hab
  obtain ⟨v, hv0, hv⟩ := hbc
  obtain ⟨w, hw⟩ := realClosed_sum_of_two_squares_is_square data u v
  refine ⟨w, ?_, ?_⟩
  · intro hw0
    rw [hw0] at hw
    have hzero : (u : Qbar) * (u : Qbar) + (v : Qbar) * (v : Qbar) = 0 := by
      have hcast := congrArg (fun z : data.carrier => (z : Qbar)) hw
      push_cast at hcast
      linear_combination hcast
    exact hu0 (realClosed_sq_add_sq_eq_zero data u v hzero).1
  · calc c - a = (c - b) + (b - a) := by ring
      _ = v * v + u * u := by rw [hu, hv]
      _ = u * u + v * v := by ring
      _ = w * w := hw

end Ising2DLambda.FisherZero
