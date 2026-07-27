# 章 020「臨界点と比熱の対数発散」の Lean 形式化で人手証明について判明したこと

対象: `structured-latex/content/020_critical_point.ts`
形式化: `lean/Ising2D/Part020/`, `lean/Ising2D/Abstract/{HyperbolicBounds,MeanValueTwoSided,LogDivergentIntegral,DiffUnderIntegral}.lean`
記録日: 2026-07-27

**`structured-latex/` の本文は一切変更していない。** 以下は一次情報（Lean のビルド結果と原文の該当箇所）
つきの記録である。

## 0. 結論

**人手証明に数学的な誤りは見つからなかった。** 形式化した 11 ブロック
（`cosh_addition_and_half_angle` 〜 `second_derivative_log_divergence`）はすべて
`sorry` なしで Lean 上に再現できた。以下は「誤り」ではなく、
(a) 原文が外から持ち込むと宣言している数値評価の扱い、
(b) 評価の緩さ、
(c) 形式化で明示が必要になった暗黙のステップ、の 3 種類の記録である。

## 1. 原文が外から持ち込んでいる初等関数の数値評価（宣言済み・誤りではない）

原文 `critical_000_remark_escape_to_real_analysis_chapter_E` の末尾で宣言されているとおり、
証明中には `cosh 0.2 ≤ 1.02007`、`\sinh\tfrac14 \leq 0.2527`、`\cosh(\kappa/2) \leq 1.0315`、
`√2` の数値など、初等関数の具体的な数値評価が導出なしで現れる（`critical_006`, `critical_011`）。

形式化ではこれらを**一切持ち込まず**、`Ising2D.Abstract.cosh_le_inv_one_sub_sq_div_two`
（`cosh t ≤ (1-t²/2)⁻¹`、mathlib の `Real.cosh_le_exp_half_sq` から導出）と
`Ising2D.Abstract.one_add_sq_div_two_le_cosh`、`Real.pi_gt_d6` / `Real.pi_lt_d6` だけから
すべて導いた。そのぶん途中の定数がわずかに悪くなる（原文 → 形式化）:

| 量 | 原文 | 形式化 | 原文の該当箇所 |
| --- | --- | --- | --- |
| `sinh 2K` の下界 | `0.7353` | `0.7313` | `critical_006` (4) |
| `sinh 2K` の上界 | `1.3048` | `1.3091` | `critical_006` (4) |
| `κ'` の範囲 | `[3.53, 4.72]` | `[3.52, 4.74]` | `critical_006` (4) |
| `\|κ''\|` の上界 | `9.19` | `9.3` | `critical_006` (4) |
| `\|(κ'²)'\|` の上界 | `87` | `88.2` | `critical_006` (6) |
| `\|κ'²-16\|/\|κ\|` | `24.7` | `25.1` | `critical_006` (6) |
| `T` の上界 | `3.614` | `3.7` | `critical_011` Step 5 |
| `\|2πG'' - log(1/κ)\|` | `7.233` | `6.9` | `critical_011` Step 7 |

**結論の定数 `6/5` は原文のまま成立する。** 形式化の評価では `6.9/(2π) ≤ 1.10 ≤ 6/5`
（原文は `7.233/(2π) ≤ 1.16 ≤ 6/5`）。形式化のほうが総合値が小さいのは、
Step 4 の緩さ（次項）を使っていないためである。

### 1.1 定数の余裕がほぼ無い箇所（形式化上の注意）

原文 Step 5 の `T ≤ 2cosh²(κ/2)/c_0 ≤ 2·1.0315²/0.5887 ≤ 3.614` は
`cosh(κ/2) ≤ 1.0315`（`cosh(1/4) = 1.031413…`）を使っており、原文の範囲では正しい。
一方、形式化が使う `cosh(κ/2) ≤ 32/31 = 1.032258…` では
`2·(32/31)²/0.5887 = 3.61996…` となり、**`3.62` という上界は成り立たない**
（`2·(32/31)² = 2048/961 = 2.1311134…` に対し `3.62·0.5887 = 2.1310940…` で、
わずかに左辺のほうが大きい。この 2 桁目以下の差で `nlinarith` が失敗した）。
形式化では `T ≤ 3.7` に緩めて `Ising2D.Tint_le` から結論した。
**これは原文の誤りではなく、外部数値評価を排したことによる代償である。**

## 2. 原文 Step 4（`critical_011`）の評価が不必要に緩い

原文 Step 4 は残差 `R` について

* `0 ≤ R_0 ≤ 2δ²/π² + B`（上界側）
* `0 ≤ I - J ≤ (π/2)cosh(κ/2)`（下界側）

