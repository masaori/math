/-
具体版が必要十分版の特殊化として得られることの導出。
具体側の仕事は、可換環の 2 つの性質（平方の和が平方であること・平方の和が零なら各項が零であること）を
供給することだけである。
住処: ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.FisherZero.RealAlgebraicOrderTransitive
import Ising2DLambda.NecSuf.FisherZero.RealAlgebraicOrderTransitive

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

theorem realAlgebraicLt_trans_from_necSuf (data : RealClosedSubfieldData) (a b c : data.carrier)
    (hab : realAlgebraicLt data a b) (hbc : realAlgebraicLt data b c) :
    realAlgebraicLt data a c :=
  Ising2DLambda.NecSuf.FisherZero.lt_of_difference_trans_necSuf
    (fun u v => realClosed_sum_of_two_squares_is_square data u v)
    (fun u v h => by
      refine realClosed_sq_add_sq_eq_zero data u v ?_
      have hcast := congrArg (fun z : data.carrier => (z : Qbar)) h
      push_cast at hcast
      linear_combination hcast)
    a b c hab hbc

end Ising2DLambda.FisherZero
