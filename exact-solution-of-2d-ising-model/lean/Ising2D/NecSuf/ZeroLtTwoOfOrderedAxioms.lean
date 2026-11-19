/-
# 0 は 1 + 1 より小さい（**必要十分版**）

具体版: `Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealZeroLessThanTwo.lean`
（人手 `real_zero_less_than_two`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealZeroLessThanTwoFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| 準備の鎖 3 段（加法の単位元、`0 < 1` と順序と加法の両立、`def_real_two`）と本体の推移律 | `zero_lt_two_of_orderedAxioms` の同じ並び |

## 何が効いているか / 効いていないか

- 効くのは、`0 < 1`、左からの加法の単位元 `0 + a = a`、順序と加法の両立 `x < y ⇒ x + c < y + c`、
  `<` の推移律、`t` が `1 + 1` に等しいこと（人手の `def_real_two`）だけである。
- 型には `<` と元と和を持つだけの `Zero`・`One`・`Add`・`LT` を置き、推移律も仮定に書く。
  順序の反射律・反対称律・全域性、加法の結合律・可換律・逆元、乗法は効いていない
  （`0 < 1` は具体版では順序体の公理から示した主張 `real_zero_less_than_one` を引く段で、ここではその結論だけを仮定に置く）。
- `t` を数字 `2` に限らず任意の元で書くのは、人手の `2` が `1 + 1` という定義以外の性質を使わないことを示すため。
- 実数であること、体であること、完備性は効いていない。
-/
import Mathlib.Order.Basic

namespace Ising2D.NecSuf

/-- **`real_zero_less_than_two`** の必要十分版: `0 < 1`、加法の単位元、順序と加法の両立、`<` の推移律と
`1 + 1 = t` から `0 < t`。 -/
theorem zero_lt_two_of_orderedAxioms {R : Type*} [Zero R] [One R] [Add R] [LT R] {t : R}
    (h01 : (0 : R) < 1)
    (hzero_add : ∀ a : R, 0 + a = a)
    (hadd : ∀ x y c : R, x < y → x + c < y + c)
    (htrans : ∀ a b c : R, a < b → b < c → a < c)
    (htwo : (1 : R) + 1 = t) : (0 : R) < t := by
  have h12 : (1 : R) < t :=
    calc (1 : R)
        = 0 + 1 := (hzero_add 1).symm                       -- 加法の単位元を右辺から左辺へ
      _ < 1 + 1 := hadd 0 1 1 h01                             -- `0 < 1` と順序と加法の両立（`x → 0, y → 1, c → 1`）
      _ = t := htwo                                           -- `1 + 1 = t`（人手の `def_real_two` を右辺から左辺へ）
  exact htrans 0 1 t h01 h12                                  -- 本体: `<` の推移律

end Ising2D.NecSuf