を別々に出したうえで、両者を**足して** `|R| ≤ 2δ²/π² + B + (π/2)cosh(κ/2)` としている
（原文 1774 行付近）。しかし `R` の上界と下界は別々の項から来るので、実際には

  `-(π/2)cosh(κ/2) ≤ R ≤ 2δ²/π² + B`

であり、和を取る必要がない。形式化ではこちらを使った
（`Ising2D.second_derivative_log_divergence_pos` 内の `hJub` / `hJlb` / `hJabs`）。
その結果 `|R| ≤ 1.622`（原文は `2.514`）となり、外部数値を排して定数が悪化しているにもかかわらず
総合値は原文より小さくなっている（`6.9 < 7.233`）。

**誤りではない**（原文の不等式は成り立つ）。定数を最適化していないという原文自身の断り書き
（`critical_011` の末尾ノート）の範囲内である。

## 3. 形式化で明示が必要になった暗黙のステップ

### 3.1 Step 0 の「`G` が偶関数 ⇒ `G''` が偶関数」

原文 Step 0 は `G(-κ) = G(κ)` から「したがって `G''(-κ) = G''(κ)`」と一行で進む
（原文 1646-1652 行付近）。これは正しいが、偶関数の 2 階導関数が偶関数であることを
`G''` の存在込みで使っている。形式化では**この経路を取らず**、
`Ising2D.Gsecond` の積分表示に対して被積分関数が `κ ↦ -κ` で不変であること
（`Ising2D.Sfun_neg` → `Ising2D.d2gammaK_neg` → `Ising2D.Gsecond_neg`）から直接示した。
そのほうが (R5) の適用範囲（`κ ≠ 0`）を気にせずに済む。

**誤りではない。** 原文の書き方でも通るが、形式化では別経路のほうが短い。

### 3.2 (R5)（積分記号下の微分）が mathlib にそのままの形で無い

原文が新たに持ち込む (R3)〜(R6) のうち、**(R5) だけが mathlib に
「有界閉長方形上の連続性だけを仮定した形」で存在しない**（調査結果）。
mathlib が持つのは優関数を明示的に与える形
`intervalIntegral.hasDerivAt_integral_of_dominated_loc_of_deriv_le` である。
コンパクト集合上の連続関数の有界性から優関数を定数に取れば導けるので、
その導出を `lean/Ising2D/Abstract/DiffUnderIntegral.lean` に置いた。

探して存在しなかった名前: `intervalIntegral.hasDerivAt_integral_of_continuousOn`,
`intervalIntegral.deriv_integral`, `hasDerivAt_integral_of_continuous`。

**原文の不備ではない。** 形式化側の作業量に関する記録である。

### 3.3 `K_2^*` の双対関係が既存の `IsingParam` に無い

原文 `def_transfer_matrix_symbols` は `K_2^*` を `sinh 2K_2 sinh 2K_2^* = 1` で定めるが、
既存の Lean 側の `Ising2D.IsingParam` は `K_1, K_2, K_2^*` の正値性しか持たない。
そのため `critical_point_iff_kappa_zero` と `isotropic_A_equals_one` の形式化では
`Ising2D.KStar`（`K^* := arsinh(1/sinh 2K)/2`）を導入し、`K_2^* = KStar K_2` を
**明示的な仮定として書いた**（`lean/Ising2D/Part020/Definition002_KappaAndCritical.lean`）。
これは原文の定義そのものであり、原文が仮定を落としているわけではない。

## 4. 未形式化として残した主張

| ラベル | 理由 |
| --- | --- |
| `specific_heat_log_divergence`（`critical_012`） | 原理的な障害ではなく**依存関係の欠落**。`f(K) = log 2 + G(κ(K))` を `K` について 2 回微分する形なので、章 012 の `onsager_free_energy_expression`（`f` を `M,N → ∞` の極限として与えている）と本章の `Ising2D.Gfun ∘ Ising2D.kappaK` が同一の対象であることを結ぶ橋渡し補題が要る。それが未形式化。部品（`Gsecond_ge`, `abs_Gfirst_le`, `kappaDeriv_bounds`, `abs_kappaSecond_le`, `abs_kappaDerivSq_sub_le`）は本章ですべて揃っている。 |
| `remark_physical_specific_heat`（`critical_013`） | 数学的主張ではなく物理量との辞書。形式化の対象外。 |
| `remark_real_analysis_escape_chapter_E`（`critical_000`） | (R3)〜(R6) の宣言というメタな注記。定理ではないので形式化の対象外だが、全項目の mathlib 対応は `lean/docs/ch020-formalization.md` §0 に表として記録した。 |

## 5. 次にやること

`specific_heat_log_divergence` を形式化するには、先に
**章 012 の `f` と本章の `G ∘ κ` を結ぶ橋渡し**を形式化する必要がある。
これは章 020 の内部作業ではなく章 012 との接続作業なので、別タスクとして立てる。
