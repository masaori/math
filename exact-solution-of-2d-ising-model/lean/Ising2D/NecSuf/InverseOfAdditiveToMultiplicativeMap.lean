/-
# 加法を乗法へ移す写像の逆写像: 狭義単調性・積・冪（必要十分版）

対応する人手証明のラベル: `real_log_strictly_increasing`、`real_log_of_product`、`real_log_of_power`
具体版: `Ising2D/PartitionFunction/TransferMatrixRepresentation/ClaimRealLogStrictlyIncreasing.lean`、
`Ising2D/MathematicalTools/RealSquareRootExponentialAndHyperbolicFunctions/ClaimRealLogOfProduct.lean`、
`Ising2D/MathematicalTools/RealSquareRootExponentialAndHyperbolicFunctions/ClaimRealLogOfPower.lean`
（具体版をこのファイルの系として導くのは、それぞれの `*FromNecSuf.lean`）

人手の実対数 `log : ℝ_{>0} → ℝ` は `def_real_logarithm_positive` で `exp` の逆写像として定まる。
ここでは `exp` を写像 `f : G → R`、`log` を写像 `L : R → G`、`ℝ_{>0}` を `R` の部分集合を表す述語 `P` に置き換える。

## 何が効いているか / 効いていないか

| 人手の主張 | 具体版の段 | 必要十分版の段 | 効いている仮定 |
| --- | --- | --- | --- |
| `real_log_strictly_increasing` | `log u < log v` でないと仮定し三分律 → `log v < log u` なら `v = exp(log v) < exp(log u) = u`、`log v = log u` なら `v = exp(log v) = exp(log u) = u` → どちらも `u < v` と矛盾 | `inv_strictMono`（同じ段） | `G` の順序の三分律、`R` の `<` の非対称性と非反射性、`f` の狭義単調性、`P y` なら `f(L y) = y` |
| `real_log_of_product` | `exp(log a + log b) = exp(log a)exp(log b) = ab` → `log(ab) = log(exp(log a + log b)) = log a + log b` | `inv_map_mul`（同じ段） | `f(x + y) = f(x)f(y)`、`P y` なら `f(L y) = y`、`L(f x) = x`、`P` が積で閉じること |
| `real_log_of_power` | `n` の帰納法。`n = 1` は `a^1 = a^0a = 1·a = a` と `log(a^1) = log a = 1·log a = ι(1) log a`、`n → n+1` は `log(a^{n+1}) = log(a^na) = log(a^n) + log a = ι(n) log a + log a = ι(n) log a + 1·log a = (ι(n)+1) log a = ι(n+1) log a` | `inv_map_pow`（同じ段。ただし `1·log a = ι(1) log a` は `one_nsmul` の 1 段、`ι(n) log a + log a = … = ι(n+1) log a` の 3 行は `succ_nsmul` の 1 段にまとまる。`G` の `n` 倍では `ι` と `G` の積を分けて書けないため） | 積の法則（`real_log_of_product` の形）、`P` が積で閉じること、`1 • x = x` と `(n+1) • x = n • x + x`（`G` の `n` 倍）、`a^1 = a^0a`・`a^0 = 1`・`1a = a`（`R` の冪）。`[AddMonoid G]`・`[Monoid R]` は記法 `•`・`^` のためで、加法・乗法の結合則は効いていない |

- **効いていないもの**: `exp` の連続性・全射性（人手の定義が実解析の事実として使うもの）、`G`・`R` が `ℝ` であること、
  `G` の乗法（人手の `ι(n) log a` の実数の積は、`G` の `n` 倍 `n • L a` で足りる）、`R` の加法、`R` の乗法の可換性。
- 狭義単調性の証明は `f` の加法の法則も `L(f x) = x` も使わない。積の法則の証明は順序を使わない。
-/
import Mathlib.Algebra.Group.Basic
import Mathlib.Algebra.Group.Nat.Defs
import Mathlib.Data.Nat.Init
import Mathlib.Order.Basic

namespace Ising2D.NecSuf

