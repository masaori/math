/-
# `z(-w) = -(zw)`・`(-z)w = -(zw)`・`(-x) + x = 0`（必要十分版）

具体版: `Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimNegationInProductAndNegationPlusSelfInCC.lean`
（人手 `complex_times_negation_is_negation_of_product_in_cc`・`negation_times_complex_is_negation_of_product_in_cc`・
`negation_plus_self_is_zero_in_cc`）。具体版をこのファイルの系として導くのは同じフォルダの
`ClaimNegationInProductAndNegationPlusSelfInCCFromNecSuf.lean`。可換環での特殊化を `TwoByTwoAdjugateInverse.lean` が使う。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `mul_neg_eq_neg_mul_complex` の 5 段 | `mul_neg_eq_neg_mul_of_neg_one'` の 5 段（同じ並び） |
| `neg_mul_eq_neg_mul_complex` の 3 段 | `neg_mul_eq_neg_mul_of_neg_one'` の 3 段（同じ並び） |
| `neg_add_self_complex` の 8 段 | `neg_add_self_of_neg_one'` の 5 段（4〜7 段目の成分の等式 `(-1,0)+(1,0) = (0,0)` を仮定 `hsum` の 1 段で受ける） |

## 何が効いているか / 効いていないか

- 符号反転と積のつながりは仮定 `hneg : ∀ x, -x = (-1) * x`（人手の `multiply_by_minus_one` はこの形の定義である）で渡す。
  `Ring` を取ると 3 つの主張が型クラスの側から出てしまい、何が効いているかが見えなくなるので取らない。
- `mul_neg_eq_neg_mul_of_neg_one'` で効いているのは `hneg`、積の結合律（`Semigroup`）、`-1` が全ての元と交換すること
  （仮定 `hcomm : ∀ x, x * (-1) = (-1) * x`）である。具体版の 3 段目は積の可換律を `z` と `-1` の組にだけ使っているので、
  **積の可換律そのものは効いていない**。加法も効いていない。
- `neg_mul_eq_neg_mul_of_neg_one'` で効いているのは `hneg` と積の結合律だけである。**交換も加法も効いていない**。
- `neg_add_self_of_neg_one'` で効いているのは `hneg`、左単位元 `hleft : ∀ x, 1 * x = x`、右からの分配律（`RightDistribClass`）、
  `hsum : (-1) + 1 = 0`、零の左からの積 `hzero : ∀ x, 0 * x = 0` である。**積の結合律・可換律、加法の結合律・可換律は効いていない**
  （型クラスにも取らない）。`hsum` は具体版では `ℂ` の成分の等式（`inclusion_rr_to_cc`・`definition_of_cc` の和・`ℝ` の四則）の
  4 段で出しており、必要十分版では成分を持たないので仮定として渡す。`hsum` を外すと `(-x) + x` を `0` へ運ぶ段が無くなる。
- 複素数であること、体であること（積の逆元）は効いていない。
-/
import Mathlib.Algebra.Ring.Defs
import Mathlib.Algebra.Group.Defs

namespace Ising2D.NecSuf

/-- **`z(-w) = -(zw)`**（具体版 `mul_neg_eq_neg_mul_complex`）。 -/
theorem mul_neg_eq_neg_mul_of_neg_one' {R : Type*} [Semigroup R] [One R] [Neg R]
    (hneg : ∀ x : R, -x = (-1) * x) (hcomm : ∀ x : R, x * (-1) = (-1) * x)
    (z w : R) : z * (-w) = -(z * w) :=
  calc z * (-w)
      = z * ((-1) * w) := by rw [hneg w]           -- 1 段目: `-x = (-1)x`（`x → w`）
    _ = (z * (-1)) * w := (mul_assoc _ _ _).symm   -- 2 段目: 積の結合律を右辺から左辺へ
    _ = ((-1) * z) * w := by rw [hcomm z]          -- 3 段目: `-1` との交換（具体版は積の可換律）
    _ = (-1) * (z * w) := mul_assoc _ _ _          -- 4 段目: 積の結合律
    _ = -(z * w) := (hneg _).symm                  -- 5 段目: `-x = (-1)x`（`x → zw`）を右辺から左辺へ

/-- **`(-z)w = -(zw)`**（具体版 `neg_mul_eq_neg_mul_complex`）。 -/
theorem neg_mul_eq_neg_mul_of_neg_one' {R : Type*} [Semigroup R] [One R] [Neg R]
    (hneg : ∀ x : R, -x = (-1) * x) (z w : R) : (-z) * w = -(z * w) :=
  calc (-z) * w
      = ((-1) * z) * w := by rw [hneg z]           -- 1 段目: `-x = (-1)x`（`x → z`）
    _ = (-1) * (z * w) := mul_assoc _ _ _          -- 2 段目: 積の結合律
    _ = -(z * w) := (hneg _).symm                  -- 3 段目: `-x = (-1)x`（`x → zw`）を右辺から左辺へ

/-- **`(-x) + x = 0`**（具体版 `neg_add_self_complex`）。 -/
theorem neg_add_self_of_neg_one' {R : Type*} [Mul R] [Add R] [One R] [Zero R] [Neg R] [RightDistribClass R]
    (hneg : ∀ x : R, -x = (-1) * x) (hleft : ∀ x : R, 1 * x = x) (hsum : (-1 : R) + 1 = 0)
    (hzero : ∀ x : R, 0 * x = 0) (x : R) : (-x) + x = 0 :=
  calc (-x) + x
      = (-1) * x + x := by rw [hneg x]             -- 1 段目: `-x = (-1)x`（`x → x`）
    _ = (-1) * x + 1 * x := by rw [hleft x]        -- 2 段目: 左単位元を右辺から左辺へ
    _ = ((-1) + 1) * x := (add_mul _ _ _).symm     -- 3 段目: 右からの分配律を右辺から左辺へ
    _ = 0 * x := by rw [hsum]                      -- 具体版の 4〜7 段目: `(-1) + 1 = 0`
    _ = 0 := hzero x                               -- 具体版の 8 段目: `0x = 0`

end Ising2D.NecSuf
