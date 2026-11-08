/-
# 定数の左から掛ける有限積は冪に等しい（**必要十分版**）

具体版: `Ising2D/MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimFiniteProductOfConstantRealIsPower.lean`
（人手 `finite_product_of_constant_real_is_power`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimFiniteProductOfConstantRealIsPowerFromNecSuf.lean`。

有限積は `NecSuf.finProdLeft`（`FiniteProductLeft.lean`。人手 `def_finite_product_of_real_numbers` の 2 つの式がそのまま 2 つの節）である。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `m = 1` の 4 段（定義 → `1r = r` → `a^0 := 1` → `a^{m+1} := a^m a`） | `finProdLeft_const_eq_pow'` の `0` の節（同じ並び） |
| `m → m + 1` の 3 段（定義 → 帰納法の仮定 → `a^{m+1} := a^m a`） | `finProdLeft_const_eq_pow'` の `m + 1` の節（同じ並び） |

## 何が効いているか / 効いていないか

- 効くのは、`1` が左の単位元であること（`1r = r`。`m = 1` の 2 段目）と、冪の定義の 2 つの式（`a^0 = 1`・`a^{m+1} = a^m a`）だけである。
  積の結合則・可換則、`1` が右の単位元であること、和・順序は効いていない。
- `Monoid R` は mathlib の冪 `^`（`Monoid.npow`）と、その定義の式 `pow_zero`・`pow_succ` を使うためだけに要る。
  `Monoid` はその公理として積の結合則と右の単位元も含むが、証明はそれらを使わない（`PowerFromProductOfTwoValuedFactors.lean` と同じ事情）。
-/
import Ising2D.NecSuf.FiniteProductLeft

namespace Ising2D.NecSuf

/-- **`finite_product_of_constant_real_is_power`** の必要十分版: `Π_{j=1}^{m+1} r = r^{m+1}`。 -/
theorem finProdLeft_const_eq_pow' {R : Type*} [Monoid R] :
    ∀ (m : ℕ) (r : R), finProdLeft m (fun _ => r) = r ^ (m + 1)
  | 0, r =>
    calc finProdLeft 0 (fun _ => r)
        = r := finProdLeft_zero _                                             -- 定義
      _ = 1 * r := (one_mul r).symm                                           -- `1` は左の単位元
      _ = r ^ 0 * r := by rw [pow_zero]                                       -- `a^0 = 1` を右辺から左辺へ
      _ = r ^ (0 + 1) := (pow_succ r 0).symm                                  -- `a^{m+1} = a^m a` を右辺から左辺へ
  | m + 1, r =>
    calc finProdLeft (m + 1) (fun _ => r)
        = finProdLeft m (fun _ => r) * r := finProdLeft_succ m _              -- 定義
      _ = r ^ (m + 1) * r := by rw [finProdLeft_const_eq_pow' m r]            -- 帰納法の仮定
      _ = r ^ (m + 1 + 1) := (pow_succ r (m + 1)).symm                        -- `a^{m+1} = a^m a` を右辺から左辺へ

end Ising2D.NecSuf
