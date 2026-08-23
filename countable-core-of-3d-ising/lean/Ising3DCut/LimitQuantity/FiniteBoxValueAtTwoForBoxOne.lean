/-
人手証明「有理点 2 では有限箱の量の列は定数列でない」
（ラベル `claim_finite_box_sequence_at_two_is_not_constant`）の Lean 具体版のうち、
最初の有限箱計算 `Z_1(2) = 2` を閉じる段。

人手証明の各行とこのファイルの対応:

  E_1 は空である（辺は始点の座標 +1 が箱内に収まる必要があるが L = 1 では不可能）
                                          `card_edge_one`
  Z_1(X) = Ω_1(0) X^0（有限和の項が一つだけ）  `partitionPolynomial_box_one`
         = 2（多重度の総和が配位の個数 2^(#V_1) = 2 に等しい）
  Z_1(2) = 2（定数多項式の値は代入によらない） `isingValueSeq_two_at_one`

箱の大きさの極限は使わない。ℝ は最後の行で有理数を実数へ写す箇所にだけ現れ、
そこは既に取ってある列の住処に合わせるためであって新たな脱出ではない。
-/
import Ising3DCut.LimitQuantity.LimitQuantityAtOneEqualsTwo

namespace Ising3DCut.LimitQuantity

open NullModel

/-- 人手証明の第一行。`L = 1` の箱には辺が無い。
辺は始点の `axis` 成分に 1 を足したものが `L` 未満であることを要求するが、
`L = 1` では始点の座標が `0` しか取れないので `0 + 1 < 1` は成り立たない。 -/
theorem card_edge_one : Fintype.card (Edge 1) = 0 := by
  rw [Fintype.card_eq_zero_iff]
  constructor
  intro e
  exact absurd e.next_lt (by omega)

/-- 人手証明の第二行。辺が無いので有限和は `m = 0` の一項だけになり、
その係数は多重度の総和すなわち配位の個数 `2^(#V_1) = 2` である。 -/
theorem partitionPolynomial_box_one :
    NullModel.partitionPolynomial 1 = Polynomial.C 2 := by
  have hsum := NullModel.sum_multiplicity_eq_config_card 1
  have hcard := NullModel.config_card_eq_two_pow_site_card 1
  have hsite : Fintype.card (Site 1) = 1 := by
    rw [card_site]
    norm_num
  rw [card_edge_one] at hsum
  rw [hcard, hsite] at hsum
  simp only [zero_add, Finset.range_one, Finset.sum_singleton] at hsum
  rw [NullModel.partitionPolynomial, card_edge_one]
  simp only [zero_add, Finset.range_one, Finset.sum_singleton]
  rw [hsum]
  simp [Polynomial.C_eq_natCast, Polynomial.monomial_zero_left]

/-- 人手証明の第三行。定数多項式の有理点での値は代入によらないので `Z_1(2) = 2`。 -/
theorem isingValueSeq_two_at_one : isingValueSeq 2 1 = 2 := by
  unfold isingValueSeq
  rw [partitionPolynomial_box_one]
  simp [map_ofNat]

end Ising3DCut.LimitQuantity
