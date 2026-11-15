/-
# 0 は 1 より小さい（**必要十分版**）

具体版: `Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealZeroLessThanOne.lean`
（人手 `real_zero_less_than_one`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealZeroLessThanOneFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| 準備の場合分け（`0 ≠ 1` と全順序の全域性）、`1 < 0` の場合の第 1 の鎖 3 段と第 2 の鎖 3 段 | `zero_lt_one_of_orderedAxioms` の同じ並び |

## 何が効いているか / 効いていないか

- 効くのは、`0 ≠ 1`、順序の全域性と反対称律（`0 < 1` か `1 < 0` の場合分け。`LinearOrder` の `lt_or_gt_of_ne`。反対称律は mathlib の `<` の定め方による。下の項）、
  順序と加法の両立 `x < y ⇒ x + c < y + c`、正の元どうしの積は正、`(−a)(−b) = ab`、
  加法の逆元 `z + (−z) = 0`、左からの加法の単位元 `0 + a = a`、左からの乗法の単位元 `1·a = a` だけである。
- `0 ≠ 1` を外すと通らない（`0 = 1` のとき `0 < 1` は偽）。
- 型には演算と元を持つだけの `Zero`・`One`・`Add`・`Neg`・`Mul` を置き、使う等式はすべて仮定に書く。
  加法の結合則・可換則、右からの単位元 `a + 0 = a`・`a·1 = a`、乗法の結合則・可換則、分配則、
  乗法の逆元（体であること）は効いていない
  （`(−a)(−b) = ab` は具体版では分配則などから示した主張 `real_negation_times_negation_is_product` を引く段で、
  ここではその結論だけを仮定に置く）。
- 順序の反対称律は、`LinearOrder` の `<` が `a ≤ b ∧ ¬ b ≤ a` で定まるため、場合分けの `lt_or_gt_of_ne` の中で効いている。
  人手の `<`（`≤` かつ `≠`）のもとでは、全域性と `0 ≠ 1` だけで場合分けができ、反対称律は要らない。
  mathlib の `<` を使う限り、`le_total` と `lt_of_le_of_ne` に書き換えても `lt_of_le_of_ne` が反対称律を使うので外せない。
- 実数であること、完備性は効いていない。
-/
import Mathlib.Order.Basic

namespace Ising2D.NecSuf

/-- **`real_zero_less_than_one`** の必要十分版: `0 ≠ 1`、順序の全域性、加法の逆元と単位元、乗法の単位元、
順序と加法の両立、正の元どうしの積は正、`(−a)(−b) = ab` から `0 < 1`。 -/
theorem zero_lt_one_of_orderedAxioms {R : Type*} [Zero R] [One R] [Add R] [Neg R] [Mul R] [LinearOrder R]
    (h01 : (0 : R) ≠ 1)
    (hadd_neg : ∀ z : R, z + -z = 0)
    (hzero_add : ∀ a : R, 0 + a = a)
    (hone_mul : ∀ a : R, 1 * a = a)
    (hadd : ∀ x y c : R, x < y → x + c < y + c)
    (hmul : ∀ a b : R, 0 < a → 0 < b → 0 < a * b)
    (hnegneg : ∀ a b : R, (-a) * (-b) = a * b) : (0 : R) < 1 := by
  rcases lt_or_gt_of_ne h01 with h | h                       -- 全域性で `0 < 1` か `1 < 0`
  · exact h                                                  -- `0 < 1` の場合は主張そのもの
  · have hneg : (0 : R) < -1 :=
      calc (0 : R)
          = 1 + (-1) := (hadd_neg 1).symm                    -- 加法の逆元を右辺から左辺へ
        _ < 0 + (-1) := hadd 1 0 (-1) h                      -- 場合の仮定 `1 < 0` と順序と加法の両立
        _ = -1 := hzero_add (-1)                             -- 加法の単位元
    calc (0 : R)
        < (-1) * (-1) := hmul (-1) (-1) hneg hneg            -- 正の元どうしの積は正
      _ = 1 * 1 := hnegneg 1 1                               -- `(−a)(−b) = ab`
      _ = 1 := hone_mul 1                                    -- 乗法の単位元

end Ising2D.NecSuf
