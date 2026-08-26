/-
「有限箱の量が末尾で一定となる正の有理点は 1 に限られる」の接続の一段。
有理点の既約分母が `1`（すなわち有理点が正の自然数）である場合について、
既に示した有限箱側の二つの結論を束ね、分子が `2` を割ることを得る。

束ねる二つは次である。
第一段: 破れ数 `0` の多重度がちょうど `2` であること（`multiplicity_zero_eq_two`）。
第二段: 整数の有理点の分子が「多重度ゼロの値から 1 を引いた数の 2 倍」を割ること
        （`integer_point_numerator_divides_twice_zero_multiplicity_minus_one`）。

第二段の結論の右辺へ第一段を代入すると `2 * (2 - 1) = 2` になるので、
分子が `2` を割ることが従う。扱うのは自然数の有限和と整除だけであり、
箱の大きさは閾値の一つに固定されていて極限も無限和も現れない。
-/
import Ising3DCut.LimitQuantity.IntegerPointNumeratorDividesTwiceZeroMultiplicityMinusOne
import Ising3DCut.NullModel.ZeroBreakageConstant

namespace Ising3DCut.LimitQuantity

/-- 有限箱の多重度で書いた分配多項式の値についての整除から、
破れ数 `0` の多重度が `2` であることを使って、整数の有理点の分子が `2` を割ることを得る。 -/
theorem integer_point_numerator_divides_two
    {a E Z L : ℕ} (hL : 0 < L)
    (hZ : Z = ∑ m ∈ Finset.range (E + 1), NullModel.multiplicity L m * a ^ m)
    (hdvd : a ∣ 2 * (Z - 1)) :
    a ∣ 2 := by
  have hzero : NullModel.multiplicity L 0 = 2 := NullModel.multiplicity_zero_eq_two hL
  have hOmega : 1 ≤ NullModel.multiplicity L 0 := by omega
  have hstep : a ∣ 2 * (NullModel.multiplicity L 0 - 1) :=
    integer_point_numerator_divides_twice_zero_multiplicity_minus_one hOmega hZ hdvd
  have hval : 2 * (NullModel.multiplicity L 0 - 1) = 2 := by omega
  rwa [hval] at hstep

end Ising3DCut.LimitQuantity
