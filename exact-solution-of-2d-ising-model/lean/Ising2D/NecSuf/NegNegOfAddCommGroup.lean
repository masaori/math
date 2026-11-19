/-
# 符号を 2 度反転するともとに戻る（**必要十分版**）

具体版: `Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealDoubleNegation.lean`
（人手 `real_double_negation`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealDoubleNegationFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `calc` の 8 段（加法の単位元 → 加法の逆元 → 加法の可換律 → 加法の結合律 → 加法の可換律 → 加法の逆元 → 加法の可換律 → 加法の単位元） | `neg_neg_of_addCommGroup` の `calc` の 8 段（同じ並び） |

## 何が効いているか / 効いていないか

- 効くのは、加法の右からの単位元 `a + 0 = a`、右からの逆元 `z + (-z) = 0`、加法の結合律、加法の可換律だけである。
  `AddCommGroup R` はこの 4 つと同じ強さである。
- 乗法、分配律、順序、実数であることは効いていない。
- 具体版と同じ手順を保つ限り、加法の可換律は外せない（3 段目で `a + (-a)` を `(-a) + a` に、5 段目で `-(-a) + (-a)` を
  `(-a) + -(-a)` に、7 段目で `0 + a` を `a + 0` に並べ替え、右からの逆元・右からの単位元を当てる形にしている）。
-/
import Mathlib.Algebra.Group.Defs

namespace Ising2D.NecSuf

/-- **`real_double_negation`** の必要十分版: 加法の可換群で `-(-a) = a`。 -/
theorem neg_neg_of_addCommGroup {R : Type*} [AddCommGroup R] (a : R) : -(-a) = a :=
  calc -(-a)
      = -(-a) + 0 := (add_zero (-(-a))).symm                                 -- 加法の単位元を右辺から左辺へ
    _ = -(-a) + (a + -a) := by rw [add_neg_cancel a]                          -- 加法の逆元を右辺から左辺へ
    _ = -(-a) + (-a + a) := by rw [add_comm a (-a)]                           -- 加法の可換律
    _ = (-(-a) + -a) + a := (add_assoc (-(-a)) (-a) a).symm                   -- 加法の結合律
    _ = (-a + -(-a)) + a := by rw [add_comm (-(-a)) (-a)]                     -- 加法の可換律
    _ = 0 + a := by rw [add_neg_cancel (-a)]                                  -- 加法の逆元
    _ = a + 0 := add_comm 0 a                                                 -- 加法の可換律
    _ = a := add_zero a                                                       -- 加法の単位元

end Ising2D.NecSuf
