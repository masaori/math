/-
# 二乗は 0 以上（**必要十分版**）

具体版: `Ising2D/MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimRealSquareIsNonnegative.lean`
（人手 `real_square_is_nonnegative`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimRealSquareIsNonnegativeFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `0 ≤ r` の場合の 2 段 | 同じ 2 段（`hmul_self`・`hsq`） |
| 全順序から `r ≤ 0` | `htotal` |
| `0 ≤ −r` の 3 段 | 同じ 3 段（`hadd_neg`・`hle_add`・`hzero_add`） |
| `¬(0 ≤ r)` の場合の 3 段 | 同じ 3 段（`hmul_self`・`hneg_mul_neg`・`hsq`） |

## 何が効いているか / 効いていないか

- 効くのは、二乗 `s` が `s r = r r` を満たすこと、`≤` の全順序の `0` と `r` の組 `0 ≤ r ∨ r ≤ 0`、加法の逆元 `r + (−r) = 0`、
  `≤` と加法の両立の `y = 0` の形 `r ≤ 0 ⇒ r + t ≤ 0 + t`、左からの加法の単位元 `0 + x = x`、順序と乗法の両立の `x = y` の形
  `0 ≤ x ⇒ 0 ≤ x x`、符号反転どうしの積の `a = b` の形 `(−x)(−x) = x x` の 7 つだけである。
- 型には演算と元を持つだけの `Zero`・`Add`・`Neg`・`Mul` と、関係を持つだけの `LE` を置き、使う性質はすべて仮定に書く。
  `≤` の反射律・推移律・反対称律は効いていない（順序であることも要らない）。全順序・両立・符号反転どうしの積は、具体版が使う組の形だけを仮定に置いた。
- 加法・乗法の結合律・可換律、分配律、右からの単位元、乗法の単位元・逆元、実数であること（完備性）は効いていない
  （具体版がそれらを使うのは、引いた主張 `real_negation_times_negation_is_product`・`square_of_real_number_is_product` の中だけである）。
-/
import Mathlib.Order.Basic

namespace Ising2D.NecSuf

/-- **`real_square_is_nonnegative`** の必要十分版: `s r = r r` を満たす `s`、全順序、加法の逆元、`≤` と加法の両立、
左からの加法の単位元、順序と乗法の両立、符号反転どうしの積から `0 ≤ s r`。 -/
theorem sq_nonneg_of_cases {R : Type*} [Zero R] [Add R] [Neg R] [Mul R] [LE R] (s : R → R)
    (hsq : ∀ x : R, s x = x * x)
    (htotal : ∀ x : R, 0 ≤ x ∨ x ≤ 0)
    (hadd_neg : ∀ x : R, x + -x = 0)
    (hle_add : ∀ x t : R, x ≤ 0 → x + t ≤ 0 + t)
    (hzero_add : ∀ x : R, 0 + x = x)
    (hmul_self : ∀ x : R, 0 ≤ x → 0 ≤ x * x)
    (hneg_mul_neg : ∀ x : R, (-x) * (-x) = x * x)
    (r : R) : 0 ≤ s r := by
  by_cases hr : 0 ≤ r
  · calc (0 : R)
        ≤ r * r := hmul_self r hr                         -- 順序と乗法の両立
      _ = s r := (hsq r).symm                             -- 二乗は積（右辺から左辺へ）
  · have hr0 : r ≤ 0 := (htotal r).resolve_left hr      -- 全順序の左が成り立たない
    have hneg : 0 ≤ -r :=
      calc (0 : R)
          = r + -r := (hadd_neg r).symm                   -- 加法の逆元を右辺から左辺へ
        _ ≤ 0 + -r := hle_add r (-r) hr0                -- 順序と加法の両立
        _ = -r := hzero_add (-r)                          -- 左からの加法の単位元
    calc (0 : R)
        ≤ (-r) * (-r) := hmul_self (-r) hneg              -- 順序と乗法の両立
      _ = r * r := hneg_mul_neg r                         -- 符号反転どうしの積
      _ = s r := (hsq r).symm                             -- 二乗は積（右辺から左辺へ）

end Ising2D.NecSuf
