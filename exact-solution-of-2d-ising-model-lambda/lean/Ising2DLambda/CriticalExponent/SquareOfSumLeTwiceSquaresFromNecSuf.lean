/-
`claim_square_of_sum_le_twice_sum_of_squares` の具体版を、必要十分版
`squareOfSum_le_twiceSumOfSquares_necSuf` の特殊化として導出する。

K := data.carrier（実閉部分体は体、したがって可換環）、
difference := 減法、positive := 「零でない元の平方」と具体化すると、
広義順序の定義が `realAlgebraicLe` と一致する。
-/
import Ising2DLambda.CriticalExponent.SquareOfSumLeTwiceSquares
import Ising2DLambda.NecSuf.CriticalExponent.SquareOfSumLeTwiceSquares

namespace Ising2DLambda.CriticalExponent

open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.FisherZero

/-- 具体版は必要十分版の特殊化として得られる。 -/
theorem squareOfSum_le_twiceSumOfSquares_from_necSuf
    (data : RealClosedSubfieldData) (u v : data.carrier) :
    realAlgebraicLe data ((u + v) * (u + v)) (2 * (u * u) + 2 * (v * v)) := by
  have h := Ising2DLambda.NecSuf.CriticalExponent.squareOfSum_le_twiceSumOfSquares_necSuf
    (K := data.carrier) u v
  rcases h with hlt | heq
  · exact Or.inl hlt
  · exact Or.inr heq

end Ising2DLambda.CriticalExponent
