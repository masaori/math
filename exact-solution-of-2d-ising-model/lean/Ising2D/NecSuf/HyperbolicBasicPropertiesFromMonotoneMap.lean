/-
# 写像の偶部と奇部の基本性質（**必要十分版**）

対応する人手証明のラベル: `cosh_sinh_basic_properties` (1)・(3)（`structured-latex/content/003_exp_linear_map.ts`）。
具体版は `Ising2D/MathematicalTools/RealSquareRootExponentialAndHyperbolicFunctions/ClaimCoshSinhBasicProperties.lean`、
具体版をこのファイルの系として導くのは同じフォルダの `ClaimCoshSinhBasicPropertiesFromNecSuf.lean`。

写像 `e : G → R` から `c(x) := (e(x) + e(−x))·⅟2`、`s(x) := (e(x) − e(−x))·⅟2` を作る（具体版は `e := exp`、`c := cosh`、
`s := sinh`、`⅟2` は `2` の逆元で、具体版の `/2` に当たる）。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `cosh_sub_sinh_eq_exp_neg`（定義 → 分母の等しい分数の差 → 分子の整理 → 約分） | `evenPart_sub_oddPart'`（同じ 4 段） |
| `cosh_add_sinh_eq_exp`（定義 → 分母の等しい分数の和 → 分子の整理 → 約分） | `evenPart_add_oddPart'`（同じ 4 段） |
| `cosh_sub_sinh_pos`（第 1 式 → `exp` の正値性） | `evenPart_sub_oddPart_pos'`（第 1 式 → `e` の正値性） |
| `real_cosh_gt_sinh`（両辺に `sinh x` を加える） | `oddPart_lt_evenPart'`（両辺に `s(x)` を加える） |
| `two_cosh_pos`（右辺の整理 → 上の 2 式 → `exp` の正値性） | `two_mul_evenPart_pos'`（同じ 3 段） |
| `cosh_pos_of_two_cosh_pos`（両辺を `2 > 0` で割る） | `evenPart_pos'` |
| `cosh_sinh_basic_properties_1`（(1) 全体） | `evenPart_oddPart_properties'` |
| `real_neg_lt_zero_of_pos`（両辺に `−1 < 0` を掛ける） | `neg_lt_zero_of_pos'` |
| `real_exp_neg_lt_one`・`real_one_lt_exp`（`exp` の狭義単調性 → `exp(0) = 1`） | `map_neg_lt_map_zero'`・`map_zero_lt_map'`（`e` の狭義単調性。`= 1` の段は無い） |
| `real_exp_sub_exp_neg_pos`（推移律 → 両辺に `−exp(−x)` を加える） | `map_sub_map_neg_pos'`（推移律 → 両辺に `−e(−x)` を加える） |
| `real_sinh_pos_of_pos`（定義 → 正の実数を `2 > 0` で割った値は正） | `oddPart_pos'`（定義 → 正の元に正の `⅟2` を掛けた値は正。`⅟2 > 0` は `invOf_two_pos'`） |
| `cosh_sinh_basic_properties_3`（(1) と直前の不等式） | `evenPart_gt_oddPart_pos'` |

## 何が効いているか / 効いていないか

- (1) の 2 つの等式で値域について効くのは、環の演算（分配法則 `ac ± bc = (a ± b)c`、加法の可換則と `2b = b + b = b·2`）と、
  `2` が逆元 `⅟2` を持つこと（約分 `(b·2)·⅟2 = b`）だけである（`[Ring R] [Invertible (2 : R)]`）。2 以外の元の逆元（体・除法環であること）と
  乗法の可換則は効いていない。`2` の可逆性は外すと通らない: `ZMod 2` で `e ≡ 1` とすると、`2 = 0` なので `c − s = 0` だが `e(−x) = 1`。
  写像 `e` には何も仮定しない。定義域は符号反転 `−x` を持つことだけを使う（`Neg G`）。
- (1) の不等号で効くのは、`e` の値が正であること（`hpos`）、値域の加法と順序の両立（両辺に `s(x)` を加える）、`2 > 0` と
  `2c > 0 ⟹ c > 0` である。値域は全順序環 `[Ring R] [LinearOrder R] [IsStrictOrderedRing R]` に `Invertible 2` を足した。
  全順序は外すと通らない: `2c > 0 ⟹ c > 0`（`mul_pos_iff_of_pos_left`）と `⅟2 > 0`（`invOf_two_pos'` の背理法 `⅟2 ≤ 0` でないなら `⅟2 > 0`）は、
  比べられない元があると使えない（`PartialOrder` では通らないことを確かめた）。
