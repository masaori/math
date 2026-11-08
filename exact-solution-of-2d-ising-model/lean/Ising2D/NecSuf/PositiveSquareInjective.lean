/-
# 正の元の二乗の一意性（**必要十分版**）

対応する人手証明のラベル: `positive_real_square_injective`（`structured-latex/content/000_calculation_formulae_00_09.ts`）。
具体版は `Ising2D/MathematicalTools/RealSquareRootExponentialAndHyperbolicFunctions/ClaimPositiveRealSquareInjective.lean` の
`positive_real_square_injective`（逆向きの鎖は `factor_difference_of_squares_eq_zero`）、特殊化は同じフォルダの
`ClaimPositiveRealSquareInjectiveFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `factor_difference_of_squares_eq_zero` の `calc` の 8 段 | `factor_difference_of_squares_eq_zero'` の `calc` の 8 段（同じ並び） |
| `positive_real_square_injective` の `hpos`・`hne`・`hsub`・最後の行と `mpr` | `positive_square_injective'` の同じ段 |

## 効いているもの / 効いていないもの

具体版と同じ手順のまま、係数を次だけを持つ `R` に上げる。

- 環（`Ring`）: 分配法則 2 回（`mul_add`・`sub_mul`）、打ち消し（`sub_add_sub_cancel`）、`b^2 − b^2 = 0`。
- `b a = a b`（仮定 `hab : Commute b a`）: 3 段目の乗法の交換法則は、この 1 組の元にしか使っていない。
  これを外すと `(a-b)(a+b) = a^2 + ab - ba - b^2` で、`-ab` と `ab` の打ち消しの段が通らない。環全体の可換性は効いていない。
- 冪の定義（`Monoid.npow` の `pow_zero`・`pow_succ`）: 5・6 段目の `sq_eq_mul_self'`（`NecSuf/SquareIsProduct.lean`）。
- 零因子が無いこと（`NoZeroDivisors`）: 人手の「ℝ は整域」の段。
- 前順序と、和が正の元を保つこと（`Preorder`・`AddLeftStrictMono`）: 人手の「正の実数の和は正」「正の実数は 0 でない」の段。

効いていないもの: 環全体の積の可換性、加法の可換性（証明では使わないが、`Ring` と `sub_mul` に付いてくるので仮定からは外せない）、乗法の結合則（同じく使わないが、冪のための `Monoid` に付いてくる）、体であること（逆元）、順序が全順序であること、順序と積の両立、完備性、実数であること。
-/
import Mathlib.Algebra.Order.Ring.Defs
import Ising2D.NecSuf.SquareIsProduct

namespace Ising2D.NecSuf

/-- **人手 `positive_real_square_injective` の逆向きの鎖**の必要十分版: `b a = a b` かつ `a^2 = b^2` なら `(a-b)(a+b) = 0`。 -/
theorem factor_difference_of_squares_eq_zero' {R : Type*} [Ring R] {a b : R} (hab : Commute b a)
    (h : a ^ 2 = b ^ 2) : (a - b) * (a + b) = 0 :=
  calc (a - b) * (a + b)
      = (a - b) * a + (a - b) * b := mul_add (a - b) a b                      -- 分配法則
    _ = (a * a - b * a) + (a * b - b * b) := by rw [sub_mul a b a, sub_mul a b b]  -- 分配法則
    _ = (a * a - a * b) + (a * b - b * b) := by rw [hab.eq]                   -- `b a = a b`（効くのはこの 1 組だけ）
    _ = a * a - b * b := sub_add_sub_cancel (a * a) (a * b) (b * b)           -- `-ab` と `ab` が打ち消し合う
    _ = a ^ 2 - b * b := by rw [sq_eq_mul_self' a]                            -- 二乗は積（`r → a`）を右辺から左辺へ
    _ = a ^ 2 - b ^ 2 := by rw [sq_eq_mul_self' b]                            -- 二乗は積（`r → b`）を右辺から左辺へ
    _ = b ^ 2 - b ^ 2 := by rw [h]                                            -- `a^2 = b^2`
    _ = 0 := sub_self (b ^ 2)                                                 -- `b^2 − b^2 = 0`

/-- **人手 `positive_real_square_injective` の核**: `b a = a b`、`0 < a`、`0 < b` なら `a^2 = b^2 ↔ a = b`。 -/
theorem positive_square_injective' {R : Type*} [Ring R] [NoZeroDivisors R] [Preorder R]
    [AddLeftStrictMono R] {a b : R} (hab : Commute b a) (ha : 0 < a) (hb : 0 < b) :
    a ^ 2 = b ^ 2 ↔ a = b := by
  constructor
  · intro h
    have h1 : (a - b) * (a + b) = 0 := factor_difference_of_squares_eq_zero' hab h
    have hpos : 0 < a + b := add_pos ha hb               -- 正の元の和は正
    have hne : a + b ≠ 0 := ne_of_gt hpos                -- 正の元は 0 でない
    have hsub : a - b = 0 :=
      (mul_eq_zero.1 h1).resolve_right hne               -- 零因子が無い
    exact sub_eq_zero.1 hsub                             -- 両辺に `b` を加える
  · intro h
    rw [h]                                               -- `a^2` の `a` へ `a = b` を代入する

end Ising2D.NecSuf
