/-
# `(t z) s = z`（`t s = 1`、`t` と `z` が可換。必要十分版）

具体版: `Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimTwiceTimesInverseOfTwoIsOriginalInCC.lean`
（人手 `twice_times_inverse_of_two_is_original_in_cc`）。具体版をこのファイルの系として導くのは
具体版と同じフォルダの `ClaimTwiceTimesInverseOfTwoIsOriginalInCCFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `complex_two_mul_mul_inv_two` の 4 段 | `mul_mul_right_inverse_of_commute'` の 4 段（同じ並び） |

## 何が効いているか / 効いていないか

- 効いているのは、積の結合律（`Semigroup`）と、`t` と `z` が可換であること（仮定 `hc`。人手の積の可換律の段）、
  `t` の右逆元 `s`（仮定 `hinv : t * s = 1`。人手の `multiplicative_group_of_cc` の逆元の段）、`1` が右単位元であること
  （仮定 `hone`。人手の積の単位元の段）だけである。
- **積の可換律は `t` と `z` の 1 組についてしか使わない。** 一般の可換律（`CommSemigroup`）は取らない。
- **`s` が左逆元でもあること・`t` 以外の元の逆元（体・群であること）・`1` が左単位元であること・加法・複素数であることは効いていない。**
  `2_ℂ ≠ 0_ℂ` は右逆元の存在（`hinv`）を出すためだけに要る（`2 = 0` の体、すなわち標数 2 では `hinv` が成り立たない）。
  `Monoid` を取ると使わない左単位元が入るので取らず、`Semigroup` と `One` に右単位元だけを仮定で渡す
  （`SumPlusAndMinusDifference.lean` と同じ扱い）。
-/
import Mathlib.Algebra.Group.Defs

namespace Ising2D.NecSuf

/-- **`(t z) s = z`**（具体版 `complex_two_mul_mul_inv_two`。`t → 2_ℂ`、`s → 2_ℂ^{-1}`）。 -/
theorem mul_mul_right_inverse_of_commute' {M : Type*} [Semigroup M] [One M]
    (hone : ∀ x : M, x * 1 = x) (t s z : M) (hc : t * z = z * t) (hinv : t * s = 1) :
    (t * z) * s = z :=
  calc (t * z) * s
      = (z * t) * s := by rw [hc]                                -- 1 段目: `t` と `z` の可換性
    _ = z * (t * s) := mul_assoc _ _ _                           -- 2 段目: 積の結合律
    _ = z * 1 := by rw [hinv]                                    -- 3 段目: `t` の右逆元
    _ = z := hone z                                              -- 4 段目: 右単位元

end Ising2D.NecSuf
