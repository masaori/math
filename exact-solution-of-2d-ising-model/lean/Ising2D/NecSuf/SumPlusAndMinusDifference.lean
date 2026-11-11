/-
# `(a+b) + (a-b) = 2a`・`(a+b) - (a-b) = 2b`（必要十分版）

具体版: `Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimSumPlusAndMinusDifferenceInCC.lean`
（人手 `sum_plus_difference_is_twice_first_in_cc`・`sum_minus_difference_is_twice_second_in_cc`）。具体版をこのファイルの系として
導くのは同じフォルダの `ClaimSumPlusAndMinusDifferenceInCCFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `complex_sum_add_difference` の 11 段 | `sum_add_difference'` の 11 段（同じ並び） |
| `complex_sum_sub_difference` の 17 段 | `sum_sub_difference'` の 17 段（同じ並び） |

## 何が効いているか / 効いていないか

- 差と和のつながりは仮定 `hsub : ∀ x y, x - y = x + -y`（人手の `def_complex_difference`）、符号反転と積のつながりは
  `hneg : ∀ x, -x = (-1) * x`（人手の `multiply_by_minus_one`）と `hmm : (-1) * (-1) = 1`（人手の
  `minus_one_times_minus_one_is_one_in_cc`）で渡す。符号反転が加法の逆元であることは `hinv : ∀ x, x + -x = 0`、
  零元が加法の右単位元であることは `hzero : ∀ x, x + 0 = x`、左単位元は `hleft : ∀ x, 1 * x = x` で渡す。
  `2` は元 `two` と仮定 `htwo : 1 + 1 = two`（人手の `one_plus_one_is_two_in_cc`）で渡す。
  `Ring` を取ると結論が型クラスの側から出てしまい、何が効いているかが見えなくなるので取らない。
  `AddCommMonoid`・`Monoid` を取ると使わない左単位元・右単位元と倍・冪が入るので取らず、`AddCommSemigroup`・`Zero` と
  `Semigroup`（または `Mul`）・`One` に、使う単位元の向きだけを仮定で渡す（`DoubleNegationAndReversedDifference.lean` と同じ扱い）。
- `sum_add_difference'` で効いているのは `hsub`・`hinv`・`hzero`・`hleft`・`htwo`、加法の結合律と可換律（`AddCommSemigroup`）、
  右からの分配律（`RightDistribClass`）である。**符号反転と積のつながり（`hneg`・`hmm`）・積の結合律・左からの分配律は効いていない**
  （型クラスにも仮定にも取らない）。
- `sum_sub_difference'` で効いているのは上の 5 つの仮定と `hneg`・`hmm`、加法の結合律と可換律、積の結合律（`Semigroup`）、
  左からの分配律と右からの分配律である。
- 両方とも、積の可換律・積の逆元（体であること）・複素数であることは効いていない。`-b` を `(-1)b` と読む人手の定義
  （`hneg`）は、`(a+b)+(a-b)` の側では使われず、`(a+b)-(a-b)` の側で `-(a-b)` を開くときだけ使われる。
-/
import Mathlib.Algebra.Ring.Defs
import Mathlib.Algebra.Group.Defs

namespace Ising2D.NecSuf

/-- **`(a+b) + (a-b) = 2a`**（具体版 `complex_sum_add_difference`）。 -/
theorem sum_add_difference' {R : Type*} [AddCommSemigroup R] [Zero R] [Mul R] [One R]
    [RightDistribClass R] [Neg R] [Sub R]
    (hsub : ∀ x y : R, x - y = x + -y) (hinv : ∀ x : R, x + -x = 0) (hzero : ∀ x : R, x + 0 = x)
    (hleft : ∀ x : R, 1 * x = x) (two : R) (htwo : (1 : R) + 1 = two)
    (a b : R) : (a + b) + (a - b) = two * a :=
  calc (a + b) + (a - b)
      = (a + b) + (a + -b) := by rw [hsub a b]                   -- 1 段目: 差の定義
    _ = ((a + b) + a) + -b := (add_assoc _ _ _).symm             -- 2 段目: 加法の結合律を右辺から左辺へ
    _ = (a + (b + a)) + -b := by rw [add_assoc a b a]            -- 3 段目: 加法の結合律
    _ = (a + (a + b)) + -b := by rw [add_comm b a]               -- 4 段目: 加法の可換律
    _ = ((a + a) + b) + -b := by rw [← add_assoc a a b]          -- 5 段目: 加法の結合律を右辺から左辺へ
    _ = (a + a) + (b + -b) := add_assoc _ _ _                    -- 6 段目: 加法の結合律
    _ = (a + a) + 0 := by rw [hinv b]                            -- 7 段目: `x + (-x) = 0`
    _ = a + a := hzero _                                         -- 8 段目: `x + 0 = x`
    _ = 1 * a + 1 * a := by rw [hleft a]                         -- 9 段目: 左単位元を 2 か所へ右辺から左辺へ
    _ = (1 + 1) * a := (add_mul _ _ _).symm                      -- 10 段目: 右からの分配律を右辺から左辺へ
    _ = two * a := by rw [htwo]                                  -- 11 段目: `1 + 1 = 2`

