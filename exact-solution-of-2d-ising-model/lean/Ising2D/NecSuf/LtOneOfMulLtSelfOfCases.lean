/-
# 0 以上の c について x·c < c なら x < 1（全順序と 0 以上の元の分解で示す**必要十分版**）

具体版: `Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimIntegerLessThanOneOfProductLessThanNonnegativeFactor.lean`
（人手 `int_less_than_one_of_product_less_than_nonnegative_factor`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimIntegerLessThanOneOfProductLessThanNonnegativeFactorFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| 全順序 `x ≤ 0 ∨ 0 ≤ x` で分ける | `htotal` |
| 0 以上の元の分解 | `hdecomp` |
| `x = 0` の側の反射律 | `hrefl` |
| `hnc`・`hc_le` の 5 段 | 同じ（`hmul_nonneg`・`hzero_add`・`hle_add`・`hone_mul`・`hadd_mul`） |
| `hxc1` | `hlt` |
| `hc1` の 2 段 | 同じ（`hle_add`・`htrans`） |
| `h10` の 6 段 | 同じ（`hzero_add`・`hneg_add`・`hadd_assoc`・`hadd_comm`・`hle_add`・`hadd_neg`） |
| 反対称律・`int_zero_at_most_one`・`0 ≠ 1` | `hantisymm`・`hzero_le_one`・`hzero_ne_one` |
| 最後の 2 段と `def_int_strict_order` | 同じ（`hle_add`・`hzero_add`・`hlt`） |

## 何が効いているか / 効いていないか

- 効くのは、`x ≤ 0 ∨ 0 ≤ x`（全順序を `x, 0` に使う形）、0 以上の元の分解（0 か、0 以上の元に 1 を足したもの）、
  `≤` の反射律（`0 ≤ 0` の形）・推移律・反対称律（`0, 1` に使う形）、`≤` と加法の両立、`≤` と乗法の両立、`<` が `x + 1 ≤ y` と同値であること、
  左からの加法の単位元、左右の加法の逆元、加法の結合律・可換律、左からの乗法の単位元、右からの分配律、`0 ≤ 1`、`0 ≠ 1` だけである。
- 型には演算と元を持つだけの `Zero`・`One`・`Add`・`Neg`・`Mul` と関係を持つだけの `LE`・`LT` を置き、使う性質はすべて仮定に書く。
  `0 ≤ 1` は、具体版では別の主張（`int_zero_at_most_one`）を引く段なので、ここでも結論の形で仮定に置く。
- 0 以上の元の分解が効いていることが、この主張が整数に固有であることの在り処である（有理数で `<` を `x + 1 ≤ y` と読むと、分解のほかの仮定を全て満たし、`x = 1/2, c = 2` で仮定 `x·c + 1 = 2 ≤ 2` が成り立つのに `x + 1 = 3/2 ≤ 1` が崩れる）。
- 乗法の結合律・可換律、左からの分配律、帰納法は効いていない。
-/
import Mathlib.Order.Basic

namespace Ising2D.NecSuf

/-- **`int_less_than_one_of_product_less_than_nonnegative_factor`** の必要十分版: 上の仮定の下で、
`0 ≤ c` かつ `x·c < c` なら `x < 1`。 -/
theorem lt_one_of_mul_lt_self_of_cases {R : Type*} [Zero R] [One R] [Add R] [Neg R] [Mul R] [LE R] [LT R]
    (x c : R)
    (htotal : x ≤ 0 ∨ 0 ≤ x)
    (hdecomp : ∀ x : R, 0 ≤ x → x = 0 ∨ ∃ n : R, 0 ≤ n ∧ x = n + 1)
    (hrefl : (0 : R) ≤ 0)
    (htrans : ∀ x y z : R, x ≤ y → y ≤ z → x ≤ z)
    (hantisymm : (0 : R) ≤ 1 → (1 : R) ≤ 0 → (0 : R) = 1)
    (hle_add : ∀ x y t : R, x ≤ y → x + t ≤ y + t)
    (hmul_nonneg : ∀ x y : R, 0 ≤ x → 0 ≤ y → 0 ≤ x * y)
    (hlt : ∀ x y : R, x < y ↔ x + 1 ≤ y)
    (hzero_add : ∀ y : R, 0 + y = y)
    (hadd_neg : ∀ y : R, y + -y = 0)
    (hneg_add : ∀ y : R, -y + y = 0)
    (hadd_assoc : ∀ y z s : R, (y + z) + s = y + (z + s))
    (hadd_comm : ∀ y z : R, y + z = z + y)
    (hone_mul : ∀ y : R, 1 * y = y)
    (hadd_mul : ∀ y z s : R, (y + z) * s = y * s + z * s)
    (hzero_le_one : (0 : R) ≤ 1)
    (hzero_ne_one : (0 : R) ≠ 1)
    (hc : 0 ≤ c) (hxc : x * c < c) : x < 1 := by
  have hx_le : x ≤ 0 := by
    rcases htotal with hx | hx
    · exact hx
    · rcases hdecomp x hx with hx0 | ⟨n, hn, hxn⟩
      · calc x
            = 0 := hx0
          _ ≤ 0 := hrefl
      · have hnc : 0 ≤ n * c := hmul_nonneg n c hn hc
        have hc_le : c ≤ x * c :=
          calc c
              = 0 + c := (hzero_add c).symm
            _ ≤ n * c + c := hle_add 0 (n * c) c hnc
            _ = n * c + 1 * c := by rw [hone_mul c]
            _ = (n + 1) * c := (hadd_mul n 1 c).symm
            _ = x * c := by rw [hxn]
        have hxc1 : x * c + 1 ≤ c := (hlt (x * c) c).mp hxc
        have hc1 : c + 1 ≤ c := htrans (c + 1) (x * c + 1) c (hle_add c (x * c) 1 hc_le) hxc1
        have h10 : (1 : R) ≤ 0 :=
          calc (1 : R)
              = 0 + 1 := (hzero_add 1).symm
            _ = ((-c) + c) + 1 := by rw [hneg_add c]
            _ = (-c) + (c + 1) := hadd_assoc (-c) c 1
            _ = (c + 1) + (-c) := hadd_comm (-c) (c + 1)
            _ ≤ c + (-c) := hle_add (c + 1) c (-c) hc1
            _ = 0 := hadd_neg c
        exact absurd (hantisymm hzero_le_one h10) hzero_ne_one
  have hx1 : x + 1 ≤ 1 :=
    calc x + 1
        ≤ 0 + 1 := hle_add x 0 1 hx_le
      _ = 1 := hzero_add 1
  exact (hlt x 1).mpr hx1

end Ising2D.NecSuf
