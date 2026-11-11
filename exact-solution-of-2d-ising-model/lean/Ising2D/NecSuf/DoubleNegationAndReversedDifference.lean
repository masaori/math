/-
# `-(-z) = z`・`b - a = -(a - b)`（必要十分版）

具体版: `Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimDoubleNegationAndReversedDifferenceInCC.lean`
（人手 `double_negation_in_cc`・`reversed_difference_is_negation_of_difference_in_cc`）。具体版をこのファイルの系として導くのは
同じフォルダの `ClaimDoubleNegationAndReversedDifferenceInCCFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `complex_double_negation` の 5 段 | `double_negation'` の 5 段（同じ並び） |
| `complex_reversed_difference` の 10 段 | `reversed_difference'` の 10 段（同じ並び） |

## 何が効いているか / 効いていないか

- 符号反転と積のつながりは仮定 `hneg : ∀ x, -x = (-1) * x`（人手の `multiply_by_minus_one` はこの形の定義である）と
  `hmm : (-1) * (-1) = 1`（人手の `minus_one_times_minus_one_is_one_in_cc`）で渡す。差と和のつながりは仮定
  `hsub : ∀ x y, x - y = x + -y`（人手の `def_complex_difference`）で渡す。
  `Ring` を取ると `-(-x) = x` と `b - a = -(a - b)` が型クラスの側から出てしまい、何が効いているかが見えなくなるので取らない。
- 左単位元は仮定 `hleft : ∀ x, 1 * x = x`（人手の `complex_numbers_form_a_field` の積の単位元）で渡し、型クラスは
  `Semigroup`（積の結合律）と `One` だけを取る。`Monoid` を取ると使わない右単位元 `x1 = x` と冪が入るので取らない
  （`InvertibleElementsProduct.lean` と同じ扱い）。
- `double_negation'` で効いているのは `hneg`・`hmm`・`hleft`・積の結合律の 4 つである。**加法は効いていない**
  （行列の版 `NegNegMatrix.lean` の成分の鎖と同じ）。
- `reversed_difference'` で効いているのは `hsub`・`hneg`・`hmm`・`hleft`、加法の可換律（`AddCommMagma`）、積の結合律（`Semigroup`）、
  左からの分配律（`LeftDistribClass`）である。**加法の逆元（`x + (-x) = 0`）・加法の結合律・零元は効いていない**（型クラスにも取らない）。
  積の可換律と右からの分配律も効いていない。
- 複素数であること、体であること（積の逆元）は効いていない。
-/
import Mathlib.Algebra.Ring.Defs
import Mathlib.Algebra.Group.Defs

namespace Ising2D.NecSuf

/-- **`-(-z) = z`**（具体版 `complex_double_negation`）。 -/
theorem double_negation' {R : Type*} [Semigroup R] [One R] [Neg R]
    (hneg : ∀ x : R, -x = (-1) * x) (hmm : (-1 : R) * (-1) = 1) (hleft : ∀ x : R, 1 * x = x)
    (z : R) : -(-z) = z :=
  calc -(-z)
      = (-1) * (-z) := hneg (-z)                                   -- 1 段目: `-x = (-1)x`（`x → -z`）
    _ = (-1) * ((-1) * z) := by rw [hneg z]                        -- 2 段目: `-x = (-1)x`（`x → z`）
    _ = ((-1) * (-1)) * z := (mul_assoc _ _ _).symm                -- 3 段目: 積の結合律を右辺から左辺へ
    _ = 1 * z := by rw [hmm]                                       -- 4 段目: `(-1)(-1) = 1`
    _ = z := hleft z                                               -- 5 段目: 左単位元

/-- **`b - a = -(a - b)`**（具体版 `complex_reversed_difference`）。 -/
theorem reversed_difference' {R : Type*} [Semigroup R] [One R] [AddCommMagma R] [LeftDistribClass R]
    [Neg R] [Sub R] (hsub : ∀ x y : R, x - y = x + -y)
    (hneg : ∀ x : R, -x = (-1) * x) (hmm : (-1 : R) * (-1) = 1) (hleft : ∀ x : R, 1 * x = x)
    (a b : R) : b - a = -(a - b) :=
  calc b - a
      = b + -a := hsub b a                                         -- 1 段目: 差の定義
    _ = -a + b := add_comm _ _                                     -- 2 段目: 加法の可換律
    _ = -a + 1 * b := by rw [hleft b]                              -- 3 段目: 左単位元を右辺から左辺へ
    _ = -a + ((-1) * (-1)) * b := by rw [hmm]                      -- 4 段目: `(-1)(-1) = 1` を右辺から左辺へ
    _ = -a + (-1) * ((-1) * b) := by rw [mul_assoc]                -- 5 段目: 積の結合律
    _ = -a + (-1) * (-b) := by rw [← hneg b]                       -- 6 段目: `-x = (-1)x`（`x → b`）を右辺から左辺へ
    _ = (-1) * a + (-1) * (-b) := by rw [hneg a]                   -- 7 段目: `-x = (-1)x`（`x → a`）
    _ = (-1) * (a + -b) := (mul_add _ _ _).symm                    -- 8 段目: 左からの分配律を右辺から左辺へ
    _ = -(a + -b) := (hneg _).symm                                 -- 9 段目: `-x = (-1)x`（`x → a + (-b)`）を右辺から左辺へ
    _ = -(a - b) := by rw [hsub]                                   -- 10 段目: 差の定義を右辺から左辺へ

end Ising2D.NecSuf