/-- **`(a+b) - (a-b) = 2b`**（具体版 `complex_sum_sub_difference`）。 -/
theorem sum_sub_difference' {R : Type*} [AddCommSemigroup R] [Zero R] [Semigroup R] [One R]
    [LeftDistribClass R] [RightDistribClass R] [Neg R] [Sub R]
    (hsub : ∀ x y : R, x - y = x + -y) (hneg : ∀ x : R, -x = (-1) * x) (hmm : (-1 : R) * (-1) = 1)
    (hinv : ∀ x : R, x + -x = 0) (hzero : ∀ x : R, x + 0 = x)
    (hleft : ∀ x : R, 1 * x = x) (two : R) (htwo : (1 : R) + 1 = two)
    (a b : R) : (a + b) - (a - b) = two * b :=
  calc (a + b) - (a - b)
      = (a + b) + (-(a - b)) := hsub _ _                                    -- 1 段目: 差の定義
    _ = (a + b) + (-(a + (-b))) := by rw [hsub a b]                         -- 2 段目: 差の定義
    _ = (a + b) + (-1) * (a + (-b)) := by rw [hneg (a + (-b))]              -- 3 段目: `-x = (-1)x`
    _ = (a + b) + ((-1) * a + (-1) * (-b)) := by rw [mul_add]               -- 4 段目: 左からの分配律
    _ = (a + b) + ((-1) * a + (-1) * ((-1) * b)) := by rw [hneg b]          -- 5 段目: `-x = (-1)x`（`x → b`）
    _ = (a + b) + ((-1) * a + ((-1) * (-1)) * b) := by
        rw [← mul_assoc (-1 : R) (-1) b]                                    -- 6 段目: 積の結合律を右辺から左辺へ
    _ = (a + b) + ((-1) * a + 1 * b) := by rw [hmm]                         -- 7 段目: `(-1)(-1) = 1`
    _ = (a + b) + ((-1) * a + b) := by rw [hleft b]                         -- 8 段目: 左単位元
    _ = (a + b) + ((-a) + b) := by rw [← hneg a]                            -- 9 段目: `-x = (-1)x`（`x → a`）を右辺から左辺へ
    _ = ((a + b) + (-a)) + b := (add_assoc _ _ _).symm                      -- 10 段目: 加法の結合律を右辺から左辺へ
    _ = ((b + a) + (-a)) + b := by rw [add_comm a b]                        -- 11 段目: 加法の可換律
    _ = (b + (a + (-a))) + b := by rw [add_assoc b a (-a)]                  -- 12 段目: 加法の結合律
    _ = (b + 0) + b := by rw [hinv a]                                       -- 13 段目: `x + (-x) = 0`
    _ = b + b := by rw [hzero b]                                            -- 14 段目: `x + 0 = x`
    _ = 1 * b + 1 * b := by rw [hleft b]                                    -- 15 段目: 左単位元を 2 か所へ右辺から左辺へ
    _ = (1 + 1) * b := (add_mul _ _ _).symm                                 -- 16 段目: 右からの分配律を右辺から左辺へ
    _ = two * b := by rw [htwo]                                             -- 17 段目: `1 + 1 = 2`

end Ising2D.NecSuf