- (3) で効くのは、定義域の `x > 0 ⟹ −x < 0`（`−1 < 0` を掛ける。定義域は全順序環）、`e` が狭義単調であること（`hmono`）、
  値域の推移律と、加法と順序の両立（`map_sub_map_neg_pos'` は値域が順序つきの加法群であることだけを使う）と、正の元に正の `⅟2` を
  掛けた値が正であることである。`e` の正値性は (3) の `s(x) > 0` には効かない（(3) の `c(x) > s(x)` は (1) の結論なので効く）。
- 効いていないもの: `exp(0) = 1`（具体版の `exp(−x) < exp(0) = 1 < exp(x)` の `= 1` は、推移律が `e(0)` を経由するだけで足りる）、
  `e(a + b) = e(a)e(b)`、`e` が級数で定義されていること、連続性・極限・完備性、値域・定義域が ℝ であること、乗法の可換則、2 以外の元の逆元。
-/
import Mathlib.Algebra.Order.Ring.Defs
import Mathlib.Algebra.Ring.Invertible
import Mathlib.Tactic.Abel
import Mathlib.Tactic.NormNum

namespace Ising2D.NecSuf

section Equalities

variable {G R : Type*} [Neg G] [Ring R] [Invertible (2 : R)]

/-- **`c(x) − s(x) = e(−x)`**（具体版 `cosh_sub_sinh_eq_exp_neg`）。 -/
theorem evenPart_sub_oddPart' (e c s : G → R)
    (hc : ∀ x, c x = (e x + e (-x)) * ⅟2) (hs : ∀ x, s x = (e x - e (-x)) * ⅟2) (x : G) :
    c x - s x = e (-x) :=
  calc c x - s x
      = (e x + e (-x)) * ⅟2 - (e x - e (-x)) * ⅟2 := by rw [hc, hs]   -- 定義
    _ = ((e x + e (-x)) - (e x - e (-x))) * ⅟2 := (sub_mul _ _ _).symm  -- 分母の等しい分数の差
    _ = (2 * e (-x)) * ⅟2 := by congr 1; rw [two_mul]; abel           -- 分子の整理
    _ = e (-x) := by rw [two_mul, ← mul_two]; exact mul_invOf_cancel_right _ _
                                                                     -- 約分（`2b = b + b = b·2` なので乗法の可換則は使わない）

/-- **`c(x) + s(x) = e(x)`**（具体版 `cosh_add_sinh_eq_exp`）。 -/
theorem evenPart_add_oddPart' (e c s : G → R)
    (hc : ∀ x, c x = (e x + e (-x)) * ⅟2) (hs : ∀ x, s x = (e x - e (-x)) * ⅟2) (x : G) :
    c x + s x = e x :=
  calc c x + s x
      = (e x + e (-x)) * ⅟2 + (e x - e (-x)) * ⅟2 := by rw [hc, hs]   -- 定義
    _ = ((e x + e (-x)) + (e x - e (-x))) * ⅟2 := (add_mul _ _ _).symm  -- 分母の等しい分数の和
    _ = (2 * e x) * ⅟2 := by congr 1; rw [two_mul]; abel               -- 分子の整理
    _ = e x := by rw [two_mul, ← mul_two]; exact mul_invOf_cancel_right _ _
                                                                     -- 約分

end Equalities

section FirstInequalities

variable {G R : Type*} [Neg G] [Ring R] [LinearOrder R] [IsStrictOrderedRing R] [Invertible (2 : R)]

omit [IsStrictOrderedRing R] in
/-- **`c(x) − s(x) = e(−x) > 0`**（具体版 `cosh_sub_sinh_pos`）。 -/
theorem evenPart_sub_oddPart_pos' (e c s : G → R) (hpos : ∀ y, 0 < e y)
    (hc : ∀ x, c x = (e x + e (-x)) * ⅟2) (hs : ∀ x, s x = (e x - e (-x)) * ⅟2) (x : G) :
    c x - s x > 0 :=
  calc c x - s x
      = e (-x) := evenPart_sub_oddPart' e c s hc hs x               -- 上の第 1 式
    _ > 0 := hpos (-x)                                              -- `e` の正値性

