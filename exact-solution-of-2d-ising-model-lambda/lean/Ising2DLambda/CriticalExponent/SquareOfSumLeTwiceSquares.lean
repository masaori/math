/-
人手証明 `claim_square_of_sum_le_twice_sum_of_squares` の具体版。

  人手証明                                                     このファイル
  差 D = (2u²+2v²) − (u+v)² を置き (u−v)·(u−v) へ変形         `ring`（展開・同類項・因数分解の三段）
  u = v の場合: D = 0 で両辺が等しい（等号の枝）               `Or.inr`
  u ≠ v の場合: w := u−v ≠ 0 が差の平方の証人（狭義順序の枝）  `Or.inl`

住処: Qbar。実数体・複素数体は現れない。
-/
import Ising2DLambda.FisherZero.RealAlgebraicOrder

namespace Ising2DLambda.CriticalExponent

open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.FisherZero

/-- 和の平方は平方和の二倍以下である（実閉部分体の広義順序）。 -/
theorem squareOfSum_le_twiceSumOfSquares (data : RealClosedSubfieldData)
    (u v : data.carrier) :
    realAlgebraicLe data ((u + v) * (u + v)) (2 * (u * u) + 2 * (v * v)) := by
  by_cases huv : u = v
  · -- 第一の場合: u = v なら差が零元で、両辺が等しい。
    exact Or.inr (by subst huv; ring)
  · -- 第二の場合: w := u − v ≠ 0 が差 (2u²+2v²) − (u+v)² = w·w の証人。
    exact Or.inl ⟨u - v, sub_ne_zero.mpr huv, by ring⟩

end Ising2DLambda.CriticalExponent
