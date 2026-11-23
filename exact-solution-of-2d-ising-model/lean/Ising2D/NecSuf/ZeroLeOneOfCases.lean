/-
# 0 は 1 以下（全順序で分ける論法の**必要十分版**）

具体版: `Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimIntegerZeroAtMostOne.lean`
（人手 `int_zero_at_most_one`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimIntegerZeroAtMostOneFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| 全順序 `0 ≤ 1 ∨ 1 ≤ 0` で分ける | `htotal` |
| `hneg_one` の 3 段 | 同じ（`hadd_neg`・`hle_add`・`hzero_add`） |
| `hsq` | 同じ（`hmul_nonneg`） |
| `calc` の 8 段 | 同じ（`hneg_mul`・`hone_mul`・`hadd_zero`・`hneg_add`・`hadd_assoc`・`hneg_add`・`hzero_add`） |

## 何が効いているか / 効いていないか

- 効くのは、`0 ≤ 1 ∨ 1 ≤ 0`（全順序を `0, 1` に使う形）、`≤` と加法の両立、`≤` と乗法の両立 `(0 ≤ x ∧ 0 ≤ y) ⇒ 0 ≤ x·y`、
  符号反転と積の `(−x)·t = −(x·t)`、左からの乗法の単位元 `1·y = y`、左右の加法の単位元、左右の加法の逆元、加法の結合律だけである。
- 型には演算と元を持つだけの `Zero`・`One`・`Add`・`Neg`・`Mul` と関係を持つだけの `LE` を置き、使う性質はすべて仮定に書く。
  `(−x)·t = −(x·t)` は、具体版では別の主張（`int_negation_times_is_negation_of_product`）を引く段なので、ここでも結論の形で仮定に置く。
- `≤` の反射律・反対称律・推移律、加法の可換律、乗法の結合律・可換律・右からの単位元、分配律、`0 ≠ 1`、整数であること（離散性・帰納法）は効いていない。
  `≤` の推移律が要らないのは、二つの鎖のどちらも `≤` を一度しか使わないためである。
-/
import Mathlib.Order.Basic

namespace Ising2D.NecSuf

/-- **`int_zero_at_most_one`** の必要十分版: 上の仮定の下で `0 ≤ 1`。 -/
theorem zero_le_one_of_cases {R : Type*} [Zero R] [One R] [Add R] [Neg R] [Mul R] [LE R]
    (htotal : (0 : R) ≤ 1 ∨ (1 : R) ≤ 0)
    (hle_add : ∀ x y t : R, x ≤ y → x + t ≤ y + t)
    (hmul_nonneg : ∀ x y : R, 0 ≤ x → 0 ≤ y → 0 ≤ x * y)
    (hneg_mul : ∀ x t : R, (-x) * t = -(x * t))
    (hone_mul : ∀ y : R, 1 * y = y)
    (hzero_add : ∀ y : R, 0 + y = y)
    (hadd_zero : ∀ y : R, y + 0 = y)
    (hadd_neg : ∀ y : R, y + -y = 0)
    (hneg_add : ∀ y : R, -y + y = 0)
    (hadd_assoc : ∀ y z s : R, (y + z) + s = y + (z + s)) :
    (0 : R) ≤ 1 := by
  rcases htotal with h | h
  · exact h
  · have hneg_one : (0 : R) ≤ -1 :=
      calc (0 : R)
          = 1 + -1 := (hadd_neg 1).symm
        _ ≤ 0 + -1 := hle_add 1 0 (-1) h
        _ = -1 := hzero_add (-1)
    have hsq : (0 : R) ≤ (-1) * (-1) := hmul_nonneg (-1) (-1) hneg_one hneg_one
    calc (0 : R)
        ≤ (-1) * (-1) := hsq
      _ = -(1 * (-1)) := hneg_mul 1 (-1)
      _ = -(-1) := by rw [hone_mul (-1)]
      _ = -(-1) + 0 := (hadd_zero (-(-1))).symm
      _ = -(-1) + ((-1) + 1) := by rw [hneg_add 1]
      _ = (-(-1) + (-1)) + 1 := (hadd_assoc (-(-1)) (-1) 1).symm
      _ = 0 + 1 := by rw [hneg_add (-1)]
      _ = 1 := hzero_add 1

end Ising2D.NecSuf