/-- **`c(x) − s(x) > 0 ⟹ c(x) > s(x)`**（具体版 `real_cosh_gt_sinh`）。 -/
theorem oddPart_lt_evenPart' (e c s : G → R) (hpos : ∀ y, 0 < e y)
    (hc : ∀ x, c x = (e x + e (-x)) * ⅟2) (hs : ∀ x, s x = (e x - e (-x)) * ⅟2) (x : G) :
    c x > s x := by
  have h : 0 + s x < (c x - s x) + s x :=
    add_lt_add_left (evenPart_sub_oddPart_pos' e c s hpos hc hs x) (s x)  -- 両辺に `s(x)` を加える
  rwa [zero_add, sub_add_cancel] at h

/-- **`2c(x) = (c(x) − s(x)) + (c(x) + s(x)) = e(−x) + e(x) > 0`**（具体版 `two_cosh_pos`）。 -/
theorem two_mul_evenPart_pos' (e c s : G → R) (hpos : ∀ y, 0 < e y)
    (hc : ∀ x, c x = (e x + e (-x)) * ⅟2) (hs : ∀ x, s x = (e x - e (-x)) * ⅟2) (x : G) :
    2 * c x > 0 :=
  calc 2 * c x
      = (c x - s x) + (c x + s x) := by rw [two_mul]; abel          -- 右辺の整理
    _ = e (-x) + e x := by
        rw [evenPart_sub_oddPart' e c s hc hs, evenPart_add_oddPart' e c s hc hs]
                                                                     -- 上の 2 式
    _ > 0 := add_pos (hpos (-x)) (hpos x)                           -- `e` の正値性

/-- **`2c(x) > 0 ⟹ c(x) > 0`**（具体版 `cosh_pos_of_two_cosh_pos`）。 -/
theorem evenPart_pos' (e c s : G → R) (hpos : ∀ y, 0 < e y)
    (hc : ∀ x, c x = (e x + e (-x)) * ⅟2) (hs : ∀ x, s x = (e x - e (-x)) * ⅟2) (x : G) :
    c x > 0 :=
  (mul_pos_iff_of_pos_left two_pos).mp (two_mul_evenPart_pos' e c s hpos hc hs x)
                                                                     -- 両辺を `2 > 0` で割る

/-- **(1) 全体**（具体版 `cosh_sinh_basic_properties_1`）。 -/
theorem evenPart_oddPart_properties' (e c s : G → R) (hpos : ∀ y, 0 < e y)
    (hc : ∀ x, c x = (e x + e (-x)) * ⅟2) (hs : ∀ x, s x = (e x - e (-x)) * ⅟2) (x : G) :
    (c x - s x = e (-x) ∧ e (-x) > 0) ∧ (c x + s x = e x ∧ e x > 0) ∧ c x > 0 ∧ c x > s x :=
  ⟨⟨evenPart_sub_oddPart' e c s hc hs x, hpos (-x)⟩, ⟨evenPart_add_oddPart' e c s hc hs x, hpos x⟩,
    evenPart_pos' e c s hpos hc hs x, oddPart_lt_evenPart' e c s hpos hc hs x⟩

end FirstInequalities

/-- **`x > 0 ⟹ −x < 0`**（具体版 `real_neg_lt_zero_of_pos`）。 -/
theorem neg_lt_zero_of_pos' {G : Type*} [Ring G] [LinearOrder G] [IsStrictOrderedRing G]
    {x : G} (hx : x > 0) : -x < 0 := by
  have h : (-1) * x < (-1) * 0 := mul_lt_mul_of_neg_left hx (by norm_num)
                                                                     -- 両辺に `−1 < 0` を掛けると不等号の向きが反転する
  rwa [neg_one_mul, mul_zero] at h

/-- **`e(−x) < e(0)`**（具体版 `real_exp_neg_lt_one`。`e(0) = 1` の段は無い）。 -/
theorem map_neg_lt_map_zero' {G R : Type*} [Ring G] [LinearOrder G] [IsStrictOrderedRing G] [LT R]
    (e : G → R) (hmono : ∀ a b, a < b → e a < e b) {x : G} (hx : x > 0) : e (-x) < e 0 :=
  hmono _ _ (neg_lt_zero_of_pos' hx)                                -- `−x < 0` と `e` の狭義単調性

/-- **`e(0) < e(x)`**（具体版 `real_one_lt_exp`。`e(0) = 1` の段は無い）。 -/
theorem map_zero_lt_map' {G R : Type*} [Zero G] [LT G] [LT R]
    (e : G → R) (hmono : ∀ a b, a < b → e a < e b) {x : G} (hx : x > 0) : e 0 < e x :=
  have h0x : 0 < x := hx                                            -- 同じ不等式の左右を入れ替える
  hmono _ _ h0x                                                     -- `0 < x` と `e` の狭義単調性

/-- **`e(−x) < e(0) < e(x) ⟹ e(−x) < e(x) ⟹ e(x) − e(−x) > 0`**（具体版 `real_exp_sub_exp_neg_pos`）。
値域は順序と加法が両立する加法群であることだけを使う。 -/
theorem map_sub_map_neg_pos' {G R : Type*} [Ring G] [LinearOrder G] [IsStrictOrderedRing G]
    [AddGroup R] [Preorder R] [AddRightStrictMono R]
    (e : G → R) (hmono : ∀ a b, a < b → e a < e b) {x : G} (hx : x > 0) : e x - e (-x) > 0 := by
  have h1 : e (-x) < e x := lt_trans (map_neg_lt_map_zero' e hmono hx) (map_zero_lt_map' e hmono hx)
                                                                     -- 順序の推移律
  have h2 : e (-x) + -e (-x) < e x + -e (-x) := add_lt_add_left h1 (-e (-x))
                                                                     -- 両辺に `−e(−x)` を加える
  rwa [add_neg_cancel, ← sub_eq_add_neg] at h2

section SecondInequalities

variable {G R : Type*} [Ring G] [LinearOrder G] [IsStrictOrderedRing G]
  [Ring R] [LinearOrder R] [IsStrictOrderedRing R] [Invertible (2 : R)]

omit [Ring G] [LinearOrder G] [IsStrictOrderedRing G] in
/-- `⅟2 > 0`。`⅟2 ≤ 0` なら `1 = 2·⅟2 ≤ 0` となり `1 > 0` に反する（具体版では「`2 > 0` で割る」の中にある）。 -/
theorem invOf_two_pos' : (0 : R) < ⅟2 := by
  by_contra h
  have h1 : 2 * (⅟2 : R) ≤ 0 := mul_nonpos_of_nonneg_of_nonpos zero_le_two (not_lt.mp h)
  rw [mul_invOf_self] at h1
  exact absurd h1 (not_le.mpr one_pos)

/-- **`s(x) = (e(x) − e(−x))·⅟2 > 0`**（具体版 `real_sinh_pos_of_pos`）。 -/
theorem oddPart_pos' (e s : G → R) (hmono : ∀ a b, a < b → e a < e b)
    (hs : ∀ x, s x = (e x - e (-x)) * ⅟2) {x : G} (hx : x > 0) : s x > 0 :=
  calc s x
      = (e x - e (-x)) * ⅟2 := hs x                                  -- 定義
    _ > 0 := mul_pos (map_sub_map_neg_pos' e hmono hx) invOf_two_pos' -- 正の元に正の `⅟2` を掛けた値は正

/-- **`x > 0 ⟹ c(x) > s(x) > 0`**（具体版 `cosh_sinh_basic_properties_3`）。`c(x) > s(x)` は (1) の結論なので
`e` の正値性 `hpos` が効く。`s(x) > 0` には `hpos` は効かない。 -/
theorem evenPart_gt_oddPart_pos' (e c s : G → R) (hpos : ∀ y, 0 < e y) (hmono : ∀ a b, a < b → e a < e b)
    (hc : ∀ x, c x = (e x + e (-x)) * ⅟2) (hs : ∀ x, s x = (e x - e (-x)) * ⅟2) {x : G} (hx : x > 0) :
    c x > s x ∧ s x > 0 :=
  ⟨oddPart_lt_evenPart' e c s hpos hc hs x, oddPart_pos' e s hmono hs hx⟩  -- (1) と直前の不等式

end SecondInequalities

end Ising2D.NecSuf
