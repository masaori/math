/-
# 単位元と積を保つ写像は冪を保つ（必要十分版）

対応する人手証明のラベル: `real_inclusion_preserves_power`
具体版: `Ising2D/MathematicalTools/KroneckerProductAndMultiFactorBasis/ClaimRealInclusionPreservesPower.lean` の `real_inclusion_of_power`
（具体版をこのファイルの系として導くのは、同じフォルダの `ClaimRealInclusionPreservesPowerFromNecSuf.lean`）

人手の `ι_{ℝ→ℂ}` を、2 つの集合の間の写像 `f : A → B` に置き換える。

## 何が効いているか / 効いていないか

| 人手の段 | 具体版の段 | 必要十分版の段 | 効いている仮定 |
| --- | --- | --- | --- |
| `m = 0` の 3 行 | `(r^0)_ℂ = (1_ℝ)_ℂ = 1_ℂ = (r_ℂ)^0` | `map_pow_of_map_one_of_map_mul'` の `zero`（同じ 3 段） | 冪の `a^0 = 1`（両側）、`f(1) = 1`（仮定 `h1`） |
| 帰納法の段の 4 行 | `(r^{m+1})_ℂ = (r^m r)_ℂ = (r^m)_ℂ r_ℂ = (r_ℂ)^m r_ℂ = (r_ℂ)^{m+1}` | `succ`（同じ 4 段） | 冪の `a^{m+1} = a^m a`（両側）、`f(ab) = f(a)f(b)`（仮定 `hmul`。人手の `real_inclusion_preserves_product`） |

- **型クラスについて**: 両側に置くのは、単位元 `[One]` と積 `[Mul]` だけである。冪は、人手の
  `def_power_of_real_number`・`def_power_of_complex_number` と同じ 2 つの式 `a^0 = 1`・`a^{m+1} = a^m a` で
  定まる Lean の `npowRec` で書く（2 つの式は `npowRec` の定義そのものなので、各段は定義の展開で閉じる）。
  mathlib の記法 `^`（`Monoid` の冪）を使わないので、乗法の結合則・単位元の公理は仮定に入らない。
- **効いていないもの**: `ℝ`・`ℂ` であること、和・符号反転・除法、乗法の可換性・結合則、単位元が単位元であること
  （`1 a = a = a 1`）、`f` が単射であること。
- 仮定 `h1`・`hmul` はどちらも削れない。`h1` を削ると `m = 0` の段が、`hmul` を削ると帰納法の 2 段目が通らない
  （例えば定数写像 `f := fun _ => 2` は `hmul` を満たさず、`f(a^0) = 2 ≠ 1 = f(a)^0`）。
-/
import Mathlib.Tactic.TypeStar

namespace Ising2D.NecSuf

/-- **必要十分版の `real_inclusion_preserves_power`**: `f(1) = 1` と `f(ab) = f(a)f(b)` を満たす写像は冪を保つ。
冪は `npowRec`（`a^0 = 1`、`a^{m+1} = a^m a`）。具体版 `real_inclusion_of_power` と同じく `m` についての帰納法。 -/
theorem map_pow_of_map_one_of_map_mul' {A B : Type*} [One A] [Mul A] [One B] [Mul B] (f : A → B)
    (h1 : f 1 = 1) (hmul : ∀ a b : A, f (a * b) = f a * f b) (a : A) (m : Nat) :
    f (npowRec m a) = npowRec m (f a) := by
  induction m with
  | zero =>
    calc f (npowRec 0 a)
        = f 1 := rfl                             -- 冪の `a^0 = 1`（`npowRec` の定義）
      _ = 1 := h1                                -- `f(1) = 1`
      _ = npowRec 0 (f a) := rfl                 -- 冪の `b^0 = 1` を右辺から左辺へ（`npowRec` の定義）
  | succ m ih =>
    calc f (npowRec (m + 1) a)
        = f (npowRec m a * a) := rfl             -- 冪の `a^{m+1} = a^m a`（`npowRec` の定義）
      _ = f (npowRec m a) * f a := hmul _ _      -- `f(ab) = f(a)f(b)`（`a → a^m`、`b → a`）
      _ = npowRec m (f a) * f a := by rw [ih]    -- 帰納法の仮定
      _ = npowRec (m + 1) (f a) := rfl           -- 冪の `b^{m+1} = b^m b` を右辺から左辺へ（`npowRec` の定義）

end Ising2D.NecSuf
