/-
# 狭義単調な写像の奇部は狭義単調（**必要十分版**）

対応する人手証明のラベル: `sinh_strictly_increasing`（`structured-latex/content/020_critical_point.ts`）。
具体版は `Ising2D/MathematicalTools/RealSquareRootExponentialAndHyperbolicFunctions/ClaimSinhStrictlyIncreasing.lean` の
`sinh_strictly_increasing`、具体版をこの特殊化として得る導出は同じフォルダの `ClaimSinhStrictlyIncreasingFromNecSuf.lean`。

写像 `e : G → R` と正の元 `k ∈ R` から `s(x) := (e(x) − e(−x))·k` を作る（具体版は `e := exp`、`s := sinh`、`k := 1/2`）。

| 具体版の段 | 必要十分版 |
| --- | --- |
| 準備の 1 本目の鎖（`real_exp_strictly_increasing`） | `hE`（`e` の狭義単調性 `hmono`） |
| 準備の 2 本目の鎖（`real_neg_lt_neg_of_lt`: 両辺に `−1 < 0` を掛ける → `real_exp_strictly_increasing`） | `neg_lt_neg_of_lt'` → `hEN`（`hmono`） |
| 3 本の含意（両辺に `−exp(x)`・`−exp(−y)` を加える、正の実数の和は正） | `h1`・`h2`・`h3`（同じ 3 本） |
| `sinh y − sinh x` の鎖（定義 → 分母の等しい分数の差 → 分子の並べ替え → `2 > 0` で割ると正） | `hd`（定義 `hs` → `sub_mul` → 分子の並べ替え → 正の元 `k` を掛けると正） |
| 最後の含意（両辺に `sinh x` を加える） | 同じ |

## 何が効いているか / 効いていないか

- 定義域 `G` で効くのは、`x < y ⟹ −y < −x` を「両辺に `−1 < 0` を掛ける」で出すための次の仮定だけである:
  環であること（`Ring G`）、加法と順序の両立（`AddLeftStrictMono G`）、正の元を左から掛けると狭義単調（`PosMulStrictMono G`。
  `mul_lt_mul_of_neg_left` が要る）、`0 < 1`（`ZeroLEOneClass G`・`NeZero (1 : G)`。`−1 < 0` に要る）。
  全順序と、右から掛ける側の単調性（`MulPosStrictMono`）は効いていない。
- 写像 `e` で効くのは狭義単調性（`hmono`）だけである。`e` の正値性、`e(0) = 1`、`e(a + b) = e(a)e(b)`、
  級数で定義されていること、連続性・極限・完備性は効いていない。
- 値域 `R` で効くのは、加法と順序の両立（両辺に同じ元を加える、正の元の和は正。`AddLeftStrictMono R`）、
  右分配法則 `ac − bc = (a − b)c` と分子の並べ替え（`Ring R`）、正の元どうしの積が正であること（`PosMulStrictMono R`）だけである。
  全順序、右から掛ける側の単調性、`0 < 1`、非自明性は効いていない。
- 具体版の `/2` は、正の元 `k` を掛けることとしてしか効いていない。`2` の逆元であること（`2·k = 1`）は使わない
  （`HyperbolicBasicPropertiesFromMonotoneMap.lean` の `⅟2` と違い、約分の段が無いため）。乗法の可換律も効いていない。
-/
import Mathlib.Algebra.Order.Ring.Unbundled.Basic
import Mathlib.Tactic.Abel

namespace Ising2D.NecSuf

/-- **`x < y ⟹ −y < −x`**（具体版 `real_neg_lt_neg_of_lt`）。 -/
theorem neg_lt_neg_of_lt' {G : Type*} [Ring G] [PartialOrder G] [AddLeftStrictMono G]
    [PosMulStrictMono G] [ZeroLEOneClass G] [NeZero (1 : G)]
    {x y : G} (h : x < y) : -y < -x := by
  have h1 : (-1) * y < (-1) * x := mul_lt_mul_of_neg_left h (neg_lt_zero.mpr one_pos)
                                                        -- 両辺に `−1 < 0` を掛けると不等号の向きが反転する
  rwa [neg_one_mul, neg_one_mul] at h1

/-- **奇部の狭義単調性**（具体版 `sinh_strictly_increasing`）。具体版と同じ段の並び。 -/
theorem oddPart_strictly_increasing' {G R : Type*} [Ring G] [PartialOrder G] [AddLeftStrictMono G]
    [PosMulStrictMono G] [ZeroLEOneClass G] [NeZero (1 : G)]
    [Ring R] [PartialOrder R] [AddLeftStrictMono R] [PosMulStrictMono R]
    (e s : G → R) (k : R) (hk : 0 < k) (hmono : ∀ a b, a < b → e a < e b)
    (hs : ∀ x, s x = (e x - e (-x)) * k) {x y : G} (h : x < y) : s x < s y := by
  -- 準備の 1 本目の鎖
  have hE : e x < e y := hmono x y h                    -- `e` の狭義単調性
  -- 準備の 2 本目の鎖
  have hN : -y < -x := neg_lt_neg_of_lt' h              -- 両辺に `−1 < 0` を掛ける
  have hEN : e (-y) < e (-x) := hmono (-y) (-x) hN      -- `e` の狭義単調性
  -- 3 本の含意
  have h1 : e y - e x > 0 := by
    have h' : e x + -e x < e y + -e x := add_lt_add_left hE (-e x)
                                                        -- 両辺に `−e(x)` を加える
    rwa [add_neg_cancel, ← sub_eq_add_neg] at h'
  have h2 : e (-x) - e (-y) > 0 := by
    have h' : e (-y) + -e (-y) < e (-x) + -e (-y) := add_lt_add_left hEN (-e (-y))
                                                        -- 両辺に `−e(−y)` を加える
    rwa [add_neg_cancel, ← sub_eq_add_neg] at h'
  have h3 : (e y - e x) + (e (-x) - e (-y)) > 0 := add_pos h1 h2
                                                        -- 正の元の和は正
  -- `s(y) − s(x)` の鎖
  have hd : s y - s x > 0 :=
    calc s y - s x
        = (e y - e (-y)) * k - (e x - e (-x)) * k := by rw [hs y, hs x]
                                                        -- 定義を 2 箇所へ
      _ = ((e y - e (-y)) - (e x - e (-x))) * k := (sub_mul _ _ _).symm
                                                        -- 分母の等しい分数の差（右分配法則）
      _ = ((e y - e x) + (e (-x) - e (-y))) * k := by congr 1; abel
                                                        -- 分子の項の並べ替え
      _ > 0 := mul_pos h3 hk                            -- 正の元に正の `k` を掛けると正
  -- 最後の含意
  have h4 : 0 + s x < (s y - s x) + s x := add_lt_add_left hd (s x)
                                                        -- 両辺に `s(x)` を加える
  rwa [zero_add, sub_add_cancel] at h4

end Ising2D.NecSuf
