/-
# 正の実数の二乗の一意性（具体版）

正本: `structured-latex/content/000_calculation_formulae_00_09.ts`
（`calc_formulae_000c0_claim_positive_real_square_injective`、ラベル **`positive_real_square_injective`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| `a = b ⇒ a^2 = b^2`（等しい実数を二乗しても等しい） | `positive_real_square_injective` の `mpr` |
| `(a-b)(a+b) = a^2 - b^2 = 0` の 2 行 | `h1` の `calc` の 2 段 |
| `a + b > 0`、`a + b ≠ 0`、ℝ は整域で `a - b = 0`、`b` を加えて `a = b` の 4 行 | `hpos`・`hne`・`hsub`・最後の行 |

必要十分版は `Ising2D/NecSuf/PositiveSquareInjective.lean` の `NecSuf.positive_square_injective'`
（係数は零因子の無い可換環で、前順序と `AddLeftStrictMono` だけ）。特殊化は `ClaimPositiveRealSquareInjectiveFromNecSuf.lean`。
人手の `a^2` は `aa` の略記で、Lean の `a ^ 2` は `sq` で `a * a` に読み替える。
-/
import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring

namespace Ising2D

/-- **人手 `positive_real_square_injective`**: `a, b ∈ ℝ_{>0}` について `a^2 = b^2 ⟺ a = b`。 -/
theorem positive_real_square_injective {a b : ℝ} (ha : 0 < a) (hb : 0 < b) :
    a ^ 2 = b ^ 2 ↔ a = b := by
  constructor
  · intro h
    have h1 : (a - b) * (a + b) = 0 :=
      calc (a - b) * (a + b)
          = a ^ 2 - b ^ 2 := by ring                     -- 2 乗の差の因数分解
        _ = 0 := by rw [h, sub_self]                     -- `a^2 = b^2`
    have hpos : a + b > 0 := add_pos ha hb               -- 正の実数の和は正
    have hne : a + b ≠ 0 := ne_of_gt hpos                -- 正の実数は 0 でない
    have hsub : a - b = 0 :=
      (mul_eq_zero.1 h1).resolve_right hne               -- ℝ は整域
    exact sub_eq_zero.1 hsub                             -- 両辺に `b` を加える
  · intro h
    rw [h]                                               -- 等しい実数を二乗しても等しい

end Ising2D