/-- **必要十分版の `real_log_strictly_increasing`**: `f` が狭義単調で、`P y` なら `f(L y) = y` のとき、
`P u`・`P v`・`u < v` なら `L u < L v`。具体版と同じく、`L u < L v` でないと仮定して三分律で `L v < L u` と `L v = L u` に分け、
どちらも `u < v` と両立しないことを示す。 -/
theorem inv_strictMono {G R : Type*} [LinearOrder G] [Preorder R] (f : G → R) (L : R → G) (P : R → Prop)
    (hf : ∀ x y : G, x < y → f x < f y) (hfL : ∀ y : R, P y → f (L y) = y)
    {u v : R} (hu : P u) (hv : P v) (huv : u < v) : L u < L v := by
  by_contra hne                                         -- `L u < L v` でないと仮定する
  rcases lt_or_eq_of_le (not_lt.1 hne) with h | h        -- 三分律: `L v < L u` か `L v = L u`
  · -- `L v < L u` の場合
    have hvu : v < u :=
      calc v = f (L v) := (hfL v hv).symm               -- `P y` なら `f(L y) = y`
        _ < f (L u) := hf (L v) (L u) h                  -- `f` の狭義単調性
        _ = u := hfL u hu                                -- `P y` なら `f(L y) = y`
    exact lt_asymm huv hvu                               -- `<` の非対称性
  · -- `L v = L u` の場合
    have hvu : v = u :=
      calc v = f (L v) := (hfL v hv).symm               -- `P y` なら `f(L y) = y`
        _ = f (L u) := by rw [h]                         -- `L v = L u`
        _ = u := hfL u hu                                -- `P y` なら `f(L y) = y`
    exact lt_irrefl u (hvu ▸ huv)                        -- `<` の非反射性

/-- **必要十分版の `real_log_of_product`**: `f(x + y) = f(x)f(y)`、`P y` なら `f(L y) = y`、`L(f x) = x` のとき、
`P a`・`P b` なら `P (ab)` かつ `L(ab) = L a + L b`。`P (ab)` は仮定 `hPmul`（具体版の「正の数の積は正」）である。 -/
theorem inv_map_mul {G R : Type*} [Add G] [Mul R] (f : G → R) (L : R → G) (P : R → Prop)
    (hadd : ∀ x y : G, f (x + y) = f x * f y) (hfL : ∀ y : R, P y → f (L y) = y)
    (hLf : ∀ x : G, L (f x) = x) (hPmul : ∀ a b : R, P a → P b → P (a * b))
    {a b : R} (ha : P a) (hb : P b) : P (a * b) ∧ L (a * b) = L a + L b := by
  have hprep : f (L a + L b) = a * b :=
    calc f (L a + L b) = f (L a) * f (L b) := hadd (L a) (L b)    -- 加法の法則を右辺から左辺へ
      _ = a * b := by rw [hfL a ha, hfL b hb]                     -- `f(L y) = y` を 2 か所へ
  refine ⟨hPmul a b ha hb, ?_⟩
  calc L (a * b) = L (f (L a + L b)) := by rw [hprep]             -- 準備の鎖
    _ = L a + L b := hLf (L a + L b)                              -- `L(f x) = x`

/-- **必要十分版の `real_log_of_power`**: 積の法則 `L(ab) = L a + L b`（`P a`・`P b`）と `P` が積で閉じることから、
`P a`・`n ≥ 1` なら `P (a^n)` かつ `L(a^n) = n • L a`。具体版と同じく `n` の帰納法で 2 つを同時に示す。 -/
theorem inv_map_pow {G R : Type*} [AddMonoid G] [Monoid R] (L : R → G) (P : R → Prop)
    (hmul : ∀ a b : R, P a → P b → L (a * b) = L a + L b) (hPmul : ∀ a b : R, P a → P b → P (a * b))
    {a : R} (ha : P a) : ∀ n : ℕ, 1 ≤ n → P (a ^ n) ∧ L (a ^ n) = n • L a := by
  intro n hn
  induction n, hn using Nat.le_induction with
  | base =>
    have h1 : a ^ 1 = a :=
      calc a ^ 1 = a ^ 0 * a := pow_succ a 0                      -- 冪の定義 `a^{m+1} := a^m a`（`m = 0`）
        _ = 1 * a := by rw [pow_zero]                             -- 冪の定義 `a^0 := 1`
        _ = a := one_mul a                                        -- 乗法の単位元
    refine ⟨by rw [h1]; exact ha, ?_⟩
    calc L (a ^ 1) = L a := by rw [h1]                            -- 上の `a^1 = a`
      _ = 1 • L a := (one_nsmul (L a)).symm                       -- 加法の `1` 倍
  | succ n hn ih =>
    refine ⟨?_, ?_⟩
    · rw [pow_succ]                                               -- `a^{n+1} = a^n a`
      exact hPmul _ _ ih.1 ha                                     -- `P` は積で閉じる
    · calc L (a ^ (n + 1)) = L (a ^ n * a) := by rw [pow_succ]    -- 冪の定義 `a^{n+1} := a^n a`
        _ = L (a ^ n) + L a := hmul _ _ ih.1 ha                   -- 積の法則を `a^n, a` に
        _ = n • L a + L a := by rw [ih.2]                         -- 帰納法の仮定
        _ = (n + 1) • L a := (succ_nsmul (L a) n).symm            -- `n` 倍に `1` 倍を足すと `n+1` 倍

end Ising2D.NecSuf
