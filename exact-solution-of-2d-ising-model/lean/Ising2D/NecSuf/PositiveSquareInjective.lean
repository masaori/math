/-
# 正の元の二乗の一意性（**必要十分版**）

対応する人手証明のラベル: `positive_real_square_injective`（`structured-latex/content/000_calculation_formulae_00_09.ts`）。
具体版は `Ising2D/MathematicalTools/RealSquareRootExponentialAndHyperbolicFunctions/ClaimPositiveRealSquareInjective.lean` の
`positive_real_square_injective`、特殊化は同じフォルダの `ClaimPositiveRealSquareInjectiveFromNecSuf.lean`。

## 効いているもの / 効いていないもの

具体版と同じ手順（`a = b ⇒ a^2 = b^2`、逆に `(a-b)(a+b) = a^2 - b^2 = 0`、`a + b > 0`、`a + b ≠ 0`、零因子が無いので
`a - b = 0`、`b` を加えて `a = b`）のまま、係数を次だけを持つ `R` に上げる。

- 可換環（`CommRing`）: `(a-b)(a+b) = a^2 - b^2` に積の可換律 `ba = ab` が要る（`-ba + ab` を消すため）。
  非可換な環では `(a-b)(a+b) = a^2 + ab - ba - b^2` で、この段が通らない。
- 零因子が無いこと（`NoZeroDivisors`）: 人手の「ℝ は整域」の段。
- 前順序と、和が正の元を保つこと（`Preorder`・`AddLeftStrictMono`）: 人手の「正の実数の和は正」「正の実数は 0 でない」の段。

効いていないもの: 体であること（逆元）、順序が全順序であること、順序と積の両立、完備性、実数であること。
-/
import Mathlib.Algebra.Order.Ring.Defs
import Mathlib.Tactic.Ring

namespace Ising2D.NecSuf

/-- **人手 `positive_real_square_injective` の核**: `0 < a`、`0 < b` なら `a^2 = b^2 ↔ a = b`。 -/
theorem positive_square_injective' {R : Type*} [CommRing R] [NoZeroDivisors R] [Preorder R]
    [AddLeftStrictMono R] {a b : R} (ha : 0 < a) (hb : 0 < b) : a ^ 2 = b ^ 2 ↔ a = b := by
  constructor
  · intro h
    have h1 : (a - b) * (a + b) = 0 :=
      calc (a - b) * (a + b)
          = a ^ 2 - b ^ 2 := by ring                     -- 2 乗の差の因数分解（積の可換律が効く）
        _ = 0 := by rw [h, sub_self]                     -- `a^2 = b^2`
    have hpos : 0 < a + b := add_pos ha hb               -- 正の元の和は正
    have hne : a + b ≠ 0 := ne_of_gt hpos                -- 正の元は 0 でない
    have hsub : a - b = 0 :=
      (mul_eq_zero.1 h1).resolve_right hne               -- 零因子が無い
    exact sub_eq_zero.1 hsub                             -- 両辺に `b` を加える
  · intro h
    rw [h]                                               -- 等しい元を二乗しても等しい

end Ising2D.NecSuf
